From: Amit Kachhap <amit.kachhap@gmail.com>
Subject: Re: [PATCH 1/3] arm64: psci: warn if psci_power_state variable is not initialised
Date: Thu, 30 Oct 2014 17:05:03 +0530
Message-ID: <CADGdYn4H_nNhrc7cGXzzVVaL_bT03O05hBjoRCG64dfAxCHxQw@mail.gmail.com>
References: <1414641338-25279-1-git-send-email-amit.daniel@samsung.com>
	<20141030102948.GB17843@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:38537 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758646AbaJ3LfD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Oct 2014 07:35:03 -0400
Received: by mail-yk0-f179.google.com with SMTP id 131so2198752ykp.10
        for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2014 04:35:03 -0700 (PDT)
In-Reply-To: <20141030102948.GB17843@red-moon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Vladimir Murzin <Vladimir.Murzin@arm.com>

On Thu, Oct 30, 2014 at 3:59 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Thu, Oct 30, 2014 at 03:55:36AM +0000, Amit Daniel Kachhap wrote:
>> Without this cpu_suspend may cause crash dump when psci cpuidle
>> is not initialised and cpu_suspend is called.
>>
>> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> ---
>>  arch/arm64/kernel/psci.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
>> index 866c1c8..2178d6e 100644
>> --- a/arch/arm64/kernel/psci.c
>> +++ b/arch/arm64/kernel/psci.c
>> @@ -523,9 +523,11 @@ static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
>>       struct psci_power_state *state = __get_cpu_var(psci_power_state);
>>       /*
>>        * idle state index 0 corresponds to wfi, should never be called
>> -      * from the cpu_suspend operations
>> +      * from the cpu_suspend operations.
>> +      * Also psci_power_state variable should have been populated by
>> +      * above init idle routine.
>>        */
>> -     if (WARN_ON_ONCE(!index))
>> +     if (WARN_ON_ONCE(!index || !state))
>>               return -EINVAL;
>
> I thought about this when developing the code, at the moment this can't
> happen so I did not add any check for that. I would wait for the dust
> to settle on the API usage (and if we need it for something different
> than idle) before adding checks that might turn out useless, so we will
> keep this patch on the back-burner for now.

Ok right this fix is not mandatory.

>
> Thanks,
> Lorenzo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
