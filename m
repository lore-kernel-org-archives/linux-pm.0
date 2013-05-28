From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: improve governor Kconfig options
Date: Tue, 28 May 2013 15:23:37 +0200
Message-ID: <51A4AFD9.3020109@linaro.org>
References: <1369688458-9114-1-git-send-email-daniel.lezcano@linaro.org> <1578834.dvFIpyCvrt@vostro.rjw.lan> <51A4A1A4.1070008@linaro.org> <5938372.bcA6BTeOGP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38105 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932491Ab3E1NXl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 May 2013 09:23:41 -0400
Received: by mail-bk0-f46.google.com with SMTP id my13so4260591bkb.19
        for <linux-pm@vger.kernel.org>; Tue, 28 May 2013 06:23:40 -0700 (PDT)
In-Reply-To: <5938372.bcA6BTeOGP@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Gleixner <tglx@linutronix.de>

On 05/28/2013 02:42 PM, Rafael J. Wysocki wrote:
> On Tuesday, May 28, 2013 02:23:00 PM Daniel Lezcano wrote:
>> On 05/28/2013 01:46 PM, Rafael J. Wysocki wrote:
>>> On Monday, May 27, 2013 11:00:58 PM Daniel Lezcano wrote:
>>>> Each governor is suitable for different kernel configurations: the=
 menu
>>>> governor suits better for a tickless system, while the ladder gove=
rnor fits
>>>> better for a periodic timer tick system.
>>>>
>>>> The Kconfig does not allow to [un]select a governor, thus both are=
 compiled in
>>>> the kernel but the init order makes the menu governor to be the la=
st one to be
>>>> registered, so becoming the default. The only way to switch back t=
o the ladder
>>>> governor is to enable the sysfs governor switch in the kernel comm=
and line.
>>>>
>>>> Because it seems nobody complained about this, the menu governor i=
s used by
>>>> default most of the time on the system, having both governors is n=
ot really
>>>> necessary on a tickless system but there isn't a config option to =
disable one
>>>> or another governor.
>>>>
>>>> Create a submenu for cpuidle and add a label for each governor, so=
 we can see
>>>> the option in the menu config and enable/disable it.
>>>>
>>>> The governors will be enabled depending on the CONFIG_NO_HZ option=
:
>>>>  - If CONFIG_NO_HZ is set, then the menu governor is selected and =
the ladder
>>>>    governor is optional, defaulting to 'no'
>>>
>>> Why not defaulting to 'yes'?  That'd be backwards compatible, would=
n't it?
>>
>> Yes, that wouldn't be backward compatible but who wants the ladder
>> governor which is less efficient with a tickless system ?
>=20
> I don't know and this isn't the right question to ask I think.
>=20
> You need to ask who uses the ladder governor with CONFIG_NO_HZ and yo=
u need to
> avoid making changes that aren't backwards compatible if you don't kn=
ow the
> answer (which I'm pretty sure is the case).
>=20
> I'd prefer to default to 'yes' to start with and then to change the
> default to 'no' after a couple of cycles, possibly.
>=20
>>>>  - If CONFIG_NO_HZ is not set, then the ladder governor is selecte=
d and the
>>>>    menu governor is optional, defaulting to 'no'
>>>
>>> Are you sure this is not going to introduce regressions with CONFIG=
_NO_HZ
>>> unset?
>>
>> Yes, a system configured with a periodic tick will use the ladder
>> instead of the menu governor (which is less efficient on this
>> configuration).
>=20
> Well, "less efficient" meaning what exactly?  Less power-efficient or=
 less
> efficient performance-wise?

less power efficient.

>> Currently the default is the menu governor with a periodic tick syst=
em
>> because both governors are compiled in and the init order makes the =
menu
>> governor to be enabled instead of the 'ladder'.
>=20
> I understand that.
>=20
>> We can set both to 'yes' by default but in this case, I suggest to a=
dd
>> in the code a 'preferred' governor depending on tickless or not, so =
the
>> right governor is chosen at boot time depending on CONFIG_NO_HZ.
>>
>> Otherwise, I am not sure people running servers (with a periodic tic=
k)
>> will change their kernel command line option to enable the sysfs
>> governor switch to change the governor to ladder, neither they are a=
ware
>> ladder is better for their system.
>>
>> I am open to any suggestion.
>=20
> I think the change to make the governor preference depend on CONFIG_N=
O_HZ
> kind of makes sense.  However, I'd default to 'yes' for both governor=
s in both
> configurations to start with (which basically means that the ordering=
 will now
> depend on CONFIG_NO_HZ).

Ok, no problem. I will respin the patch.

Thanks for the review

  -- Daniel


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

