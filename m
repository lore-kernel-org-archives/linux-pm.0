From: yoma sophian <sophian.yoma@gmail.com>
Subject: Re: how to enable suspend to ram for arm-64 bits
Date: Thu, 18 Aug 2016 10:07:59 +0800
Message-ID: <CADUS3onUDk_=UpRoZy1m0hV1VGZYSf22ea8D10MpDbqJCfTkqw@mail.gmail.com>
References: <CADUS3onCMDThNK2ZwSSjGZhPE0M6cybjgCHJR2wVVeK09GC6ng@mail.gmail.com>
 <06a4f0d7-9022-578d-99e0-ddcde31ed895@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:34236 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480AbcHRCIU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Aug 2016 22:08:20 -0400
Received: by mail-it0-f67.google.com with SMTP id e63so1360407ith.1
        for <linux-pm@vger.kernel.org>; Wed, 17 Aug 2016 19:08:00 -0700 (PDT)
In-Reply-To: <06a4f0d7-9022-578d-99e0-ddcde31ed895@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

hi Sudeep

> Correct. What's the cpu enable method on your platform ? Is it PSCI ?
No, the enable method is "spin-table"

> If yes, does you PSCI implementation support SYSTEM_SUSPEND ? If yes,
> it should work. Check your PSCI implementation otherwise.

if so, there are 2 things make me curious:
a. I trace arch/arm64/kernel/psci.c even arch/arm64/*, but I sill
cannot find where it create global suspend method table with
suspend_set_ops.
# grep -rnw 'suspend_set_ops' ../linux-4.1/arch/arm64/
#
except arch/xxx folder, there are
../linux-4.1/drivers/macintosh/via-pmu.c:2276:    suspend_set_ops(&pmu_pm_ops);
../linux-4.1/drivers/acpi/sleep.c:666:    suspend_set_ops(old_suspend_ordering ?
Does that mean aarch64 register suspend_set_ops by apci flow when
adopt PSCI implementation?

b. in arm64, if some platform has its own suspend flow,  couldn't it
adopts arm/match-xxx to register its own global suspend method?

appreciate your kind help,
