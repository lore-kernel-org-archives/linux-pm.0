From: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Subject: Re: [PATCH 0/4] Add TMU support for Exynos7
Date: Thu, 20 Nov 2014 18:35:30 +0530
Message-ID: <CAM4voanO=2ewsSjX_YqW7ZPWFJKe8_f3DD5SFytozaooBVKNMw@mail.gmail.com>
References: <1415963882-3460-1-git-send-email-a.kesavan@samsung.com>
	<2756804.O2Zby5SkUf@amdc1032>
	<CAM4voannFHau+TSufpN-rsp4TpSFSK0kKx6QtccNtFW9hO5i+Q@mail.gmail.com>
	<20141114140202.014e1b82@amdc2363>
	<CAM4voanZz-q4d7TXQdcTGYkvYGxBmCjHMbpK29rMwoPS6L_c8A@mail.gmail.com>
	<20141118090826.26056436@amdc2363>
	<CAM4voanQJsQnQJjyo5e7vJ4jSkPY1ZYSDV68x-UDq5vtbFFgbA@mail.gmail.com>
	<20141119131826.GA10406@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:34780 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755979AbaKTNFb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Nov 2014 08:05:31 -0500
Received: by mail-qg0-f51.google.com with SMTP id l89so2029422qgf.10
        for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2014 05:05:31 -0800 (PST)
In-Reply-To: <20141119131826.GA10406@developer>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, rui.zhang@intel.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, amit.daniel@samsung.com

Hi,

On Wed, Nov 19, 2014 at 6:48 PM, Eduardo Valentin <edubezval@gmail.com> wrote:
> Abhilash,
>
> On Tue, Nov 18, 2014 at 01:44:16PM +0530, Abhilash Kesavan wrote:
>> Hi Lukasz,
>>
>> On Tue, Nov 18, 2014 at 1:38 PM, Lukasz Majewski <l.majewski@samsung.com> wrote:
>> > Hi Abhilash,
>> >
>> >> Hi Lukasz,
>> >>
>> >> On Fri, Nov 14, 2014 at 6:32 PM, Lukasz Majewski
>> >> <l.majewski@samsung.com> wrote:
>> >> > Hi Abhilash,
>> >> >
>> >> >> Hi Bartlomiej,
>> >> >>
>> >> >> On Fri, Nov 14, 2014 at 5:49 PM, Bartlomiej Zolnierkiewicz
>> >> >> <b.zolnierkie@samsung.com> wrote:
>> >> >> >
>> >> >> > Hi,
>> >> >> >
>> >> >> > On Friday, November 14, 2014 04:47:58 PM Abhilash Kesavan wrote:
>> >> >> >> The Thermal Management Unit (TMU) in Exynos7 provides
>> >> >> >> software-controlled (thermal throttling) and hardware-controlled
>> >> >> >> (thermal tripping) management schemes.
>> >> >> >> There are several changes in terms of the register and bit
>> >> >> >> offsets in the Exynos7 TMU from that in older SoCs. There are
>> >> >> >> also new bits, more trigger levels and a special clock for TMU
>> >> >> >> that has been introduced in Exynos7. This patchset modifies the
>> >> >> >> thermal driver to handle all these changes.
>> >> >> >>
>> >> >> >> This series is based on linux-next(20141114) and tested on an
>> >> >> >> Exynos7-based espresso board.
>> >> >> >
>> >> >> > Please rebase your patchset on top of:
>> >> >> >
>> >> >> >   http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg38717.html
>> >> >>
>> >> >> Sure, will rebase on top of your patchset. Is this patchset going
>> >> >> to be merged into Eduardo's tree soon ?
>> >> >>
>> >> >> >
>> >> >> > There is also ongoing work to convert Exynos thermal driver to
>> >> >> > use device tree but Lukasz Majewski (added to Cc:) knows better
>> >> >> > the current state of the work.
>> >> >>
>> >> >> Lukasz, are you in the process of making changes to the existing
>> >> >> exynos tmu bindings ?
>> >> >
>> >> > Yes. I'm working on them.
>> >> >
>> >> > Please consider following patches [1]:
>> >> > http://www.spinics.net/lists/linux-samsung-soc/msg37719.html
>> >> >
>> >> > They are based on top of Bartek's work.
>
> Bartlomiej work is in linux-next already. I am planning to send his
> refactoring work for 3.19. But I do require more testing
> to cover for all supported chips, because it is a big change.
> Can you please also try his series in different boards to see if all
> chip support is still in one piece?

I have tested the exynos TMU driver in linux-next (20141119), which
has Bartlomiej's patch series applied, on an SMDK5420 and Exynos5800
based chromebook. Both the boards are working fine (saw the
temperature vary in sysfs and the board shutdown when it hit the s/w
trip temperature).

>
>> >> > Patch set status:
>> >> > 1. Fixes for thermal_core (with -EPROBE_DEFER) - v2 posted
>> >> > yesterday.
>> >> > http://www.spinics.net/lists/linux-samsung-soc/msg37719.html
>> >> >
>> >> > 2. of-thermal rework - I'm working on it now (to export common data
>> >> > from of-thermal.c and provide structure with ops).
>> >> >
>> >> > Patches [1] replace configuration available in exynos_tmu_data.c to
>> >> > the one from device tree. Also it handles setting cpu cooling
>> >> > frequencies per CPUs via device tree.
>> >> >
>> >> >
>> >> > I think that it is Eduardo's decision about how Exynos patches
>> >> > should be serialized.
>> >> >
>
> This is correct. We need some serialization to have a proper flow into
> Linus tree.
>
>> >> > I can only say that after Bartek's and my [1] patch sets the exynos
>> >> > TMU driver is much simpler with significant code base reduction.
>> >> >
>> >> > Personally I think that it may be far more easier to add Exynos7 TMU
>> >> > support to reworked driver.
>> >>
>> >> Thanks for the details. I am OK with rebasing my patches over
>> >> Bartlomiej and your patch sets. Do you have any public tree with both
>> >> these patch sets merged ?
>> >
>> > I've managed to export my ongoing Exynos TMU work to a public tree.
>> > You can find it at:
>> > https://git.linaro.org/people/marek.szyprowski/linux-srpol.git/shortlog/refs/heads/v3.18-ti-soc-thermal
>> >
>> >
>> > Please be aware that this code is under development (and review) and
>> > some parts may be changed.
>> >
>> > However, this shows how the Exynos TMU driver would look like after the
>> > rework.
>> >
>> > If in any doubts, please ask.
>>
>> Thanks a lot for this. I will start rebasing my exynos7 patches on your tree.
>>
>
> Good! Please rebase your work on top of Bart's and Lukasz's work.
>
> New Exynos chip support, at this point, makes sense to hold until we get
> the rework done. The proposals for change in of-thermal are more or less
> alined. The rework at the exynos driver as well. So, things should go
> smoothly, from my perspective.

Sure I will wait for Lukasz's consolidation to get in. However, there
is a patch in my series [1] which adds support for an optional special
clock. Could that be picked up independently now if I rebase it over
Bartlomiej's patchset ?

[1] http://permalink.gmane.org/gmane.linux.power-management.general/52826
>
> One point I want you, Abhilash, is to check Bartlomiej series. He has ripped
> several things in his refactoring, like register abstraction, etc. It would
> be good if you check the impact of those changes in your new chip
> support, before we send his series for merge. Please have a word there.

Lukasz,  I tested the tree with your patches applied on a SMDK5420 and
5800-Peach-Pi. However, the boards hang at boot-up after failing to
get the trip points ("get_th_reg: Cannot get trip points from
of-thermal.c!"). I have not debugged this yet and was wondering if you
have noticed similar issues or have already fixed this.

I am currently in the process of porting the Exynos7 changes over
yours, will let you know if I have any other questions.

Regards,
Abhilash

>> >> >> >> Abhilash Kesavan (4):
>> >> >> >>   thermal: exynos: add optional sclk support
>> >> >> >>   thermal: exynos: add a triminfo_mask field in
>> >> >> >> exynos_tmu_register structure
>> >> >> >>   thermal: exynos: modify the prototype for code_to_temp
>> >> >> >> function thermal: exynos: Add TMU support for Exynos7 SoC
>> >> >> >>
>> >> >> >>  .../devicetree/bindings/thermal/exynos-thermal.txt |    4 +
>> >> >> >>  drivers/thermal/samsung/exynos_tmu.c               |  106
>> >> >> >> ++++++++++++++----
>> >> >> >> drivers/thermal/samsung/exynos_tmu.h               |   13 ++-
>> >> >> >> drivers/thermal/samsung/exynos_tmu_data.c          |  117
>> >> >> >> ++++++++++++++++++++
>> >> >> >> drivers/thermal/samsung/exynos_tmu_data.h          |   27 +++++
>> >> >> >> 5 files changed, 247 insertions(+), 20 deletions(-)
>> >> >> >
>> >> >> > Best regards,
>> >> >> > --
>> >> >> > Bartlomiej Zolnierkiewicz
>> >> >> > Samsung R&D Institute Poland
>> >> >> > Samsung Electronics
>> >> >> >
>> >> >
>> >> >
>> >> >
>> >> > --
>> >> > Best regards,
>> >> >
>> >> > Lukasz Majewski
>> >> >
>> >> > Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
>> >
>> >
>> >
>> > --
>> > Best regards,
>> >
>> > Lukasz Majewski
>> >
>> > Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
>
>
