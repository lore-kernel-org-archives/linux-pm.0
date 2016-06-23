From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle/powernv: Fix snooze timeout
Date: Thu, 23 Jun 2016 12:01:57 +0200
Message-ID: <576BB395.5050502@linaro.org>
References: <1466624203-1847-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <576B23EB.7080903@gmail.com> <576B6C64.6060206@linux.vnet.ibm.com>
 <576BABC5.7020600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38369 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbcFWKB7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jun 2016 06:01:59 -0400
Received: by mail-wm0-f42.google.com with SMTP id r201so42163378wme.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Jun 2016 03:01:58 -0700 (PDT)
In-Reply-To: <576BABC5.7020600@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Balbir Singh <bsingharora@gmail.com>, Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, anton@samba.org, linuxppc-dev@lists.ozlabs.org

On 06/23/2016 11:28 AM, Balbir Singh wrote:

[ ... ]

>> cpuidle_enter_state()
>> {
>> 	[...]
>> 	time_start =3D local_clock();
>> 	[enter idle state]
>> 	time_end =3D local_clock();
>> 	/*
>>           * local_clock() returns the time in nanosecond, let's shif=
t
>>           * by 10 (divide by 1024) to have microsecond based time.
>>           */
>>          diff =3D (time_end - time_start) >> 10;
>> 	[...]
>> 	dev->last_residency =3D (int) diff;
>> }
>>
>> Because of >>10 as opposed to /1000, last_residency is lesser by 2.3=
%

I am surprised the last_residency is 2.3% exactly less. The difference=20
between >>10 and /1000 is 2.34%.

What is the next target residency value ?

Does it solve the issue if you replace >>10 by /1000 ?



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

