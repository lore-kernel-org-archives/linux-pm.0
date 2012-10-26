From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: add missing header include
Date: Fri, 26 Oct 2012 14:45:02 +0200
Message-ID: <508A85CE.2010601@linaro.org>
References: <001401cdb332$93ffe450$bbffacf0$%han@samsung.com> <6329232.eg8Mc603Uh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51794 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932591Ab2JZMpH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Oct 2012 08:45:07 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1244803bkc.19
        for <linux-pm@vger.kernel.org>; Fri, 26 Oct 2012 05:45:05 -0700 (PDT)
In-Reply-To: <6329232.eg8Mc603Uh@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jingoo Han <jg1.han@samsung.com>, "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/26/2012 01:14 PM, Rafael J. Wysocki wrote:
> On Friday, October 26, 2012 01:30:07 PM Jingoo Han wrote:
>> This patch adds missing device.h header to fix build warnings as bel=
ow:
>>
>> drivers/cpuidle/cpuidle.h:26:41: warning: 'struct device' declared i=
nside parameter list [enabled by default]
>> drivers/cpuidle/cpuidle.h:26:41: warning: its scope is only this def=
inition or declaration, which is probably not what you want
>> [enabled by default]
>> drivers/cpuidle/cpuidle.h:27:45: warning: 'struct device' declared i=
nside parameter list [enabled by default]
>> In file included from drivers/cpuidle/driver.c:15:0:
>> drivers/cpuidle/cpuidle.h:26:41: warning: 'struct device' declared i=
nside parameter list [enabled by default]
>> drivers/cpuidle/cpuidle.h:26:41: warning: its scope is only this def=
inition or declaration, which is probably not what you want
>> [enabled by default]
>> drivers/cpuidle/cpuidle.h:27:45: warning: 'struct device' declared i=
nside parameter list [enabled by default]
>>
>> This build warning is introduced by commit efeca1b
>> "cpuidle / sysfs: change function parameter".
>>
>> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>=20
> I fixed up the original patch.
>=20
> Daniel, I must say I'm less and less impressed by the quality of code
> I'm getting from you.  Please improve it.

Rafael,

I am sorry there are some compilation problems with the code.

I am trying to improve and cleanup step by step the code. I would
understand you remark if I send you untested patches but I always take
care of making the patches git-bisect safe, compile and boot for every
patch.

I double checked the patch and I was able to compile without problem
with my config file.

Jingoo, would you mind to pastebin your config file please ?

If I can compile without problem and Jingoo can't compile, that means
there is something wrong with the headers and including device.h in the
cpuidle.h does not solve the root problem. Furthermore, driver.c does
not use the struct device.

At the first glance, adding a forward declaration in cpuidle.h

  struct device;

and including device.h for sysfs.c should fix the problem.

There are so many combinations for the configuration that it makes
possible I miss one config option and when the code defines implicit
rules difficult to track like the _COMPONENT macro in acpi, that makes
it harder.

=46or example, include/linux/pm_qos.h includes device.h, but it is not
needed because a forward declaration should suffice and it is up to the
=2Ec files to include device.h if they manipulate the struct device.
If I fix that, it is possible, with my best effort, to miss a .c to add
the device.h file if the option is not set for it.

I promise to try improving the code but please accept some parts of the
current code look like a jackstraws, don't blame me too much if
sometimes I introduce some errors.

Thanks
  -- Daniel


>> ---
>>  drivers/cpuidle/cpuidle.h |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle.h b/drivers/cpuidle/cpuidle.h
>> index a5bbd1c..2120d9e 100644
>> --- a/drivers/cpuidle/cpuidle.h
>> +++ b/drivers/cpuidle/cpuidle.h
>> @@ -5,6 +5,8 @@
>>  #ifndef __DRIVER_CPUIDLE_H
>>  #define __DRIVER_CPUIDLE_H
>> =20
>> +#include <linux/device.h>
>> +
>>  /* For internal use only */
>>  extern struct cpuidle_governor *cpuidle_curr_governor;
>>  extern struct list_head cpuidle_governors;
>>


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

