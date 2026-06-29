Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010057.outbound.protection.outlook.com [52.101.84.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB89D436371;
	Mon, 29 Jun 2026 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747903; cv=fail; b=DyRcC4+XmtibHjbZxyVUa1sqbaHr2t1u1EqRLUamId/b6O026UnkQai7ZCRKsu7CCsHw8/xcGpMaR7MtmOhi0gKu2yLwwbjerLGKuireudeOZoPJ5c52xMSVW//hAmo6FPLdWp2iuf450FlIlloi9XPKNodjhqKdHC/gqI6pSCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747903; c=relaxed/simple;
	bh=V9Q0ok/1rX3waEUxj89jVzj0ih/KDdCqVx+xqckLKKk=;
	h=From:To:CC:Subject:Message-ID:Date:MIME-Version:Content-Type; b=chhFVvgcg9iHcckuV2MehEybvHVurk13tgsoJE8vWLxg4v7uOQPLoLUUFnMctx1htw4onull+NLgROIni0gPLC0D8zM/taLr7qxf8iHrPiQlX9tQCPPjc2uBQINFbZ2/tkFvz3HPWHhqi+2hMq69AVzduvvxNS66Lz3GvlKRqeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=K5NR0Sob; arc=fail smtp.client-ip=52.101.84.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="K5NR0Sob"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=habmh/+tvmCdD/Cm0Ws6R6qrp12oPWhwwKWgQ1/XKUSRcPrMvsvBffZ6nhr1T45drGO2bKvTH49mHuTsg1w05ui1BM6n849WoMsRohekZe9YuqoFEqcOCZQjrupfyzP47qfpv40Ayz3HN3mkRx0mhDCLlQG+SUUXoP6erEa4MUpnbR85Dxi6dJVludixFSAhy1+cfJgd6/ivIao3BDR0zqVAuHDY/jK0k8/dMpB+VbHqqWLMlVSosLf6+8Z6n/x4KMGOwWoZOsWq8kFLQdwGxTRhH4jdlnzN1To+pbjW3HiJL7yoKNzdDQWsDjn90tJeaLrSzoElBOTsIoGldju2Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VOnPHrygGZCuje/eN9WSFDcyVgRiWj1138XZQRhm0o=;
 b=CC/UoTbXJ41j7u9Df/AdH3VJ3DoJbfQXgHfdTp5axBWmb1Nbkz7mLzbD1wZgbTo6vuiVEozOfuoAVrBFWi+u1vji2qQSWleIsyJyDp94x9wrKT6Do+SvUq2cpMp6SX3IehGcUtaVbxUy/8ljilZm4ey08DRNeHouLTYKQ3czOrPy8h5hshN03Ish3dwkfdZx+kqzKHX1WrscELHQnKGTQmbESEKycNmGsl6YvT85hiqjfQFeYMggwDLQ/ysYtrQiw//uqfZXYPu35j/7pg5b9MhKjZfhHHwItorfJ9v5fAg/MOd9NBGrgJnKokmV0IVQTadtX+iwvGbyKAAuy7QKBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VOnPHrygGZCuje/eN9WSFDcyVgRiWj1138XZQRhm0o=;
 b=K5NR0SobX27rxpx00uDZUge/7iUQbG+5P1BgloyDHWuJm3FIY6m8K9Aj9SXx1SXdKR9e2b5XlHRaHHkpQVwg0xyfQcfUiK0IKWPpbBpseVJit9i5CWglD+XgFIO4oKZr76woMbjSPGXsKenbDWkbzC7zaRlm25CmDpH3oEs8aW8=
Received: from DU6P191CA0025.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::25)
 by PR3PR02MB6378.eurprd02.prod.outlook.com (2603:10a6:102:72::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:44:57 +0000
Received: from DB1PEPF000509E5.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::a5) by DU6P191CA0025.outlook.office365.com
 (2603:10a6:10:53f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509E5.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 15:44:57 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 29 Jun
 2026 17:44:56 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Shuah Khan <shuah@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH 00/10] Add sysfs entry for system load control
User-Agent: a.out
Message-ID: <cover.1782746851.git.waqar.hameed@axis.com>
Date: Mon, 29 Jun 2026 17:44:56 +0200
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E5:EE_|PR3PR02MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: 1764f4e7-748f-4137-9fc3-08ded5f55f2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|13003099007|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	rPVU9mKCOtybnVzkR7+vq0BFJDgEITYAgwThF8glZqtm5DvOQaF09y+mIl/NYfRA/YhHIUHelyOf1wgboZHM4T4KG1rHDyjQI8uk590UUYrhMdbP2gdUHUyvrK8ZGQ62hv2snQ7IGnCxX/njuxK9yQ2GimQELkKzSqous2n4ju9644Y4OISdcCxawIGEU2t+5oyffTgBhwq1auGCfL9L+cs6cKpk5zsPgNLHcNEc5dMiEE4jpoL/KP4P57WRMx2Rz1yyU9eyaRpuF5fHe1/o4ZaiwpRhuGCrfnLKyZrSomnDlwhtxc5Z0n2GZDm/5TKC24eikjxFLQ5p2Aj3T5T8z4mQB8gEP6qtJseuc0Bg0iotggWj+fjY7QNCMDEX7of5fCWQJ3Y61D2AQLlFB7C3nTCgxixzZBUCgb0eAcJS3MWMipcYmxT5WgqBcHPmxppmaekAVxL0opznTfli/Im7zZP6zxMhMVqGCaTp7lFgGCOxY37j4rvqzbBHdnp/W+Ku/CwqZy6BT+T6ZdCuAMJolC9vPYQp88/zgO7DGu0dG0crL7UIdA6BxhQ0E9Y9cVsQ+tTwI3PXWWm7i4YB2z0YkdQQeyNXig7J7sdh76dxZkpcHrNUJif9KGJ9o2quakzNVaXv64hnPNOsVLVEKuLPJzANJcYCo2vhmhsZhRLByHKJ/LlVfCpKWz0bkbhg28Snz9GaoTDouVFgEgZEsubkUw==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(13003099007)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dj7RoofVzS4n/Ao1WReGWvCyQORZjtlWf4kb8yiW2MiP10c2HZ+9SNasMPPspnxjiLk4S6lAsOwbH/2DUhfCNKHdSs3bF2+BHTuw9LXX+Lb3WNrIWUtsfULHnk1lkotta484Hw/px9y+ePeDf0Wfjw7ZiBdxAjwMtUA+yzTOukFrYCjKj67vu5z7E4ZkTf/CivdYpEcpfWTPC+aSgWGuqxo+IEvKPHrlApvOh86cstcKLQV6mWVbh0IyC9xka4hiauCbBfQV+8oAxXXYAFUqvV1t8PUS2ki377S57D3LdOhhPbY7BzUJNHq0+kXkY0DEXSAhQeC6q6ViI4F6AMNr3PrehMHC/ipWtJDG30Jlj+BeTsZ6CNZwuFtjA7f3zreYprPgZ2MoSC42t3R5GigdCLIbCW60CJ8esgJk0mECJzSb3wuUo5GQRoX0gfbVqQQl
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:44:57.3288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1764f4e7-748f-4137-9fc3-08ded5f55f2e
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6378

During discussions of the development of a new driver [1], it was
concluded that a new `sysfs` ABI for controlling the connection from
power to system load is wanted (often called BATFET). This patchset
introduces such one.

There are already several drivers that are controlling this, but with
their own custom `sysfs` entries. The drivers in this patchset were find
with a simple `grep` for `bat\s?fet` (there might be more?), and then
converted to use this new `sysfs` ABI. The old custom ABIs are left
untouched of course, for backward compatibility.

[1] https://lore.kernel.org/lkml/cover.1772201049.git.waqar.hameed@axis.com/

Waqar Hameed (10):
  power: supply: Add sysfs entry for system load control
  selftests: power_supply: Add tests for load_switch ABI
  power: supply: ltc4162-l: Use POWER_SUPPLY_PROP_LOAD_SWITCH
  power: supply: rt9471: Remove superfluous unpacking of propval
  power: supply: rt9471: Use POWER_SUPPLY_PROP_LOAD_SWITCH
  power: supply: rt9467: Use POWER_SUPPLY_PROP_LOAD_SWITCH
  power: supply: bq24257: Use POWER_SUPPLY_PROP_LOAD_SWITCH
  power: supply: bq24190: Remove unused watchdog struct field
  power: supply: bq24190: Disable watchdog with bq24190_write_mask()
  power: supply: bq24190: Use POWER_SUPPLY_PROP_LOAD_SWITCH

 Documentation/ABI/testing/sysfs-class-power   |  24 +++++
 .../ABI/testing/sysfs-class-power-ltc4162l    |   2 +
 .../ABI/testing/sysfs-class-power-rt9467      |   2 +
 .../ABI/testing/sysfs-class-power-rt9471      |   2 +
 drivers/power/supply/bq24190_charger.c        |  74 +++++++++++--
 drivers/power/supply/bq24257_charger.c        |  41 ++++++-
 drivers/power/supply/ltc4162-l-charger.c      |  54 ++++++++--
 drivers/power/supply/power_supply_sysfs.c     |   9 ++
 drivers/power/supply/rt9467-charger.c         |  52 +++++++--
 drivers/power/supply/rt9471.c                 | 101 +++++++++++++-----
 include/linux/power_supply.h                  |   9 ++
 .../test_power_supply_properties.sh           |   2 +
 12 files changed, 322 insertions(+), 50 deletions(-)


base-commit: ab9de95c9cf952332ab79453b4b5d1bfca8e514f
-- 
2.43.0

