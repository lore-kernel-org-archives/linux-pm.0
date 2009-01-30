From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Fri, 30 Jan 2009 10:13:20 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0901300955270.2466-100000@iolanthe.rowland.org>
References: <d6200be20901292040l5f540cf5ybbda03db9627c477@mail.gmail.com>
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
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: swetland@google.com, Nigel Cunningham <ncunningham@crca.org.au>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 29 Jan 2009, Arve Hj=F8nnev=E5g wrote:

> > Does the input-event-queue wakelock always prevent the system from
> > suspending whenever the input queue is nonempty?
> =

> Yes.
> =

> > Does that mean if I
> > type ahead while a program is running, I can't suspend the computer
> > until the program processes the keystrokes?
> =

> The actual suspend will not happen until all the keys are processed,
> but user-space can turn the screen off at any time.

Okay, this is slowly getting clearer.

Personally, I think we need to be able to suspend computers even when =

there are some unconsumed type-ahead characters in the input buffer.  =

But that's merely an implementation detail.

> > Does the wakelock mechanism distinguish between suspend or power-state
> > transitions that happen automatically and transitions requested
> > directly by userspace?
> =

> No.

And I think this is a big mistake.  It makes sense to have locks for
blocking auto suspend, but it does not make sense to prevent the user
from putting his own computer to sleep.

For example: Suppose some program happens to hold a wakelock, perhaps =

because of a simple bug, when the user closes the laptop lid and throws =

the laptop into a backpack.  We don't want the computer to remain awake =

under those circumstances!

In fact, it would be a good idea to inform drivers (by passing a =

particular pm_message_t argument to the suspend method) whether a =

particular suspend was initiated by the user or as an auto suspend.  In =

some cases a driver might very well want to allow one while preventing =

the other.

> When the user decides to suspend, we use the early-suspend api to tell
> the kernel to turn of the screen and possibly some other devices.
> Wakelocks are useful without early-suspend, but it must always enter
> suspend when the last wakelock is unlocked.

Wakelocks and early-suspend are separate issues.  Let's consider only
wakelocks.

> >> - The user-space input-event thread returns from read. It determines t=
hat the
> >>   key should not wake up the system, releases the process-input-events
> >>   wakelock and calls select or poll.
> >
> > This makes no sense.  If the system wasn't asleep to begin with, how
> > could the key wake it up?  And if the system _was_ asleep to begin
> > with, how could all of this happen without waking the system up?
> =

> What I mean here is that the screen turns on and the system does not
> immediately go back to sleep. The user-space framework has its own
> idea of whether the system is awake or not. I can change this to
> "fully wake up" or "turn on the screen".

So what this example really shows is how wakelocks can be used to
prevent auto suspend from kicking back in the moment a keystroke is
received, before userspace has even had a chance to decide whether or
not to turn auto suspend off.  That's how you should describe it -- not
as a way of preventing keystrokes from waking the system up.

In fact, you have made the discussion very confusing by using the same
terms ("suspend", "wake up", and so) for at least three different
concepts: full system suspend, early-suspend, and this new userspace
framework's idea of suspend.  Not to mention this other notion of
turning off the screen (and perhaps a few other devices) while leaving
the system as a whole running.  In the future, please use different
words when talking about different concepts.

Alan Stern
