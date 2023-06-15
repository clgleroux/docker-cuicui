from django.shortcuts import render

# board/views.py

from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt
from django.core.cache import cache
from .models import Message


def home(request):
    last_message = cache.get('last_message')

    if last_message is None:
        last_message_content = 'Aucun message pour le moment'
    else:
        last_message_content = last_message.content

    return render(request, 'board/home.html', {'last_message': last_message_content})


def thread(request):
    messages = Message.objects.all()
    return render(request, 'board/thread.html', {'messages': messages})


@csrf_exempt
def post_message(request):
    name = request.POST.get('name', 'Anonymous')
    content = request.POST.get('content', '')
    message = Message.objects.create(name=name, content=content)
    cache.set('last_message', message, timeout=None)
    return render(request, 'board/posted.html')
