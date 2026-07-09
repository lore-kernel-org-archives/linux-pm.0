Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012049.outbound.protection.outlook.com [52.101.126.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4F638F626;
	Thu,  9 Jul 2026 03:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568100; cv=fail; b=nYwSZc9YfK6RGwl+DG1cjGq2pUUOB7bd5UDARkrOFVLFn5msW4/kLKw+GOsYzRl6eIwFTT0HNDe2oTU8Scy2+lU8YmXMAn6l7KE5Bm5eep/z88Qx09FdfJ+mWqgZJiyJqbHEACg3r7Lk0l8UKdL3J1ZYhUTGZlhbb1CAaEO2s1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568100; c=relaxed/simple;
	bh=AuoL15LvZGiB3YrTm/TOyaNpx8f2CU+B4h55AykQVRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UtGa4Qe1ru6zMEN9QGlBrCvXmyDAouea/CT6WZrfaDA0/ru3IcPht5QhsxNqou219wu4HZ7ew2Fpy40iPgTYDLi95H5NZ+aL4qSXtnqZWFX1Sx2Hq1f7fLCD84iJTghJYyWk2DawOwca3I7P+WHPCLCE5BfGr/zNR/qdtkyY6jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Y+4cwjoc; arc=fail smtp.client-ip=52.101.126.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Y+4cwjoc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MV/4UW/3aB99sMMsgF+2Ps8LNCF0n8p17TqJ1iIUo5iqYM7gAnbdZPBT4j1erTREsHVHYBCvolCis8MVmKPPY2e3IOPYkwionTkGxr/QdcIDt/lZ5EJZx+SiEZvSQit7j43tnb+TmTdKMIBIasxWfhhV9+kNg+Gr4u9Jn8XejeBZqZObh5QNdDDsXWPNniHwUmNg5pth0fBkvQtbRIq+DWbareqZziC57pRQlzr+juyWDCY79icEFJpNyjHsBN8DMusDQr5VcXejJ4fEPiF8klLs3lmb7BKulMnlRjVFw/MNqPYs/K5U3Yy/w2MhP9Bye6CJ7ttn3LWaed3de0Yybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/4aH8mYPg77tUTTVxq/JIS00UcpjNCQMf5ImAWEuv0=;
 b=lQZnJuIq/CNtvM2GWZ1gB0Y8uSHj9HW2RwIxCHsFzkJzSGyeL1ljuPCYx53diiP3iBAhAqq384yV2bnfJGrBl0fjEnzhmosJrjFA9Ylc+tRup/g1HRwTFfehGIM0T4Xi7eK/Xad40gsmKbUbKVZQGZP+LRbrcn7RE5eqmUdt9phiVOhE8kcOSAng7MbRvebzs0J8zNw7MxLDeZCTUaiKi6zACZRUflVwiN6HbTLS/R3hb6eSeEwwV5SarWHl36WsODHd2SEmyTGblhUawixgErcrdDoRqqPgKEbEEUe4jy1gZHF7JMEiHmHr66DgkKaF3ZjuR/0DtF+RQwPkOMDcgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/4aH8mYPg77tUTTVxq/JIS00UcpjNCQMf5ImAWEuv0=;
 b=Y+4cwjoc+z/F92m1NqUv5lm/LrXGLAPoL+PBkRqVB4S1cX3xgxGuTfESVPmD8FPePt2TvPqqmZW6U4yAmPAEW8SrIm0MGEhSwi4TNiMeMdz0oDXiC3d7rdbiiX5WVTOAUE8eX0A2ePSXEk0v2MdEgPW96g2U0cL86ZvR6gpKJGQhGXCyNTmZrdfnUkca/kx0SHCUQnfd5pTuWCLnL5TzgmC1curthyIR1MiUZCbnqduuCIwcyKkvYxNljRazTEtFCv9q0AJkZOqpye6r9bYpxqF52c7J6TU0Gn+HIL0wG4G+IHFmHOXIWLGZDD6hgVtkNWKQ3IsztUU+/XAWV6p+8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB7253.apcprd06.prod.outlook.com (2603:1096:405:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 03:34:53 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:34:53 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 03/43] power: supply: 88pm860x_charger: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:33:42 +0800
Message-Id: <20260709033428.362970-4-panchuang@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TYZPR06MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a245811-6051-41d1-0a38-08dedd6b0a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|52116014|18002099003|22082099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	NpFHFxIKOIUPnddv0JA6UXKFpt0M1rZGSWIX6h9NFqQHtkuVA3MwVBIBMPE0FbgxuNUgrFJo2BBiAsbpi4p6gzna9meMwJGplGqSuENTi4TMqIu42G2GFazWVSIyBQdjPwUYQJm0F0h2z/yxvtXZpjl1gBR51plluJf+ubLyH6Jx1WYhnpcSJWc46y1sZt5wXrhGS3dN4Oxs+6oIi9OwKNX226U7XujUM4i5UWLQU1XD2hqVeY6usURyDIkJIv7YMM5YPQptIXEUM81NbVO2FnA/sbXmp5VV0Kbu1M15GZhyWh/CB+lR+xmhcONyk2kgpFIt7r/2ZWI60MCi3vHYpHQawILVdLlgDPqth1i8eZ/rFqoVgpDSTsnNsxKieJsM/JHSCwbTwKEManl3EYrNWTPrNZ/zGahu4No1X4VM5D2StH8ahj9KbyUB8UdtOkKlV9AY7/4rWvkBHJKewhrpjUpAIG0mHEtV6f76EM23t03yrU+qkp/o0246uoB2qcbGNaWXBY33uO8OvDeW9MScan40aUgF0PrsSr68haLEiJ3szBWgK3B1yLyEZ9re5L5uik0KKJsga/WUXxACrckItP4MMwEoVjAvpu51Ht3eKdoPZrNNRNNtAq9wK0GI6G9d+Rfh3Xq7EO8DChKtds26gT6GxEk+U1NYbxvyqRbYzSi3WKypz4MpM3e064OF7KVtEXbLCWcXBbo8+p2fS8yu2d7PE+4er48EK6WImhnYYoo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(52116014)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vj5cd566RbDeGkUO8vcwokBsKnEAcNHyvImhIt6YmA0rQI+KyHr+P70mF1FM?=
 =?us-ascii?Q?lRxSZP5ves5muc44HQ2pMTZc6z9UzPLgo2AaPFZwUYZ2BXmAEdsADELcpQNX?=
 =?us-ascii?Q?Z1S/sAukQ82SswE3AEooR9zGaMYJkgorOBF2aF+v5JX0hyyaQD4YnBOiuAzr?=
 =?us-ascii?Q?vJBKdltNF/YPZdpC5gt8nVrDyf2blZM2JVNvvCe97XATSzc+GdqPI9ArUwgl?=
 =?us-ascii?Q?WHEKdSBs/2HC7ySO5lo3U+H7bOswAptELH3OEKWc6PK7fywlISNa+CKWH3p/?=
 =?us-ascii?Q?fB27QRu76q5S3xCAym3HrOr/T+HHggqKXhvI3HygB8x60KzTH6NMwN5aYbro?=
 =?us-ascii?Q?s1yG76Tg9Is5/jLI6Nvlo2acuiXGT3Zd/vHqVhWwxfU38wSI6dp9ctAIiHuF?=
 =?us-ascii?Q?QN4Iysk7xQ1N1aTf7Xkx1cT3wN55hnK0XW/Hx0WfTQwQJQQ4umwKp3aNSIxg?=
 =?us-ascii?Q?IsDrjz5a16j0knvt6uPzFwTuDhYjXFXHTcDSj4S6vsV3AFn84NuFZI9fH4F2?=
 =?us-ascii?Q?9NZIs9wtzmhrUvxV7mCSQ+9y0b/9R4VduJ3zajxHWYOg/uX86oDJFFMDKpAQ?=
 =?us-ascii?Q?TVp1FbegQWBsx7E7+YyuZ5FaNHKYwaoKYT4/23yAqBSiBkE0dL3GXfZOJPLC?=
 =?us-ascii?Q?HJhxIgLbIFxAdlyIc+uh9KSY0uezpuWkmHzFoojgL48fd5CoHL6ISodxNFJ1?=
 =?us-ascii?Q?s6Md2MMjBgzSIoSX1zmPzfyiQK4rAIbYRvbXhrp5KWdJFUgMjDpczlR4er+f?=
 =?us-ascii?Q?4xNzBqAtmNoOMULvK2B9fRTu87PFvwPaj7qToE8Gwt5Mn0fm+simaC0QW+3A?=
 =?us-ascii?Q?ilImvhQvUK/VzYtCriBCgksCYcVvMWP+spyWJskO7aWph5p9OQF0ttK+FtkR?=
 =?us-ascii?Q?lBt0Pws9mZV5XDuRufCpkOT1b0J57+JRnmYJA9KUgGSDu8x9zAfLI8wQbUsn?=
 =?us-ascii?Q?7iQoT3MOPRFDnjeNZz437XtJD2iQOR/3SEOToCLhh6H1Q21voMjWwdVEmk8y?=
 =?us-ascii?Q?1Yo1tzUgp0/cMq55IDElIksTcTAqTeESIQH4W6w8b+aTdAD8pSYSwtZBX1vW?=
 =?us-ascii?Q?jkluKwbig316nqtNlY5uZcG7JgYYwTVjTGQ3zlF7nPLKHGVL9S8joIZMdTPD?=
 =?us-ascii?Q?U4UT9hTBi9X0xPHxsgh1A21nsbEf4Ak/lGDF0dZTW0WY0+FK4hEMizb4f5eD?=
 =?us-ascii?Q?OUGJFPj5Em0WYUAiH1/Yg1h0s6BsGvgNE2ff5Or5ECzv3JpbScR5FIuyfHTl?=
 =?us-ascii?Q?xhjnICv6j3Hu5l8PBcXPIcwmKKBfzXoku8MKBJU9tLR3CXIPgrbd7KNZR6Yv?=
 =?us-ascii?Q?UEjnG/nnn6FTAo8/W55oscUKopO8W66GKBm5A9fuTrFSVCIqRpdMjh1Ynclk?=
 =?us-ascii?Q?qNbJPyp+/w29oW3xIeK48zGi/GklOMpiTn7O4f64LuoGyj/NdQSWH4+Oef3Y?=
 =?us-ascii?Q?1eQjcNDrEKlnlNYyK+cGlJIkEm1PolYWLuei66PBCpiMNSgW8bnri/Czdb7O?=
 =?us-ascii?Q?bRBu1s6RPaMJQhLWYHYd7LnbhI4z7Mzlfgv4Bz3qfI/qJrCQUt39cwIh9C80?=
 =?us-ascii?Q?DoJYox7jqYlkRRAbIyQHKw0OmE0HbJwnvprqo0pq0Ons5y2IvlTOj4YP3iCq?=
 =?us-ascii?Q?11Q9dOOmxur+JJU9tqoejhYdTeMk9P0ubgX3PErpvSkgRebK05vdmfoR7klZ?=
 =?us-ascii?Q?sOmOf58Mhni58HUwvtOMjUtt4qWyvacQ8kLfV+R0rWgDNAZu1ucSDwAEXFcr?=
 =?us-ascii?Q?Om3r9fBYjg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a245811-6051-41d1-0a38-08dedd6b0a32
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:34:53.7224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRbLODbXJ5sMyqUEdqfv/2KjHP39iDLFBvBFfXlh9pd73J8v7OFQJXy2AhukPIVPlSvQao1xidqjJ6nGTCkNyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7253

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/88pm860x_charger.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/power/supply/88pm860x_charger.c b/drivers/power/supply/88pm860x_charger.c
index 8d99c6ff72ed..47f95f31e472 100644
--- a/drivers/power/supply/88pm860x_charger.c
+++ b/drivers/power/supply/88pm860x_charger.c
@@ -716,11 +716,8 @@ static int pm860x_charger_probe(struct platform_device *pdev)
 						pm860x_irq_descs[i].handler,
 						IRQF_ONESHOT,
 						pm860x_irq_descs[i].name, info);
-		if (ret < 0) {
-			dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
-				info->irq[i], ret);
+		if (ret < 0)
 			return ret;
-		}
 	}
 	return 0;
 }
-- 
2.34.1

