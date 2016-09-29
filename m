From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/2] PM / devfreq: exynos-nocp: Select REGMAP_MMIO
Date: Thu, 29 Sep 2016 14:29:30 +0200
Message-ID: <9785239.FWYofzirS3@vostro.rjw.lan>
References: <1474805638-30407-1-git-send-email-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1474805638-30407-1-git-send-email-axel.lin@ingics.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, September 25, 2016 08:13:57 PM Axel Lin wrote:
> This driver uses devm_regmap_init_mmio(), so select REGMAP_MMIO to avoid
> build failure.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> v2: fix typo in commit log and also add Chanwoo's Ack.
> This one is a build fix, I think it should be for v4.8.
>  drivers/devfreq/event/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/devfreq/event/Kconfig b/drivers/devfreq/event/Kconfig
> index 0fdae86..cd94980 100644
> --- a/drivers/devfreq/event/Kconfig
> +++ b/drivers/devfreq/event/Kconfig
> @@ -17,6 +17,7 @@ config DEVFREQ_EVENT_EXYNOS_NOCP
>  	tristate "EXYNOS NoC (Network On Chip) Probe DEVFREQ event Driver"
>  	depends on ARCH_EXYNOS || COMPILE_TEST
>  	select PM_OPP
> +	select REGMAP_MMIO
>  	help
>  	  This add the devfreq-event driver for Exynos SoC. It provides NoC
>  	  (Network on Chip) Probe counters to measure the bandwidth of AXI bus.
> 

MyungJoo, I can apply this one and the [2/2] directly.  Should I do that?

Thanks,
Rafael
