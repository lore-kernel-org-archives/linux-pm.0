From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/6] ARM64: cpuidle: Replace cpu_suspend by the common
 ARM/ARM64 function
Date: Fri, 13 Mar 2015 22:22:37 +0100
Message-ID: <5503551D.2020202@linaro.org>
References: <1425385777-14766-1-git-send-email-daniel.lezcano@linaro.org> <1425385777-14766-4-git-send-email-daniel.lezcano@linaro.org> <20150313182102.GS30671@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:39294 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652AbbCMVWk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 17:22:40 -0400
Received: by wiwl15 with SMTP id l15so13242wiw.4
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2015 14:22:38 -0700 (PDT)
In-Reply-To: <20150313182102.GS30671@e104818-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, devicetree@vger.kernel.org, arnd@arndb.de, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lina.iyer@linaro.org, linux-arm-kernel@lists.infradead.org

On 03/13/2015 07:21 PM, Catalin Marinas wrote:
> On Tue, Mar 03, 2015 at 01:29:34PM +0100, Daniel Lezcano wrote:
>> Call the common ARM/ARM64 'arm_cpuidle_suspend' instead of cpu_suspe=
nd function
>> which is specific to ARM64.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/cpuidle/cpuidle-arm64.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuid=
le-arm64.c
>> index 39a2c62..0cea244 100644
>> --- a/drivers/cpuidle/cpuidle-arm64.c
>> +++ b/drivers/cpuidle/cpuidle-arm64.c
>> @@ -49,7 +49,7 @@ static int arm64_enter_idle_state(struct cpuidle_d=
evice *dev,
>>   		 * call the CPU ops suspend protocol with idle index as a
>>   		 * parameter.
>>   		 */
>> -		ret =3D cpu_suspend(idx);
>> +		arm_cpuidle_suspend(idx);
>
> Nitpick: why don't we just rename the arm one cpuidle_suspend()?

I don't have a strong opinion on that. Actually, the cpuidle_ prefix is=
=20
used by the arch agnostic code in drivers/cpuidle/cpuidle.c.

If Rafael agrees on changing it to this function name, I am ok also.


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

