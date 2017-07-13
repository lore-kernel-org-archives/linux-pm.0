From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 1/3] cpufreq: mediatek: Add support of cpufreq to
 MT2701/MT7623 SoC
Date: Thu, 13 Jul 2017 08:46:14 +0530
Message-ID: <20170713031614.GH1679@vireshk-i7>
References: <cover.1499692967.git.sean.wang@mediatek.com>
 <feabcfd53899954198c6620e9d9b68f4a3c55201.1499692967.git.sean.wang@mediatek.com>
 <1499741386.12408.11.camel@mtksdaap41>
 <12f23fb1-a145-bdf0-54c8-c2818ba75d9d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <12f23fb1-a145-bdf0-54c8-c2818ba75d9d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Eddie Huang <eddie.huang@mediatek.com>, sean.wang@mediatek.com, robh+dt@kernel.org, mark.rutland@arm.com, jamesjj.liao@mediatek.com, p.zabel@pengutronix.de, shunli.wang@mediatek.com, erin.lo@mediatek.com, jdelvare@suse.de, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
List-Id: linux-pm@vger.kernel.org

On 12-07-17, 16:50, Matthias Brugger wrote:
> Hi Eddie,
> 
> On 07/11/2017 04:49 AM, Eddie Huang wrote:
> >Hi Sean,
> >
> >On Mon, 2017-07-10 at 22:23 +0800, sean.wang@mediatek.com wrote:
> >>From: Sean Wang <sean.wang@mediatek.com>
> >>
> >>MT2701/MT7623 is a 32-bit ARMv7 based quad-core (4 * Cortex-A7) with
> >>single cluster and this hardware is also compatible with the existing
> >>driver through enabling CPU frequency feature with operating-points-v2
> >>bindings. Also, this driver actually supports all MediaTek SoCs, the
> >>Kconfig menu entry and file name itself should be updated with more
> >>generic name to drop "MT8173"
> >>
> >>Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> >>Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >>Reviewed-by: Jean Delvare <jdelvare@suse.de>
> >>---
> >>  drivers/cpufreq/Kconfig.arm                              | 7 +++----
> >>  drivers/cpufreq/Makefile                                 | 2 +-
> >>  drivers/cpufreq/{mt8173-cpufreq.c => mediatek-cpufreq.c} | 2 ++
> >>  3 files changed, 6 insertions(+), 5 deletions(-)
> >>  rename drivers/cpufreq/{mt8173-cpufreq.c => mediatek-cpufreq.c} (99%)
> >>
> >
> >As Viresh mentioned, there are already many drivers use "mtk" as

Do you have a link to when I mentioned this?

/me suffering from Amnesia ? :)

> >filename prefix or postfix.To align with those files, I suggest use
> >mtk-cpufreq.c.I think there are not too many values to change all "mtk-"
> >to "mediatek-", but it is worth to have the same naming rule for
> >mediatek upstream driver.
> >
> 
> In the last submission Jean proposed to change all file names from
> mtk-*.[ch] to mediatek-*.[ch] as this will cause less confusion.
> 
> Viresh are you OK with that approach or do you prefer that we stay with mtk
> prefix? I think it makes sense to have a unique prefix and resolve the
> situation we now have with source files and Kconfig options.
> But TBH I have no strong feeling for any of the two prefixes.

I am fine with both. Maybe don't resend for just that, mediatek
doesn't sound any bad.

-- 
viresh
