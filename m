From: jonghwa3.lee@samsung.com
Subject: Re: [PATCH 1/3] power: core: Add generic interface to get battery
 specification.
Date: Mon, 10 Nov 2014 10:10:54 +0900
Message-ID: <5460109E.9060603@samsung.com>
References: <1412679518-21499-1-git-send-email-jonghwa3.lee@samsung.com>
 <1412679518-21499-2-git-send-email-jonghwa3.lee@samsung.com>
 <20ADAB092842284E95860F279283C5642ED8AE04@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:31777 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbaKJBK5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 9 Nov 2014 20:10:57 -0500
In-reply-to: <20ADAB092842284E95860F279283C5642ED8AE04@BGSMSX104.gar.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Tc, Jenny" <jenny.tc@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "anton@enomsg.org" <anton@enomsg.org>, "pavel@ucw.cz" <pavel@ucw.cz>

On 2014=EB=85=84 11=EC=9B=94 08=EC=9D=BC 19:13, Tc, Jenny wrote:

>> +ATOMIC_NOTIFIER_HEAD(psy_battery_info_notifier);
>=20
>  Isn't it good to reuse the existing power_supply_notifier for this?
>=20
>> +enum battery_info_notifier_events {
>> +	PSY_BATT_INFO_REGISTERED,
>> +	PSY_BATT_INFO_UNREGISTERED,
>> +};
>=20
> If we use the power_supply_notifier, then this can be moved to
> enum power_supply_notifier_events
>=20


It doesn't use power_supply_notifier, rather than it uses newly introdu=
ced
notifier for battery information. Intention of making of new notifier b=
lock here
is to extinguish event from power_supply_changed which might be noisy f=
or
battery information consumer. However, If it looks wasteful code, it's =
not a big
deal to use existed power_supply_notifier.

Thanks,
Jonghwa

