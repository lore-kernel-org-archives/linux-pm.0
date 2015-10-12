From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: CPUIdle for Exynos5422 Odroid-XU3/XU4 boards.
Date: Tue, 13 Oct 2015 00:36:57 +0530
Message-ID: <CAHLCerO_eLNtnan9tvM_EjtPo5hWHC0NUJJa_5y9V9r3Q54YrQ@mail.gmail.com>
References: <CANAwSgTWZ1a+j8RTiamsKaALKf+ekLVqtO6RFTLXkG=bJN4BPQ@mail.gmail.com>
	<4468206.R1amSm9GHX@amdc1976>
	<20150825160932.GD20070@red-moon>
	<1574385.AV2PKdoIbr@amdc1976>
	<55E01D61.8020706@osg.samsung.com>
	<55E0573B.4060604@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:36378 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbbJLTG5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2015 15:06:57 -0400
Received: by ykey125 with SMTP id y125so20770364yke.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2015 12:06:57 -0700 (PDT)
In-Reply-To: <55E0573B.4060604@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Anand Moon <linux.amoon@gmail.com>, Daniel Lezcano <daniel.lezcano@free.fr>, Kukjin Kim <kgene@kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Przemyslaw Marczak <p.marczak@samsung.com>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Fri, Aug 28, 2015 at 6:12 PM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> W dniu 28.08.2015 o 17:35, Javier Martinez Canillas pisze:

>>
>> Ok, I'll see if I can take a look what is needed to implement a Exynos542x CPUidle
>> driver. I'm quite busy with other stuff right now but I should be less busy in a
>> couple of weeks.
>
> The only useful users of Exynos542x cpuidle would be Chromebooks.
> Probably the same goes with suspend to RAM. Non-mobile devices could
> leave without it.
>
> In the same time cpuidle and S2R would require a significant amount of
> work. Testing would have to be performed on Chromebooks. I have doubts
> it would work on Odroid XU3.
>
> I dug into S2R issues on Odroid XU3 and after fixing trivial imprecise
> abort I don't have clue. It just dies somewhere in firmware/bootloader.
> Vendor code has a lot more stuff related to suspend and testing it
> one-by-one whether it fixes the issue is frustrating.
>
> Do we really need cpuidle or S2R on Exynos542x/5800?

Cpuidle support on Odroid-XU3 and Peach-Pi would be useful for general
PM/scheduler work on big.LITTLE systems. On the Odroid, it has the
additional benefit of allowing power measurements, which helps.

Regards,
Amit
