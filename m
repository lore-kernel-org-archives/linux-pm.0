From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC/RFT v2 0/2] power_supply: Fix NULL pointer dereference from uevent
Date: Thu, 21 May 2015 07:39:52 +0200
Message-ID: <0D9D5B5F-3FAB-4AC4-89DA-1001F522BD02@goldelico.com>
References: <1432019582-27612-1-git-send-email-k.kozlowski@samsung.com> <77C4D085-96E6-4874-BD7A-AC4BDFAC3A58@goldelico.com> <20150520222053.GC28218@earth>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:42110 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186AbbEUFjy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 May 2015 01:39:54 -0400
In-Reply-To: <20150520222053.GC28218@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


Am 21.05.2015 um 00:20 schrieb Sebastian Reichel <sre@kernel.org>:

> Hi,
>=20
> On Tue, May 19, 2015 at 10:28:39AM +0200, Dr. H. Nikolaus Schaller wr=
ote:
>> Am 19.05.2015 um 09:13 schrieb Krzysztof Kozlowski <k.kozlowski@sams=
ung.com>:
>>> Changes since v1:
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> 1. Patch 2: fix invalid member used for container_of().
>>> 2. Patch 2: Replace WARN with pr_warn() in __power_supply_register(=
)
>>>  if parent is missing.
>>>=20
>>>=20
>>> Description:
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> This is an idea to fix issue in bq27x00 driver (and probably in oth=
ers)
>>> reported by H. Nikolaus Schaller [0].
>>>=20
>>> The fixes are marked RFC/RFT because:
>>> 1. I do not have bq27x00-like device. I confirmed this and tested o=
n
>>>  modified drivers (max77693, ACPI AC). These drivers are not
>>>  impacted by the issue but one can easily adjust them to reproduce
>>>  the problem.
>>> 2. The first uevent coming from power_supply_register() is now
>>>  different because it won't contain device properties. I am
>>>  not sure how this impacts userspace.
>>>=20
>>> Comments are welcomed.
>>=20
>> appears to work! bq27000 is coming up now without hickups.
>>=20
>> What I can=92t test is if the uevent is reasonable because we do not
>> have a specific rule triggered by it in our system.
>>=20
>> So from my side we are now happy with the solution.
>=20
> So you would be ok with the following added to the patches?
>=20
> Tested-By: Dr. H. Nikolaus Schaller <hns@goldelico.com>

Yes, please add.

BR,
Nikolaus

