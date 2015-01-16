From: Mason <mpeg.blue@free.fr>
Subject: Re: RFC on cpufreq implementation
Date: Fri, 16 Jan 2015 12:10:23 +0100
Message-ID: <54B8F19F.8060108@free.fr>
References: <54B7F7CD.7030903@free.fr> <1421399293.11224.7.camel@AMDC1943>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:49302 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499AbbAPLKa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 16 Jan 2015 06:10:30 -0500
In-Reply-To: <1421399293.11224.7.camel@AMDC1943>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>

On 16/01/2015 10:08, Krzysztof Kozlowski wrote:

> On 2015-01-15 at 18:24 +0100, Mason wrote:
>  
>> This is a follow-up to my previous thread.
>> "How many frequencies would cpufreq optimally like to manage?"
>> http://thread.gmane.org/gmane.linux.ports.arm.kernel/373669
>>
>> As I originally wrote, I'm running 3.14 on an ARM Cortex-A9
>> based SoC (namely Tango4 from Sigma Designs). I'd like to get
>> some feedback on the cpufreq driver I wrote for that platform.
>>
>> I decided to expose only a small subset of frequencies (namely
>> {999,500,333,111} MHz) because, in my tests, the ondemand gov
>> chose mostly min and max, and the intermediate frequencies not
>> so much; so I figured "2 intermediate freqs" is good enough.
>> (I'm ready to hear otherwise.)

I'll take a closer look at other drivers, but I'd like to hear
opinions on the subject.

>> I tried to use as much generic framework as possible, but I've
>> read about the clk framework, and it looks to be an even greater
>> generalization. Are new platforms encouraged to use that, rather
>> than provide a cpufreq driver? Does it work when voltage scaling
>> comes in play? (This SoC doesn't have it, but the next will.)
>
> The clock framework generalizes clocks, not cpufreq. Ideally you should
> use clock framework in cpufreq driver. So instead manually setting
> divider just do something like:
>
> ret = clk_set_rate(cpu_clk, freq_exact);
> if (ret) {
> 	dev_err(cpu_dev, "failed to set clock rate: %d\n", ret);
> 	return ret;
> }

I will give clk a closer look.

> For voltage scaling you should use regulator framework.

OK. I'm also interested in frequency-throttling when temperatures
rise beyond specific thresholds. What subsystem ties sensors and
cpufreq together?

> Actually I think existing cpufreq-dt could serve your purpose. Why don't
> you try it? Or look at it and use as an example.

Will do. I've heard of device tree, but know nothing about it.

>> I'm also wondering how cpufreq and cpuidle interact? Is one a
>> subset of the other? Are they orthogonal?
>
> cpuidle and cpufreq are different subsystems. They don't interact, yet.
> There are efforts to combine scheduler, cpufreq and cpuidle but this is
> future. If your SoC has some deeper low power states than developing
> cpuidle driver makes sense. If not - WFI will be used.

AFAIU, there are no deeper power states on the Cortex-A9.

I didn't find where WFI is called :-(

In kernel/cpu/idle.c (file seems to have been removed in 3.15)
cpu_idle_loop() calls arch_cpu_idle()
http://lxr.free-electrons.com/source/kernel/cpu/idle.c?v=3.14#L98

In arch/kernel/process.c
http://lxr.free-electrons.com/source/arch/arm/kernel/process.c?v=3.14#L173
/*
  * Called from the core idle loop.
  */
void arch_cpu_idle(void)
{
	if (cpuidle_idle_call())
		default_idle();
}

default_idle calls cpu_do_idle (by default), a macro for cpu_v7_do_idle
which executes dsb+wfi, BUT...

ifndef CONFIG_CPU_IDLE then
static inline int cpuidle_idle_call(void) { return -ENODEV; }

Does that mean I MUST define CONFIG_CPU_IDLE if I want the idle
loop to call wfi (to save power), even if I don't have a cpuidle
driver?

Regards.

