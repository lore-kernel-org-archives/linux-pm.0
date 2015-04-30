From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH V2 linux-next] cpufreq: pxa: replace typedef pxa_freqs_t
 by structure
Date: Wed, 29 Apr 2015 21:46:41 -0700
Message-ID: <1430369201.2575.10.camel@perches.com>
References: <1430335980-9765-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0033.hostedemail.com ([216.40.44.33]:60190 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750871AbbD3Eqo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2015 00:46:44 -0400
In-Reply-To: <1430335980-9765-1-git-send-email-fabf@skynet.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

On Wed, 2015-04-29 at 21:32 +0200, Fabian Frederick wrote:
> typedef is not really useful here. Replace it by structure
> to improve readability.typedef should only be used in some cases.
> (See Documentation/CodingStyle Chapter 5 for details).

trivia:

> diff --git a/drivers/cpufreq/pxa2xx-cpufreq.c b/drivers/cpufreq/pxa2xx-cpufreq.c
[]
> @@ -86,7 +86,7 @@ static unsigned int sdram_rows;
>  /* Use the run mode frequencies for the CPUFREQ_POLICY_PERFORMANCE policy */
>  #define CCLKCFG			CCLKCFG_TURBO | CCLKCFG_FCS
>  
> -static pxa_freqs_t pxa255_run_freqs[] =
> +static struct pxa_freqs pxa255_run_freqs[] =

Should these be const?

>  {
>  	/* CPU   MEMBUS  CCCR  DIV2 CCLKCFG	           run  turbo PXbus SDRAM */
>  	{ 99500,  99500, 0x121, 1,  CCLKCFG, -1, -1},	/*  99,   99,   50,   50  */
> @@ -98,7 +98,7 @@ static pxa_freqs_t pxa255_run_freqs[] =
>  };
>  
>  /* Use the turbo mode frequencies for the CPUFREQ_POLICY_POWERSAVE policy */
> -static pxa_freqs_t pxa255_turbo_freqs[] =
> +static struct pxa_freqs pxa255_turbo_freqs[] =
>  {
>  	/* CPU   MEMBUS  CCCR  DIV2 CCLKCFG	   run  turbo PXbus SDRAM */
>  	{ 99500, 99500,  0x121, 1,  CCLKCFG, -1, -1},	/*  99,   99,   50,   50  */
> @@ -153,7 +153,7 @@ MODULE_PARM_DESC(pxa255_turbo_table, "Selects the frequency table (0 = run table
>     ((HT) ? CCLKCFG_HALFTURBO : 0) | \
>     ((T)  ? CCLKCFG_TURBO : 0))
>  
> -static pxa_freqs_t pxa27x_freqs[] = {
> +static struct pxa_freqs pxa27x_freqs[] = {
>  	{104000, 104000, PXA27x_CCCR(1,	 8, 2), 0, CCLKCFG2(1, 0, 1),  900000, 1705000 },
>  	{156000, 104000, PXA27x_CCCR(1,	 8, 3), 0, CCLKCFG2(1, 0, 1), 1000000, 1705000 },
>  	{208000, 208000, PXA27x_CCCR(0, 16, 2), 1, CCLKCFG2(0, 0, 1), 1180000, 1705000 },
> @@ -171,7 +171,7 @@ extern unsigned get_clk_frequency_khz(int info);
>  
>  #ifdef CONFIG_REGULATOR
>  
> -static int pxa_cpufreq_change_voltage(pxa_freqs_t *pxa_freq)
> +static int pxa_cpufreq_change_voltage(struct pxa_freqs *pxa_freq)
>  {
>  	int ret = 0;
>  	int vmin, vmax;
> @@ -202,7 +202,7 @@ static void __init pxa_cpufreq_init_voltages(void)
>  	}
>  }
>  #else
> -static int pxa_cpufreq_change_voltage(pxa_freqs_t *pxa_freq)
> +static int pxa_cpufreq_change_voltage(struct pxa_freqs *pxa_freq)
>  {
>  	return 0;
>  }
> @@ -211,7 +211,7 @@ static void __init pxa_cpufreq_init_voltages(void) { }
>  #endif
>  
>  static void find_freq_tables(struct cpufreq_frequency_table **freq_table,
> -			     pxa_freqs_t **pxa_freqs)
> +			     struct pxa_freqs **pxa_freqs)
>  {
>  	if (cpu_is_pxa25x()) {
>  		if (!pxa255_turbo_table) {
> @@ -270,7 +270,7 @@ static unsigned int pxa_cpufreq_get(unsigned int cpu)
>  static int pxa_set_target(struct cpufreq_policy *policy, unsigned int idx)
>  {
>  	struct cpufreq_frequency_table *pxa_freqs_table;
> -	pxa_freqs_t *pxa_freq_settings;
> +	struct pxa_freqs *pxa_freq_settings;
>  	unsigned long flags;
>  	unsigned int new_freq_cpu, new_freq_mem;
>  	unsigned int unused, preset_mdrefr, postset_mdrefr, cclkcfg;
> @@ -361,7 +361,7 @@ static int pxa_cpufreq_init(struct cpufreq_policy *policy)
>  	int i;
>  	unsigned int freq;
>  	struct cpufreq_frequency_table *pxa255_freq_table;
> -	pxa_freqs_t *pxa255_freqs;
> +	struct pxa_freqs *pxa255_freqs;
>  
>  	/* try to guess pxa27x cpu */
>  	if (cpu_is_pxa27x())
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



