From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Fri, 30 Jan 2009 16:02:04 -0800
Message-ID: <d6200be20901301602w3756321dy94e05a65c2598a19@mail.gmail.com>
References: <d6200be20901292040l5f540cf5ybbda03db9627c477@mail.gmail.com>
	<Pine.LNX.4.44L0.0901300955270.2466-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0901300955270.2466-100000@iolanthe.rowland.org>
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

On Fri, Jan 30, 2009 at 7:13 AM, Alan Stern <stern@rowland.harvard.edu> wro=
te:
> Personally, I think we need to be able to suspend computers even when
> there are some unconsumed type-ahead characters in the input buffer.
> But that's merely an implementation detail.

For us, the key that will turn the screen back on could be in this buffer.

>> > Does the wakelock mechanism distinguish between suspend or power-state
>> > transitions that happen automatically and transitions requested
>> > directly by userspace?
>>
>> No.
>
> And I think this is a big mistake.  It makes sense to have locks for
> blocking auto suspend, but it does not make sense to prevent the user
> from putting his own computer to sleep.

If we go to sleep while the keypad wakelock is locked, then the keypad
can no longer wake the system up. Note that this is specific to a
keypad driver that scans the keypad matrix in software. A keyboard
that generates an interrupt on every key change does not need its own
wakelock.

Also, consider the case where the user presses the power button to go
to sleep. Before this sleep request has finished a phone call comes
in. The driver gets an interrupt, enqueues the message and locks a
wakelock to make sure user-space gets a chance to process the message.
If we ignore this wakelock, the phone will either not ring at all, or
it will ring later when the device wakes up for some other reason.

There is a class of applications where we do want the behaviour you
describe, but so far all of them also require the screen to stay on.
This is handled entirely by our user-space framework which also has
other options (like keeping the keypad backlight on).

> For example: Suppose some program happens to hold a wakelock, perhaps
> because of a simple bug, when the user closes the laptop lid and throws
> the laptop into a backpack.  We don't want the computer to remain awake
> under those circumstances!

If the program hold the wakelock because of a bug we don't want the
computer on, but if it operating correctly we do. Since we don't have
a good way to detect if the program locked the wakelock because of a
bug, we assume it is correct and honor the request. We have debugging
interfaces to report how often and for how long wakelocks are locked.
We also do not allow applications to use wakelocks unless they have
the required permission.

> In fact, it would be a good idea to inform drivers (by passing a
> particular pm_message_t argument to the suspend method) whether a
> particular suspend was initiated by the user or as an auto suspend.  In
> some cases a driver might very well want to allow one while preventing
> the other.

I'm not sure this would be useful. We don't have any drivers that only
need their wakelock to prevent auto suspend. And, every pm_suspend
call is the result of unlocking the last wakelock.

>> >> - The user-space input-event thread returns from read. It determines =
that the
>> >>   key should not wake up the system, releases the process-input-events
>> >>   wakelock and calls select or poll.
>> >
>> > This makes no sense.  If the system wasn't asleep to begin with, how
>> > could the key wake it up?  And if the system _was_ asleep to begin
>> > with, how could all of this happen without waking the system up?
>>
>> What I mean here is that the screen turns on and the system does not
>> immediately go back to sleep. The user-space framework has its own
>> idea of whether the system is awake or not. I can change this to
>> "fully wake up" or "turn on the screen".
>
> So what this example really shows is how wakelocks can be used to
> prevent auto suspend from kicking back in the moment a keystroke is
> received, before userspace has even had a chance to decide whether or
> not to turn auto suspend off.  That's how you should describe it -- not
> as a way of preventing keystrokes from waking the system up.

I was trying to show that user-space decides which keys allow the
system to wake up. From the kernels point of view, every key causes a
wakeup, but if user-space decides that the key should not wake the
system, the system will go back to sleep as soon as possible (when all
wakelocks are unlocked).

> In fact, you have made the discussion very confusing by using the same
> terms ("suspend", "wake up", and so) for at least three different
> concepts: full system suspend, early-suspend, and this new userspace
> framework's idea of suspend.  Not to mention this other notion of
> turning off the screen (and perhaps a few other devices) while leaving
> the system as a whole running.  In the future, please use different
> words when talking about different concepts.

The user-space notion of suspend matches the early-suspend state. I
consider early-suspend another stage, not a different concept. The
difference between early-suspend and suspend is similar to the
difference between device suspend and sysdev suspend. What would you
call the the first stage of suspend that we have added?

-- =

Arve Hj=F8nnev=E5g
