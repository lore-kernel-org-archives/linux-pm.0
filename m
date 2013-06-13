From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/8] cpuidle: Remove governor module format
Date: Thu, 13 Jun 2013 13:57:10 +0200
Message-ID: <51B9B396.8060906@linaro.org>
References: <1371042535-22630-1-git-send-email-daniel.lezcano@linaro.org> <1584034.uif9lZguq4@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47276 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938Ab3FML5J (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jun 2013 07:57:09 -0400
Received: by mail-bk0-f46.google.com with SMTP id na10so5111987bkb.19
        for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2013 04:57:08 -0700 (PDT)
In-Reply-To: <1584034.uif9lZguq4@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org

On 06/13/2013 12:53 AM, Rafael J. Wysocki wrote:
> On Wednesday, June 12, 2013 03:08:48 PM Daniel Lezcano wrote:
>> The governors are defined as module in the code, but the Kconfig opt=
ions do not
>> allow to compile them as module. This is not really a problem but th=
e init
>> order is: the cpuidle init functions (framework and driver) and then=
 the
>> governors. That leads to some weirdness in the cpuidle framework bec=
ause the
>> function cpuidle_register_device calls cpuidle_enable_device which i=
n turns
>> fails at the first attempt because no governor is registered. When t=
he
>> governor is registered, the framework calls cpuidle_enable_device ag=
ain which
>> will invoke the __cpuidle_register_device function. Of course, in or=
der to make
>> this to work, the return code of cpuidle_enable_device is not checke=
d by the
>> caller in cpuidle_register_device.
>>
>> Instead of having this cyclic call graph and relying on a positive s=
ide effect
>> of the hackish back and forth call to cpuidle_enable_device, let's f=
ix the
>> init order for the governor in order to clean up the cpuidle_enable_=
device
>> function.
>>
>> Remove the module init code and replaced it with postcore_initcall, =
so we have:
>>
>>  * cpuidle framework : core_initcall
>>  * cpuidle governors : postcore_initcall
>>  * cpuidle drivers   : device_initcall
>>
>> Remove exit module code as it is dead code (governors aren't compile=
d as
>> module).
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>=20
> That's something I'd like to receive much earlier in the cycle (aroun=
d -rc2).
>=20
> Honestly, I'm not sure if it's going to make it into 3.11 even if nob=
ody has
> any comments.

It is ok, choose what is the more convenient to stabilize the kernel.

>> ---
>>  drivers/cpuidle/governors/ladder.c |   12 +-----------
>>  drivers/cpuidle/governors/menu.c   |   12 +-----------
>>  2 files changed, 2 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/go=
vernors/ladder.c
>> index 9b78405..9f08e8c 100644
>> --- a/drivers/cpuidle/governors/ladder.c
>> +++ b/drivers/cpuidle/governors/ladder.c
>> @@ -192,14 +192,4 @@ static int __init init_ladder(void)
>>  	return cpuidle_register_governor(&ladder_governor);
>>  }
>> =20
>> -/**
>> - * exit_ladder - exits the governor
>> - */
>> -static void __exit exit_ladder(void)
>> -{
>> -	cpuidle_unregister_governor(&ladder_governor);
>> -}
>> -
>> -MODULE_LICENSE("GPL");
>> -module_init(init_ladder);
>> -module_exit(exit_ladder);
>> +postcore_initcall(init_ladder);
>> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/gove=
rnors/menu.c
>> index fe343a0..743138c 100644
>> --- a/drivers/cpuidle/governors/menu.c
>> +++ b/drivers/cpuidle/governors/menu.c
>> @@ -540,14 +540,4 @@ static int __init init_menu(void)
>>  	return cpuidle_register_governor(&menu_governor);
>>  }
>> =20
>> -/**
>> - * exit_menu - exits the governor
>> - */
>> -static void __exit exit_menu(void)
>> -{
>> -	cpuidle_unregister_governor(&menu_governor);
>> -}
>> -
>> -MODULE_LICENSE("GPL");
>> -module_init(init_menu);
>> -module_exit(exit_menu);
>> +postcore_initcall(init_menu);
>>


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

