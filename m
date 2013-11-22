From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: cpuidle governors
Date: Fri, 22 Nov 2013 19:17:10 +0100
Message-ID: <528F9FA6.8080905@linaro.org>
References: <1383831870.4370.382.camel@chaos.site>	 <527B9BA2.4060100@linaro.org> <1385106338.4373.11.camel@chaos.site>	 <528F7DB9.6020204@intel.com>  <528F82F4.3080005@linaro.org> <1385143611.4840.7.camel@chaos.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:37667 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113Ab3KVSRG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Nov 2013 13:17:06 -0500
Received: by mail-we0-f176.google.com with SMTP id t61so1484295wes.7
        for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2013 10:17:05 -0800 (PST)
In-Reply-To: <1385143611.4840.7.camel@chaos.site>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org

On 11/22/2013 07:06 PM, Jean Delvare wrote:
> Hi Daniel,
>
> Le Friday 22 November 2013 =C3=A0 17:14 +0100, Daniel Lezcano a =C3=A9=
crit :
>> On 11/22/2013 04:52 PM, Rafael J. Wysocki wrote:
>>> On 11/22/2013 8:45 AM, Jean Delvare wrote:
>>>> My own testing revealed:
>>>>
>>>> * That a kernel built without NO_HZ still gets cpuidle governor "m=
enu".
>>>> This contradicts your statement above.
>>>> * That a NO_HZ kernel booted with nohz=3Doff behaves differently t=
han a
>>>> kernel built without NO_HZ with regards to cpuidle. Both use the "=
menu"
>>>> governor by default (while I understand they should rather not), b=
ut in
>>>> the latter case deep C states are reached while in the former they=
 never
>>>> are. This smells like a second bug.
>>>>
>>>> I would appreciate if both bugs could get fixed.
>>>
>>> Yes, it looks like we have two separate bugs there.
>>
>> Actually, the first one is a bug but not the second one.
>>
>> I made some changes to select by default the menu governor with NO_H=
Z
>> and the ladder governor without NO_HZ and wanted to remove the unnee=
ded
>> governor from the Kconfig. But we let it as it was to keep the old
>> behavior. Unfortunately, the governor rating decision will always go=
es
>> in favor of the menu governor as it is the best one even if we are *=
not*
>> with NO_HZ. So the only way to prevent is to set in the kernel comma=
nd
>> line the option 'cpuidle_sysfs_switch' and from the userspace set th=
e
>> ladder governor when the system has booted.
>
> That's what I ended up doing, yes, but I don't like it, because 1* it=
's
> not as straightforward as a cpuidle.governor=3Dxxx option and 2* I do=
n't
> think I should have to change the governor manually in the first plac=
e.
>
>> A fix could be to remove from the configuration the governor which d=
oes
>> not suit the NO_HZ option.
>
> That's not a good idea because nohz=3Doff can be passed on the comman=
d
> line to reenable the ticking at runtime. So the governor must be deci=
ded
> at runtime too.
>
>> Another fix would be to play with the rating and change them dependi=
ng
>> on the NO_HZ option.
>
> Yes, I think this is better, because then you can honor nohz=3Doff.

Yes, good point.

>> Concerning the second bug, it is not a bug but totally normal. On a
>> periodic tick system, (aka NO_HZ=3Dno), the periodic timer duration
>> prevents to enter a deep idle state. The target residency for the st=
ate,
>> which is never reached, should be on your system greater than the
>> periodic tick duration.
>
> Not sure if you read what I wrote properly. The menu governor _does_
> work at least to some degree without NO_HZ, even if it is less effici=
ent
> than with NO_HZ (no surprise here.) What bothers me is that NO_HZ=3Dy=
 +
> nohz=3Doff behaves differently than NO_HZ=3Dn. I believe they should =
behave
> the same.

Yes, you are right I misunderstood it.

Thanks
   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

