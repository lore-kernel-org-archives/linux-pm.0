From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/2] ARM: clps711x: Add cpuidle driver
Date: Mon, 24 Mar 2014 18:15:02 +0100
Message-ID: <53306816.1090809@linaro.org>
References: <1395467076-29462-1-git-send-email-shc_work@mail.ru> <53305094.8010008@linaro.org> <1395679441.129942365@f386.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:44324 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200AbaCXROx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Mar 2014 13:14:53 -0400
Received: by mail-bk0-f41.google.com with SMTP id d7so592658bkh.14
        for <linux-pm@vger.kernel.org>; Mon, 24 Mar 2014 10:14:51 -0700 (PDT)
In-Reply-To: <1395679441.129942365@f386.i.mail.ru>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Kevin Hilman <khilman@linaro.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On 03/24/2014 05:44 PM, Alexander Shiyan wrote:
> Mon, 24 Mar 2014 16:34:44 +0100 =D0=BE=D1=82 Daniel Lezcano <daniel.l=
ezcano@linaro.org>:
>> On 03/22/2014 06:44 AM, Alexander Shiyan wrote:
>>> Add cpuidle support for ARM Cirrus Logic CLPS711X CPUs.
>>> This CPU has an unique internal register and write to this location
>>> will put the system into the Idle State by halting the clock to the
>>> processor until an interrupt is generated.
>>>
>>> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
>>> ---
> ...
>>> +static struct cpuidle_driver clps711x_idle_driver =3D {
>>> +	.name		=3D CLPS711X_CPUIDLE_NAME,
>>> +	.owner		=3D THIS_MODULE,
>>> +	.states[0]	=3D {
>>> +		.name		=3D "HALT",
>>> +		.desc		=3D "CLPS711X HALT",
>>> +		.enter		=3D clps711x_cpuidle_halt,
>>> +		.exit_latency	=3D 1,
>>
>> Did you forget target_residency ? Or just not defined it as it is 0 =
?
>
> Yes, zero value.

Ok, thanks. The driver looks good. I will pick it for 3.16.

Thanks
   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

