From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Fri, 7 May 2010 10:22:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005071019170.1804-100000__17070.1704839759$1273242236$gmane$org@iolanthe.rowland.org>
References: <y2id6200be21005061648m47d03875h6e9de89d0e965344@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <y2id6200be21005061648m47d03875h6e9de89d0e965344@mail.gmail.com>
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
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 6 May 2010, Arve Hj=F8nnev=E5g wrote:

> On Thu, May 6, 2010 at 12:40 PM, Alan Stern <stern@rowland.harvard.edu> w=
rote:
> > On Thu, 6 May 2010, Rafael J. Wysocki wrote:
> >
> >> > Here's a completely new issue. =A0When using opportunistic suspends =
on an
> >> > SMP system, it could happen that the system gets a wakeup event and
> >> > this routine starts running again before the event's IRQ handler has
> >> > finished (or has enabled a suspend blocker). =A0The system would
> >> > re-suspend too soon.
> >>
> >> This routine will be run from a freezable workqueue.
> >
> > But how do you know that processes won't get unfrozen until all the
> > pending IRQs have been handled? =A0Imagine something like this:
> >
> > =A0 =A0 =A0 =A0CPU 0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CPU 1
> > =A0 =A0 =A0 =A0----- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 -----
> > =A0 =A0 =A0 =A0Wake up non-boot CPUs
> > =A0 =A0 =A0 =A0Resume devices =A0 =A0 =A0 =A0 =A0Invoke the IRQ handler
> >
> > =A0 =A0 =A0 =A0[ CPU 0 should wait here for the handler to finish,
> > =A0 =A0 =A0 =A0 =A0but it doesn't ]
> >
> > =A0 =A0 =A0 =A0Defrost threads =A0 =A0 =A0 =A0 Handler running...
> > =A0 =A0 =A0 =A0Workqueue routine runs
> > =A0 =A0 =A0 =A0Start another suspend
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Handler =
enables a suspend blocker,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0but it's=
 too late
> =

> It is not optimal, but it is not too late. We check if any suspend
> blockers block suspend after disabling non-boot cpus so as long as
> this is done in a way that does not lose interrupts the resuspend
> attempt will not succeed.

Is it possible for the resuspend to disable CPU 1 before the IRQ
handler can enable its suspend blocker?  (Probably not -- but I don't
know enough about how non-boot CPUs are enabled or disabled.)

Alan Stern
