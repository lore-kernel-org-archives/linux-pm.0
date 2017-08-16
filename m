From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/4] mfd: db8500-prcmu: Get rid of cpufreq dependency
Date: Wed, 16 Aug 2017 12:27:09 +0100
Message-ID: <20170816112709.zytzhykdbrikghkp@dell>
References: <20170810125221.25818-1-linus.walleij@linaro.org>
 <20170810125221.25818-4-linus.walleij@linaro.org>
 <20170814070740.eezm4wiilb25w7ze@dell>
 <CACRpkdZ=H0NNFcyXvZk2qqRSLqkSHwnUkyfx5EFtKVnPPgRCPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:35077 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751584AbdHPL1O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2017 07:27:14 -0400
Received: by mail-wr0-f180.google.com with SMTP id 49so4251902wrw.2
        for <linux-pm@vger.kernel.org>; Wed, 16 Aug 2017 04:27:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACRpkdZ=H0NNFcyXvZk2qqRSLqkSHwnUkyfx5EFtKVnPPgRCPw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>

On Wed, 16 Aug 2017, Linus Walleij wrote:

> On Mon, Aug 14, 2017 at 9:07 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Thu, 10 Aug 2017, Linus Walleij wrote:
> >
> >> The ARMSS clock, also known as the operating point of the
> >> CPU, should not cross-depend on cpufreq like this. Move
> >> the code to use just frequencies and remove the false
> >> frequency (1GHz) and put in the actual frequency provided
> >> by the ARMSS clock (998400000 Hz) as part of the process.
> >>
> >> After this and the related cpufreq patch, the DB8500 will
> >> simply use the standard DT cpufreq driver to change the
> >> operating points through the common clock framework using
> >> the ARMSS clock.
> >>
> >> Cc: Lee Jones <lee.jones@linaro.org>
> >> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> >>  drivers/mfd/db8500-prcmu.c | 59 +++++++++++++---------------------------------
> >>  1 file changed, 17 insertions(+), 42 deletions(-)
> >
> > Make sure this passes checkpatch.pl.
> 
> Sure thing :)
> $ scripts/checkpatch.pl
> cpufreq/0003-mfd-db8500-prcmu-Get-rid-of-cpufreq-dependency.patch
> total: 0 errors, 0 warnings, 112 lines checked
> 
> cpufreq/0003-mfd-db8500-prcmu-Get-rid-of-cpufreq-dependency.patch has
> no obvious style problems and is ready for submission.
>
Strange, this line looks way over 80 chars:

static const unsigned long armss_freqs[] = { 200000000, 400000000, 800000000, 998400000 };

Although when I look at it in Gmail, you appear to have a '\n' in
here, very odd.

Anyway, even if the '\n' is in there, please format it like:

static const unsigned long armss_freqs[] = {
	200000000,
	400000000,
	800000000,
	998400000
};


> >> +     int i;
> >>
> >>       /* Find the corresponding arm opp from the cpufreq table. */
> >> -     cpufreq_for_each_entry(pos, db8500_cpufreq_table)
> >> -             if (pos->frequency == rate)
> >> +     for (i = 0; i < ARRAY_SIZE(armss_freqs); i++) {
> >> +             freq = armss_freqs[i];
> >> +             if (rate == freq)
> >>                       break;
> >> +     }
> >
> > Why don't you just call round_armss_rate()?
> 
> It's because I need the index of the located frequency (i), and the other
> function due to being called from the clock framework has to have
> that simple signature.
> 
> > Once fixed please apply my:
> >
> > For my own reference:
> >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> OK thanks!
> 
> Yours,
> Linus Walleij

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
