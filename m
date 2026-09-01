Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BEB3A1E67;
	Tue,  1 Sep 2026 19:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291317; cv=fail; b=qA9uEi0cIQrs0LjZ8bo4lQkxGM3xE8bnJBY/EyMPN7vhddwJN79ixjNCIhrdbYhg3nPZyYWnDWBkVn0R4CujIk2jL3m25fLDY+5S8WyeYt1jLAYAZZcj7jOMmca4qsgVvC3n7HFToZvVnmkw1uNlNKCii3dA0picYblyawfvIYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291317; c=relaxed/simple;
	bh=KaIYbjJyWmFjzySFgFo00E5lChAw+KsyyTR2G/XlqJc=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=EQzAcOULwl0M3gvODgrY43Xt1ylaYsBsYG+eX5FK4P5V7MJt18LkboAgwooVWjvlq1cim0KX+d6BCulBEUti8ACzLgNbtG/pc7P15J9tCcXR9xhEVxnaRC5cRjnBqNcX49iAACZhwYkxTue62HbLoSzaMT837eRzkkMpso/Gsm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=ABsb7Wpp; arc=fail smtp.client-ip=52.101.65.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="ABsb7Wpp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sy1fY0mV5IkL0hjFnf5b+vj78BFAshon+wYLGzW7AKceSs0Dpn1g/DBGURyUI3GA2tkM9rNKLQ49OS/PLMlFBdiYX53trN3g3ttEXmPNNbZHi0CSgboNCRRM/hEZwFco3a2AZgLbmRMy+m8dLJemncEhqlPqMOS5PU34sF6fsK0fM/AOqOEm7/OSvz9xLIsc3vncJdKhh19hssd8Jzrcx20oL5TqAVOADKsIWHU2tEVMuXtgUeObGm1E6JuKYqaho6m6qz7Eek0Y9ahpwU0fBGaIRvitRfTa0uQ/8ETruC2k2TkfZ5VIwndbpj8gTGH4NUc8XDOcdPF00guEvIDh6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TftWA8QiFjcxFTiAZIUHp8fuMFU4sRhI5CTTkhEzq2c=;
 b=Qc4PSrD1li+qX+I+Ct6L1/YTT3rcyoQCaMUD9w64KT9kFHCrKmqCV4a7wspnBBIDHii+ePlCr7jbq20QjhN/Mwo4aGvJqwGPdCXk2lsoyQFQTkD3J6AGd7FngMJLITcCwOx6yiCz+nW67/OSJ0BZhGUN6vrnbbvVWyCeNDdpQDEJoh3/DHf8nOBAQcguICmXeMe+Co1rBcjHvW6TIe59UxKm4Zfz5Q/5jUkp2z/neXzLumoQkIgfsICYTewsPxONZmS0INxZbEwa/Tbv67xAjLkJ4f6CMGHjUVBAj95SgKEF6rqwKx739r4PpbX2rNDUZPEJC6QtSwwnXt0CQhx+iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TftWA8QiFjcxFTiAZIUHp8fuMFU4sRhI5CTTkhEzq2c=;
 b=ABsb7WppZ7+p2ToMEyZyXKbUltbd1YlTmpCb3OoWjLdnL9fXey7vCatkSz+NtCiVGVsVJKOXzJou+AlVZtBbUTeKPuY7Bxv3S3V0HRh2EXuf42WAULRxAsRIFQsxtxXA9Iv60JPXp8WNH/L8yTjwWyB8BBPAUxC7Unr4DhWqrlM=
Received: from AM0P309CA0012.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::19)
 by AS8PR02MB7077.eurprd02.prod.outlook.com (2603:10a6:20b:2ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 19:35:09 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:20b:28f:cafe::4d) by AM0P309CA0012.outlook.office365.com
 (2603:10a6:20b:28f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.1 via Frontend Transport; Tue, 1
 Sep 2026 19:35:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 19:35:09 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 1 Sep
 2026 21:35:08 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/8] power: supply: Pack power_supply_desc to eliminate
 holes
In-Reply-To: <cover.1788290289.git.waqar.hameed@axis.com>
References: <cover.1788290289.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <5b6d1d588c8aaf237c45638c29a2ff23f0a07f34.1788290289.git.waqar.hameed@axis.com>
Date: Tue, 1 Sep 2026 21:35:07 +0200
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|AS8PR02MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ff6def-88f4-4063-15da-08df0860222d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	YhcVAEpIghWTixBGBAI/Jj3onhSwEU4NvsxWpjSt5y9gJSdmb3HAMERWzMWHVejt9Y8GJiHyLaMPLAAErjm7Q0b8Lr5OVH+Tp/pA/awShXeOb2wlYbmtfrrUpORTdR3FLrDbEUg/jQRLv3l8+N5COh6e65PkYdkHV1USZqEJDXgY2UldFa0sqIWPuSYuFUMH6w4/j/TKQubrgZJ3YKuTt6KWYbzeLY6wwybMNvIbiBsx/L6iS0og6ob6/nA/LBCFSmSmklap6QZcdBuozFnZZi+Bh33NaenExiSrvhYAHRQ8pAQmIMkKBWY5d8U0ZxhE0BMauIDLdVKBr4v3C44yK0u4dLtsfaDB5XSllha2l8SdFTJ6uRFq3IzSnq1ti81N6Zq0m9PRYF5xjMb2BXhBXazsnmBxMapIirIB1zUboZBx65SvuT9IreETRqneIYMtYyPOlzF0OtDMI5ft2xUqqWGuqeq8sHmqudpUJAqVxLQvcHm2yFxvdk8vdIkR5y8xvtKx/CsFF+YQfzD721Mk01C+1bsGC6buGdT7LDBtEOvlAEvb1QnN7XLWAkmYGbrboeVTzjZobi77CuE9KCqEfHtnkXl3OgfYPM1DX0Kv8nY17XFy2OmHp5yQHMrY+27pihvx/kGnW85qfQd8eM1bzUopXjADNJCZScjRTJacH30bfLHrRzUf8vyrfHFtfLCnVPt+6Z0HMx1FA/3S53Tvzw==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6LAPP1X3H1+pXi6u8Foe+cnh3ZLo7T8vp5f5UWcpVNuJUzQh8zGZ3xvwrIeRx5GmqhmueYaHB97nYIc09H5qLxiSi1o6mIOO4eUUzFqAWAleAYvbMe5FN6zhoemh/njYEpKG3GELJKgSK1POzRQhRK9PPrFGJiaw0l5MoNfuzLgt2t9E5bVBsxlx6+fT0yF2SLmtt0PGL654eUbJtG3pejCb/a5V0HpCzNgxJwOSbLfdBgU/jGh8Cn/OGZ/TbebaKmOJ6nJ7B3q4Ob6L0zpuTzclFYVkDvhVng3XI9BBljHLfi4HAr8qMRKaItuApn+e4iddLN1b80RH5ieKzlrkfJHedYfVidSnxLx5tHKlKMqE7fr5yUvdnLcQ64MiFxX5xHjDoqiuSuxjr3Xdxk7sYJiYIpMklNPXU8d8VSCyd5q+g2qNmBh+VneSLEULEW7X
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:35:09.2776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ff6def-88f4-4063-15da-08df0860222d
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB7077

`pahole` reports that there are two holes in `struct power_supply_desc`:

  struct power_supply_desc {
          const char  *              name;                 /*     0     4 */
          enum power_supply_type     type;                 /*     4     4 */
          u8                         charge_behaviours;    /*     8     1 */

          /* XXX 3 bytes hole, try to pack */

          u32                        charge_types;         /*    12     4 */
          u32                        usb_types;            /*    16     4 */
          const enum power_supply_property  * properties;  /*    20     4 */
          size_t                     num_properties;       /*    24     4 */
          int                        (*get_property)(...); /*    28     4 */
          int                        (*set_property)(...); /*    32     4 */
          int                        (*property_is_writeable)(...);  /*    36     4 */
          void                       (*external_power_changed)(...); /*    40     4 */
          int                        (*init)(struct power_supply *); /*    44     4 */
          bool                       no_thermal;           /*    48     1 */

          /* XXX 3 bytes hole, try to pack */

          int                        use_for_apm;          /*    52     4 */

          /* size: 56, cachelines: 1, members: 14 */
          /* sum members: 50, holes: 2, sum holes: 6 */
          /* last cacheline: 56 bytes */
  };

This can be optimized by moving `u8 charge_behaviours` to the end and
swapping `int use_for_apm` with `bool no_thermal`:

  struct power_supply_desc {
          const char  *              name;                 /*     0     4 */
          enum power_supply_type     type;                 /*     4     4 */
          u32                        charge_types;         /*     8     4 */
          u32                        usb_types;            /*    12     4 */
          const enum power_supply_property  * properties;  /*    16     4 */
          size_t                     num_properties;       /*    20     4 */
          int                        (*get_property)(...); /*    24     4 */
          int                        (*set_property)(...); /*    28     4 */
          int                        (*property_is_writeable)(...);  /*    32     4 */
          void                       (*external_power_changed)(...); /*    36     4 */
          int                        (*init)(struct power_supply *); /*    40     4 */
          int                        use_for_apm;          /*    44     4 */
          bool                       no_thermal;           /*    48     1 */
          u8                         charge_behaviours;    /*    49     1 */

          /* size: 52, cachelines: 1, members: 14 */
          /* padding: 2 */
          /* last cacheline: 52 bytes */
  };

Do this in order to save 4 bytes. This will also help when adding new
members in the future to this `struct`.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 include/linux/power_supply.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index e749d21893352..fcd05f4a88833 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -259,7 +259,6 @@ struct power_supply_config {
 struct power_supply_desc {
 	const char *name;
 	enum power_supply_type type;
-	u8 charge_behaviours;
 	u32 charge_types;
 	u32 usb_types;
 	const enum power_supply_property *properties;
@@ -295,14 +294,17 @@ struct power_supply_desc {
 	 */
 	int (*init)(struct power_supply *psy);
 
+	/* For APM emulation, think legacy userspace. */
+	int use_for_apm;
+
 	/*
 	 * Set if thermal zone should not be created for this power supply.
 	 * For example for virtual supplies forwarding calls to actual
 	 * sensors or other supplies.
 	 */
 	bool no_thermal;
-	/* For APM emulation, think legacy userspace. */
-	int use_for_apm;
+
+	u8 charge_behaviours;
 };
 
 struct power_supply_ext {
-- 
2.43.0

