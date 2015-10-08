From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 4/4] w1:slaves:bq27000: load battery driver kernel module if required
Date: Thu, 8 Oct 2015 09:26:26 +0200
Message-ID: <7F953A3F-D9F5-4BA0-A7B5-0CF8AAB5C937@goldelico.com>
References: <cover.1444243358.git.hns@goldelico.com> <c9ee31c641a8612c49172123cd56407484e699d6.1444243358.git.hns@goldelico.com> <201510080026.21233@pali>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:45091 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753547AbbJHH0d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2015 03:26:33 -0400
In-Reply-To: <201510080026.21233@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?iso-8859-1?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org


Am 08.10.2015 um 00:26 schrieb Pali Roh=E1r <pali.rohar@gmail.com>:

> On Wednesday 07 October 2015 20:42:39 H. Nikolaus Schaller wrote:
>> Explicitly call request_module() in the wrapper so that the
>> bq27x00_battery driver is loded on demand, when compiled as module.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> drivers/w1/slaves/w1_bq27000.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>=20
>> diff --git a/drivers/w1/slaves/w1_bq27000.c
>> b/drivers/w1/slaves/w1_bq27000.c index caafb17..745bd6e 100644
>> --- a/drivers/w1/slaves/w1_bq27000.c
>> +++ b/drivers/w1/slaves/w1_bq27000.c
>> @@ -49,6 +49,8 @@ static int w1_bq27000_add_slave(struct w1_slave
>> *sl) int ret;
>> 	struct platform_device *pdev;
>>=20
>> +	request_module("bq27x00_battery");  /* load as module if needed */
>> +
>> 	pdev =3D platform_device_alloc("bq27000-battery", -1);
>> 	if (!pdev) {
>> 		ret =3D -ENOMEM;
>=20
> Hi! Function platform_device_alloc would allocate kernel device and i=
t=20
> should also load appropriate kernel driver (via platform:bq27000-batt=
ery=20
> alias). If that does not work, problem is somewhere else. Maybe depmo=
d=20
> is not properly generated? Or bq27x00_batter.ko modules does not cont=
ain=20
> needed alias?

alias exists:

#ifdef CONFIG_BATTERY_BQ27X00_PLATFORM
MODULE_ALIAS("platform:bq27000-battery");
#endif

depmod entry exist:

root@letux:~# modprobe -c | fgrep bq27
alias i2c:bq27000_battery bq27x00_battery
alias i2c:bq27200 bq27x00_battery
alias i2c:bq27425 bq27x00_battery
alias i2c:bq27500 bq27x00_battery
alias i2c:bq27510 bq27x00_battery
alias i2c:bq27742 bq27x00_battery
alias platform:bq27000_battery bq27x00_battery
alias w1_family_0x01 w1_bq27000

And I have traced all calls to call_modprobe

[    9.969085] call_modprobe w1-family-0x01
[   10.189727] call_modprobe bq27x00_battery
[   29.879333] call_modprobe net-pf-10
[   30.530548] call_modprobe netdev-eth0
[   30.548156] call_modprobe eth0
[   30.565063] call_modprobe netdev-eth0
[   30.581420] call_modprobe eth0
[   31.301300] call_modprobe netdev-eth1
[   31.316101] call_modprobe eth1
[   32.008270] call_modprobe usbfunc:ecm
[   35.554748] call_modprobe net-pf-16-proto-9
[   36.243164] call_modprobe net-pf-31
[   36.614410] call_modprobe bt-proto-4
[   73.888122] call_modprobe net-pf-16-proto-9
[   73.921112] call_modprobe net-pf-16-proto-9
[   77.153625] call_modprobe net-pf-16-proto-9
[   77.188262] call_modprobe net-pf-16-proto-9
[   77.342895] call_modprobe net-pf-16-proto-9
[   77.389129] call_modprobe net-pf-16-proto-9
[   77.419006] call_modprobe net-pf-16-proto-9

And there is only the line I have added. I.e. I can't find an automatic=
 attempt
to load the platform:bq27000-battery. It also doesn't help to change to=
=20
platform_device_alloc("bq27000_battery", -1)

So I think platform_device_alloc() does only what it tells: it allocate=
s a device
but does *not* try to load a kernel module. It only binds to a driver c=
ompiled
into the kernel. AFAIR the I2C bus driver also calls request_module() a=
t some
stage after finding a client (i2c:bq27000_battery).

> Adding request_module() here is not proper solution. Real problem is=20
> somewhere else... Anyway there is series of patches for bq27x00_batte=
ry=20
> which should cleanup some problems, so maybe they also fix your probl=
em.

Is there a tree where I can pull the patches to cross-check if they cha=
nge
something?

BR,
Nikolaus

