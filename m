From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 1/2] thermal: exynos: Fix wrong control of power down
 detection mode for Exynos7
Date: Wed, 25 Feb 2015 13:25:08 +0100
Message-ID: <20150225132508.5143c9cf@amdc2363>
References: <1424753815-15113-1-git-send-email-cw00.choi@samsung.com>
 <1424753815-15113-2-git-send-email-cw00.choi@samsung.com>
 <20150225100330.0ef63a95@amdc2363>
 <CAM4voakf6oeSEdtGtHRzQ-tC6XMbsU+VNtBnqeed8J4btKA3Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:51138 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbbBYMZU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Feb 2015 07:25:20 -0500
In-reply-to: <CAM4voakf6oeSEdtGtHRzQ-tC6XMbsU+VNtBnqeed8J4btKA3Yg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: l.majewski@majess.pl, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Eduardo,

> Hi Lukasz,
> 
> On Wed, Feb 25, 2015 at 2:33 PM, Lukasz Majewski
> <l.majewski@samsung.com> wrote:
> > Hi Abhilash,
> >
> >> This patch fixes the wrong control of PD_DET_EN (power down
> >> detection mode) for Exynos7 because exynos7_tmu_control() always
> >> enables the power down detection mode regardless 'on' parameter.
> >>
> >> Cc: Zhang Rui <rui.zhang@intel.com>
> >> Cc: Eduardo Valentin <edubezval@gmail.com>
> >> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> >> ---
> >>  drivers/thermal/samsung/exynos_tmu.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/thermal/samsung/exynos_tmu.c
> >> b/drivers/thermal/samsung/exynos_tmu.c index 933cd80..a60f527
> >> 100644 --- a/drivers/thermal/samsung/exynos_tmu.c
> >> +++ b/drivers/thermal/samsung/exynos_tmu.c
> >> @@ -682,6 +682,7 @@ static void exynos7_tmu_control(struct
> >> platform_device *pdev, bool on)
> >>       if (on) {
> >>               con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
> >> +             con |= (1 << EXYNOS7_PD_DET_EN_SHIFT);
> >>               interrupt_en =
> >>                       (of_thermal_is_trip_valid(tz, 7)
> >>                       << EXYNOS7_TMU_INTEN_RISE7_SHIFT) |
> >> @@ -704,9 +705,9 @@ static void exynos7_tmu_control(struct
> >> platform_device *pdev, bool on) interrupt_en <<
> >> EXYNOS_TMU_INTEN_FALL0_SHIFT; } else {
> >>               con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
> >> +             con &= ~(1 << EXYNOS7_PD_DET_EN_SHIFT);
> >>               interrupt_en = 0; /* Disable all interrupts */
> >>       }
> >> -     con |= 1 << EXYNOS7_PD_DET_EN_SHIFT;
> >>
> >>       writel(interrupt_en, data->base + EXYNOS7_TMU_REG_INTEN);
> >>       writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
> >
> > Could you test this patch if it isn't introducing any regression on
> > your HW?
> 
> The patch does not cause any regression on exynos7 and seems
> logically correct.
> 
> Tested-by: Abhilash Kesavan <a.kesavan@samsung.com>
> 

Eduardo, it is up to you if you prefer to take this fix directly or via
the new thermal-samsung tree ?

>From when shall I regard myself as a maintainer? :-)


> 
> Regards,
> Abhilash
> >
> > --
> > Best regards,
> >
> > Lukasz Majewski
> >
> > Samsung R&D Institute Poland (SRPOL) | Linux Platform Group


-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
