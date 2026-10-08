Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2095.outbound.protection.partner.outlook.cn [139.219.17.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0B647DF8F;
	Thu,  8 Oct 2026 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791450747; cv=fail; b=YnEnz6TbQiRB8G7hzaf5QSOZHjwokD7QcqJ8nAUrNQsLnK3GtBt9ufEXdy0zysFYWwukcGNGunUDvt0BfWxrB9fB81e+hNWwh5pcA4VggeuuGLEoOsYHuOiFv4SJwaE60Jy/qKDTOrzqTPSm5ML4az+5pQI96ESbTKMiD23sO+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791450747; c=relaxed/simple;
	bh=IoZxkcYS/K7YSGRrXMxXQadtlTT9Jl5Bz36IKJnYq8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=STGnqVgPtc3oxpYRPJL2nY8lI2eTffmk3cdeKqSaO0Z8eDksLFGycQ+tkzygsl+NLzcULKK7KUbyVmhD1RXSsr4wyibSSnyu8Y+ZdQLGRrqVkKMSUQdlknyGPkJNL9Iu5RD/EhOCviSn+CClSwpfLgLYJWcw6ikDXp5Tlw/AM10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTekHy2kU8aB1thFzhrM6YQJ+XaueJE937uj4TsGHaQQ7EQAZaIgw3eL3RG+5W9KjHa8+GKijtHFUiqPyiWxgqthi7YpLadk86ZbWZy/ZOE5CvoK8LsXALShXa9K/Co+ggiDl4Jp0jn0eHfg1VxqG74vOkm6TnFvAayAcDbU51U/n9/xEKFW8CiDibuaZrAecEI7W8fXlokmwPIY0mb1hDGY12DJB8M78V9Ec/S78+trSL7ZJHbFBkMusQ24AEg/r/V8HT288yU6QwVKxvAie63oY86wKaCdLnbkp3IrH3aiay16LQ1RUhliVacMTvbs9mfTI9yhdfd+J1qOL1P1lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1mhBXKjDO7FFXH1VV+6gNy+QgNcBIwW1J2S7mSG+n0=;
 b=KfUVj94yToKCIHqfB6UsXaqwxLXI2Elg2QLfFzPyCJIMN3YKzY8ksfaZuYzhLHGSQLf/Cz33S80F9+xt8/YC/wqvHeR9koag7ODczz06LeQIejyedhCRAiGVZTHyyWhkkRY3W8KXYbK4NVQWyqD2u2rEnCG5qlkmh1a461n27G8b/WOP9VQ9HggIHqIyzVbctTkD51gBn6VH2a1JjSrFAobOwVos3gnj/AyfYOPGBMziO7wjoFBS/whiuxnuICIAE1Mwp/6Wu8VY0WRBjZqomm9fXrWWuJXESNNlGNokwyGiH2lqCCt4bc09YMmJztamKf+C7kNvK4eGl+Jrp+fYug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:f::11) by NT0PR01MB1309.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 09:12:09 +0000
Received: from NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
 ([fe80::6da4:f1ae:9ce:9a24]) by NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
 ([fe80::6da4:f1ae:9ce:9a24%6]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 09:12:08 +0000
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
Subject: [PATCH v2 1/7] dt-bindings: dvfs: Add RPMI performance service message proxy bindings
Date: Thu,  8 Oct 2026 17:10:25 +0800
Message-ID: <20261008091032.2832333-2-joshua.yeong@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 82d6d7cb-a6cd-47b7-b26e-08df251c3adf
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|52116014|921020|38350700014|56012099006|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	3/mw5DX12N6bcbswHI71ejyEtepsNGfSd6PJPUOF8Zzw6ShO82S5oESExcpWzEPPtVZnI8eJ5EGii+oNwZa95hqlaPPQY/Jzo/RpeHakVcFwaE8UDaZSWjpGem9Rp6tUlvStApo7Z5DHXmQQSJ/SSzE6VuUcc5XAMkp0kkIeB2bEsk2GurTRzul+QfdWBBlt8orrjAgcBMgn64/96I2c7opuGb8z5ZRTkyAWefGV7MoplDYxDNtI1oUdcqko7ev2dwpJfm7fl0gQrlBBf/3RXjone1BNugK/8qKPbZaWtQZtRVrQQ0sY+bB0OEBCo0nauKihz088uGLtJyjy0z2LawJCU8vy0wMxvEK8T8wI3642bWp4KVg8KtC9McNDDa9K585im/RGVq8O94XF1d/bEgV9MReTLK6NVAzxkaLGcwB+dBx1vNfEeA46LFeHq3t2MyogsEFXhE8G4dKVLDk9aSkNDVZ8r2l1CiIm9K1kw/wnjF2T/X9VksRXEMVnS4LceDZP6UjWyTPnmd3tjzPJWDReobeU5YvWwZyG8I+fv/01awZ64ABJOa+p72SoyC0lF8wFuueFu0RqOQxgFLMtow==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(52116014)(921020)(38350700014)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cERkHaH3aP7oOFUgkk4H+Z0iKexycSig+ZkHFMX7c0HUp+iArOFqtIHLYajq?=
 =?us-ascii?Q?zkVvZcfNVBXOHIeFElh8cyh4LZvN9On52t9vLuL713Ko2QUxTu1H3pw49hg6?=
 =?us-ascii?Q?EUI9sM/XxQtc+6JYL5kxRQWjSaRgTUsBAyZJtiZ9RJ/wkoiUFYsq6/rGcNK1?=
 =?us-ascii?Q?0uuMGRRkB1qizyNAK1IeNNWs9mWO47J8W0N55DG3tMuz2N5EknpmUyNd5Q85?=
 =?us-ascii?Q?cHhubnLBMpykUO0wWPGEc/K6nD+1in5FIH4RTvjTkgU0iYwl0uX+jU5dKPrV?=
 =?us-ascii?Q?I84X5lr2i35walkL8cwGTx7dEPdG6ZMXaqwK7anxCkLyRhHMrTIamuGq0Qcj?=
 =?us-ascii?Q?uA5vXNhyskPhZN3ienJ4iMLaMgs+FkTT9XDjGEygvjPycAP3j0RZs/ywOjs2?=
 =?us-ascii?Q?h3xA+ocKzlH+j0+kplgEv711+n/7y6E9M8/fd3GbfE693oUP7UN+QwfQYhBp?=
 =?us-ascii?Q?Q1Qnc4W3hgj1jJMhQnl4L5mbCiHK5LCsCWnjFw+mJu2xiCQ4DRkuz7ZlceKd?=
 =?us-ascii?Q?Gce15BaFhmafFYippMXSviDTagIG4nVD+vi1Sb1PaDXGj5dQmzCRk9kBVpKq?=
 =?us-ascii?Q?M1aznMOTv3wLp7MKaG6Ssm0d/yBBmE8rfmnDdXt5lebGAHiWHkmWCF4JDT4I?=
 =?us-ascii?Q?7YAdMCqkO/C5XAwKVTaWBdR/tumK8/sSkOtNh1SB/6jZOeUKyFkOubUmTOBC?=
 =?us-ascii?Q?ugJqea3ig+rjJhbFg0cGqh4aGacTyHdbAnF6L3Y97m4pQWHcQsdK1fgJ1wC5?=
 =?us-ascii?Q?dgbDeaPKL4p0grrmGenIBrlH35czBck1FlKZq05kMbwevKhYSoSjdo7t/6uw?=
 =?us-ascii?Q?sWjsgKSZwO51oondHxRy4qKhUqwjijiAtAqBR3MM3ZgJwbIgG9isQOJbsn3j?=
 =?us-ascii?Q?L8n6xpF3s9DufRolcezxT1WG2oJJS6uPu2v29IHu0WQHYCN2l51/bCa2DdjR?=
 =?us-ascii?Q?/xniMUat7UcSxkMIrKKmsclxeYBCcUmtpgVCH0FOTnPRBO0ixevi0+kLwNXr?=
 =?us-ascii?Q?KRqLyL+WQa5qTuhQ5XyVzVNFxyopacOPLWm+Fd8APF19qMi9HhHJlS0YVblX?=
 =?us-ascii?Q?mq0vejWi/KeWpqfIKLFgw5wwi4PlneQxNetrSEYvahsoNGI0YLyMfu/+TzU4?=
 =?us-ascii?Q?24ky2veYmIwy/+taGBbrQCwhn13G/pLzR44wcaeTeiX4wbmhlMA1mwokiwHc?=
 =?us-ascii?Q?8XXbBIZhIFReEAEzX+e+j3fk5ZQNhHEhjwfODZAL9VM9tUe6GHJBzlZzc+GJ?=
 =?us-ascii?Q?zaWNA/FYjQ6Gnli50AWSfsDRw+GGCVDBad98bBzO3IM+71E+W7H9BkkizDye?=
 =?us-ascii?Q?ApDXfOP1ygVDYCJdUrxe6AGx/HeNjrcsP53imJHC9b+vlsjb0afGTxAGgz6A?=
 =?us-ascii?Q?+sqGoeXtMl/6RlER8K8K5nW2Jhu/+NlcY1LEI/hmjcFUtA+eJLmA8qCUM9fE?=
 =?us-ascii?Q?ZbenMVYqW76vfsB/KFwO0LoAXM4BwlpsvaWdAoCfUGioft/FJRCdmt+uXkGI?=
 =?us-ascii?Q?Djs4tORS6MIVKy9Hs2nb4yMbOBHsjRNrPcBbO9UIFjmkrRGehB+jJ9eS8RAI?=
 =?us-ascii?Q?bZ0xQRpw//kbAWSAvxuSMP3f1vb9/d0n2bsbcefefMJUGRr6zHuIYEkjmxqj?=
 =?us-ascii?Q?lUfoBM7JGJjcCJZkHtvd8CAXKwwI+hssMGN3Vo44xRyyL0GJNlofqi38JL8s?=
 =?us-ascii?Q?LRcpAqnpsWU4VNCi1iMII4Q3mXeyohEUuPGJL2dX3nfOUWk5g2nA1tdjSYW3?=
 =?us-ascii?Q?epFwBSo/dUtfxA4TvNPmNGP6vxiDI90=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d6d7cb-a6cd-47b7-b26e-08df251c3adf
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:12:08.8947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+KtXKyEBEhpEaZ1Xq3/IdDpmRBSxZxCdunQFT+qwjhsD+gQdfTzEbzw5uP6ZpTKLxNIodCzH2+montpwK4vTHHgJ8D5DhDF9MDzBPrirys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1309

Add device tree bindings for the RPMI performance service group based
message proxy implemented by the SBI implementation (machine mode
firmware or hypervisor).

The RPMI performance service group is defined by the RISC-V Platform
Management Interface (RPMI) specification.

Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
---
 .../dvfs/riscv,rpmi-mpxy-performance.yaml     | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dvfs/riscv,rpmi-mpxy-performance.yaml

diff --git a/Documentation/devicetree/bindings/dvfs/riscv,rpmi-mpxy-performance.yaml b/Documentation/devicetree/bindings/dvfs/riscv,rpmi-mpxy-performance.yaml
new file mode 100644
index 000000000000..4a05c48c1e12
--- /dev/null
+++ b/Documentation/devicetree/bindings/dvfs/riscv,rpmi-mpxy-performance.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dvfs/riscv,rpmi-mpxy-performance.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V RPMI performance service group based message proxy
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
+  resources implemented by a platform microcontroller. The SBI implementation
+  (machine mode firmware or hypervisor) can implement an SBI MPXY channel
+  to allow supervisor software to access the RPMI performance service group.
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
+      Intended for use by the SBI implementation.
+    const: riscv,rpmi-mpxy-performance
+
+  mboxes:
+    maxItems: 1
+    description:
+      Mailbox channel of the underlying RPMI transport.
+
+  riscv,sbi-mpxy-channel-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The SBI MPXY channel id to be used for providing RPMI access to
+      the supervisor software.
+
+required:
+  - compatible
+  - mboxes
+  - riscv,sbi-mpxy-channel-id
+
+additionalProperties: false
+
+examples:
+  - |
+    performance {
+        compatible = "riscv,rpmi-mpxy-performance";
+        mboxes = <&rpmi_shmem_mbox 0x0a>;
+        riscv,sbi-mpxy-channel-id = <0x1003>;
+    };
+...
-- 
2.43.0

