From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCHv7 00/10] devfreq: Add devfreq-event class to provide raw
 data for devfreq device
Date: Mon, 12 Jan 2015 19:17:05 +0900
Message-ID: <54B39F21.3070602@samsung.com>
References: <437622256.904751421056684753.JavaMail.weblogic@epmlwas01a>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:13939 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbbALKRI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jan 2015 05:17:08 -0500
In-reply-to: <437622256.904751421056684753.JavaMail.weblogic@epmlwas01a>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, ABHILASH KESAVAN <a.kesavan@samsung.com>
Cc: "kgene@kernel.org" <kgene@kernel.org>, =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, =?UTF-8?B?64yA7J246riw?= <inki.dae@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>

On 01/12/2015 06:58 PM, MyungJoo Ham wrote:
>>   
>>  This patchset add new devfreq_event class to provide raw data to determine
>> current utilization of device  which is used for devfreq governor.
>>
>> The following description explains the feature of two kind of devfreq class:
>> - devfreq class (existing)
>>  : devfreq consumer device use raw data from devfreq_event device for
>>    determining proper current system state and change voltage/frequency
>>    dynamically using various governors.
>> - devfreq_event class (new)
>>  : Provide measured raw data to devfreq device for governor
>>
> 
> Question: Applying this patchset seems to imply that
> drivers/devfreq/exynos/exynos_ppmu.c becomes obsolete.
> How do you want to address it? Do you think it'd be ok to remove
> thse obsolete drivers after your successing patchset?
> 
> If it is ok to remove old drivers after applying the new patchset,
> please inclde a patch that removes old drivers unless such a removal
> might result in compatibility issues with old (yet another obsolete)
> board files, which I don't think probable.

I agree to remove 'drviers/devfreq/exynos/exynos_ppmu.c.
But, existing exynos_ppmu.c was used for drivers/devfreq/exynos/exynos5_bus.c.

Before removing existing 'exynos_ppmu.c', might need to test the devfreq-event class
on Exynos5260 SoC. I will just remove old driver('drivers/devfreq/exynos/exynos4_bus.{c|h}')
on next patchset.

To Abhilash,
Could you test this patch-set on Exynos5260 SoC?

Best Regards,
Chanwoo Choi

