From: amit daniel kachhap <amit.daniel@samsung.com>
Subject: Re: [PATCH 3/3] arm64: psci: Add support to call cpu_suspend with
 deepest C state.
Date: Mon, 1 Dec 2014 13:38:55 +0530
Message-ID: <CADGdYn51aC-r7bRLvF+5p2z=a1WXRXobA-ukuvuDXHn-HE2PZw@mail.gmail.com>
References: <1414641338-25279-1-git-send-email-amit.daniel@samsung.com>
	<1414641338-25279-3-git-send-email-amit.daniel@samsung.com>
	<20141030104630.GC17843@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yh0-f50.google.com ([209.85.213.50]:38508 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390AbaLAII4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 03:08:56 -0500
Received: by mail-yh0-f50.google.com with SMTP id 29so4990671yhl.9
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2014 00:08:55 -0800 (PST)
In-Reply-To: <20141030104630.GC17843@red-moon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Vladimir Murzin <Vladimir.Murzin@arm.com>, Charles Garcia-Tobin <charles.garcia-tobin@arm.com>

On Thu, Oct 30, 2014 at 4:16 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Thu, Oct 30, 2014 at 03:55:38AM +0000, Amit Daniel Kachhap wrote:
>> This feature will be useful for system suspend/resume which may
>> intend to invoke cpu_suspend with deepest possible C state level.
>
> We are working on defining system states in the PSCI specification,
> but it is not set in stone yet (Cc'ed Charles).
>
> I guess you are posting this code because you have already an
> implementation that supports system suspend/resume, so I am
> taking an immediate action to come up with an API suitable
> for that asap.
Hi Lorenzo,

Any update on this API for system sleep.

Regards,
Amit

>
> On a side note I do not necessarily like this magic idle index
> logic, I prefer adding an API for that, that translates the call
> into whatever is required by the back-end (ie PSCI) implementation.
>
> Thanks,
> Lorenzo
>
>> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> ---
>>  arch/arm64/include/asm/psci.h | 2 ++
>>  arch/arm64/kernel/psci.c      | 8 ++++++++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/psci.h b/arch/arm64/include/asm/psci.h
>> index e5312ea..487e52b 100644
>> --- a/arch/arm64/include/asm/psci.h
>> +++ b/arch/arm64/include/asm/psci.h
>> @@ -14,6 +14,8 @@
>>  #ifndef __ASM_PSCI_H
>>  #define __ASM_PSCI_H
>>
>> +#define CPU_PSCI_IDLE_INDEX_MAX              0xff
>> +
>>  int psci_init(void);
>>
>>  #endif /* __ASM_PSCI_H */
>> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
>> index 4ebc146..a761513 100644
>> --- a/arch/arm64/kernel/psci.c
>> +++ b/arch/arm64/kernel/psci.c
>> @@ -70,6 +70,7 @@ enum psci_function {
>>  static DEFINE_PER_CPU_READ_MOSTLY(struct psci_power_state *, psci_power_state);
>>
>>  static u32 psci_function_id[PSCI_FN_MAX];
>> +static u32 cpu_psci_idle_state_count;
>>
>>  static int psci_to_linux_errno(int errno)
>>  {
>> @@ -239,6 +240,8 @@ static int __maybe_unused cpu_psci_cpu_init_idle(struct device_node *cpu_node,
>>       if (!count)
>>               return -ENODEV;
>>
>> +     cpu_psci_idle_state_count = count;
>> +
>>       psci_states = kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
>>       if (!psci_states)
>>               return -ENOMEM;
>> @@ -521,6 +524,11 @@ static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
>>  {
>>       int ret;
>>       struct psci_power_state *state = __get_cpu_var(psci_power_state);
>> +
>> +     /* Check and select the deepest idle state */
>> +     if (index == CPU_PSCI_IDLE_INDEX_MAX)
>> +             index = cpu_psci_idle_state_count;
>> +
>>       /*
>>        * idle state index 0 corresponds to wfi, should never be called
>>        * from the cpu_suspend operations.
>> --
>> 1.9.1
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
