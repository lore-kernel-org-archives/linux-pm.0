Return-Path: <SRS0=xQv0=SK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C194DC282CE
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 08:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749C521738
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 08:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="fnKDM41I";
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="fnKDM41I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbfDHIE6 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:04:58 -0400
Received: from mail-eopbgr150043.outbound.protection.outlook.com ([40.107.15.43]:6050
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725871AbfDHIE6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Apr 2019 04:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector1-TopicProducts-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QdUcuHoS3Fwx976yghOlqyEMJ45JHg2rC5/jGhD0xA=;
 b=fnKDM41IBwxsxO0REyoXEEI3Ctpu/NfhCl//ORUB9vC+eKdLEsYJjZOoOm5S7oDFOdJBUxjmyQWW2LTl64V/HuiGm59p0WYkiw4/O+n3D4PjJc2h3lDkizCuAJKPwM2Cw2q9K9fMGoNRFqeoSWlr5uk8EylLnCvYwTD936uszOk=
Received: from AM3PR04CA0142.eurprd04.prod.outlook.com (2603:10a6:207::26) by
 VI1PR04MB5245.eurprd04.prod.outlook.com (2603:10a6:803:5f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Mon, 8 Apr 2019 08:04:52 +0000
Received: from HE1EUR01FT020.eop-EUR01.prod.protection.outlook.com
 (2a01:111:f400:7e1f::200) by AM3PR04CA0142.outlook.office365.com
 (2603:10a6:207::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.15 via Frontend
 Transport; Mon, 8 Apr 2019 08:04:52 +0000
Authentication-Results: spf=pass (sender IP is 52.166.56.231)
 smtp.mailfrom=topicproducts.com; analog.com; dkim=pass (signature was
 verified) header.d=topicbv.onmicrosoft.com;analog.com; dmarc=none action=none
 header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 52.166.56.231 as permitted sender)
 receiver=protection.outlook.com; client-ip=52.166.56.231;
 helo=westeu11-emailsignatures-cloud.codetwo.com;
Received: from westeu11-emailsignatures-cloud.codetwo.com (52.166.56.231) by
 HE1EUR01FT020.mail.protection.outlook.com (10.152.0.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1771.16 via Frontend Transport; Mon, 8 Apr 2019 08:04:51 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (104.47.5.52) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 08 Apr 2019 08:04:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector1-TopicProducts-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QdUcuHoS3Fwx976yghOlqyEMJ45JHg2rC5/jGhD0xA=;
 b=fnKDM41IBwxsxO0REyoXEEI3Ctpu/NfhCl//ORUB9vC+eKdLEsYJjZOoOm5S7oDFOdJBUxjmyQWW2LTl64V/HuiGm59p0WYkiw4/O+n3D4PjJc2h3lDkizCuAJKPwM2Cw2q9K9fMGoNRFqeoSWlr5uk8EylLnCvYwTD936uszOk=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (10.255.168.18) by
 AM6PR04MB5480.eurprd04.prod.outlook.com (20.178.93.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.15; Mon, 8 Apr 2019 08:04:47 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5804:da31:3d28:cd27]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5804:da31:3d28:cd27%4]) with mapi id 15.20.1771.014; Mon, 8 Apr 2019
 08:04:47 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     Sebastian Reichel <sre@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Getz, Robin" <Robin.Getz@analog.com>
Subject: Re: [PATCH] power: supply: ltc3651-charger.c: Fix typo in device name
Thread-Topic: [PATCH] power: supply: ltc3651-charger.c: Fix typo in device
 name
Thread-Index: AQHU49svBG6FxJYmZ0ejAK2K59n8z6Ytso+AgAAFwwCAAAO7gIAEP7IA
Date:   Mon, 8 Apr 2019 08:04:47 +0000
Message-ID: <54ec5e8b-cbec-b2f6-8d76-d7db0d0a87c0@topic.nl>
References: <1553608635-29376-1-git-send-email-michael.hennerich@analog.com>
 <20190405143747.didydf5neea4iqcq@earth.universe>
 <BY1PR0301MB0901370B40482D4EBD6EE84F8E510@BY1PR0301MB0901.namprd03.prod.outlook.com>
 <20190405151145.3iplzv423u7pkq6j@earth.universe>
In-Reply-To: <20190405151145.3iplzv423u7pkq6j@earth.universe>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-clientproxiedby: AM5PR0602CA0005.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::15) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d9::18)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=mike.looijmans@topicproducts.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [81.173.50.109]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: a897e210-8df2-4a65-0b10-08d6bbf8e101
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:AM6PR04MB5480;
X-MS-TrafficTypeDiagnostic: AM6PR04MB5480:|VI1PR04MB5245:
X-Microsoft-Antispam-PRVS: <VI1PR04MB5245002F78E3F8859D0E365D962C0@VI1PR04MB5245.eurprd04.prod.outlook.com>
x-forefront-prvs: 0001227049
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(39830400003)(396003)(13464003)(51914003)(199004)(189003)(186003)(386003)(446003)(11346002)(110136005)(14454004)(71200400001)(76176011)(53546011)(65806001)(66066001)(65826007)(42882007)(54906003)(31696002)(65956001)(71190400001)(508600001)(2616005)(93886005)(81166006)(81156014)(6486002)(6506007)(36756003)(97736004)(68736007)(106356001)(105586002)(8676002)(476003)(102836004)(26005)(8936002)(486006)(6246003)(229853002)(74482002)(6436002)(52116002)(6512007)(44832011)(305945005)(4326008)(25786009)(99286004)(14444005)(316002)(5660300002)(64126003)(6116002)(3846002)(31686004)(2906002)(58126008)(256004)(53936002)(7736002)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5480;H:AM6PR04MB6341.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: topicproducts.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: +LbQyRetdLwp0pJvS+RCLJniouViPFDqAA4q/UN73VQf66dzDvoXo5nydmQbJi9kzNTUWlCyb1Z8DKsX+kPB9B7JY3eunLwU6bK+zuVirzSZb+DOGoDYwSPhdGyD9ogICPx2/fQq19YyX9QNzSNT28XecPRkTqyScDrDaWeEfcViBBOhpoSyASdVhsKmReL3J0Tchc9L4wgnUMIOxJTM1m+XqaNSBJHgmIOXRBKh/zOcRBNWyXjeiCn9hm8dSNb2mRhG0GvfOqJdIupEIvlfH6o0tYYdZH3uhdUpiFzQ66r1WEmi0MybfTIFvUScqEE+2WSkiactOPCMgZC0TfvwbKHNGhjU9dhIZQgAXKKoz3r1/Bd3MWW2GW4cR47czysHx9i5X1EI3bI2WHa+12rjNAx9bSeptlb7H7d+n1yNMwQ=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <9A63CBFD483F1F469C83A659E69D4B3D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5480
X-CodeTwo-MessageID: 20190408080449.6d6f250b-82e8-4866-8964-36f78d1ce3c3@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT020.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:52.166.56.231;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39830400003)(2980300002)(13464003)(189003)(199004)(51914003)(6116002)(7596002)(305945005)(8746002)(7736002)(356004)(5660300002)(7636002)(246002)(47776003)(14454004)(3846002)(66066001)(65956001)(8676002)(8936002)(23746002)(6512007)(229853002)(31696002)(508600001)(64126003)(36756003)(50466002)(6246003)(6486002)(65826007)(93886005)(2906002)(65806001)(58126008)(2616005)(76176011)(110136005)(42882007)(14444005)(316002)(54906003)(6506007)(446003)(336012)(31686004)(53546011)(476003)(126002)(102836004)(4326008)(11346002)(486006)(44832011)(74482002)(106466001)(25786009)(186003)(26005)(99286004)(386003)(106002)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5245;H:westeu11-emailsignatures-cloud.codetwo.com;FPR:;SPF:Pass;LANG:en;PTR:westeu11-emailsignatures-cloud.codetwo.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6c81c164-1c08-4a9f-b92a-08d6bbf8de11
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600139)(710020)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR04MB5245;
X-Forefront-PRVS: 0001227049
X-Microsoft-Antispam-Message-Info: alySfaQCG/8KxHrbxxE+/rPd91jUkGsypCYpmtprGRWnpUcyUQcR5/wC6s8J7ORuVh/N9Ept4RlUq8zyDxB3TT1OkxbgXwpElbbaFGM0lMDNfaLvunKJP7AC7Twbm9NKKa0WP6GYbGo91TSt5XZvekFu1EWjqvhNvousHwkEQ88dvSRJBQICZ2WT3MBcOnfVLpI2U0ykdYFTCqOI/4g4yOjVA8JDb918ZKWfEdmHsh/V3gqxM5oeRZuVjU6iYgO31cl43PfN4a8kMIGTNv0QgzvBBna638Sm/c/gJV0ZoWgG9v66TkmV+I+lS63SWcnZuF2xoaynwQcIzR+u6rxmz0j7nWQg2ChM8rCPewysOBeJX2n5xIhMJ+Yar+d/JUafmUF/8QlDcv4KqWPbSa2EyYP4LmNfJBykrwrvLxSpL/g=
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2019 08:04:51.5315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a897e210-8df2-4a65-0b10-08d6bbf8e101
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[52.166.56.231];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5245
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-04-19 17:11, Sebastian Reichel wrote:
> Hi,
>=20
> On Fri, Apr 05, 2019 at 02:58:24PM +0000, Hennerich, Michael wrote:
>>> -----Original Message-----
>>> From: Sebastian Reichel [mailto:sre@kernel.org]
>>> Sent: Freitag, 5. April 2019 16:38
>>> To: Hennerich, Michael <Michael.Hennerich@analog.com>
>>> Cc: mike.looijmans@topic.nl; robh+dt@kernel.org; linux-pm@vger.kernel.o=
rg; devicetree@vger.kernel.org; Getz, Robin
>>> <Robin.Getz@analog.com>
>>> Subject: Re: [PATCH] power: supply: ltc3651-charger.c: Fix typo in devi=
ce name
>>>
>>> Hi,
>>>
>>> On Tue, Mar 26, 2019 at 02:57:15PM +0100, michael.hennerich@analog.com =
wrote:
>>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>>
>>>> There never was a device called LTC3651, it always was just LT3651.
>>>> This circumstance makes it pretty difficult to identify what this
>>>> driver is meant to control. This patch is a minimal invasive attempt
>>>> to fix this issue without affecting existing systems.
>>>>
>>>>
>>>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>>>> ---
>>>
>>> Please change subject to "power: supply: ltc3651-charger: Fix device na=
me"
>>
>> Sure
>>
>>> Also we probably should change the filenames and Kconfig name.
>>
>> If we go that far we can also fix the function prefixes as well.
>=20
> sounds good to me.
>=20
>> I'm a bit hesitant about the Kconfig name. It'll break existing kernel c=
onfigs
>> for no good reason!? Please let me know what you prefer.
>=20
> I suppose we can keep to the old Kconfig option, if this is being
> used already. Hopefully not many people search for their driver
> using raw Kconfig names :)

Well, if you don't change it now, it will never get fixed.

I'm actually in favor of completely fixing the name. It does mean that I'll=
=20
have to update a few devicetrees and configs, but in the long run, I think=
=20
it's the better choice.


>=20
> -- Sebastian
>=20
>>
>> Thanks for the review.
>>
>> -- Michael
>>
>>>
>>> -- Sebastian
>>>
>>>>   .../devicetree/bindings/power/supply/ltc3651-charger.txt         | 8=
 +++++---
>>>>   drivers/power/supply/Kconfig                                     | 6=
 +++---
>>>>   drivers/power/supply/ltc3651-charger.c                           | 9=
 +++------
>>>>   3 files changed, 11 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/power/supply/ltc3651-ch=
arger.txt
>>> b/Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt
>>>> index 71f2840..f012449 100644
>>>> --- a/Documentation/devicetree/bindings/power/supply/ltc3651-charger.t=
xt
>>>> +++ b/Documentation/devicetree/bindings/power/supply/ltc3651-charger.t=
xt
>>>> @@ -1,7 +1,9 @@
>>>> -ltc3651-charger
>>>> +Analog Devices LT3651 Charger Power Supply bindings: ltc3651-charger
>>>>
>>>>   Required properties:
>>>> - - compatible: "lltc,ltc3651-charger"
>>>> +- compatible: Should contain one of the following:
>>>> + * "lltc,ltc3651-charger",
>>>> + * "lltc,lt3651-charger"
>>>>    - lltc,acpr-gpios: Connect to ACPR output. See remark below.
>>>>
>>>>   Optional properties:
>>>> @@ -20,7 +22,7 @@ attributes to detect changes.
>>>>   Example:
>>>>
>>>>   	charger: battery-charger {
>>>> -		compatible =3D "lltc,ltc3651-charger";
>>>> +		compatible =3D "lltc,lt3651-charger";
>>>>   		lltc,acpr-gpios =3D <&gpio0 68 GPIO_ACTIVE_LOW>;
>>>>   		lltc,fault-gpios =3D <&gpio0 64 GPIO_ACTIVE_LOW>;
>>>>   		lltc,chrg-gpios =3D <&gpio0 63 GPIO_ACTIVE_LOW>;
>>>> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconf=
ig
>>>> index e901b9879..6816a86 100644
>>>> --- a/drivers/power/supply/Kconfig
>>>> +++ b/drivers/power/supply/Kconfig
>>>> @@ -476,11 +476,11 @@ config CHARGER_MANAGER
>>>>             with help of suspend_again support.
>>>>
>>>>   config CHARGER_LTC3651
>>>> -	tristate "LTC3651 charger"
>>>> +	tristate "Analog Devices LT3651 charger"
>>>>   	depends on GPIOLIB
>>>>   	help
>>>> -	  Say Y to include support for the LTC3651 battery charger which rep=
orts
>>>> -	  its status via GPIO lines.
>>>> +	  Say Y to include support for the Analog Devices (Linear Technology=
)
>>>> +	  LT3651 battery charger which reports its status via GPIO lines.
>>>>
>>>>   config CHARGER_MAX14577
>>>>   	tristate "Maxim MAX14577/77836 battery charger driver"
>>>> diff --git a/drivers/power/supply/ltc3651-charger.c b/drivers/power/su=
pply/ltc3651-charger.c
>>>> index eea63ff..07ed537 100644
>>>> --- a/drivers/power/supply/ltc3651-charger.c
>>>> +++ b/drivers/power/supply/ltc3651-charger.c
>>>> @@ -1,11 +1,7 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>>   /*
>>>> + *  Driver for Analog Devices (Linear Technology) LT3651 charger IC.
>>>>    *  Copyright (C) 2017, Topic Embedded Products
>>>> - *  Driver for LTC3651 charger IC.
>>>> - *
>>>> - *  This program is free software; you can redistribute it and/or mod=
ify it
>>>> - *  under  the terms of the GNU General  Public License as published =
by the
>>>> - *  Free Software Foundation;  either version 2 of the License, or (a=
t your
>>>> - *  option) any later version.
>>>>    */
>>>>
>>>>   #include <linux/device.h>
>>>> @@ -190,6 +186,7 @@ static int ltc3651_charger_probe(struct platform_d=
evice *pdev)
>>>>
>>>>   static const struct of_device_id ltc3651_charger_match[] =3D {
>>>>   	{ .compatible =3D "lltc,ltc3651-charger" },
>>>> +	{ .compatible =3D "lltc,lt3651-charger" },
>>>>   	{ }
>>>>   };
>>>>   MODULE_DEVICE_TABLE(of, ltc3651_charger_match);
>>>> --
>>>> 2.7.4
>>>>

