Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.169.86
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794932802;
	b=JqiYfN4Jb/1kxH3FontmgSmvuZzLSuL8Ir1fo7jd5PJlh4AnPeeeZpqbSTw7CnzVfx+S
	 UdMS8x7Q8rfbocuhJ+ut8XMprmDNyqU7YWikqpwnWoRiHSDEYfRCUOVnstFYNHIuzA29s
	 8Y2/p2i7bzF1mMWaSUt95rdrkQEoDDAjC1Bu/ZvTvZWn9hGtE6bYDZrfp9tFEdbTFo5H8
	 lzMlzxQUq6XcOC1qfx1w/eBZMTrcbDtaURxBC7qmkFxOe01lITq5pS92zyJ65NqZvjapk
	 mVzKVa96nm+CzQjMWeiWN4IhlNMGSXvgaQ5e3H8M+GU+tvkcf8xOyPXwzQK+ogQdBzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932802;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=JlVJFlo+Z37NPkgdkXBGsDyQ3tFuu7UaFk2vnsRKWbo=;
	b=tH5jNTpY40Bg+wcINI4O6JJKawm9Q6LYpslpiz8Dhbs3pmvXoojVwC3Olvjlyb1eHyEP
	 75FRVSQD3Mc5f82oJbgM6la6+LOvCq9IInHfDZbB2P86Yu7oXisaT2mEe+qaE5Jzc2eyZ
	 76YZvgpa1O+4fScyu9WydamTwjUbYksenxczJR/vlgLHvm/w9kmL0uF2FgAp0wCx0zITz
	 f9L77y/ZQroFguvfyKEpJtytqAQI50PFllk/tKYQhjCCoYX+4SHNazma6oubOkPZGw2zR
	 Ul6gOZxRs6JEVmFCBvG7oku5mqWBDxorxYw1hfoKeca0mvMBOzFtoJiqw/hANEoOFLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=schellhasconsulting.de;
	spf=pass smtp.mailfrom=schellhasconsulting.de;
	dkim=pass header.d=schellhasconsulting.de header.i=@schellhasconsulting.de header.a=rsa-sha256 header.s=selector1 header.b=Pz3rVCIS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.169.86
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11020086.outbound.protection.outlook.com [52.101.169.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF205606A31C
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 16:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF205606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schellhasconsulting.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schellhasconsulting.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=schellhasconsulting.de header.i=@schellhasconsulting.de header.a=rsa-sha256 header.s=selector1 header.b=Pz3rVCIS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZm5Tx/uADuW4F7ZPUsI2MlrsLwemrb5mD0eKWXULNCbTXmy6+Ozm7LVJVigH1dUCoSMmp/5pmH2icCsMTXqWDHKIgycn6UuRJneViF8XHv3IFVHxyVq/C1F6c1CRLoplJGWd1MkGqzGFqiJ/rKBt/hTNitJtHSUl5OhtzkJGdE7o5iDYLMcwI1AdVVk91bXIEQnlhkyJoQp0+z2LgboHm/GY4m6WQL/6Sy9Lx4ls+e0pVvIo9DvdW2TR1EEE42A6nRQdUvUycMXet/PNj9ApU2rw6xUd1wn9oJJEZr23ijpmCtrGsIGscNQ6HUvcpFldYYFBxuDhi2Vt80wzzQM0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlVJFlo+Z37NPkgdkXBGsDyQ3tFuu7UaFk2vnsRKWbo=;
 b=X/t/KmyY3RqYkwGnyY0WjnFsQfZ7uvMpizXqaE9az6+LUSZnZm9jGUPOBaB8w9CJK8aanXbFgg4jCto+jYBzMpL/HYAC/dQ/rjoFHu20AxZqzBkwbp7OqVG4I2BsBdCqxFKP0BaOmv51lYUwiPg5Na+SU32PyyaVRmjnJGsyPXkx8Bzx0eONh6AzRJZQ/FXsCYVeICMbG9fXtOA+n345gJ2j9v+UwfgFQM6GAFYarhbzmePo8zok7hCroV2B1kl0YTU44JBffJeCkAVUF+/i47goUr9qaWpoolJ+L++/2QunrYkoL2YMg/CwBQguxFkkqbJV181wupaAqYsUOQPkiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schellhasconsulting.de; dmarc=pass action=none
 header.from=schellhasconsulting.de; dkim=pass
 header.d=schellhasconsulting.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schellhasconsulting.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlVJFlo+Z37NPkgdkXBGsDyQ3tFuu7UaFk2vnsRKWbo=;
 b=Pz3rVCISkZ+axs/O5/ZpIuSfwQzNdRObSx74+w7zQ7jOs8w3kxsIP2Inf5iYsAMaIzRoO+LgtlvJoWqP77MCkZSQXQjSrWfunykul6BQpenCsLTPjZpmg8TaHoFza2grZHYO6scvBisbRQrxpmxP7rH+ScySs8eLTraTfdNhpG6gpsH72GYgKhYpuSU50hhySHTGz41nkZ1hQJ+AxCAEWqN7rVu3qcyx18Bcetxf5LzOuwetGy8pr/kIx9FaB5uMjE4gjTU+BqPiLv0GX8YI0+jmg3Y46ZlYNShbE0SjVzN3WT1I5ulYvF4mUpLgHyC+7xG5ctN5uA9vtzNklO0RMg==
Received: from BEZSPRMB0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:29::7) by
 BE1P281MB2612.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:3c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.14; Tue, 17 Nov 2026 16:26:37 +0000
Received: from BEZSPRMB0002.DEUP281.PROD.OUTLOOK.COM
 ([fe80::58a9:6dd5:d6a6:4264]) by BEZSPRMB0002.DEUP281.PROD.OUTLOOK.COM
 ([fe80::58a9:6dd5:d6a6:4264%7]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 16:26:37 +0000
From: Lars Schellhas van Kisfeld
	<lars.schellhas-van-kisfeld@schellhasconsulting.de>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Subject: AW: [RFC] intel_rapl: exposing PL3 / PsysPL3 (MSR 0x615) through
 powercap?
Thread-Topic: [RFC] intel_rapl: exposing PL3 / PsysPL3 (MSR 0x615) through
 powercap?
Thread-Index: AQHddn2/TzZJReQw8kKuDI7YP3MdDrcybCiAgAAHclE=
Date: Tue, 17 Nov 2026 16:26:37 +0000
Message-ID:
 <BEZSPRMB0002E04ECF84B3BD99C4B68DE87B2@BEZSPRMB0002.DEUP281.PROD.OUTLOOK.COM>
References:
 <BEZSPRMB000259539D5BE9BD203C5455E87B2@BEZSPRMB0002.DEUP281.PROD.OUTLOOK.COM>
 <3435bb0b801bd63f989b04073b747c90c1ce4af5.camel@linux.intel.com>
In-Reply-To: <3435bb0b801bd63f989b04073b747c90c1ce4af5.camel@linux.intel.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=schellhasconsulting.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZSPRMB0002:EE_|BE1P281MB2612:EE_
x-ms-office365-filtering-correlation-id: 911bfb96-fc64-4f97-4d11-08df44c78dab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|23010399003|366016|18002099003|6133799003|22082099003|261009223027099003|4143699003|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|38070700021|10067099003|7055299009;
x-microsoft-antispam-message-info:
 PSraY38nkL/d/lrd4EzHl2RC5lxCiDQ0zlrlJwrBxqC0D23B93OzV0V+PVAE65epBKv2WWaKGJdRwNLg+9WYy4PkbnG21u+I1Bc44Ihjkv8adnQq5J5yp0o+hiNrXMQ+ULpldVLTgdD7Dhz2Bl9dysHI/JRlZGmbI1oKnVSR9sQ3DTZhradQofcVZPsWE2nd4LIhGkcU8IWZ47YmmKZWJqk+z4ouFSO/XcVrECCPjvAdwf5sgWWv+4ppOjOozUya//uZl7DrO1NqSUCgqWNz1v5BT9Be0Qv1JnGqvhNsxFgQDWqgwnjNx16cYoN/7HSKPbMX9GgwZ06TFZhN032URhPdfkVveDUaPV+9mlVm+QAhJqDIqspNJV+F3gW9KYQ15clOCoksJe52exSrq0GvWakh8EfJaiVnMPpFNsfgbJqBU6fr/CwsS/kGyu87TSk54vEEijtrZjKKlJ/NGhJVdCs7WbWU9iE0Rb4l8OPgpeCGwjewFa1v/7pVIdUJATPYIROomx1YGoePcGwJj0hKwJtLSA3RbMh1Xt4UqZSyEdiveYLV50u0LDhDW78p3MeMgpd569Ax1DnKmmkZZSMNVGdOgLYH28OxcuISpYZ3ANk6o8oBuVWu0eBdQowN0iqgtzPdTqltDpmiyFZwdQxHBX79PiLKbIYIOM1s1eKriOWDKvfF2/NhkgR/zYOU3nR+clp/qLm51cUkmV54b0S0helarqbh/C4iZJzbeEyyhk3Tk/YgOPHcycRtb4JIZQJ/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZSPRMB0002.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(23010399003)(366016)(18002099003)(6133799003)(22082099003)(261009223027099003)(4143699003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(38070700021)(10067099003)(7055299009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?KDxM12P4J4JddTsfQVdzh9vRl1Pt84ClWDymHU8zACr4Hs+yB9gFkvx3?=
 =?Windows-1252?Q?07/YEOHTp6CjXcxFKJ24yXX2r5vig2mfAbhwSBNz79ZnAg+qR+EYXND0?=
 =?Windows-1252?Q?AFsM8OJSShVLRMLt0OUnSZrKpjnoGtt9V/bflC0bbx42MkAVPgpt7puZ?=
 =?Windows-1252?Q?yyBnjHjDz1RuZNFehTAfoQtSft8IfYcZHGlogtPQyw5FUIDbbzdB8jDx?=
 =?Windows-1252?Q?pqaPPxIePwghYc/sJNXnMI0kxR27kYYXbVUu7QWYYsJc4FpkNOM9amtV?=
 =?Windows-1252?Q?BTZsobKmY3Jw5cxElwEllC4epXIHV8yPwB7iJlYiX8QLJE+Bg2/W9TDF?=
 =?Windows-1252?Q?2sQVV7lVd0E8vVjiC0Yz11+b6s7prdWSiCtLO2QhkEbCdJL6CrrLHtnm?=
 =?Windows-1252?Q?Tehb/bDhDhJutX6jAJrjK9OKpOpUSNIbwH0ohYKRzgK7/IISsdbVsv7D?=
 =?Windows-1252?Q?35ihNRalBtj9rjy94+zklfX/50p85bxaTnnwNt2Gbeb1MKQT9OaPwMFA?=
 =?Windows-1252?Q?5DIy3OSfuITi5BLszkwVSvDaedD15zwoj0+bS+/MmOvJLGO8x+buwArm?=
 =?Windows-1252?Q?JrswEGSOG04ZodDhi+8DJwiz6Sl9+qkUsildhneJ9++uKaWqV0EWVDSF?=
 =?Windows-1252?Q?qUt/vHSLE+c+MJx0uiA06BrMXlsQk/T/l1dalb9sjQgFbNpVQd1nkjkw?=
 =?Windows-1252?Q?IqjQ1Spb6Lzg+bZxx+8hlgrxZ4jEClzceQLgRWxfvPInppgmmLn4nFFz?=
 =?Windows-1252?Q?yYwEHl1ItoLcD9yZipU3yULtXjtbAw5ks5Rpl4cFVErum4uMZUlMLLyR?=
 =?Windows-1252?Q?85d0T0Q8TLDWiE4TjcGfNzpoQyi7EK1TfnJd9YEdrkY4WqYiuv5119Pi?=
 =?Windows-1252?Q?OwPjvTFkV+8QI3FfMPCYdUUIDgXyodEaNruJnKnX49+NU+bqni8pYFiN?=
 =?Windows-1252?Q?FcUFecXNSsMQg2Qnvf8WQWVCTWAZjxApsFbqEwlF+QE6v+NEINrn3qdl?=
 =?Windows-1252?Q?R128okZXFGOmSKF6mioJCCSzmRr9nqji2Eb2/h1HrSmVEmq4h35CGOW6?=
 =?Windows-1252?Q?CRa9kJWIskaea+2ta5Sjj/EqFZj71tfHGQccldYtlTTKOfpYEjWfaKg4?=
 =?Windows-1252?Q?VuS/+c7Oma+bnYPBb4ACX3tNgcrGJiih+6hxsGxy0WnzebEiqT3uy1lF?=
 =?Windows-1252?Q?z65d4NkV70NyqYQOj+A61eHoDF3cMfEIm4relzccFFlpu+2zWhoF4LIN?=
 =?Windows-1252?Q?Fr2kpN3DXEULyv3zgRN5KuYagxL5M0ZZnNyY3pXNyhtTGjc1imvbhjGX?=
 =?Windows-1252?Q?8IpRWtit+xoaSk0rY5/GY14uJGzuN02gPCil3Oucz65MGn/MizU3qgKu?=
 =?Windows-1252?Q?ayS7mUTpAKGmQiWJ0RtDVVQNqrCKPVWeSIg0n8fnBHEw/+HGQwRNGwtM?=
 =?Windows-1252?Q?IlBrchCJdKsAXJPPEBsI39vuCm7TqwBT+6iqUwtVEuQtih1xKlegMLIh?=
 =?Windows-1252?Q?wljti94LajCmEubqtMlxJbv+8WeRMj3x8+VM6w/cnaqWwTS4kPmQ3BB/?=
 =?Windows-1252?Q?+4pNs7LGthKXy9XUDknimBkQIq4ThE2cjJzm70buuzYvsq/7b3UWLuql?=
 =?Windows-1252?Q?38W9M9XiJcPgAYiFRmhb3uSOc8su6jYbdZNrcrxeAvoG42TPwYaBEMXf?=
 =?Windows-1252?Q?br6b7jE6kjhM7NNN9X1ITyLy1MQIBFyERBaKtC8eqIQuQPcVuaHVwepj?=
 =?Windows-1252?Q?yWwQsnteJCxNnMN+kEt7BDQxhRIwAsi4uqCbCvgeMapv6HGedYGIf0Je?=
 =?Windows-1252?Q?Z97uyW5TMuzJmAUIThcO2lchxM6ZLSdIVg3krUoe73e9mgkzkWJdx7pe?=
 =?Windows-1252?Q?KUj1szhiK0e58Ro9jXTqz0tVV+KiROv5Kqgm3odhRLebX0/xer5W1mil?=
 =?Windows-1252?Q?BYW75BY0?=
x-ms-exchange-antispam-messagedata-1:
 fWpCqoKMhkOGd8J/LourDzg5/EJs3ig+cngDRjsOZXBmICsUewgstBJIizWyndP0MrySWw4MAqX1Gw==
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: schellhasconsulting.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZSPRMB0002.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 911bfb96-fc64-4f97-4d11-08df44c78dab
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 16:26:37.5441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f2749c6d-a11c-4d42-b10b-9f24df02f86b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: siYTXQaLp69BcPxmBNb0xzkx0i+4VDW/wWi2d0wmjUgSFLynVjYpGZQ4A8rSUxbEcNAU7Zr9U5D8cv7gB30KgiBIiNwEhKSc4HDQsSfrQDJFmp75Gzx1OnMm63J8yd1Y5NZNKWm5tFJPrx7vmV5DpIrtvquQM8BO+M3ZxaNLe/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2612

Hi Srinivas,=0A=
=0A=
thanks for the quick and clear answer. That makes sense: without public doc=
umentation the field meanings can=92t be verified, and I don=92t want to pu=
sh an interface upstream that might behave differently on other generations=
. I won=92t send a patch.=0A=
=0A=
For now I=92ll keep the access in user space, restricted to the models I ha=
ve measured, and I=92ll leave all bits except the power limit field untouch=
ed.=0A=
=0A=
If Intel ever documents 0x615 (or can tell me that it is stable across clie=
nt generations), I=92d be glad to revisit this.=0A=
=0A=
Best regards,=0A=
Lars=0A=
=0A=
________________________________________=0A=
Von: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>=0A=
Gesendet: Dienstag, 17. November 2026 16:59=0A=
An: Lars Schellhas van Kisfeld <lars.schellhas-van-kisfeld@schellhasconsult=
ing.de>; linux-pm@vger.kernel.org <linux-pm@vger.kernel.org>=0A=
Cc: Rafael J. Wysocki <rafael@kernel.org>; Zhang Rui <rui.zhang@intel.com>=
=0A=
Betreff: Re: [RFC] intel_rapl: exposing PL3 / PsysPL3 (MSR 0x615) through p=
owercap?=0A=
=A0=0A=
Hi Lars,=0A=
On Tue, 2026-11-17 at 10:27 +0000, Lars Schellhas van Kisfeld wrote:=0A=
> Hi,=0A=
> before writing a patch I'd like to ask whether this would be welcome.=0A=
>=0A=
> Background: I'm working on a user-space daemon that applies the=0A=
> Windows=0A=
> power configuration of Microsoft Surface devices on Linux [1]. On=0A=
> Windows,=0A=
> Intel DTT writes MSR 0x615 dynamically as a platform peak limit. On a=0A=
> Surface Book 3 (Ice Lake) the firmware sets it to 65 W (enabled);=0A=
> Windows=0A=
> raises it to 100 W on AC. powercap has no constraint for it, so the=0A=
> daemon=0A=
> writes 0x615 through /dev/cpu//msr, which needs CAP_SYS_RAWIO, fails=0A=
> under=0A=
> lockdown and triggers the "unrecognized MSR" warning.=0A=
>=0A=
> What I measured: on the SB3, 0x615 binds on platform (psys) power,=0A=
> not on=0A=
> package power. With 20 W in bits 14:0 and the enable bit as found,=0A=
> psys=0A=
> power under all-core load drops from ~35 W to ~18 W. Restoring the=0A=
> original=0A=
> value works. A tester saw the same write, bind and restore on an=0A=
> Alder Lake=0A=
> Surface Pro 9. coreboot also treats 0x615 as PsysPL3, next to 0x65C.=0A=
>=0A=
> Questions:=0A=
> 1. Is 0x615 PsysPL3 (platform domain) on all client parts that have=0A=
> it, and=0A=
> =A0=A0=A0 is its layout documented publicly (time window, duty cycle in=
=0A=
> bits=0A=
> =A0=A0=A0 30:24, lock bit 31)? I couldn't find 615H in the public SDM.=0A=
=0A=
This is not documented in SDM. So, will be difficult to add to Linux=0A=
kernel. When not documented, it is difficult to what each fields mean=0A=
and can change gen to gen.=0A=
=0A=
Thanks,=0A=
Srinivas=0A=
=0A=
=0A=
> 2. Would you accept a third constraint on the psys domain for it,=0A=
> opt-in=0A=
> =A0=A0=A0 per CPU model like msr_pl4_support? Duty cycle would stay=0A=
> untouched.=0A=
> 3. Any preference for the constraint name? "peak_power" is taken by=0A=
> PL4.=0A=
>=0A=
> If this sounds reasonable, I'd send a patch for the models I can=0A=
> verify,=0A=
> and only those.=0A=
> Thanks,=0A=
> Lars=0A=
>=0A=
> [1] https://github.com/larsschellhas/linux-surface-power=
