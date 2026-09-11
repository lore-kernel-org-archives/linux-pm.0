Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011017.outbound.protection.outlook.com [40.107.74.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0669299920;
	Fri, 11 Sep 2026 13:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132622; cv=fail; b=YTqqZ87/WUxfN+bGixkGh2gok9CLWP/bbHeYAUb/ESDi5KQGp6F7CzJCXXbpA6M5tUUcY0iq3lzUQXWqZLSXf91v8cd7Ed0I3dbfMLuWajylWX5LRMWTvBGgVxeJ9oVET66EQJnTAFM84px6t5DzqrzsCzE7l2WHHavEyPt+paw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132622; c=relaxed/simple;
	bh=w/JrTrl2gvNn0l2/DWiZ8AN5gXqv1KdHMBAhElkHXg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QISSto7lVl8s44yGmczIRGNwt4NWM0pvf7aWas8j1wxvA4fSKh8y6nRvRHexnOwOZPiBYFnHelECVeW77uGCgzRljSNXBRoK+WCSgdx6CJ7EKBuxP7vyI5Y1PNBJ59d1FuD0b00BSVlotwZiBJCKji+MTwfcdPYl6Hi0RKxXOHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Uid4EpWX; arc=fail smtp.client-ip=40.107.74.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Uid4EpWX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sz+YLaOTbM1NByW35rGsk5/J6ONMzZ5KoZCn8wKCqAufeWymcSzvLnRhO/1jiRH9VLDUFvFYHUcOFApSe1W+5S/D+5cb7S3yVi9yribcnXl433P7UqNHRoFcSlw5Q/UX5xJ1fa8s8hg4DmBuKGpC6/wbxNr8G4QBGLf2ssOeC8mx10J1t8LW9uJYjznyb42p2uDjcsI/frUB8z0ploYrXNEuTpskY1OZvDweDc6zaBfNhamPD7ZjL1xL7x6XqO+8t1DunzmbZFKrqFVpXdEzr93Sb72wM9oYxbKb0ZI3PS/4qK+HTbJJkm8FQb69P0MRcTSs4wP1iFitJqb4yvHCkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXJLQ/+pR7LojEVVD4CAg7B97re9r5sGwox/N/4gkng=;
 b=UmevSH2tyFk/xENn+EBgtNe8yWBvBMDsmIUhQG3bxIeEraCgw9eAO/ryEyn95FutVzqd3CKtPa8khRCPHBwLANaItqzLJ3kHTmKmLHnbefS9VJtYJVzZSaB7aJI+JD5wUuWk7WKISq15FyFksUX2T9ZrA/8FT/DiqY/O2dDEef6WhWXF76eWz5wF/rUT1BtK0ZTCKnCIlv9fbVN1Nj16f4VWtMtpSspF6qAWB73jJoqP8C1JNgVN8PjP3vQzKZ9OHhn+P8N+5O1CCtT4PeXrulAN+EtqRrTBpUw1QsK2F1eZUvJiToDr/jJDmSAS85C759c/DZXHzIurrjcxCheH1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=arm.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXJLQ/+pR7LojEVVD4CAg7B97re9r5sGwox/N/4gkng=;
 b=Uid4EpWXBZqg3DRDM3lMURTlfb88qa9Sjf8GZ988ojW8VRtV4fWz8iHKSKK5ihYCpI74qtCKjCEDgRHjWprrp33k4JxBiSIOl2GV2BJr9vqZZdolTIdq2Dg7SKOuHP+zky5OcSmXjJL5wzhpJB0HpKSe5+SWzKeplUyAtdIeSds=
Received: from OS0P286CA0075.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:b0::8) by
 OS7PR01MB17161.jpnprd01.prod.outlook.com (2603:1096:604:455::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 13:16:56 +0000
Received: from OS1PEPF0000D216.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:b0:cafe::9f) by OS0P286CA0075.outlook.office365.com
 (2603:1096:604:b0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 13:16:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D216.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 13:16:55 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.92.175])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id D53553010B34;
	Fri, 11 Sep 2026 22:16:41 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
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
	linux-renesas-soc@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/3] dt-bindings: thermal: r9a08g045-tsu: Document RZ/G3L TSU
Date: Fri, 11 Sep 2026 14:16:22 +0100
Message-ID: <20260911131629.111564-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911131629.111564-1-biju.das.jz@bp.renesas.com>
References: <20260911131629.111564-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D216:EE_|OS7PR01MB17161:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4b3fdad1-63fe-4cb1-f4cb-08df1006f409
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|7416014|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Cad0Xjy1zQkDUIHDFycyG0Y3vp7wJgwHtvnpsiKE7LQzrQTrq1mva8qEWjT8jX72bjqDklKqK0YEgQdvqeK5vPhhWIUVmggQEI1qwFWkcU+lMUDrBTjvGQjWzL/Ib14960bnVSBQcq2LvFL9ZKyAjcGAqB6fMFQEjOYG14P67wm7PEwLxRcxNz7i5hOU5qMvfDtDQJon5MnDIxmdrywpU9skmLWg3xYGtttHt77uVs8P4sx77u0JTJmqT4NuFpmE+3v9Pz/QL00dti6zmsXw4tXmqKPjhHDgPkGNgyH2J9yggjjqzCTdIlgxSHV3B263H4mkfP+WvMvPa5xfcM3D6ZcrbU0Hu1GnonwuKivbDDIRUB3dS2RTxUx17gGCYKkonCHN9WWO3mu93x9ClZ3XichSfgy+LWjoXibOEMwW4z541as0b/u9LXFziVYo8gljmfna02m/mFRSIy4fl5jz2KVc3wQTWlsUSt6kLoDiUc/wolkawU08+J6cuF/meQYbUBrH4VqcWVxwrs8nOY15pbXFVI2rODYin3ns1Si6rXCt91utV77oV/0jkXMUEE+OosMWcaksGbdpjF8ZR7GmErl4Aiq8iL83/0sALRuoGR+hk6OQjMyX2leUjEo1lIhg+iAs5hLaZAIALl713C9sfpmm+NNxZmo45Lz5d1pKjkpAClNuG2oUOpHdL7q71NzYtNjpJZs2eX+7bM9xi583/A==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(7416014)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TJQQXEMjqfe3HPbyUrL7H2SAIzQrxibcr6hQXsxJ4B3rFJasBrOgngosf0B4gtrzld07cFDF7Okj+YZoeXWaB0GFHGeDJYf93r++ieL9Vtp+RI5vZwvQglrGPVp5N5jbcxO5UBAgneOibDDeJLEf2PxzYXqY+M643O9vey1j6U176bzS8zhKcEhlokeaHIscBNjnIq6C6OCKs1HNWmNw+HGHOmZaLvu6NC3qAFo5iDxsZGfB3a9g8h4DaeD5iWF/vcCU0rETC0IoZIZbFT58KDFJknV4TPMNDtac6//hGlYBTbO+cxCHqLHn7FNR/BLIxcNb+jd0WUAtGkc5HAyjowIxeNCSrtgkf4cy0lDbK3RbBeS1Sc6SEHuwDKpKQwbRx4mX9vqypEm9mR94Ebr4zJeG/S0rovFLvKnBv851JK0quGp2cmlZF8ZPTR8DUOcg
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 13:16:55.9408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3fdad1-63fe-4cb1-f4cb-08df1006f409
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D216.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB17161

Add the renesas,r9a08g046-tsu compatible string for the RZ/G3L TSU,
which is similar to the RZ/G3S TSU but uses different calibration
constants. TSU is connected to a dedicated ADC IP (a.k.a ADC1) on
RZ/G3L.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
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

