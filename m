From: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v4 1/3] cpufreq: mediatek: Add support of cpufreq to
 MT2701/MT7623 SoC
Date: Thu, 13 Jul 2017 11:54:38 +0800
Message-ID: <1499918078.2392.14.camel@mtksdaap41>
References: <cover.1499692967.git.sean.wang@mediatek.com>
         <feabcfd53899954198c6620e9d9b68f4a3c55201.1499692967.git.sean.wang@mediatek.com>
         <1499741386.12408.11.camel@mtksdaap41>
         <12f23fb1-a145-bdf0-54c8-c2818ba75d9d@gmail.com>
         <20170713031614.GH1679@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170713031614.GH1679@vireshk-i7>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jamesjj.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, jdelvare-l3A5Bk7waGM@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2017-07-13 at 08:46 +0530, Viresh Kumar wrote:
> On 12-07-17, 16:50, Matthias Brugger wrote:
> > Hi Eddie,
> > 
> > On 07/11/2017 04:49 AM, Eddie Huang wrote:
> > >Hi Sean,
> > >
> > >On Mon, 2017-07-10 at 22:23 +0800, sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org wrote:
> > >>From: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > >>
> > >>MT2701/MT7623 is a 32-bit ARMv7 based quad-core (4 * Cortex-A7) with
> > >>single cluster and this hardware is also compatible with the existing
> > >>driver through enabling CPU frequency feature with operating-points-v2
> > >>bindings. Also, this driver actually supports all MediaTek SoCs, the
> > >>Kconfig menu entry and file name itself should be updated with more
> > >>generic name to drop "MT8173"
> > >>
> > >>Signed-off-by: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > >>Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > >>Reviewed-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> > >>---
> > >>  drivers/cpufreq/Kconfig.arm                              | 7 +++----
> > >>  drivers/cpufreq/Makefile                                 | 2 +-
> > >>  drivers/cpufreq/{mt8173-cpufreq.c => mediatek-cpufreq.c} | 2 ++
> > >>  3 files changed, 6 insertions(+), 5 deletions(-)
> > >>  rename drivers/cpufreq/{mt8173-cpufreq.c => mediatek-cpufreq.c} (99%)
> > >>
> > >
> > >As Viresh mentioned, there are already many drivers use "mtk" as
> 
> Do you have a link to when I mentioned this?
> 
> /me suffering from Amnesia ? :)

Sorry, my fault. It's from Jean. The link is 
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-July/517782.html

> 
> > >filename prefix or postfix.To align with those files, I suggest use
> > >mtk-cpufreq.c.I think there are not too many values to change all "mtk-"
> > >to "mediatek-", but it is worth to have the same naming rule for
> > >mediatek upstream driver.
> > >
> > 
> > In the last submission Jean proposed to change all file names from
> > mtk-*.[ch] to mediatek-*.[ch] as this will cause less confusion.
> > 
> > Viresh are you OK with that approach or do you prefer that we stay with mtk
> > prefix? I think it makes sense to have a unique prefix and resolve the
> > situation we now have with source files and Kconfig options.
> > But TBH I have no strong feeling for any of the two prefixes.
> 
> I am fine with both. Maybe don't resend for just that, mediatek
> doesn't sound any bad.

I am also fine with both. I think most people won't confuse about mtk
and mediatek. I don't like send patches to just only change filenames
and kconfig, especially kconfig modification will affect project
defconfigs. My point is we shouldn't spend much time on this topic, and
revisit filename when that driver need support new SoC, like this case.

Regards,
Eddie


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
