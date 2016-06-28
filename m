From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v2 4/6] PM / Hibernate: Allow architectures to specify
 the hibernate/resume CPU
Date: Tue, 28 Jun 2016 15:51:39 +0100
Message-ID: <57728EFB.5050701@arm.com>
References: <1466012148-7674-1-git-send-email-james.morse@arm.com> <1466012148-7674-5-git-send-email-james.morse@arm.com> <CAJZ5v0ipRONyMe15k=-FhcKEGM6kMh5Vu35XQexBr0SMYQoktQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48023 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952AbcF1Oxx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 28 Jun 2016 10:53:53 -0400
In-Reply-To: <CAJZ5v0ipRONyMe15k=-FhcKEGM6kMh5Vu35XQexBr0SMYQoktQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>

Hi Rafael,

On 15/06/16 22:10, Rafael J. Wysocki wrote:
> On Wed, Jun 15, 2016 at 7:35 PM, James Morse <james.morse@arm.com> wrote:
>> On arm64 the cpu with logical id 0 is assumed to be the boot CPU. If a
>> user hotplugs this CPU out, then uses kexec to boot a new kernel, the new
>> kernel will assign logical id 0 to a different physical CPU.
>> This breaks hibernate as hibernate and resume will be attempted on different
>> CPUs.
>>
>> Define a weak symbol arch_hibernation_disable_cpus(), which defaults to
>> calling disable_nonboot_cpus). Architectures that allow CPU 0 to be
>> hotplugged can use this to control which CPU is used for hibernate/resume.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Pavel Machek <pavel@ucw.cz>
>> ---
>> If this approach is acceptable, this patch should go with 4&5 via the arm64
>> tree.
> 
> I'm not entirely happy with this, but if you absolutely need it and if
> you can't think about any cleaner way to achieve the goal, feel free
> to add my ACK to this patch if necessary.

I would prefer you to be happy with it.
On the weak symbol: After staring at this some more I've made the macro approach
work, so the weak symbol can go. (a new version of this series should arrive soon)
On the arch-specific odour coming from this, it may also be useful for Chen Yu's
'Use hlt instead of mwait when resuming from hibernation' series[0]. (I don't
understand the x86 specifics)


We need this to allow kexec and hibernate to interact freely. Preventing kexec
if CPU0 is offline because of hibernate doesn't feel right. Fixing it is
necessary as the first hint that something is wrong is when we fail to resume
and the user looses any data they had in memory.


Thanks,

James


[0] https://lkml.org/lkml/2016/6/25/98
