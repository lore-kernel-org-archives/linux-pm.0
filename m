From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 0/4] Add TMU support for Exynos7
Date: Tue, 18 Nov 2014 09:08:26 +0100
Message-ID: <20141118090826.26056436@amdc2363>
References: <1415963882-3460-1-git-send-email-a.kesavan@samsung.com>
 <2756804.O2Zby5SkUf@amdc1032>
 <CAM4voannFHau+TSufpN-rsp4TpSFSK0kKx6QtccNtFW9hO5i+Q@mail.gmail.com>
 <20141114140202.014e1b82@amdc2363>
 <CAM4voanZz-q4d7TXQdcTGYkvYGxBmCjHMbpK29rMwoPS6L_c8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:23375 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbaKRIIk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Nov 2014 03:08:40 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NF8005HD6MCJ590@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 18 Nov 2014 17:08:36 +0900 (KST)
In-reply-to: <CAM4voanZz-q4d7TXQdcTGYkvYGxBmCjHMbpK29rMwoPS6L_c8A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, rui.zhang@intel.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, amit.daniel@samsung.com

Hi Abhilash,

> Hi Lukasz,
> 
> On Fri, Nov 14, 2014 at 6:32 PM, Lukasz Majewski
> <l.majewski@samsung.com> wrote:
> > Hi Abhilash,
> >
> >> Hi Bartlomiej,
> >>
> >> On Fri, Nov 14, 2014 at 5:49 PM, Bartlomiej Zolnierkiewicz
> >> <b.zolnierkie@samsung.com> wrote:
> >> >
> >> > Hi,
> >> >
> >> > On Friday, November 14, 2014 04:47:58 PM Abhilash Kesavan wrote:
> >> >> The Thermal Management Unit (TMU) in Exynos7 provides
> >> >> software-controlled (thermal throttling) and hardware-controlled
> >> >> (thermal tripping) management schemes.
> >> >> There are several changes in terms of the register and bit
> >> >> offsets in the Exynos7 TMU from that in older SoCs. There are
> >> >> also new bits, more trigger levels and a special clock for TMU
> >> >> that has been introduced in Exynos7. This patchset modifies the
> >> >> thermal driver to handle all these changes.
> >> >>
> >> >> This series is based on linux-next(20141114) and tested on an
> >> >> Exynos7-based espresso board.
> >> >
> >> > Please rebase your patchset on top of:
> >> >
> >> >   http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg38717.html
> >>
> >> Sure, will rebase on top of your patchset. Is this patchset going
> >> to be merged into Eduardo's tree soon ?
> >>
> >> >
> >> > There is also ongoing work to convert Exynos thermal driver to
> >> > use device tree but Lukasz Majewski (added to Cc:) knows better
> >> > the current state of the work.
> >>
> >> Lukasz, are you in the process of making changes to the existing
> >> exynos tmu bindings ?
> >
> > Yes. I'm working on them.
> >
> > Please consider following patches [1]:
> > http://www.spinics.net/lists/linux-samsung-soc/msg37719.html
> >
> > They are based on top of Bartek's work.
> > Patch set status:
> > 1. Fixes for thermal_core (with -EPROBE_DEFER) - v2 posted
> > yesterday.
> > http://www.spinics.net/lists/linux-samsung-soc/msg37719.html
> >
> > 2. of-thermal rework - I'm working on it now (to export common data
> > from of-thermal.c and provide structure with ops).
> >
> > Patches [1] replace configuration available in exynos_tmu_data.c to
> > the one from device tree. Also it handles setting cpu cooling
> > frequencies per CPUs via device tree.
> >
> >
> > I think that it is Eduardo's decision about how Exynos patches
> > should be serialized.
> >
> > I can only say that after Bartek's and my [1] patch sets the exynos
> > TMU driver is much simpler with significant code base reduction.
> >
> > Personally I think that it may be far more easier to add Exynos7 TMU
> > support to reworked driver.
> 
> Thanks for the details. I am OK with rebasing my patches over
> Bartlomiej and your patch sets. Do you have any public tree with both
> these patch sets merged ?

I've managed to export my ongoing Exynos TMU work to a public tree.
You can find it at:
https://git.linaro.org/people/marek.szyprowski/linux-srpol.git/shortlog/refs/heads/v3.18-ti-soc-thermal


Please be aware that this code is under development (and review) and
some parts may be changed.

However, this shows how the Exynos TMU driver would look like after the
rework.

If in any doubts, please ask.

> >
> >
> >>
> >> Regards,
> >> Abhilash
> >> >
> >> >> Abhilash Kesavan (4):
> >> >>   thermal: exynos: add optional sclk support
> >> >>   thermal: exynos: add a triminfo_mask field in
> >> >> exynos_tmu_register structure
> >> >>   thermal: exynos: modify the prototype for code_to_temp
> >> >> function thermal: exynos: Add TMU support for Exynos7 SoC
> >> >>
> >> >>  .../devicetree/bindings/thermal/exynos-thermal.txt |    4 +
> >> >>  drivers/thermal/samsung/exynos_tmu.c               |  106
> >> >> ++++++++++++++----
> >> >> drivers/thermal/samsung/exynos_tmu.h               |   13 ++-
> >> >> drivers/thermal/samsung/exynos_tmu_data.c          |  117
> >> >> ++++++++++++++++++++
> >> >> drivers/thermal/samsung/exynos_tmu_data.h          |   27 +++++
> >> >> 5 files changed, 247 insertions(+), 20 deletions(-)
> >> >
> >> > Best regards,
> >> > --
> >> > Bartlomiej Zolnierkiewicz
> >> > Samsung R&D Institute Poland
> >> > Samsung Electronics
> >> >
> >
> >
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
