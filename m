From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V3] cpufreq: cpufreq-cpu0: defer probe when regulator is not ready
Date: Thu, 02 May 2013 23:17:46 +0200
Message-ID: <5719082.lcBc7IQZVf@vostro.rjw.lan>
References: <1367415492-20956-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:55567 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757189Ab3EBVJ3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 2 May 2013 17:09:29 -0400
In-Reply-To: <1367415492-20956-1-git-send-email-nm@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

On Wednesday, May 01, 2013 08:38:12 AM Nishanth Menon wrote:
> With commit 1e4b545, regulator_get will now return -EPROBE_DEFER
> when the cpu0-supply node is present, but the regulator is not yet
> registered.
> 
> It is possible for this to occur when the regulator registration
> by itself might be defered due to some dependent interface not yet
> instantiated. For example: an regulator which uses I2C and GPIO might
> need both systems available before proceeding, in this case, the
> regulator might defer it's registration.
> 
> However, the cpufreq-cpu0 driver assumes that any un-successful return
> result is equivalent of failure.
> 
> When the regulator_get returns failure other than -EPROBE_DEFER, it
> makes sense to assume that supply node is not present and proceed with
> the assumption that only clock control is necessary in the platform.
> 
> With this change, we can now handle the following conditions:
> a) cpu0-supply binding is not present, regulator_get will return
> appropriate error result, resulting in cpufreq-cpu0 driver controlling
> just the clock.
> b) cpu0-supply binding is present, regulator_get returns
> -EPROBE_DEFER, we retry resulting in cpufreq-cpu0 driver registering
> later once the regulator is available.
> c) cpu0-supply binding is present, regulator_get returns
> -EPROBE_DEFER, however, regulator never registers, we retry until
> cpufreq-cpu0 driver fails to register pointing at device tree
> information bug. However, in this case, the fact that cpufreq-cpu0
> operates with clock only when the DT binding clearly indicates need of
> a supply is a bug of it's own.
> d) cpu0-supply gets an regulator at probe - cpufreq-cpu0 driver
> controls both the clock and regulator
> 
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Nishanth Menon <nm@ti.com>

I've queued this up for the v3.10-rc2 push.

Thanks,
Rafael


> ---
> V3: Changes since V1 (for 3.10-rc2?)
> 	review comment updates (and dropped Viresh's original ack ;) ).
>    	Now that regulator patch https://patchwork.kernel.org/patch/2451211/
> 	has been merged to master
> 	based on git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm+acpi-3.10-rc1
> 
> V2: https://patchwork.kernel.org/patch/2505311/
> V1: https://patchwork.kernel.org/patch/2396541/
> 
>  drivers/cpufreq/cpufreq-cpu0.c |   22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
> index 3ab8294..ecd8af9 100644
> --- a/drivers/cpufreq/cpufreq-cpu0.c
> +++ b/drivers/cpufreq/cpufreq-cpu0.c
> @@ -195,6 +195,22 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
>  	cpu_dev = &pdev->dev;
>  	cpu_dev->of_node = np;
>  
> +	cpu_reg = devm_regulator_get(cpu_dev, "cpu0");
> +	if (IS_ERR(cpu_reg)) {
> +		/*
> +		 * If cpu0 regulator supply node is present, but regulator is
> +		 * not yet registered, we should try defering probe.
> +		 */
> +		if (PTR_ERR(cpu_reg) == -EPROBE_DEFER) {
> +			dev_err(cpu_dev, "cpu0 regulator not ready, retry\n");
> +			ret = -EPROBE_DEFER;
> +			goto out_put_node;
> +		}
> +		pr_warn("failed to get cpu0 regulator: %ld\n",
> +			PTR_ERR(cpu_reg));
> +		cpu_reg = NULL;
> +	}
> +
>  	cpu_clk = devm_clk_get(cpu_dev, NULL);
>  	if (IS_ERR(cpu_clk)) {
>  		ret = PTR_ERR(cpu_clk);
> @@ -202,12 +218,6 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
>  		goto out_put_node;
>  	}
>  
> -	cpu_reg = devm_regulator_get(cpu_dev, "cpu0");
> -	if (IS_ERR(cpu_reg)) {
> -		pr_warn("failed to get cpu0 regulator\n");
> -		cpu_reg = NULL;
> -	}
> -
>  	ret = of_init_opp_table(cpu_dev);
>  	if (ret) {
>  		pr_err("failed to init OPP table: %d\n", ret);
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
