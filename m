From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v2 7/7] ARM: smp: Add runtime PM support for CPU hotplug
Date: Fri, 4 Sep 2015 09:12:02 -0600
Message-ID: <20150904151202.GA876@linaro.org>
References: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
 <1441310314-8857-8-git-send-email-lina.iyer@linaro.org>
 <20150904091735.GC21084@n2100.arm.linux.org.uk>
 <20150904092716.GD21084@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20150904092716.GD21084@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, ulf.hansson@linaro.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, rjw@rjwysocki.net, k.kozlowski@samsung.com, msivasub@codeaurora.org, khilman@linaro.org, geert@linux-m68k.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 04 2015 at 03:27 -0600, Russell King - ARM Linux wrote:
>On Fri, Sep 04, 2015 at 10:17:35AM +0100, Russell King - ARM Linux wrote:
>> On Thu, Sep 03, 2015 at 01:58:34PM -0600, Lina Iyer wrote:
>> > @@ -401,6 +412,11 @@ asmlinkage void secondary_start_kernel(void)
>> >  	local_irq_enable();
>> >  	local_fiq_enable();
>> >
>> > +	/* We are running, enable runtime PM for the CPU. */
>> > +	cpu_dev = get_cpu_device(cpu);
>> > +	if (cpu_dev)
>> > +		pm_runtime_get_sync(cpu_dev);
>> > +
>>
>> Please no.  This is fragile.
>>
>> pm_runtime_get_sync() can sleep, and this path is used when the system
>> is fully up and running.  Locks may be held, which cause this to sleep.
>> However, we're calling it from a context where we can't sleep - which
>> is the general rule for any part of system initialisation where we
>> have not entered the idle thread yet (the idle thread is what we run
>> when sleeping.)
>>
More explanation below.

Another patch (3/7) in this series defines CPU devices as IRQ safe and
therefore the dev->power.lock would be spinlock'd before calling the
rest of the PM runtime code and the domain. The CPU PM domain would also
be an IRQ safe domain (patch 2/7 makes the genpd framework usable in IRQ
safe context).

>> NAK on this.
>
>There's another issue here.  This is obviously wrong.  If the CPU is
>inside the PM domain, then don't you need the PM domain powered up for
>the CPU to start executing instructions?
>
This would not be the case for CPU PM domains. The CPU PM domains AFAIK,
are triggered by the same wake up interrupt that brings the CPU out of
its power downs state. The domain hardware has to be awake before the
CPU executes its first instruction. Thefore the hw power up is a logical
OR of the wakeup signals to any of the cores.

Similarly, the domain hardware would be the last to power down after all
the CPUs.  Generally tied to the execution of WFI command by the ARM CPU
core. The domain power down signal is a logical AND of all the WFI
signals of all the cores in the domain.

>If the CPU can run instructions with the PM domain that it's allegedly
>inside powered down, then the CPU is _not_ part of the PM domain, and
>this whole thing is total crap.
>
CPU PM domains have to be synchronized in hardware and all these can
only happen when the SoC provides a domain that can power on before any
of the CPU powers up and power down only after the all CPUs have powered
down.

What s/w generally can do in the CPU domain power on/off callbacks from
genpd is to configure which state the domain should be in, when all the
CPUs have powered down. Many SoCs, have PM domains that could be in
retention in anticipation of an early wakeup or could be completely
cache flushed and powered down, when suspending or sleeping for a longer
duration. The power off callbacks for the PM domain does the
configuration and it doesnt take effect until all the CPUs power down.

While powering on the domain in the genpd power on callback, all we do
is to ensure that the domain is reconfigured to remain active (ignore
all WFI instruction from the CPU, which are not tied to CPU power down.
Dont want the domain powering off when all CPUs in the domain are just
clock gated.) until the domain is configured to its idle state by the
last CPU in Linux.

>Sorry, I'm really not impressed by the "design" here, it seems to be
>totally screwed.
>

Thanks,
Lina
