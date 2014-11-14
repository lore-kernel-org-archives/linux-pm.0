From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 5/8] thermal:cpu cooling:tegra: Provide deferred probing
 for tegra driver
Date: Fri, 14 Nov 2014 12:24:37 +0100
Message-ID: <20141114122437.6742ea68@amdc2363>
References: <1411547232-21493-1-git-send-email-l.majewski@samsung.com>
 <1415898165-27406-1-git-send-email-l.majewski@samsung.com>
 <1415898165-27406-6-git-send-email-l.majewski@samsung.com>
 <5465DDC5.6090301@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:58181 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965074AbaKNLYs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Nov 2014 06:24:48 -0500
In-reply-to: <5465DDC5.6090301@kapsi.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux PM list <linux-pm@vger.kernel.org>, Vincenzo Frascino <vincenzo.frascino@st.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Mikko Perttunen <mperttunen@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Mikko,

> Tested-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>

Thanks for testing.

> 
> One potential issue I can see is that if the cpufreq driver fails to 
> probe then you'll never get the thermal driver either. For example, 
> Tegra124 currently has no cpufreq driver, so if CONFIG_CPU_THERMAL
> was enabled, then the soctherm driver would never be able to probe.

Yes, this is a potential issue. However, this option in tegra_defconfig
is by default disabled when thermal is enabled.

> But I don't really have a solution for this either.

Ok. I see.

> 
> Cheers,
> Mikko
> 
> On 11/13/2014 07:02 PM, Lukasz Majewski wrote:
> > When CPU freq is used as a thermal zone cooling device, one needs
> > to wait until cpufreq subsystem is properly initialized.
> >
> > This code is similar to the one already available in imx_thermal.c
> > file.
> >
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > ---
> >   drivers/thermal/tegra_soctherm.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/thermal/tegra_soctherm.c
> > b/drivers/thermal/tegra_soctherm.c index 70f7e9e..9c5aaa4 100644
> > --- a/drivers/thermal/tegra_soctherm.c
> > +++ b/drivers/thermal/tegra_soctherm.c
> > @@ -26,6 +26,7 @@
> >   #include <linux/platform_device.h>
> >   #include <linux/reset.h>
> >   #include <linux/thermal.h>
> > +#include <linux/cpufreq.h>
> >
> >   #include <soc/tegra/fuse.h>
> >
> > @@ -346,6 +347,12 @@ static int tegra_soctherm_probe(struct
> > platform_device *pdev)
> >
> >   	const struct tegra_tsensor *tsensors = t124_tsensors;
> >
> > +#ifdef CONFIG_CPU_THERMAL
> > +	if (!cpufreq_get_current_driver()) {
> > +		dev_dbg(&pdev->dev, "no cpufreq driver!");
> > +		return -EPROBE_DEFER;
> > +	}
> > +#endif
> >   	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra),
> > GFP_KERNEL); if (!tegra)
> >   		return -ENOMEM;
> >
> 



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
