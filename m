Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012018.outbound.protection.outlook.com [52.101.66.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ECB3B71CF;
	Tue, 11 Aug 2026 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448891; cv=fail; b=HonkkZcZziGzgFMZkiQQ/rCgrZSRQIyjMf29iyIqTIg0eFm3vXF6oRGRuoxzTm3LSi5DRbMpJUpRaXnjyD0MKz9toRRNqO6vNeZuC8M0e18RV9DkCmoVONMRb2a3J+jAZsPAzHbFidx4vLdT1jeFCwvPYmtCKs996Un4Iq4Qmfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448891; c=relaxed/simple;
	bh=pxCaIblG7YQ8IkwwNcu8Cur7PHHhI7jkU4NbPm3OcuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FyKLKqCi1nI/LcOwuVaaUt7TJckbIFoakz69FI4YCy6Mj1gI9YgTm9cdWLOCixqaizaEaNuB2A2ukXMlZ8WoV/ihJ5tryccT+/F2BGEzF3K2CRl0ytbHp16wXM2mW8bONd1822DfbcdM2wqzbevZH7MnV2HFNdNJRsnrHdJsQ9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Sc8qw10Q; arc=fail smtp.client-ip=52.101.66.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Sc8qw10Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Od+Gj/BezA5E7pBsZcBhn23gwW7WHvAVdeYziU5h9BhTv5OrHtWE5aW7jOh5hBuhGPdJqyhUH4MuMejj1O5IWy2DKDIOEsS0VvvPXjrj9XsRqZ++aDh1ALtBhx5ShJlZZPMo7cYEE0eWWxtK9W+J62pTf6d4/5+PjXKc2er2h+toh/UaFbd7WcEv14mpvpLHxSH98HfChoTbuLKQ/5DN27uHuy3mMwM+zdkJz91C7DNi/ICcik+wvNxNDkT+SRNcf/Qt6eoNjAtlFareRpjs9v4R//d8lSzmweLgkcFI9UQRfDLZ26Ueefs+tktTZkNRgaRWtAzM6SEyY+qIXenTzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90Et49rDe5ZsMO5XDUUWSoPxqD0r31uSQ4wyV6mwd9M=;
 b=SYsZ4i05cPIYYzqD9uPtkBL3S2eQW9dDqxbHIs2hN9b7Dzgfu12NUn9NLlg+PH5mflbcSdg+LD91ZMGak2dtaEKVVTa5/P8wW3L44uM8bEXsUox0Qcqq3247dbf1KAozk+uUm0horNvdUUcdvW9UrrF53trUfr9BnopIjiO3lAzwBUnMj9Q7vzW3iMpbCyo1CBBoc0pk+gBcJfk9aULPexJaB60l7tzYJ6kT5TaQKYv6xiNCrEVtXoltL0sPeYhUs+A/TsRN0tbKuEAA3AXxQvyE4MzUoPb6kczfpjrYZhCPglU4xYeX+FteOKsjEjxsrolT89PMpzOltNMe9DRgrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=collabora.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90Et49rDe5ZsMO5XDUUWSoPxqD0r31uSQ4wyV6mwd9M=;
 b=Sc8qw10QE51Khw07xT5yTB1kEEWjY1XovcubnQ8/t+/rsUCTwwnf9ZkTqUAm2W3HN2AiDEh7HbE3c0xjvahKf20TMRSWA4eor3qRm7t3tr2uJX5OF18S5LoxbE1D2fjJKZV7P5CnVG2ifZIA5yM8JPRDz87Ud5YgqYbIXi5wMEk=
Received: from AM0P190CA0029.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::39)
 by PAVPR02MB9306.eurprd02.prod.outlook.com (2603:10a6:102:30d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Tue, 11 Aug
 2026 11:48:04 +0000
Received: from AMS1EPF00000092.eurprd05.prod.outlook.com
 (2603:10a6:208:190:cafe::9c) by AM0P190CA0029.outlook.office365.com
 (2603:10a6:208:190::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Tue,
 11 Aug 2026 11:48:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF00000092.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 11:48:04 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 11 Aug
 2026 13:48:03 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 11 Aug 2026 13:48:03 +0200
Received: from lap5cd525d1j1.sto.se.axis.com (dh-10-133-4-142.sto.se.axis.com [10.133.4.142])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 5F91C1F9B;
	Tue, 11 Aug 2026 13:48:03 +0200 (CEST)
Received: by lap5cd525d1j1.sto.se.axis.com (Postfix, from userid 22105)
	id 4A9B6803BA1C; Tue, 11 Aug 2026 13:48:03 +0200 (CEST)
From: Henrik Grimler <henrik.grimler@axis.com>
Date: Tue, 11 Aug 2026 13:47:43 +0200
Subject: [PATCH 1/5] dt-bindings: power: bq27xxx: document bq27z746
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260811-bq27z746-v1-1-3a4fa38205cc@axis.com>
References: <20260811-bq27z746-v1-0-3a4fa38205cc@axis.com>
In-Reply-To: <20260811-bq27z746-v1-0-3a4fa38205cc@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, "Andrew F. Davis"
	<afd@ti.com>, Chris Lapa <chris@lapa.com.au>, Dan Murphy <dmurphy@ti.com>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Sebastian Reichel
	<sebastian.reichel@collabora.com>, <kernel@axis.com>, Henrik Grimler
	<henrik.grimler@axis.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=819;
 i=henrik.grimler@axis.com; h=from:subject:message-id;
 bh=pxCaIblG7YQ8IkwwNcu8Cur7PHHhI7jkU4NbPm3OcuA=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBqewvj2yDSbUyF4CNsXHqet3yKHgk7CPN9uPXTc
 6zF9juK8XmJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCansL4wAKCRCwB25JC3Fh
 a/fZB/97FSSlJ0AoDxnrzqjISNRP1gc8WdSUxPauzvWTak0CDZ6LmacjKut3Tve8/yL0jXZR0ID
 yW8uhX1YvkIZ6aapTnGesYodoyyqfNlFDYrw7c1edg/Ohb9GbQTO26yiJfFddghV8eKEtxysnTS
 PEZQGYIGS2ly7YvxiE+55F8zd80Z2XrQGyZ/t0i1O1op8Gxu27gRFQnbEIiYRl3XKLrb/LvDNC5
 ETCFz1lFhkEsXyuk8tFF0YFVdJlJOBCT38vMZO5DcG3WiLJEdlIx1oSv6e4YR8Fd8PTVeC4tWII
 dZnc0RxKmRILD7ck+m+R+JFQ0sb2YxyMPzmU5fq8kKmjJf5b
X-Developer-Key: i=henrik.grimler@axis.com; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000092:EE_|PAVPR02MB9306:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b35051-8b4d-4559-cd5d-08def79e6768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|36860700016|82310400026|10067099003|11063799006|22082099003|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	D5Aui6l4kGgeSDC4cgBjgHA0dpVLEmxQREAvfcsXnhjp33fmpBMGdxmgXfWJWn1PnFcKLaXipPFZxsZg9wgqqDpVLxQk2suRiJ0bMVLEW8P1pf2Qcujn+QeHlpI5RLGswBcsd/A9Ba7KXxxG7A66WP65Xsj8f+ITqDBU3f1Cruy8yDUh3wRgalu4REB7I9f4aOOkBW+7b/hlAKLwbRD9W1RqY0jQ+h2HkktpA88+WFeTwI045iCMq0XELwMnlw2oQFoum4XGxlLltZdVUKZGELL9Gc6Cgl5TmriqIIEzQOYbbZAhjABEUAAR3Ounm4kDOdgtS0k2z1lR4NxhdW+0u0HaH1BvYnse46rdXiA2V7/YwAqP0nAf4hf27hzqBru4iaZK7IIHwvH4pWOp6gtEPDNLr5AFQmzs9ZErE8YwxbLvxXUG0EWicPTwpUZJmzKzBPMDg8AIRaHG3iIOplm+Xr9cvhPee5cc2e1Dd8FCAOjUTlfoM2f8IT+S8Qh16w3X8FBrikBPKS3e46bxBGnQrVXX1IjN3biDtShJzxTaaSFn58QjB+XdrRyc7aBjsHeyQJpfjsw0bBIuRdkPTZUyvAoSqhZw18wdZJpIa+a2NufHuS0z24gHLpMiAQdkJuK/iKNRl+5T56N4Cfp3X6z1YgMXZXoZdP/K/NoC1Hed0SY2qiqm0lGNmlRFGwiIq+LsV6mT63rzoAxiT9aNVQTrHA==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(22082099003)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SWD/9UUJxU9FDfL/ccH6ZuPYdk4Zi1RLYKSRUEO4I1NU5TsV4AS2Uxo9YQ+xbAxsf5Mdlrdg7b+YXTr6lC509YHd0jzbES0QqnB5l0nrkmVv9HV1MANh3pdsOjUs7DUXbyFk7UQULKjcItHcEUQzRWUItqAKaONuQxDUee6CqjHwBqHLPTR4jzFrf11F7dIJctBmvCFrcjR+fmQYsoNKb2KsY4SLQfqwISRzOnmsHLN/fBjuDXq9iJ+D+IY4IwB2xB5DjsI42sldUIOQQK/WQE7gN1H8aowy9MheuhoA8qTRSz0Yi9IxEJ/lg1N0wx28f9PGm4IMTOE9VrlZYJg1M8q1wHybLaewlnilVPPIxY72lfDYdEfNg7qVlSH4JQvAOGXOIQGXU1NhGxJmDqh7zpAoeUKSQp54JTzCB4bsBM77L8OJktKLA9QhZfZ9QmRf
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 11:48:04.4632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b35051-8b4d-4559-cd5d-08def79e6768
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000092.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9306

Add compatible for Texas Instruments bq27z746 fuel gauge, which is
similar to its sibling bqz27561, but with more protection
functionality.

Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
---
 Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
index bc05400186cf..4e09e1df0914 100644
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

