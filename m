Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012006.outbound.protection.outlook.com [40.107.75.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A363BB118;
	Thu,  9 Jul 2026 03:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568179; cv=fail; b=BOkz0NQh/yy0v14GniTDUja//+AbTKnyDIRzWfSMosSSkiPFuuK5wGy9RrVpH+paA/bgfv+tVFOEymH2QgT8TYc308QhZ+uIuFvG4d/pdNIow14UdPm5NAScXK3roiAqF8GtxDkt+xdH3Mj8l80CpxP7Ytx/AmzPzDd4JfRecuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568179; c=relaxed/simple;
	bh=yVWGbIqp30H0Vxl7+9BP1IhebKD//xD5GagkgFAp/tk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ltxGMb7S+GIOCFin0zqUA/JpRJLSoHbUnJ5QTrKWfLMq8k34lNAcUe68oQQIgb/ZxO13tsxKvlR9SmjbuO1DTkH5m+2f0vdKn0UupoHbfQwXQJQ647gEfvCBasDm5AamRnkmx2sYVp0I4VfbOWHU70jlixtSXkCtfRTe6AoU3Tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=iFVFP2xJ; arc=fail smtp.client-ip=40.107.75.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="iFVFP2xJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovfJkCItvA+4HfWKf5JG9A7nt2jOU7wJ49waBc3cynRe/kdKZ30qOoGoPFNT8OuIQ+bB13h40jDXwIrSFrpLAMZzRHXhiFrakU4rvW/dO5b0zjmK12U/+FDnA7GLCS2jLTxfbhhHJUuI3FhrFcuEM5kLlippAq9D0X8OQNTDK1ZRDFdG+MJILFs65ksfKG5PUp0ThMhBHr2LaWGft4xewyE/r/kyVxUkOMPbzJGT24w2hOqh8cTwm28YLKMF9oSRcgtVcUWVh6cL9KKWJCVAxa1cKvypiIqvR1lUPZy+X3h2wspeIlaEC58WpcgppN+gIRIypnt4PNhO+JPsRC0hLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnK1eNm7yw77Deq4+0uaK+qjX8B6lthLfmeHt1r8RPE=;
 b=mrFVC+uEnQDKtBMjSL7iIv9pdD3ceevbUT6rJHOmCpGU61JBO5SMSsnWhVpHiP63DQnmwO51DeQBmobfJIflwDv3a16xaYXWla1r/kd2GXwwnGexGljXa5htMMzFb2wNe9l745ZRuVj2yeLgMeV64tmfCLgRx3Iggbr4E2Hq6KEt6Z6EXljLs3QX96GR8EaIpN2wLG1cSrWkY6Icg0iRm5QtLoAIZ7ZnBVj6eA6fYoGv8pu4jU1exbdUpBRK88QKZs7tV0+a+B/YO90bLG8DAJqJB0YTntIGIYqJDA44WiLm2HBY2vSksGNUltTAnoCiwo5w8+YA/aIw52s5c6LkIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnK1eNm7yw77Deq4+0uaK+qjX8B6lthLfmeHt1r8RPE=;
 b=iFVFP2xJNSCoMzh9MHDRhKcktpnVV9tX8DJnxj9kIA6c6kMAhPXWa6rxWyR4uxxItnlEiRVIWw6hMeioqu3oOWvPe96LMwhL9YH/Sk2BGatJQS3/vC78uHLYyzB+5PbxF57K7NYfMaDM+vMwkeunrc8L0gADfwqnUFxpfa+L3RFtgPJWzDNYrgBDFVBhQRyV+1m3A5CFN4Kz9PC09OHpFqoWaJn9+Z/Q5YQTJ6apssmyDtRXzTk4lRQDeTt3BavcBlnGRGzs51lYR98iBDluFX/ZoH/Xb5hazL8+u+NJL+ADneFNPelnAg2QA0jTMIlZW89dGvYdzfCaHdAnpJCJZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB6213.apcprd06.prod.outlook.com (2603:1096:400:33f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 03:36:09 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:36:08 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 43/43] power: supply: ucs1002_power: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:34:22 +0800
Message-Id: <20260709033428.362970-44-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: be109048-a89a-43dd-f3fe-08dedd6b2b65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EHSkOFq/GTYurAJZFqJ2bJps6KaFxADqglvBqnUR+nbtgrbKVoyX6FJEnIyHvPOvmgwd+cJqmVTQAxtMVZc77D795zzgTBgJYuOEbl4//YenAulPe/Suu4Y3CtPWS8HTllRppzN9pTEP4/A1vlyczKhfHhsUR8ZydKg3SoC+SBDRKaVxo8h7PSDWG5mcAhRw0YtJZmzE/iajIbqtD2IT9n1+Ly5sKPzXneRtR4APM7ldS+nR68/2cv1xM+Ak1mfzz1aj5lJTZr5XDzi/JsHVmCUzCqLeQOllsTZurWZYiSYIqS8bSKHOochMNlVoAbS/ZL20ApKMPda3SkAHjw4eEvSOZmV/yo+5ASGS58THnUaLTuMKrrGx6u5MoO2dzC7iT7eZIVlguVzYicazCo3xyT0ACsVfAYn9RLLTsgGzfAjDIK8ZgT4Puyoe3U2pprKdyTIIgY6DVySzdFQJESAWa3mz3p6IVu44lh8/pn6Pztfnrz6TfFfUXShS8WS3tyris60/dKGGQ6ZhPX8dKjq2X2G+/C8TSynL4E4SQ6m+nW2LKlEIukTJ9VpkfHzDr7CTPI7SJ4jPPQ0No9dF27pq/6QqretcIpCeK9pJbCmZMVrZmzGY1FZ1oqqVxEOXG0PmEBJkJwoh4eUXhwAonSORShWNfL9Lxcmt342IPJBNeVOxGsuxfVxM+CppJhnThYhgvAo3ewU0zaOpSG5yJEjpbWO/di2uZt9kqyTsoLwtFvA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?awoOj9KRLVPoF+YkTTfjUtAlGLKr2ZJIiGywx5jjbdn9nqNlgwrLMST1kk8f?=
 =?us-ascii?Q?6lt5+20ZcW5uZm8menZNt/lBEeI95F2HyUTvmBGpVYnInHiaRBCCSUEMP5ra?=
 =?us-ascii?Q?FMxiaKRq1kGyCqKDS/hr+++G3BtYsyaaVbP6NHm1mmjaDYOIrT121rF0w3om?=
 =?us-ascii?Q?d7mq6XQ/Cwe262Cy11Ky58friM5QN9MLeivp4VTGBXrLr9HXVFN2J8h9smZr?=
 =?us-ascii?Q?97Nu1AHq8T0uBPcgmm0sUTnxwQJAs0hfN78SR+WgLzy1K0oWft3n5F6RlcEx?=
 =?us-ascii?Q?1th6GZH3nxBPe1eK+/AxA6BoSFxX9VZJ6uPkRrPHHy9T29kb+54+v4UrBR2U?=
 =?us-ascii?Q?DDM0T8jE3NOFrLxvql/bdslIneLtf/B8k6HgmBK1WCiGalnVvZq73YG+9c40?=
 =?us-ascii?Q?CSohXpUwY6QZojui83W/mX8H9hPJP4bPBppvUM8F4NQgv7RfFW9GE9AJIM4W?=
 =?us-ascii?Q?tbonoyEzkeyh/r6yh84BCUFlJ1qy6YdvfUsUbGa0hDhX835m6YmdGJv4QALq?=
 =?us-ascii?Q?gwLFvMDfaMgpfT+ou7sQy7pghhE8rttRBGIHllrerLh7bXqJLaQ0yIS6qlSd?=
 =?us-ascii?Q?Fv+CC9J8PYcif/e5n4swWG/whiZtMFD01l3+z/cndUw+6MBzpumPEa+eFj97?=
 =?us-ascii?Q?sR7TtFbJlAUjKY5FYxNr87rvGcebH0Xlvnmlk8904Kgdycz9U4TAcogT6PtL?=
 =?us-ascii?Q?HCpTJ1hOSeENUrSs2zs5pfjJ0oWp7s2ERjOoLAIj2liRhFaeT27jb/PnFz2/?=
 =?us-ascii?Q?Uj3UZczh8uLkFsxkEyGGxsDw1CyHmFxhhgkMKbzb1+uxQ1Ac+ijwZVvROcQy?=
 =?us-ascii?Q?bTs7Y6igb1gxwjmc8ytQliVHNWFViJoruZwEwQP5+lzHJTnBruMEtGX6BET7?=
 =?us-ascii?Q?VT8IVSd6yDBnXQ5TROA55FP5C2XKpxbsy/7lRC+ZY61fXUtc6CeFErpVZF3/?=
 =?us-ascii?Q?EKGktQ473z6ki7L2v8lziBhfZ6gcHI/LqWXzpnDY9hgOmqs/j6iLqptmfsmR?=
 =?us-ascii?Q?h2U2DUhCP6cFNOqGMxtAsGA3f95UTubPv1pi+OiufJAoDqjOUXe+vnCPzYyT?=
 =?us-ascii?Q?R17/VPN146wr4s+LQO1uDl8gbC+ZGF3HV4YPPNO4ZTBXbtwXkbXB8w173Lo/?=
 =?us-ascii?Q?8bCU1hj29+NI6OJzxYoLU+aXCsqlr5HAvW/PykPIXbeVz/DUVsWAnKoyIoCM?=
 =?us-ascii?Q?OPNPUXZ/JQgUGfxT99zGytA+lldRadIkRZ4PzdqYOPq9d7IkPx0AhL5m26pa?=
 =?us-ascii?Q?YeW8HFJsU6j5Us0Yh1K5bThndK4ms0+2dIbEvhVXoSE+/fygL2uGnCNVmgvl?=
 =?us-ascii?Q?5QnCD+qE5FojVNgx/02k7MdmVfi6OwtwmqVB60b2HkFR0E5yFDurd9m3XO1L?=
 =?us-ascii?Q?WyL+63r0KNiD/uhXI7dQ+5yRfaH7zJ+Sj7YMQqsitPSvg7va3XRKR8mO8Te5?=
 =?us-ascii?Q?Oladj5dBVq1w4qp5pIcvm6x/QA024Y/0E8j6Sym/oXwAD2eLp7TO8nTtYFW/?=
 =?us-ascii?Q?0iIUowdb19EgGGG8x5v1v9/R1A5guMVZJLRtAnaZhyE0AtgHHzrsV7cfcspa?=
 =?us-ascii?Q?2ssOEMxjacbCIojseMfd5hzlhIxNN0Bd/jckwjWZD8YUYeAnaqAp4OuVVigR?=
 =?us-ascii?Q?5P142Ca/hk6RtXbRFIZNU3O60+L0u0ojSkmXz+I+nyIxjVxiCBAwtLCLdS+9?=
 =?us-ascii?Q?X7I20yRdBnysL8FmBAYmYW/ZnDZRPht4TiMEhHN5aYSlGJcr7a95s6bn5TfU?=
 =?us-ascii?Q?IcCaiM0DoA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be109048-a89a-43dd-f3fe-08dedd6b2b65
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:49.4427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMXJbKWl1kO9xGqgCoSFCC2xOOnjUvZG86rilv1ntCLeClkSgGVjq4F+UJ/5pN6ULHEKfqkLegc9+f0CYef+Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6213

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/ucs1002_power.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
index 3f44cc902f84..735880ed1cc8 100644
--- a/drivers/power/supply/ucs1002_power.c
+++ b/drivers/power/supply/ucs1002_power.c
@@ -647,21 +647,15 @@ static int ucs1002_probe(struct i2c_client *client)
 						ucs1002_charger_irq,
 						IRQF_ONESHOT,
 						"ucs1002-a_det", info);
-		if (ret) {
-			dev_err(dev, "Failed to request A_DET threaded irq: %d\n",
-				ret);
+		if (ret)
 			return ret;
-		}
 	}
 
 	if (irq_alert > 0) {
 		ret = devm_request_irq(dev, irq_alert, ucs1002_alert_irq,
 				       0,"ucs1002-alert", info);
-		if (ret) {
-			dev_err(dev, "Failed to request ALERT threaded irq: %d\n",
-				ret);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return 0;
-- 
2.34.1

