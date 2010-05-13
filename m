From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 13 May 2010 13:00:04 -0700
Message-ID: <20100513200003.GE3428__32432.0396678106$1273780876$gmane$org@atomide.com>
References: <alpine.DEB.2.00.1005122118530.7624@utopia.booyaka.com>
	<Pine.LNX.4.44L0.1005131002380.1695-100000@iolanthe.rowland.org>
	<20100513191717.GA3428@atomide.com>
	<20100513192522.GA19256@srcf.ucam.org>
	<20100513194205.GC3428@atomide.com>
	<20100513195349.GB19722@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100513195349.GB19722@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

* Matthew Garrett <mjg@redhat.com> [100513 12:49]:
> On Thu, May 13, 2010 at 12:42:05PM -0700, Tony Lindgren wrote:
> 
> > 1. In the kernel, we add one more timer queue for critical timers.
> >    The current timer queue(s) stay as it is.
> > 
> > 2. We allow selecting the timer based on some flag, the default
> >    behaviour being the current default timer queue.
> > 
> > 3. Then we add next_timer_interupt_critical() to only query the
> >    critical timers along the lines of the current next_timer_interrupt().
> > 
> > 4. We implement a custom pm_idle that suspends the system based on
> >    some logic and checking if next_timer_interrupt_critical() is
> >    empty. If the next_timer_interrupt_critical() does not return
> >    anything, we assume it's OK to suspend the system.
> 
> Ok. So we stick the untrusted bits of userspace on the critical timer 
> list.

I guess you mean the trusted instead of untrusted apps in the userspace
above, the ones that are critical to keep running.

> Now we get a network packet that generates a wakeup event and gets 
> read by an application. What happens if that application can't fully 
> process the packet in a single timeslice?

The system stays running because there's something to do. The system
won't suspend until all the processors hit the kernel idle loop and
the next_timer_interrupt_critical() returns nothing.

Regards,

Tony
