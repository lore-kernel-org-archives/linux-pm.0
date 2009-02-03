From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Mon, 2 Feb 2009 22:27:23 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0902022207440.27307-100000@netrider.rowland.org>
References: <d6200be20902021510k104f2da9ha89fa00baff3910a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902021510k104f2da9ha89fa00baff3910a@mail.gmail.com>
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
Cc: Brian Swetland <swetland@google.com>, linux-pm@lists.linux-foundation.org, Uli Luckas <u.luckas@road.de>, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Mon, 2 Feb 2009, Arve Hj=F8nnev=E5g wrote:

> On Mon, Feb 2, 2009 at 7:09 AM, Alan Stern <stern@rowland.harvard.edu> wr=
ote:
> > On Mon, 2 Feb 2009, Uli Luckas wrote:
> >> Except you always want early-suspend and auto-suspend at the same time=
. The
> >> idea is, if all display of system states is off (early-suspend), we can
> >> enable or disable the cpu at will (auto-suspend) because nobody will n=
otice.
> >
> > Why should the kernel have to get involved?  Why can't userspace manage
> > both early-suspend and auto-suspend?
> =

> The kernel does not need to be involved in early-suspend. We use
> early-suspend as a simple way to shut down the framebuffer and some
> input devices.
> If by auto-suspend you mean suspend after user inactivity (usually
> after a number of seconds or minutes), then the kernel does not need
> to be involved, but if you mean suspending when all wakelocks are
> unlocked, the kernel needs to be involved to avoid delays. If the last
> wakelock to be unlocked is a kernel wakelock, then user-space would
> not know that it needs to re-attempt suspend.

I meant both: suspending after user inactivity when all wakelocks are =

unlocked.

If you'd like a way for the kernel to communicate to userspace that the
last wakelock has been unlocked, you could use a signal or a select.
But the simplest way would be to make a process block on reading a
sysfs file until the last wakelock is released.

> > That is, consider the following: Userspace initiates an early-suspend
> > by using a runtime PM interface to turn off the screen and some other
> > devices.  After a short time, if they are still off, then userspace can
> > initiate an auto-suspend by writing "auto-mem" to /sys/power/state.
> =

> Why do you want a delay?

I thought you wanted one.  If you don't then okay, don't use a delay.

> Also, what do you mean by a runtime PM interface?

I'm making a distinction between system PM and runtime (also known as =

dynamic) PM.  With system PM the entire system goes into a low-power =

state -- that's what we mean when we talk about suspend or hibernation.  =

With runtime PM the system as a whole remains running while selected =

devices are individually put into a low-power state.

For example, right now Linux will put a USB host controller into a
low-power state if no USB devices are plugged into it.  This runtime PM
interface is described in Documentation/usb/power-management.txt.  You
might want to use some of those mechanisms for controlling your
devices.

> > All the kernel would need to know is the difference between
> > auto-suspend and normal suspend: one respects wakelocks and the other
> > doesn't.
> =

> If by normal suspend you mean what is supported in the kernel now,
> then OK. We can support existing userspace code by ignoring wakelocks.
> My intention was that you only enable the WAKELOCK config option when
> using it, but I agree that it is better to allow the kernel to be
> built with support for both modes.
> =

> What do you think should happen if user-space tries to use both interface=
s?

For example, if one process tries to start an auto-suspend, and at the =

same time another process writes "mem" to /sys/power/state?  Then the =

second process should take precedence and the system should go into =

suspend.  When it wakes up again, the first process would still be =

waiting for an auto-suspend to occur.  I suppose the details don't =

matter much because it's not likely to crop up often.

Alan Stern
