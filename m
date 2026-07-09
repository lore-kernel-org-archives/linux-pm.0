Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012049.outbound.protection.outlook.com [52.101.126.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F25396573;
	Thu,  9 Jul 2026 03:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568127; cv=fail; b=l0Q7sS1nDym3/6aRtZQ6lI//VORam0gOq/v7pNBYvhPSNCndqCYzUD604ew6AQgeZlpFbSAULzS9vbKfAKdrkf543rpqZK2bT3L7ewpFcXRQDIv3NGMKc9yMRMXnxn25W5xgARc6Bm4yqtgDyNJz2HG31mv3ltoRPX/VNJAfrPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568127; c=relaxed/simple;
	bh=6jX1Knu2yfbP5Tr7ANJf3Mt6m5ygz9LKLWVmJZLA2XA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n9FkdXHFVk2P/255LnqTsCOyeXH6pmAKex+FM8YMjB6ulaBqKUNBonyQqW54bJHWEBV5RLYH7CAAUbxeGKXjq1NF8ht25bc7h3EvNcOB5+DQ0C5GU/3dGGrqbDc/IbhzKT8lmsyRbhy/djtuFWEb0nVgDOi3/R5x+IG9NBd5Phk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=GzhIDFEK; arc=fail smtp.client-ip=52.101.126.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="GzhIDFEK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8O9d55jPs0KMgZzgajR0Y91cnrc/HMr8aCr5KWiRI8CqobCsU1X+O/OzcaC06tCiHfSU4BykJVP8htCdypk5kjlBLAas973ZcAvGCWH/5EM2amd1sgMvY2Z7x0PPCV+YT095NlwFCEsGYszzBEu1MecFm7To8uHiZdPNHPu4anB9bGGgvCBMvc6REr7UN2SuJ4shS3kVLYFdx1AIpkPQRUaujwgLzYCO8EM1LRdKxwLyM3Ve6uwc8YGHBLsZcncLIvkVAzWKFXh/r7Oh/S8qCD6zrFmeDapMtCv8BT4IyHm4dTpLvI0sw6lAN1TdQHoaWdEnHFbNXmem/ds12naUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48dF0lMDCBaWwPNw/aRR58kCOMs1lLoRo4kIgMsAwbc=;
 b=feVq19B+ArQk5r6l4NL6FXlp1v2ebsMsHO8WP5gNc5MHDCLidCNN1br1/iWzor+kEpWMuHCks+kdt01z2pVXbPgVtMZkXzVhIwudMW5z/FD98dOqkFVoGoPIrPmTTKluem3RQq3V5076DxEmcVV3H0jZ7iTXi/QZdM74TiXJkq2cfyBzh5MGwAojKyTsXL97a59ASEOpekuCxdusv0vuysczmFniCRaz1Z9MaWlNKqBIHNjC5ohZxCXh6W5IZil+R4R+Ec+lOlLW4G64DhxgnaRkN1Bwl1dY0ksOUVUzIInwhGLzUrIRiXetRqy1Wx5Au2NUC6+wpFr4jT03fjmdBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48dF0lMDCBaWwPNw/aRR58kCOMs1lLoRo4kIgMsAwbc=;
 b=GzhIDFEK4RqfH0/zK2HHJStecoTOAL5jxrDLRY9zfHr2gzt+0k4tKmCg1yGGgvKzYGHOUSIbpRS5BY6/Lq3k6K5Uhn38H0pltyPvf9FJsteSWYtEmyFVo2IGNGpqYTKS6z/CNAKjb2JKv6LNxNpqvSqMtRVAjFHjOCs5q6lDVCv1SqizWZXrBoXXdNZ9ytzXELUKr3gG7WpHQtHYI3Xphq2NqZtCYoPzcBNokdmQo+qs8H423CQUeAD/H2Ec5Nm0mCcmvstfZwLj0RllWgjrITdZXMkPMSz1unZtI50JlYe03jfm+bsH6n3hibh+7YVMel3wL1KghjtlJA05GIx7ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB7253.apcprd06.prod.outlook.com (2603:1096:405:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 03:35:12 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:35:12 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 17/43] power: supply: cpcap-battery: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:33:56 +0800
Message-Id: <20260709033428.362970-18-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2b28accd-b862-48bf-afce-08dedd6b1518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|52116014|18002099003|22082099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	LagifqTulBeemYNf5IR54vXneUgoBfZpG9JW0gT+XEvxVmHUAB9IxsqEjzKExiwOrvE4JU9L7FFmsnIVil/j372Y6S8Ng5aWwg+fcZGdeR6IPWtTxACmD5qTm3tNkXPkjEDmYOtI1HwpFxOPQSxT2ziUGxxYtbrciVfctTR5cjdq40qtZdOyY4/zyP77ssz8kNS+w8T4Io1Xk+bkE8dea3CUgLSYHn+U1RCvLMd/peRZ00RcfKHZHu1zhP8O9TZJZvuuG713s+7TDPLZGRxGqm0NZAcA5Zzh9d0uL8Cxc98OZTW4KgboN8WuE294kB6nw/KUYbN2RpFGtWr8NAoSrKPAxcCL8QWq/REpnozkboKUwr27WT9QTofGptZQiC5wULKcxFauglGzKYWPDLm6wSScmtt4T6AvNsJLydBanW+vbBiLMRVl1oPeLmpVacDXjrz7KD6tf6Dbgh7J/FZr6+SLOwxx9X1OQb5mPMRnclm5tNyZqaEGxRlU+TTz9Y/WOtdyxnPwWlEnvYOahxNeoMRv1ccahVFFpXiKbzbFNevNNpa/CQK3opby1gyzIAtDsJztPaaj39ktfvh4bHih0NkWDc6zVsZeEayPZ2/Uq3ShUxx2MKnlcIjCglGj/zHUb0kzckLpFlNx72xrTlIjpmGpOJE7LIkz0vWjRYE0/ecy2nTFz3r7XhojvUbU0eJdwH+TpaBjRTKeucryY5cG1SauukgBWPOaZPACS99wb4c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(52116014)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nhpiuvp3WnumLkCJTi7k+STPLZ/zQ2C91z3Xefv+DWkWVsa1cVtjp59BN6Zp?=
 =?us-ascii?Q?bVM9/Mz+nupzf0Rt1TfGzAa+EQw9cwXQdf0L4n3+1ZjUz73nHJ4lHxtuf3Fb?=
 =?us-ascii?Q?RZO94wqSQmZi0pAoDFORtijQ3Sh2AoZUqi0X1uxEBUDP+PYL9CsnIoDRXZll?=
 =?us-ascii?Q?jhse75eEmQn7xjvSTzm3GS5ZN3XbWh6DiJfk9wgAq7Sh3rYOIRNE6+6AiCQq?=
 =?us-ascii?Q?uGBBCJUzdCLe3/NIzqzxZuzeTwE/lZOPVHsPCm/iWLW3kXXuNADziIPDXb2j?=
 =?us-ascii?Q?dpMiAQVMmR1ihzgkVPpx9Yn8gm/Ypmpx3g6+vn8XDwnCOVxNssfH2y80Paea?=
 =?us-ascii?Q?BesKDaPQocT//BT6sS+GqmvQUTnM+ApbbYpwbxGBKFcZ9D9oLE7kuhue8+we?=
 =?us-ascii?Q?6Z3O99W8LsMpae95RGDQ0n7R2Gdy0D9bm7zqHGyGYDvNMYUKp8+MvCZBRI7o?=
 =?us-ascii?Q?gjzaE2ru7tz0mPAtgm3yloqXY0ZEVRuSKCeXrLwdHb0sSWdX6lRRh10JNDNe?=
 =?us-ascii?Q?XsS+AZawEkEta/4/sinhr6jJ//i5ue2TPwk/1b7wlQK3RRHEOf3CiHc13fLj?=
 =?us-ascii?Q?cWxvUqmQGNVkPvqtBJbQLcjt7Pv58xk5Lc9I02Y63AFTUSiBzXtQhkW4prAe?=
 =?us-ascii?Q?SXymfrsTkR1gB/pIza00GXy2e2quQ0WSlya8k8Kpe3RWeOVnMQjrBLDky1G/?=
 =?us-ascii?Q?NYwE1D7MenJuFBM079f0u7T04pLDLRmtNysMCMSSXvfCKHAGtc1SnsUnyvoH?=
 =?us-ascii?Q?304pk9RW8HYq6SnXs1A51MrT8hoJgiKMeamQryv8rkvgX95QYTCsEzEW4Ss4?=
 =?us-ascii?Q?pE5KScWx7sFqDNuOV6r0XPzKVguMqRZhiJx+3ME1Mi5aP4j0ixjoT+oYbR50?=
 =?us-ascii?Q?5o17hPI+vg0HpsF17pm1/QV8RxBagB40r62uRxfVGUPxbP1NW6/d/S3+m/kG?=
 =?us-ascii?Q?MPu3z3ItFgerAJfFU3a5kLKkdyO4hCsedw9D68AAjQZLyvMwmtNBnK7V3+IA?=
 =?us-ascii?Q?WpSQrjOtjkQAE9HvnUvZ0nxoKaW+fYoUSHioJBwj9weDru/TCx45zYg7p/Mh?=
 =?us-ascii?Q?N5z5+DOBZanYECHJYgLMVslfipAEFOE81mqN5vwtZZKrxweLYVzNTzXTYqoh?=
 =?us-ascii?Q?Tpuve4FkMlkBxwu7UfWbPeUae7t+QVKIGJYFlBjVbn5lD+v8kKJgX1kNiVMn?=
 =?us-ascii?Q?ddllg/azjnvZ9wEScOPLImrQqB/GmV34RrS/gT9jTAy7mBRs3Hgyy6q2KhGG?=
 =?us-ascii?Q?y0nVNOG8vsWA4E9HvvvYQiAwwGHiUO2nasbP4XhGkxLF0dAtk/K2cxhcqSkR?=
 =?us-ascii?Q?ytQ1cv6EEieN9WZu7FlTsl2GegA0Qbzq5PMXHP1Qu7CZ5wtmmswGPEsJTOo7?=
 =?us-ascii?Q?qtScbpKtUqL9eiEbyy5bqeiZ5ZUuCHiz4yQAbO8oZOHm7HEn456XrmkYTBlK?=
 =?us-ascii?Q?X4G9LuwcPmQ9IRj4PMAlS1WU2p3btQf9Nbaii94cekUw+IS5/RnBYK35eg0W?=
 =?us-ascii?Q?9SgiU+ELFjBAXn2dTv0eUXwrYN72EV7eDNMrr7n9rf4oEO/KMQsrTUkZDwcD?=
 =?us-ascii?Q?aJvEw8dWufsjRwEXJ4rtj30r1wgmzuVTeZ2Q8qkn6GMRx8Z3CPipVO0zUone?=
 =?us-ascii?Q?TYSzXwRwkff8el0Eth9fiWkGSdrnTzuS/T2yKguptN6GXW3mWMGa/ayFT309?=
 =?us-ascii?Q?xZpKsc3eBX5l+A9yAtoERQbA19PMX2prlCdNeALav/GvMQYNZdsA7lF1Bsmo?=
 =?us-ascii?Q?eUZIPMBpgg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b28accd-b862-48bf-afce-08dedd6b1518
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:12.0500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RH7aF/Jcb2jg1tPSxBIa4aVPgLjoVTkIov56ZndY+Qa7CPtQvYC9+MEqbSqgKPVhLY3d2ef+AdmEf9YPPpHpfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7253

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/cpcap-battery.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 59c741993ef8..1d2b8bb08564 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -957,12 +957,8 @@ static int cpcap_battery_init_irq(struct platform_device *pdev,
 					  cpcap_battery_irq_thread,
 					  IRQF_SHARED | IRQF_ONESHOT,
 					  name, ddata);
-	if (error) {
-		dev_err(ddata->dev, "could not get irq %s: %i\n",
-			name, error);
-
+	if (error)
 		return error;
-	}
 
 	d = devm_kzalloc(ddata->dev, sizeof(*d), GFP_KERNEL);
 	if (!d)
-- 
2.34.1

