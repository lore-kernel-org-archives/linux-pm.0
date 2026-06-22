Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D94D39C621;
	Mon, 22 Jun 2026 09:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782120963; cv=fail; b=GFb8R0a5VMeTHGe7RqeHXjulrOKyCLV2PubZTAIeWf1QpizShxobYbVGlOMBbS+BDtGzyImG9/tUZ6ks/dkQq6Fj59AqzUPmp17I1ixIX9X7naJHtC4uCWYj8yGIFBmPIEW5+OLSE6gHsdvKkrIUoJZ3fNwvhhygcVI8Cv4LJzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782120963; c=relaxed/simple;
	bh=UJPmxySp9tAg4o9kjoMefJk6JiA0zLRJRRtqpLT9CJY=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dg7HR2n0klRuJp4p5sMv5FXDTpq2GKmMgQ6wRG/oz3rbB2oDzqd0FUK0LOCSuELFoDWIQPxCISXbFlW3z47cDC6Gqbsa77DhwbwxX9QHibppD8qI2AR+Mp+umMXb9IFCSFdrRc7GuIYE2aQBm9hWM/vSVtOYvPxyaDR4VtLyBVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=piM1AT9/; arc=fail smtp.client-ip=52.101.70.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="piM1AT9/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IClj+QWMtgOtWEueFiqJWw0gyInymDBWO/vdLUAJhJd9E6WTjBFcbS5ldIgrfNKH3PUTkPz0SjY1mQ4kJqyhDJVgM2o7kqIlCZMflOuXwUdqzIuFUiTmw+Fd0Pv+8eq0nJp3avRqZVvDrrj19LT4iQ+baQqg/ZnimPKJq9MAQIAoqwx4WqucJsEkSdtMjl0oCF9KgMM2n3M3zGM75znd9ZD/Ji00KckudZaHJBIdz+jopk2Mh/8gZ/h7orACwk0s6hsv10SH4lSEqIoqbG8nxii1ogcxpZBnkbjKaT8fWqKGqytwjN5xYHdlpnwp13sWcxFOuEerI8S6Jfbwe8sXjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJPmxySp9tAg4o9kjoMefJk6JiA0zLRJRRtqpLT9CJY=;
 b=VHuzrGxiUcpBfap+MAqgRzLTB/XTQ/5PWzQacqbQWl95TwnpOOWEoa7uWXRzRWQaxeJPHpCFlxvYaKY6AOLGkH2pCkFQjlMUHXIHVwqfau2hJb/zOAXzOU5CCTZifUUMwlYwx8myMaEOHBdhcE26Uyzi4nq72zQmtQa5NLvHY+qwcyJMO5tYOy1hxgKlbBreq2lFSbWRB+OwB5TyGEE1nTsqeX7dxATgjDf3ABnk25QcC0gp1Z3a+o+hpxDAdnecx3HhJw1caWujsGznr5I0BaNJ5nwBLEMDPjjTjzE18Jh1WxMr2ADakFXJvQ7utS4sFbhW3n4x8TilfM6WJQITvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJPmxySp9tAg4o9kjoMefJk6JiA0zLRJRRtqpLT9CJY=;
 b=piM1AT9/i/msznpSJ1Mp6/XuCrmogksXd9b7tjOixIJQPcSQgsP35vVMvm8TzBg5Tnu8k69kufNd+y54C/8PNv2j3UKxzuW+41a6wvYk3/houdqCOX6CZx2YlqXU1NVB4ryt3X+Km8FBrd5ZIIcLNB8zixUMmH2VwwE4gaPI4sE=
Received: from DU7P251CA0027.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::25)
 by VI1PR02MB6208.eurprd02.prod.outlook.com (2603:10a6:800:18a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 09:35:57 +0000
Received: from DB1PEPF000509EA.eurprd03.prod.outlook.com
 (2603:10a6:10:551:cafe::5) by DU7P251CA0027.outlook.office365.com
 (2603:10a6:10:551::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 09:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509EA.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 22 Jun 2026 09:35:57 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 22 Jun
 2026 11:35:56 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] power: supply: Add driver for TI BQ25630 charger
In-Reply-To: <b89846e3c581d90d1b9ac967d1b744e76244dc83.1781789320.git.waqarh@axis.com>
	(Waqar Hameed's message of "Thu, 18 Jun 2026 15:37:59 +0200")
References: <cover.1781789320.git.waqarh@axis.com>
	<b89846e3c581d90d1b9ac967d1b744e76244dc83.1781789320.git.waqarh@axis.com>
User-Agent: a.out
Date: Mon, 22 Jun 2026 11:35:56 +0200
Message-ID: <pndcxxi9atf.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail10w.axis.com (10.20.40.10) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EA:EE_|VI1PR02MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c7c7a9-1f51-415a-ff85-08ded041a9f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|13003099007|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uEvhBWsFRxtUV7VcqwHBF91bhjIKzRQPl/AmBdf3bc1hmu4f7bKcLG4vXFzqbBio4aEFe2qZnLdKe2xjengeMSJcqQlgjWLsMA9nY0aaJ5RMd5wBgcuD+rHna8KWN2hhb48cR+1q0Fp8P/MIJ0EWed0LCpyUAgRbSg4BxR7SpP9ehH6+0BKN7xPKJ0ZNGlDrA0updgXE7yQf7a4dlFHzN3uqiT4Ra/HOQzrJ0B0T0Gsr7mzoLtoX2ob0XFrx1vfWqUoCzJLIVDHKVtm4o3XncJRTyL7vtIa+hb/LxKe4CmAJFclMN6TIsbzEC9aBjOihjqxxAbxNmqfp96opkLla9qLBxhvx02CzHx8+kUWwTzrd3ogmVMqiAwTIVcMX+1vVxM+9+Q/89tCw5NFjyomZqI2/6knzb9cYa92EZSN2tT40NRqFLsl5LhvhblnZcc343bvr/gRrZHAkOgmZjxQcF0CucXjO8Dif/9dMny2Zl3x4sVPcm2/i2S8CAzfBRgdpAroQLDWOWVXJDOfv0e9eFcMbMlXurMuAZ4nopMfFGtO4YrTOmtTTOJw0DW6drO6mhtj1Wqt/I70lATbPx1fRD2uSio7JqgO/dLB4gk/K/67la2/M9EUrRTY66RFTEJu7FUehTE5uNjSAxAotx6gSR7aWlhrE/SHkbOQIOmQWTQ83aKV9EgitPfcQQeLGsq2OYYkgVnF+qqI8uXdkltmXyg==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(13003099007)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OszutFeR6/3TXUWcg7gjPt88WLjmKDS8gr/r5OCCEYfBab9eRJ9/UZKtayXLZuIDOHT1UTWbZcMJg3BTwgCqlMRm54MQl6UdodH3flTxDryJ2smd9uHi7IijVU0/k1XZdMXd6UGSDvi6YJDuLGTTXB7Pa9c1/9PdqUzV8z2GvtnACJ1mi/kEJkECbcuouvqBmKFCZ+Qjf4OR6Xjnrr+yz+0Sb3uBNUgcD4CvP/6sDczSRvIR1fCfNYRHFuF3CzUshaE8QJIQc6RC3cKYtXNftIxYmwnBIB3PrQeYwfSETct52tE9s2QIpdk32eBFSwpZaMtJSHCDpOxuZZe5B4MWYyB47uYEv1aAmNwpXJHXtkyEJ8zMs0DdG+YkbNAupMyfGfY0nyGrcEk/LlQr8X9ZG/zbl0Ye/cVJfLNWZaHS+VCg6tHUBPG8rYZCnVspT8tI
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 09:35:57.5740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c7c7a9-1f51-415a-ff85-08ded041a9f7
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6208

On Thu, Jun 18, 2026 at 15:37 +0200 Waqar Hameed <waqar.hameed@axis.com> wrote:

> TI BQ25630 is a battery charger that is I2C controlled. Despite its
> model name, it is rather different from the other devices in the BQ256xx
> family; it has a completely different register layout and some other
> additional functionality (see the datasheet for more details [1]).
>
> The most "annoying" thing is that it has two different register lengths:
> 8-bit and 16-bit. Moreover, the 16-bit registers are further partitioned
> into either being little- or big-endian... Luckily, `regmap` has support
> for multiple `regmap_config`s (by setting unique names). Therefore, use
> three different `regmap_config`s for the corresponding registers. ADC
> functionality has been left out, due to it not having any real-world
> use-cases.
>
> The `enum power_supply_property` values are straightforward to map. Some
> properties are clamped (e.g. voltage/current ranges). Common
> `bq25630_read/write_limit()` functions for this are therefore suitable.
>
> Interrupts are sent whenever a state change is detected. Save the state
> status registers in `bq25630_data` and `memcmp()` this in order to
> decide if `power_supply_changed()` should be called or not. The actual
> state values are in (and fetched from) the other
> `power_supply_property`-mapped registers.
>
> [1] https://www.ti.com/lit/gpn/bq25630
>
> Change-Id: I286c7a2f279cc28375a0c611a490fe7c8f77c08a

Please strip this unnecessary footer...

> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>

[...]

