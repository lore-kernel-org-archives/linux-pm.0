Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012063.outbound.protection.outlook.com [40.107.75.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E1B35E956;
	Thu,  9 Jul 2026 02:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564315; cv=fail; b=DfmcfFl+FmllTSe+YKdpUoQ+SNS+issFvEHqvIvOoOACiJ0l/aW1E00V6qX6DcEu6D8/0BbqWxJEHlTdMA4wtuylOZyZArmE1q360ClsIYnPbJmH1OE8PuPxnCmk16a1z3lTxR1fOJWSOE1hBpYxeb4ZYbmbivt0Ck2NpTu+TEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564315; c=relaxed/simple;
	bh=rVDB9gEWxkM5eS164jARwLPZx70cQ0fNRuIBez236zA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rL2D8PNIjO6HfmsW6lu5dFyl0ugceosBZINeG2X6y1SG5DrAXfUFfGfwVpqbwg5lifkU/uq7SYBru7tz3b7C6VvkJlSqOckvw0eJMdvmZTWo2dqILtsyMbxtJKQvmTtpn2Bi9gGCBIQaxfgK1FwJ5yqe5C9Pq0nHlDnXszyhHXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=czWUdwSq; arc=fail smtp.client-ip=40.107.75.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="czWUdwSq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAKo9GA+U5vpnxe6LiIAXuugpssFnmvpMik7tk9mi71zr54jt6KCnpXilQhADE4rABGSuHYOs+pvg2dUc/XevtFHfWxFC/TNv6V/BkJqW9LHXKg4zaxaGCof0zEfYfV4kevWDx2Lb37eMZDIK3S/mri4+/L/Ld3DGORuZiEcUc3MY29FcEyiqLHeVDbIBrkXsWiDtiaZJgc5/No/FWWfeCQGYYj+IQCKZJBAjmoizxxLv55NKyOkOd/a0s9bV80qyo4N9ovQrgsQN7G8UenlC/NtpepdPuXTw6kXm2ghgLU+CyN+GffVTtj0dGi/tsaYFUsroMZK/4WucEdpHP2ZDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Z8QenBfBPGDfc3ZcpjSUpWl+dxCurNDXjpgPpKmZNE=;
 b=ih1qqGWbM3A992Fe3QqoTbJrRy99emNUptwS7VRfRLYcVoV1fgw6dOH3afDx1umIgjfExCpiT2K8+yH79UPjhIFBtyXRpxa8cJ548wi967Q4nvRLaG/MNtJUzVsYuBl1puZadEnieK89Sc3u5WoygjjfbXL7AEipGaY5ANbeTolQhCjt0TG4rStLjCR/Tk9jqwwK5O9dKNYAOIIxHY5hvG96cgmv6C9pCoMbqANrg2qo33nHkanOJbI/fywuCg/eG9KR2QC6l3SSpy0u0D7Kn3MTss08QxkMkej7XhcjBaerLtScAk70R+VnFWRGN06x205XzGaM9CH5e4rRemFfcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Z8QenBfBPGDfc3ZcpjSUpWl+dxCurNDXjpgPpKmZNE=;
 b=czWUdwSqm5NYaWlk3NOi2BTL6CM6VJtirKd8seiLBItkhnGz0Zf0uc+9ssG0XtHhicGO8JspIPVH3ScqPS1TGuS/x9MRpIRzYLnJ+d5sXMJg+TM7Vpt6bqZtTtQWXyMSupYtRFJBL0bLP1EKoGqXRQkXi3BdjPd35frrdoLTIS2o3HKVU89g7IbsNVS8LKs88Qq/ZKnj6DySajPM8F2taov18A0Wx0revE3v9VQuveEbK2NuiCyB3m/fDOvMShqR52NktxtO4UZHVB8n6q5vq5ZRIFKQS9+0DdsLdT0zXNjJQ1DbMyV3M/dhU876nWLmwD4TS9gQLss5vp9QrNK+jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEYPR06MB6278.apcprd06.prod.outlook.com (2603:1096:101:143::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 02:31:46 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 02:31:46 +0000
From: Pan Chuang <panchuang@vivo.com>
To: zhanghongchen <zhanghongchen@loongson.cn>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org (open list:LOONGSON-2 SOC SERIES THERMAL DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 06/18] thermal/drivers/loongson2: Remove redundant dev_err_probe()
Date: Thu,  9 Jul 2026 10:30:09 +0800
Message-Id: <20260709023048.599150-7-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 52d479c1-2a9e-4c05-89cd-08dedd6238df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|1800799024|366016|18002099003|22082099003|11063799006|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	xMdpztTkAOw4CECDwllbfjdHtZKy6W4yNDAsnMHtm1tiikya3yCOOXXGGsgRyJYPP10VwlzznCu0ybv/0xJ7Potf/j1CehFJnqDHddmD55jcZFiQdsZCM2mHnNtnS9mYUKXqNKyAcv1UdgJGQQyEsqRYHMfA8pRIm6QObAD/ibV/jh2qTikFxp0uOR0EMrYHC+YY5+CQtD7XdBgkzSdzN+hJjzj0+C5o8fJJAG/mCUGuIroK2Z00ZCLlIH3nEuaUVnjOHIbrdDLhrX4tjmYOfUmNXtOUsiSseVVZavqPZD2H2o14OIrSrju60oqoY78gRXZESKvDa5XwBgiCp3Fblj5jMwn9vjUjlw4FbndhDIQpEeUDGY5GcLrLmsVhQj51PFKbzOxerg2ay+wppQmDq+u21tHIzRJNtZdGJ+HmQWvIFJWJJh7hF/2Ij1MI2D4M7LUp6QmkKDqHVQK95M7J5jP5e6QvJ4k3JwjTvXQE1y834VE4XZ3nTdXlm7QBOT2hlsPvcVsbl+KXdRrbj7zNlSawOFgs46zYM35ZYGY/95fqBFWG8Ump3bKih0l3bGHPVrqTyP1bNRmctdTzpZKTNYCFSX7Wre6cwbDqnt1r3P6yYpdRUmL0cppKGWNdaMFhoYeLLqe3bmijRjOkbEtjLs0AZvgdNFC59tpCGnQMqs9j6XZ+MY6YG6nmycXufG5/wLQVLxoSCuShPZHaZsdBSM+dFt74jlKxDCY1dL1cpXQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5VrTmoj8f0Z1H362pu+C/EWV/kLqD6fLVqqOL7fOEkXCo1wJ3fUHAEbPfjou?=
 =?us-ascii?Q?ICJuRu0gC/UzGr8fQhGFDbk0e4FFtnK2bPpPXf+8UVPl4qddJ+lHcIorStRM?=
 =?us-ascii?Q?jB2+5Svfe75paCRNqi6VwKMWZVK4vACCGLguX0rhLZiqmF++TdVSU94vvmh9?=
 =?us-ascii?Q?QJnFKKt0cRjURRxz8rkDQmRoQe6UAE9owz1oXqvG389gbuXQdNXwAxzyLtJ9?=
 =?us-ascii?Q?HmdVcD3T+oJXIdNFs+A8J9RKJcXjaWUtg9h5HP9KtaE+Mnpk/hw7NXqAn+QQ?=
 =?us-ascii?Q?q18Hpi8jp4m1HLC59t6ymCABr8lKh5UPXG5zfyGshxMEwen62+8N4hsSiQhk?=
 =?us-ascii?Q?SmlaE7t+Bf4xlzU68Awyh6uZsA89/YdoZJnFfzC8kWLpMmLH7aSrknIRgKH5?=
 =?us-ascii?Q?Xb7tIMhMxJU2bzfDflD9/go1YMa8Yn94jsFUKVnXogvkVhVvPxF4swuEfsry?=
 =?us-ascii?Q?PQpaHIv6XyyfNpw3MhL0J3XFqlTv4SlWjOqfKqA8tusDeDaL8V0fwyQ/CELc?=
 =?us-ascii?Q?dtQBdMsvNnSCOMUT7b5kLbdz5/tui+6d5qpZVycNHMNPndOpH5El3YheaaLE?=
 =?us-ascii?Q?53qmDZVxjEN9DGAxD7rnKMEnvaqeztJDkqANDGluGUrnVW3pTSk3R/Le++dd?=
 =?us-ascii?Q?0zv+ME3FtUScIi4IpjiQM4wsjF77lSgazZC+RW4L9dGS20aMhpTvrpbrEwBo?=
 =?us-ascii?Q?SNse/Cxc/1zhCoPfWmBZZW8DInof1p2/Ke1LhScsw+alVAVeiBaaV7CMWbri?=
 =?us-ascii?Q?o/w8/zIqZPVMg1ygDFmU+jD7adOsaJv36sDNVRG+65N4HRpqJ9gGbagZ5HDt?=
 =?us-ascii?Q?GhIkpq3anbdMZldnPHRidfs0Ik/jLEzvUsTUEBeUaOgm9J+SOH/eNirOhV0B?=
 =?us-ascii?Q?PyGSa8F9hJU0Gxhw4jBFsQ8Yu8ygc4gID9LEcWKvnO/nVIEsgWC7gLPKXc2y?=
 =?us-ascii?Q?nhs3jhqLznDIy6UT06s5DcY3mGD1sTfbvxIvD/K0yy3+EG8wX+vO0yTKL2B5?=
 =?us-ascii?Q?nN3+NrvIb2Pcrrx7Nw8u2LwQFNQxoaInITXjuZAJS7Jqzw3gobQTqY3yIEuz?=
 =?us-ascii?Q?61Ac/XoEniEd4tZCskYkEQLNLaWc0p2JAWAYm6PU3P+O5ypjcwutP6dSyQXt?=
 =?us-ascii?Q?Iu1+BZo3ZKpTXyT69B/lNUgQ6L5Y9KyQA//XsK+jsmd2QXDsdbxeSqO9W+qO?=
 =?us-ascii?Q?Kd5n1GbvHE1s2uNC1JD2sSqZ+J23MTYNeYFVNe0Fp3t8xRP5IWozuJDfVS0m?=
 =?us-ascii?Q?JSVb8sQ1iwOhMNliimoswTqd8YzykjP7j+u9NpH/i3Oe9aLDmKk4Q4qkpaQn?=
 =?us-ascii?Q?GAVIczYVg/P4kEv9Ejc/WxY+JZjOevNPKdpRxAZWfux8L8y1uNAU1Edyjtf/?=
 =?us-ascii?Q?fEqE35nBRnE8fVgZE0SBK1fiCiReyKRHGsHwc1OCcciF1i16uZ/SD6bRRgqp?=
 =?us-ascii?Q?SKgzCZLd51ELdd2Gxng22Jv2ZRfvCKA/xVMSL+5t5lzR8xk20remuNvlzQg/?=
 =?us-ascii?Q?SJm/4ZA6d6Ny88jBY6yCk0QDgyOwtE8Fl+jw0A1oj50GKjwNnGjclaZ9suW0?=
 =?us-ascii?Q?aPBdmstYTNNMDvbAgYZl7JFKV5lJvQDy1Tmt58Jgn4q8JlOpTL2/abhd0l3g?=
 =?us-ascii?Q?5iNxIrwlQK6nzIVDnwMsdLefHHhie38nvV4bSQfdq4SK4uabbLfi2jermZbL?=
 =?us-ascii?Q?MFVz4DJgv4eHAGQIgZvi/ZKgubWrakdQqiBYOJSf93E5Geifo7BCc2LJ8WCL?=
 =?us-ascii?Q?ddG/qhRVdw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d479c1-2a9e-4c05-89cd-08dedd6238df
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 02:31:46.5767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayD4GZlEGdYSfFXToTXgjX8u6ibOJWYD0mlrbBHtMtdYrmeAccei+BxquSKvQt5XjDyS0bUfZy5GWDGnCXvUgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6278

The devm_request_threaded_irq() now automatically logs detailed error
messages on failure. This eliminates the need for driver-specific
dev_err_probe() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/loongson2_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index 88f87badfdf6..4d40fc706a53 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -173,7 +173,7 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(dev, irq, NULL, loongson2_thermal_irq_thread,
 					IRQF_ONESHOT, "loongson2_thermal", tzd);
 	if (ret < 0)
-		return dev_err_probe(dev, ret, "failed to request alarm irq\n");
+		return ret;
 
 	devm_thermal_add_hwmon_sysfs(dev, tzd);
 
-- 
2.34.1

