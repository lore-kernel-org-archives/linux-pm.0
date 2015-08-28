From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: CPUIdle for Exynos5422 Odroid-XU3/XU4 boards.
Date: Fri, 28 Aug 2015 21:42:35 +0900
Message-ID: <55E0573B.4060604@samsung.com>
References: <CANAwSgTWZ1a+j8RTiamsKaALKf+ekLVqtO6RFTLXkG=bJN4BPQ@mail.gmail.com>
 <4468206.R1amSm9GHX@amdc1976> <20150825160932.GD20070@red-moon>
 <1574385.AV2PKdoIbr@amdc1976> <55E01D61.8020706@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33903 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbbH1Mmm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2015 08:42:42 -0400
In-Reply-To: <55E01D61.8020706@osg.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Anand Moon <linux.amoon@gmail.com>, Daniel Lezcano <daniel.lezcano@free.fr>, Kukjin Kim <kgene@kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Przemyslaw Marczak <p.marczak@samsung.com>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

W dniu 28.08.2015 o 17:35, Javier Martinez Canillas pisze:
> Hello Bartlomiej and Lorenzo,
> 
> Thanks a lot for your explanations.
> 
> On 08/27/2015 06:58 PM, Bartlomiej Zolnierkiewicz wrote:
>
>> If somebody wants to implement a separate Exynos542x/Exynos5800
>> big.LITTLE cpuidle driver for them I see no problem with it and I'm
>> willing to help in maintaining it.
>>
> 
> Ok, I'll see if I can take a look what is needed to implement a Exynos542x CPUidle
> driver. I'm quite busy with other stuff right now but I should be less busy in a
> couple of weeks.

The only useful users of Exynos542x cpuidle would be Chromebooks.
Probably the same goes with suspend to RAM. Non-mobile devices could
leave without it.

In the same time cpuidle and S2R would require a significant amount of
work. Testing would have to be performed on Chromebooks. I have doubts
it would work on Odroid XU3.

I dug into S2R issues on Odroid XU3 and after fixing trivial imprecise
abort I don't have clue. It just dies somewhere in firmware/bootloader.
Vendor code has a lot more stuff related to suspend and testing it
one-by-one whether it fixes the issue is frustrating.

Do we really need cpuidle or S2R on Exynos542x/5800?

> 
> Maybe is a little bit out of topic but since Anand also asked about CPUFreq support,
> are you planning on re-posting your "cpufreq: add generic cpufreq driver support
> for Exynos5250/5800 platforms" [0] series?

That would be useful. Bartlomiej, do you have plans for continuing the work?

Best regards,
Krzysztof

