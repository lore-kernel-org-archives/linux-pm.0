Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013031.outbound.protection.outlook.com [52.101.72.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220F847ECE2;
	Tue,  9 Jun 2026 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018019; cv=fail; b=PLdd8OkvaU3QOIiIakf6sBkb4NUBVJpvxwtCcqP3Ti/pRt5m15T+TJ9bU5pEw34bWg/Ld4i2qYkXbhBYHjmzICQRbGYSLjAKPV9Ir0/BoMvC8uzW+S+LJeut9n95Fcv+KiUSZjE6SYcxSX4lFajaBNwBAl1tZkH9xwwz5Zf2osw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018019; c=relaxed/simple;
	bh=buSMQwv//fBiiXFiYiHhtWytdWB1uhAL4bmttFoJn6E=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kz8HPo8Xd4Uw4uR9w4wu29X9JBkAnm1hvV0472XPTgYzcsRQOE9qWy4wjgTrZhvH2bt4nNOM7DnwovkWBURinSNIn8mZByqDlqXbAt8XU/I+BpfUBszHELqd5ErpV//751l0ilyCE/OqQ9VHA6TUNsBnDYMeliwBaZsIGF4hit8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=qh545K+A; arc=fail smtp.client-ip=52.101.72.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="qh545K+A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ly6j+Uyu7xVGuaaWE+zrqib5jtTt8ic1Ka4R/w4siOsYcwNR7Xd+vqEWXzglBnWel/+bkNRSrFw1kalcUq12V6l5CcFP5KeKkdTYNQpB6o20nzMJcyAAbtT1De6UcIBy7JxV/+paaCCfCvSW4pHu8f4JaUAT5GQMwpdqccAhas4W24P0Tzxfwn4jmq/nNHneqECOlAWZCDKScBqasvGW2q/tfEr+UNTxz/XzAYV2K95eOfFFv/F33EMEo1ff1vpYaaV//TludE8XfCqaN0a4857n7TKu+XuU7MbeFhTX09/Qx3BaD1izE1s7fvoM6I7fTPkNpc/EDA0oEbivjIMwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTq12nMNoYRUVTkgw0xgb37gzF7+e5El1z/LNetKgSo=;
 b=Lka/V6epAclWV9yThIe3xIaCPULosXOWmUT8a3AKAYggG/84oGHnQa8qokwRCyzDrLmDcgUXRvqFmW7b1QmIuULGRpW0IO8bj81YUf3nPLgCSdblNq+y97XMsx7qkfFN8cZ3QbGKaO64JoW/15VyHELxowALKfvxtyiVWJZSVewQ46MRON1W0XAJCfRJhU2jpm9hT2MrJlyVYnZ1TfxhCfJh9Zfs6AmgQd0FdKG7I/d/FnAmfI4ygag9hdttkewsYFw8MSPr3K6iBh7iVAxPVSTsiiy/rk+oF11fAqOaK9bre77N0d0vXlMhTf/myusDIiurgRHEs8pLXD/MUBjvGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTq12nMNoYRUVTkgw0xgb37gzF7+e5El1z/LNetKgSo=;
 b=qh545K+AI+bGZ37XOSZ/6l7hejkD50ePgYyO6/83G6TE86cDM5Wguaxu8FNRwHTlOwar1+eLoXtm61hBI33YFZZvHMjpCZlbMTbbsRoxj21szTjFqKWVUp9jjGgUysj0qnvfGqwvID1Em/QI3IBW6jLsDWwLqrL+c3kne0PiknU=
Received: from DU7P191CA0010.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::35)
 by GV1PR02MB10837.eurprd02.prod.outlook.com (2603:10a6:150:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Tue, 9 Jun 2026
 15:13:19 +0000
Received: from DB5PEPF00014B9C.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::9f) by DU7P191CA0010.outlook.office365.com
 (2603:10a6:10:54e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 15:13:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB5PEPF00014B9C.mail.protection.outlook.com (10.167.8.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 15:13:18 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 9 Jun
 2026 17:13:17 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <kernel@axis.com>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [RFC PATCH 0/2] Add driver for TI BQ25630 charger
In-Reply-To: <ah72aPNg-psfHrHi@venus> (Sebastian Reichel's message of "Tue, 2
	Jun 2026 18:17:16 +0200")
References: <cover.1772201049.git.waqar.hameed@axis.com>
	<pnda4tunkrx.a.out@axis.com> <ah72aPNg-psfHrHi@venus>
User-Agent: a.out
Date: Tue, 9 Jun 2026 17:13:17 +0200
Message-ID: <pndzf13u4qa.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail11w.axis.com (10.20.40.11) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9C:EE_|GV1PR02MB10837:EE_
X-MS-Office365-Filtering-Correlation-Id: daf09964-7251-493f-2900-08dec639a349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|6133799003|18002099003|22082099003|11063799006|56012099006|5023799004|4143699003|13003099007;
X-Microsoft-Antispam-Message-Info:
	DP6kJ2WwTQGAEkpcO9WhUSq1mcW/sJ6KBEBgCKH1T1a3daALM3JvTdCxXMwApB4jQ3wZlbB0NHM1Qq8dhUeWbsWpsmX+tPQhLsezteiVyRZD6yMCs3dv1u4nwQoxqgcFTUcQmZr88B59U3YC29MDYpMYELzqdiLcQUHPSz9jL4bDrVAXjLFTj8ul/F06H+IeqTndzG37YNbmbdzszPSwlrJ5zhrmuJ2tsyOSxlrBFAoH0hHqHUQ7UGLeBsQgf2HjYrQfmI5vZ7FdiDbFzPyA7SfyE9WAK/wnGCvu8njhLa92U3iIBtqDKvAxqMtPkVQOHQu2bIxbUiMMSlm7Aa4TlQ2IpxJ2+AB9fLhAqSD7/5JSKhzq0qXg8f3Jm2BvtI4fNVKlKDovTh8UWyQSeIgH6Kc+iGUj7M+mY+8OYtnvKjnumh57+Df8gALB+DH5U/PPLerANsLWB1/ThJO6U2TLhZxddQ4XTFrjrzrctRf9Z76uh8kexz6BYWAF9W7jqm7hhtAZd1wSmnAsV4+M/+noN85/PGPiimWMAS/b1na+iBlkq7rKb6olLCjXWR+UFnzI1BEl61rR9qdPOIRiAGXDiT96WjLh32anIkpz7x3zPnwzMXrno37t56+04SMvAdq+aOCBBDS2SEfY6r8xRv8wiiau2uMSn2heycDZV5x8oC9MHTpz+v6NcoonoLZXI6sx
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(5023799004)(4143699003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8uILbGbNVPRD3ZfiHoq0Hysk+ijK7+MeZfegJh20mS3Hy39m901Oe1n4MF9ulcdJxtQuVNm1S+ych2dXb9S1QS1Zvk+2FSnRyWbZtlHnZo+ONzB0ipV9123mRSUWpW+RLHCXOOjTPfOqF4wyYG1TIvHUglmxCzgIXMcSutX7qO+tnfODnToz54EjrjTQ1FuZdxGrn2fiaMfP+EKT+mol6/P30iCi2rp3OuZrAyLeG5Z19NOr3Bb7rFN/6EnLIm+TfXtufTxiz+nFvlBS/tC8Fyvdup929H19yuMKoTeRlhJTbOJstV7KDAr4R6RiHaLwHgq4QrtgTTbywOTdul3Ov4uI7wXUYzsLRbjIFNo98/PN8Ox26s52KFYzE5AMYCU1ok3p4q7ordSrB3UY4LQBakn0x2AumI7wybuEk/NIpDFGCsiglbq+bO5oXIXQuYEC
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 15:13:18.7616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daf09964-7251-493f-2900-08dec639a349
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB10837

On Tue, Jun 02, 2026 at 18:17 +0200 Sebastian Reichel <sebastian.reichel@collabora.com> wrote:

> On Wed, May 20, 2026 at 05:49:38PM +0200, Waqar Hameed wrote:

[...]

> Driver itself LGTM. I think it would be sensible to merge that while
> the extra features are being prepared, but the DT binding must be
> fixed first :)

Sounds reasonable! I'm doing a thorough testing of this right now (with
some minor issues found) and will send an updated version of that soon
so we can have the base functionality merged.

>> > However, some functionality has no straightforward implementation. The
>> > following features have therefore been left out and hopefully we can
>> > have some design discussions to reach a clear resolution for the next
>> > patch version (hence the RFC tag):
>> >
>> >   1. The USB OTG functionality (i.e. power *out* from the device) would
>> >      probably need a minor refactorization to use the MFD sub-system to
>> >      also register a regulator driver. Looking at the bq257xx driver,
>> >      this should be the preferred design?
>
> If the regulator is the only part making this a MFD, just create it
> in the charger driver itself. There are a few examples, just grep
> for 'struct regulator_ops' in drivers/power/supply.

Alright, will do that!

>
>> >   2. Other drivers add a custom `sysfs` attributes for BATFET control.
>> >      See for example rt9471 and bq24190. Is this the preferred approach?
>> >      Should we add a new power `sysfs` class ABI for this? (There is a
>> >      TODO left in the code for this.)
>> >      
>> >      I reckon it is quite common to have BATFET control for chargers,
>> >      i.e. being able to set them in "ship mode", "stand-by mode",
>> >      "shutdown mode" or "idle mode" (example values taken from the
>> >      `BATFET_CTRL` register field from datasheet [1])?
>
> Yes. I usually ask to use custom properties until there are a few
> users to avoid cluttering the general ABI. I think BATFET is a good
> candidate. Please add a new property for that one.
>
>> >   3. This device has liquid detection and corrosion mitigation. I
>> >      couldn't find any existing device driver with this kind of
>> >      functionality. The datasheet [1] even mentions "patent pending",
>> >      although it refers to the USB type-C Specification 2.3... :)
>
> This is something I also expect to see in more devices; I know a
> couple of Android devices offer this. But indeed nothing has been
> submitted so far.
>
>> >      When liquid is detected in the charging port, an interrupt is
>> >      fired. Likewise, an interrupt can be fired when the port is dry
>> >      enough (according to some configured threshold value). My initial
>> >      thought was that maybe we can add "liquid detected" to the `health`
>> >      `sysfs` ABI?
>
> Sounds good to me.

I'll send these as separate patches then.

>
>> >      However, the question still remains though how one
>> >      should enable/disable and set threshold values for this (new power
>> >      class `sysfs` ABI or a custom one only for this driver)?
>> >
>> > [1] https://www.ti.com/lit/gpn/bq25630
>
> I had a quick look at the datasheet. I think a new standard property
> would be sensible:
>
> LIQUID_DETECTION_CONTROL with possible values
>     off = Not liquid detection is being performed
>     auto = Periodic liquid detection checks are being done
>     once = Writing this will perform a single check (and return to off)

I think this sounds reasonable. Most future devices (if not all?) would
probably be covered with these three states.

>
> For the other controls I'm not sure how generalized they are. E.g.
> for TLQD and ILQD it offers 4 steps, but not explicit current
> (seconds and amps). OTOH for the voltage explicit values are listed.
> Maybe just leave them to the default until somebody actually need
> this configurable?

The USB specification actually lists several different methods [1]. I
agree that the wisest right now is to just leave this and wait for more
data points (from how other devices will expose this).

>
>> Friendly ping incoming!
>
> Sorry for being slow with reviews, I was quite busy and out of
> office in the whole May. 

No worries! I know how the workload can be as a maintainer (especially
if you're all by yourself). Thank you for taking your time! :)

> I suggest that the 3 things are being send on top of the updaed base
> driver :)

Yes, let's do baby steps here and merge base functionality first (as
discussed above) before adding all these extra features.

[1] `USB Type-C Spec R2.4 - October 2024.pdf`, A.3, p. 351. https://usb.org/sites/default/files/USB%20Type-C%202.4%20Release%20202410.zip
