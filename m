From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: improve governor Kconfig options
Date: Tue, 28 May 2013 14:23:00 +0200
Message-ID: <51A4A1A4.1070008@linaro.org>
References: <1369688458-9114-1-git-send-email-daniel.lezcano@linaro.org> <1578834.dvFIpyCvrt@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ea0-f175.google.com ([209.85.215.175]:38756 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933730Ab3E1MXF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 May 2013 08:23:05 -0400
Received: by mail-ea0-f175.google.com with SMTP id h10so4524001eaj.20
        for <linux-pm@vger.kernel.org>; Tue, 28 May 2013 05:23:03 -0700 (PDT)
In-Reply-To: <1578834.dvFIpyCvrt@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Gleixner <tglx@linutronix.de>

On 05/28/2013 01:46 PM, Rafael J. Wysocki wrote:
> On Monday, May 27, 2013 11:00:58 PM Daniel Lezcano wrote:
>> Each governor is suitable for different kernel configurations: the m=
enu
>> governor suits better for a tickless system, while the ladder govern=
or fits
>> better for a periodic timer tick system.
>>
>> The Kconfig does not allow to [un]select a governor, thus both are c=
ompiled in
>> the kernel but the init order makes the menu governor to be the last=
 one to be
>> registered, so becoming the default. The only way to switch back to =
the ladder
>> governor is to enable the sysfs governor switch in the kernel comman=
d line.
>>
>> Because it seems nobody complained about this, the menu governor is =
used by
>> default most of the time on the system, having both governors is not=
 really
>> necessary on a tickless system but there isn't a config option to di=
sable one
>> or another governor.
>>
>> Create a submenu for cpuidle and add a label for each governor, so w=
e can see
>> the option in the menu config and enable/disable it.
>>
>> The governors will be enabled depending on the CONFIG_NO_HZ option:
>>  - If CONFIG_NO_HZ is set, then the menu governor is selected and th=
e ladder
>>    governor is optional, defaulting to 'no'
>=20
> Why not defaulting to 'yes'?  That'd be backwards compatible, wouldn'=
t it?

Yes, that wouldn't be backward compatible but who wants the ladder
governor which is less efficient with a tickless system ?

>>  - If CONFIG_NO_HZ is not set, then the ladder governor is selected =
and the
>>    menu governor is optional, defaulting to 'no'
>=20
> Are you sure this is not going to introduce regressions with CONFIG_N=
O_HZ
> unset?

Yes, a system configured with a periodic tick will use the ladder
instead of the menu governor (which is less efficient on this
configuration).

Currently the default is the menu governor with a periodic tick system
because both governors are compiled in and the init order makes the men=
u
governor to be enabled instead of the 'ladder'.

We can set both to 'yes' by default but in this case, I suggest to add
in the code a 'preferred' governor depending on tickless or not, so the
right governor is chosen at boot time depending on CONFIG_NO_HZ.

Otherwise, I am not sure people running servers (with a periodic tick)
will change their kernel command line option to enable the sysfs
governor switch to change the governor to ladder, neither they are awar=
e
ladder is better for their system.

I am open to any suggestion.

Thanks
  -- Daniel

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

