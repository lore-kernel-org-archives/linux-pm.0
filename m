Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012049.outbound.protection.outlook.com [52.101.126.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF853939BD;
	Thu,  9 Jul 2026 03:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568125; cv=fail; b=VPPTkdGowjcOng7yR7iEUkys34G8fWTM+Y09wuunncpNjFGAxbir/UaASUxeCdP6CPjwAb90UOnItC4X2hELTuSdVSHJ6mEHTTHYn1ug841aQnU+yzjLYEBpyuoQLzm4CnoqTNx5Q9HV/pXY3Fc6SERHgM1MPxoHx1P1jNgD1Y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568125; c=relaxed/simple;
	bh=ozCXumohq0yoFt/kLUEaazhf6eEIHunB2rnp0jGpKs4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mGuOLe/6SjTk7Bm57I+wXZY9jFkxm99PSRMlgdd1rku8Qscf/rTYHiSxqoquC6thKGRjhK6FkGWjAAIw0HhszeK7pbaGTKPLGSR3sFdP8MOoSsYnMPlbrcT2Kogk1pWGg6XOwRGUJTzQIsQJcrR6Nl+lCCscJtbOvAyKfe01nss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=RPFSje5k; arc=fail smtp.client-ip=52.101.126.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="RPFSje5k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1s/A2RupNdgQmWPekP00LtOUVlv0zC474exjJhgDZbBH+NuOFxvGXJ8Njc26Sbjtbc7q1TRJVp5w9LBTNZaiDKYfbQIUd6yre0rY1XK1Ai6XsgGSmmFRgiImv33Rxee80l7NF920mF13u4U+/tRloGmxH1Q9PeTe+t+g+seNyMu1XYzxu9pZNDpS8UaUOlc0FSZ2Ysw3FB7UEmDYkjVveV+M+Kdx0+aNQjbfD40fLWajYJ3H4U5MoYE6qlBv/3s9XUH2inS2CKi2tXA9uvb2IlmB6iBrRGiimfNsZXOWqc7w3aofJg6D/RNZQrX4M1HKz20OG4CKaRb3AstGXb7vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeRGFfgcW+49Ks2dtESzDhPmddkrLkwkD0v3e5ys9sk=;
 b=VcopkoMO+fbGe+3O9KypZ2q9433pAyZKVMzqdVFiLRbYCr8zmaUh4aAtIQXfiKjXeqb1obP2dEqUZsxdc8T/BvqDdXzOAicSrA4tGznEfiExh5xXoEceWBX6KcOA+Hs52o4Buwsjoxx4J95C5VzlgEmD6Tm2F+m1lmyloJFZfxqM7q/hdzOAwbsxmeEQxB4DdByGShTGaZYFBEvjhAeHWU/dc/X1/srE0QfYr7qtuRyI8UFb1G7uNoM1ndP8idXpi1/lyOiH02exgOWMTecce1mDBdRRYewRmGIrEWmizFDDqFoTX+RlfNJTX6chV9B9Bw+a5XXhAg3MotAqV1CMFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeRGFfgcW+49Ks2dtESzDhPmddkrLkwkD0v3e5ys9sk=;
 b=RPFSje5k3OMz/wHv5+yl/cRAU89GJbGZtEdBAzRyyvoIHmez3B0cMFRTJBPhnSo44n3nDM8SwRqVvB40wUIVktcVGHQvepf/NU6dgozsBj1Ynj5D0aPXe+kNC5mlcq7ULvEvecCbFI9sXawMg4UydD56S3VeZd6Y03g0YVj+vxdXGbgC/w/fk8j17GbsLtZU4Vj740Dfu8rkt/dJZ44/+Q5LtTlXI96Bex+NKiqT0VR72pdONpVyrCe2H6vOO2ipskdwz4LliipAv8K2yjczaCKypo4Zx2c6ceJ47ePQodMIkIQrQrT5z2m+B+dY7Txc6tsHc+1834yHDCGo5vmNAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB7253.apcprd06.prod.outlook.com (2603:1096:405:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 03:35:06 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:35:06 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 12/43] power: supply: bq24190_charger: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:33:51 +0800
Message-Id: <20260709033428.362970-13-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 40e8e2fa-9abe-4136-879d-08dedd6b1160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|52116014|18002099003|22082099003|38350700014|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	nUA69DkbLaZ+k4vKDwSUaQ3GASfBhw4+Ymn76f8Txig9zUm4sUmvfQo5VfuTUbJZy+TQhR4+OdBX2Uc1Fk5rfc2K7IujZbXX28ZWTsNcYZtcMny9wyLe9zhtBhBn34gh1E9Ik694SRZq1fte5oIljWrHO+lXXdd3Kp63KS9/XbFUtsV1sE5oEMUhDRxz6cvWrqPSU+2NsXcfAO+1qx/M8xDvyGufta80n/c7vdap57OPlau3j2pKO7+bqbDMkc3yzTB9lczzZfj37FmIfrZ3Xr46I3saSCN/3/LvZzWacTHb5qQ6Odqr9JQXcyxwmjzxECLEeqjP0QY1GskXETMI+Ld8pzz9bgC4s5spOd7p5+7BuXc+QLZUUC2eLPhy385TZm1yq/DaOO4c4O9jAm18EMMdVlNLAbOVKSZkHzCQXyd+NFjIwkHexXk5V73/jCV/fWKbUIahCvZN4FYIzpP3CiE5H78xyVX/vswpdhfflgQZThekXf8VQEilK14BuSmqhTFb+8WElHTVPKWqpix6dxrds2bq1sqGx1fjPKTg0ZRmEolaqxo2EDBK6hYXacVTFJibTHcHR8G89jfbayVU3fbrPOCI17J/VG/oC8ABXQ2Pojl6GDAA05lEc+NATdrGZFzEwy2e2Fn+XKJm7sKNqHul5rS+sT/W5q1cOEGqCZaD9s1QjRSfmFrs2k0rhSJPUIdrVKAdFirlOHlCxxbLVDCeZzFwBG7bcUQBwXfJzeI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(52116014)(18002099003)(22082099003)(38350700014)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KwTLupsHHC2FytGAMRBlG2hu1KNlP7U9ZgSfaCJYT+NmF906atAle4AH0R0x?=
 =?us-ascii?Q?NpQHTtOIwCvSugBgbhbA8mm/eFyeKSHwNdcdYertG3U6CJyr/1pu4MRyCIuR?=
 =?us-ascii?Q?SYeO7CCGPOCRGtQS3DWJAkCHskrgiWlihwgiKRTjvvPW6OwUUbdTE0QvYH15?=
 =?us-ascii?Q?ALWprbh1I4kuscXpeYgaokaWphVQCCTgwaiW3mYinZlVkYe3xo8krgEOx7VN?=
 =?us-ascii?Q?KH8NKos6Kv31MZ1Hb4NrgsTRd6MBc/6zt2lZ7YPx9PiwzFRNmsTfvcKWqv1w?=
 =?us-ascii?Q?tR99lNukcbBjGjodaeQsQt+VBaaWevhuFlfZKQjxsU5NUynr0IHv8IXrBhr2?=
 =?us-ascii?Q?ug8JgTeHLZXpX841s7O4GWjOAEz89eQh/ANJT23RCEesz/AZVhLFw9LheQFM?=
 =?us-ascii?Q?rYvGBMERJ8rmqMsYl0hCmlpHmAWUA/Ycnzck9sw3X/rhRSkDztyGs7/3hFc2?=
 =?us-ascii?Q?aLnKvFoYnNzuvZoQo3KYePGHYRFrm5rwgPrJm1HEM2oxATgNDgesl6rnZupY?=
 =?us-ascii?Q?sHd8tZyzqVnrk2Z/lTpVFseOUFJEYjZ9jdiAZoMtrMeUfB3q5onuOxoLmIKU?=
 =?us-ascii?Q?zc0HIzvpCWyIzC7LoFW9zJ5JRq1Gnmjx+0ZRqZrdObjGstRZmfrqE9qdUVPN?=
 =?us-ascii?Q?S54VO0OXvw6RzHwsh39AmW7jpPULjCPlrRBcZeB0MmTa0Fev02XJZhPN1DQG?=
 =?us-ascii?Q?G7+XXefYDnlce9jBrMtCrn4iNqRhL7PtiSkV3ka/kSkf7Kqqe3+MVS7EUo4C?=
 =?us-ascii?Q?wZHP3Btqs7ejXB2W7DurIICv8v1A3ll8P7muEFEXeRyRmu6UVGX+MUlv+SKX?=
 =?us-ascii?Q?ZVjvm3KhP51jWOCb2FANN9F6DkoERO2pfRheTuwWovUHkeWFRoYYo0jViXNV?=
 =?us-ascii?Q?jK1GnihQtroeSGbfucvdqGc9j2CVndRBG/9cywaqUQ+FfRypCPeA/un4leKQ?=
 =?us-ascii?Q?12f5O04L9+D6n0aprU0zOgtqyLtlvxUdFEzKE76Cxm7piZsim28g1fGKbEgW?=
 =?us-ascii?Q?1scRvWyoyXVifNI+FRTJ9WcHUDBXPQza3PCMFPBSZ5SVHwuKFasDDzO0YSTT?=
 =?us-ascii?Q?+My3xmTzuni1YLE3EJlB42IDifuCSqhhSbIFtF4c5vApZcbB9NhQ30SJQ1R6?=
 =?us-ascii?Q?KGTzLEv0ttcfc9W5m1fH4PLBPmo1bmYVT6nnq6GhfSu3x9VCZVJWw4zfGW+y?=
 =?us-ascii?Q?Vt47+Gwe2HppR1W0gzunNj5N861SdoO3Nqb63fJ92KwrV3aKPXi+kT3psYsK?=
 =?us-ascii?Q?aO9F1z8DpkkL948EKcKU39gsd5ZAsw5PWh85Ovz3E3IUBvNyuLdp06YGwSBt?=
 =?us-ascii?Q?XcZDM5XpPpU5gh9XhYl6ljMZuoYrDIclRtfIzmp5gjw7ZdppCOvr4iYPzmTH?=
 =?us-ascii?Q?00T5T/AB8GJbNh43qwEtshaWvCcs4K9iaiUxp381WdsXMJfb58nqOk4Ew8+w?=
 =?us-ascii?Q?G2nPKtGjoCc2HUWktPjiZAHW4phEHePGQNdpoojiWdK2Qvoqw5llIT21aKk4?=
 =?us-ascii?Q?lR9sOlSGXFE/FYzdHYpT9NBYTbjTGYMfBKBbF0G25rfE+eXrLJGcc1fwsHGg?=
 =?us-ascii?Q?ODEgAaxWiQ1CXAspdfpoy/2aO5vlZ98VCo19Tj37Ebft4+0x16o/kOClCo2D?=
 =?us-ascii?Q?fw/C7E+FIPjAmTTaq8zyJ8+QnwngVXXalCjh2DHOtdg0K5fQgz/G+XzkqndF?=
 =?us-ascii?Q?4RQYO0r++X270FeOI3GcpB+G4Gdu3bfI3WwtvAwGL7dzwkmaNZW8aHYm0OKY?=
 =?us-ascii?Q?qWPQ6UM0/Q=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e8e2fa-9abe-4136-879d-08dedd6b1160
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:05.7651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pPPhsTFA2mCapbaD9FSvxCwvkYJX0Chkfbe37LyGUb/Oozr0LhA7Aui0ZvV4XkDVqEljhMpoOVIellJjwTc5oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7253

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/bq24190_charger.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 8e28f86ae09f..cbd29e9b32d2 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -2169,10 +2169,8 @@ static int bq24190_probe(struct i2c_client *client)
 			bq24190_irq_handler_thread,
 			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 			"bq24190-charger", bdi);
-	if (ret < 0) {
-		dev_err(dev, "Can't set up irq handler\n");
+	if (ret < 0)
 		goto out_charger;
-	}
 
 	ret = bq24190_register_vbus_regulator(bdi);
 	if (ret < 0)
-- 
2.34.1

