From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: cpuidle governors
Date: Fri, 22 Nov 2013 17:14:44 +0100
Message-ID: <528F82F4.3080005@linaro.org>
References: <1383831870.4370.382.camel@chaos.site>	 <527B9BA2.4060100@linaro.org> <1385106338.4373.11.camel@chaos.site> <528F7DB9.6020204@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:34254 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041Ab3KVQOk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Nov 2013 11:14:40 -0500
Received: by mail-wg0-f50.google.com with SMTP id k14so1360302wgh.5
        for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2013 08:14:38 -0800 (PST)
In-Reply-To: <528F7DB9.6020204@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Jean Delvare <jdelvare@suse.de>
Cc: linux-pm@vger.kernel.org

On 11/22/2013 04:52 PM, Rafael J. Wysocki wrote:
> On 11/22/2013 8:45 AM, Jean Delvare wrote:
>> Hi Daniel,
>>
>> Thanks for your fast reply and sorry for my slow one :(
>>
>> Le Thursday 07 November 2013 =C3=A0 14:54 +0100, Daniel Lezcano a =C3=
=A9crit :
>>> On 11/07/2013 02:44 PM, Jean Delvare wrote:
>>>> Hi all,
>>>>
>>>> I had to work on cpuidle recently and there are two things which c=
aused
>>>> me trouble and I'd like to discuss.
>>>>
>>>> 1* Is there no documentation about how the available governors (me=
nu
>>>> and
>>>> ladder) work? I found good documentation of the general architectu=
re
>>>> and
>>>> API in Documentation/cpuidle, but I am missing a description of th=
e
>>>> internal logic of each available governor (just like
>>>> Documentation/cpu-freq/governors.txt for cpufreq.)
>>> IMO, the code review and the header description in the menu.c file =
is
>>> the best way to understand how the governor works.
>> OK, I'll look at the code then. But I still believe this should be
>> documented for clarity.
>>
>>> For very specific
>>> questions, try asking in the mailing list.
>> I'm doing that right now ;)
>>
>>>> Also, the
>>>> documentation says that "the kernel picks the best governor based =
on
>>>> governor ratings" but that's pretty vague. An explanation of how t=
he
>>>> governors are rated would be good to have. Could this be added?
>>> Yeah, actually they are rated but depending on the system configura=
tion
>>> one fit better than the other one. Tickless system =3D> menu govern=
or,
>>> Periodic system =3D> ladder governor. Using a tickless system with =
the
>>> ladder governor is less efficient from a power saving POV.
>> My original issue is somewhat related to this. One customer reported=
 to
>> us that booting with nohz=3Doff breaks cpuidle. My own testing revea=
led:
>>
>> * That a kernel built without NO_HZ still gets cpuidle governor "men=
u".
>> This contradicts your statement above.
>> * That a NO_HZ kernel booted with nohz=3Doff behaves differently tha=
n a
>> kernel built without NO_HZ with regards to cpuidle. Both use the "me=
nu"
>> governor by default (while I understand they should rather not), but=
 in
>> the latter case deep C states are reached while in the former they n=
ever
>> are. This smells like a second bug.
>>
>> I would appreciate if both bugs could get fixed.
>
> Yes, it looks like we have two separate bugs there.

Actually, the first one is a bug but not the second one.

I made some changes to select by default the menu governor with NO_HZ=20
and the ladder governor without NO_HZ and wanted to remove the unneeded=
=20
governor from the Kconfig. But we let it as it was to keep the old=20
behavior. Unfortunately, the governor rating decision will always goes=20
in favor of the menu governor as it is the best one even if we are *not=
*=20
with NO_HZ. So the only way to prevent is to set in the kernel command=20
line the option 'cpuidle_sysfs_switch' and from the userspace set the=20
ladder governor when the system has booted.

A fix could be to remove from the configuration the governor which does=
=20
not suit the NO_HZ option.

Another fix would be to play with the rating and change them depending=20
on the NO_HZ option.

Concerning the second bug, it is not a bug but totally normal. On a=20
periodic tick system, (aka NO_HZ=3Dno), the periodic timer duration=20
prevents to enter a deep idle state. The target residency for the state=
,=20
which is never reached, should be on your system greater than the=20
periodic tick duration.

Hope that helps.

   -- Daniel


>
>>   I can fill out bugzilla entries if it helps.
>
> Please do, that helps a lot.
>
> Thanks,
> Rafael
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

