Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792965924;
	b=jo9sO7/3ah1j1QmQGUBXjR80tcRpcVtJUtx6LS2nrirX44xuxbikKTwtfmeZwXofrNIc
	 gaBl22LRZuApvtXg7yK4fiaHCdZMU1H7MLosY4XbInIKStgTEN8IKoc/j4Es8aBjqlFbo
	 BNXB0sBkRjbZGnvDm0Kn6ceIC5tKAuhM2+OcwttY3Ag2xHE/RKfu10hv1PtJhBgqk8tW8
	 SdKJ4vq6VurHP1634Myt2gPhRl2KuXTHECqm3QtI0nXdORQIDdR8NOysvMd+B1HCwBoPI
	 moWHPpcBZkjj11543KcKhT8cuhDP4X0nR+e6wZuW5xGW2s15+WlPtJaLeh9zsVXThnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792965924;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Message-ID:Date:MIME-Version:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=d583kzAqATPSJijV62pWNHNw+7YiLT1wLwEAIMphnfM=;
	b=5X9HZy++MA54UZNkBQdpO8AinJptL9bPdamZTh14qfBVNCSOX5ZRncW832k7I8pW1sVF
	 lvWwz8RGtgaMBzsWOGI+z1GbdCROBN7f1VfmDXpWWg6he5XjkdDbkLsHQYwVHAMTGwStC
	 geU+TljEZmI9oSkGWf6NmvGd5WiAiTBhlc4ZU3MXMXLoQlhmd11ZMkfV7IBgCx+cwtEsz
	 Osk4xDjJVHBBb7iXCKBw1HpzdN0QgaCNjRNPG+92oxb3/3fHk4KhMwenbfHeTCl4uZAz/
	 1O/HbKM0sll3E+w722eeP3UmISPInARHab0ehQJEEAsUW0xr7N94kXcAsexb83JQM/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b="U8mib/w/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.10
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010010.outbound.protection.outlook.com [52.101.69.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7461C606A31E;
	Sun, 25 Oct 2026 22:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7461C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=U8mib/w/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+rZxuBMhNRibmEudruPhBiaALZfv3zsS2z0BqOgVKu8KK214L9uhATNbc+ZqSG4xL2Xwv9o90tX/NUU4fhoZwU+YZf/9mTq4HaUzmcdQCHnjsIeLda+drUkOdp1Fj2PihO1iWBJE0vHs4kzvEc7CIIbZ+EMgpLg47cOZUHMehTM8bF936uFNQMh0NKoMPyVUL7EgZhRxQJL9U+uwaYOc5MowOkrDT0fz1wBItRgVxIzCjfIchIDAnrVo8LsxVcdjG+BFBFr0ruHXCmPZDNtJfRa73QkJWJ2ZxY/8eLJyDc3YjZDUTz/C9GmXwaJc1i2YcmLs93q/OZ2tSIssxq32Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d583kzAqATPSJijV62pWNHNw+7YiLT1wLwEAIMphnfM=;
 b=ROahrcsAQ7bscP7MXHjAonOjMGNlap3S1yeziGoCwyXQ2GvZIFOi4VP85UqPRw/BUdVqt4r/0ckJ5vQmi2WFjXmTDgBQ6Y+cgXw8m+gw9V8IUXirXf1pi1rVU7MzjfZuXwtGiNSnENJLSd5dRZvOWwnovZGLnjb4atOjZnc4utB/GqWfm4qbNAE7e5zsTL36Wt9rxCcCRyOA4JFue1etuRx9QqmorN+EVR1759gIPNlD2AWdkD791ook+cBvxEOjw8h8wXjMdR+gcOWrSUL2Fw3jHxO8o+GKOBy83ASUtXA9DLt3alpIKcY1svqI60lEKiwldWEGw8y81eFTenH/8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d583kzAqATPSJijV62pWNHNw+7YiLT1wLwEAIMphnfM=;
 b=U8mib/w/+L/QUFlrUyQhuNlxHyJh6uyJnuAWcbo+J9LxhFfMmqxWnwvAVm3bUeOXtAZPC7qwG8ZOoCrjjbpa/7s/3ef1WXG9MBeHwTr7nGEqIXGSZn2wwPboM92fHH4Co35Dq3LNgc1NmVGdvu6DxPSLwiz9YYCGGP+YdzKI76E=
Received: from DUZPR01CA0132.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::22) by PA4PR02MB6991.eurprd02.prod.outlook.com
 (2603:10a6:102:105::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 25 Oct
 2026 22:05:19 +0000
Received: from DU2PEPF00028D09.eurprd03.prod.outlook.com
 (2603:10a6:10:4bc:cafe::69) by DUZPR01CA0132.outlook.office365.com
 (2603:10a6:10:4bc::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Sun,
 25 Oct 2026 22:05:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D09.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Sun, 25 Oct 2026 22:05:19 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Sun, 25 Oct
 2026 23:05:18 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 0/7] docs: ABI: power: Clean it up
Message-ID: <cover.1792965060.git.waqar.hameed@axis.com>
Date: Sun, 25 Oct 2026 23:05:13 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail11w.axis.com (10.20.40.11) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D09:EE_|PA4PR02MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: b8166a3a-d595-4713-8ff4-08df32e40eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|10067099003|18002099003|13003099007|56012099006|11063799006|261021121427099003|261021123027099003|261009223027099003|261022075727099003|260925021311599003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info:
	eIQH7dublBXR99AsVK4LJq4osrpKB929Ce1pwcBby547gEw/u3Y8RugCPzrF/8t+prFnsEEL3sKeVli93KL3sLJtKgt5vFxT4M4eHI0r7R2jcWQ8xch3DLR2aCXF7Tu6l3ZfjqKHv8XOBXm8GsbngfhEGRjcqiMw1poNSATf5s1F6tvJUPwjGaSjOnn6ZZzx7iLCh8I4LvJK/QIkE3YeJOSja1KfC5vuRO4BreAPxVyWQrcXw9spSIQeA3go4zyA7e9StQg+pTGiyXRmD0TvljgFbFQQjPa1zc4dDu+B55GUd1HRbopFvVVNs1S2s+MUzcS2rQDlnDilxFlq2ao3QD3w+OMax3J8qcWiSzYEkUC+2UMUtZUqcQU3r+P30ca7EaQ35D6QQq6d6emiSnAcp+qyndUHFjzjB3M6YnFtczC7kcbaLvJLkOyivAS/Ar0QOqBk8EJpyQg7YZCH9wVwfRQa1tMZWJm9/eLaMnURlxHAw4vjMEgNtq41I0cpn7IivP0y3GG4lyxINivk7Qu0Glx65Xfh+VMbqrpGnx4BLlduj6DOGJ8l8WZqrfYwFaBmSc3IYihRnrUEO5Tp0sl/8kJHiULCpY1+XDW3Rhsaya1wssh7JtTuiX9ihQRqYRjIl9LO50fToQ6AsQWTTJmXOMzpbHz76U9pCMN+ThXpNZQ=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(10067099003)(18002099003)(13003099007)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261009223027099003)(261022075727099003)(260925021311599003)(260925021911599003)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RmidwPYePt0JcX9A8fxlLHBEuo6H9Tz85zKOKacPSM392uhS3ipT7yzrlANE4i5ycSGZQn9RW+uor07gh42bq/ieh3eyDU43vwDPwnIx1LvjX0JVCyFRH6QKtdR0WmrQmIYUsnMwII6nW4I++cU3QSnfBKQiIBvB86127b1ZYbwAJScOiQQ8Bjp+K6etgcwf9q24dsauBvkFM2BoBe19oHWVAU83BzD7VNoT+bczkUPI/cqy2l7v2X0jGo5k5WaCzPm4SOmX6tm8NG3WpQfSolTx4DBx6KUfGYxzSqgnVpesBpWvJVXkWFswXs6ZDVpgST6plezW76mgwcLbo2uS4IWOtbQ2MmPVicwQQYKGTNnvlhmqyjmDHH+tSsgl2IVPB5StddysY5bwW/hnwu9+SvLmWgWifHjUxaK0Dz5bIUa+frEFFFYfRS+G2wtUp73H
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 22:05:19.0031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8166a3a-d595-4713-8ff4-08df32e40eb7
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D09.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6991

While working on adding sysfs support for system load control [1],
kernel test robot reported some warnings. This patch series fixes those
and some additional ones that were discovered during discussions [2].

[1] https://lore.kernel.org/lkml/cover.1788290289.git.waqar.hameed@axis.com/
[2] https://lore.kernel.org/oe-kbuild-all/202610151025.1g5IgCv2-lkp@intel.com/

Waqar Hameed (7):
  docs: ABI: power: rt9471: Fix invalid inline emphasis
  docs: ABI: power: rt9471: Add newline for paragraphs
  docs: ABI: power: rt9471: Fix mismatched quote
  docs: ABI: power: rt9467: Fix invalid inline emphasis
  docs: ABI: power: rt9467: Add newline for paragraphs
  docs: ABI: power: rt9467: Fix mismatched quote
  docs: ABI: power: rt9756: Fix invalid inline emphasis

 Documentation/ABI/testing/sysfs-class-power-rt9467 | 5 +++--
 Documentation/ABI/testing/sysfs-class-power-rt9471 | 8 +++++---
 Documentation/ABI/testing/sysfs-class-power-rt9756 | 4 ++--
 3 files changed, 10 insertions(+), 7 deletions(-)


base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.43.0

