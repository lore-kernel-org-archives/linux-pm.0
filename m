From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Sat, 31 Jan 2009 11:19:36 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0901311049260.6305-100000@netrider.rowland.org>
References: <d6200be20901301602w3756321dy94e05a65c2598a19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20901301602w3756321dy94e05a65c2598a19@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: swetland@google.com, Nigel Cunningham <ncunningham@crca.org.au>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 30 Jan 2009, Arve Hj=F8nnev=E5g wrote:

> On Fri, Jan 30, 2009 at 7:13 AM, Alan Stern <stern@rowland.harvard.edu> w=
rote:
> > Personally, I think we need to be able to suspend computers even when
> > there are some unconsumed type-ahead characters in the input buffer.
> > But that's merely an implementation detail.
> =

> For us, the key that will turn the screen back on could be in this buffer.

Why do you have this fixation on the screen?  Forget about the screen =

and consider the system as a whole.

If the keyboard is enabled for wakeup, then typing a key _will_ wake =

the system up from suspend -- provided the key was typed after the =

system went to sleep.  It's silly to think that a key which was typed =

before the computer was suspended should cause it to wake up.


> > And I think this is a big mistake.  It makes sense to have locks for
> > blocking auto suspend, but it does not make sense to prevent the user
> > from putting his own computer to sleep.
> =

> If we go to sleep while the keypad wakelock is locked, then the keypad
> can no longer wake the system up. Note that this is specific to a
> keypad driver that scans the keypad matrix in software. A keyboard
> that generates an interrupt on every key change does not need its own
> wakelock.

Are you sure about this?  IIRC, you said earlier that your keyboard
generates an interrupt on a key press only when no other keys are
already pressed.  Okay -- so imagine the system suspends while a key is
pressed.  Pressing another key won't generate an interrupt and hence
won't wake up the system.  But releasing all the keys and then pressing
one _will_ generate an interrupt and so will wake up the system.  I
don't see any problem with this.

> Also, consider the case where the user presses the power button to go
> to sleep. Before this sleep request has finished a phone call comes
> in. The driver gets an interrupt, enqueues the message and locks a
> wakelock to make sure user-space gets a chance to process the message.
> If we ignore this wakelock, the phone will either not ring at all, or
> it will ring later when the device wakes up for some other reason.

For situations like this, the driver can simply refuse to suspend.  You =

don't need to use a wakelock.

In fact, if you did use a wakelock the behavior would be very strange.  =

The user presses the power button, an instant later a call comes in, =

the device doesn't go to sleep, the user answers the call, and as soon =

as he hangs up (perhaps 10 minutes later) the wakelock is released and =

the device immediately goes to sleep!  Not what the user would expect.

> There is a class of applications where we do want the behaviour you
> describe, but so far all of them also require the screen to stay on.

Again this fixation with the screen.  Forget about the screen!

> This is handled entirely by our user-space framework which also has
> other options (like keeping the keypad backlight on).
> =

> > For example: Suppose some program happens to hold a wakelock, perhaps
> > because of a simple bug, when the user closes the laptop lid and throws
> > the laptop into a backpack.  We don't want the computer to remain awake
> > under those circumstances!
> =

> If the program hold the wakelock because of a bug we don't want the
> computer on, but if it operating correctly we do.

_I_ don't.  I want my device to suspend itself when I tell it to.  =

Nothing is more annoying than a machine that doesn't turn itself off =

when told to do so.

> Since we don't have
> a good way to detect if the program locked the wakelock because of a
> bug, we assume it is correct and honor the request. We have debugging
> interfaces to report how often and for how long wakelocks are locked.
> We also do not allow applications to use wakelocks unless they have
> the required permission.

I admit that in a properly-operating system there won't be any =

wakelocks held because of bugs.  But there might be wakelocks held for =

other reasons, and I don't want _them_ to interfere when I suspend the =

machine either.

> > In fact, it would be a good idea to inform drivers (by passing a
> > particular pm_message_t argument to the suspend method) whether a
> > particular suspend was initiated by the user or as an auto suspend.  In
> > some cases a driver might very well want to allow one while preventing
> > the other.
> =

> I'm not sure this would be useful. We don't have any drivers that only
> need their wakelock to prevent auto suspend.

Maybe you do but you don't realize it.  :-)  And even if you don't, =

maybe other people do.

> And, every pm_suspend
> call is the result of unlocking the last wakelock.

Not true.  What if all the wakelocks are already unlocked when the user =

writes "mem" to /sys/power/state?


> > So what this example really shows is how wakelocks can be used to
> > prevent auto suspend from kicking back in the moment a keystroke is
> > received, before userspace has even had a chance to decide whether or
> > not to turn auto suspend off.  That's how you should describe it -- not
> > as a way of preventing keystrokes from waking the system up.
> =

> I was trying to show that user-space decides which keys allow the
> system to wake up. From the kernels point of view, every key causes a
> wakeup, but if user-space decides that the key should not wake the
> system, the system will go back to sleep as soon as possible (when all
> wakelocks are unlocked).

This paragraph is an excellent example of the muddiness of your =

thinking.  Userspace does _not_ decide which keys allow the system to =

wake up.  _All_ keys cause the system to wake up; userspace then =

decides which ones should cause the system to go right back into =

suspend.

But you don't need wakelocks to do this.  You can get the same effect
without them, just by running a program that writes "mem" (not
"auto-mem"!) to /sys/power/state whenever it sees a keystroke it
doesn't like.  So this example does not illustrate the power of
wakelocks.

> The user-space notion of suspend matches the early-suspend state.

Then call it "early-suspend"!  Don't call it "suspend" or "the =

user-space notion of suspend".

>  I
> consider early-suspend another stage, not a different concept. The
> difference between early-suspend and suspend is similar to the
> difference between device suspend and sysdev suspend. What would you
> call the the first stage of suspend that we have added?

"Early-suspend" is an okay name.  However I have the impression that
you want to prolong the early-suspend stage, and sometimes even go back
to full power directly from early-suspend.  There's nothing wrong with =

that; just make it clear that this is what you're doing.

In fact, I get the impression that much of what you're talking about =

has to do with providing ways to short-circuit a complete suspend and =

go directly from early-suspend back to full power.

Alan Stern
