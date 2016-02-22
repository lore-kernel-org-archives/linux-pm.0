From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Mon, 22 Feb 2016 20:32:13 +0530
Message-ID: <56CB22F5.8010808@linux.vnet.ibm.com>
References: <1455637383-14412-1-git-send-email-daniel.lezcano@linaro.org> <1455637383-14412-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455637383-14412-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: tglx@linutronix.de, peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

Hi Daniel,

On 02/16/2016 09:13 PM, Daniel Lezcano wrote:
> +
> +/**
> + * sched_idle_next_wakeup - Predict the next wakeup on the current cpu
> + *
> + * The next event on the cpu is based on a statistic approach of the
> + * interrupt events and the timer deterministic value. From the timer
> + * or the irqs, we return the one expected to occur first.
> + *
> + * Returns the expected remaining idle time before being woken up by
> + * an interruption.
> + */
> +s64 sched_idle_next_wakeup(void)
> +{
> +	s64 next_timer = ktime_to_us(tick_nohz_get_sleep_length());
> +	s64 next_irq = next_irq_event();

Since next_irq_event() uses RCU and we are in idle this should probably
be wrapped in RCU_NONIDLE().

> +
> +	return min(next_irq, next_timer);
> +}
> +

Thanks,
Shreyas
