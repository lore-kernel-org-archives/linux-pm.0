Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011050.outbound.protection.outlook.com [52.101.70.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69673280A56;
	Thu, 18 Jun 2026 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781789886; cv=fail; b=QeBD5Hjud2t4qPIBSQNGEO9BZPPWzKdONn8cOxDJz8CBFHU++O9mCYTqTDY9ypzDqUKrz3AAKk1cLLlh8j0wNRcoQ1+DylvmfTa8KXVYfPjy1azmsB2FOxVIWD7egD4JYv4+V/id9JscJgKiHatuDCwddEk9gVwoMJu5jx+WD8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781789886; c=relaxed/simple;
	bh=5O+fEq+9Pf7LjoSxBCE5RXWGlB2lRpn/W7cq2aL2YUw=;
	h=From:To:CC:Subject:Message-ID:Date:MIME-Version:Content-Type; b=sJW4TATh2c1tRLKpIZU291F5nZw3GIzly53UjR2jhMdU9dOCGk6JHIzL65FKOIvSlkP6lCoNz9GBQg/jRKnpwo4rItnyyO8UhikhMMw7udak5IZc0ym4SxBBzJC8XLw2Hs3SWltvKW79r1m4oqAZv5MUgNfup1m2taTL7X99wOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=EAL3SmFT; arc=fail smtp.client-ip=52.101.70.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="EAL3SmFT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOctZmuTW6YJbNx23V3Ksn2uQrowOMeNF6Pdy601FBBUUifQO1snUwMcWtbkvRMZ260W6S0xwV2KBBQ6VZT0m8yflO/Abf9rtyl035suWONelGTyBPRt6nxCaqlOWkG7M4GBXkrsCQifn3uYjeFNEPDxn60NUUl/d8DsxYvhfDb6F6vAAbak3WX3bN8cYUVuopdyO4bQY/GzAoFgHvbEbxQTqB76cuAJS8j4F2EhUIoexN6F8vKC8JgD5PmDmbkv91kyZypXoZmw1oBbOa0KKjwZjEt9PyLQzrjB9MjpoQjndtr75OxgoILmDOoj2m/1o2E+yi3d/1gz6V+khiBMZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2YE21qve9F8w9gJJnucUJyZKxZBvNvlAw/rDM2EnnQ=;
 b=YsNYLeSA4oP1EN9+h4zd2xA5YEuLLKWYvu15Qpdn5zetI642hc42ARLnSg3U6mHZTkCut/DwknTbFsTC/TrflTGbKHRB3t6XdzHppddzrCULK0gDzvdTwEjFjjZaTZ+olHtgprkl8KjF7Q2munUYJ/cQ56echtf5+PWK6o7ibUOoXnMIbNOhZFhqN/1qP0+xSWpEY444rA6YOLWfkqlO0gB3F9oYLqRN/h7vGuXnGqbnUuI9aol1z+vwOOodWhzcdtRyWNGGQeVTIjg3FgdiUHU3ddtLmH2zbr0UFzyuCMd2LOg/sjdeTQDwzO7DUbrxOfRpbciesDvRNur3K1ZcJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2YE21qve9F8w9gJJnucUJyZKxZBvNvlAw/rDM2EnnQ=;
 b=EAL3SmFTrSKADlGETcWp8Fbf43WnOss3503OGlVNoryvV2OEyYi9sf2+yzHvv8DtwdvqaCiUKvhHbrQUsywqVnc0U3RJoioE9VJcvD7p7S6bJy8KVwsH9HFkaqVwyILo6T/ElHRcbOeQIyEWHWP5VGokajiMZwH6dDZ/NuM9OJM=
Received: from CWLP123CA0273.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1d5::20)
 by GVXPR02MB12020.eurprd02.prod.outlook.com (2603:10a6:150:31a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Thu, 18 Jun
 2026 13:38:00 +0000
Received: from AM4PEPF00027A62.eurprd04.prod.outlook.com
 (2603:10a6:400:1d5:cafe::56) by CWLP123CA0273.outlook.office365.com
 (2603:10a6:400:1d5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Thu,
 18 Jun 2026 13:38:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A62.mail.protection.outlook.com (10.167.16.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 13:37:59 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 18 Jun
 2026 15:37:58 +0200
From: Waqar Hameed <waqarh@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 0/2] Add driver for TI BQ25630 charger
User-Agent: a.out
Message-ID: <cover.1781789320.git.waqarh@axis.com>
Date: Thu, 18 Jun 2026 15:37:58 +0200
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A62:EE_|GVXPR02MB12020:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d42543f-10f6-44de-f86d-08decd3ed057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|56012099006|6133799003|11063799006|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info:
	/zl54JJdkNL+keAFD0O9K4hUcJ4VzIP4J+KPO+AQlAPFQX3EM7G5mrHdUnYXmI2NgvA9ebzo46c/RkMUcyINHXEqVIYpp32ueDMTgEkxjYsGPD2G2u1Eh/+wtuhfFK8Uhgw5GpBFaj5R/QuFitCoohojXuRYls4uZbgGEtAjcKlcarkYmXBQjCKWsWOfrTPEpp7anIPSgrsI8bPGEblAGUtXlmf8RKnGtXd1uNflAi1EzzXy2lUhYrcXNQrbz3pwYf3pXk++Vy0yNoAfYhHAl2ZtDNLzAEIZuRNkJd57jxxk/j3f+f4vgJHdbpC0cKdqeI6ZD0fQ7wN7yogWwhXa9Xs6Huq3wWCdJk7YnG+4j9QN97d8WfCxAI1XI3fNXcI3+UXJ7zmHQf2dZprY5zchcnwlte65mZyvyullqD4np7vx82DrDvotTm9+8MYNJKr8JPzO3IpQ4zokvWihZ+Ot0Yg3IeGbRgA01/e5kJfsdhgaNndAThHxDSBzno/C7Xxj8f2rhIgxjAg8BnJ7ZfvqLlaC2KKmaU9wiZYh7qFd35qorB+LSe/miP4DK9uMrl5mOhHXY3VtP0Xhhw8re7Y4ozxmIXFAjy/v6LdnyvrVY2Smetf0nIAoEA0YLsFKpl3s+ancn8O1D+u8YmCahuMrKl+P8TlhZs6pD1RlBZsj6YkMBXR1MsxyCCFe/B/CpmDcX5rQ4EDUZYW0mCFmIjwjYKBrRxeEQDNz9st92IzuVOg=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(56012099006)(6133799003)(11063799006)(13003099007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jIQx5RmIVnxRpKT3u9+8SYVKoBXtd4JdycwlhrxRumIKiwoLAQ/nYPoWOIjQGjiTLl3X0BY7CcUqaUd4t6CVjTRRrJuT7+lUJsz7Lvm8hDeIEj77PKcZn1IhBw/Yc1OZktwBpUaq9FPLbd2DWNNby7iXzUX4uy9frEksxD9Un2vXJeYYwq1KExBLXoKzMIYZwEYUdvABNL9K6OaPm2VtVPhHYhQWJtpQ036isygx3Gn1Hexqkux30NxyX1B25jgyCvUJx2oZMhkNWCuSEk7CvCuJkz+t2O0Gh90w17ZifD3VUMe7tLfuOxOWYXvwdXabOo/twxx+CLXPsrIyEBXW28sk7OBouTA8JibD/wvIq6fnC+KKLEJfXLaRuAqaejr/onaTFHQimh5pptKUA0a64nTA2eurut7Jp0esqJYCWMVTjZOxe2AVLet8xpJ++ozw
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 13:37:59.9890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d42543f-10f6-44de-f86d-08decd3ed057
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A62.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB12020

This patch series contains a fully working driver for the basic
functionality for the new TI BQ25630 charger (see datasheet [1]). The
other "advanced" functionalities such as USB OTG, BATFET control and
liquid detection, will be handled in separate patches (after necessary
framework changes) according to the design discussions in the first RFC
version.

[1] https://www.ti.com/lit/gpn/bq25630

Changes in v2:

[power]
* Fix return value check for `data->regmap16be` initialization in probe
  (check was wrongly for `data->regmap16le`).
* Remove TODO-comment about BATFET `sysfs` ABI (we will add a new sysfs
  ABI entry in the framework for this).
* Check registers `BQ25630_REG_CHARGER_STATUS_X` as well in IRQ handler.
  Because there might be changes that is not necessarily *only*
  triggered from hardware faults. For example, manually
  enabling/disabling with `echo 0 > /online`.

[dt-bindings]
* Rename file with `ti,` prefix.
* Remove battery-node in example.

Link to v1: https://lore.kernel.org/lkml/cover.1772201049.git.waqar.hameed@axis.com/

Waqar Hameed (2):
  dt-bindings: power: supply: Add TI BQ25630 charger
  power: supply: Add driver for TI BQ25630 charger

 .../bindings/power/supply/ti,bq25630.yaml     |   59 +
 drivers/power/supply/Kconfig                  |    7 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/bq25630_charger.c        | 1073 +++++++++++++++++
 4 files changed, 1140 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/ti,bq25630.yaml
 create mode 100644 drivers/power/supply/bq25630_charger.c


base-commit: e771677c937da5808f7b6c1f0e4a97ec1a84f8a8
prerequisite-patch-id: 7dfa938b45374a748d43880f3e8416e665134104
prerequisite-patch-id: c22d643d2a260a8dbcc92df0754cfdb480879578
prerequisite-patch-id: 12e94680b398a795657d3d2addcf55bed5ce62de
-- 
2.43.0

