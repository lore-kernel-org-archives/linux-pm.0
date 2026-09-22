Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010054.outbound.protection.outlook.com [52.101.228.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB253ED5A1;
	Tue, 22 Sep 2026 04:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051313; cv=fail; b=Ek50qgkW7ACH8YNPWIK7+56esHl8hDQYrW2W1fj0xVGTiuYh4AofgM6VZzDVRZB0HIrvG4kXtwA6brCPVvA3kmGBNdBUMmwOvm5IdCGitV3PpxAvyo2j/XlE7cRZDn6XHrHuPvmd98sgQC+0G7uJ17Z+NgKNOrgHnxdfeqGVBWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051313; c=relaxed/simple;
	bh=rWuX1v+1Btjymp+G1JWCUTeDaVDhlFPqFLT8fR3q0ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LeTb8Aof/kpfSfFi1x7wmGBeoXLCzLCuZ6E43RWAhDgyFzJ+fk0CUbXcAEEhtuQZ4M6qngLDxObyLmfI0kIId5WE6RiPWbWo1Xn59j8ycqEopOqJTzZOLZC2bkKp4ZeBLQ5TMEH66nNKco1U6bejHbaP6YPlICH3MUYhYS17RZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=woPbtYLj; arc=fail smtp.client-ip=52.101.228.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="woPbtYLj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfTX3qjJknGE8UdjLZXWJS5ucQS+e9AUrlSDJlPkYp0mdxL86/1r4MZnZEbUoWcAyWV9RSn7ENJNum08DkP/fvseNA3gGceuJkBsZxDq0WwRnW5A7iFxN7pd+/Ukdp9uqAGbaoXaayFdd7JOuORMah6PRNwzyzKzDt2Vv+4kVYoTwxJRxWX4oqXnCWC/7n73Io3HI0OvmhVTdFgfWoBQxLPuvbAkQCsASiOcptHnoJpHwvhTiQnzzx8n5gYZk7KqI9Xi9j1XCMXaoAmI7UG7OwqqvaNTXnQcHPExbujhH+DxYgWhbp9iEjau4/L+PI/RUODOow5qEEGnVb+FqiOcYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xd/oSPpEpPyYR6qP4fYSqGyInGDqXsWcqkzHSYhhlVs=;
 b=EGgZzmrACaL3W2X2a/w+tXa1+Ou1MsKKL/bkNL3akjxOZcALKrEIF82cnxQx2H0D7AK9RuwSyHjNm/XK0auj7Zcpy90T+pNA3DiWGj6emVKsYeBiKzbDsEQoYMotXHi3GWginde2RETqe/8x0FiaJ5n3nq8GTTmYsZwiXQWW1e/A6V2WoMrKEgPT5OpEM3fZgUQXMn19YI+O+KP+hMLe1QFZFs0PdzJNpAuRFTx2DFgGst5zJ8nR5r7f8aInYyklgsrv/oFk/3AuYDwJ77nv8ovz4J1KZTuLLvElxY99W/azRyFrnnt/IJ5KgiRTsQ3h49JF3LvpKFgAUQZcBWODyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xd/oSPpEpPyYR6qP4fYSqGyInGDqXsWcqkzHSYhhlVs=;
 b=woPbtYLjInMjgO9tokmRGZzpDyV1bLdEz0kju3Zk8C8btLYVhYdUtytLvZT0RGLa0dBjiw1myH3YCWMjUEsv5TReNJ9abIT9tkoTTDhiIKMxF4bMqZ6+NosNqOfBT63xFivQNIoW2Z7NYmiONIBwo1aV9d5LSK89rZJ2o/411c0=
Received: from OSTP286CA0101.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:219::17)
 by OS3PR01MB8602.jpnprd01.prod.outlook.com (2603:1096:604:19c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Tue, 22 Sep
 2026 04:28:27 +0000
Received: from OS1PEPF0000D216.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:219:cafe::6c) by OSTP286CA0101.outlook.office365.com
 (2603:1096:604:219::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Tue,
 22 Sep 2026 04:28:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D216.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 04:28:26 +0000
Received: from biju-VirtualBox.adwin.renesas.com (ree-0065939.adwin.renesas.com [10.226.92.1])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 8F690300028A;
	Tue, 22 Sep 2026 13:28:16 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH v3 7/8] iio: adc: rzg2l_adc: Add RZ/G3L ADC support for TSU
Date: Tue, 22 Sep 2026 05:26:59 +0100
Message-ID: <20260922042707.116378-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922042707.116378-1-biju.das.jz@bp.renesas.com>
References: <20260922042707.116378-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D216:EE_|OS3PR01MB8602:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9ffb48dd-0f55-41af-548b-08df1861f23a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|82310400026|7416014|376014|56012099006|3023799007|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/IPYacYIYDAuW1HXyETp1M3U+ehv+ooPlW/pgAd2bAGxpVpa6uzNSfFYZYSqKthgYOnFRhxRZuAnWasxWjwrjFgjE5Q5uWy0GugpGcmVoil0vBnjLtx7MV5T/ZQbsua5WWuLboDtfcKgvDTQLrEsj0de1daCg89yk1OixcAcThUzy+3Y7bS/WI8ohyA/i2OnW7LxNaHGFlpUoho7Yb1VWBpyUUVzz3mkeTN7vFSzfNEIKcExv6gBii2F8jAN19i894RqwwOhOFoyonUHrF2Xg1p3pQMPwjhULm1g4fTKF0Tlgq2g0KJ+GQ7HSvg6r22sDwZ7lcrcr4PkG+2Sz6vwZQX69pMCnn2L80xBdR342uYatCckXHwPTogb4rxzf0NBmSza30kaE3hkt7sLsWR3S9qgZlo8YvcynqgcdyZNz68g7A98KfrzJOZuhJDKM/867/elBCdvvsbnNPpiJ2HfjxYbNMEqbY5ScsdNlMt6GjPAdXEE1cQi2j6vdg/a6NDZT3QT0MxHa6y0Z9rLOPb3cW73oHqxLxs4aGWnNbcnJq+HWgdp0hokswy0g6FYNhHhEZ5pI9/DhWroNFCHrwLcFZi5QmRmbBJjjCz9ldYxdpJAG7TozOHcSKr590LRfA9CXmBzcMrTZp5mD7jQShfy4yu/zWDN+3qoFAoGw4+Nl0bM+wU+KqVl84NCLLn76BRLUlnCHshhWx+jjM3m0kd+sA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(7416014)(376014)(56012099006)(3023799007)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yNuTjwwOubIL88GFgByUfqnoXpWMkBtmLeY/mD8fn6yUcoqZ0kkBtQyxeWRswrQuD5gxB3XWPKXAHJqkgILfAAEmtub3hApWmABaVnpkUekQOyB4OAsZ3vYMFloQbZsKFfrXMmZev9+jNPa8clIF2y+Dy4MxUUfJGoUrOp+jGjZNLp38MiARmIrOHUCfZi7PkZfV9r4ycnd+mSv22IIU2Xv+827nJSN+0M6aPRITH38lHrr4dC8uHbGOy99OORZsdPh9xP81+SNfbg5nowkIqd/JNf66FG/rmcXyrGSKgUlxVUFhFfDWD9yZsAaLwQHTzy13qHRK3kUGPc4JVOFGiVakUFKnJcBFtlH6fAbXR9ufBFHRNGVGtC0l97sIocHzq/dnWY43YzpkUZ8+fjzTVSdUPjm4xOioHXSGc0EgGbJQyqsdarvkuH/w1DFZjYaJ
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 04:28:26.4079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ffb48dd-0f55-41af-548b-08df1861f23a
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D216.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8602

Add renesas,r9a08g046-adc1 compatible string and its hardware
parameters for the ADC1 IP on RZ/G3L, which is dedicated to
the on-chip TSU (thermal sensor unit).

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No Change.
v1->v2:
 * No Change.
---
 drivers/iio/adc/rzg2l_adc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index aaf7e2ceff8a..c892e355b739 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -500,8 +500,17 @@ static const struct rzg2l_adc_hw_params rzg3s_hw_params = {
 	.adint_inten_mask = GENMASK(11, 0),
 };
 
+static const struct rzg2l_adc_hw_params rzg3l_adc1_hw_params = {
+	.max_channels = 9,
+	.default_adcmp = 0x1d,
+	.default_adsmp = { 0x7f, 0xff },
+	.adsmp_mask = GENMASK(7, 0),
+	.adint_inten_mask = BIT(8),
+};
+
 static const struct of_device_id rzg2l_adc_match[] = {
 	{ .compatible = "renesas,r9a08g045-adc", .data = &rzg3s_hw_params },
+	{ .compatible = "renesas,r9a08g046-adc1", .data = &rzg3l_adc1_hw_params },
 	{ .compatible = "renesas,rzg2l-adc", .data = &rzg2l_hw_params },
 	{ }
 };
-- 
2.43.0

