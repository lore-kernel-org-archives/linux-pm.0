From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Mon, 24 May 2010 21:34:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005242130290.8440-100000__30122.9655779482$1274751321$gmane$org@netrider.rowland.org>
References: <AANLkTikz2UcDv6BZQ9Hq2MdowuAK1y_PBBPPXMEkDmNa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikz2UcDv6BZQ9Hq2MdowuAK1y_PBBPPXMEkDmNa@mail.gmail.com>
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
Cc: Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 24 May 2010, Arve Hj=F8nnev=E5g wrote:

> > Wakeup events can be lost in at least three different ways:
> >
> > =A0 =A0 1. A hardware signal (such as an IRQ) gets ignored.
> >
> > =A0 =A0 2. The hardware event occurs, but without effect since the
> > =A0 =A0 =A0 =A0kernel thread that would handle the event has been froze=
n.
> > =A0 =A0 =A0 =A0The event just ends up sitting in a queue somewhere until
> > =A0 =A0 =A0 =A0something else wakes up the system.
> >
> > =A0 =A0 3. The hardware event occurs and the kernel handles it fully,
> > =A0 =A0 =A0 =A0but the event propagates to userspace for further handli=
ng
> > =A0 =A0 =A0 =A0and the user program is already frozen.
> >
> > 1 is a hardware configuration failure (for example, it might happen as
> > a result of using edge-triggered IRQs instead of level-triggered) and
> > is outside the scope of this discussion.
> >
> > 2 generally represents a failure of the core PM subsystem, or a failure
> > of some other part of the kernel to use the PM core correctly. =A0In
> > theory we should be able to fix such mistakes. =A0Right now I'm aware of
> > at least one possible failure scenario that could be fixed fairly
> > easily.
> >
> > 3 is the type of failure that suspend blockers were really meant to
> > handle, particularly the userspace suspend-blocker API.

> I don't see a big difference between 2 and 3. You can use suspend
> blockers to handle either.

You can, but they aren't necessary.  If 2 were the only reason for =

suspend blockers, I would say they shouldn't be merged.

Whereas 3, on the other hand, can _not_ be handled by any existing
mechanism.  3 is perhaps the most important reason for using suspend
blockers.

Alan Stern
