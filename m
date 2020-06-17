Return-Path: <SRS0=eD5R=76=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7EFC433E0
	for <linux-pm@archiver.kernel.org>; Wed, 17 Jun 2020 10:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA0E02082F
	for <linux-pm@archiver.kernel.org>; Wed, 17 Jun 2020 10:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgFQKks (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 17 Jun 2020 06:40:48 -0400
Received: from foss.arm.com ([217.140.110.172]:55276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgFQKkr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Jun 2020 06:40:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC958C0A;
        Wed, 17 Jun 2020 03:40:46 -0700 (PDT)
Received: from [10.37.12.67] (unknown [10.37.12.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9D923F71F;
        Wed, 17 Jun 2020 03:40:44 -0700 (PDT)
Subject: Re: [PATCH 0/4] Restore big.LITTLE cpuidle driver for Exynos
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Anand Moon <linux.amoon@gmail.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <CGME20200616081248eucas1p168faa343ce333a28c8fd3cf9a6a58b3c@eucas1p1.samsung.com>
 <20200616081230.31198-1-m.szyprowski@samsung.com>
 <CANAwSgStsYP5fBB7z7-Reo2BP4ZQPT6RN4s8QdLGVGhKCDA_Ng@mail.gmail.com>
 <3e6b5dbb-a8a2-e3db-d740-53e13676455c@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <6b2ac503-62e1-35a6-6dc7-232597367396@arm.com>
Date:   Wed, 17 Jun 2020 11:40:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3e6b5dbb-a8a2-e3db-d740-53e13676455c@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/17/20 10:48 AM, Marek Szyprowski wrote:
> Hi Anand,
> 
> On 16.06.2020 22:58, Anand Moon wrote:
>> On Tue, 16 Jun 2020 at 13:44, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>>> The ARM big.LITTLE cpuidle driver has been enabled and tested on Samsung
>>> Exynos 5420/5800 based Peach Pit/Pi Chromebooks and in fact it worked
>>> only on those boards.
>>>
>>> However, support for it was broken by the commit 833b5794e330 ("ARM:
>>> EXYNOS: reset Little cores when cpu is up") and then never enabled in the
>>> exynos_defconfig. This patchset provides the needed fix to the common
>>> code and restores support for it. Thanks to Lukasz Luba who motivated me
>>> to take a look into this issue.
>>>
>> Thanks for this updates.
>>
>> But I feel some DTS changes are missing for example
>> d2e5c871ed8a drivers: cpuidle: initialize big.LITTLE driver through DT
> 
> This is not strictly needed. The bl-cpuidle matches also to the A7/A15
> CPU product ids and it is properly instantiated on the Peach Pit/Pi
> Chromebooks. Those CPU DT properties were added as a future-proof
> generic solution. I won't hurt to add them though.

> 
>> But I feel that this feature is not working as desired since
>> still some missing code changes for cluster idle states are missing.
>> like clock  PWR_CTR and PWR_CTRL2.
> 
> I cannot judge now. All I can test now is a that the boards enters those
> idle states and system works stable. I cannot measure power consumption,
> because currently I have only remote access to the boards.

I agree with Marek. This can be done incrementally. The series fixes the
code path which was working. After the investigation with a power
meter, a proper set of new patches might come if needed.

As a hint to measure this power consumption difference, because it
might be tricky, I would suggest to heat up the SoC. The main
difference between wfi and deeper idle which cut the power
to some components (like caches) should be seen at higher voltage
OPP and higher temperature. It's due to the fact that static power
(leakage) is related to Vdd and temperature -
higher voltage -> higher leakage
higher temp -> higher leakage
This difference (idle state 0 vs 1) should be amplified in the
above scenario and easier to measure.

I am going to review this series after finishing hotplug tests.

Regards,
Lukasz
