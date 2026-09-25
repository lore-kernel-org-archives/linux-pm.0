Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010059.outbound.protection.outlook.com [52.101.229.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C833D9552;
	Fri, 25 Sep 2026 06:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790317008; cv=fail; b=h0ZF5SrrKy2h4a0Rb11TL1vFZhd2JE/upTFkvV43o3jZj/p/+rvnwlF8Ki/kCvysVnpzm0EANf86CvaAbV57u6hhxKAmGt6B8Per3GgciNmSjm0rp1LuKC9HltqOQPMkax6TWJ6RVYE5TP2pGH294qWBPC0g3l0FwziHuaV9WOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790317008; c=relaxed/simple;
	bh=q4OQQx/kcSeb8tOx0lTr9zWvdY6UbsCKi/G3DbDtZ9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6XdTX/NiwBzpK0A38MO8wzCmHbXHI9sDCTtyu/Ev8fYjI9fc5JLRxZ34wfCEYRY9/4inloqzSZLKurpZ/gQopQO2UMQa8H7DgZ0wG6UTWybUon2n12CAoFMv+1zyO/yWK8oThCgBNUUEwAciPEUlttdMrD+55O1qoED7guGUVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=BMLw8h2d; arc=fail smtp.client-ip=52.101.229.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="BMLw8h2d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqA4d1hGSSqB56NADa+dz25sUSbBTmaQgy9bXf5P6qspGImdooODa49yeFMzqYpl09Gy+Sx368HshA4Pk57NTOHGZB0O8sKaFdQEUdHi/X1FpuFcCpuYMRKXMuEWtS3lEortvjml3vG3GSA4B8D7+DrltWzYV1XlugKGYt8aQYsvHtIWdo9Y2Asa40zc+/WLqg4f6m1LKMjFtnkpsqpALtaC1vFLLNsaNX2VJELVrtL94ghHe3+Yq+GooG+59Tylp5zr6+zwLmaioSgLgTulJC65ib7+OFBKr00R7eiSsNfuF6GjyL4bsi0i7jZvbKVP3FfxcTXZsCUFdePqepEOig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RN0NOrrfSf5TVBfuh/VdGBWo3LlvAz0+WltKAaDynRg=;
 b=CuXcWVgaD2c0mP8jAywGlzPxDZ8qgVpSRnv5GfYFDiRBwf+Z+oQyCL7k5dfsO6CSe+UiUdoI3HuAbBlGr0j8uJzIMADBJPcym1/imHwt3DtrfKtK1D1c93NksabYNPLmh1tumRhrAlSpHy/0d4wSoxH48hfQABinE/UNmpdpdDrndmmwaADQk5KyGmeSnaDMcA6VxfwBUb1SVbMHCvI150qqK0bhoA+y72rnYDMUPtfrNYTBIHpDpW/JDZkyc8KRSp2drPrpCN6+jNVvsqjMZv1MCJNqCFWhkgPiblpkCsWBjBVD8fAsEKtSkIPv4zLhjVtVkyvBDl1lJk02O1HqyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=arm.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RN0NOrrfSf5TVBfuh/VdGBWo3LlvAz0+WltKAaDynRg=;
 b=BMLw8h2dvYC3x4VdwWk4kV0Uii4pxtNUk8LuMjYfoOTE7iQuYHJ9PMOOPQNfi+bPdKArmlELcT7VCD0eDob4XXjqfGFF3UL20JmDoybMXxMmYEnBXA3fxnjCGqcrWAqkAveAsnyrC2OLW1T02XHMkbVB30LlkSw5FCdLMlMbDwg=
Received: from OS3P301CA0007.JPNP301.PROD.OUTLOOK.COM (2603:1096:604:21d::14)
 by TYCPR01MB9601.jpnprd01.prod.outlook.com (2603:1096:400:192::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Fri, 25 Sep
 2026 06:16:41 +0000
Received: from OS1PEPF0000D20F.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:21d:cafe::2d) by OS3P301CA0007.outlook.office365.com
 (2603:1096:604:21d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 06:16:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20F.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 25 Sep 2026 06:16:40 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.92.177])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 63DD83000257;
	Fri, 25 Sep 2026 15:16:30 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v4 1/7] dt-bindings: thermal: r9a08g045-tsu: Document RZ/G3L TSU
Date: Fri, 25 Sep 2026 07:15:59 +0100
Message-ID: <20260925061617.127349-2-biju.das.jz@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20F:EE_|TYCPR01MB9601:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ceccdcca-bb26-4aec-9550-08df1acc9079
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DoLJ8AOmIollUD5SE2+94MeRuXK3bib8U4+NZrtHetrYzaWtH7gumwP+85TdMNptnh21NzFLEzItB2CFx7OgrUaxCmb1cGnmITj6huuklUPlKosGvE+a/bTgWlYSEKtFU2+m4FlJ+CtEZxZHCiGWLwGOcVeM/TQCkKkpoe3CtZ1W9i6YpB01Uv6juWtI6w5OaULkvJuGAF1BUh2jlnKGCCH2n6FhQhhb6cqn9S2WxA1hWYdSk6U2mfpT8jy5xNwsqPLJFyjT2++OTI+RAyI1PDNGZFTox5Rc4rHEDZUG47FIoH76tik1ukaSOxP9s4FPZEY2TSvlXlfziS0lz8QqXIUT6IbLmFhnHjDMo1X6z2we0FQPCLR1ih/oHMzpGDjlrUPvWnYeqXHajKlaaXSKQwTOsXEeCEnaSvBVKMIZMB2xuczNmAXHTpfVEizGTuMl2wGzTGcZsus7Cuz7lQ9ERbMq4RAoxneAucMSyo+FVw0FO9jac+pceiCWYcQuYbZhE9/ozaq/IdJ5qcoLze5oOe8UlinDdU/nxF1MglzNLCsFAa2RnQ4GqxU17dKUqDXeVIcVjK/126//Ku78CkpVWz2/vZA0yRX03We0o7Uq9G47Rhl9qZhtIjMVgqkFfaI1rZzprkS/730UFKuMeDhh5oD6tUF5RaLGPDBISBWmHgmgoYsJDjJGYN9mbJW9Gnwnn+DtqVTJ9YmUyxIbheqDjQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wO2+sTVk0l1ZGxNPtCIhrLphaRVwnNxLOMi8U0VqCHlEllzOUb1pDSiOhiCVSRL+YHp6GElSFXd8az08OyCNwevMVBj7RBNyqMfoF6dB7Egb1C2tPnib4XRYFqwDgczYbH9QN1uyzD9Uzgw/ttULLw94+61Sx0Z6zzu2BO1+tTrS2GLQ8zcIOnuWJV5Ate4a+2vqj9GeLYdN1Wv0QF1CzwRGwLmvVCPGXZRzZdaAKria3i8bAWgweJyBC8m3PUpdqxJsEReA7UnRAhpw8YXtItVDsMMZIvCrMATfeLCXCKaleInbdmXwPqzpkyBYjlCd72YsertQLFtgEMOn5SJ345BAG9eXEV5EYOPa7tfcbpOrCUQsUenCRlF6ru7jdkEXh27kINfHEiqIrEIEi6JNrGC0jMBJ+wbkll6+G5bhoNtdTsQR23w2XVm5wkjuTMy7
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 06:16:40.8808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ceccdcca-bb26-4aec-9550-08df1acc9079
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20F.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9601

Add the renesas,r9a08g046-tsu compatible string for the RZ/G3L Thermal
Sensor Unit (a.k.a TSU), which is similar to the RZ/G3S TSU but uses
different calibration constants. TSU is connected to a dedicated ADC IP
(a.k.a ADC1) on RZ/G3L.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * No change.
v2->v3:
 * Collected tags
v1->v2:
 * Updated commit description.
---
 .../devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml b/Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
index 573e2b9d3752..20fc1a8000e3 100644
--- a/Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
+++ b/Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
@@ -17,7 +17,9 @@ $ref: thermal-sensor.yaml#
 
 properties:
   compatible:
-    const: renesas,r9a08g045-tsu
+    enum:
+      - renesas,r9a08g045-tsu
+      - renesas,r9a08g046-tsu
 
   reg:
     maxItems: 1
-- 
2.43.0

