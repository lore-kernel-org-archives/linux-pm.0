From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/4] cpufreq: cpufreq-cpu0: assign cpu_dev correctly to
 cpu0 device
Date: Wed, 11 Sep 2013 17:43:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1309111742290.26942@axis700.grange>
References: <1378835989-19281-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1378835989-19281-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:50792 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754840Ab3IKPnN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2013 11:43:13 -0400
In-Reply-To: <1378835989-19281-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-arm-kernel@lists.infradead.org

On Tue, 10 Sep 2013, Sudeep KarkadaNagesha wrote:

> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> Commit f837a9b5ab05c52a07108c6f09ca66f2e0aee757 "cpufreq: cpufreq-cpu0:
> remove device tree parsing for cpu nodes" assumed the pdev->dev is set to
> cpu0 device in the platform code. But it actually points to the virtual
> cpufreq-cpu0 platform device which is not present in the device tree.
> Most of the information needed by cpufreq is stored in cpu0 DT node.
> So cpu_dev must point to cpu0 device.
> 
> This patch fixes the wrong assignment to cpu_dev.
> 
> Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Tested-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Thanks
Guennadi

> ---
>  drivers/cpufreq/cpufreq-cpu0.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.=
> c
> index cbfffa9..78c49d8 100644
> --- a/drivers/cpufreq/cpufreq-cpu0.c
> +++ b/drivers/cpufreq/cpufreq-cpu0.c
> @@ -12,6 +12,7 @@
>  #define pr_fmt(fmt)=09KBUILD_MODNAME ": " fmt
> =20
>  #include <linux/clk.h>
> +#include <linux/cpu.h>
>  #include <linux/cpufreq.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
> @@ -177,7 +178,11 @@ static int cpu0_cpufreq_probe(struct platform_device *=
> pdev)
>  =09struct device_node *np;
>  =09int ret;
> =20
> -=09cpu_dev =3D &pdev->dev;
> +=09cpu_dev =3D get_cpu_device(0);
> +=09if (!cpu_dev) {
> +=09=09pr_err("failed to get cpu0 device\n");
> +=09=09return -ENODEV;
> +=09}
> =20
>  =09np =3D of_node_get(cpu_dev->of_node);
>  =09if (!np) {
> --=20
> 1.8.1.2
> 
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
