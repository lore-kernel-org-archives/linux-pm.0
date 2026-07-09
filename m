Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012006.outbound.protection.outlook.com [40.107.75.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF2C39A06A;
	Thu,  9 Jul 2026 03:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568176; cv=fail; b=lPY337knOl1YDYy+faddg+GgAnskOs8vBjc9XHviOJjPKELdHUeMav0Yl5sktpzOPxuqnCK3pnSx6mH5K8n1WtgHInjDlGJ5UmZoRAxkAlz8Jc4OdY+dUN0PN6T1IDc+poGOQk5VM7g6Nm8X7yhi/P+QyuxhWDVBOxVgh47yUUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568176; c=relaxed/simple;
	bh=JLwumIf2k65ytytgWMhfQkkIgfcuqB2lahTT0sjCb+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e0+BlL1cZ2stlapNHGebzsuE0kAQ2p2Ktr7yM3qKU+/GF0QuoGHcAB9dQbj2opgc0Xre1SjZOx64rBaYFKhS5H1t117upikshbtt6xCAyKT/tJh8vRJ1vZJyOTOjo7Q6Ufc0KmDdGScAW2O10SlEhxR/EBHhV/NN4+WedcGdbvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=eaNn7JGD; arc=fail smtp.client-ip=40.107.75.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="eaNn7JGD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/afqClanLp1IqegiwTjOiZSTTOsKb5jWJoNj5LNAIFZdQWKBE/i9ofSnZKaCJ26uraRJwOg8zbSomwlJCSu3WIVzdBxyecwUdpEeLCkourTI6H+X8AUZJvcrw1N8nlO4GJ+0T3P3ImIF7Z2sAMub82YNS0B9B3R2hdyIR5QUx43nLnySl2FZj1UrhU9Wl5+K4cOvYbkqHHix8xQ9xHANuohydwy/qUC1bA7TmRFR+8GAcHUqvMvNSORZvU+IIW8U2CV3NP1uk0nYNq+43K56wC2DriqHh7xLooG1Xilp7OfSJQL7ismILeat/e5MKwxujgMpwjjXUyemczWOXqK3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sn/0MvpwNWTUsPSj19cBU40/MCwbJHL5C4hwdGxVlmM=;
 b=oWEmueV1G0a17h6YE8H/n8qL/5/tgP2xeax0O8XwztNP+Xf5wQqXAAu5iijK/VlKT7mrcS0q4Xi5gYbNrFTUpurqd1lR3Ws6E3DPnTRK2r7nrIjzEQYLzJOlDHRD/eoaZJd+97Fp4FtjPO8HWAlejeawsJS7XaAfKxn7T2PTHoyMz1EQK87xiLgPqZHdquJVDiSgoLRJZFT74R+1UFFJdA+e7C8hA+YW+alp/u/Xcsn7/cKuFhHFlUOt/byjoXC/7cFvx4Kjn5BIyO9A3i40Ix4cQnkLVoXSQxO3MNjXTtypZhnBVFPpHrAH4u7OH5Cq6MmRS8youpK7+4YUwEgOXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sn/0MvpwNWTUsPSj19cBU40/MCwbJHL5C4hwdGxVlmM=;
 b=eaNn7JGD0CKDUEhNHuPXbhwt48/U1YTVJRPkhD0UVRX36QdjlZlpsBt/1H/O9wgP6kHBcuW0S1qZ+Twi6oyssHAgXuzmqxWhnVb7v3pDn5jOMMxmjOqsfi8MFpn/YY8wwIoLy6rYt6vYev2zH0sqvAH8wqEuDY58TF/3tzm9qGE2H6c9uXtiQI+KF2rBAvZS65veyyQaoEPqBBwm/TvPTgfD1DZdHcGPrz1vkMWGuOJi3vMI/JAIz/B+aSo5Hum9iLD/HdvNPUKOqhBiXRA4k6cMbB9tNIn16t9D+0X5A4hHp566OjZDg8Iw+qiKSK5yhjuzoIigNPM8KE2z4GibsQ==
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
Subject: [PATCH 39/43] power: supply: tps65090-charger: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:34:18 +0800
Message-Id: <20260709033428.362970-40-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c26a1c8a-64ab-4e74-684a-08dedd6b280a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+Y4HWI25JlI2RkFJzt72eI5bRZP21DreHsMc5xJw+d5FsL79j4UQJZaWGLysDFu0FXKSjlsoLdscLmE0Rc4N7ukRojBtdPW+Rr5GVxuxMWPzaAn2zHJvrKivVjJwT2a4U/tF+iWvAa8F+l4ZoVeJQPLexWpLfJB16kzY4535OdnXMHDNGvlLVsTzh8P+6xHHDP7PdEopFzjbWh63GQWezB1KBk3JVoMMIj7yIcklNIcfNfgIUxMgK7i8mtsBEsPb0o/lvQYd1CZdOmwz5jf6DWzWxlqPGjCXf2gEWvbJ/0fgcuuMcLZ5IdFg8aCWD7OBfZKit7DLJ4GCGaJBAEFeBiNLSSF9eLSOf2kKWBA9bg0CYkmiGWO2OWU6Dx4eSWe+LncYkdU8Xf4c9F7Pwp1TFxLsxl9bJi+bGAwSwboMVDpzAxfZcoNzVMuIWRTDqpIZwmkP+oY4VEdBq6wdKlrZz7Jw3myd2Z7tEshidGne7oefIldjdUzw+cdl2pKrDOxP859IQFAtosbCmW4q1ByxnRw+hPynRh3k5hegsdckBq2i0TvE0vTOizKprW64+YuY1oBunK5CfYFv/Om08wJ5q5y3TBskeJSN3GbLxE1FkDAg5NQYZzVVgpd+bjzfPhz6QtPd5jo/bMV3YXwLQESOQVmTg8FpCKD7sMBzyayiHQvqmKDmGjHD3CoCjs2e0URGuW3ZwT1wtMABRtcicY98+bYUaP5ULWyNaxxDaIW7GG8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f7cPQIaIEb+xddeoPjXByU7dTIWtRNMstCZy9V7o68PPszJUAHjgAMvXGdvt?=
 =?us-ascii?Q?4kpQ1F9yDM/97RbAn2cvyOmcMnYAZx8lQBEULm8I3L4ByGZjNAp6xMjkNbbj?=
 =?us-ascii?Q?qXJmvdqp46TmZ9RJQzIB0UWYtuRJ6u/rNo0xfJOAMYpcuczHNws+OhcORWE+?=
 =?us-ascii?Q?XhMjDGRt4cTRquxQGhNDzDUb7Q33Wch8bMy2IQIlD9B2elvRZBwXXVOo4bY0?=
 =?us-ascii?Q?rvpX+UEq6o9tXt5rGjCmnpM9hL4q3bhYZ2RDTDbwSk+uJloVrzP/SDcOl+zO?=
 =?us-ascii?Q?sbD6bKRKyL5MFvg5RlCcKCgz25f8JRD3vTSNElFT4LV7GfLfmJ1gsaRdRop9?=
 =?us-ascii?Q?nDj8/X9CkU0lM3tEp55In69w3GfGOn9289q5ZzfofNKdAaSfTVK/L+J+XfJQ?=
 =?us-ascii?Q?eKIIh17CAQYV6+FoZDL1iMsDqtZg77D/I7rgQvdJ+6mJz8Phlx76nk1R05H8?=
 =?us-ascii?Q?LKwgUogMlLIiYKRdOOodyLIfzczLJlyqdyNjNMiOeG4EfHhMCIG2D3iFja40?=
 =?us-ascii?Q?AyUxvw16sT70v0Ruq8V0nsEGs/msQQQjrnq59IYzYSgkiFTF130wUxsIDiLD?=
 =?us-ascii?Q?j2SeoEu0iDwWFERkTMluvf/P0VWI0ZvXkboJ/iTUf9zjUIo1WgMSS7bhUx0/?=
 =?us-ascii?Q?y2vgt1ArthspahyrTWnoolfB+0Khd4DBU/aWaZlEf8i1sk7yfRjeSIpfL7QT?=
 =?us-ascii?Q?pcREBrObFQVAXYlKm3QnrdPKfAw4jtoUhpk0Zz/nOQq4iiejdA4LwRHy+Zdm?=
 =?us-ascii?Q?4GAXyzCq/S0YvnxcM/ynF0B8N8cCtPUpY6aninrTyB3ybLwIr5jxnyLVlwvX?=
 =?us-ascii?Q?8wFW6Qe7Fc7AIh74LLsZtYK9gT0BOHtARFiP2mICW5ZKJoQcgftZgkMZGjuI?=
 =?us-ascii?Q?tNHYf3evQZm5CptM7Zsz169YhUI57trjY6M9c0Q4dU/+m6Y2vlXJR6bkSHxb?=
 =?us-ascii?Q?od612o5N+jzAJ0mJsnwq8HEibNaMPWpriPvvrau/Unxr8yEwgT944kfzM8B6?=
 =?us-ascii?Q?S/eC4G7XgrDZEoXb6rv7S6OQDr0/rRGwaxA6YGu8u3U5yz6qQ9KiuhrVJ4ZD?=
 =?us-ascii?Q?Vwft0WRBfi/6QDKOY6/0inh+32lNMs5HD/SLBZ/a75hubugyTvf/ijxwv/25?=
 =?us-ascii?Q?Do9dOKw2GxD0GZE0M53tk6vIS/icpG1A4gVDAcFwriGfMRsEHb62DFIbz4CI?=
 =?us-ascii?Q?ERLnHR0rov2hy2dxmyP8urzlwQYOkm0ZA36ANvfK4IHsldmmnuKTPt1dLDuZ?=
 =?us-ascii?Q?ugfNU2PsIeFRp8EQkxy4ICKSPWNfjiESykbshpzAIbp3uL81r02CAb1e0Wt6?=
 =?us-ascii?Q?fG4Ob81Cb7RbluUAGiXsWo7ext1OiaqS37F+hpJeMLYN7sw6bTYl4ncTSFWM?=
 =?us-ascii?Q?SPgQPpEIvjlnu6E/3e641SdunQxg4ZxACYXvtP10plpsml6onYGNDASYY6MZ?=
 =?us-ascii?Q?dHxcjF55tmbA9KOP0I9rGs7M3OkxiGqXdOUR1JdFMA+kuL51/tzNYLEag1j+?=
 =?us-ascii?Q?RLPWY1Kwo3cuY4pdmIRsWzZa0ghFFNnfs/NUYe5dKL/3MMP1PFqocLMG85ms?=
 =?us-ascii?Q?EL8b4LK3gk0vKJqVqW8KbUo9sncPBqnK7haCuJUZs3ZhSwhTYPhaghB+IB4b?=
 =?us-ascii?Q?00p+ToPbUMMTPdS5AtXwgfPBqNggpLm7iRiL8sOspzDeY1xNu8bE3JHpScno?=
 =?us-ascii?Q?WB5iUdD10hp+SD29CCYwsqcdh8/8S1cRz3sxiabgaqc9+FHCtFFNscqw0MLq?=
 =?us-ascii?Q?9alUihcnCw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c26a1c8a-64ab-4e74-684a-08dedd6b280a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:43.8502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWUqcMGOpmkGt27BS+bgOzqEJorInaILRSSKS4qws3eBwdXQ95UGM7TNaJNCNuXreieuDy98N0eTOrvFzINSsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6213

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/tps65090-charger.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/power/supply/tps65090-charger.c b/drivers/power/supply/tps65090-charger.c
index d010f013af8c..36340c56d272 100644
--- a/drivers/power/supply/tps65090-charger.c
+++ b/drivers/power/supply/tps65090-charger.c
@@ -302,12 +302,8 @@ static int tps65090_charger_probe(struct platform_device *pdev)
 	if (irq != -ENXIO) {
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 			tps65090_charger_isr, IRQF_ONESHOT, "tps65090-charger", cdata);
-		if (ret) {
-			dev_err(cdata->dev,
-				"Unable to register irq %d err %d\n", irq,
-				ret);
+		if (ret)
 			return ret;
-		}
 	} else {
 		cdata->poll_task = kthread_run(tps65090_charger_poll_task,
 					      cdata, "ktps65090charger");
-- 
2.34.1

