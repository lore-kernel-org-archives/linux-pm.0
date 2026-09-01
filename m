Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013030.outbound.protection.outlook.com [52.101.72.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB67D3A453F;
	Tue,  1 Sep 2026 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291316; cv=fail; b=j/jgwqp7NcFX6XiWJHKaIo815KfTGjmJDjlJtKBNgRHm4hF2Zl3NrPqIsvkWAd8IflH+NNxoM9LSiLH5nAm4N76iYAQAAg9dmuPWjzu4zvpSLJuKJSvB31BsVQXrxszKYfnZn9ZCwdr/m+HetjGivZ9hu/GHjCYn4XeREk0L7+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291316; c=relaxed/simple;
	bh=WoATPQlmRCmtWClOaQXIiQ5ozXcarQqg5FqxJU1dtbY=;
	h=From:To:CC:Subject:Message-ID:Date:MIME-Version:Content-Type; b=q6CTw+3KYGQkqCIUr03VHIDMZjsYlkklebbLjrWhZgCLiLd9idBboxB2fZwFrWmqOMSZchUjAJZJas7gr+0TY3q7U7FWqzLtSyKx3mxDshXlsNPuFaD4SW8ufjhuZ4tL0nqSg/FQJkLOCDR82Dlu2tmC4HzNSnsVfD3DUjdI/yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=FK2GMAv/; arc=fail smtp.client-ip=52.101.72.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="FK2GMAv/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVhmwdijZA2yt+Zf7ikPcrDzB61vHq/V3EUuNySfdbY7HmvmR5i8OXc/e5qzYbXS3qLp+F7ycDYOtCDzQ7Ai9t2bR5+7Cx7lI0UcRVF+zkaMqPMOM4zmrDqQCHTsBs/hCdLWv4lkcXUlL3zCL2M9/GRtkYu9aCkAOJ/CjXycbxxiNOgMwghDI8CBts9K7ivrEMbVtf8lLOZB6943OTQvQDBoVnFB3wtAPncHC0A4fLw8O+VpCRfBMKvSaj2FNxHc/5Nnl3zytkHz6SAKVPtEqEs9DoJjaJPPDRUL0J7zFiidO/6ic8iyMqB9tKvvz6lrXJWDa+FgwshT5H1OtFaeuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnYjDxigcEXKr2fxOLa6bqtky2yaW6U3xZ5vg+MBibA=;
 b=OAQJ6A5I1p29bwF/gmIdNS74HkXkjOlwSm2KLUJbKM7Zk11Er27CrqmpyEWX/TF0GZKYQiWAYcTsHmC+bY82jDTeVEpTOuDnif/78WIbxaRQLeCBj+UrydmlAEkWM/NywY46MfzLVoUBlRbmVY9GBjC34t/CMYjUyrKy4Z8gSZTS1siXUISjkzk9k7AbiUqVXWj5Y2+P2+TIkTk3fZjxhrFssQZCU9h5CD3+2loAeCtafqy4W72L67FUUvsbwqv49AXy1VgWt1ZPPG6vtnGOS2P79nBk6iZ1tgKERlOZAN/VOFxSboPOkEP75xiXKQE961x0rBeYcYXHkCLH5Fojrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnYjDxigcEXKr2fxOLa6bqtky2yaW6U3xZ5vg+MBibA=;
 b=FK2GMAv/7/fKw9Ht+w17AE2GVPWvKfk7Jb2SU7E6ZiilrDV/VSgpAlb6HRJ9MoNEJb5lt7UtUv4+3O0v66P0F12zx2O6qLwNah/Zo4cQ9EatlZN6oNHbDYW0nXdqK3wXvpOqlphJB+RQV/No5xU+F2tAjuPvjd07juPopW7F4zw=
Received: from AM0P309CA0018.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::11)
 by AS8PR02MB7801.eurprd02.prod.outlook.com (2603:10a6:20b:441::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 19:35:08 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:20b:28f:cafe::51) by AM0P309CA0018.outlook.office365.com
 (2603:10a6:20b:28f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 19:35:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 19:35:08 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 1 Sep
 2026 21:35:07 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/8] Add sysfs entry for system load control
User-Agent: a.out
Message-ID: <cover.1788290289.git.waqar.hameed@axis.com>
Date: Tue, 1 Sep 2026 21:35:07 +0200
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|AS8PR02MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a2ffc2-4e10-446b-b68b-08df086021d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|10067099003|6133799003|18002099003|56012099006|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info:
	KX7or+iql2ZkPd4Y0k3aul4RUanxSU++Wc7Er9BDsUJdIZWfO+Xatvf2G8U3ukc1dRxSDxPIJByKmFmK8rHyH9GMxPEiYWcJPO5FolH4h65gAgfjs1artP6U5T1ylZLBCaPHJGW+/wiW9P8Asty9KluEIMjHwmxvwGpmLxvZ2RTgDpzpaauKjZwHPoSGZ7kABLF/A3oSXPd7lS2J/ymlTYfYmjuOpDMRKnLt3ePmLhzxeUrTqA6ttpTADI+THsS6Vvr8NMLJGelH9Z/7v9Zq2+CVOKaRlbTDZWlPh3K7iO9eBUKn12gC/pux0IQb2caKWEPMX6aC3YstrvpZSrxgytYn9H/F8Vgt9qhWerv++SdPjhkjfilx6KkVjrkMuasrzpzpxyOgavswP3UauwGy/QdmnTgjZJi6MW2ykBgpchpfe7/Y8FZWoncMLugaCPcBbl3LbCLw5G+ALg6DJ1gmDZNdqtD4K0libipqceVy2e9okByi2b2iY2wqEz4bxB9HRDCUZgZap6zn1Xm8IUk9dPBKfJgFksJvf36YPZunNsjRdYa79UtKa8IzYvjqtIYTZelj0ojJDonIudhx/dGwOwfxx3QaoceK8BAmw4d0qY3BSG3FCi0qqZtIcrJI40oiFyjuKsEXWKIac7RvOkoUB7DqyhWWtWYOfyFgwG/xN4QLXaZgguC6AxGV6j0Cr0Nhg2E1vJG7Njl15kEda6vf3A==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(10067099003)(6133799003)(18002099003)(56012099006)(11063799006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EAgyraVj+RSrHJ2GCAkMpUCcH/KD4GaGBYSjesW7razo0RL1N1WLpNt627Loxu/mwSn59vxzYUOxUwiF/anqsX3bPm9CJUHjIfPu/NVI/ahImtVy+/8MjNZYa9BmJ9Y2Btcwu32XwzEOvCI4zEthkcZXzji/F/rEwWhiA8sjcRItkgMMmFR/DcoZVlLXsWmUMQ2Hw0H9xezEct8gfAmLqFJgsc0CvprQrwMS5RTiD/bovCAN/ArQ92wEMaX4CIpxpIvHbExajz9ROXeoTvu7RcQUCJNi8/N4F3XNEZmukgWVx7tmuYlnhI9GlA3POzmZnsEId8yESeeLyRAu/oMtkky06hdeBnsWkuUEC0t5w5NFYmGAtIp6TeLRpHnkDC6QWKkfbJaI8kh4ew5FfyX/wXl7zMwiGajCNSxTOrUA2klbd/kbrj4a7nQO3GTOvSmj
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:35:08.7192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a2ffc2-4e10-446b-b68b-08df086021d7
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB7801

During discussions of the development of a new driver [1], it was
concluded that a new `sysfs` ABI for controlling the connection from
power to system load is wanted. This patchset introduces this.

There are already several drivers that are controlling this, but with
their own custom `sysfs` entries. The drivers in this patchset were find
with a simple `grep` for `bat\s?fet` (there might be more?), and then
converted to use this new `sysfs` ABI. The old custom ABIs are left
untouched of course, for backward compatibility.

[1] https://lore.kernel.org/lkml/cover.1772201049.git.waqar.hameed@axis.com/

Changes in v2:

* Drop already merged patches (picked up by Sebastian in v1).
* Pack `struct power_supply_desc` so that an extra member doesn't
  increase the size unnecessarily too much.
* Use `power_supply_show_enum_with_available()` for
  `POWER_SUPPLY_LOAD_SWITCH`.
* Drop commit for selftest since properties using
  `power_supply_show_enum_with_available()` don't have any helper test
  functions. Should we add this (in a separate patch set)? I'll others
  decide if it's worth the churn...
* Add implementation for bq25630.

Link to v1: https://lore.kernel.org/lkml/cover.1782683551.git.waqar.hameed@axis.com/

Waqar Hameed (8):
  power: supply: Pack power_supply_desc to eliminate holes
  power: supply: Add sysfs entry for system load control
  power: supply: ltc4162-l: Use POWER_SUPPLY_PROP_LOAD_SWITCH
  power: supply: rt9471: Use POWER_SUPPLY_PROP_LOAD_SWITCH
  power: supply: rt9467: Use POWER_SUPPLY_PROP_LOAD_SWITCH
  power: supply: bq24257: Use POWER_SUPPLY_PROP_LOAD_SWITCH
  power: supply: bq24190: Use POWER_SUPPLY_PROP_LOAD_SWITCH
  power: supply: bq25630: Add support for BATFET control

 Documentation/ABI/testing/sysfs-class-power   | 25 ++++++
 .../ABI/testing/sysfs-class-power-ltc4162l    |  2 +
 .../ABI/testing/sysfs-class-power-rt9467      |  2 +
 .../ABI/testing/sysfs-class-power-rt9471      |  2 +
 drivers/power/supply/bq24190_charger.c        | 62 ++++++++++++++
 drivers/power/supply/bq24257_charger.c        | 43 +++++++++-
 drivers/power/supply/bq25630_charger.c        | 84 +++++++++++++++++++
 drivers/power/supply/ltc4162-l-charger.c      | 56 +++++++++++--
 drivers/power/supply/power_supply_sysfs.c     | 17 ++++
 drivers/power/supply/rt9467-charger.c         | 54 ++++++++++--
 drivers/power/supply/rt9471.c                 | 54 ++++++++++--
 include/linux/power_supply.h                  | 18 +++-
 12 files changed, 397 insertions(+), 22 deletions(-)


base-commit: 73e3f0710014fe6d4ed98cfc02292f6121db7558
-- 
2.43.0

