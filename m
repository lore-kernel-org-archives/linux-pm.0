From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v9 0/7] devfreq: Add devfreq-event class to provide raw
 data for devfreq device
Date: Mon, 26 Jan 2015 11:11:44 +0900
Message-ID: <54C5A260.7030103@samsung.com>
References: <298834569.29261422238011182.JavaMail.weblogic@epmlwas04d>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:16825 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbbAZCLq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 25 Jan 2015 21:11:46 -0500
In-reply-to: <298834569.29261422238011182.JavaMail.weblogic@epmlwas04d>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: Kukjin Kim <kgene@kernel.org>, =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, ABHILASH KESAVAN <a.kesavan@samsung.com>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, =?UTF-8?B?64yA7J246riw?= <inki.dae@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>

Dear Kukjin and Myungjoo,

On 01/26/2015 11:06 AM, MyungJoo Ham wrote:
>>   
>>  Chanwoo Choi wrote:
>>>
>> Hi,
>>
> 
> []
> 
>>>
>>> --
>>
>> Looks good to me.
>>
>> Myungjoo, shall I take DT changes in this series into Samsung tree?
>>
>> 4/7 ARM: dts: Add PPMU dt node for Exynos3250 SoC
>> 5/7 ARM: dts: Add PPMU dt node for Exynos4 SoCs
>> 6/7 ARM: dts: exynos: Add PPMU node for Exynos3250-based Rinato/Monk board
>> 7/7 ARM: dts: exynos: Add PPMU node for Exynos4412-based TRATS2 board
> 
> Yes, you may take those. I am not so confident with taking DT patches, either.
> 
> However, Chanwoo has another updates following for this patchset.
> 
> After that, I guess we can merge chanwoo's patchset splitted.

I have minor fixup issue. I'll send next patchset(v10) right now.

Thanks for your review.

Best Regards,
Chanwoo Choi

