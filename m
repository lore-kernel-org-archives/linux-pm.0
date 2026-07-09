Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013000.outbound.protection.outlook.com [52.101.127.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7A838F659;
	Thu,  9 Jul 2026 03:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568176; cv=fail; b=AC/4cR+5zyiYpy9KqSP/7JK76aG90s8yPbMYaObJZN6pse7IWT+cVpuK6sl0r82oFyLqxBiXv9zNtX/P3SOUmKZxq6jDmWJd4ejldCo/0XNx12q38W3BNF1YyAfdYxsJBf5UR+M1I1Y0Aw3eJf1MMdgBJKSS1x/2sL7za7S8bCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568176; c=relaxed/simple;
	bh=LZsmykWZ71RGgORlsromTLuk6P+4XmujBVeMyjhwVvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pnF37mcYPKWqrYhPan8SrZ0OQ5UKQRPGD+GbKKbqlAbV1kcyZoonOeFkzuq5AoSk8we+ph9Vj0FaZ7X1IfmwLilkxmwRnVxLWi3Fg9YlJFUYvqsZbQ2tqb+r0bsfGoTtzF38bmzKt2zLD9lki6NcbroCPLJNbvVS/eEbAXgUZE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ZXXQNpDW; arc=fail smtp.client-ip=52.101.127.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ZXXQNpDW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szr1bjpqUt2JacUbQc9pQ7Py7FBWivX7pOy3jBJFNCvWPnWQgYrXRsVDjhBTO8rAhJXjDyUDXZuEMCEgfEVjADLOwH+tMvG0962HZmuXA7SIU1fBpWHsJP3IDn5j3ls7WpXO4n9setN14GVCqtS04vqUeMRLLRb5/EVOgjQfwoq0gRc2ClAr7t0EJHx1cIqFdYqKNJd5AWOOBRcdWD2mTzfohfUexv3JskCfKCNkVpIpZe5cxfeH4H7IxNxmiMDkZjRAH69kYzhJYixa5T4bFSvWIyalC5F+goUvOJKldMORC4IfjjztmH/bKaPmCV3pdJZiBx6/ZpyxxK26dYYz3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7x30D/hPjjhi+LsB9qWNXGI9aaYSPBb/nQbIXqih+fQ=;
 b=skOlT7xSW0kpvb4/4tTt7apOyHmb5IQ6lRNXUqO83CjXo2hJVPUd+KQFT1Q4Nf7TrurapWXn4Wj6m7bpQaxPq/goG/pEIYkSMtCdmqFdiqhZ+todgbIReCy4jYSx4sMLiaYHqYNvPHkMzVy3VYs4IE+CWaeoiJLn4psM3aQL/vnfl/4d/ADZV7NTtcGlBVBk5BPY7cXos9r+20UI72gMrETiYNx9hsZqzfD02yRC5HeY1p1gJO4ZdjSgeJtR4ThuwMQErn15P2xA1GBtXMu5SUun5FjfF1cDzgWt6PBfsUMgsv3r9qZvSs6a3M02r+yn+9foQ/VEJyhnV3zJ0k+pMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7x30D/hPjjhi+LsB9qWNXGI9aaYSPBb/nQbIXqih+fQ=;
 b=ZXXQNpDWRZEPPg9Dl5f/6jRFIpZZWPb+9cJkJAuF4g5cvldqEDiezX+lMYYIS5NBBf/i0/ogiKXrlH+7Co3eC6tMvjsGScjwMMJyP1zRXykN+wXLJArUFPM7NzzrBMF4rsuoTNiQAcMTnqfiHqP7xj3UFOH5jYFgtVdaTZwK92z8oI4tD92fewldyaevWYrOGicVcrcblhrE/JPFGG1gPyOFr1OL0Ey+relssPOo00K5MTOxSvt4h9d+bvJpqKi5ITN+g9ld2FvRLq8H1tZ6GT75fKuO26Hx3bNbQ4uoFe335uidWQQjmE6avHPz2nZaPMbO/7//zM3v6ma8vsmPhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB6213.apcprd06.prod.outlook.com (2603:1096:400:33f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 03:36:05 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:36:05 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 40/43] power: supply: tps65217_charger: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:34:19 +0800
Message-Id: <20260709033428.362970-41-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709033428.362970-1-panchuang@vivo.com>
References: <20260709033428.362970-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0017.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::9)
 To SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TYZPR06MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d82d8e-c55c-4740-67f2-08dedd6b28f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Ed7I1iMto/gWJ20iInmJ1Apk8/5RrOFqqU1tPDCJSVPDuDOfyzJzwn/rjU3i/DaL4IcL7Ybmc+mCJoZ6nuyYj+5e3Df29ML3yjqFZYyQjFTaaku9Bmy9p/HgSxEoDJ6/4W7NrZjEeqPOn8v7wq4uvajJpushn/FC5/4F/dpsYtKk6WbHkqbSgZ8a5QBwsQpjCmeVc7MGSlKCHdBLfZPpkGcvddSf5tu5crS0dWQANsKyYwBHeYz7CCdTBmdnwM25UNx7sF1H5VPVHIk/rx5vGBc1awXZTmxTUOeovEbAafM0T1SHKz26zxNnzf3mhhAmif2EtvGixeDbfm8PqtnqgWNd1UI/bFcJmP4/ORo+u2toIN8nqSAIYmjoDR4hiV8a58pF5cNJ98whv305il1csj+r8yGLWfh3O+4xvrA3yl0CRRyl1kn0N4io4HdkdPkiQDkAo5BK1wgMc7bRq6L5q1o1GZe6MZ6ajilc/C5oLVssQsCyVZzQdui0bNwVl4NtqKN+aOYfnhCJLTI0Cg2g6yUl4Dg5agTbizJXPIJWRhuIS7cRbFhc7NOyntlWk8ICl+2pySA86CxzZftyZPr4NowYMD/r3nYvBGg14m2NX3W4dpNSsvcFjXO8kA6TWWPlPkjBS/DJCICrxMZDLL4+uzk6TRih0iPyqGtayksnGI5we8l9u5pNoAHvzbUg1XcbF/ig9nVN/V4WPwzqSHECcYNbScJ/35cTxaYgKyKgAPk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hPF76XS4bMrwg0Z7hJypEPbEqdfwgM1qg1aYDfbATpnCLTUk6mXKhGXYkSM8?=
 =?us-ascii?Q?A+894fWqS2iBNc5T+GYdiXMhA9MWvOmQoHt9KH+06avVUq5Hjm1ZaWIYx4Od?=
 =?us-ascii?Q?ZJkafDUVFmVeoytAUVUk4QCjuvP3GJvHShoEOatFZVwfYXWYfH/RO3E1U8GV?=
 =?us-ascii?Q?qFJKGrWlcsWXw+UO4cmItD5vALVg8NGyzkt0H/AeF6T/rolkRqrqiAKzmhKc?=
 =?us-ascii?Q?MOeXQcwmgxIc+AkMDhwa+DNaHkbM4qrM3Na9Xm4JHpzG342w+3wekJcj93Ma?=
 =?us-ascii?Q?Hc2NKlSX1lWY1umwnw8xvLNhY138W8+ie4cd79QDTOd/9C6yRu+dxirywpJQ?=
 =?us-ascii?Q?EvDI+7QuoisOx/VE7mUOvNYNZuSWfd2BpOjihSEHSEIQC1BbRkyN7YtU90HC?=
 =?us-ascii?Q?0ZFId/KtS1MGkYXpmw078OwzS8aPwGlSVsINdB2IYN4XDDhF0oKmGfh8uPaV?=
 =?us-ascii?Q?BIgOs2ksh0KJZLarhNKDwhUEekvaYispXtPGKwM3bzLjy5276SY0HH+PRFGz?=
 =?us-ascii?Q?DVSdcLJDynFKM72kpzVgEUCS7LpOdHUvtQGf2lP4P4EGSFDkCzww2FtRq3f8?=
 =?us-ascii?Q?UVUuzTQLplahnD4Z96hzqYA7F6iisqdm0/NBQvPQ/q7Ne927fzqKo8Qjm5r4?=
 =?us-ascii?Q?sWpt+Nue7BpIrMpKuXw4cD65HlMUnz7j4KSRpK9LN8iusJskZXf0eApHpEKw?=
 =?us-ascii?Q?9EL8MXQMguS5rA+Pkg446nTDCtWRFKGbzIV/XGfzQNga5MsWIEIMQ1uP7Sms?=
 =?us-ascii?Q?xm+jDXdJToqngBPcTi8tZhKKozHUHFKmfsnnVQhzTWbQyY8zB6hKkXeEzxbp?=
 =?us-ascii?Q?SuefZIFtHISSpiTMNg4PIoOirRcobZaFWtHlGHWqAXcQduX/LxJ86OLcRSXu?=
 =?us-ascii?Q?g+agr1V34n1Mu/YgEkhpkjb61tIcNXstv3gdrHvstdvBHh7mUce9Ak9nEOa8?=
 =?us-ascii?Q?VHpPaVXrFakx5gbry7VtWPzRDQGzOX64brxm4tHbx5wYmCXGaGAtjoTdyEYC?=
 =?us-ascii?Q?hAsv1oQ4bfoMvd/fUGjfiecHYs9FuMzH22lNTWQ868TFtk1+G+FJcxI4+21D?=
 =?us-ascii?Q?/R9GYfaulSRAHDTLNVApvwCyROns5EfS1MZzxsK4XyiEi8gVLJrl0SP//+5r?=
 =?us-ascii?Q?Q39HxgHkyn4dyyWuLYH1FmGx82LVC6revlPkblKZoAz3BGbv83B8/ShHl/pr?=
 =?us-ascii?Q?IwV+J5F8Dz8K9FtCBc20DxGU7SJkUsp80ahmp2Bc4J4fpsHyXmTDB+2Kpw+w?=
 =?us-ascii?Q?NR23sUxM23jhDeRaE2avYPzeVPZ5aJJMFEHea4NPZEG/cjQgYicMuIdMnjKv?=
 =?us-ascii?Q?jR7eFKmIJnCe7gG8cWX4QSrVWG/HcRzphB7BG23zolNLOk80dIcjIaSH333x?=
 =?us-ascii?Q?PKK59ONeTAkr8UQKYlwG3ULbMnATv35d07BWPj6v8GoP+BkgnGO4IoT5Q0b0?=
 =?us-ascii?Q?UTDWS5AJFXhxAO34Vn1vZmEPly0HiBex44IOqEHZA0MhV6cGDDtkL+S7hJIz?=
 =?us-ascii?Q?d3798DeWKhsgrEOJ8WhmA9DwJy0t2RewVZiqOu4CHsTo7Zrd3Y5gSNCxtieT?=
 =?us-ascii?Q?xTEecHtNl6MH3m5V1VXmlqB1/cqcYrUTWS2lSo7obJszlUcvaTdfKVBS94+t?=
 =?us-ascii?Q?hG8SnnMMQ26wLnf0FySNKtAJcraqxyDzKXlhj9hPDUIXN9QV309xieB4vlwK?=
 =?us-ascii?Q?98I9RBFwzi/qQpyNLDU3086fLv9cQRX4IeRDRH1OzYqkxTbiXSDoG1/mt91U?=
 =?us-ascii?Q?H5VAvGRfeA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d82d8e-c55c-4740-67f2-08dedd6b28f0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:45.3251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68gAIUrnjDDRZL4d8YYsbebtp7wbtXAnD+4Bd5KXRHHPTXL60TYRZpRiGIxRN3MZkgh5seeNzPtUipOtHyO6AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6213

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/tps65217_charger.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index 6af17ce0b204..cd00a3f372b3 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -239,12 +239,8 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 						tps65217_charger_irq,
 						IRQF_SHARED, "tps65217-charger",
 						charger);
-		if (ret) {
-			dev_err(charger->dev,
-				"Unable to register irq %d err %d\n", irq[i],
-				ret);
+		if (ret)
 			return ret;
-		}
 
 		/* Check current state */
 		tps65217_charger_irq(-1, charger);
-- 
2.34.1

