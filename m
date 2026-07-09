Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012049.outbound.protection.outlook.com [52.101.126.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06EB39657D;
	Thu,  9 Jul 2026 03:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568133; cv=fail; b=alm1F0GJ8RCStPDIbbOR/54l+HEpU7789+s9w8E/2fj3u2SjxRO+wC3s0XRyblITYPn9+sRwrY1COy42FqjanRNXgaxifBAEuLXVdqXs8cFKv2O7zK8Ze4SpdGO1wBaABqnTJzyOoDkJSzAtlIFQ8mtjUrJ55NXy2imHHClhsJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568133; c=relaxed/simple;
	bh=LiHIKse95i5NKd+ZPl31x3ncyoUiDTxvkU9ljnccSKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r9pDVoWVOsjv3cqz0Rb8VhtonajfGLWvMdtb8I+KXefdtOf9ZQLNqcA6LE55o35Q9kRGjAWqJAJRf8/tnP1/yxtG3J7eRJmX8jt1EoAkZHBxjz8Zr7VnUJPiVB6K5ngZBPnEF1SLOOoJQ3dO8YTj6vRHFUNfE3VbFxuOSBnsUpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=aaYC8Fv4; arc=fail smtp.client-ip=52.101.126.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="aaYC8Fv4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdVob/qRyAPcaqlEEp/UI9XRl/m8Wiqb0vIuBZGkeA6u+I3h+Jtr0zdXLdJV/VjvXBszKBgnDfWIZpXkbBdvk3hx24GsdMBL3Z5w0l+E0AXW/ofo5JRju/u66P7Lfz2svvLSyvtIONpnJ7y4byiOAnQevL5amD+s38dhLLm8x3LF8AVFX6u6OTXxD0Qx2FOYkDACQWTGIMnuWlZUH6HRZObZygF6uLCovw1MQYs0uypv2GtLXLKB6jQOGsexp4Vg2ikPzKBOBE/TwbrexCl9hyfNaTjBHNvplJYQHZ8syKtVrVIKMF48FJCnHSFuQy/NsCc6NGyOidlQy8251fHF7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWsj16kUI8kiDoFbUp3ozT/0TZ8UPOvrzzJr94SSCt4=;
 b=XXdqX07M5iqolRVdM/ryxKekAVfMjHQlxmqz2SeCH8dxZdlOYdUdSY7HsS7EZnURlW0X5m6j89a1QckLUu+OQeFyCU51yV1rmymi7Frd7jubNdqt2dGc6BkX7uUo7HQUCcfKJOkZKlDfuKGgnLjbSmvwYoQmljdYWiCX59MZWmcGu4dq0an3XcKZQsrwpivhqPg1T83tQ+HJggrdZ8Gn2ON10Gfc8d3CB7LZiLOKLYDr6NQsNjaXPvLp2FrddxK1gWbTmeTXzAq6+dm8B3NZbMkmovnhPhrckzgHO90BVi+cCgcQZsrlE1SlYNobcPRJdJUwcnx/IhkCwRuN9fuQnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWsj16kUI8kiDoFbUp3ozT/0TZ8UPOvrzzJr94SSCt4=;
 b=aaYC8Fv4VheuvNiQvaTHCa13IOKtmHzb/G1pULEElZV+oVpASwJ09nPImXSwVgumgKTD6qmZRhJXqOppCcMuwd2lMdoAFnXUnKssoDwc9anGnvCPGT0jhLn3OUYJYjppB3jCF4+v2ATMUQSfn0DBl9vK5d0+IRti9myySL75k7072vPy9CgWAARgo6Rqm/L1v0I4aqB3Ii8RW4mCtHzqEkPg333hbYqYhOb1PrAEUV/O9h6lLMLmetHlO3Hj1XHSBiOJaPPyjm+b7P3yOFAuj641iHCHgDtc4AMSmkzCU4M9T50ntatk5nUA8R0IOj0s6Vm4CC5ZsRWC0aS4He5/Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB7253.apcprd06.prod.outlook.com (2603:1096:405:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 03:35:18 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:35:18 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 21/43] power: supply: max14656_charger_detector: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:34:00 +0800
Message-Id: <20260709033428.362970-22-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: f2f73296-293f-4c11-7fb1-08dedd6b18a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|52116014|18002099003|22082099003|38350700014|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	CVcsweANhdrWesslnKZ+u3Q1lmjtILLI/G4pKd7QIF65hQyKr1rH9YnE7HjkyqM7C+D1KPRMFX03HjfKmSQoNux5oeX0x2HWyievyZtyY1hXl4BrU33YcRemFS+ndJRoFBt+HiFfYmZD2QnX4djzwWizweV+S7EqYPoKeupcYzX5uHkUGSMLtZHxaLAQv8R23Vbq8RKWlj2zT3zC4L8CZZOjWyDUSBTK6MdKi9q4ug77bFIGseJv+yY4lek2rjAa9jsxOuzblmXp8dOz1yT8fGkcgfK0xwOSNKb8OTsWRKezFRskzmYE9NGht7y0M30PiYkYlWYbEWNS2TEIrfpE34jQVADkLfhdEGaIV/bgd2d+0TATYD6uVVdWUkRsTkUrHOLBh0dyocVmlH3nGi5Yfa8SFNmpNMA7bfYK43sYHCdeR3rVzfrhsHqc7I8QNa82okxuQxCLAzlVoT1ITD4mOXKjXWL8C9YcmcSDTAsTTxeQGtugdU7yHQNx6YkD55uwlJQgoCifgtnVeBBGzVWeC1L5zBF2R3fljrLrrH/CwGjIw+e7Ra9eUSNUPUOLXcm70BaE0SwSdFhD5D3VM7RZaiKNX8IOtxf6POOqOFEjMOuOSXIM2ASjVHE5klZAi0I+UzuSPLFdF5C0nEnQaEonHBrUS+5r0hfA6UB44ow2Fzj6Dgy3srSEXhSmVBMQgDy5wF2SHMd3u9kNMOPFbwrXmfQq8vs2OCSCZlKW/sdnqp4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(52116014)(18002099003)(22082099003)(38350700014)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4xW3RDD3y1nFGsERlHOjkCT7wXaJAIUdWPsDfNXhSuBAssQZCmiBdR8I+07Y?=
 =?us-ascii?Q?TZmg9VsIoPVC1ZpWG74JKANK+WKiSHRQC9BXqR6MCifrtrmQNvuA/Xzcv76k?=
 =?us-ascii?Q?n7eiZ4IOkQ9Xe7SsCB8XLuToW4aqSAM/BA3vCnZF0un392usDLeT1B5RjDWS?=
 =?us-ascii?Q?J5KG/ymZnbO73Q+us+F1FhHOF2V9MqhRHfX6wTUZondj0DWcoo/2wh1SlPMC?=
 =?us-ascii?Q?V9Rg88vujIo0le1+/6UZmpRohTLDHntTPkrJCFnO3AoXQTx7dojHyox/dAnS?=
 =?us-ascii?Q?S4qQdjDzvzSTiou2oG/G3P+EuUMRCFMFgAVKwCDzY1CY/R1Keef/GyNqyvvr?=
 =?us-ascii?Q?wHSs0VyOHfZ1I7p9uQtzi9mmb16bmwLLV7MkwusdyNRhiWhKmslfiOd+R/Up?=
 =?us-ascii?Q?UeK61UhL3G29J28qHBev8yzMcIdJ7ciucyIyCmWeCqhqmI50wzhnJjAdXwxs?=
 =?us-ascii?Q?PiT8GLJs9OMcN6YxJn3DUi6Hh3vfmLW33cv5ixDxK+AztBTfGzMOn8jZ18+1?=
 =?us-ascii?Q?yiMYbFUSwxwve7WIfLMvgTY63jPpGyeqq5SZNmBECouY2CdLfccO2RTaKjEi?=
 =?us-ascii?Q?4khs0blS8wh7IeAbvIj+mQNfY/8F+9WFRdvm0CvTeXkr6YGNjEHl/hD+UQEj?=
 =?us-ascii?Q?/8JQ8tzH3cSVwpNkge6unj9DRo9yOzc2QFEIoosUpSruNZiHFmSlRxOwhIC6?=
 =?us-ascii?Q?sqPJIUMazJSWCsVVj4pH/o9On45ynsfOqcyLJJKiUo+mg3eUj/LGH3HgRpjC?=
 =?us-ascii?Q?LJx6xWs7dLjrsE4Eu4VKX5QG161GMcrUldDgPIIe8Z6w8sp1cAJbRQVNcDa1?=
 =?us-ascii?Q?o4UDFMHNYStPZO0nLDguPKK3j+iUCvnwRivW2txrfff/6p3nH6DxzJyX8HHm?=
 =?us-ascii?Q?Bqn/TcSgflnfxtWnpg8/e3IQ4yQ7dNG92Hvfg/wwB+/tL5VHuNgBGQleeGHZ?=
 =?us-ascii?Q?Cxk6Rl6RAGkYZAPzL9UifE+SqZCYq8VmCSHslc960JtcN15xLPLot1DWRb2S?=
 =?us-ascii?Q?A22wj4DDq6AwRvud52GwuHXs+HRJZuarL5Yg3+jPqH7uf/TA0qJoSd5pc7an?=
 =?us-ascii?Q?JKziQqabIhdZF96qM/EbXGLJsD3Z9ZkCvmdrIHyH+YiQlr/sFGWS/cpPqSKA?=
 =?us-ascii?Q?MZt2ARGHmvnO7aYMcl9nscITGslGnE8NhB54e++ssyE7z7d11t1tLOuwpfua?=
 =?us-ascii?Q?I7o/APTI12sHnPgvTOSbpAH0fGgFOlnDInUU8XjMdsX2O2Ote+EKHSRyP1EE?=
 =?us-ascii?Q?QmZfHufUCM+gi+fxAAL3dQ9mvkA99mvx5TjHC8qtHQka53BFnHgLDLjA5HpB?=
 =?us-ascii?Q?ix2auXkh/EXfSbVWAQETUuB15AfETd7iRu+suONt5xEoBmd526UxSt2Buz1f?=
 =?us-ascii?Q?LzsZO5GzXFvfwSLFTdwiYchr+BYTLBwX4YlXCzW4EheQ0BFKL6NW4eQSOqGp?=
 =?us-ascii?Q?pkpZNl3/FxoQ5rdM+2AY2QVWLSa2FCnu1a3wMssWXsBiGHQVFzvD4etfmCis?=
 =?us-ascii?Q?M+Z3jEi8jM+JYZ8nLr9tkRJ51LBeGYXbeEaYI43Hn7WG8bfbES/pszD+cxXO?=
 =?us-ascii?Q?FqhYvWd8Lc5m6+xV4nHCaE99/XqfnOiJbIvhhui0mNKknINvElFtIXZ3xQe/?=
 =?us-ascii?Q?Q7D+r1JpSw1HtFApr/XvbLRE9djjLa4wv1ADrd56czHbBpW1IZ52U5g13rYz?=
 =?us-ascii?Q?JKUrp+KKXwJX6kkHs52v+7Mkzqpg7ndMF0+CUnGaoQabx5GI0Ri+5LRhiYXg?=
 =?us-ascii?Q?ugVEXW21MQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f73296-293f-4c11-7fb1-08dedd6b18a3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:17.9702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4QsonCvay5iHwi3EJATmLR5wGC9WUXurUQne1UQTcALvxFqkjdOE4Tbkhl9buactq7R1jL330DpDqCHfRiOLdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7253

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/max14656_charger_detector.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/max14656_charger_detector.c b/drivers/power/supply/max14656_charger_detector.c
index 81798f22a037..f78d0341d0ef 100644
--- a/drivers/power/supply/max14656_charger_detector.c
+++ b/drivers/power/supply/max14656_charger_detector.c
@@ -287,10 +287,8 @@ static int max14656_probe(struct i2c_client *client)
 	ret = devm_request_irq(dev, chip->irq, max14656_irq,
 			       IRQF_TRIGGER_FALLING,
 			       MAX14656_NAME, chip);
-	if (ret) {
-		dev_err(dev, "request_irq %d failed\n", chip->irq);
+	if (ret)
 		return -EINVAL;
-	}
 	enable_irq_wake(chip->irq);
 
 	schedule_delayed_work(&chip->irq_work, msecs_to_jiffies(2000));
-- 
2.34.1

