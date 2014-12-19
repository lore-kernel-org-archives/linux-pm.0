From: jonghwa3.lee@samsung.com
Subject: Re: [PATCH RESEND v2 02/10] power: charger-manager: Use
 power_supply_changed() not private uevent.
Date: Fri, 19 Dec 2014 17:21:50 +0900
Message-ID: <5493E01E.6090806@samsung.com>
References: <1443120167.38671418974875751.JavaMail.weblogic@epmlwas08d>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:12765 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbaLSIV7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Dec 2014 03:21:59 -0500
In-reply-to: <1443120167.38671418974875751.JavaMail.weblogic@epmlwas08d>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: =?UTF-8?B?7J207KKF7ZmU?= <jonghwa3.lee@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "anton@enomsg.org" <anton@enomsg.org>, "pavel@ucw.cz" <pavel@ucw.cz>, =?UTF-8?B?7LWc7LCs7Jqw?= <cw00.choi@samsung.com>

On 2014=EB=85=84 12=EC=9B=94 19=EC=9D=BC 16:41, MyungJoo Ham wrote:

>>  =20
>>  Whenever battery status is changed, charger manager tries to trigge=
r uevent
>> through private interface. This patch modifies it to use power_suppl=
y_changed()
>> since it belongs to power supply subsystem.
>>
>> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
>=20
> The original uevent_notify() has two additional mechanisms:
> C1. Save events in suspend-again context and show them up at wakeup.
> C2. If the new event is a duplicated event, ignore it.
>=20
> Questions:
> Q1. Have you checked if C1 is met with the modification? Besides, hav=
e
> you made it sure that the modification won't change the behavior of
> suspend-again context? (whether "theoretical" or "experimental")


It won't ruin suspend-again context because it just changes the locatio=
n where
the charger manager's notice to go.

> Q2. Do you still support C2?
>   For example, if we have notifited the user that we are charging
>   30 seconds ago, we should never bother the user with another messag=
e
>   that declares that it is charging unless we have notified that
>   we are not charging since then.
>=20


Above case never happens. If charging state is not changed, the report =
will not
be triggered. Maybe current driver will send same event repeatedly even=
 though,
these patch series will guarantee not to do so.

And also if we have a status changing while short time wake-up which ex=
pects
suspend-again proceeds in near future, I think it is better to notify i=
t to the
user not to keep until undetermined 'TRUE' wake-up.

Thanks,
Jonghwa

> Cheers,
> MyungJoo.
>=20
>> ---
>>  drivers/power/charger-manager.c |   91 +++++-----------------------=
-----------
>>  1 file changed, 11 insertions(+), 80 deletions(-)
>>
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD{=EF=BF=BD=
=EF=BF=BDh=EF=BF=BD=EF=BF=BD=17=EF=BF=BD=EF=BF=BD=DC=A8}=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=C6=A0z=EF=BF=BD&j:+v=EF=BF=BD=EF=BF=BD=EF=BF=BD=07=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD+zf=EF=BF=BD=EF=BF=BD=EF=
=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BD~=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
i=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=
=BF=BD?=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD&=EF=BF=BD)=DF=A2=1Bfl=3D=3D=
=3D


