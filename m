From: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 4 Aug 2010 20:25:56 -0700
Message-ID: <20100805032556.GO2927__37861.3625340678$1280978808$gmane$org@count0.beaverton.ibm.com>
References: <20100731230101.7cc1d8c7@infradead.org>
	<20100801191228.GL2470@linux.vnet.ibm.com>
	<20100801154708.19817b75@infradead.org>
	<20100802011006.GS2470@linux.vnet.ibm.com>
	<AANLkTi=a-1hn_oL=i-=RKK9xOur+4mQjTRut+aiXtYkE@mail.gmail.com>
	<20100803183447.0275c134@infradead.org>
	<20100804163216.GB24163@linux.vnet.ibm.com>
	<20100804163509.GA31523@srcf.ucam.org>
	<20100805015815.GN2927@count0.beaverton.ibm.com>
	<AANLkTi=yQitRpx9AXMw6+Jx=hAVfZn2imR=DNiSi_SAf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=yQitRpx9AXMw6+Jx=hAVfZn2imR=DNiSi_SAf@mail.gmail.com>
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
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 04, 2010 at 07:02:55PM -0700, Brian Swetland wrote:
> On Wed, Aug 4, 2010 at 6:58 PM, Matt Helsley <matthltc@us.ibm.com> wrote:
> > On Wed, Aug 04, 2010 at 05:35:09PM +0100, Matthew Garrett wrote:
> >>
> >> The main problem I see with the cgroups solution is that it doesn't seem
> >> to do anything to handle avoiding loss of wakeup events.
> >
> > cgroups alone don't but there is a solution which doesn't require routing
> > all event data through a single server -- use SIGIO.
> >
> > Suppose we've got two cgroups of tasks -- those in the initial freezer
> > cgroup and those in a freezer cgroup meant for power-naive apps. Let's
> > call the second cgroup the naive cgroup.
> >
> > One task -- let's call it the "waker" -- is in the initial cgroup is normaly
> > asleep waiting for SIGIO. Note it's not an "app" -- it's been trusted/blessed
> > to be a non-power-naive task. It will be signaled via SIGIO by the
> > applications which want to be unfrozen when an event comes in.
> >
> > When the power-naive app in the naive cgroup opens a file descriptor it's
> > going through the Android interpretter to make the syscall. The interpretter
> > can do fcntl() on the fd to cause SIGIO to be delivered to the waker task.
> > When the waker gets SIGIO it unfreezes the naive cgroup and thus wakes the
> > power-naive app. When the power-naive app wakes it will
> > poll/return-from-poll/read/return-from-read and thus retrieve the event.
> 
> The Android execution model includes native code in addition to the
> dalvik VM, and in the future could include other runtimes -- there are
> many standard libraries that directly make posix file IO calls, and
> apps can bundle native libraries which can also directly make
> syscalls.  It's not practical to instrument every piece of userspace
> code that opens a fd somehow to make additional fcntl calls in various
> places.

Perhaps using an LD_PRELOAD will work.

Cheers,
	-Matt Helsley
