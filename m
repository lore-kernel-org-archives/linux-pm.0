From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Crashes in arm qemu emulations due to 'cpufreq: governor:
 Replace timers with utilization ...'
Date: Mon, 15 Feb 2016 19:07:00 +0000
Message-ID: <20160215190700.GN10826@n2100.arm.linux.org.uk>
References: <20160215170527.GA24453@roeck-us.net>
 <CAJZ5v0gLankSuziQq25qTCyNqeOX43yD9jnJu_XXwbdyajfmKg@mail.gmail.com>
 <56C21DD0.40508@arm.com>
 <CAJZ5v0gfOVyoWeee5jg7NxLFm-xwdA6-sPQV+cJ=NWJOV-wYzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gfOVyoWeee5jg7NxLFm-xwdA6-sPQV+cJ=NWJOV-wYzg@mail.gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 15, 2016 at 07:54:26PM +0100, Rafael J. Wysocki wrote:
> On Mon, Feb 15, 2016 at 7:49 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > Given that OMAP3 is a UP system, there is zero chance that it has
> > registered the magic hook that delivers IPIs (its interrupt controller
> > is not even capable of doing so).
> >
> > I don't really know the context, but IPIs on a UP system seem at best odd.
> 
> That would explain it, thanks.
> 
> So it looks like we should always use irq_work_queue() on UP even if
> CONFIG_SMP is set, shouldn't we?

irq_work_queue_on() doesn't check whether 'cpu' is the CPU that we're
running on.  This is a problem where we want to be able to run a kernel
built for SMP on a UP system.

I guess the question is whether irq_work_queue_on() is buggy, or whether
our implementation of arch_send_call_function_single_ipi() is buggy.
Should arch_send_call_function_single_ipi() do something on UP systems,
if so what?

We don't have IPIs on UP systems, so we can't raise any interrupts.
So, should we call generic_smp_call_function_interrupt() directly
from it?

Some clues would be good...

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
