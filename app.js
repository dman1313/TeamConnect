// Navigation Logic
const navLinks = document.querySelectorAll('.nav-links li');
const views = document.querySelectorAll('.view');

navLinks.forEach(link => {
    link.addEventListener('click', () => {
        // Remove active class from all links
        navLinks.forEach(l => l.classList.remove('active'));
        // Add active class to clicked link
        link.classList.add('active');
        
        // Hide all views
        views.forEach(view => view.classList.remove('active-view'));
        
        // Show target view
        const targetId = link.getAttribute('data-target');
        document.getElementById(targetId).classList.add('active-view');
    });
});

// Action Triage Logic
function handleComplete(cardId) {
    const card = document.getElementById(cardId);
    card.style.transform = 'translateX(100%)';
    card.style.opacity = '0';
    
    setTimeout(() => {
        card.innerHTML = `
            <div style="text-align: center; color: var(--success); padding: 1rem;">
                <h3 style="margin-bottom: 0.5rem">Great Job!</h3>
                <p>+1 Token Earned</p>
            </div>
        `;
        card.style.transform = 'translateX(0)';
        card.style.opacity = '1';
        card.style.background = 'rgba(34, 197, 94, 0.1)';
        card.style.borderColor = 'var(--success)';
        
        // Update token UI
        const tokenDisplay = document.querySelector('.tokens');
        tokenDisplay.innerText = '16 Tokens';
    }, 300);
}

function handleStruggle(cardId) {
    const card = document.getElementById(cardId);
    card.style.transform = 'translateX(-100%)';
    card.style.opacity = '0';
    
    setTimeout(() => {
        card.innerHTML = `
            <div style="text-align: center;">
                <h3 style="margin-bottom: 0.5rem; color: var(--warning)">Empathy Loop Activated</h3>
                <p style="color: var(--muted); margin-bottom: 1rem; font-size: 0.9rem;">It's okay to struggle. Let's try a simpler version of this task to maintain momentum.</p>
                <button class="btn-accept" style="width: 100%" onclick="acceptRecovery()">Accept (+2 Recovery Tokens)</button>
            </div>
        `;
        card.style.transform = 'translateX(0)';
        card.style.opacity = '1';
    }, 300);
}

function acceptRecovery() {
    const tokenDisplay = document.querySelector('.tokens');
    tokenDisplay.innerText = '18 Tokens';
    alert("Recovery action accepted. Keep going!");
}

// Chat Interface Logic
const chatHistory = document.getElementById('chat-history');
const chatInput = document.getElementById('chat-input');
const sendBtn = document.getElementById('send-btn');
const voiceBtn = document.getElementById('voice-btn');

function appendMessage(text, sender) {
    const msgDiv = document.createElement('div');
    msgDiv.className = `message ${sender}`;
    
    const avatar = document.createElement('div');
    avatar.className = `avatar ${sender}-avatar`;
    avatar.innerText = sender === 'user' ? 'D' : 'AI';
    
    const bubble = document.createElement('div');
    bubble.className = 'bubble';
    bubble.innerText = text;
    
    if(sender === 'user') {
        msgDiv.appendChild(bubble);
        msgDiv.appendChild(avatar);
    } else {
        msgDiv.appendChild(avatar);
        msgDiv.appendChild(bubble);
    }
    
    chatHistory.appendChild(msgDiv);
    chatHistory.scrollTop = chatHistory.scrollHeight;
}

// Simulate Cognitive Coach Response
function triggerCoachResponse(userText) {
    setTimeout(() => {
        appendMessage(`So, you are saying: "${userText}". Tell me more about what success looks like for that?`, 'agent');
    }, 1000);
}

sendBtn.addEventListener('click', () => {
    const text = chatInput.value.trim();
    if (text) {
        appendMessage(text, 'user');
        chatInput.value = '';
        triggerCoachResponse(text);
    }
});

chatInput.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') {
        sendBtn.click();
    }
});

// Web Speech API (Voice Dictation)
const SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;

if (SpeechRecognition) {
    const recognition = new SpeechRecognition();
    recognition.continuous = false;
    recognition.interimResults = false;

    recognition.onstart = function() {
        voiceBtn.classList.add('recording');
    };

    recognition.onresult = function(event) {
        const transcript = event.results[0][0].transcript;
        chatInput.value = transcript;
    };

    recognition.onerror = function(event) {
        console.error("Speech recognition error", event.error);
        voiceBtn.classList.remove('recording');
    };

    recognition.onend = function() {
        voiceBtn.classList.remove('recording');
    };

    voiceBtn.addEventListener('click', () => {
        if (voiceBtn.classList.contains('recording')) {
            recognition.stop();
        } else {
            recognition.start();
        }
    });
} else {
    voiceBtn.style.display = 'none'; // Hide if not supported
    console.warn("Speech Recognition API not supported in this browser.");
}
