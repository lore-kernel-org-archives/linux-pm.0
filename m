Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012063.outbound.protection.outlook.com [40.107.75.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4A6363C7C;
	Thu,  9 Jul 2026 02:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564319; cv=fail; b=dNBEJUnbUjiN+DgUTC64BrbP91+zb1k/UglNcl7C3fJ5yT82nZ44YnaOH5wqlN13dOO54zC7pXLdnB1cQW4iV7AWAG8ZUwvVDO0hYOVaGT0JHqx/rWC0ZFH/fcBEy9+6+C2WwcXG4H2/kTYd4n/t3ro/AqoqfyKCRKakzp3Tlgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564319; c=relaxed/simple;
	bh=MUBOqzfbZij/RoiuuJk8Vz3dv5j83iK91MPPSSzKfgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pKbWFYoGGB5OenQ3T7ay4BbjRAONh+B2UsjXLJtvusUwLprIhLDepRKDBUlyVMRCqk58ObUm3zJ1Abwt0cerbZWDmcCTmlSmH+NYPO+W+Dy42rgApXc9i5xjhgT0bQA4EQExA9akJXB/TKMmaAoL47vIUHXuobt81afMM+3gMkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=RbqJIMjV; arc=fail smtp.client-ip=40.107.75.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="RbqJIMjV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4HsX8AGJJmnWG+bYFT0maOi/7Crk491oHZeL9GQjVLYJVeXV5ng5nwyraZmBReGGEmFe7BJN8vn6BW9cAdbD7MryJvLYwNpAk+UpkF+p6laUKK4Pjb2kEGaarm17rdmlM5/Ewro+kGV9dS5usYo24YM5GDJv29xx1tmkBWNGkkqsn7J7eE7mo1aZIx98cIwH8xIliV8V3DFyd6DqO7oh2SVtkUN8A0HRmOYRd2ie3adO7V83XgNSdxbt5md5jOyjK45qinuc4PTQRzmWx6HuXPq8eYgmA2L/huo5zxw6k4pqVBhGqNc/q+YVsyGW+VzbbKj0QSII5omuAKnQ028pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AgRasxon9IadjkzD5bqj5kNiDYPJRzUSjdTGTPmN5Y=;
 b=XRNaacg2KSUBPaXt9Wvt0p2ABw/wQ5YKVhmi2l6b0DBM9JunFtnsot14xW6gbYZ+stcp/yLAxuM2SHn9LudEaDo7oAw+Kb6rbx8tIfKpyi4KGNmnRNUw3w4N6mE62QGjgnRe9j9emtAI433dKErnSEUiywshWIocVC1P/IxWwtD8EtUYLzKRC56kbOUlVjJM652SQlqlc0Yp1/r8/IYMldZjhQX1xZDL47qafUlDQ8gAor+wZF7ydMKI2NKaBD710KbRwRKvEEPmoKaNLmZFXJXEhbpNDdJ6kzCSCqgl8Q90f67USGKiCH5U5uiStHXIqult58LMensjUwsMVHRBEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AgRasxon9IadjkzD5bqj5kNiDYPJRzUSjdTGTPmN5Y=;
 b=RbqJIMjVpi4GJDcWHA1VCFXR5J2auWWDfAclbQGvR7Um2QPDjuAJ3l1ceOZA+GBkJVFjrvEUYiQ9CVCT82BPZFeDycPMsM/7coehATrTBP1obCepyKB75HXp39ObJYbiiqZLsBY2xU9VwcpUyLB2J1nJtG0UgukD/CIrcsOfCuPF8Z8urxZL1MTTk+6HVRPH8GCQ/tB6iqO45M9nXSgcChy2nNIPCvjprJZMA5HnCqp/TWk0aoe3Qh5HsLQmSsqhwNX1kikazOKMMYeriuPf+1ysQ6cuy+ar/ggiSebn8Iz9j3A8/GtzcADqRTOmR/3IqSfP3M0pNIjBsZxhSJ3Oag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEYPR06MB6278.apcprd06.prod.outlook.com (2603:1096:101:143::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 02:31:50 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 02:31:50 +0000
From: Pan Chuang <panchuang@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 08/18] thermal/drivers/rockchip: Remove redundant dev_err_probe()
Date: Thu,  9 Jul 2026 10:30:11 +0800
Message-Id: <20260709023048.599150-9-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709023048.599150-1-panchuang@vivo.com>
References: <20260709023048.599150-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0019.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::14) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SEYPR06MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fde7b70-4e6b-4ecb-549a-08dedd623b64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|1800799024|366016|18002099003|22082099003|11063799006|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	Zbe3rTeqZ/T5utR94KRM8DeyQE7aIz5j/oHyoSdOczt5SR3LpIExn3ghL7H2syZ0i5Pz/GKM6opCZhBRGKBB71wazFk1MZv+pkCdYpZCPKo5MbKiDs79OmQBT1OI1tgCIa7291OVAxFYdgdcoXsc6d3w/Z4Sbe2gxmTxd2s9zOj7pKcMHlk+dq5mIVbKCJR8kBxfdG3wclQ51/X74/N9lP9eFpdl299L9/AL2f6cV+YoLlG5ZmNQS8YoyFqDSdCbhJ+IHsqhZG4nDaevj+7rwyyVVapILLk9N7QoCUgbyuUZi6tY99RxcmgVOBWgNPTgdtSxwc3kCKiu7KKdd0Xm5Tz9QlRdhbjRKmYrsnDXBsbl7I51hGDwwJlIWdDmWAjQocZsFhIK1D5I4fnNeAAaVN7Wbf8KosNI2MfVRLkKdaK2ay/wcyfY9B5V2V7jPNTcympSYWzJA4ADvgD1PHzRGaJF0bsua5fiQmgX0ZWHW5ftDB4DrWJQpfGUYtxDC6L9L17PTuUOVKVlvjOLEh9dWe9feqx+K/Q7kdDUmuctpe9dAee1Ga/iJcYJiQ9WF1Oxss9ZDzOltXwPMRgHl+510no8Fr1H3mAihiJMWA8ACF/Q8LEPjDa8QVPJUCIArIRa2OFkaKAr0kzDANgs7MQSTmO/rJ74T6H+y4Zt2AjOu2tqIdyhCKVF5IX5hdByysgm504YXBQh5RCcuxA11EDFxkN0vUJZKRsPv/UtVBoFpks=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cATDT0c8rvOANf8Pm23nl6bZdb92JB6fTloqepO4JpOLIehtXVgEAYACTGrx?=
 =?us-ascii?Q?Yj6JR9Fys+MqMSQ1e6bkyZRXq8y1CA/WK6xaa8KgMTej7a6HmOFEn0My1oVY?=
 =?us-ascii?Q?/XwghGjFDVnPAgBtvROl3dXSIVD+HzCGHDBgroW7fEn/aiUBCKYCVaa2JZKT?=
 =?us-ascii?Q?0zx1O4wKejjxxfwNU6Mze8/Fw84yxG684LPApSop2h5VbCz3bSN8VboRSCM0?=
 =?us-ascii?Q?PIXo7pkB2+S2tOT8uYRWSgzcSyhH6NvVxRb6fMWA3TikkAmr0MMl3wgbxkpl?=
 =?us-ascii?Q?cKlIoEYhtkxI4r95yJkp8Js7uU/GY10cR+I1ejYGcV6MCGwKD9SqhmEssORh?=
 =?us-ascii?Q?tAwOWJeD1YfQKWWX2mP5mWhoQdMNAiOcuM9zmoIUmHJyyrBXep3WTnSh2Nxz?=
 =?us-ascii?Q?wtq9z1giJHQ8zxKokRjOQwUBlP8WN+v1qveveCG6i+06fvXB7yvWG6hyebNI?=
 =?us-ascii?Q?sZd/LWAbHuKBzxQ6CNVwj4LewVrbvVAdUwGN9jsCAGKqLgmlk7P25qhK5FG8?=
 =?us-ascii?Q?6AHVfSRE+w8eATjubNESxjFazQPVcvFET3RvuS6gYjWGtALj7zX0TAm64nVw?=
 =?us-ascii?Q?JzGAaVpFhfBV/+wc0AYVHJ92n9Y/Ar7gPn52a9U+b7zZNOxs7ED/hYV4nRTZ?=
 =?us-ascii?Q?e/8PO/7yI89Q8BksBRIFRqUeswSm0BdVJDoAVXuALHDluktOJHpGvQg3cxuA?=
 =?us-ascii?Q?7gHCAtqWQ+R6dzgFmudwlaavFdgnkCvHmFzv1UM+BQ93H6Cz9QNMGrnR+tAs?=
 =?us-ascii?Q?++T6NHPLjyaWVpQ6ybJgH+CS7BqNAUMZnjNCadSn8Ac8ndGs5Dl6O2Vrp2b4?=
 =?us-ascii?Q?EPyPAtTL93Ipy1o0emvan83wIT5IiQVsK+CGgJ3k1RboLfIK3L3P7I+DAXcN?=
 =?us-ascii?Q?kILBaN8CarxGII1IKJevlEuomlTZvI8wnL81xQ2Zr7TuFJKcZiJKEAUfpknv?=
 =?us-ascii?Q?09jR09MNuTYQaaLfgGW44CgQn5gKXJv6uf19hYHLZ7Dzg9eRLmar0aRrXIMC?=
 =?us-ascii?Q?38ZIKXfQS37R8ogo6N/CJcdBC/llRBovc7qKSSN5jZ9SG+RfyLhYK/o1Lf2+?=
 =?us-ascii?Q?Jlq9Y1JAdCmPhv0NoiUiOH/Hk5at68bApR3tcfoyy2vs8R02Myh0ZN80MF+j?=
 =?us-ascii?Q?D7X/4Jk/Aomc4e2JuavQsEY6GxBVWv+V/5cB1u3nhdtK7h7FN5reO1NT00/C?=
 =?us-ascii?Q?irK55m6SuuJx6fp7HBS6wL4pWTARCrMGeTeU058WPePIBGrHTxFIUXRLdQNf?=
 =?us-ascii?Q?bw2McbEXtCkdjUbdUBBJlfV0Xu6St7XaDN7DQ9jC4cSTuGasl8eD+O7Zxgok?=
 =?us-ascii?Q?jENfUHBqIxLcH6AoROeeksoqMb0vxYJpA9ONw7JZW2mQq9xSZIs8HthepxXA?=
 =?us-ascii?Q?TWQ9pgy2NaeGQeVp+I446glftQM7O97+sDim4c9X6evKdwSishHGjPtTo6La?=
 =?us-ascii?Q?K2gDt78e0q+GdIN+FfoNJ+fsbI47W3Nsj/o2TbFtRJaJrV/Lmr5iex8gepYQ?=
 =?us-ascii?Q?/UKu2AUzI8PUUBPNfIwWXbYhCOIjTWYblX9pP6TT5cz7KnSoo3VxaQdXQS07?=
 =?us-ascii?Q?mq6YIAJ27KLQxQa04KxRJtNkMLW9tIkktdUDbm+eUxIIEoirlr2pdECWcu3C?=
 =?us-ascii?Q?tf/u8POWU2b33Va88reQQnC02WhT2i13wMjqphJdVHJHXI3GaSw2AaHcKflT?=
 =?us-ascii?Q?n89DeosFHfFH7OcKzlGkA0iTImxpHuW2RcyelGXQHRvkJa43oBumz/0Y2sTB?=
 =?us-ascii?Q?FdCQTz9oIw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fde7b70-4e6b-4ecb-549a-08dedd623b64
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 02:31:50.8011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfomWfUbngzXPKNmh5P6MgL6zjxaIIRnUtqBSQJ779mHSzCfvkjC8CPoJSlqGXONG0KB0je2nT5T01c8W7LqCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6278

The devm_request_threaded_irq() now automatically logs detailed error
messages on failure. This eliminates the need for driver-specific
dev_err_probe() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/rockchip_thermal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index c49ddf70f86e..08891608baa6 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1773,8 +1773,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 					  IRQF_ONESHOT,
 					  "rockchip_thermal", thermal);
 	if (error)
-		return dev_err_probe(&pdev->dev, error,
-				     "failed to request tsadc irq.\n");
+		return error;
 
 	thermal->chip->control(thermal->regs, true);
 
-- 
2.34.1

