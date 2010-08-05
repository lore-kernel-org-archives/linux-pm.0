From: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 4 Aug 2010 18:58:15 -0700
Message-ID: <20100805015815.GN2927__34319.3012093709$1280973652$gmane$org@count0.beaverton.ibm.com>
References: <20100731215214.2543c07e@infradead.org>
	<20100801054816.GI2470@linux.vnet.ibm.com>
	<20100731230101.7cc1d8c7@infradead.org>
	<20100801191228.GL2470@linux.vnet.ibm.com>
	<20100801154708.19817b75@infradead.org>
	<20100802011006.GS2470@linux.vnet.ibm.com>
	<AANLkTi=a-1hn_oL=i-=RKK9xOur+4mQjTRut+aiXtYkE@mail.gmail.com>
	<20100803183447.0275c134@infradead.org>
	<20100804163216.GB24163@linux.vnet.ibm.com>
	<20100804163509.GA31523@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100804163509.GA31523@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 04, 2010 at 05:35:09PM +0100, Matthew Garrett wrote:
> On Wed, Aug 04, 2010 at 09:32:16AM -0700, Paul E. McKenney wrote:
> 
> > If this doesn't work for the Android folks for whatever reason, another
> > approach would be to do the freeze in user code, which could track
> > whether any user-level resources (pthread mutexes, SysV semas, whatever)
> > where held, and do the freeze on a thread-by-thread basis within each
> > "victim" application as the threads reach safe points.
> 
> The main problem I see with the cgroups solution is that it doesn't seem 
> to do anything to handle avoiding loss of wakeup events.

cgroups alone don't but there is a solution which doesn't require routing
all event data through a single server -- use SIGIO.

Suppose we've got two cgroups of tasks -- those in the initial freezer
cgroup and those in a freezer cgroup meant for power-naive apps. Let's
call the second cgroup the naive cgroup.

One task -- let's call it the "waker" -- is in the initial cgroup is normaly
asleep waiting for SIGIO. Note it's not an "app" -- it's been trusted/blessed
to be a non-power-naive task. It will be signaled via SIGIO by the
applications which want to be unfrozen when an event comes in.

When the power-naive app in the naive cgroup opens a file descriptor it's
going through the Android interpretter to make the syscall. The interpretter
can do fcntl() on the fd to cause SIGIO to be delivered to the waker task.
When the waker gets SIGIO it unfreezes the naive cgroup and thus wakes the
power-naive app. When the power-naive app wakes it will
poll/return-from-poll/read/return-from-read and thus retrieve the event.

Then it's just a matter of choosing when to freeze the naive cgroup. That
requires a userspace implementation of the suspend blockers API plus
opportunistic suspend but does not require any other kernel pieces. Then you
can use sigprocmask to prevent the freeze/wake-event race. You would
probably even merge the waker with the daemon which implements
opportunistic suspend.

Cheers,
    -Matt Helsley
