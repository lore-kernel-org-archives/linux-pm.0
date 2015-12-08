From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v3 10/10] arm64: kernel: Add support for hibernate/suspend-to-disk.
Date: Tue, 08 Dec 2015 10:39:47 +0000
Message-ID: <5666B373.8070306@arm.com>
References: <1448559168-8363-1-git-send-email-james.morse@arm.com> <1448559168-8363-11-git-send-email-james.morse@arm.com> <20151201093143.GD21222@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42679 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932084AbbLHKkl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Dec 2015 05:40:41 -0500
In-Reply-To: <20151201093143.GD21222@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

Hi Pavel,

On 01/12/15 09:31, Pavel Machek wrote:
>> diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
>> index 5faa3ce1fa3a..e75ad7aa268c 100644
>> --- a/arch/arm64/include/asm/suspend.h
>> +++ b/arch/arm64/include/asm/suspend.h
>> @@ -1,3 +1,5 @@
>> +#include <linux/suspend.h>
>> +
>>  #ifndef __ASM_SUSPEND_H
>>  #define __ASM_SUSPEND_H
>>
> 
> Actually... even additional includes should go after the #ifdef
> guards.

Ooops - thanks for spotting that! I will send a fixup.

(I'm expecting to publish a new version if there are newer versions of
the four patches shared with kexec.)


Thanks,

James
