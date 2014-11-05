From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2 1/5] sched: idle: cpuidle: Check the latency req before
 idle
Date: Wed, 05 Nov 2014 22:41:00 +0100
Message-ID: <545A996C.6030606@linaro.org>
References: <1414054881-17713-1-git-send-email-daniel.lezcano@linaro.org> <1637800.Fp0noCplzq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:42769 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbaKEVlK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Nov 2014 16:41:10 -0500
Received: by mail-wg0-f43.google.com with SMTP id y10so1946661wgg.30
        for <linux-pm@vger.kernel.org>; Wed, 05 Nov 2014 13:41:09 -0800 (PST)
In-Reply-To: <1637800.Fp0noCplzq@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: nicolas.pitre@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org, Preeti U Murthy <preeti@linux.vnet.ibm.com>

On 11/05/2014 10:57 PM, Rafael J. Wysocki wrote:
> On Thursday, October 23, 2014 11:01:17 AM Daniel Lezcano wrote:
>> When the pmqos latency requirement is set to zero that means "poll i=
n all the
>> cases".
>>
>> That is correctly implemented on x86 but not on the other archs.
>>
>> As how is written the code, if the latency request is zero, the gove=
rnor will
>> return zero, so corresponding, for x86, to the poll function, but fo=
r the
>> others arch the default idle function. For example, on ARM this is w=
ait-for-
>> interrupt with a latency of '1', so violating the constraint.
>>
>> In order to fix that, do the latency requirement check *before* call=
ing the
>> cpuidle framework in order to jump to the poll function without ente=
ring
>> cpuidle. That has several benefits:
>>
>>   1. It clarifies and unifies the code
>>   2. It fixes x86 vs other archs behavior
>>   3. Factors out the call to the same function
>>   4. Prevent to enter the cpuidle framework with its expensive cost =
in
>>      calculation
>>
>> As the latency_req is needed in all the cases, change the select API=
 to take
>> the latency_req as parameter in case it is not equal to zero.
>>
>> As a positive side effect, it introduces the latency constraint spec=
ified
>> externally, so one more step to the cpuidle/scheduler integration.
>
> I'm expecting to see a new version of this patchset relatively soon.
>
> Are you planning to send one?

I would like to find an agreement with Preeti. But, yes, I am on it.

   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

