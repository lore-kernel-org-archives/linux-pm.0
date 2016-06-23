From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle/powernv: Fix snooze timeout
Date: Thu, 23 Jun 2016 16:36:01 +0200
Message-ID: <576BF3D1.6030507@linaro.org>
References: <1466624203-1847-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <576B23EB.7080903@gmail.com> <576B6C64.6060206@linux.vnet.ibm.com>
 <576BABC5.7020600@gmail.com> <576BB395.5050502@linaro.org>
 <576BE58F.9030303@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37616 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbcFWOgD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jun 2016 10:36:03 -0400
Received: by mail-wm0-f43.google.com with SMTP id a66so53078997wme.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Jun 2016 07:36:02 -0700 (PDT)
In-Reply-To: <576BE58F.9030303@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, anton@samba.org, linuxppc-dev@lists.ozlabs.org

On 06/23/2016 03:35 PM, Shreyas B Prabhu wrote:
>
>
> On 06/23/2016 03:31 PM, Daniel Lezcano wrote:
>> On 06/23/2016 11:28 AM, Balbir Singh wrote:
>>
>> [ ... ]
>>
>>>> cpuidle_enter_state()
>>>> {
>>>>      [...]
>>>>      time_start =3D local_clock();
>>>>      [enter idle state]
>>>>      time_end =3D local_clock();
>>>>      /*
>>>>            * local_clock() returns the time in nanosecond, let's s=
hift
>>>>            * by 10 (divide by 1024) to have microsecond based time=
=2E
>>>>            */
>>>>           diff =3D (time_end - time_start) >> 10;
>>>>      [...]
>>>>      dev->last_residency =3D (int) diff;
>>>> }
>>>>
>>>> Because of >>10 as opposed to /1000, last_residency is lesser by 2=
=2E3%
>>
>> I am surprised the last_residency is 2.3% exactly less. The differen=
ce
>> between >>10 and /1000 is 2.34%.
>>
>> What is the next target residency value ?
>>
> Target residency of the next idle state is 100 microseconds.
> When snooze times out after 100 microseconds, last_residency value
> calculated is typically 97 or 98 microseconds.

I see, the snooze exit is very fast.

>> Does it solve the issue if you replace >>10 by /1000 ?
>>
>
> Yes it does.

Ok. IMO, it would be cleaner to fix this in the core code.

   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

