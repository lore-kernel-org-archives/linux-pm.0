From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH] PM / devfreq: rockchip: add PM_DEVFREQ_EVENT dependency
Date: Fri, 16 Sep 2016 21:26:02 +0900
Message-ID: <CAGTfZH2UsAGMAuysRH5Cg7FTQQpSndnCmwdjott8p-GS=CXdSA@mail.gmail.com>
References: <20160915154513.3006199-1-arnd@arndb.de>
Reply-To: chanwoo@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160915154513.3006199-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Lin Huang <hl@rock-chips.com>, Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Arnd,

Looks good to me.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Best Regards,
Chanwoo Choi

2016-09-16 0:44 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> The newly added ARM_RK3399_DMC_DEVFREQ driver requires the
> DEVFREQ_EVENT_ROCKCHIP_DFI driver and tries to turn that on through
> a 'select' statement, and that in turn has a dependency on
> PM_DEVFREQ_EVENT, which may be disabled here:
>
> warning: (ARM_RK3399_DMC_DEVFREQ) selects DEVFREQ_EVENT_ROCKCHIP_DFI which has unmet direct dependencies (PM_DEVFREQ && PM_DEVFREQ_EVENT && ARCH_ROCKCHIP)
>
> We probably want a 'depends on' here, but other drivers use 'select'
> too, so for consistency I'm doing the same.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 5a893e31a636 ("PM / devfreq: rockchip: add devfreq driver for rk3399 dmc")
> ---
>  drivers/devfreq/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 93b6ada06676..41254e702f1e 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -105,6 +105,7 @@ config ARM_RK3399_DMC_DEVFREQ
>         depends on ARCH_ROCKCHIP
>         select DEVFREQ_EVENT_ROCKCHIP_DFI
>         select DEVFREQ_GOV_SIMPLE_ONDEMAND
> +       select PM_DEVFREQ_EVENT
>         select PM_OPP
>         help
>            This adds the DEVFREQ driver for the RK3399 DMC(Dynamic Memory Controller).
> --
> 2.9.0
>
