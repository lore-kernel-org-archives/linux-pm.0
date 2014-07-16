From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH v3 5/7] PM / devfreq: exynos5250: migrate to common-clock
Date: Wed, 16 Jul 2014 13:03:40 +0200
Message-ID: <53C65C0C.10200@samsung.com>
References: <1400779322-4410-6-git-send-email-a.kesavan@samsung.com>
 <1405449332-26350-1-git-send-email-a.kesavan@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35506 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbaGPLET (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jul 2014 07:04:19 -0400
In-reply-to: <1405449332-26350-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Abhilash Kesavan <a.kesavan@samsung.com>, myungjoo.ham@samsung.com, linux-pm@vger.kernel.org, kgene.kim@samsung.com
Cc: rjw@sisk.pl, kesavan.abhilash@gmail.com, devicetree@vger.kernel.org

Hi Abhilash, Andrew,

Please see my comments inline.

On 15.07.2014 20:35, Abhilash Kesavan wrote:
> From: Andrew Bresticker <abrestic@chromium.org>
> 
> Use the common-clock framework to scale frequencies for the various
> peripheral clocks on the Exynos5250.
> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
>  drivers/devfreq/exynos/exynos5_bus.c |  131 ++++++++++++++++++++++++++++++----
>  1 file changed, 119 insertions(+), 12 deletions(-)

[snip]

> +
>  static struct int_bus_opp_table exynos5_int_opp_table[] = {
>  	{LV_0, 266000, 1025000},
>  	{LV_1, 200000, 1025000},
> @@ -75,6 +85,98 @@ static struct int_bus_opp_table exynos5_int_opp_table[] = {
>  	{0, 0, 0},
>  };
>  
> +static struct int_clk_table aclk_166[] = {
> +	{LV_0, 167000},
> +	{LV_1, 111000},
> +	{LV_2,  84000},
> +	{LV_3,  84000},
> +	{LV_4,  42000},
> +};

[snip]

> +static struct int_clk_table aclk_300_gscl[] = {
> +	{LV_0, 267000},
> +	{LV_1, 267000},
> +	{LV_2, 267000},
> +	{LV_3, 200000},
> +	{LV_4, 100000},
> +};

Shouldn't you manage this using OPP framework and parse this from DT?

> +
> +#define EXYNOS5_INT_CLK(name, tbl) {		\
> +	.clk_name = name,			\
> +	.freq_table = tbl,			\
> +}

[snip]

> @@ -320,16 +427,16 @@ static int exynos5_busfreq_int_probe(struct platform_device *pdev)
>  	rcu_read_unlock();
>  	data->curr_freq = initial_freq;
>  
> -	err = clk_set_rate(data->int_clk, initial_freq * 1000);
> +	err = exynos5_int_setvolt(data, initial_volt);
> +	if (err)
> +		return err;
> +
> +	err = exynos5_int_set_rate(data, initial_freq);
>  	if (err) {
>  		dev_err(dev, "Failed to set initial frequency\n");
>  		return err;
>  	}
>  
> -	err = exynos5_int_setvolt(data, initial_volt);
> -	if (err)
> -		return err;
> -

Whether voltage or rate should be set first depends on current settings
and initial_{freq,volt}. Also it might be more convenient to simply call
exynos5_busfreq_int_target() here.

Best regards,
Tomasz
