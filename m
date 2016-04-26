From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ARM: cpuidle: Pass on arm_cpuidle_suspend()'s return value
Date: Tue, 26 Apr 2016 21:05:57 +0200
Message-ID: <CAJZ5v0h+P5baWVkTcbjxOjsXyp7aDy25+ik_9XHtUs6+jeN7Pw@mail.gmail.com>
References: <1461669301-30834-1-git-send-email-james.morse@arm.com>
	<20160426113103.GB2204@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34202 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277AbcDZTF7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2016 15:05:59 -0400
Received: by mail-lf0-f65.google.com with SMTP id m101so3793440lfi.1
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2016 12:05:58 -0700 (PDT)
In-Reply-To: <20160426113103.GB2204@red-moon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: James Morse <james.morse@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Tue, Apr 26, 2016 at 1:31 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Tue, Apr 26, 2016 at 12:15:01PM +0100, James Morse wrote:
>> arm_cpuidle_suspend() may return -EOPNOTSUPP, or any value returned
>> by the cpu_ops/cpuidle_ops suspend call. arm_enter_idle_state() doesn't
>> update 'ret' with this value, meaning we always signal success to
>> cpuidle_enter_state(), causing it to update the usage counters as if we
>> succeeded.
>>
>> Fixes: 191de17aa3c1 ("ARM64: cpuidle: Replace cpu_suspend by the common ARM/ARM64 function")
>> Signed-off-by: James Morse <james.morse@arm.com>
>> ---
>>  drivers/cpuidle/cpuidle-arm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>
>>
>> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
>> index 545069d5fdfb..e342565e8715 100644
>> --- a/drivers/cpuidle/cpuidle-arm.c
>> +++ b/drivers/cpuidle/cpuidle-arm.c
>> @@ -50,7 +50,7 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
>>                * call the CPU ops suspend protocol with idle index as a
>>                * parameter.
>>                */
>> -             arm_cpuidle_suspend(idx);
>> +             ret = arm_cpuidle_suspend(idx);
>>
>>               cpu_pm_exit();
>>       }
>> --

OK

Should that go into -stable?
