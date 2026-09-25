Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011053.outbound.protection.outlook.com [40.107.74.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430B0255F28;
	Fri, 25 Sep 2026 06:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790317021; cv=fail; b=t2emRO4sUnbBxHw6uCEhIQu19ZBbxeWoGOKYAeQ59Ck3qIlBhpbe/dJhSp96l6SALhSPqg/BjbBqD7tUultJdpXnmnwStLMI6zbJ+EXC2ueQQVjfSghenpvjCqZ6W9jn6vE+Bz2p542i77X92XscKZkanl2naq/LpNble+lVALI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790317021; c=relaxed/simple;
	bh=+jMjuF2Nlc/I/fXxkwpuKLzRgu9Y2TFX9gmHXo4HTm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s5n0wBJuyHUoPOGCPmS5HkfaQoqZSSdS6fHUouPA4P0uqcOk8PiE7GVSOKtqci4JfVgWhcP9xukr0eRvOvRvBuA8fEXRZfan4UtlzwNXKlubpD8WZ6D5pHfn/7kdkRAkyt8OqWYtSOZ2rSI24V1563S62SxHcY/s85h7jZnt2HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=wEo7ElgF; arc=fail smtp.client-ip=40.107.74.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="wEo7ElgF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAT4E3aoV15F0eP6w89w04cYxXkNWfExrl+OaywMQzWHtUQbG2zAe+taMaNF4U+xYB2f/xgog37htkl52ihX1u8GzzHxeNSUCB5b76A92gbIAIR0gW6a9LMzFkSy989D5zEtnQSEI5OllvgwE0HbxEYacJKzX+AFOpVd3tWJ9i/bvaGMnuir8F1l1JhwRoE/KWB5L4LI5q74KMuxpGDKTnzm0hLyb2aw2xxv+NwIHk4XdEjWy+3nRFGFAcFb3McHP1V8KfZA8m5kghwZYwLhegeWGSZLXd7Gg1bopBmbxI6vPcRMHhMlbwKkxLTr5VJoNGhlWorpr0bTXdPsSBcxhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eW1D9oERvEDL+re+ncgsEpQ9ImyPZ8teUJJgvtHhCak=;
 b=WVPHVX59W4fpdq2MMdtLaL2FD9dgAXD3da0CkevgEvyqsIsEV57JEksSSr7fs3bd7thHjKXQRZbV0gG256rQwATauKLJee2KnmBt6kD75PPHbKpeRJoKbQA+gTVTYUA6HSjnQAl8v6+lckISd11q5FBZCjyA7IRAmeKQGoyaHtC+aN3uvze5Wd7OlPTrNmKbhBfHKq/M3BU6lAuIweAYh5HIolrdnHSlflbsAKueA2RkC6pvHXlPtwDYy6y7s0yYc5CVsG7m2gzcPrrOPz8M6BRCEkr6KI9OhxYK1dIROJzzP+cJzn0H+63j0dNI1pNkUTgYb4iSLsHRMJv4834E5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=arm.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eW1D9oERvEDL+re+ncgsEpQ9ImyPZ8teUJJgvtHhCak=;
 b=wEo7ElgFAHM4BcizGIHsEE+zwuR3HI2LUup6/Suw6p/RGzp8naBzxhXLfpJh4VllHwzLnbBHWcijsgAX1eSJ0KhI/gA5SxBBQ3wcdaAMOhWu9ilzt+rispu5JOyuNlDXugKrdsBFlUrdFN+5DyXIVCMLwV+9MxcP+8U+fGKyx04=
Received: from OS7PR01CA0087.jpnprd01.prod.outlook.com (2603:1096:604:25b::10)
 by OS7PR01MB13671.jpnprd01.prod.outlook.com (2603:1096:604:35a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 06:16:57 +0000
Received: from OS1PEPF0000D210.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:25b:cafe::7f) by OS7PR01CA0087.outlook.office365.com
 (2603:1096:604:25b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 06:16:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D210.mail.protection.outlook.com (10.167.240.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 25 Sep 2026 06:16:57 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.92.177])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id EB23F3000252;
	Fri, 25 Sep 2026 15:16:49 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 3/7] thermal/drivers/renesas/rzg3s: Add RZ/G3L TSU support
Date: Fri, 25 Sep 2026 07:16:01 +0100
Message-ID: <20260925061617.127349-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925061617.127349-1-biju.das.jz@bp.renesas.com>
References: <20260925061617.127349-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D210:EE_|OS7PR01MB13671:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ee669081-2e3e-43f0-dfb9-08df1acc9a25
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|7416014|376014|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WbqpztaAtFd4wdS3dgwVHgmmSMUAlaauOGgW5pJ16T+OAhh2VHbAN50IjuQ81fkN1FsQwQIlVGOH2+wgSxrZ7pNwDb20fsM7eZyyloZz8z4lCT/0u7SPY8o7OucqHORVkEuEkHzTog0kdHdZa+cOxPImDgiMppedojVRCo+ts0wjdhQVh3HcI50C+cmAOn/s0oeokyhhvvN2Q0IWRhmpTjlJmzqxQzPf0CTjyQKLmdg4UeXODrt2++wCbuo3rtQ/VvC36ihnw1oh0RJLoueWGdORXa05vyya/WanVjNbXe8ZXVJ59ktIvOJ/vFKm0RooikkZ0nMqmVkVTIqiD+uNQSf7WTi6UHnUzI/dTL2HBIcVn3IjBYDm6xTodMs7P6J+Q68jqMtRsxsEiG1SsA2/O9hppyB6IdmZ1GB3PrCrQh0/1h3dnoNagnxJ9J2uh16ZxC18VLUqVmeMAIXaHYOgc49Vr4mGdDV2Mu+4xnDeQ1ZXcHxKaV+mFQyjCESGtMHQzS+KSgF4LvhQHnvht6+NE7dvZZgRbuU4mKDUoA/cxoAUHAlyiwkPcEpbQ4782CW8d8mkTul0CxpKaQ4WxLrGKh4FjQ23JhjSvz30Q6H8tkP5m8x5cnLcbh1+Ev54u3b46bz42kfeJ2Nn20ErOxSz5bYrBJ4cAkz6SdQYt/vZqUpSa9AAIyOmykFZAmMI2qgu
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(7416014)(376014)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o1qsd5hrc55k6jMXfxLf0K/i0p9ARA2VJeoZZ2x2j84ECKoR/McFWGE9q9Zy0QwXtMmErVrS+k14cvMxOJdVVuLhetNYbFLPb8A9K5zc/Ugs8iz4Vm/2e6heuYRQh/hlGtSKc4IsUk4Xvyg9QuakaFt8sbqxPFMIt4OEEcZDW8i/S2eDuQSM9VEVo8lg7D26fsR3RqVI50Pa6xmznISD2VEtP5PtGoIcW4YSmMVSLEUm327j/w+Pku4ReNXyn3JDc2uM2DAGOMiEyb33ceAWepVchYwMlmHeXO5NwDw95D1zIncFpYL84ZaFmDwAgPa7JOgB4j+x8kLeWrJJguT0MB118dwEShj0HT+AH2BVdLx/ohCBTnaANgjBLhnTiS5m6PAidNjVgKLUKeX9MHGt8RSX+d0FB8GLkYrtHi3HIt9newo1hfDn144ilwR3FlrA
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 06:16:57.1109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee669081-2e3e-43f0-dfb9-08df1acc9a25
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D210.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13671

Add the renesas,r9a08g046-tsu compatible string and its default
(software) calibration constants for RZ/G3L, used when FUSE
calibration values are missing.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * No change.
v2->v3:
 * No change.
v1->v2:
 * No change.
---
 drivers/thermal/renesas/rzg3s_thermal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/renesas/rzg3s_thermal.c b/drivers/thermal/renesas/rzg3s_thermal.c
index 146b73a1b751..a8716da7fcd2 100644
--- a/drivers/thermal/renesas/rzg3s_thermal.c
+++ b/drivers/thermal/renesas/rzg3s_thermal.c
@@ -265,8 +265,14 @@ static const struct rzg3s_thermal_info rzg3s_info = {
 	.calib1 = 751,
 };
 
+static const struct rzg3s_thermal_info rzg3l_info = {
+	.calib0 = 1322,
+	.calib1 = 772,
+};
+
 static const struct of_device_id rzg3s_thermal_dt_ids[] = {
 	{ .compatible = "renesas,r9a08g045-tsu", .data = &rzg3s_info },
+	{ .compatible = "renesas,r9a08g046-tsu", .data = &rzg3l_info },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzg3s_thermal_dt_ids);
-- 
2.43.0

