From: Eric Nelson <eric.nelson@boundarydevices.com>
Subject: Re: [PATCH v3 1/2] cpufreq: add imx6q-cpufreq driver
Date: Mon, 14 Jan 2013 08:43:35 -0700
Message-ID: <50F427A7.7000203@boundarydevices.com>
References: <1358175733-13475-1-git-send-email-shawn.guo@linaro.org> <1358175733-13475-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36865 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757094Ab3ANPni (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jan 2013 10:43:38 -0500
Received: by mail-pa0-f45.google.com with SMTP id bg2so2290186pad.18
        for <linux-pm@vger.kernel.org>; Mon, 14 Jan 2013 07:43:38 -0800 (PST)
In-Reply-To: <1358175733-13475-2-git-send-email-shawn.guo@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@sisk.pl>

Hi Shawn,

On 01/14/2013 08:02 AM, Shawn Guo wrote:
> Add an imx6q-cpufreq driver for Freescale i.MX6Q SoC to handle the
> hardware specific frequency and voltage scaling requirements.
>
>
 > <snip>
 >
> --- /dev/null
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -0,0 +1,296 @@
>
> <snip>
>
> +
> +static int imx6q_set_target(struct cpufreq_policy *policy,
> +			    unsigned int target_freq, unsigned int relation)
> +{
>
> <snip>
>
> +
> +	/* scaling up?  scale voltage before frequency */
> +	if (freqs.new > freqs.old) {
> +		ret = regulator_set_voltage_tol(arm_reg, volt, 0);
> +		if (ret) {
> +			dev_err(cpu_dev, "failed to scale voltage up: %d\n", ret);
> +			return ret;
> +		}
> +
> +		/*
> +		 * Need to increase vddpu and vddsoc for safety
> +		 * if we are about to run at 1.2 GHz.
> +		 */
> +		if (freqs.new == FREQ_1P2_GHZ / 1000) {
> +			regulator_set_voltage_tol(pu_reg,
> +					PU_SOC_VOLTAGE_HIGH, 0);
> +			regulator_set_voltage_tol(soc_reg,
> +					PU_SOC_VOLTAGE_HIGH, 0);
> +		}

I believe you need a delay here to let the LDOs ramp before changing
the CPU frequency.

According to the i.MX6Q reference manual, with the factory default
step times in PMU_MISC2 and the maximum voltage swing is
	1.25V (1.2GHz) - 0.95V (400MHz) == 0.325V

or 13 steps at 25mV.

The default step time is 0.000021333s (512 clocks at 24MHz), so
the worst case delay needed is ~280uS.

This could also be done in the regulator driver, but that may
require multiple delays if multiple rails are changed.

Regards,


Eric
