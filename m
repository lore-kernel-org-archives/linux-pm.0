From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 14 May 2010 00:28:49 +0200
Message-ID: <201005140028.49443.rjw__34059.7591632561$1273791440$gmane$org@sisk.pl>
References: <20100513214739.GM3428@atomide.com>
	<Pine.LNX.4.44L0.1005131756420.1731-100000@iolanthe.rowland.org>
	<20100513220814.GP3428@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100513220814.GP3428@atomide.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Kernel development list <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Oleg Nesterov <oleg@redhat.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Friday 14 May 2010, Tony Lindgren wrote:
> * Alan Stern <stern@rowland.harvard.edu> [100513 14:56]:
> > On Thu, 13 May 2010, Tony Lindgren wrote:
> > 
> > > > > And that's why 
> > > > > it should be handled by runtime power management instead.
> > > > 
> > > > Runtime PM is not capable of freezing userspace and shutting down CPUs.  
> > > > More or less by definition -- if it could then it wouldn't be "runtime" 
> > > > any more, since the processor wouldn't be running.
> > > 
> > > Not true. We are already powering off CPUs and rebooting them for
> > > at least omaps in every idle loop using cpuidle. The memory stays on.
> > 
> > Okay, that's a valid point.  But is that approach usable in general 
> > (i.e., on non-OMAP systems)?
> 
> Yes if your system wakes to interrupts at least. If your system does
> not wake to timer events, then you'll get missed timers. So it should
> work on PC too with CONFIG_NO_HZ and if RTC was used for the timer
> wake event.
>  
> > How do you handle situations where the CPU is currently idle but an 
> > event (such as I/O completion) is expected to occur in the near future?  
> > You don't want to power-off and reboot then, do you?
> 
> The idle code looks at next_timer_interrupt() value, then if the
> next timer event if far enough ahead, the system powers down and
> wakes to the timer interrupt. It also wakes to device interrupts.

For the record, waking to interrupts doesn't work on quite some systems
(like ACPI-based PCs for one example).

Rafael
