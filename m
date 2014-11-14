From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: Re: [PATCH 5/8] thermal:cpu cooling:tegra: Provide deferred probing
 for tegra driver
Date: Fri, 14 Nov 2014 12:47:33 +0200
Message-ID: <5465DDC5.6090301@kapsi.fi>
References: <1411547232-21493-1-git-send-email-l.majewski@samsung.com> <1415898165-27406-1-git-send-email-l.majewski@samsung.com> <1415898165-27406-6-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:35560 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934378AbaKNKrq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 14 Nov 2014 05:47:46 -0500
In-Reply-To: <1415898165-27406-6-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux PM list <linux-pm@vger.kernel.org>, Vincenzo Frascino <vincenzo.frascino@st.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Mikko Perttunen <mperttunen@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org

Tested-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>

One potential issue I can see is that if the cpufreq driver fails to 
probe then you'll never get the thermal driver either. For example, 
Tegra124 currently has no cpufreq driver, so if CONFIG_CPU_THERMAL was 
enabled, then the soctherm driver would never be able to probe. But I 
don't really have a solution for this either.

Cheers,
Mikko

On 11/13/2014 07:02 PM, Lukasz Majewski wrote:
> When CPU freq is used as a thermal zone cooling device, one needs to wait
> until cpufreq subsystem is properly initialized.
>
> This code is similar to the one already available in imx_thermal.c file.
>
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
>   drivers/thermal/tegra_soctherm.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/thermal/tegra_soctherm.c b/drivers/thermal/tegra_soctherm.c
> index 70f7e9e..9c5aaa4 100644
> --- a/drivers/thermal/tegra_soctherm.c
> +++ b/drivers/thermal/tegra_soctherm.c
> @@ -26,6 +26,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/reset.h>
>   #include <linux/thermal.h>
> +#include <linux/cpufreq.h>
>
>   #include <soc/tegra/fuse.h>
>
> @@ -346,6 +347,12 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
>
>   	const struct tegra_tsensor *tsensors = t124_tsensors;
>
> +#ifdef CONFIG_CPU_THERMAL
> +	if (!cpufreq_get_current_driver()) {
> +		dev_dbg(&pdev->dev, "no cpufreq driver!");
> +		return -EPROBE_DEFER;
> +	}
> +#endif
>   	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
>   	if (!tegra)
>   		return -ENOMEM;
>

