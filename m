From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 13 May 2010 14:54:05 -0700
Message-ID: <20100513215404.GN3428__15861.9631002241$1273787733$gmane$org@atomide.com>
References: <20100513194205.GC3428@atomide.com>
	<Pine.LNX.4.44L0.1005131740370.1731-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1005131740370.1731-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-omap@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

* Alan Stern <stern@rowland.harvard.edu> [100513 14:36]:
> On Thu, 13 May 2010, Tony Lindgren wrote:
> 
> > Well this is an interesting problem, and once solved will be handy
> > for all kind of things. My worry is that if it's integrated in it's
> > current form it will be totally out of control all over the place :(
> > 
> > Still hoping we can come up with some clean way that avoid the patching
> > all over the place part.. How about the following, can you please check
> > if it would help with your example of guaranteed handling of event:
> > 
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
> > 
> > Now to me it sounds if your the input layer and userspace handle
> > both grab the timers with the critical flags, it should be guaranteed
> > that the events get handled before the system is suspended.
> 
> Why do you want this to be tied to timers?  Many of the events in 
> question are asynchronous with no specific timing relations.

To me it seems that the non-timer related events can be dealt
with toggling the opportunistic suspend idle flag in sysfs.
That should depend on the device and use specific policy.

Tony
