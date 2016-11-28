From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3] cpufreq: brcmstb-cpufreq: CPUfreq driver for older
 Broadcom STB SoCs
Date: Mon, 28 Nov 2016 14:29:28 +0100
Message-ID: <CAJZ5v0gq1xDSSiD42Lnwv3uyVjmr7owCiU1zkDif6kB0zc8HHA@mail.gmail.com>
References: <20161122213245.17955-1-code@mmayer.net> <8526810.ogr5uYm3lV@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wj0-f193.google.com ([209.85.210.193]:35278 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932127AbcK1N3a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2016 08:29:30 -0500
In-Reply-To: <8526810.ogr5uYm3lV@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Markus Mayer <code@mmayer.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Power Management List <linux-pm@vger.kernel.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Markus Mayer <mmayer@broadcom.com>

On Mon, Nov 28, 2016 at 11:14 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday, November 22, 2016 1:32:45 PM CET Markus Mayer wrote:
>> From: Markus Mayer <mmayer@broadcom.com>
>>
>> This CPUfreq driver provides basic frequency scaling for older Broadcom
>> STB SoCs that do not use AVS firmware with DVFS support. There is no
>> support for voltage scaling.
>>
>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> This causes multiple build errors in linux-next, please fix asap or
> drop the patch again. My feeling is that it's probably too late to
> fix it for v4.10, but that's up to Viresh and Rafael of course.
>
>> +#define BRCMSTB_CPUFREQ_PREFIX       "brcmstb"
>> +#define BRCMSTB_CPUFREQ_NAME BRCMSTB_CPUFREQ_PREFIX "-cpufreq"
>> +
>> +/* We search for these compatible strings. */
>> +#define BRCMSTB_DT_CPU_CLK_CTRL      "brcm,brcmstb-cpu-clk-div"
>> +#define BRCMSTB_DT_MEMC_DDR  "brcm,brcmstb-memc-ddr"
>> +#define BRCM_AVS_CPU_DATA    "brcm,avs-cpu-data-mem"
>> +
>> +/* We also need a few clocks in device tree. These are node names. */
>> +#define BRCMSTB_CLK_MDIV_CH0 "cpu_mdiv_ch0"
>> +#define BRCMSTB_CLK_NDIV_INT "cpu_ndiv_int"
>> +#define BRCMSTB_CLK_SW_SCB   "sw_scb"
>
> Not critical but the use of those macros obfuscates the DT interfaces
> here and made it harder to analyse what was going on.
>
> Also, a couple of them are lacking a DT binding.
>
>> +static int get_frequencies(const struct cpufreq_policy *policy,
>> +                        unsigned int *vco_freq, unsigned int *cpu_freq,
>> +                        unsigned int *scb_freq)
>> +{
>> +     struct clk *cpu_ndiv_int, *sw_scb;
>> +
>> +     cpu_ndiv_int = __clk_lookup(BRCMSTB_CLK_NDIV_INT);
>> +     if (!cpu_ndiv_int)
>> +             return -ENODEV;
>> +
>> +     sw_scb = __clk_lookup(BRCMSTB_CLK_SW_SCB);
>> +     if (!sw_scb)
>> +             return -ENODEV;
>> +
>> +     /* return frequencies in kHz */
>> +     *vco_freq = clk_get_rate(cpu_ndiv_int) / 1000;
>> +     *cpu_freq = clk_get_rate(policy->clk) / 1000;
>> +     *scb_freq = clk_get_rate(sw_scb) / 1000;
>> +
>> +     return 0;
>> +}
>
> You really can't do this:
>
> ../drivers/cpufreq/brcmstb-cpufreq.c: In function 'get_frequencies':
> ../drivers/cpufreq/brcmstb-cpufreq.c:71:17: error: implicit declaration of function '__clk_lookup';did you mean 'key_lookup'? [-Werror=implicit-function-declaration]
>   cpu_ndiv_int = __clk_lookup(BRCMSTB_CLK_NDIV_INT);
>                  ^~~~~~~~~~~~
>
> __clk_lookup is an internal API for the clk providers.
>
> In particular, relying on undocumented internal names of the
> clk provider in a device driver is inappropriate.
>
>> +static const struct of_device_id brcmstb_cpufreq_match[] = {
>> +     { .compatible = BRCMSTB_DT_CPU_CLK_CTRL },
>> +     { }
>> +};
>> +MODULE_DEVICE_TABLE(platform, brcmstb_cpufreq_match);
>
> This is a simple typo, also causing the build to fail:
>
>     FATAL: drivers/cpufreq/brcmstb-cpufreq: sizeof(struct platform_device_id)=24 is not a modulo of the size of section __mod_platform__<identifier>_device_table=392.
>

I've dropped the patch.

Markus, please fix the problems pointed out by Arnd and resend.

Thanks,
Rafael
