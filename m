From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [Patch v2 0/4] add cpuidle support for Exynos5420
Date: Thu, 24 Apr 2014 00:42:11 +0900
Message-ID: <5357DF53.4010806@samsung.com>
References: <1398080958-21677-5-git-send-email-chander.kashyap@linaro.org> <1398245154-18771-1-git-send-email-chander.kashyap@linaro.org> <4517423.BmCv8cudjC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:38404 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbaDWPmf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Apr 2014 11:42:35 -0400
In-Reply-To: <4517423.BmCv8cudjC@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Chander Kashyap <chander.kashyap@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, daniel.lezcano@linaro.org, kgene.kim@samsung.com

On 04/23/14 19:18, Rafael J. Wysocki wrote:
> On Wednesday, April 23, 2014 02:55:50 PM Chander Kashyap wrote:
>> Exynos5420 is a big-little Soc from Samsung. It has 4 A15 and 4 A7 cores.
>>
>> This patchset adds cpuidle support for Exynos5420 SoC based on
>> generic big.little cpuidle driver.
>>
>> Tested on SMDK5420.
>>
>> This patch set depends on:
>> 	1. [PATCH 0/5] MCPM backend for Exynos5420
>> 	   http://www.spinics.net/lists/arm-kernel/msg321666.html
>>
>> 	2. [PATCH v4] arm: exynos: generalize power register address calculation
>> 	   http://www.spinics.net/lists/arm-kernel/msg324024.html
>> 		
>> Changelog is in respective patches.
>> Chander Kashyap (4):
>>    cpuidle: config: Add SOC_EXYNOS5420 entry to select
>>      cpuidle-big-little driver
>>    driver: cpuidle: cpuidle-big-little: init driver for Exynos5420
>>    exynos: cpuidle: do not allow cpuidle registration for Exynos5420
>>    mcpm: exynos: populate suspend and powered_up callbacks
>>
>>   arch/arm/mach-exynos/cpuidle.c       |    3 ++
>>   arch/arm/mach-exynos/mcpm-exynos.c   |   53 ++++++++++++++++++++++++++++++++++
>>   drivers/cpuidle/Kconfig.arm          |    2 +-
>>   drivers/cpuidle/cpuidle-big_little.c |    3 +-
>>   4 files changed, 59 insertions(+), 2 deletions(-)
>
> I'm assuming that the Exynos maintainers will take care of this, correct?
>

Yeah, I will if you have any objection :-)

BTW, I need to look at the dependent patches.

- Kukjin
