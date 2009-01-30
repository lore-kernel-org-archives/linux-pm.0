From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Thu, 29 Jan 2009 22:04:32 -0800
Message-ID: <d6200be20901292204i207f5c89u37825ea8dd6bd843@mail.gmail.com>
References: <d6200be20901291716g5b6f4542r54c2ba8672961c91@mail.gmail.com>
	<Pine.LNX.4.44L0.0901292203470.4063-100000@netrider.rowland.org>
	<d6200be20901292040l5f540cf5ybbda03db9627c477@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20901292040l5f540cf5ybbda03db9627c477@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: swetland@google.com, Nigel Cunningham <ncunningham@crca.org.au>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Documentation/power/wakelocks.txt (version 3)
Wakelocks
=3D=3D=3D=3D=3D=3D=3D=3D=3D

A locked wakelock, depending on its type, prevents the system from entering
suspend or other low-power states. When creating a wakelock, you can select
if it prevents suspend or low-power idle states.  If the type is set to
WAKE_LOCK_SUSPEND, the wakelock prevents a full system suspend. If the type
is WAKE_LOCK_IDLE, low-power states that cause large interrupt latencies, or
that disable a set of interrupts, will not be entered from idle until the
wakelocks are released. Unless the type is specified, this document refers
to wakelocks with the type set to WAKE_LOCK_SUSPEND.

If the suspend operation has already started when locking a wakelock, it wi=
ll
abort the suspend operation as long it has not already reached the suspend_=
late
stage. This means that locking a wakelock from an interrupt handler or a
freezeable thread always works, but if you lock a wakelock from a suspend_l=
ate
handler you must also return an error from that handler to abort suspend.

Wakelocks can be used to allow user-space to decide which keys should wake =
the
full system up and turn the screen on. Use set_irq_wake or a platform speci=
fic
api to make sure the keypad interrupt wakes up the cpu. Once the keypad dri=
ver
has resumed, the sequence of events can look like this:
- The Keypad driver gets an interrupt. It then locks the keypad-scan wakelo=
ck
  and starts scanning the keypad matrix.
- The keypad-scan code detects a key change and reports it to the input-eve=
nt
  driver.
- The input-event driver sees the key change, enqueues an event, and locks
  the input-event-queue wakelock.
- The keypad-scan code detects that no keys are held and unlocks the
  keypad-scan wakelock.
- The user-space input-event thread returns from select/poll, locks the
  process-input-events wakelock and then calls read in the input-event devi=
ce.
- The input-event driver dequeues the key-event and, since the queue is now
  empty, it unlocks the input-event-queue wakelock.
- The user-space input-event thread returns from read. It determines that t=
he
  key should not wake up the full system, releases the process-input-events
  wakelock and calls select or poll.

                 Key pressed   Key released
                     |             |
keypad-scan          ++++++++++++++++++
input-event-queue        +++          +++
process-input-events       +++          +++


Driver API
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

A driver can use the wakelock api by adding a wakelock variable to its state
and calling wake_lock_init. For instance:
struct state {
        struct wakelock wakelock;
}

init() {
        wake_lock_init(&state->wakelock, WAKE_LOCK_SUSPEND, "wakelockname");
}

Before freeing the memory, wake_lock_destroy must be called:

uninit() {
        wake_lock_destroy(&state->wakelock);
}

When the driver determines that it needs to run (usually in an interrupt
handler) it calls wake_lock:
        wake_lock(&state->wakelock);

When it no longer needs to run it calls wake_unlock:
        wake_unlock(&state->wakelock);

It can also call wake_lock_timeout to release the wakelock after a delay:
        wake_lock_timeout(&state->wakelock, HZ);

This works whether the wakelock is already held or not. It is useful if the
driver woke up other parts of the system that do not use wakelocks but
still need to run. Avoid this when possible, since it will waste power
if the timeout is long or may fail to finish needed work if the timeout is
short.


User-space API
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Write "lockname" or "lockname timeout" to /sys/power/wake_lock lock and if
needed create a wakelock. The timeout here is specified nanoseconds.
Write "lockname" to /sys/power/wake_unlock to unlock a user wakelock.

Do not use randomly generated wakelock names as there is no api to free
a user-space wakelock.



-- =

Arve Hj=F8nnev=E5g
