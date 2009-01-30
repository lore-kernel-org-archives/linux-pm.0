From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Thu, 29 Jan 2009 20:40:16 -0800
Message-ID: <d6200be20901292040l5f540cf5ybbda03db9627c477@mail.gmail.com>
References: <d6200be20901291716g5b6f4542r54c2ba8672961c91@mail.gmail.com>
	<Pine.LNX.4.44L0.0901292203470.4063-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0901292203470.4063-100000@netrider.rowland.org>
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

On Thu, Jan 29, 2009 at 7:27 PM, Alan Stern <stern@rowland.harvard.edu> wro=
te:
> On Thu, 29 Jan 2009, Arve Hj=F8nnev=E5g wrote:
>> A wakelock prevents the system from entering suspend or other low-power
>> states when active.
>
> I wish your writing was clearer.  "when active" could mean "when the
> system is active" or "when the wakelock is active".  Try to be less
> ambiguous.  For example: "When a wakelock is locked, it blocks the
> system from entering suspend or other low-power states."

OK.

>> If the type is set to WAKE_LOCK_SUSPEND, the wakelock
>> prevents a full system suspend. If the type is WAKE_LOCK_IDLE, low-power
>> states that cause large interrupt latencies or that disable a set of
>> interrupts will not be entered from idle until the wakelocks are release=
d.
>
> Here you talk about "will not be entered from idle", whereas above you
> mention "when active".  So which is it?  Does a wakelock affect an
> active system or an idle system?

Most of the document refers to wakelocks of type WAKE_LOCK_SUSPEND. If
create a wakelock of type WAKE_LOCK_IDLE affects the idle power state
instead.

>> - The Keypad driver gets an interrupt. It then locks the keypad-scan wak=
elock
>>   and starts scanning the keypad.
>
> Is the system asleep to begin with?  If it is, how does the keypad
> driver get this interrupt unless the system first wakes up?

It may have been. If it was, wake up should be for the interrupt using
the existing set_irq_wake call.

> Conversely, what happens if the PM core has just started a system
> suspend?  Does locking the wakelock force the suspend to be aborted?

Yes, assuming is has not already suspended all the drivers and
disabled interrupts.

>
>> - The keypad-scan code detects a key change and reports it to the input-=
event
>>   driver.
>> - The input-event driver sees the key change, enqueues an event, and loc=
ks
>>   the input-event-queue wakelock.
>> - The keypad-scan code detects that no keys are held and unlocks the
>>   keypad-scan wakelock.
>
> What use is the keypad-scan wakelock?  Isn't the fact that the keypad
> driver's interrupt handler is running already sufficient to prevent or
> delay a system suspend?

Once you hold one key down, you cannot get another interrupt if you
press another key on the same input line. The driver uses a timer to
scan the keypad matrix until all keys are released. A key on a
dedicated input with both rising and falling edge detect interrupt
would not need this wakelock.

>> - The user-space input-event thread returns from select/poll, locks the
>>   process-input-events wakelock and then calls read in the input-event d=
evice.
>> - The input-event driver dequeues the key-event and, since the queue is =
now
>>   empty, it unlocks the input-event-queue wakelock.
>
> Does the input-event-queue wakelock always prevent the system from
> suspending whenever the input queue is nonempty?

Yes.

> Does that mean if I
> type ahead while a program is running, I can't suspend the computer
> until the program processes the keystrokes?

The actual suspend will not happen until all the keys are processed,
but user-space can turn the screen off at any time.

> Does the wakelock mechanism distinguish between suspend or power-state
> transitions that happen automatically and transitions requested
> directly by userspace?

No.

> This would be a little more understandable if
> the wakelocks only prevent the system from suspending itself and don't
> prevent me from suspending the system.

When the user decides to suspend, we use the early-suspend api to tell
the kernel to turn of the screen and possibly some other devices.
Wakelocks are useful without early-suspend, but it must always enter
suspend when the last wakelock is unlocked.

>
>> - The user-space input-event thread returns from read. It determines tha=
t the
>>   key should not wake up the system, releases the process-input-events
>>   wakelock and calls select or poll.
>
> This makes no sense.  If the system wasn't asleep to begin with, how
> could the key wake it up?  And if the system _was_ asleep to begin
> with, how could all of this happen without waking the system up?

What I mean here is that the screen turns on and the system does not
immediately go back to sleep. The user-space framework has its own
idea of whether the system is awake or not. I can change this to
"fully wake up" or "turn on the screen".

-- =

Arve Hj=F8nnev=E5g
