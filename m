From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/4] mfd: db8500-prcmu: Get rid of cpufreq dependency
Date: Mon, 14 Aug 2017 08:07:40 +0100
Message-ID: <20170814070740.eezm4wiilb25w7ze@dell>
References: <20170810125221.25818-1-linus.walleij@linaro.org>
 <20170810125221.25818-4-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35362 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbdHNHHx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Aug 2017 03:07:53 -0400
Received: by mail-wm0-f43.google.com with SMTP id m85so30877767wma.0
        for <linux-pm@vger.kernel.org>; Mon, 14 Aug 2017 00:07:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170810125221.25818-4-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>

On Thu, 10 Aug 2017, Linus Walleij wrote:

> The ARMSS clock, also known as the operating point of the
> CPU, should not cross-depend on cpufreq like this. Move
> the code to use just frequencies and remove the false
> frequency (1GHz) and put in the actual frequency provided
> by the ARMSS clock (998400000 Hz) as part of the process.
> 
> After this and the related cpufreq patch, the DB8500 will
> simply use the standard DT cpufreq driver to change the
> operating points through the common clock framework using
> the ARMSS clock.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Lee, this needs to be merged together with the other
> related cpufreq patches, so an ACK to take this through
> the cpufreq subsystem would be appreciated once you're
> pleased with it.
> ---
>  drivers/mfd/db8500-prcmu.c | 59 +++++++++++++---------------------------------
>  1 file changed, 17 insertions(+), 42 deletions(-)

Make sure this passes checkpatch.pl.

> diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
> index 5c739ac752e8..a66be0203ece 100644
> --- a/drivers/mfd/db8500-prcmu.c
> +++ b/drivers/mfd/db8500-prcmu.c
> @@ -33,7 +33,6 @@
>  #include <linux/mfd/abx500/ab8500.h>
>  #include <linux/regulator/db8500-prcmu.h>
>  #include <linux/regulator/machine.h>
> -#include <linux/cpufreq.h>
>  #include <linux/platform_data/ux500_wdt.h>
>  #include <linux/platform_data/db8500_thermal.h>
>  #include "dbx500-prcmu-regs.h"
> @@ -1692,32 +1691,22 @@ static long round_clock_rate(u8 clock, unsigned long rate)
>  	return rounded_rate;
>  }
>  
> -/* CPU FREQ table, may be changed due to if MAX_OPP is supported. */
> -static struct cpufreq_frequency_table db8500_cpufreq_table[] = {
> -	{ .frequency = 200000, .driver_data = ARM_EXTCLK,},
> -	{ .frequency = 400000, .driver_data = ARM_50_OPP,},
> -	{ .frequency = 800000, .driver_data = ARM_100_OPP,},
> -	{ .frequency = CPUFREQ_TABLE_END,}, /* To be used for MAX_OPP. */
> -	{ .frequency = CPUFREQ_TABLE_END,},
> -};
> +static const unsigned long armss_freqs[] = { 200000000, 400000000, 800000000, 998400000 };
>  
>  static long round_armss_rate(unsigned long rate)
>  {
> -	struct cpufreq_frequency_table *pos;
> -	long freq = 0;
> -
> -	/* cpufreq table frequencies is in KHz. */
> -	rate = rate / 1000;
> +	unsigned long freq = 0;
> +	int i;
>  
>  	/* Find the corresponding arm opp from the cpufreq table. */
> -	cpufreq_for_each_entry(pos, db8500_cpufreq_table) {
> -		freq = pos->frequency;
> -		if (freq == rate)
> +	for (i = 0; i < ARRAY_SIZE(armss_freqs); i++) {
> +		freq = armss_freqs[i];
> +		if (rate <= freq)
>  			break;
>  	}
>  
>  	/* Return the last valid value, even if a match was not found. */
> -	return freq * 1000;
> +	return freq;
>  }
>  
>  #define MIN_PLL_VCO_RATE 600000000ULL
> @@ -1854,21 +1843,23 @@ static void set_clock_rate(u8 clock, unsigned long rate)
>  
>  static int set_armss_rate(unsigned long rate)
>  {
> -	struct cpufreq_frequency_table *pos;
> -
> -	/* cpufreq table frequencies is in KHz. */
> -	rate = rate / 1000;
> +	unsigned long freq;
> +	u8 opps[] = { ARM_EXTCLK, ARM_50_OPP, ARM_100_OPP, ARM_MAX_OPP };
> +	int i;
>  
>  	/* Find the corresponding arm opp from the cpufreq table. */
> -	cpufreq_for_each_entry(pos, db8500_cpufreq_table)
> -		if (pos->frequency == rate)
> +	for (i = 0; i < ARRAY_SIZE(armss_freqs); i++) {
> +		freq = armss_freqs[i];
> +		if (rate == freq)
>  			break;
> +	}

Why don't you just call round_armss_rate()?

> -	if (pos->frequency != rate)
> +	if (rate != freq)
>  		return -EINVAL;
>  
>  	/* Set the new arm opp. */
> -	return db8500_prcmu_set_arm_opp(pos->driver_data);
> +	pr_debug("SET ARM OPP 0x%02x\n", opps[i]);

Add a '\n' here.

Once fixed please apply my:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
