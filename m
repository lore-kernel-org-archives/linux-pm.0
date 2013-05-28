From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: improve governor Kconfig options
Date: Tue, 28 May 2013 23:39:28 +0200
Message-ID: <51A52410.8090608@linaro.org>
References: <1369688458-9114-1-git-send-email-daniel.lezcano@linaro.org> <5938372.bcA6BTeOGP@vostro.rjw.lan> <51A4AFD9.3020109@linaro.org> <1687661.MEWgzcOBGL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:54544 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932260Ab3E1Vjc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 May 2013 17:39:32 -0400
Received: by mail-wi0-f182.google.com with SMTP id c10so2934828wiw.9
        for <linux-pm@vger.kernel.org>; Tue, 28 May 2013 14:39:30 -0700 (PDT)
In-Reply-To: <1687661.MEWgzcOBGL@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Gleixner <tglx@linutronix.de>

On 05/28/2013 11:26 PM, Rafael J. Wysocki wrote:
> On Tuesday, May 28, 2013 03:23:37 PM Daniel Lezcano wrote:
>> On 05/28/2013 02:42 PM, Rafael J. Wysocki wrote:
>>> On Tuesday, May 28, 2013 02:23:00 PM Daniel Lezcano wrote:
>>>> On 05/28/2013 01:46 PM, Rafael J. Wysocki wrote:
>>>>> On Monday, May 27, 2013 11:00:58 PM Daniel Lezcano wrote:
>>>>>> Each governor is suitable for different kernel configurations: t=
he menu
>>>>>> governor suits better for a tickless system, while the ladder go=
vernor fits
>>>>>> better for a periodic timer tick system.
>>>>>>
>>>>>> The Kconfig does not allow to [un]select a governor, thus both a=
re compiled in
>>>>>> the kernel but the init order makes the menu governor to be the =
last one to be
>>>>>> registered, so becoming the default. The only way to switch back=
 to the ladder
>>>>>> governor is to enable the sysfs governor switch in the kernel co=
mmand line.
>>>>>>
>>>>>> Because it seems nobody complained about this, the menu governor=
 is used by
>>>>>> default most of the time on the system, having both governors is=
 not really
>>>>>> necessary on a tickless system but there isn't a config option t=
o disable one
>>>>>> or another governor.
>>>>>>
>>>>>> Create a submenu for cpuidle and add a label for each governor, =
so we can see
>>>>>> the option in the menu config and enable/disable it.
>>>>>>
>>>>>> The governors will be enabled depending on the CONFIG_NO_HZ opti=
on:
>>>>>>  - If CONFIG_NO_HZ is set, then the menu governor is selected an=
d the ladder
>>>>>>    governor is optional, defaulting to 'no'
>>>>>
>>>>> Why not defaulting to 'yes'?  That'd be backwards compatible, wou=
ldn't it?
>>>>
>>>> Yes, that wouldn't be backward compatible but who wants the ladder
>>>> governor which is less efficient with a tickless system ?
>>>
>>> I don't know and this isn't the right question to ask I think.
>>>
>>> You need to ask who uses the ladder governor with CONFIG_NO_HZ and =
you need to
>>> avoid making changes that aren't backwards compatible if you don't =
know the
>>> answer (which I'm pretty sure is the case).
>>>
>>> I'd prefer to default to 'yes' to start with and then to change the
>>> default to 'no' after a couple of cycles, possibly.
>>>
>>>>>>  - If CONFIG_NO_HZ is not set, then the ladder governor is selec=
ted and the
>>>>>>    menu governor is optional, defaulting to 'no'
>>>>>
>>>>> Are you sure this is not going to introduce regressions with CONF=
IG_NO_HZ
>>>>> unset?
>>>>
>>>> Yes, a system configured with a periodic tick will use the ladder
>>>> instead of the menu governor (which is less efficient on this
>>>> configuration).
>>>
>>> Well, "less efficient" meaning what exactly?  Less power-efficient =
or less
>>> efficient performance-wise?
>>
>> less power efficient.
>=20
> I thought so, but that's really important, because some people *do* c=
are about
> performance.  In the context of changes like this one we always need =
to talk
> about both power and performance.  For example, when you're saying th=
at
> changing something may lead to better energy saving behavior, you sho=
uld also
> say what the impact of that change on performance is going to be

I fully agree with you but with this very specific case, when the
cpuidle is enabled in the system, it is to have the best trade-off
between performance and power saving. Using the ladder governor on a
tickless system is not power efficient and the performance is not
significantly improved. If the governor is too agressive in power savin=
g
and impacts the performance the pm_qos will guarantee the needed
performance.

Desktop will use tickless system because they want power saving, thus
cpuidle and the menu governor is the best trade-off.

Server will want more responsiveness and will use a periodic timer tick
system, the cpuidle and the ladder suits better.

The pm_qos will ensure a latency for both governors.

But again I agree 100% with you and keeping the old behavior makes sens=
e
until we sort this out clearly in the next cycles.

Thanks
  -- Daniel

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

