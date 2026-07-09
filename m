Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013000.outbound.protection.outlook.com [52.101.127.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4BE3B3C14;
	Thu,  9 Jul 2026 03:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568175; cv=fail; b=EhrBfRbS5jlpV6yjo3zVBOoGn2Ur7M3gb/oj4mb/AgcaLLpHCWS2qIfpxSons3o10i4Vg/PIuT04J8X6V9ByTifUAUjhtdJI16pI87fnHK0HqPwW9yGV+m8tNHhJNA3LfS0KDWCZTqk/PW9+fh+cKNzq6xrgKvScz3cmQeiUrY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568175; c=relaxed/simple;
	bh=tAjKnEwDkqPtCuQx+pdS4Cc3aOqx+TCqaTJZ9b6qMSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tn69Q2/oQE760FU93N19spN29MNh7/VT3J/S+8sCPozTeFqdMQoNM7/Q9a/DcQJ8r+ehQ3/7MIWGoiCjUmLO0gqslkUB2ycjHyA/4gi2ux6XEwvmwI34BmQS4SgMSsbwifehl3OlFlf+rthCJjtfOf/FarRjWmv8/Abg0zDkweI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Yu7hsLNj; arc=fail smtp.client-ip=52.101.127.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Yu7hsLNj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcVjqs7Qj9+C47SQN/CEew9+7sMjmL4n1RADiefbm63N7MI3zrG2QkAY9T/6VPijX/D4VUXTwAMqzd28G0BQDA5S8Hy2JxEeySjAy5C3EKV9mzHbd7z4GJsrEi6KnA89YHg4pL0jh99zYJaUiytHiVua7LG2sYr1DvQsnxrHPibdKnlOh7nuV0VyHSVWqFEnFX7Kchi7i5Lg6A0qTihVTQOkqgffGTiaxbt2AJi83jdqTid9IVYdcxP0tKSNF970BLCd70FNrsImeQ3bVIDjgjjkQhZ7Q3yNBy0A1nAqWQ2WXZIhegHaYK5m/Q4SwYEjnAe7P6ii9o9/jc9W33Lw9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATKcBHLhA5Y1NN8xYrrWItUsebHdxZW70XCL/lI8I68=;
 b=Prg4nU7TyeR85Gd23noCv+sb6Xu6xjWa0B7DXIJ+6mr7VQ4wXdEzI5g1hOoAogRMbyuXHZHrFFlBXQoVf6b2U+268O0x/n2QqCCXZb5SB5noZCfcw+lQ4rNkCPxGFPu20gufghrZXFHx1IdgBnVnjGVmFrgqv6vAPF3IlZIoFdIbh79/DP+2SFDC//32fCRjxNVxLT7ixH/JTOB2bOomwbQyXYCaiL9s8/yveznngvVHd6+wNkbaDL23k2QWgV/9FmZGkqtwVNO/10xYeoEGQikin+5tzVgMhuQMZgopuSS+A3awb/2WaTqp3dFOgrchmz5c7hs03V3nNhZUQQE+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATKcBHLhA5Y1NN8xYrrWItUsebHdxZW70XCL/lI8I68=;
 b=Yu7hsLNjV7nHXq45P67lF9ijzgXysVxXx13JI0Kqvxx0Hf1PHjA5AEIdgCehfYWnM5LxfG0Tw96ngR6SEPUEQ8oKAcPSDoZs95Zc1BRDDd9gEL5NcdFrZoxbX/K9gGD7b7FYEwAbPDuXncX9u2taINvaLvABnnU1FuiXLWpfltWrjelZi8mQtpE/UblNo5Qvq+XaHaS5yTIFSCReGlbjr3kHQDmUe2VWdyLnS6TCQZ5gtwzeeJGt37KcbRWYBNJbSZtT8Ej1JCEgktj4IvsbDGvZ7Jma2ljD1bvsPcqVOQdpXOyg5IE9u8zjuZ1OGCK251w1Fxk9mRGXALwXNeJtLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB6213.apcprd06.prod.outlook.com (2603:1096:400:33f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 03:36:04 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:36:04 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 38/43] power: supply: surface-rt-ec: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:34:17 +0800
Message-Id: <20260709033428.362970-39-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 33e65409-5f61-4609-646a-08dedd6b272e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	j7kp+xiLlgkOt7BTAtCJCvorvXy7PQT++trLO8AhrzByXFnRGkfAJzgXdx0k4OyBjNtJXZOJmwL1jeqiR2TlM6rVOgW1yUX+QX96zADxbFqGh+CmUnya4C7ovUxQtQ5xt8aqT/Su23yyZF0owC3YcPXw61hywWxHgUOm/U5sICD6PR64Hx7VF19dqwrcE9wJrlKStk0Dasx4ybltJFPUrAiJMfzRDY/1oorhaSe2k2FoqBJmkg9m0U0+oHZhUXnL34kAWC1/f7Aw8BDp3yFQyIyz3VQkafjlzn95dF4y13vyG+DHqb4AlbWRkaonqJew/BbuAAOK4wRFb36EGonLpsbEbJYdWr86ukXh6I10RXlRZa0yCCqMlzfPRcPYwR6X5WkNXkNEk/LG/DdsDKpQvXLkOeWR6czcltRuaIXPHrn9nmIvJp4jeTMrCQ/OA6kebc0OQHPBlidhUSds25Qxn2pkS/SsMGkzScy3/i2GNBJYFV6+PQtngQbPBwrzbGeEmWWi87JD/oWbh44eito2WQp84Fu9B2M594v6ytaxMAfjR5XpxRJwv0/PG7nTZCiy2jAXVh6sMRNbWEDJzR/7HGelCUGslBVG+s1RmViab7WO84xF6Hfps7c74pzuthuSvhVlgnUl2c8W5GJRXFA3cd9+EqaxitU0nJ0BmLYQaDgvgntDqIBSDkVUONxePK8zxR2dC9Sxs491o9XQyO1L0SHJ62mEgXEKle0PSgrGXcQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kIBr+YAy1bwXWWQWeAKRIH3yynr4NhdOqGzXRJTMwnWmJXwa4b3OHnZVhKbK?=
 =?us-ascii?Q?2r2nAS7LXqcffocTDITvbXJeWfAfCe/OfEAtZGJLGPYnmIrrHPksjqrIqgBj?=
 =?us-ascii?Q?laJ7dtn/bsW5XfHIpBe8zj5zlWkSP6ZnZ1KSj0PPc5HmUb0ya5RKA3f0Q2K8?=
 =?us-ascii?Q?UKBXhBDSuqnCMTwzmJ4UwOY3YtWn1D3idI6TQyUxIs/UcVKBhU+9wm7sK9I2?=
 =?us-ascii?Q?NuWaWl13m+YJ3OtFmP4hpZKGbsYk2UvMwftuqpcLZU3tyQy3WfkGnQjf5w2u?=
 =?us-ascii?Q?QupO9lw9fJGoNPqscniqr6Y/uqZjx7f17kd76X+LK3g3uv0z8tXHdPrdznCm?=
 =?us-ascii?Q?9jjEhiRceutV0w3FvtokRxNvL7MkNBLEPM5NaE2ydJwxJWqE0ozsyhkCHnxE?=
 =?us-ascii?Q?ApiMJY2BggRii8fH+0rBfNGktZv2fixr8VWsOifor1osZ1WQ5u7bl74LPcTN?=
 =?us-ascii?Q?9G0G2bK5UQLrnSdDcNcXMOmJ7qFJXMUm9rm5J9jM7d0zyoklON1EuSsp/wh4?=
 =?us-ascii?Q?hOJRaFi6Q9J/qgWR90Y/hHV6jNzO2AvAdD/XFFpBiKOZjEqQNU3NVE+xjfd5?=
 =?us-ascii?Q?jTxc+II3I07G00yjRsSnITQg30Iw+nHiPMimQ41M41JcLrPI3Bwh3Gy0yAjC?=
 =?us-ascii?Q?AQCsdp5HR0vS7BQV8EjbRQQTeMTk4GJ3F8fPxLkn7VCcN3A9XRsLHp1U99FV?=
 =?us-ascii?Q?WtbEydTa7QndRKfXmYRgn8Vd7kPF0oOahrYnnROm2lDxClNdL57ipyjy4GyZ?=
 =?us-ascii?Q?VkQCSmy4zIZizatuQ/n8roJTlsxOvTg0wfzUHZ6M8yv2+wRVs+hNiGY6Qffi?=
 =?us-ascii?Q?3wqg25svzlZV/iSwb9bVVlad/kkiBwlaxIw4Ct/AtHtPkfhMYtw9Ti6tMKPM?=
 =?us-ascii?Q?1y2tYJ5H6iifuyLBj2HhiGl5Mfs47OeJDgb9/dxNWH3MATEbmWYl4HpresV1?=
 =?us-ascii?Q?wFK5AvedrhCObYuWwcI/uMrbc4Vug63ADR3w96ilov+d8ZuwGQDAHtv5Lt0C?=
 =?us-ascii?Q?1/Mf/+7CK7odX9ALmL5Ui2/RBZ+6YsVfCPzofzAKsbExehylUFL185vLCyXO?=
 =?us-ascii?Q?8fA7eaJ1BrgSN4KlwCMdnUjbC9Yu7llgMdHlHB/7WzSaHCZM4WFs90jVI2V0?=
 =?us-ascii?Q?5ZkkNpBDxll2qwNSkf4yXGGtcZCNkuLjEwbn/hQIkXD1MTkfZfkO05LeECGR?=
 =?us-ascii?Q?ZG6O2ePTmlmulqw6Li2KKjuMCbONwi1NKjBcfNamrbUPUYO1WxUI1aDrLi5Y?=
 =?us-ascii?Q?S/3mv6iry5UpBPAIsNtdaYwd60DrZ8CyUgkQbHJgZaFPlJsmDX8pSL8Flmk2?=
 =?us-ascii?Q?zMjSeusUJXcWo035jkVxqyjv0jiZ8LnquvyaV5ALvwZGIOothNH+j0vHuMSo?=
 =?us-ascii?Q?92RM7KfH/m3ciDuFlWReoVZdHyuz8juHGytsAmPt5K5+xhQyikQspH7Hb+Vh?=
 =?us-ascii?Q?Gf3kJcDzmDxh+lzEXH/u2to/GoH/g5vlvMjqomIEQQo0SVGXF54T6o9+tNUG?=
 =?us-ascii?Q?Mi6PhTEd1J6+Lfwv85QNUyJOI6bG2n5yDn8iSYmgNmXDJ74+WMureEnKC9QB?=
 =?us-ascii?Q?HkBTOGocnRkpL0rQIA4u0NH1SrqW9H/j3ctf2/bjNciFmZ4pINrxMHkTt/ov?=
 =?us-ascii?Q?wZxFiFOy/+pIuIAkCGrMSBeSvXiCwWHUgK4vti9fsm1bAOn19YH0fYrV+SSs?=
 =?us-ascii?Q?a+07bzst3kY7MQHNnoNhnqBh4o5Dvv5jp61GEV74A4xcJGVr9QILS6WUon4C?=
 =?us-ascii?Q?AJr6wjWLiw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e65409-5f61-4609-646a-08dedd6b272e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:42.4476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xS67QR7KQW4UorEN1GXxfCY2E6cIiaP6RZJUmYA4c1JR86yhCVLW/viTeH4izm7ZkiDYSXBZgaGBlB7uOJIKOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6213

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/surface-rt-ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/surface-rt-ec.c b/drivers/power/supply/surface-rt-ec.c
index a728ae0db858..da57b0a1a495 100644
--- a/drivers/power/supply/surface-rt-ec.c
+++ b/drivers/power/supply/surface-rt-ec.c
@@ -337,7 +337,7 @@ static int srt_ec_probe(struct i2c_client *client)
 	ret = devm_request_threaded_irq(dev, client->irq, NULL, srt_psy_detect_irq,
 					IRQF_ONESHOT, client->name, srt);
 	if (ret < 0)
-		return dev_err_probe(dev, ret, "failed to request interrupt\n");
+		return ret;
 
 	ret = devm_delayed_work_autocancel(dev, &srt->poll_work, srt_bat_poll_work);
 	if (ret < 0)
-- 
2.34.1

