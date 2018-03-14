From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v6 06/25] timer: Export next wakeup time of a CPU
Date: Wed, 14 Mar 2018 17:19:51 +0000
Message-ID: <20180314171950.yn5spehwzuc5nttu@lakrids.cambridge.arm.com>
References: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
 <1521046715-30683-7-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1521046715-30683-7-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>, Rob Herring <robh+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 14, 2018 at 05:58:16PM +0100, Ulf Hansson wrote:
> @@ -132,6 +133,15 @@ static inline ktime_t tick_nohz_get_sleep_length(void)
>  {
>  	return NSEC_PER_SEC / HZ;
>  }
> +
> +static inline ktime_t tick_nohz_get_next_wakeup(int cpu)
> +{
> +	ktime_t len = NSEC_PER_SEC/HZ;
> +
> +	/* Next wake up is the tick period, assume it starts now */
> +	return ktime_add(len, ktime_get());
> +}

Thsi could be marginally simpler as:

static inline ktime_t tick_nohz_get_next_wakeup(int cpu)
{
	/* Next wake up is the tick period, assume it starts now */
	return ktime_add(tick_nohz_get_sleep_length(), ktime_get());
}

Thanks,
Mark.
