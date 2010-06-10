From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: suspend blockers & Android integration
Date: Thu, 10 Jun 2010 10:28:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006101003480.1702-100000__4130.95207554779$1276180181$gmane$org@iolanthe.rowland.org>
References: <AANLkTil2JhBgJ27qcTARVj2wVgEltxZKPOc9Ddu4c8yY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTil2JhBgJ27qcTARVj2wVgEltxZKPOc9Ddu4c8yY@mail.gmail.com>
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
Cc: Neil Brown <neilb@suse.de>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 9 Jun 2010, Arve Hj=F8nnev=E5g wrote:

> > I think this is where you misunderstood. =A0There is no "report wakeup
> > event" as such. =A0All that happens is that data becomes available to be
> > read from the input device file. =A0However the power manager process
> > isn't polling the device file at this point (because a suspend blocker
> > is active), so it doesn't realize that the source has become active
> > again.
> >
> =

> Yes this is not what I though you were suggesting. I thought you were
> trying to make sure the power manager sees all wakeup events. If you
> are only listening for wakeup events while no suspend blockers are
> active, why latch them?

...

> If you only poll the fd after the last user-space suspend blocker is
> released, why do you care when the kernel wakelock could have been
> released? It seem the only thing it saves you is an extra poll call
> when two wakeup events happen at the same time and one of them is
> fully processed and unblocks suspend before the other event handler
> blocks suspend. It seems strange to remove your wakeup event from the
> list when a specific suspend blocker is acquired when any suspend
> blocker will prevent that wakeup event from being added to the list in
> the first place.

...

> I don't think there is a need to tie the fds to anything else. If you
> poll the fds on the last suspend unblock call, you should get the same
> behaviour.

You are quite right; there is no need to associate suspend blockers
with wakeup sources.  The power manager merely needs to poll all wakeup
sources whenever no suspend blockers are active.  I put those =

associations in the proposal because of the line of reasoning that led =

up to it, but they aren't necessary.


> All input events that can wake the system are handled by one
> user-space suspend blocker. Input devices come and go so we would need
> to add and remove the fds dynamically.

Correct; the power manager would need to know whenever a wakeup-capable =

device file was opened or closed.


> > The power manager would indeed have to know about wakeup devices that
> > don't need to _keep_ the system awake. =A0Here's one way to cope: During
> > those times when no suspend blockers are active but the PM process
> > thinks a wakeup source is active, the PM process could poll every few
> > seconds to update its list of active sources. =A0At those points it cou=
ld
> > remove wakeup sources that have timed out.
> >
> =

> For that to work the wakeup events would have to be reported to the
> power manager in a reliable way in the first place. Passing the file
> descriptor that the app uses to the power manager does not work for
> this, since the app could read the event while the power manager was
> not in the poll call and the power manager would never see it.

If the app activates a suspend blocker before reading the event, this =

doesn't matter.  If the app doesn't activate a suspend blocker then it =

risks being suspended after it has read the event but before it has =

handled the event.  This is equally true with wakelocks.

> Also,
> existing apps don't pass their file descriptors to the power manager,
> so it has the get the event from somewhere else.

Now you've put your finger on the key.  The main difference between my
scheme and the original wakelock scheme is that programs have to inform
the power manager whenever they open or close a wakeup-capable device
file.  With everything implemented inside the kernel this isn't
necessary, because obviously a kernel driver already knows when its
device file is opened or closed.

As I said before, this additional complication in userspace is the
price paid for keeping stuff out of the kernel.  If you had implemented
wakelocks this way originally, you would not have needed to patch the
vanilla kernel and this entire stormy discussion would never have
occurred.  (But of course you couldn't have used this for the original
implementation of wakelocks, because back then the hardware couldn't
achieve the lowest power states from idle.)

> > Obviously this proposal would complicate your userspace. =A0Not
> > enormously, since most of the work is confined to the power manager,
> =

> No, the main problem it that it is not confined to the power manager.
> The power manager does not have a list of file descriptors to monitor,
> so we have to modify all code that handles wakeup events. This
> includes vendor supplied code that we don't have the source for, but,
> on some platforms at least, this code relies on kernel wakelocks with
> a timeout and could at first be handled the same way we would have to
> handle existing apps reading from a socket.

Look, I never said this scheme was _better_ than wakelocks.  I merely =

said that it could be used without significant modifications to the =

kernel.

> The suspend blocker approach is more generally useful since it
> supports hardware where suspend is needed. Why this argument is being
> ignored is very puzzling.

Probably because people doesn't envision system suspend being used for
dynamic power management on that kind of hardware.

> Your solution is not immediately useful since depends on removing all
> periodic kernel timers and adding support to stopping the monotonic
> clock for set of processes that are frozen.

The monotonic clock is indeed an issue.

Periodic kernel timers... I don't know about them.  Has anyone tried to
measure them?  There are excellent reasons for trimming them when the
system goes into low-power idle, independent of Android.  This sounds
like the kind of thing Arjan might have worked on.

> Your solution forces the user space interface to be more complicated,
> and it creates a new user space power manager that has to start before
> any process that handle wakeup events.

That's right.

Alan Stern
