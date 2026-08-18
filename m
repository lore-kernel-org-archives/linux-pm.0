Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012027.outbound.protection.outlook.com [52.101.66.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB593BE633;
	Tue, 18 Aug 2026 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046522; cv=fail; b=C96DxEaPzh+bV7c1HRhuA+C0JyJMA5VoyEq0XdERRFBYJ6RffRKAA6I0bZz46Bn75grwcMFxmuSoReQwqUo7zbEjqsO+MGNpamui/dhtUQZKDPI7BQcZ/57DNWJxG3CH1AyB5LK/bT50KL452CJHS85/EH0PnJmqeuWZ6XUM76g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046522; c=relaxed/simple;
	bh=mTAZ71UrDJprh5PtjEAUgGZEvYQABnhveW5GbZWDLo4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=n8PHNHF20I7RkEJgDwpadKEruc1YVPq2jbA6MgCS838u7FO/3ZNsN6BsH5eiCAMF4pOk//ql3tqlVWSja92VCXUyxpj7OMg5hmL5iYjzQXtpCDxfbZmJOiGLTYvPJfkO46wIDNtVUAURTS2f8j57Qk6DxWxpq/T2eh3llSIzs1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=D+hZcLCq; arc=fail smtp.client-ip=52.101.66.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="D+hZcLCq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrG2A+DxqcJeUgZriMBA4vFm03p1WR1Wz2oe7XLVHY+u/JC5hTaN06gFeTB5s1ovrY7ph4Ln0tQd8kZbPNDzzcJ2rpjk4mJR3KdlRDE4vBrCVxTGl6xwC/crSIwgqqNT8QNyoQMzkD9b07dRTTOQIG8X+In+gRPInK0qQHS8XPR79GyuRW/msmSlnEe1UiIhwojJINvtxXS7TL1L7kdfHuGK7lBUHrruoJ1BZnS+UfrCO7xRhOpk1sg5kX9iyEEtMLWXM04EWJPxohaovNxP6ryFZ88gahG6REsv7okxTF9VNLcBF/5rAemK5cN5yytHgvOgfTGGicRFVQJHmmmn1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Y7xgcpETsPdwai8VCul2/WLPXZQEo5auSKIocjGXio=;
 b=vMj6WYgh2dgTls3HxM6dYecw23QnqDWEBvjs9mVEqytzpdJDPnR0T5uLhocR9UDYv4+SYfdUqBMYATldUJJgo3nWD9/nXbF10x2ZtPGNyH/6KqG3YPGWKsxgKdsBoARRLBqnfiyPSxGYN38HFqooU24xLgNZufzrq5KAl7KbRL8MlbgRK5BNi7qo/HmsWCYfAX23YxtfDbzI/zzxHk9mPGwgbJxka9X2Cd3Ovl/kClElsW1TITG6TnRnAufwezmJAABBUoCpaoG2zDKH8qsXzj+Hh89lJBVgyfYt4zZl3b704Xc/D3me+Oq3vmX2Elo+e4hQiXP/QhAPQN71t3WC/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=collabora.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Y7xgcpETsPdwai8VCul2/WLPXZQEo5auSKIocjGXio=;
 b=D+hZcLCqH/JC+0cI5xHispp+ZMq8/wXCW3kU0q+Qe/M2bKqWlUSjTswXzReEfiT5rB2ljbjGiNBGBGm9QZHzXxe+6SARgjyBTnhLxv6TjV2WjrDmhNnGVGoXMT/NW9nnUboc24VRdK3KMJavaphc2gs/kc+8A64ly2NZ1NXRlxQ=
Received: from AS9PR06CA0238.eurprd06.prod.outlook.com (2603:10a6:20b:45e::8)
 by AS5PR02MB11270.eurprd02.prod.outlook.com (2603:10a6:20b:6c4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 09:48:37 +0000
Received: from AM3PEPF0000A78D.eurprd04.prod.outlook.com
 (2603:10a6:20b:45e:cafe::32) by AS9PR06CA0238.outlook.office365.com
 (2603:10a6:20b:45e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 09:48:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF0000A78D.mail.protection.outlook.com (10.167.16.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 09:48:37 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 18 Aug
 2026 11:48:36 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 18 Aug 2026 11:48:36 +0200
Received: from lap5cd525d1j1.sto.se.axis.com (dh-10-133-4-142.sto.se.axis.com [10.133.4.142])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 67CAF2333;
	Tue, 18 Aug 2026 11:48:36 +0200 (CEST)
Received: by lap5cd525d1j1.sto.se.axis.com (Postfix, from userid 22105)
	id 4DE3F803B02E; Tue, 18 Aug 2026 11:48:36 +0200 (CEST)
From: Henrik Grimler <henrik.grimler@axis.com>
Subject: [PATCH v2 0/3] power: supply: bq27xxx: add bq27z746
Date: Tue, 18 Aug 2026 11:48:19 +0200
Message-ID: <20260818-bq27z746-v2-0-0371e206665f@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGMqhGoC/0XMQQ6CMBCF4auQWVvTlkqLK+9hWNRhkFlItTUEJ
 b27FRcu/5eXb4VEkSnBsVoh0syJw1RC7yrA0U9XEtyXBi11I61sxeWh7duaRrgeDWpC2RoH5X6
 PNPCyUeeu9MjpGeJrk2f1XX+IU+qPzEpIUXsz+NppeUA8+YXTHsMNupzzB/LAHVqfAAAA
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, "Andrew F. Davis"
	<afd@ti.com>, Chris Lapa <chris@lapa.com.au>, Dan Murphy <dmurphy@ti.com>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Sebastian Reichel
	<sebastian.reichel@collabora.com>, <kernel@axis.com>, Henrik Grimler
	<henrik.grimler@axis.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1641;
 i=henrik.grimler@axis.com; h=from:subject:message-id;
 bh=mTAZ71UrDJprh5PtjEAUgGZEvYQABnhveW5GbZWDLo4=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBqhCplg6F6Yz4tES4xt6b3M3MupFKMamXQi8P1l
 habvzaGgfWJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCaoQqZQAKCRCwB25JC3Fh
 a3e3CADAKl34RcqtzAYzUv3G9JvJsBmHTPxBduNWkX3eRrLmWXK4dGnn+HnKpnyWdmu2+EojDV1
 owPk8oxxL2308y72Ppqu+wu9G2Zvl8J4p1tffaGwHqMK++K43EnTSYDF+cuLC7Awh0BwpzCWJ8o
 xFQ+gEbYSWmUsNTG4zATYV3xrw0u6VXzTrzneqYLZ1wmHahyxJRgLSHD9lU4sPVSE/cjJgHWaX/
 5ivTyLbKUj8hwuvyslucqiEG/6bQ2Xy36HHyZ7/j6psjdv+vSbhw9/CZ/PWkCnZ1GcZjEFdQ+Gg
 u8qigjsH2ZFHuFVA3xQ8traHUOIV4Up9D7WqpktNK0c9wAkE
X-Developer-Key: i=henrik.grimler@axis.com; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78D:EE_|AS5PR02MB11270:EE_
X-MS-Office365-Filtering-Correlation-Id: f21dea0c-6e6f-4bfb-d595-08defd0de068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|23010399003|36860700016|1800799024|13003099007|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	FtmZh7FurqCdtDau6YZQo3PZhk9ZCLEqaN/yN5OhJlsrYWPJzSkYcBVdr4qfN7xVGx1Jh+t+00TGa5CgbQmxfDorTPvzc9pqr22atqmHpnN1FU9LfrZ4/LOj1gBEb1xv7V/0wGn57qD6MCXuRVtXyEgaqRZfFeU6HuMt8B5fKAm3ViE7DHMXUvsuycY/zQuuWNxLHqMnd5hEQlgneTyLORiSOLF/plBuxlH2V3kMzt2kPAw/mpxk5mfZjaMyKVRnnRhlU2vUOmdiq5iVvZ5KT4L2A6EKFqVviAyWu0/hYuNgrZpRAszZmJY5qN2s0T6dDspn7SY1UnxSODVrBMFwxCd6JPaVP1cas3RWTaL4G7ErZVwXVF4HT1qTNIeuq8dXfwssOGhp2KKONAs2txncLySMy/m8wcC0oDJuPweIfp0gLXDZEFSDYebruHmfuqhZcZ3HvcXee9qBbiHV8cpCwRUM8zSxgzMcpy/ATBret63/BQaA3c0a+MjJXTQDpf+OjbAbKTxxIYwsqOapyNNfeViPlW2L53Ou0SdAqMBpeHm+CdOqirGCgMoTjaxnDJ5f1vSjzI9KiCb+sbiUZP6rFPG8/5Y4VQhIxoZVBCXrcQON8Pd+WgE8pcXkzP/U96a0FTJgeA8FTuyfVv5amgCowA==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(23010399003)(36860700016)(1800799024)(13003099007)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VyRwmLUrK4TUQDHVK83qr3geZ5Vtl8NmaSnZHLD8wXvm67uVd6TRfqYNn9W/1BfO1gnZPcNs4ViTJTiB7Z/TMscVhjTq+n8Emv58CPMJNNokudl829sG+fu+N8Z8fNfp2vTF9RcBPB3olYrr4Yo9h2OOGHZtbb1mdiBynto7+PqXf1o9DZj0Rki8YA2VdBXcPVh4LUqvCP7CnxfEy/LpeAIYqwLnKIlVV2DuZFhy22GZvvLuvQbgmXOcMk0KDgP1P0eLDw60SVY8wS6bZmrwxBWwr2SqXtjfA36YUCQnuaj0tVXT03ycfbrqW1ZvRNxp3zLuDp3ae1LMQeRnPpA7cXf2Kk3GhclC+aEoLBlQfoltaadtYfGNZTbrveOoU01ymg62QC2Br0+subYW59aOGAVkzjpFgWkh+NEXnyhiC3e/DSMreuc60e0SyJ7mNmts
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 09:48:37.4136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f21dea0c-6e6f-4bfb-d595-08defd0de068
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A78D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR02MB11270

bq27z746 is similar to bq27z561 but with additional protection
functionality. The standard register set is identical, but the
extended registers accessed through AltManufacturerAccess has
differences.

While working on the series I also noticed that bq27z561 supports
interrupts, but the dt binding marks it as unsupported. Fix while at
it.
    
For reference the TRMs for the affected bq chips can be found at these
direct links:

- bq27z746:  https://ti.com/lit/ug/sluuca6/sluuca6.pdf
- bq27z561:  https://ti.com/lit/ug/sluubo7/sluubo7.pdf

Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
---
Changes in v2:
- Rebase and drop applied patches
- Add patch to add interrupt support for bq27z561, issue found thanks
  to that Sashiko commented on it
- Describe differences between bq27z746 and bq27z561 in more detail
- Link to v1: https://lore.kernel.org/r/20260811-bq27z746-v1-0-3a4fa38205cc@axis.com

---
Henrik Grimler (3):
      dt-bindings: power: bq27xxx: bq27z561: allow interrupts property
      dt-bindings: power: bq27xxx: document bq27z746
      power: supply: bq27xxx: add support for bq27z746

 Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 2 +-
 drivers/power/supply/bq27xxx_battery.c                      | 6 ++++++
 drivers/power/supply/bq27xxx_battery_i2c.c                  | 2 ++
 include/linux/power/bq27xxx_battery.h                       | 1 +
 4 files changed, 10 insertions(+), 1 deletion(-)
---
base-commit: 2da28b059e0ddcd2e1956eeae383246207965573
change-id: 20260709-bq27z746-8dc4c2ec0948

Best regards,
-- 
Henrik Grimler <henrik.grimler@axis.com>

