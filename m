From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC v1 3/8] timer: Export next wakeup time of a CPU
Date: Mon, 29 Oct 2018 23:36:08 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1810292334160.5984@nanos.tec.linutronix.de>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org> <1539206455-29342-4-git-send-email-rplsssn@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539206455-29342-4-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

Raju,

On Thu, 11 Oct 2018, Raju P.L.S.S.S.N wrote:
>  
> +/**
> + * tick_nohz_get_next_wakeup - return the next wake up of the CPU

Lacks documentation of @cpu. Please include kernel docs into your test
builds.

> + */
> +ktime_t tick_nohz_get_next_wakeup(int cpu)
> +{
> +	struct clock_event_device *dev = per_cpu(tick_cpu_device.evtdev, cpu);
> +
> +	return dev->next_event;
> +}

Thanks,

	tglx
