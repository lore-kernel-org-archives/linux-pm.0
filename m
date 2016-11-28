From: Markus Mayer <markus.mayer@broadcom.com>
Subject: Re: [PATCH v3] cpufreq: brcmstb-cpufreq: CPUfreq driver for older
 Broadcom STB SoCs
Date: Mon, 28 Nov 2016 13:07:27 -0800
Message-ID: <CAGt4E5ugNr4QtGQum4tftkhf5o9_+devhdSVetT4ZnnaESZQgQ@mail.gmail.com>
References: <20161122213245.17955-1-code@mmayer.net> <8526810.ogr5uYm3lV@wuerfel>
 <CAGt4E5vvNxoa-3SW-Gmoymy4AuLQfU_qckC8UQHyN=+0+EU2oA@mail.gmail.com> <5489387.Z7UgOxivrY@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5489387.Z7UgOxivrY@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Markus Mayer <code@mmayer.net>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Power Management List <linux-pm@vger.kernel.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 28 November 2016 at 12:58, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday, November 28, 2016 9:12:05 AM CET Markus Mayer wrote:
>> >> +static int get_frequencies(const struct cpufreq_policy *policy,
>> >> +                        unsigned int *vco_freq, unsigned int *cpu_freq,
>> >> +                        unsigned int *scb_freq)
>> >> +{
>> >> +     struct clk *cpu_ndiv_int, *sw_scb;
>> >> +
>> >> +     cpu_ndiv_int = __clk_lookup(BRCMSTB_CLK_NDIV_INT);
>> >> +     if (!cpu_ndiv_int)
>> >> +             return -ENODEV;
>> >> +
>> >> +     sw_scb = __clk_lookup(BRCMSTB_CLK_SW_SCB);
>> >> +     if (!sw_scb)
>> >> +             return -ENODEV;
>> >> +
>> >> +     /* return frequencies in kHz */
>> >> +     *vco_freq = clk_get_rate(cpu_ndiv_int) / 1000;
>> >> +     *cpu_freq = clk_get_rate(policy->clk) / 1000;
>> >> +     *scb_freq = clk_get_rate(sw_scb) / 1000;
>> >> +
>> >> +     return 0;
>> >> +}
>> >
>> > You really can't do this:
>> >
>> > ../drivers/cpufreq/brcmstb-cpufreq.c: In function 'get_frequencies':
>> > ../drivers/cpufreq/brcmstb-cpufreq.c:71:17: error: implicit declaration of function '__clk_lookup';did you mean 'key_lookup'? [-Werror=implicit-function-declaration]
>> >   cpu_ndiv_int = __clk_lookup(BRCMSTB_CLK_NDIV_INT);
>> >                  ^~~~~~~~~~~~
>> >
>> > __clk_lookup is an internal API for the clk providers.
>> >
>> > In particular, relying on undocumented internal names of the
>> > clk provider in a device driver is inappropriate.
>>
>> What compiler are you using? I didn't get any warnings. Otherwise I
>> would have known right away that something isn't right.
>
> This is a randconfig build with CONFIG_COMMON_CLK=n. There is a different
> problem with COMMON_CLK=y and the cpufreq driver as a loadable module,
> where the symbol causes a link error.
>
> I did not get any warnings either, these are both hard errors.
>
>> >> +static const struct of_device_id brcmstb_cpufreq_match[] = {
>> >> +     { .compatible = BRCMSTB_DT_CPU_CLK_CTRL },
>> >> +     { }
>> >> +};
>> >> +MODULE_DEVICE_TABLE(platform, brcmstb_cpufreq_match);
>> >
>> > This is a simple typo, also causing the build to fail:
>> >
>> >     FATAL: drivers/cpufreq/brcmstb-cpufreq: sizeof(struct platform_device_id)=24 is not a modulo of the size of section __mod_platform__<identifier>_device_table=392.
>>
>> What is the typo, if I may ask. Again strange, since the build doesn't
>> fail for me. What was the configuration you used?
>
> MODULE_DEVICE_TABLE() is only used when building a loadable module,
> e.g. in allmodconfig.
>
> MODULE_DEVICE_TABLE(platform, ...) is for 'struct platform_device_id'.
> You need to use MODULE_DEVICE_TABLE(of, ...) for 'struct of_device_id'.

Got it. Thanks.

I fixed this problem and the
IS_ENABLED(CONFIG_ARM_BRCMSTB_AVS_CPUFREQ) issue in my copy. I'll need
to look a bit more what I can do instead of calling __clk_lookup().

Regards,
-Markus
