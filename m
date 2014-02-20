From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 09/10] cpuidle: declare cpuidle_dev in cpuidle.h
Date: Thu, 20 Feb 2014 14:53:06 +0100
Message-ID: <530608C2.3070507@linaro.org>
References: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com> <1389794137-11361-10-git-send-email-paul.burton@imgtec.com> <53060496.6000303@linaro.org> <20140220134118.GT25765@pburton-linux.le.imgtec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:48199 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754333AbaBTNxI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2014 08:53:08 -0500
Received: by mail-we0-f177.google.com with SMTP id t61so1457202wes.22
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2014 05:53:07 -0800 (PST)
In-Reply-To: <20140220134118.GT25765@pburton-linux.le.imgtec.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On 02/20/2014 02:41 PM, Paul Burton wrote:
> On Thu, Feb 20, 2014 at 02:35:18PM +0100, Daniel Lezcano wrote:
>> On 01/15/2014 02:55 PM, Paul Burton wrote:
>>> Declaring this allows drivers which need to initialise each struct
>>> cpuidle_device at initialisation time to make use of the structures
>>> already defined in cpuidle.c, rather than having to wastefully defi=
ne
>>> their own.
>>>
>>> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
>>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: linux-pm@vger.kernel.org
>>> ---
>>>   include/linux/cpuidle.h | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
>>> index 50fcbb0..bab4f33 100644
>>> --- a/include/linux/cpuidle.h
>>> +++ b/include/linux/cpuidle.h
>>> @@ -84,6 +84,7 @@ struct cpuidle_device {
>>>   };
>>>
>>>   DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
>>> +DECLARE_PER_CPU(struct cpuidle_device, cpuidle_dev);
>>
>>
>> Nak. When a device is registered, it is assigned to the cpuidle_devi=
ces
>> pointer and the backend driver should use it.
>>
>
> Yes, but then if the driver needs to initialise the coupled_cpus mask
> then it cannot do so until after the device has been registered. Duri=
ng
> registration the cpuidle_coupled_register_device will then see the em=
pty
> coupled_cpus mask & do nothing. The only other ways around this would=
 be
> for the driver to define its own per-cpu struct cpuidle_device (which=
 as
> I state in the commit message seems wasteful when cpuidle already
> defined them), or for cpuidle_coupled_register_device to be called la=
ter
> after the driver had a chance to modify devices via the cpuidle_devic=
es
> pointers.

Yeah. I understand why you wanted to declare these cpu variables.

The mips cpuidle driver sounds like a bit particular. I believe I need=20
some clarification on the behavior of the hardware to understand=20
correctly the driver. Could you explain how the couples act vs the cpu =
?=20
And why cpu_sibling is used instead of cpu_possible_mask ?



>> --
>>   <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software=
 for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

