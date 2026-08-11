Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013055.outbound.protection.outlook.com [52.101.72.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9753842AF9F;
	Tue, 11 Aug 2026 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448895; cv=fail; b=Wmgryxks8yK9UfN2z8/zLbeD6qPq+pjy5vaRjo5Ai6V/649qp2CoLOwXQKULORrYWrPzaCeC6S8RGWDo38tX2lGtqBsxCxV1KBcIiftONqAk+m6P+7b7yJzrymm4UmXDwIyb4qkEan8f/vCnMe/ujMMswVtjg6wKm/k59ju3V7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448895; c=relaxed/simple;
	bh=tT+/8ROBD28/OKzxAn3TsOOqh0j20qNp0hZxxxlZL2w=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=WKXPehdJzaKF9hgXHDuaGffScF0kG4siQ33DPxhvKD5C5gyp+yW/PpqiQiNmGwVMLuC+9+11ndgA3vrXIG2iCT4esNYJEi/CBLJx5FsyreGLTF9ezmyXIYICnkkRfXGx5aGK27pAa6dgqjkPMLHvfgCAwsYR+qIXwOd5SzgyzIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=bXbar/RS; arc=fail smtp.client-ip=52.101.72.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="bXbar/RS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1FfxBdmAdiQ4O90901t4v/HSjHJQJzDv82I/vPapGfqbuGjmY26UNLrY7jcQT2/AbbNSWEkpjgPw7VSsyDgGLPC2f2OzIkic94SBZRXMiSaPs5g0EJ3Q7CvEa8u18ofb7fYOnr1W0K7fzdsVQMv4esoLFKFxsmK0BkUhlGTZyqs4jTxWOspQqWzg2NjRMrPW9C7qwjeTUL38kDVocgTZVHN9oytB9KGyeo+1zr7xYBtijtZyL22LD697aHsaLdKDq36yOegheLvxntdnROHAfBhEdUJN0crKb7rahW734j9jiOanz0rAj+0siIJcik3feIZJTM0l7+ky/rMHHuWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nopil8S+wJAloN9yhMhZULYv+VAOSdPqqmXWKXi8bYw=;
 b=v7CGTJQCneB8vY7sCVxzRAJyhie9fKwYSI32g/f06PGLTcJ4BYbKBh5Xc6kC+4E3/DXfJLA4hfMtE5hEwFDmcBKiOdJV4QqmuuL9/0n9RTt/eJsrJcPZHx4fnlJUHqa5b3f/8gVUYx0QHnXa+R5jo03tgEflvFWRt2oiXXckVZOdkVZUDL+J17uYSr+CPNUV+E2u5Hicy4a54Qb0d3rzdeaUBBoAucned7WnzW/GXGFkFskG5zhnsA4SBbh/j3wdsXYh5UUWPA2lnO/4IT2UnR+pjICiCM3l+x76eVsJRwfmdjSf/S263l2cfoqQuYjDrSgugF3cPiD13aE2sftqLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=collabora.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nopil8S+wJAloN9yhMhZULYv+VAOSdPqqmXWKXi8bYw=;
 b=bXbar/RSgFzazGwelICjRIlgtctLrtc2OhTUHTohuqNBM1lzPWynaLNU+mhMI29B/1xJB6OzOHSvfBxwBsESz9clDEiBRIHy/zrysdIT5SDlEg5qevn9slamRHp/8syQKw985+h4b/J1XPAGLptEbL/fEUq8AzJPV5VS8BlTKWE=
Received: from AM0P190CA0027.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::37)
 by PA4PR02MB6589.eurprd02.prod.outlook.com (2603:10a6:102:fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 11:48:05 +0000
Received: from AMS1EPF00000092.eurprd05.prod.outlook.com
 (2603:10a6:208:190:cafe::7) by AM0P190CA0027.outlook.office365.com
 (2603:10a6:208:190::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 11:48:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF00000092.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 11:48:05 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 11 Aug
 2026 13:48:03 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 11 Aug 2026 13:48:03 +0200
Received: from lap5cd525d1j1.sto.se.axis.com (dh-10-133-4-142.sto.se.axis.com [10.133.4.142])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 601972034;
	Tue, 11 Aug 2026 13:48:03 +0200 (CEST)
Received: by lap5cd525d1j1.sto.se.axis.com (Postfix, from userid 22105)
	id 46881803B9B8; Tue, 11 Aug 2026 13:48:03 +0200 (CEST)
From: Henrik Grimler <henrik.grimler@axis.com>
Subject: [PATCH 0/5] power: supply: bq27xxx: add bq27z746, and fix some
 regs
Date: Tue, 11 Aug 2026 13:47:42 +0200
Message-ID: <20260811-bq27z746-v1-0-3a4fa38205cc@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN8Le2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwNL3aRCI/MqcxMzXYuUZJNko9RkA0sTCyWg8oKi1LTMCrBR0bG1tQC
 xa2KrWgAAAA==
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, "Andrew F. Davis"
	<afd@ti.com>, Chris Lapa <chris@lapa.com.au>, Dan Murphy <dmurphy@ti.com>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Sebastian Reichel
	<sebastian.reichel@collabora.com>, <kernel@axis.com>, Henrik Grimler
	<henrik.grimler@axis.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1640;
 i=henrik.grimler@axis.com; h=from:subject:message-id;
 bh=tT+/8ROBD28/OKzxAn3TsOOqh0j20qNp0hZxxxlZL2w=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBqewvflc/37F1DSK7t677yF+YrLMgiXgn+Xe4BD
 mA8BtzIbH6JATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCansL3wAKCRCwB25JC3Fh
 azLsB/936ebWXuw4AZf76DBtKopfz7GbcWvbpEXnRaMTxLubDhn3f/yQhErrX7rnAY5fjenRd7c
 XVO9RG6epsIUvbBfgBBK46Ig2hIxYsbnq2Dwqay2RkEVWIGKzQv7ukK6lD9b17KkHw628mtYO06
 QKWULqdlldPYDLbI0EpPf0p9Yic3284ZUcn5mEo16qUi3HB9WOqd0c9XSYNhIjBhIvCBHOmT+uE
 S+0JQFtZ17REhQ9/KUfWwSblZSoURPlWBw7IlXyNNaRVAzd8syuDmwH5k89SOpVsaG9rNbnI0wC
 TN/5VY2EyseHsJIiKobhLsKSuwTC+Ya9LMok2D20YvwgYSDR
X-Developer-Key: i=henrik.grimler@axis.com; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000092:EE_|PA4PR02MB6589:EE_
X-MS-Office365-Filtering-Correlation-Id: a32a49b8-65b2-46d3-440a-08def79e67e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|82310400026|36860700016|1800799024|376014|13003099007|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	p72LmM1cNUKaAnXuor6tO3Qzc3NR93dHBxsp6hkeoZCHfr+ELffYkXq+47INgpL63n7OMolAIG5O9vfHI+XunjEFInJx2tM6DLA6rJsgqaj7DK+1sGM2cIXSwyPVSS72VjcgBMrDE/CDS11DVrAnMGDUSqlGpJr4E/3ZU5iD98i52CtNVcnPA1BE5u7L96HmnwEdFQnjX6rx+zQgEWLkDXYZmRMbrY4GkjTqAE3OUGHA9eXX1x3ZryhjscgFSKJ4aUBgXmxxJUzM6WmnaBLLrcJGa06gj3yB6Wam0nBbEH5sb9T3j1CQY8vpLT6qfyM4yeEdSyk6Pw8vcAmQqqthkB60m5C4Fwyq2W9CwAQda+ScZam+IeDVo6SOqhvI62z+OilbFJfVWipM9kODXTf4VIwJ+Y9DpInlFUMU8/nDTP69lRLJBfAmyTjYxNp3EYI9seVMshjxV9OmJgstvTb1e7AnTwQ8SAbgu3OY2P3Y9i6ovm085S/rfI0H6lEwdz0I/UnonRARv+cNXj1weFsB18eFZjDT29VIuy1IeJrU8jFihn+Y3g9Z42hzlxF4mpLTAWSq+ni13OTYMw8pi5uM9e3ySnXm6I/WPsSeYIqcxDUvn/h+Fdv+IU0dtK5T50U1Q2wDLmiLhoFLPQxMq7Ea/LMgikIjbtXrHhp05lBuTJw=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(13003099007)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GtPIS9CbLz3PdwgiR5vQRk8kDgGtjaV/PMJgnpzo5cw2JWbZwoHlHfHh7VkYiHH1uFg/Bl4QNOcWd8dXVTnV1e41KV2IUUxxw0lyyKw8hGTLqLmBdYuttbzjZ9GwSAznbZ2MMByWK5y7exWEDcqeBCvpzw5tCtVMEhBuj+WrNiic4hs59mQGh/SghS1QxK0o0c6Y5KLnudmzaYYuoiGjJA8NJlc6Uy5j3OIOH5J0fp5eL4NgzAmy8iP/pdkntP7UjSC1EoObaBfq5XWgQ6lf6LROzz2q0KZf2VCX5Os3dTWuTMGOpCNsAYp403e2BMfHrDIqEQCgTyrLS7mlAROLZCBYOdEm+EJ4AgGpZue9JcsiiqHXPvPdDI2pguxIks5AVrSPZo2GH7iT1ott5MaUsgtmfJ8pxDJj4n55zIfin+ldDFLz+TXMp0Pj0CegZiat
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 11:48:05.2787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a32a49b8-65b2-46d3-440a-08def79e67e5
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000092.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6589

bq27z746 is similar to bq27z561 but with additional protection
functionality. The standard register set is identical, but the
extended registers accessed through AltManufacturerAccess has
differences.

While working with bq27z746 I looked at some of the technical
reference manuals for the other bq27xxx devices, and noticed some
discrepancies with the driver. Fix these issues while we are at it.

For reference the TRMs for the affected bq chips can be found at these
direct links:

- bq27z746:  https://ti.com/lit/ug/sluuca6/sluuca6.pdf
- bq27520g4: https://ti.com/lit/ug/sluua35/sluua35.pdf
- bq28z610:  https://ti.com/lit/ug/sluua65e/sluua65e.pdf
- bq27z561:  https://ti.com/lit/ug/sluubo7/sluubo7.pdf

Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
---
Henrik Grimler (5):
      dt-bindings: power: bq27xxx: document bq27z746
      power: supply: bq27xxx: add support for bq27z746
      power: supply: bq27xxx: bq27520g4: fix REG_TTES address
      power: supply: bq27xxx: bq28z610: fix invalid AverageEnergy address
      power: supply: bq27xxx: bq27z561: fix invalid AverageEnergy address

 Documentation/devicetree/bindings/power/supply/bq27xxx.yaml |  1 +
 drivers/power/supply/bq27xxx_battery.c                      | 12 +++++++++---
 drivers/power/supply/bq27xxx_battery_i2c.c                  |  2 ++
 include/linux/power/bq27xxx_battery.h                       |  1 +
 4 files changed, 13 insertions(+), 3 deletions(-)
---
base-commit: 99b38cda3f4c486cfbc40f3c8ede1703594e9f13
change-id: 20260709-bq27z746-8dc4c2ec0948

Best regards,
-- 
Henrik Grimler <henrik.grimler@axis.com>

