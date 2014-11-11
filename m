From: jonghwa3.lee@samsung.com
Subject: Re: [PATCH 2/3] power: core: Add variables related temperature to
 power_supply_info.
Date: Tue, 11 Nov 2014 09:30:24 +0900
Message-ID: <546158A0.5000707@samsung.com>
References: <1412679518-21499-1-git-send-email-jonghwa3.lee@samsung.com>
 <1412679518-21499-3-git-send-email-jonghwa3.lee@samsung.com>
 <20ADAB092842284E95860F279283C5642ED9EDE3@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:50020 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbaKKAa1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Nov 2014 19:30:27 -0500
In-reply-to: <20ADAB092842284E95860F279283C5642ED9EDE3@BGSMSX104.gar.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Tc, Jenny" <jenny.tc@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "anton@enomsg.org" <anton@enomsg.org>, "pavel@ucw.cz" <pavel@ucw.cz>

On 2014=EB=85=84 11=EC=9B=94 10=EC=9D=BC 20:16, Tc, Jenny wrote:

>> @@ -241,6 +241,8 @@ struct power_supply_info {
>>  	int charge_empty_design;
>>  	int energy_full_design;
>>  	int energy_empty_design;
>> +	int temperature_max;
>> +	int temperature_min;
>>  	int use_for_apm;
>>  };
>=20
>=20
> The CC,CV and restart threshold would vary based on the battery tempe=
rature
> So I would suggest to have temperature zone table as part  of battery=
 info
> along with other attributes.
>=20
> int iterm; //charge termination current (used to stop charging)
> int temp_zone_count; // number of temperature zone tables present
> struct batt_temp_mon_table temp_mon_tbl[MAX_TEMP_MON_TABLE]; //temper=
ature zone table array
>=20
> struct  batt_temp_mon_table {
> 	 short int temp_max;
> 	 short int cc;
> 	 short int cv;
> 	 short int vbat_vchk_drop_uv;
> 	 short int temp_min;
> };
>=20


IMO, throttling cc/cv according the temperature can be done via thermal=
 fw
interface. However voltage drop and charging termination current can be=
 added here.


Jonghwa

> -Jenny
>=20
>=20


