From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH RFC 15/27] PM / Domains: Add next_wakeup to device's timing data
Date: Thu, 19 Nov 2015 14:19:57 -0800
Message-ID: <7h8u5ttywi.fsf@deeprootsystems.com>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
	<1447799871-56374-16-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1447799871-56374-16-git-send-email-lina.iyer@linaro.org> (Lina
	Iyer's message of "Tue, 17 Nov 2015 15:37:39 -0700")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com
List-Id: linux-pm@vger.kernel.org

Lina Iyer <lina.iyer@linaro.org> writes:

> Allow devices that know when their next wakeup event is, to record save
> it as part of timing data. A genpd governor may use this data to
> determine if suspending the domain is going to affect the QoS of its
> devices.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  include/linux/pm_domain.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index f1329ea..9ac089d 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -16,6 +16,7 @@
>  #include <linux/of.h>
>  #include <linux/notifier.h>
>  #include <linux/spinlock.h>
> +#include <linux/ktime.h>
>  
>  /* Defines used for the flags field in the struct generic_pm_domain */
>  #define GENPD_FLAG_PM_CLK	(1U << 0) /* PM domain uses PM clk */
> @@ -104,6 +105,7 @@ struct gpd_timing_data {
>  	s64 effective_constraint_ns;
>  	bool constraint_changed;
>  	bool cached_stop_ok;
> +	ktime_t next_wakeup;
>  };

The addition of a new field should be combined with the patch that uses
it (e.g. PATCH 16/27)

Kevin
