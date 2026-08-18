Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013021.outbound.protection.outlook.com [52.101.83.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097A7449B37;
	Tue, 18 Aug 2026 09:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046525; cv=fail; b=IuxsBv85+5ZsrkhllWh2k+oZ1P1W1uakslhBO89OQp/I8dlxI+VaIptfYyVZ5IeC4LkIk54mZvDBTEB7bnvrDsNOqDMQv38HZcJmKI/uTkInOKide2gQx4vXsgU0OTy5J2OCrH4dfOspl808OQpAwGapOTkWyESjcnMiGfXpEo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046525; c=relaxed/simple;
	bh=UqMKQ3BV6EMmNNOjPQMPKWOZe+Mdu57+WOwJWyft/LU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PJ0pwBU1XGbmKefhtsAB6xOcJflY01LelzN1vBjR8zsD8RujWXGtRCiD1nPFcueCQCimdfJmt7y0xmSI7/og/dbOlM1J1NSq0OwPZoKrrumc1JP8lBo1pV8ScOsJHO6dOXioKZtYpHq2TR8HriYm5OIZUkv5IOHa0fW0KXl6j5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=rGcLS2+V; arc=fail smtp.client-ip=52.101.83.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="rGcLS2+V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lp858DBmn+fnmo5WXVCrdprXJwRpacmp3/yALnarB/kHZrtPjlcDUzb30SBMGB+4LhRFZGO10ILaD/GtUIbbr+ILpZYhzW8K+faDSqleSi4pYuqYShyi8ef8aMpJ2F1wQr0QNIQUnLCTs7Bkz2a5fy/2C9PfYugfi9QbYBR+3BsVfkOe6O3DAnN2F3EJ8b5+NBZvGXDX+8iD8VLuY8AVv5R93n4nk1prpX28xeDssKlRvO82IxdZ6Ain/gDGudEBsrIi3EIp0K0qPWrPBoWn3JeF44H5RsWWPlHXrzBbGISOzPZu+s3lqOlii1HcZK7loh2P9wIMISLXgowzs9qXkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNvXPR+4bFp0/FjdWxCAA+3xsf/zM2/pUdX583lF0Wo=;
 b=Zdd1b7X/XJiqdptvyUMTyhQnDmy22baKEJzzUQtD7978YPpiPbBjfpff+3J1ZfuH8XM7Ap4Mbj42Aj6gMNy/0BaT2BVOMgdUP1ErXjBB4AiesvMXfAaZuuUUed3XC2O6oerprin3pZ5SKXteRywbpbPfviQxFD5DlXcSR3is/af/FCYbEuVhXywGfdR6vZAmzJJ3Nn+gtTHnkDJexptlPF/ZPrB0YVzFgIwDSkjv8ey2TVXfXEX4sl+EOfSIfEju/3tqbgQtqxSkKn1Gzqr2LkSMbepxT9uSQruKtao+sguLdS2+z33C9KkqaC6atsGYfKk2khzUcBNixDBRhXafKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=collabora.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNvXPR+4bFp0/FjdWxCAA+3xsf/zM2/pUdX583lF0Wo=;
 b=rGcLS2+VSTB969aAJiXkRzApSFoSuYkTczmm2teljmwECY4fUnyTS6wa6CGG0usVmVPDmA8/cE2rcO5zFShsp4Au5Jpy1P1a5Tfb9Zu04jP0uyboCzDR031yQeLjWXMRJ0oTeCwbSYRJlqmohNbGq0HT2rQwbggGcAiowQW2ZIA=
Received: from AM7PR03CA0021.eurprd03.prod.outlook.com (2603:10a6:20b:130::31)
 by DB9PR02MB8202.eurprd02.prod.outlook.com (2603:10a6:10:301::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 09:48:37 +0000
Received: from AMS1EPF0000008E.eurprd05.prod.outlook.com
 (2603:10a6:20b:130:cafe::2a) by AM7PR03CA0021.outlook.office365.com
 (2603:10a6:20b:130::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 09:48:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF0000008E.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 09:48:37 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 18 Aug
 2026 11:48:36 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 18 Aug 2026 11:48:36 +0200
Received: from lap5cd525d1j1.sto.se.axis.com (dh-10-133-4-142.sto.se.axis.com [10.133.4.142])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 67FBB27B0;
	Tue, 18 Aug 2026 11:48:36 +0200 (CEST)
Received: by lap5cd525d1j1.sto.se.axis.com (Postfix, from userid 22105)
	id 520E5803B03D; Tue, 18 Aug 2026 11:48:36 +0200 (CEST)
From: Henrik Grimler <henrik.grimler@axis.com>
Date: Tue, 18 Aug 2026 11:48:20 +0200
Subject: [PATCH v2 1/3] dt-bindings: power: bq27xxx: bq27z561: allow
 interrupts property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260818-bq27z746-v2-1-0371e206665f@axis.com>
References: <20260818-bq27z746-v2-0-0371e206665f@axis.com>
In-Reply-To: <20260818-bq27z746-v2-0-0371e206665f@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, "Andrew F. Davis"
	<afd@ti.com>, Chris Lapa <chris@lapa.com.au>, Dan Murphy <dmurphy@ti.com>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Sebastian Reichel
	<sebastian.reichel@collabora.com>, <kernel@axis.com>, Henrik Grimler
	<henrik.grimler@axis.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1016;
 i=henrik.grimler@axis.com; h=from:subject:message-id;
 bh=UqMKQ3BV6EMmNNOjPQMPKWOZe+Mdu57+WOwJWyft/LU=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBqhCpqwZwnx1j5zsMoiTHTZnHdo0KpC9NuCtkUg
 pYmAirboZmJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCaoQqagAKCRCwB25JC3Fh
 a/kGB/9TkD2CUwHhtOqK76inb817vjFl3qmtvbL2Chjyp/J4uADUXA4pHcjywOLwfRvYParC89Z
 KN8uMfIAd00xmwcFeNXT9DeFF7xzGhKTTxWRJpktfClDbxtLRlqXYvHhvExJA/MFgKN/QxCuqLS
 Jpt0eH9wNtALOG/Gj4gMQAD9PeP3wnb1BU6Vpkn8/B4YEspDWUJykJwEsYVI6lXbDVF8l1RDesz
 gMPkqf2MaCXSMbVX6Za2kthNyqzigE1TeJ3F2uBVan4S8pdhcIz8UgpB5JOTpYKrmc5icwLhHhD
 TCMormSszbQqhi+Vo22oPPPZ2pgxY7zyRhFGPGDMeUDWm5jh
X-Developer-Key: i=henrik.grimler@axis.com; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000008E:EE_|DB9PR02MB8202:EE_
X-MS-Office365-Filtering-Correlation-Id: 62dc2571-dc91-44a8-ae7e-08defd0de056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|23010399003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	GqcHpR9o2k+96ZASBaml1cRvw4sr0YEX6GHFN9dzQxUoUUg2YiTIAKMS6kIzEx9K7851pyrShfuYKgc96vDC5sDSC+vIMyOvYvK7fT2ytoXniAxV7zrqgl1kBCp4OkC5mIWSsRZyimIfSGEiu5sZZVGsWvtlFNCfAcuIAgN+Ys0lVhlRQvR0sp6TxTAykTJP4QoWO0kJ8Lp7CGsWMuuAIHOsPtpr1TqTAILkVv0MWv7iG98EH91UNxFsgF2xMOVmZkqNQhW/i4vrtoezSRURYt6jVtrtrNAFlzkAjeJFtvOxbi4m2gZDVfjy0t+avLbHQVBm13JwbVhEaAdnVRURJ7FF1PTgRHHnP8JQWaHrU8aK67iW8KtFM1UeewOg8GEtl13oG1p7K3Ki+oPZZ4hLHu5DCg81yr4kdbjubB6QLwR5pN79Yvlp5bwmcluSQP3qScyVAhz9tw3rkuxsRbqx0+7CC9utR4jcxI6WW6BxaLVWo8CzECXRTQrBb8erlHJ3e8o3bJA7YiDfp5fT/ChrvKVxipN0FkJAOtr40zDAfZno6Tfu7dNOZAJoE/psWNpHfVYghqp5zk8adAnSF9IBhQAF9dsOuQizEQ/7V8H/KY63PAaDtsDnQKyvi4hf6Rm7jWU9QXokgvqYN2VRTDEZQ88In71vqRsGRlo3cUaMjpBvCg7auVC72z/wCisK+mrXmJ0JYY9K3yalbm6m4Yl88A==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xgqzINJag4zL/XuCXYU5Elh5q7w4NuEfi8LrLL+7oc0DE57lhjyNmYJVqoQPzRpJ6Tmi7u+8/FFdzw1jRS4vEVtmG/Gww/WP3UBIgNeOfpif/eyN/ajnrzXLDFfBxbadgz200MS2u4zseLGjxBXl9LnyublSOh6bUdxyJCEnxXSky8Ph6hXPL9LhyzbzOGDM1kMIAONPeVrxyeY1IdUT5bHi9q/WnVa6UgVuL8cpnXFFCptGTQcMvrU8kCoPxw6EA1LkyEJDQcqott82LRvhTOmrYZYEgGc15Lmsy3kOiXK0D7VJazi0c4SK/M+OsOrQfLODq/n6XBR6Wl+5s4ZtlRNv9ac9GFRbjtRelWMC0X0ZomiGU75y8iG2zYrbpfu4qei1uBtuTBwF5Epe4blZH4Lj9JbsKweXmAuP+Kb/j14b3Z1RJDMs8Yg+2Qw3olAH
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 09:48:37.2996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62dc2571-dc91-44a8-ae7e-08defd0de056
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000008E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB8202

According to the technical reference manual for bq27z561 it has
support for an interrupt on an INT pin. Remove it from the list of
devices without interrupt support to better describe the hardware.

Fixes: b4f7a727c29c ("dt-bindings: power: supply: bq27xxx: document optional interrupt")
Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
---
 Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
index bc05400186cf..d985ae632599 100644
--- a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
@@ -91,7 +91,6 @@ allOf:
               - ti,bq27742
               - ti,bq27545
               - ti,bq27411
-              - ti,bq27z561
               - ti,bq28z610
               - ti,bq34z100
               - ti,bq78z100

-- 
2.43.0

