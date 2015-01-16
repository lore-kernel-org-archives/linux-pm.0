From: Mason <mpeg.blue@free.fr>
Subject: Re: RFC on cpufreq implementation
Date: Fri, 16 Jan 2015 15:00:14 +0100
Message-ID: <54B9196E.1030302@free.fr>
References: <54B7F7CD.7030903@free.fr> <1421399293.11224.7.camel@AMDC1943> <54B8F19F.8060108@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <54B8F19F.8060108@free.fr>
Sender: cpufreq-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 16/01/2015 12:10, Mason wrote:

> I didn't find where WFI is called :-(
>
> In kernel/cpu/idle.c (file seems to have been removed in 3.15)
> cpu_idle_loop() calls arch_cpu_idle()
> http://lxr.free-electrons.com/source/kernel/cpu/idle.c?v=3.14#L98
>
> In arch/kernel/process.c
> http://lxr.free-electrons.com/source/arch/arm/kernel/process.c?v=3.14#L173
> /*
>   * Called from the core idle loop.
>   */
> void arch_cpu_idle(void)
> {
>      if (cpuidle_idle_call())
>          default_idle();
> }
>
> default_idle calls cpu_do_idle (by default), a macro for cpu_v7_do_idle
> which executes dsb+wfi, BUT...
>
> ifndef CONFIG_CPU_IDLE then
> static inline int cpuidle_idle_call(void) { return -ENODEV; }
>
> Does that mean I MUST define CONFIG_CPU_IDLE if I want the idle
> loop to call wfi (to save power), even if I don't have a cpuidle
> driver?

For the record, I read the code wrong.

cpuidle_idle_call() always returns -ENODEV, so the test
"if (cpuidle_idle_call())" is always true, and we always
call default_idle() and everything works as expected.

Sorry for the noise.

