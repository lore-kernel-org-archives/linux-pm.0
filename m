From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Touchscreen failure with CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
Date: Fri, 21 Apr 2017 23:33:01 +0200
Message-ID: <1593358.0FdoGjUNcl@aspire.rjw.lan>
References: <CAOMZO5BZ8Z8dfwsfuiunNQ_q39_k4QJg7jLPQfaxn+YBsmz2jw@mail.gmail.com> <1998934.0RuxqCUAOW@aspire.rjw.lan> <CAOMZO5C776E3AqnhPPJSTF=atuOHi5Mok7F7yocBhRsJ6Ror2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50775 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1162977AbdDUVjJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Apr 2017 17:39:09 -0400
In-Reply-To: <CAOMZO5C776E3AqnhPPJSTF=atuOHi5Mok7F7yocBhRsJ6Ror2A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: viresh kumar <viresh.kumar@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Friday, April 21, 2017 06:37:31 PM Fabio Estevam wrote:
> On Fri, Apr 21, 2017 at 6:28 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Friday, April 21, 2017 01:11:52 PM Fabio Estevam wrote:
> >> Hi,
> >>
> >> Running 4.11-rc7 on a imx6q-sabresd board I notice that egalax
> >> touchscreen stops generating evtest events after a random period of
> >> time.
> >>
> >> This problem can be avoided if I unselect CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND:
> >>
> >> --- a/arch/arm/configs/imx_v6_v7_defconfig
> >> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> >> @@ -54,7 +54,6 @@ CONFIG_CMA=y
> >>  CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
> >>  CONFIG_KEXEC=y
> >>  CONFIG_CPU_FREQ=y
> >> -CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
> >>  CONFIG_ARM_IMX6Q_CPUFREQ=y
> >>  CONFIG_CPU_IDLE=y
> >>  CONFIG_VFP=y
> >>
> >> With this change evtest always capture all touchscreen events. No
> >> single failure is seen.
> >>
> >> I could see the same behavior with all mainline kernels I tested (4.9 and 4.10).
> >>
> >> Any ideas as to how fix this bug when CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y?
> >
> > And which governor is the default otherwise?
> 
> When CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y is removed then the
> 'performance' governor is the default.

There you go.  Apparently, using frequencies below the max causes problems to
happen in the SoC.

Thanks,
Rafael
