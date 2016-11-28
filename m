From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] cpufreq: brcmstb-cpufreq: CPUfreq driver for older Broadcom STB SoCs
Date: Mon, 28 Nov 2016 21:58:53 +0100
Message-ID: <5489387.Z7UgOxivrY@wuerfel>
References: <20161122213245.17955-1-code@mmayer.net> <8526810.ogr5uYm3lV@wuerfel> <CAGt4E5vvNxoa-3SW-Gmoymy4AuLQfU_qckC8UQHyN=+0+EU2oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:55779 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754808AbcK1U7D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2016 15:59:03 -0500
In-Reply-To: <CAGt4E5vvNxoa-3SW-Gmoymy4AuLQfU_qckC8UQHyN=+0+EU2oA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Markus Mayer <markus.mayer@broadcom.com>
Cc: Markus Mayer <code@mmayer.net>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Power Management List <linux-pm@vger.kernel.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Monday, November 28, 2016 9:12:05 AM CET Markus Mayer wrote:
> >> +static int get_frequencies(const struct cpufreq_policy *policy,
> >> +                        unsigned int *vco_freq, unsigned int *cpu_freq,
> >> +                        unsigned int *scb_freq)
> >> +{
> >> +     struct clk *cpu_ndiv_int, *sw_scb;
> >> +
> >> +     cpu_ndiv_int = __clk_lookup(BRCMSTB_CLK_NDIV_INT);
> >> +     if (!cpu_ndiv_int)
> >> +             return -ENODEV;
> >> +
> >> +     sw_scb = __clk_lookup(BRCMSTB_CLK_SW_SCB);
> >> +     if (!sw_scb)
> >> +             return -ENODEV;
> >> +
> >> +     /* return frequencies in kHz */
> >> +     *vco_freq = clk_get_rate(cpu_ndiv_int) / 1000;
> >> +     *cpu_freq = clk_get_rate(policy->clk) / 1000;
> >> +     *scb_freq = clk_get_rate(sw_scb) / 1000;
> >> +
> >> +     return 0;
> >> +}
> >
> > You really can't do this:
> >
> > ../drivers/cpufreq/brcmstb-cpufreq.c: In function 'get_frequencies':
> > ../drivers/cpufreq/brcmstb-cpufreq.c:71:17: error: implicit declaration of function '__clk_lookup';did you mean 'key_lookup'? [-Werror=implicit-function-declaration]
> >   cpu_ndiv_int = __clk_lookup(BRCMSTB_CLK_NDIV_INT);
> >                  ^~~~~~~~~~~~
> >
> > __clk_lookup is an internal API for the clk providers.
> >
> > In particular, relying on undocumented internal names of the
> > clk provider in a device driver is inappropriate.
> 
> What compiler are you using? I didn't get any warnings. Otherwise I
> would have known right away that something isn't right.

This is a randconfig build with CONFIG_COMMON_CLK=n. There is a different
problem with COMMON_CLK=y and the cpufreq driver as a loadable module,
where the symbol causes a link error.

I did not get any warnings either, these are both hard errors.

> >> +static const struct of_device_id brcmstb_cpufreq_match[] = {
> >> +     { .compatible = BRCMSTB_DT_CPU_CLK_CTRL },
> >> +     { }
> >> +};
> >> +MODULE_DEVICE_TABLE(platform, brcmstb_cpufreq_match);
> >
> > This is a simple typo, also causing the build to fail:
> >
> >     FATAL: drivers/cpufreq/brcmstb-cpufreq: sizeof(struct platform_device_id)=24 is not a modulo of the size of section __mod_platform__<identifier>_device_table=392.
> 
> What is the typo, if I may ask. Again strange, since the build doesn't
> fail for me. What was the configuration you used?

MODULE_DEVICE_TABLE() is only used when building a loadable module,
e.g. in allmodconfig.

MODULE_DEVICE_TABLE(platform, ...) is for 'struct platform_device_id'.
You need to use MODULE_DEVICE_TABLE(of, ...) for 'struct of_device_id'.

	Arnd
