Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012058.outbound.protection.outlook.com [52.101.66.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D91449B12;
	Tue, 18 Aug 2026 09:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046525; cv=fail; b=BK54v55DXEEdAnVAqM4AUP3Rh4sSqQ5wvbzAcSGScYznQ9lLIcAi/+XvgeuNnyIQNj8IBhETZVUkGbMPuZuDAkRHiQuL5LZ5+UVgFUGmHUoTIR8FLryjm0Ucgg2p2SYTgXGHYiy5RvAQN8lDsjG75y+MHL6inT5qaUUztzVgwpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046525; c=relaxed/simple;
	bh=+p93k4TIEeTcxm+NXcVowG/Q9cie2nYvBZvRDJAv9aM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ecmZ6hQk7iVs1SUmsYGtVvqDZ1HUbfftmF9r8Fwt1B2OAbbIAytmrAb86EV0sk/YLskpKSI/c37F8GvePN+ojqCCIeVX05OOc7KjJGKf3SJ8KecNoKwZ1egLUC/VR2r9gEw2d79cTL3v3jSHmfUu7kq/O5jHp2OWh3ZYqksKVQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=ZoyIleTE; arc=fail smtp.client-ip=52.101.66.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="ZoyIleTE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrQuOfjYcOBQRFYV8j715f8iJ02EV+nE8JehHTPXfr2KCZA34AZQlNdo8IwXMiYQXLNJ4i3v1TgNEjQpxFvvtPBbU6alceW+/reTz5tbRxpnL7s5sqnDe5inaWnfOLesmvLHlz1Kk+el9AhF8QVBgIjRVigzqAd19mJkIf5TPakLgu8YRKDSO5ej9YjIbLVnmmZzvbnRVbgv2SpI2tgQxXGcFeOCfhEgg7udV3peV2AqKC0p6FVBb9QgiWD9+kZhPiGFXsdzCEizb7Yj/VjB8dcAvbmI65cEzMX9KULriFcd81VgBms293UdXkOnQzk/10wO7Pd9IChgwcPajtUQ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nn7YukaMUjpJgyCfAdYfYb+UpVhH2z1pATsUHZoyhLI=;
 b=TX5RcH0VgKqckX4AMccoRjIHZlaaaedM3kUKByiAKv/Be4gUb6e7w87LVt2QVy18UVYlaaUHmvrpbgph9qCdTSPFey+51nxwztgubCOXwemRrzrBY8KFvB1Kjyz3O8Vo0BO+T6Ck582uzWpa2QSpxDq9dP63FyzrZ+DMOi3u9SxGPIsJh6YjmkEWLFIjD4KelEYVA3hk9WHYtQmbvpArdaHOXW/uylK/8rpS06ipEJGs5DyPgpd/e1rWPOGsm2XMGWsc2vUzb46hQOpU0lBfAMktA1HMwv7OkTu2Oh1M7MMI6A6h+U+dKnKPN2Ofv6OmfLgJMbnwf0eUB4YHlCFY9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=collabora.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nn7YukaMUjpJgyCfAdYfYb+UpVhH2z1pATsUHZoyhLI=;
 b=ZoyIleTEg1JA3x3ktkd8zNFBsduwW5ujINtzm8BmDIjIWerj4iQrgKV+xzntrWDgVPNY8AaXLDIpyxlgaWvD237QfJeWsUqe6srWTf8djDXSfv9Q72ZaaVOvgk0ppZ/ouWV2SMF0S1RaCPISlyV3QnyhJFmfFM3sWI8rahhvWQM=
Received: from AM7PR03CA0005.eurprd03.prod.outlook.com (2603:10a6:20b:130::15)
 by AS8PR02MB8294.eurprd02.prod.outlook.com (2603:10a6:20b:520::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 09:48:38 +0000
Received: from AMS1EPF0000008E.eurprd05.prod.outlook.com
 (2603:10a6:20b:130:cafe::96) by AM7PR03CA0005.outlook.office365.com
 (2603:10a6:20b:130::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 09:48:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF0000008E.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 09:48:38 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Tue, 18 Aug
 2026 11:48:36 +0200
Received: from se-mail10w.axis.com (10.20.40.10) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Tue, 18 Aug
 2026 11:48:36 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 18 Aug 2026 11:48:36 +0200
Received: from lap5cd525d1j1.sto.se.axis.com (dh-10-133-4-142.sto.se.axis.com [10.133.4.142])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 40A162ED0;
	Tue, 18 Aug 2026 11:48:36 +0200 (CEST)
Received: by lap5cd525d1j1.sto.se.axis.com (Postfix, from userid 22105)
	id 53A3A803B10C; Tue, 18 Aug 2026 11:48:36 +0200 (CEST)
From: Henrik Grimler <henrik.grimler@axis.com>
Date: Tue, 18 Aug 2026 11:48:21 +0200
Subject: [PATCH v2 2/3] dt-bindings: power: bq27xxx: document bq27z746
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260818-bq27z746-v2-2-0371e206665f@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135;
 i=henrik.grimler@axis.com; h=from:subject:message-id;
 bh=+p93k4TIEeTcxm+NXcVowG/Q9cie2nYvBZvRDJAv9aM=;
 b=owGbwMvMwMW4gT3Pk7swMZvxtFoSQ1aLVq5H0pxAd31ub6l3x4R2fzVR7Hvy0L8z2q6h+IhQ9
 d81LXM6GY1ZGBi5GGTFFFl06jXXTe+UT5Fc+egszCBWJpApDFycAjARnuPs/3PMnSt0nKPU9e6v
 vW/ME8Zlea15Ftvz4y6pKntcde52KUY0f85liTr6fmmzWx/n/CkcN58n2583+hQQ99nuwls/jQT
 pmkWRhQ9rWG9c327Cf+84G5OH4NK7L5xuPipZtYjz4vvElebNf3o05POz7hotflAafsc13oZDd/
 LsHvU9dokH1qY+D130JN75usb1vyw9lSfL/l1Yxpe4epPnwVI2pnOetwoPZez5F2n7/ssVz0Oef
 1J3ShdvlWGI8ZKxva+YWO1+bU6YVdUFeZmXsl7Nepuef9x6xEvz9FvbU0YylscVba22G1gKno/4
 sYTxo9n3KYm9MnsdbFRjbJXXXWVr7vg/sbgzc7KfxawpAA==
X-Developer-Key: i=henrik.grimler@axis.com; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000008E:EE_|AS8PR02MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e3f353b-d1a2-43a6-717b-08defd0de0c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|23010399003|36860700016|1800799024|3023799007|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	t++wonHNvOTYRJ/DKaIXwi1G57mGqb/IOMpDVhtli2iMCXAZG4Wv+oaaEOadbpWP7ZhyCq6T8ScdzUs0XXFB8S3IaugPUdYUI620H1Bv0zodqi+p74Q5osCnUwZrjKX2CGykU/AbXFqTR4WbpU3AHlxbkH4uIS39pXIOSjmGOMnH4AVjWmPsCqlldPlnqySB3C62IdBsDsAIiPSuE2OltgbWeDty1DfHuU7Ko2olqf2uRVcO0cFWG5q7lvzPrzSlCNY7RArFmIlkboxbUQJc1SCOs/qB4rETyK5z280t4HQRswGYxoXelunLWGcINHbuhkeyv/bSpThTXq9Jh57zL2cG+BOatqU63Kq/vXRYLllhFKf0+qcSOHsHf1j3ROvps1gYvyjgInqXZNkXBqvExknA6XrniTaMPjYb616N6+XDmsxfHXrgrb/x2UZbi9aZ+sHpiP7jjnGPpKQoL2hNxY92sc+OQOizAxPmRJgXNj8wi152R2zmoLc15UJhzhtOzPVEQOPCqDIj/w8nhtmR+OqSzQzTYkKt74CCMj9bQ90kTGtt61WSFLJXl6eQM8jtS8+JZnmAQshaU5EnPMceNMakMnkU8dkeufZSIhgsVPJsT5BbYrzqQyBwRd5HBwWuDTAa3N1XODEjxWK4hmFCukr5TB+L/MhkcWiuQAXOZTirYLb6nj5FGzSppZ0V5oduPk5aUzuUVtaR7Kv1946OBA==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(23010399003)(36860700016)(1800799024)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mPielbQze5EFMYen/4AdOhVf7LsQix57QpdIN02R7JJW2cWXuikwWGzmrOu/3MFMXPE948KuBIyPbXPPJmKxfPnk9xKUdmo16YGt93hyyNLJItzqz02tCvglRQoRXiwAj953JFw7cGWotvl+pHjXqIjeW2kgUom4CSjO50fjl5acOu3Sz9zYjKST7aq2MxRmTdRxVT4QDSxyq6JqwdSC7+VCZv+m+OaTK88hB5Lg5g8R5sMHFtg9RcJ2wMWyH9uWDysmkkidI4AIgaXuHKsgOSa/vM1e3uSJSFrdTgc+VNFBCK1NG//sB34CrIntYnitTNXnCmvsGmOBGPAFbxdFdL0clvCklyfnmvXIvkHdqR+UTY2A4XAFh7KwTYjPB3829VrT1DhmOmOsRlLTIuNcTtgy/YasmaC9QQk2duFqbwoLznp0dK7eNlA0YvaW/Kzq
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 09:48:38.0204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3f353b-d1a2-43a6-717b-08defd0de0c5
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000008E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB8294

Add compatible for Texas Instruments bq27z746 fuel gauge, which is
similar to its sibling bq27z561. Unlike bq27z561, bq27z746 includes
some protection logic and can drive external MOSFETs. The register map
is a subset of the one found in bq27z561, with bq27z561 having six
extra registers at the end at 0x70 - 0x7A.

Among the ManufacturerAccess registers there are some more differences
mainly related to MOSFET control and deep sleep/shipping mode.

Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
---
 Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
index d985ae632599..79d1a3c8c685 100644
--- a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
@@ -47,6 +47,7 @@ properties:
       - ti,bq27441
       - ti,bq27621
       - ti,bq27z561
+      - ti,bq27z746
       - ti,bq28z610
       - ti,bq34z100
       - ti,bq78z100

-- 
2.43.0

