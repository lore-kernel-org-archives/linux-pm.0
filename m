Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010024.outbound.protection.outlook.com [52.101.228.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6DF466AE6;
	Wed, 16 Sep 2026 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560040; cv=fail; b=ge1FJLKmOyU/hdIB2oVMfWHVYyxGwNbQcpjkfTjjRhRa1Y9jEQSKg6K1fbzQ8eBx6xjFAolBV9e/BbSt3Tr+KKMFWsgMws6/CJuJu3vSGcK8rQUj3aaQ3ptaqMDZFYBNqckZItNRDMDNvSAW8p4aHdMBqqS5vKyEIYCq6dBX6sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560040; c=relaxed/simple;
	bh=Ovyb+DfyQNJbkyETx6zbmd7D4ZP1ApeLS16Vl0m2nSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VnNfasgO7bqnljohCBwirk89nLceLS4IfKqc0PpYEErzH5Tnn2CVpVUYm0h10WvFAeECSNU2Vu9PeDH2SxUKqdVjfRBr03t9dtyLGjGx+EIS35lAjPBdKXhLh1gF2Fx/TUQjdZ8ElgzKrI3xKEJHi+13QGzNsOcVNg28TEKUf3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=iDYNrGtP; arc=fail smtp.client-ip=52.101.228.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="iDYNrGtP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ft4OJ4lPVQCwMMhm8GDks4i+foy214rEeajFZVGadsDNKjgWj+dxCIMp+cGpdFrr5QDdbql3+SX8oDo7bZVd7PmMAKxn4afX7O0H+UDyUzUxoyU7fWf3jGPGpDMM37E86P5lUPuQ9ZAcwPs2a8WOq0dtFAfbEvMN9fxQx0oS0ceBzXs/VQQQvE52cso5CoHSsgoo6GiMfSwBwHXQpKkbaDe2oD6vPFs8ErBjU4mDvR3vNselsFTB/4v60wjvgROlAlUoic9q7nlX0dNu+I6J/2i7stALyp7QSrrvdTirnVeO8jkFIO3Hg4tsDHNkinEkQ+0I4lvgEPEG73neI+rCDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1+sG1ljEVivCrW6hJu07pWxh8+z0iiGfqYlqOe2pEY=;
 b=QVgDPtrEw6gzF/gycxoVYNvkaL+lcfKdCOFRxnluew38o2KXHJlEjkEbPAqGLV5NcvE8L+z6wnz5WfaR9hPou+9AceMuIqBbyKcuKTcQfI1Wd8zkWsEoskj/zKJunLsEQiCrvLYjJG0o6PY0wfFA9WMMl/gq+YZXIMhrXn2+rWvE6G7zbgmVpgSA1CT6rOmA6rRM8l+ezbGoS1a67iwppOKtkpvpBUK/aB/f1xaIRYqKIampDm56dVAa7gab5jm1C/R1BDlYCbCekx/gwXTMWxGwcny7UYnUuCFAhqVG3KTcu5xbc/Zz8gsjEHf+JhE8h4Gyyth35t/f861sWb90mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=arm.com smtp.mailfrom=renesas.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=renesas.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1+sG1ljEVivCrW6hJu07pWxh8+z0iiGfqYlqOe2pEY=;
 b=iDYNrGtPVAgrGfDI+Irv7MhZw6cDZU7y88X38HiMiLYXTTG6Fb8Hc5S0aubGtrdmmua9cyO5I1z2byfY6AlyYp4qn3HBZA+frHL7B+tm+x4jrxyRoWVuD0Ve2v+wTHES6V5sBhTwz+RBV8Cfh1b9D7pMnm1n8T4gq6neWWWf19g=
Received: from TY4PR01CA0061.jpnprd01.prod.outlook.com (2603:1096:405:370::16)
 by OS3PR01MB6888.jpnprd01.prod.outlook.com (2603:1096:604:117::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 12:00:30 +0000
Received: from TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:370:cafe::a7) by TY4PR01CA0061.outlook.office365.com
 (2603:1096:405:370::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 12:00:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005023.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Wed, 16 Sep 2026 12:00:29 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.205])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id F3CB73000442;
	Wed, 16 Sep 2026 21:00:26 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: john.madieu.xa@bp.renesas.com,
	rafael@kernel.org,
	daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Subject: [PATCH 1/5] thermal: renesas: rzg3e: Fix signed integer overflow in temp_to_code()
Date: Wed, 16 Sep 2026 11:59:59 +0000
Message-ID: <20260916120003.87018-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916120003.87018-1-ovidiu.panait.rb@renesas.com>
References: <20260916120003.87018-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005023:EE_|OS3PR01MB6888:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2266ad7b-cc1a-4b62-bf1e-08df13ea1a7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	ekvDC9skNoZBLJvHHALXdaGgK1al6MDNydQB6P9xOtVGn+uDF1qXbH9iKqytlVfQhJay3IF5c0njEk7F7HcDZd+joSbm2LKxbQnKthvkLLvMZwSpX46LkP1GMS4hbiWztizGFmN0Ki8K4PWRf/TH0x9K4Vjc6Gfp31rBte4DDpNuFAjf5DMg2QMy/pjmnjm6VzeVLVUvNGBiFfqUYclTqeDrcALVmMCcL4RfDqHvlOXOdDqxxTOr/97mjWQt9TRuY4itHDnp+g4d+c8Gh1q0Fx5vMCj8gOt6bEO4bbSYbd7LI83s6kdncYtStIujFzvcP9CdK3DkFWzAi1vyhWrl4e4YqlP5aoR5qG3CZ8WXTbpy8qXU5m3Qke++2TbkB5xUXrLr/qzbpn/NkRDyphFUHOcKhr5pDT420xy41ceeALAzdDmBigp43jHngIClTaSgufUa0v2fL4CPFtZI9fRkaCo9YrFNCSj7Z6HMEBKuwzTiof+9U914ZyLzRQr7wGBFnbeVFhdg/0y7pQQJWq9NzpiHxb4U8kapH7r/ytwE9AMueeK2ZRP2uWRo9o9n7NXlSeQgFTDKTzc508zd577g0WHh/ZkTP5oRnHon0gaLC5U7fUtj4Aa8Kwe6BP6AwGjeMVBBOi0peUxVOpE75fJffCdX1IHCK9vXR6vlWUuWP0OPG2fh57rDpfSQuQOc7GDaIHv6EK3TbTewCHclJHqSfw==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LPl7LCwqiV4hv8D4RMU9ckQB2mrgqnI8tyxjEtzLeX6SPniItOe8/ip4bjTQw2W0woc22pE7MS0vuOnhXh7yzyVHMZ8k8QWizlUfohz0MGLCFhvvUT3mj6F+X7wLC8/XYxWk47n5q89J5VWupNCEjOtCik1duCPB5K5zpkJvo9ckxZ19vEJ4QV6wR0NnNnDp6NBcuncb7kcf2sqUb/Q5+7tk0gKZVr3zx75A5srZQKbmT6QGbD2KOZ8kY/2lltka3+rjdGmdZlIj/xiHQ9Wzop5Q4zFCjFCZBuCHmCjrXKUyJR0kktO/4xvIoCB8EjwhSN5CWywm84J1k/dxtAp8DSp42r//7Sl/1EduUqs3+w+zK7I6BD/FmWNNZhMwqAXoAQ6ZhV0YEuUPKkbtoD9SDe0kFKfUHsipKRxjjim0UiMVWuSWOhUI5IQeI5a6k8yU
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 12:00:29.7186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2266ad7b-cc1a-4b62-bf1e-08df13ea1a7e
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6888

The thermal core passes -INT_MAX/INT_MAX as low/high trip points, which
the driver then converts to code values for programming the registers:

numerator = (temp_mc - info->temp_d_mc) * (priv->trmval1 - priv->trmval0);

Although 'numerator' is defined as s64, the arithmetic is performed as int.
Because of this, the multiplication overflows for -INT_MAX and, because
temp_d_mc is negative, the subtraction overflows for INT_MAX.

To fix this, cast the temperature to s64, so that the arithmetic is
performed as s64.

Fixes: dc67521c20b7 ("thermal/drivers/renesas/rzg3e: Fix add thermal driver for the Renesas RZ/G3E SoC")
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/thermal/renesas/rzg3e_thermal.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesas/rzg3e_thermal.c
index c44f5b8858d0..4acee4eaff05 100644
--- a/drivers/thermal/renesas/rzg3e_thermal.c
+++ b/drivers/thermal/renesas/rzg3e_thermal.c
@@ -194,7 +194,12 @@ static u16 rzg3e_thermal_temp_to_code(struct rzg3e_thermal_priv *priv, int temp_
 	s64 numerator, denominator;
 	s64 code;
 
-	numerator = (temp_mc - info->temp_d_mc) * (priv->trmval1 - priv->trmval0);
+	/*
+	 * Perform the arithmetic in 64 bits so that it cannot overflow for
+	 * -INT_MAX/INT_MAX values passed from the thermal core or when
+	 * userspace writes arbitrary trip point temperatures.
+	 */
+	numerator = ((s64)temp_mc - info->temp_d_mc) * (priv->trmval1 - priv->trmval0);
 	denominator = info->temp_e_mc - info->temp_d_mc;
 
 	code = div64_s64(numerator, denominator) + priv->trmval0;
-- 
2.34.1

