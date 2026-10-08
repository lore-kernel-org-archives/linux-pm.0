Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2095.outbound.protection.partner.outlook.cn [139.219.17.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602BA3BFE26;
	Thu,  8 Oct 2026 09:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791450752; cv=fail; b=nI8bZ6iulc+F1usTR81IIHOoXmjBM3O/qIWigkYyk5121wpV9UEUEK10Y6wF0Pq9ENRZSq8q6tjTRHCUuxcxxpmSxcw6I3+UD/Rml7sfm4GsC0TfBt3JNLp0IXEHitRu75AkPZEH/pH7gtrvv6ludPWBZnnracFEhll8iVTiJBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791450752; c=relaxed/simple;
	bh=eclIaI4NVeGk/iJMtlfxAINJ3WOlkOLjebzK2kN9MzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lnqMPgSslB+Sh2pWYB4wwMvkmzDIW/uViv1nnGpEkk2Q3HnZNkQJSZMtVWazueU8phnQDB72T8HAtBz8dD9/kdrq+ck+Wc8GfWMJlnlKbSRJUjkZo7LPmYipebIJHNWnSlksid6fwU3Ax8d2Dailafzfo3BgnAP5YCR8JClqh9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXU3VFbFUXczPfRO7hWA4OWiZfwEv45Tn34n1JKR5kGNuIGkyonQBtpRlaiFp/gqXVivEMwpW+OQbPozqCQwIta0MVZG1VWjUKoaZnn0ApBiXryZmV/wLoUPd970z+h0Mi5n1pqivCnrM6lBTS3RGtdNDeXefXBY3UKVQeQXNcRqneXXDtvRV/DTkLY7ya3E/TJQ+xiGLy39jF6oI+4ktRsDdYVMGajs/273xh/2pzmSPJNbz0sUs2ZoAdqmlS/OFHG5BujA1sO48govZ6FUOvJ12gsHtPGMoYNr5KS5HaOm59fWmL/LDUlyFixi/qoWPAjk3mPyZmpIi8BdYSd5Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6dQS1MZ2ybaZIvnhA36bU8GwUy1w+9OEmNcC/RLYoA=;
 b=f+UJcyXrp9t/dA1PfWfavZ+DGkx3rZdyUCbHfD39sLOfNjgVTL6WReJnIUSQfI0rSnq8SqrO5DINeZI0BnzsSJhvz3Zjd5q4lX6x+c/gub5t+nzvi3B+jmXVgNgGa2jvOtBr8oi4YERid6UQXgAQdx5v6B7P1minBnGDosHPl6W7wS4xvc6g2WjcgcE8eEcQxZseGB44Zic2GQcEwowGqYwG5zR+KsBSDx4g1VLh2f5T2ufZJDV/VnaqwlFrbe9FhYutdkkLcbt+RtlmsSpW8G0Y3Ki7KVdMuwwLMQXBfNJEgZNLw6UFrikOJv/WYfuPgv3O68UkYib8+9p4iPdZLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:f::11) by NT0PR01MB1309.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 09:12:13 +0000
Received: from NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
 ([fe80::6da4:f1ae:9ce:9a24]) by NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
 ([fe80::6da4:f1ae:9ce:9a24%6]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 09:12:13 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	ulfh@kernel.org,
	rahul@summations.net,
	anup@brainfault.org,
	lftan.linux@gmail.com
Cc: alex@ghiti.fr,
	joshua.yeong@starfivetech.com,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] dt-bindings: dvfs: Add RPMI performance service bindings
Date: Thu,  8 Oct 2026 17:10:26 +0800
Message-ID: <20261008091032.2832333-3-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008091032.2832333-1-joshua.yeong@starfivetech.com>
References: <20261008091032.2832333-1-joshua.yeong@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::9) To NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:f::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1325:EE_|NT0PR01MB1309:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e4b087-1748-42c1-79bc-08df251c3dc4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|52116014|921020|38350700014|56012099006|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Dp+K7zJwjVfoNy+oREb2izRSJ20416ryJ1lh7ggk4H6bMUPaOJImRlud65LvyuOAPaaPqlwv1pMb5VvMpCQSPDr64wb7jvMGZU8iEOX040cNzcrIbKJ2wPONgz4MpJkNZzb7LmQ1heMehcLyWYMuOZnZbv4t8CwyNDHO5UjX6xYJ9T5WbWeaKntNCFUUH2eo9TiVi/Wb8m3XP8r/WN5guU0D4evqcLwkHB4rhvGTYkJ0JXaueHmrf3gposlFrSKRUxxocjLjlsR1aJmG3MkOgKL7st3+R09d3gPaVArqoK/HHOX2NV7pyFEXL+Oc+rceycmBAMyWzcb348EVN1npFN6FuvzyKRCwNB3o83b+Uiad8v4i6lQPJadtWZOQpd2WPly/VT3CUga+ls2ZN4eUsQvFT9Bl+W/NwdCn/6BPePttPC9LYgxwuCEkVLLkaNgoQ9Horn5KTkaiOJs/AaQO/i9ZDL16WYEJ8QrVu3k0HTrHljRyCzQ1DDs2RSHcjETsu2L7PBbqwAQfMIroXWrVEjB48jlL1NjPHWFwdG1LG6ac8JFbxAM90heoAi+UE+COKc3EY/f1rUtVzFnWL3erKw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(52116014)(921020)(38350700014)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k+qrXNcWNhGeO8rT1/QmARkcm3OfwHCyJRZL4IjTFk3VtouGS2IUVdpOuhJ/?=
 =?us-ascii?Q?C1uDW9Dip3QJ3nyp8VN+4b0nIjTWfqEI4+Obwad+lkFkSLMI1jtfmsi60tgW?=
 =?us-ascii?Q?GEKrzzLViO8nknpGsdaHaKU6JXfoJcjdmg+hEqmr1FjiKrtDlkpeBnC7vLhM?=
 =?us-ascii?Q?3fhbEEUca8gV9+P75U4sPv9xBJNE1DB5S7S/vWnEJ3zY7NAihSPzQOIfh6uM?=
 =?us-ascii?Q?u81jcVxp4ZQq9oXFfLDKti1l4HEOdZZWukvtvU2LebflroIqbIKfH8mFh+Hy?=
 =?us-ascii?Q?aZEVRFHIVk1PcHN1xQ4aJHD2Jcd1YwWNQjoBDdlmE4jzaJIWP5/vZ7OaGhxV?=
 =?us-ascii?Q?k6FOPitvRGDW8M7Wi9xzx12MKIYw++lDJVknArJq0SaIF6Fzq5XXTNlhzsDU?=
 =?us-ascii?Q?KtrOtsuMHslIzQthcvRgGLNHmQG5l1Uj/M6wOEIKIjgCJSR1SSuDid3oWtlM?=
 =?us-ascii?Q?cU2Vcu3FtkkSJ8Ci/I65TDe7jpgnVwlNav/As2gPuvP+UjLXNS0C//sIAs2g?=
 =?us-ascii?Q?3nANdjrix6eWADqtHl7kWL75BFhZOSqGlQnLRtNm2+HDCoKCedwRZlsRNy2x?=
 =?us-ascii?Q?sy20pzV1O1i1DP24yeyZl97TeSWjgqDQ6csTxEz8wjR+A5JfXr4Bs6IfFL2+?=
 =?us-ascii?Q?EyPeBs0t0iIjlkSz2hdg+5EC00NXgbrqWQOLQa5b9pw/hlOHyhcFoYJpC6uG?=
 =?us-ascii?Q?LgHNp/FqeeQY0TXEnHZi6yYO20PjRzbckUpeiL8N3qjjOJtjV/dFM2T93Sf0?=
 =?us-ascii?Q?EDNeP4LErWyAK9O1lS2nD38SvpOsnAcaXMeBJmZ1Bt2wHFgZJty9+qfL+Qsw?=
 =?us-ascii?Q?vBeKXdvLZ/I7uY6Sjv0UewxXuFUO+2MLjuYibL3HG6/oXRtyWRT1UbwRtMCb?=
 =?us-ascii?Q?d5BU1U8QY8y3dpG+JX2nPlwpKcgE4AP4xm4yBKijinI7bTScppWMZlDdssQF?=
 =?us-ascii?Q?oyaHttZN0K0aah2sNT9GlE+kzPky/Wsqmm3fStOlX0AhEcYzu5/xVUquycm2?=
 =?us-ascii?Q?sSuO+oDFXEBGbEkwwVtvV6pETdtZV171ee5toF/+CQ/AReJDe8Bp0StymSXV?=
 =?us-ascii?Q?E78PMUFpc0qUte4Uyp0Rkye1oVyTniUei2KfYUt8UnxMi2Fm5CUkrzVFt2aW?=
 =?us-ascii?Q?FJQ9Z8QZMe61qkO6eBHGlmIhhM88txorVAH5HzSSRBBSTbXf4dajtYON69v5?=
 =?us-ascii?Q?KD43BwW6gkqKcZqmU6tWzu2cx7i8i0FvbNYos2gQB1Coi2LJ1tr7Q+1/HDn3?=
 =?us-ascii?Q?EU1P02lNXnxULIM4MwsRgB318phtPgofAjXRaOBd7hRVvvWL0kyR4RMixVHm?=
 =?us-ascii?Q?6ysTFfUnch+Ts6Fyc7nsBvSxKPSOE733ctRJ2x7TSaWoedr/A7nLVl+5Jh1+?=
 =?us-ascii?Q?tcQHzZyKyWkehLhK9zMg3pogGPENbmIoqoDlCGMAC0GLHlpGzC6w+4VHzWLR?=
 =?us-ascii?Q?B5nPDpmcPA7M5dSHU6EZD43k2zwnorA9UG2h8ER21SMZtpMa+N2nUzQDL3hF?=
 =?us-ascii?Q?Pg6ogvJgsbHaf582vZlCAqYjyGxMXDwpziAjt4uS68Sn/EnTz7ra9hJewPZu?=
 =?us-ascii?Q?m/gcnPR+mVL0EBG7tOIqjNJ/cnfeSGJazyOcU/hLA3eDSiEKgPHG04z63mmv?=
 =?us-ascii?Q?QPTglNg3Aanmvcx0qYKoLDDyrnodBmPT7Z7Zd9hQv17Q80yejR9+s9YA8kQQ?=
 =?us-ascii?Q?zKf9xSfpG6fei+FvovZGKCIzsJyk8atLSq/fhKlWXXnKO5fizNuMNLU2IP0K?=
 =?us-ascii?Q?pRjH24YbaQwB9boW9npDzKpqpX8bOVY=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e4b087-1748-42c1-79bc-08df251c3dc4
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:12:13.7158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oth5AtrdwZTRYysFBnW9Hn1oYFsAqsI9aD27b00CgzMhyKg07uaPkAXUME7lEtJyeMxVxQJjNTp82YwOuy6tN3hjc+XQOS1ESnnDozrhjjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1309

Add device tree bindings for the RPMI performance service group based
controller for the supervisor software.

A CPU names its performance domain through "performance-domains". Any
other device names it through "power-domains": the controller is also a
power domain provider, with one power domain per performance domain and
the levels the domain advertises as the performance states of that
power domain.

The RPMI performance service group is defined by the RISC-V Platform
Management Interface (RPMI) specification.

Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
---
 .../bindings/dvfs/riscv,rpmi-performance.yaml | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dvfs/riscv,rpmi-performance.yaml

diff --git a/Documentation/devicetree/bindings/dvfs/riscv,rpmi-performance.yaml b/Documentation/devicetree/bindings/dvfs/riscv,rpmi-performance.yaml
new file mode 100644
index 000000000000..ec7856cb7257
--- /dev/null
+++ b/Documentation/devicetree/bindings/dvfs/riscv,rpmi-performance.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dvfs/riscv,rpmi-performance.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V RPMI performance service group
+
+maintainers:
+  - Joshua Yeong <joshua.yeong@starfivetech.com>
+
+description: |
+  The RISC-V Platform Management Interface (RPMI) [1] defines a modular and
+  extensible messaging protocol for platform management functions. The supervisor
+  software can send and receive RPMI messages via SBI MPXY extension [2]
+  or via a dedicated supervisor-mode RPMI transport.
+
+  The RPMI specification [1] defines performance service group (performance
+  domain) for accessing and controlling platform-managed performance-related
+  resources, as implemented by a platform microcontroller. Supervisor software
+  can interact with the RPMI performance service group through an SBI MPXY
+  channel or through a dedicated supervisor-mode RPMI transport.
+
+  The node is a performance domain provider. A CPU references its domain
+  through the generic "performance-domains" property described in
+  dvfs/performance-domain.yaml.
+
+  The node can also be a power domain provider, with one power domain for each
+  performance domain. Any other device that runs in one of the domains
+  references it through "power-domains", and each level the domain advertises
+  is a performance state of that power domain.
+
+  For example, with the provider labelled "performance", a CPU that runs in
+  domain 0 and a device that runs in domain 1 reference their domains as:
+
+    cpu@0 {
+        ...
+        performance-domains = <&performance 0>;
+    };
+
+    gpu@40000000 {
+        ...
+        power-domains = <&performance 1>;
+    };
+
+  ===========================================
+  References
+  ===========================================
+
+  [1] RISC-V Platform Management Interface (RPMI) v1.0 (or higher)
+      https://github.com/riscv-non-isa/riscv-rpmi/releases
+
+  [2] RISC-V Supervisor Binary Interface (SBI) v3.0 (or higher)
+      https://github.com/riscv-non-isa/riscv-sbi-doc/releases
+
+properties:
+  compatible:
+    description:
+      Intended for use by the supervisor software.
+    const: riscv,rpmi-performance
+
+  mboxes:
+    maxItems: 1
+    description:
+      Mailbox channel of the underlying RPMI transport or SBI message proxy channel.
+
+  "#performance-domain-cells":
+    const: 1
+
+  "#power-domain-cells":
+    const: 1
+
+required:
+  - compatible
+  - mboxes
+  - "#performance-domain-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    rpmi-performance {
+        compatible = "riscv,rpmi-performance";
+        mboxes = <&mpxy_mbox 0x1003 0x0>;
+        #performance-domain-cells = <0x01>;
+        #power-domain-cells = <0x01>;
+    };
+...
-- 
2.43.0

