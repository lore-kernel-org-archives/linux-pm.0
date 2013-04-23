From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 0/6] thermal:exynos4: Thermal Measurement Unit fixes for
 Samsung SoCs
Date: Tue, 23 Apr 2013 12:49:26 +0530
Message-ID: <CAK9yfHyQ7JWKTK9zB2ppp=F4YXv_LF_6AU0WEUf1B98-MCb5mA@mail.gmail.com>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
	<51756AA6.3000906@samsung.com>
	<20130423082608.2d163140@amdc308.digital.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:40651 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755304Ab3DWHT1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Apr 2013 03:19:27 -0400
Received: by mail-ob0-f171.google.com with SMTP id er7so248401obc.30
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2013 00:19:26 -0700 (PDT)
In-Reply-To: <20130423082608.2d163140@amdc308.digital.local>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, Zhang Rui <rui.zhang@intel.com>, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

Hi Lukasz,

On 23 April 2013 11:56, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Hi Kukjin,
>
>> On 04/20/13 01:38, Lukasz Majewski wrote:
>> > This patch series provide various fixes for TMU block.
>> > Namely, support for common clock framework and proper regulator
>> > VDD_TS has been added.
>> > Moreover device tree definitions and documentation entry are now in
>> > place.
>> >
>> > Lukasz Majewski (6):
>> >    clk:exynos4:TMU Thermal Measurement Unit clock added to common
>> > clock framework
>> >    thermal:exynos4: TMU Common clock framework support for TMU
>> > (Thermal Monitoring Unit)
>> >    thermal:exynos4: TMU device tree support for Exynos4412 targets
>> >    thermal: Support for TMU regulator defined at device tree
>> >    thermal:exynos4: Enable support for Exynos4412 SoCs
>> >    thermal:exynos4: Add documentation for Exynos SoC thermal
>> > bindings
>> >
>> >   .../devicetree/bindings/clock/exynos4-clock.txt    |    1 +
>> >   .../devicetree/bindings/thermal/exynos-thermal.txt |   22
>> > +++++++++++ arch/arm/boot/dts/exynos4x12.dtsi                  |
>> > 10 +++++ drivers/clk/samsung/clk-exynos4.c                  |    6
>> > ++- drivers/thermal/exynos_thermal.c                   |   41
>> > +++++++++++++++----- 5 files changed, 70 insertions(+), 10
>> > deletions(-) create mode 100644
>> > Documentation/devicetree/bindings/thermal/exynos-thermal.txt
>> >
>> Lukasz, please address comments from ml.
>>
>
> Ok. I'm going to prepare v2

Please respin your v2 on top of my 3 patches to avoid merge conflicts.

-- 
With warm regards,
Sachin
