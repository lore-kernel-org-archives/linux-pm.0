From: jonghwa3.lee@samsung.com
Subject: Re: [PATCH RESEND v2 03/10] power: charger-manager: Remove deprecated
 function, cm_notify_event().
Date: Fri, 19 Dec 2014 17:32:41 +0900
Message-ID: <5493E2A9.6050407@samsung.com>
References: <1255984171.39711418975524329.JavaMail.weblogic@epmlwas08d>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:15452 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbaLSIcr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Dec 2014 03:32:47 -0500
In-reply-to: <1255984171.39711418975524329.JavaMail.weblogic@epmlwas08d>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "anton@enomsg.org" <anton@enomsg.org>, "pavel@ucw.cz" <pavel@ucw.cz>, =?UTF-8?B?7LWc7LCs7Jqw?= <cw00.choi@samsung.com>

On 2014=EB=85=84 12=EC=9B=94 19=EC=9D=BC 16:52, MyungJoo Ham wrote:

>>  =20
>>  cm_notify_event() is introduced to get event associated with batter=
y status
>> externally, but no one had been used. Moreover it makes charger mana=
ger
>> driver more complicated. This patch tries to drop the function and a=
ll data
>> related to simplify the driver.
>>
>> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
>=20
> You are not just removing cm_notify_event() and its related.
>=20
> You are hereby removing the much of software charger control
> and suspend-related operations. Could you please be more specific
> on why? (many of such features are to comply with operators' requirem=
ents)
>=20


Unfortunately, all those codes are only for cm_notify_event(). Currentl=
y, and
since charger-manager has been introduced then, there's no one to use i=
t. And
the works of cm_notify_event() are is just notifying the event to user =
space or
reset the polling work. We may need passive method to get event related=
 with
battery status externally, if so we can use power_supply class notifica=
tion
method, power_supply_notifier.

I decided to remove it to make driver simple and clean.

Thanks,
Jonghwa


> (Or we may meet next Monday for some discussions :) )
>=20
>> ---
>>  .../bindings/power_supply/charger-manager.txt      |    1 -
>>  drivers/power/charger-manager.c                    |  196 +--------=
-----------
>>  include/linux/power/charger-manager.h              |   19 +-
>>  3 files changed, 8 insertions(+), 208 deletions(-)
>>


