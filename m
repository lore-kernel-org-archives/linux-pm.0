From: Kukjin Kim <kgene@kernel.org>
Subject: Re: [PATCH v4 0/4] ARM: EXYNOS: cpuidle: add AFTR mode support for
 Exynos3250
Date: Fri, 27 Mar 2015 02:19:25 +0900
Message-ID: <55143F9D.9060100@kernel.org>
References: <1426694453-3242-1-git-send-email-b.zolnierkie@samsung.com> <550A5A94.2080207@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38815 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394AbbCZRTc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 26 Mar 2015 13:19:32 -0400
In-Reply-To: <550A5A94.2080207@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/19/15 14:11, Chanwoo Choi wrote:
> Hi Bartlomiej,
> 
Hi,

> I tested this patch-set for AFTR mode.
> When CPU1 is offline state, I checked that CPU0 enter the AFTR mode.
> 
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
Thanks for your test.

> Best Regards,
> Chanwoo Choi
> 
> On 03/19/2015 01:00 AM, Bartlomiej Zolnierkiewicz wrote:
>> Hi,
>>
>> This patch series adds support for AFTR idle mode on boards with
>> Exynos3250 SoC and allows EXYNOS cpuidle driver usage on these
>> boards.
>>
>> It has been tested on Samsung Rinato board (Gear 2).
>>
>> Depends on:
>> - for-next branch (commit: 77105c882ba6) of linux-samsung.git
>>   kernel tree
>>
>> Changes since v3:
>> - enhanced patch description for patch #1
>> - added Reviewed-by/Tested-by tags from Krzysztof
>> - enhanced C2_STATE BOOT mode flag comment
>> - moved exynos_{set,clear}_boot_flag() to firmware.c
>> - added patch description to patch #3
>>
>> Changes since v2:
>> - rebased on top of for-next branch (commit: 77105c882ba6) of
>>   linux-samsung.git kernel tree
>>
>> Changes since v1:
>> - rebased on top of for-next branch (commit: ce275c369a0b) of
>>   linux-samsung.git kernel tree
>> - fixed lockup on hotplug by using dsb_sev() instead of IPI in
>>   exynos_boot_secondary() on Exynos3250
>>
>> Best regards,
>> --
>> Bartlomiej Zolnierkiewicz
>> Samsung R&D Institute Poland
>> Samsung Electronics
>>
>>
>> Bartlomiej Zolnierkiewicz (4):
>>   ARM: EXYNOS: fix CPU1 hotplug on Exynos3250
>>   ARM: EXYNOS: add code for setting/clearing boot flag
>>   ARM: EXYNOS: cpuidle: add AFTR mode support for Exynos3250
>>   ARM: EXYNOS: cpuidle: allow driver usage on Exynos3250 SoC
>>
>>  arch/arm/mach-exynos/common.h   |  6 ++++++
>>  arch/arm/mach-exynos/exynos.c   |  1 +
>>  arch/arm/mach-exynos/firmware.c | 33 ++++++++++++++++++++++++++++++++-
>>  arch/arm/mach-exynos/platsmp.c  | 23 ++++++++++++++++++++---
>>  arch/arm/mach-exynos/pm.c       | 12 +++++++++++-
>>  arch/arm/mach-exynos/regs-pmu.h |  3 +++
>>  arch/arm/mach-exynos/smc.h      |  9 +++++++++
>>  7 files changed, 82 insertions(+), 5 deletions(-)

Applied this whole series.

Thanks,
Kukjin
