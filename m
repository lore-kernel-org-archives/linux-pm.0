From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 0/4] time: dynamic irq affinity
Date: Wed, 27 Feb 2013 11:30:11 +0530
Message-ID: <512DA0EB.5000803@ti.com>
References: <1361917047-29230-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361917047-29230-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: john.stultz@linaro.org, tglx@linutronix.de, viresh.kumar@linaro.org, jacob.jun.pan@linux.intel.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, linus.walleij@stericsson.com, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On Wednesday 27 February 2013 03:47 AM, Daniel Lezcano wrote:
> When a cpu goes to a deep idle state where its local timer is shutdown,
> it notifies the time framework to use the broadcast timer instead.
>
> Unfortunately, the broadcast device could wake up any CPU, including an
> idle one which is not concerned by the wake up at all.
>
> This implies, in the worst case, an idle CPU will wake up to send an IPI
> to another idle cpu.
>
> This patch solves this by setting the irq affinity to the cpu concerned
> by the nearest timer event, by this way, the CPU which is wake up is
> guarantee to be the one concerned by the next event and we are safe with
> unnecessary wakeup for another idle CPU.
>
> As the irq affinity is not supported by all the archs, a flag is needed
> to specify which clocksource can handle it.
>
Not completely related to this series but there is another
issue where this local timer not wakeup capable hurts. So
far we are discussing only the timer related future events
which are known and can be programmed with broadcast device.

But think of the scenario's where we need to send asynchronous
IPIs to CPUs to do some work. e.g generic_exec_single().
If the CPU which is suppose to be available after IPI call
is in deep low power state, then the IPI(implemented on ARM)
isn't effective. In CPU off idle modes, a GIC SGI will not wake
the CPU and hence a special wakeup is needed to bring out
those CPUs out of idle. This special wakeup is handled
by broad-cast timer in case of CPUIDLE.

In short what I mean is, you need to have IPI which
can wakeup CPUs from any deep idle power state to address
above. Has anybody thought of this one ?

Regards,
Santosh
P.S: Time and again it proves that making the local timer wakeup
capable solves the issue.
