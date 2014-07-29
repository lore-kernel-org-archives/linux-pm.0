From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v8 2/6] clk: samsung: add cpu clock configuration data
 and instantiate cpu clock
Date: Tue, 29 Jul 2014 12:13:46 +0200
Message-ID: <53D773DA.6050003@gmail.com>
References: <1406611711-25112-1-git-send-email-thomas.ab@samsung.com> <1406611711-25112-3-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:48937 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbaG2KNv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Jul 2014 06:13:51 -0400
In-Reply-To: <1406611711-25112-3-git-send-email-thomas.ab@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, t.figa@samsung.com, l.majewski@samsung.com, viresh.kumar@linaro.org, heiko@sntech.de, cw00.choi@samsung.com

Hi Thomas,

Just few minor comments for things I probably missed before.

On 29.07.2014 07:28, Thomas Abraham wrote:

[snip]

> @@ -1356,6 +1357,16 @@ static struct samsung_pll_clock exynos4x12_plls[nr_plls] __initdata = {
>  			VPLL_LOCK, VPLL_CON0, NULL),
>  };
>  
> +static const struct exynos_cpuclk_cfg_data e4210_armclk_d[] __initconst = {
> +	{ 1200000, E4210_CPU_DIV0(7, 1, 4, 3, 7, 3), E4210_CPU_DIV1(0, 5), },
> +	{ 1000000, E4210_CPU_DIV0(7, 1, 4, 3, 7, 3), E4210_CPU_DIV1(0, 4), },
> +	{  800000, E4210_CPU_DIV0(7, 1, 3, 3, 7, 3), E4210_CPU_DIV1(0, 3), },
> +	{  500000, E4210_CPU_DIV0(7, 1, 3, 3, 7, 3), E4210_CPU_DIV1(0, 3), },
> +	{  400000, E4210_CPU_DIV0(7, 1, 3, 3, 7, 3), E4210_CPU_DIV1(0, 3), },

I have noticed that the old driver does not have this operating point.
While it is probably OK to add this one and even few more for all
possible APLL settings, I am interested in how you obtained the values
for DIV0 and DIV1 registers for this configuration.

> +	{  200000, E4210_CPU_DIV0(0, 1, 1, 1, 3, 1), E4210_CPU_DIV1(0, 3), },
> +	{  0 },
> +};

[snip]

> diff --git a/include/dt-bindings/clock/exynos5250.h b/include/dt-bindings/clock/exynos5250.h
> index 4273891..855d809 100644
> --- a/include/dt-bindings/clock/exynos5250.h
> +++ b/include/dt-bindings/clock/exynos5250.h
> @@ -21,6 +21,7 @@
>  #define CLK_FOUT_CPLL		6
>  #define CLK_FOUT_EPLL		7
>  #define CLK_FOUT_VPLL		8
> +#define CLK_ARM_CLK		12

Why 12 not 9?

Best regards,
Tomasz
