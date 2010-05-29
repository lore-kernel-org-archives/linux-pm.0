From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Sat, 29 May 2010 11:03:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005291056490.31946-100000__8918.5579833158$1275145534$gmane$org@netrider.rowland.org>
References: <AANLkTimyLsldXoZ_egjybwS9kE_OcxsOuZwC0F-C2HjY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimyLsldXoZ_egjybwS9kE_OcxsOuZwC0F-C2HjY@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Sat, 29 May 2010, Brian Swetland wrote:

> On Sat, May 29, 2010 at 7:10 AM, Alan Stern <stern@rowland.harvard.edu> w=
rote:

> > If no such constraints are active, the QoS-based suspend blocks in an
> > interruptible wait until the number of active QOS_EVENTUALLY
> > constraints drops to 0. =C2=A0When that happens, it carries out a normal
> > suspend-to-RAM -- except that it checks along the way to make sure that
> > no new QoS constraints are activated while the suspend is in progress.
> > If they are, the PM core backs out and fails the QoS-based suspend.
> >
> > Userspace suspend blockers don't exist at all, as far as the kernel is
> > concerned. =C2=A0In their place, the Android runs a power-manager progr=
am
> > that receives IPC requests from other processes when they need to
> > prevent the system from suspending or allow it to suspend. =C2=A0The po=
wer
> > manager's main loop looks like this:
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0for (;;) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (any IPC r=
equests remain)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0handle them;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (any processe=
s need to prevent suspend)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0sleep;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0write "qos" to /sys/power/state;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =

> The issue with this approach is that if userspace wants to suspend
> while a driver is holding a QOS_EVENTUALLY constraint, it's basically
> going to spin constantly writing "qos" and failing.

No, no.  If userspace wants to suspend while a driver is holding a =

QOS_EVENTUALLY constraint, the user process blocks in an interruptible =

wait state as described in the first paragraph above.

> Could we have write(powerstate_fd, "qos",3) block until all
> QOS_EVENTUALLY constraints are lifted or the system successfully
> suspends and resumes or a signal arrives?

That is basically what I originally wrote.

> > The idea is that receipt of a new IPC request will cause a signal to be
> > sent, interrupting the sleep or the "qos" write.
> =

> Alternatively (to ipc), we could have a driver provide the same
> suspendblock style interface to userspace and maps it to qos
> constraints.  If it's something we maintain out-of-tree, no worries.
> The kernel side api is the bit that's the headache to maintain
> multiple versions of drivers with and without, after all.

Yep.  The idea is that all this userspace-oriented part should be
invisible to the vanilla kernel.

> I'm sure Arve will weigh in on this later, but from what I can see it
> certainly seems like this model provides us with the functionality
> we're looking for, provided the issue with
> spinning-while-waiting-for-drivers-to-release-constraints is sorted
> out.

I'm more concerned about how the other kernel developers will react.

Alan Stern
