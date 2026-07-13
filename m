Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013018.outbound.protection.outlook.com [40.107.44.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CDA4189D9;
	Mon, 13 Jul 2026 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948316; cv=fail; b=mjmRslTe93TiYQXxRpm3NA0VEh8P0GGe6GLA2QSPETr0JOvSMQcQHf3VkObPgyEkkJ4EFTw9U11UdgAYNqZId6PlzZy5Rp8zYdvMD98U7WkmOyt5nZssH8zYa75Jp7Th/ykdTowS/Fcdpjl7ir4O1utEGuE/eu8jdwSvJmNk5Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948316; c=relaxed/simple;
	bh=i6BpKBhsr4CTB3DA6JnH/Hmk8YL6zDFptmb2VKf0EXs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ol0B5GfE6uobkn5j1p/dLwFSshJDpDp+co06ZE+lq3FzH3EUF75dP6gWLWrsvMReeVxUVbfK7QZjrt7Mc6xpMxU2lKkp4uSSOyyS8jzOXYnDY4w1fSZe+TlqXkSJdtnbiNNoQM9j57Ktcjw9jEZ1Fb9pSVIdiHzlbwgTkArWI9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=NWfbuL6d; arc=fail smtp.client-ip=40.107.44.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="NWfbuL6d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agZvk50TVasneHL6XkhHy7rrL3uFZLmlV/B6lTG44A5ytT+7u+eO83pr6HmRigdYR2AmAWOqlH5l2WezNdtyol3yduFGJL5HWJaOwSLcBgSE6S2CEtdiLjO4+8SIU5gSwFb3psot+4hMiF67SxGxqHrtVg3DRjEkRKOpCaY2B7tXTvlKOCY3+zD92FY5p8MDohcWi7is7nmHBbr9oqmKFxPU6J+GsaYDx1ezpKG2WY7HZaxKPY4lrBCdpjCoz+Qs0Sw0DNFa6JfYSpjYSda1ZWyHStLzrIft9ezUYBXGZD3HqlTERidE+0KtHWSwq2Nltfs7t3WiZ5UZBcT0CjuWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVQFPNfLVADHbt/aDLDgU/tn5PnYB97fU65K1Qa1vnE=;
 b=l8Z8Y+rt6QwUrh96/HfhfXYZFYmYFJAFCllPJmEtZmuLgYxsgJTi3aiDm2xks2rM2MtDUIftL9fziGG6bVezLEzwC+uFpr9PO/cQeaAVvshSSnTBKrsgyXWv45e19fPCLEqFv69s4x9NQFB5lBpLNjp8wa1CrCs4Ww5XS8rFxM/ihyrnale/gDDI7JaCjxzAqsxVwWXsmHtoZS2j9YyLQZRe1yOzNcI7CFRU1p4AHlB5vtLoMh3G1femXYdbukrOQhr6CWzYdFgdUG/Fdy2ZZc/YdVLH4XkaOxGBnB1J45CrYOq+eEahkbPgiFRe1Cf+Fy7iBcxqLAWZljCmIXghZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVQFPNfLVADHbt/aDLDgU/tn5PnYB97fU65K1Qa1vnE=;
 b=NWfbuL6dPnsv4kANwzytQWKzjSoYDBZdkpRdp7oNfU4vbbLezrKRuBR5SgKDs9zIx9lKPeYkmORfhZFvZXXkEzOIlhVngG8qk6bx/8qTXf022xL8R1a77n7egnxEpRH/a0hRQeRA8z0iLZ4QrHqq/ALeJjPE6QZjTlLoF1L7VfwrnJD9vPZ8OH/Fu3qydnmwV9jVuqzIU/BWUXsvg8w8HCXBT+0xMf6XNom/v6/eHfVha9s2ESSMGZyPaGJrOz4SuOGNJgO3Ek5uCtAj5lVyPcFuH3lw2I8/h1OqTdY8YXzDBwdQKRIvunWgcjytV1gZBhkeoKyGwPp+T4NfHmeXHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SI2PR06MB5316.apcprd06.prod.outlook.com (2603:1096:4:1eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 13:11:45 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 13:11:44 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Markus Mayer <mmayer@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pm@vger.kernel.org (open list:BROADCOM STB AVS CPUFREQ DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH] cpufreq: Remove redundant dev_err()
Date: Mon, 13 Jul 2026 21:11:31 +0800
Message-Id: <20260713131131.313588-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SI2PR06MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b837776-c87b-4449-b7a9-08dee0e0492f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|23010399003|38350700014|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	65GlWei3f1ucTaQ/rxGh0lNPlXOx1pqmqGg4oSJ4ry8y49u25w6LZlcy0Yb91uTDKG6OAtdHdIqYqrkokbapaGcUNdIThbwxiGNV9uOk/qNjq6CN2A01kQdlZfL4e4f0aL8nXYwlgFvqVIuqmLiTyRtnsl0+p53QompNvabWUSM8pJyIxUpADTGoTnPleOAYxUx0Y3kRjDzdjPMMDM/hS+eSjW+23co4gBM3bbMzcgMkCLAhniSM2X3Z/qIMaxvh2k7HVkEJui2sXSBTQQK3MKDXzA1QMFSSpc+KyOtlH1PxOvO/g5IdyoE0E92H0XBToVkTn3ki0q5a4lugDmA6FC1/uJf1qHwnLjyB0ppzuWULi1E69bbZWdg20248KOGsuC0GgJcfRBIGs5GX/CXjmReJeDVJOrcXcp+LEu6o5CYGZWXVbVbbxvsd1JKAU8gmSi74Fp2nHpj/r0dHIkBTENjAK4oqLCtQlzB1xG9hXKXE76+JcycBVYUgU3zk33LXAqCWW1c2TSi0SY+xz4aSOfqKwRBz7kI1Rxqhee/fCyJsKCDxINR3+cihkfHZvoHv/pyd/51J38vQ5B57hxQY6ioTu2Bnyw1iVvalhfThd3oeRBPb/+OfaN7YF8WBTpmtJzzIilc6gu58xwISC+9bhGjoHiF2S9N1puUn5xUVPjexEG2oGdx6Zn6ZBsEs3/Saw5zW8h/dLieAvyldV8E6Ev2IhuXfaMH0QKugmGbB+Pg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(23010399003)(38350700014)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8XCWRLh+L/XEeC3hnTQHahhtlAplloqZ1kWLqzlxJTNKPIg543Vj6BrCiITh?=
 =?us-ascii?Q?BOBRK7HmVATbbo5R9CnK6ibXs36XyEZsu2jAOHRdFkV+DY0HaZdHkTP/eWY0?=
 =?us-ascii?Q?zMjL0iRg4bDDW38zaCodHchQfQvxdyf7PCOeddHfAxaIWe1vhOSOBYv0Bn6W?=
 =?us-ascii?Q?RpoVjh6nd1mY/hNaJFsbkMqh/kWVq8esyshC7MfSm/ik0aMRnj97CvEnNHNh?=
 =?us-ascii?Q?ucVAM67DqC6KEsOvkh0xBL4rYjH2PZXnQgG2F29CIOIrvEviDPdYAoSp5E/t?=
 =?us-ascii?Q?VUfd9V8HcVXV+MSra9qN5Ik4cCE6iDKb0wutUNU6GyJWyJCoHDp0c3JXbMq0?=
 =?us-ascii?Q?ueWeydmAQk15i70PYuWlYXPt7YK5c46F4QdAM569wxQsALDg0qTc/9Ud4Gxg?=
 =?us-ascii?Q?se+8B0O1TCrOx0dWphBsGozbLWu4u0EyFqUr/w2pv8mXLiS4BzfX5+zSh8tT?=
 =?us-ascii?Q?GOmm+HuKi+AHoU4hPqFrsxTLtW+dZsZuMiA0xjFZWWqIVruNEf8ZSPWPXM+4?=
 =?us-ascii?Q?3jQZ7OvcKUSjYb9jNkPbcYmGrUUDRoe6199a5cpGwB6X0Aj6lWU6f0DhjfVC?=
 =?us-ascii?Q?3UQfbwqQ5TCPCwNMxWAtdxWzpZWE4ddl2P7KUGSwMTa9e9V7J1pGBHXWI4S5?=
 =?us-ascii?Q?4VeNOefraiNhSY7UrmZdLZN/8nPrLVcOSfIcNJWhF5Vm6Q8givcJgkzf2Zr8?=
 =?us-ascii?Q?VGRYcbKhykGxN3IoXQT2CAWChQ+IP8RENZdciSVR026Bk9whqlDoLTcwdt3H?=
 =?us-ascii?Q?sN399ZejZBDBkTfJp7R3XPoRjyZPBQ3K1yC16JGOZmm1Iy10Yk6PcdL9nyD3?=
 =?us-ascii?Q?UqGDUXUPk0vIfMe8IfdhDn8hkVhtqpPpMQM+jC2B++3c9MENcsGHuTzG31YY?=
 =?us-ascii?Q?vH4KK5bWJQB/pW/HuU6KPJZmR4W2Ii5CuF1TWfZL9GmS3hxXpE/oNTHTeLIg?=
 =?us-ascii?Q?LirLH0N3J6L55CEjzfAEl7UU734WMunVOzRpeF8ZRghILGgwHb4lNu47ZP0B?=
 =?us-ascii?Q?2wV8WnoG4b5cMU4/P9hjiqcn1AmDQVzjGJ4MRCJSr5iUAi9a5+ijt7Xw95e1?=
 =?us-ascii?Q?rzhTIXckT5X72RmF39J72eu0fg/Do/m4ETnQICTOvot3dH0J74HCXI1eg+u2?=
 =?us-ascii?Q?lWTQ0eckNvwUN58z67Jf+e3VCdsm+AIhKG55MWaGdMNoeFDkvAsPEcgkv5pX?=
 =?us-ascii?Q?PD/mY0MDeRuPJMT/9OY/T7leMliCKrgrwvQhRDgyfPGB/qqg+IYLuZ+VcHF0?=
 =?us-ascii?Q?EeeaVMIvfFpgEsLiOSiSa57fuEEJiQtAYt+FTRp/4Q8uhWzUSvKhsX7Gp64K?=
 =?us-ascii?Q?zHDtFRlzMN6kikjGMUx6XUpHX1HjY8hvc/01iuKxd6aEowfT4anlgzt+vUH7?=
 =?us-ascii?Q?mjGY9xkGW9u05Vw3NX0kuMiL5FbAKpzsF+Vhv75q9nyDYHnjHvJ4gxujbOez?=
 =?us-ascii?Q?7iKG17YtizxhfNALx7MBxr4da/l/U6Ne337Ls+8cBqGTrEG46xBE/mGxZ/d1?=
 =?us-ascii?Q?h8bUhMdt8mw82ZOPPuIykx638JthHzdcPyV6RpKTwDZH+WIjcWmwl85YAUyQ?=
 =?us-ascii?Q?HhxTuNXTIR2UqsZ0GAWWU72ZkDYzWOcc4l5fQ19GClQa8VxdO4Xqs4dDQPxx?=
 =?us-ascii?Q?RQOMqMSHqdyLt7AkqwRsQRrlq2jzRc4lRpU+yahH43osrFkiqbGvfPMr6XlY?=
 =?us-ascii?Q?Zt6UPpLj+XIbh+Aud15cyrKXWiW+m2zbWVQqbKJ3jgc4u0Vi2DMxvaoBcecE?=
 =?us-ascii?Q?72BI247FpA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b837776-c87b-4449-b7a9-08dee0e0492f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 13:11:44.3488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqoFGnBVa6jB77p/eE2BvrU19N1QXDOnb1/1hSv2bvtmX/AtTaI67wYU4OBu6Z+2qzCb37vSIT04nJJhzHO7zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5316

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 71450cca8e9f..7d902856ac01 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -584,11 +584,8 @@ static int brcm_avs_prepare_init(struct platform_device *pdev)
 	ret = devm_request_irq(dev, priv->host_irq, irq_handler,
 			       IRQF_TRIGGER_RISING,
 			       BRCM_AVS_HOST_INTR, priv);
-	if (ret && priv->host_irq >= 0) {
-		dev_err(dev, "IRQ request failed: %s (%d) -- %d\n",
-			BRCM_AVS_HOST_INTR, priv->host_irq, ret);
+	if (ret && priv->host_irq >= 0)
 		goto unmap_intr_base;
-	}
 
 	if (brcm_avs_is_firmware_loaded(priv))
 		return 0;
-- 
2.34.1

