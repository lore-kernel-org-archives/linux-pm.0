Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012057.outbound.protection.outlook.com [52.101.126.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD8939D6D5;
	Thu,  9 Jul 2026 03:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568133; cv=fail; b=O+t/R1lv/zufj1n9i3Yb2T2XWr50OsqfOKNEv7Pg4Fvf4sMtVhMuutzkVdhcVHDwNgPHxvHA/c1ndIXS8q/7f6lHQ5g7MPLGl2Kiqnewx2J4bzZo3O5wjAkryIZNujgFSNNxjw7hVtbH40+bK6QoaOwtrdBWLOxI9hjimwR+ftw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568133; c=relaxed/simple;
	bh=5WIMU8BW9PMWHbX/JJfCsRIvY1ZgOvbxPc2z50GYEYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tBxvXadNszKFTz71d1rvvB9cSOiXHbLMq3bdGCfxB7JXz3l8pC+6mTRUh+6h85/FATgUNNS6QzsaL7247hCMfrDnhqiwbOufVbgDfnYPapVZgXU39wzpULBOOGpc+Rp7yXrqaodOHOH4wtGrgdKJpxds6G9/aootBb+5okNBJJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QBM/8Hry; arc=fail smtp.client-ip=52.101.126.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QBM/8Hry"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+4HNAWGBUcxNS+G3SjRgkd66Jcy23eFzrtiVeZQbg+oZH66xPj9Cv7lT59nRTS173E65wU8Kac8yhuGm6py2RemNc9j1gAN/18uw/MJXkoXNV9sDNhG5PLGyi4qbsHBhKzIYIVcq61BkQO+UD1g9L/76RQmembAuycI3yL6DrfSfdfnggD3hlZ3tPkd/6wDAOp3l8hY88Feyo5EH2vfwu4ZjXXQisx5LSLrtJG320etsuFazks7MEraR4JoUMBpNnD8wHaQW4uVwUTOBsHSeVqrU5GN60FzjtubCoj6dGFgabBF26JvWKHoV2EtyXZos3Zursznd7h9QJIfQhjpPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jDib6cxtskJ+cHI5WhVEBzvMsxGtK5NMKg/75jinQs=;
 b=cFXhCvPyI3Zaf+OmJosgW/w9KWM426M7uNuXD26WF8LSFAJT70OMwxuHWbKXvnw6K6csZeq5TAIjR2u+rwwxy7bMdD/DdCwDhUAOpky3/KYVboggzV1AJTtvFWwxWh0G4c7F2gGMlwgedDnjuO8bGxviy5Rw/mhuKlfuRbir0pSpJXpZx1YGFh2uGnYeLnUUCgkO61TyOWFBJwVQPfYllHwCKD1pQ8wwi2wGF78urDlbBEMiuGBX9gqGCrH56wrUQSFGPskAgbpm2OoWqwiz+EyTcMJ8fvUuWG6y6NUZm4GUzRQqMoifDfSODWDTPOL3flVQzcBO/sL3L4XywOslHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jDib6cxtskJ+cHI5WhVEBzvMsxGtK5NMKg/75jinQs=;
 b=QBM/8HryJAT/fGLTwBqV5GDDr/a7vwUrh29939SK24zRkCz4YDV1TrddIlS52VJmytU/xPWWVDnDrLUJ+kAvJdhBVLX+l83jkicSVG0H6E0nB1guMAT/5ISQTHp9DPlgNRJy3Y/gsRIVatdMC29sBmss5zWZBX6MVqpEtYzBB1FAVdtEPoriLEWCA3GjuKJrmQaVzMucMRHd5iKqjO9AIMMzjTf6KhIjmB8JpRzQI23DyeWIctIknvoPe+RWerUMTHDaXjy1bYx/GsU6Gah9XjhPf2vHonnx+vuKrILwDvqTh8DjYfHD+2t1izPje7xpyhXhVat7N0hCPkUcDQr3og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB7253.apcprd06.prod.outlook.com (2603:1096:405:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 03:35:19 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:35:19 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Amit Sunil Dhamne <amitsd@google.com>,
	Sebastian Reichel <sre@kernel.org>,
	linux-kernel@vger.kernel.org (open list:MAXIM MAX77759 BATTERY CHARGER DRIVER),
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 22/43] power: supply: max77759_charger: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:34:01 +0800
Message-Id: <20260709033428.362970-23-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: aa631479-9925-4b29-f35f-08dedd6b1974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|52116014|18002099003|22082099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	hTUWQf+Xw5UG9FRbgt+LyEO3121nx6/+msped6YoQB2M+aL5J5g59+KICpxhkXBpoDESs4QR2Niqeoqk/uwuH9IQPaGj8me7b9uKub2r0AO2mclNuUbbYPVSJcpxETit1Ar/pymL7LpuiZi4Jy0JZ9WK6LdzwOeP0+vSY1aIUgntPbJi31mzr1r8cYMyu3KTQ4DQfzLHgSokWnVHIcwiYWZIdC2Tl8LlWQw/1X6Wl3P2W5OY5af1vieFrQjHl9id4G/585NXua6fzmXniSO2tl7l+L7xo1IH0Z283Ja1fOLUlevn3+zjg3MIGxWQatF4puIoSMrHNlmmlzwjO/ql0la2lpoJ7wmoqLI1GyqcODYOpDyUWrf+UnwweKioA8P2hqr7bSnqMn1ZlqfAkLjkpqJZpL1IaAODkmeu+9JPBc2xQVB3Ctu0gnlHkoMXgtC1YLUkicIYYEVOn3pqrJp2PwjqNFyIClrE4s/2dL3QgyMUnFVDPEIvVOo/0rdqLuOmpS9khI0wOgvr/Fy6i+EB9Ddi1qF/gJRcV8AC3Nh8ytU44+KGE5opS6z4KlPiY9IYVvCGk23A8E60Gy3UiQ+1sgtjDQ3Wl2Qqyo9VeOCPkBqYfo8d19vad7/cKPnANVWh1HZhsN2XOhFsknDhO9uZ4zVr9O2K4s66g7GjVXCXWW90Gl4ne5QLxwByr+6ul0SkV4v+k1FGyN55AjD785DSXsp8T8NJ2O1E2dfX8uOmO7k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(52116014)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3RpQncXpLdPy9LR3/1wASJQFckpf1h3QgU5kXo6yizCgEzB9zkgNvtmizlZJ?=
 =?us-ascii?Q?VOt8C8s61/E0vOZ5+zGquzSBQDCfByXX+kXNoditHiYtC1rPUfLUrgOtVYnK?=
 =?us-ascii?Q?ZLAMEqAFwrghfaBvKhadMFL+7olXILMNK0lwPUo8/gt8kKnR9jd1/Weo0fxu?=
 =?us-ascii?Q?mxSGumbQMzk5CYnWYSm6+kBREMiTgxdzntQuBcQl5RjknJCG6euFg3LbrgYo?=
 =?us-ascii?Q?fhXqSjKwQTJEoybam8HwrOyUMUJQIXoCc0G8XEbCsGYP6zhLnmwvGcn5HMg2?=
 =?us-ascii?Q?0IIhi4K3VOo2LQ9x9WC+nhbrNkyt4HX8dZDxyjGS4QqvaYTO/ekIg7SljPoi?=
 =?us-ascii?Q?0OEMamrulYjvW/jK+f18F/Ongam87Bd+lBAjHNpHVs9d/C2/miSDiNjCuESP?=
 =?us-ascii?Q?aa7Fmgc1w6SkK4nrtiGTtcBx136n4NQlSxiKM07znCh3mBW+AaEybOWCo+jY?=
 =?us-ascii?Q?3lCvmGjR22MqfEkxi3R8vv/Uf9dOh1VbI5HJhXdKppPxInzvQtgtxcv9kJQQ?=
 =?us-ascii?Q?3qN4dWfbYFnnJSl7zdlq2n024GvUSNETOjUZgD7JCxmrVFTxSn1Mk4e21X8p?=
 =?us-ascii?Q?VcuI6RqPbFmEH81mGlbgJQKXfZMLZMqfBFFhWpyNEE/AVHEdkbUFL1teJscU?=
 =?us-ascii?Q?sHZ8PlRgoPw89aeQq7IYcANnwR4fRB0L4bGsLq19fnpwqTRBkQZJiNiWaf7N?=
 =?us-ascii?Q?LE86Fst/WkrMDNerpbFl1ptGA7hx7Zu3B98rU9UIieFFeKMrcs1hUxa2xDxR?=
 =?us-ascii?Q?bUjVNMJCfrmfd3vD7XSShHx7ldvMWj8GWpnbHdzKIvWG6Huc12kbM4TMOut5?=
 =?us-ascii?Q?i5/96+LuZAUGIejTb3odoWfly9ZbWLd4XDL1QyUeaXa8qRDbFc1UHQrt50Ld?=
 =?us-ascii?Q?ZRZ/Mi4JWryzdVT5m5jcjRZMZQ5smfforVbvQpMq69sFVsYY3JipJXGp4PYq?=
 =?us-ascii?Q?ejUmyuEvkKIas03joY8SKGGHpObbrbCGhhV8+2sC3Hyz+UWfvkp45kmcHWf3?=
 =?us-ascii?Q?PIjKEGmDH5cwwxxYKR9ztqIhF3x3bReGQSWTVAyZCYEY/vTuq50TBa3o6ElR?=
 =?us-ascii?Q?icnsbUOd66gZie9DJX+4rAeBCezLut8o8SQ/iUzy5hpFmTzc1HXZv9jJfMxq?=
 =?us-ascii?Q?qhU14vhEapt/mP3SmE82oL8sbM8bTKz3zG1xxo1DUCqc3j9jqHly7FkXznS3?=
 =?us-ascii?Q?6CXe6VJgRNNWEhF1RQF0Ob84+0cITimtcNd+6ioRwciFpcPBryaeoAxs5lgj?=
 =?us-ascii?Q?NHV/RJ9V+VXbG8g/YN9PRag2Emaz3qblGwn/LTvkKCBkPFeHfVs9U9xYka+T?=
 =?us-ascii?Q?NYOmgcPxlwbDVMOxZ/3gmQcNfnTXdoM8HgbkBMDCbMXQss6EfLer3afz3qf8?=
 =?us-ascii?Q?kO6NFI32cia4jdQRIRUjoQcLKixobqA9zs5SmpawPVaDa/IiNgDvvra2dC7r?=
 =?us-ascii?Q?xhNyZ3LDA52oXAJySzyYLpR73xIA7V806pdJ5/ciDcVFRBARldZGSXntckhu?=
 =?us-ascii?Q?CvnsGCgf1qgbvr+ewHLc3o3W1N/v26dDD6m/ZJ+tZtMpt8pYLxRgePmhUU+X?=
 =?us-ascii?Q?vlzEFd17QQ/3TFg6s1e8agxEWXuXZeKZRB7kL8gNNap9EDe/fg7lfCssZ0Z0?=
 =?us-ascii?Q?9sE4HdhPYVtpAcGiV2FhOBkwPDud64J2uYPZlsGMxu+GpTnJsS0Gbx/2g2Nq?=
 =?us-ascii?Q?qspIyMwglTwcYLgz/3PTBLx/Kyyj4Ng4qDHSYo9Dhv6NHXcHdOOMW+wIqJJU?=
 =?us-ascii?Q?whJgLF0dGw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa631479-9925-4b29-f35f-08dedd6b1974
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:19.3132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JF1KIsUqjLG8t349byr3DbWu5fCm6NUo72rdkHqT8FBAIvYIuXJeRB7tHvNeETpcZmUpZIO6AdZhM8/F2Ip+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7253

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/max77759_charger.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/max77759_charger.c b/drivers/power/supply/max77759_charger.c
index 41d810bb6744..689fc733fa3f 100644
--- a/drivers/power/supply/max77759_charger.c
+++ b/drivers/power/supply/max77759_charger.c
@@ -532,9 +532,7 @@ static int max77759_init_irqhandler(struct max77759_charger *chg)
 		ret = devm_request_threaded_irq(dev, chg->irqs[i], NULL,
 						thread_fn, 0, name, chg);
 		if (ret)
-			return dev_err_probe(dev, ret,
-					     "Unable to register irq handler for %s\n",
-					     chgr_irqs_str[i]);
+			return ret;
 	}
 
 	return 0;
-- 
2.34.1

