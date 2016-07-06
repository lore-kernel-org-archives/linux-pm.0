From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v4 1/3] PM / Hibernate: Allow arch code to influence CPUs
 disabled during hibernate
Date: Wed, 06 Jul 2016 10:16:15 +0100
Message-ID: <577CCC5F.2060409@arm.com>
References: <1467643950-11034-1-git-send-email-james.morse@arm.com> <1467643950-11034-2-git-send-email-james.morse@arm.com> <2602641.slsnqsKrbn@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56910 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751022AbcGFJS2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 6 Jul 2016 05:18:28 -0400
In-Reply-To: <2602641.slsnqsKrbn@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Pavel Machek <pavel@ucw.cz>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Chen Yu C <yu.c.chen@intel.com>

Hi Rafael,

On 05/07/16 13:28, Rafael J. Wysocki wrote:
> On Monday, July 04, 2016 03:52:28 PM James Morse wrote:
>> Architecture code may need to do extra work when secondary CPUs are
>> disabled during hibernate and resume. This may include pushing sleeping
>> CPUs into a deeper power-saving state, or influencing which CPU resume
>> occurs on.
>>
>> Define a macro arch_hibernation_disable_cpus(), which defaults to
>> calling disable_nonboot_cpus() if undefined. Architectures that
>> need to do extra work around these calls can use this to influence
>> the CPU down calls.
>> The macros should be defined in asm/suspend.h, and
>> ARCH_HIBERNATION_CPU_HOOKS should be added to Kconfig.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Pavel Machek <pavel@ucw.cz>
> 
> I'm going to apply this one later today.
> 
> If you want me to apply the other two as well, they need to be ACKed by the
> ARM64 maintainers.

Thanks. I'd like to get to the bottom of Lorenzo's comments[0] before the arm64
patches go any further though!

Thanks,


James


[0] http://www.spinics.net/lists/arm-kernel/msg516244.html
