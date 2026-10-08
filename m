Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2095.outbound.protection.partner.outlook.cn [139.219.17.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC2148094C;
	Thu,  8 Oct 2026 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791450781; cv=fail; b=gCEBU0g0oNWSzuMusrrsyf2aEFVW0xBIeJd5RhkOo2HhrnxiM0fYUJW96kbBHnTHpaDWwVft8BY9vnmhzF/7nrC19Z2u1aqX3TyC/Hrp86PvaV/NkOLmG8i6eZ3GPbu3cNxFdRNEcSmhga3qUUajEkY5xVpILkTCoZzI012Klik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791450781; c=relaxed/simple;
	bh=sS2odixaEWwxPcqNjNuYXU0JSk6/AeNSKcBbfC4QD7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G0G4xQ4D4WqOKpJF98n3Ut1JJtp+Eis4ZMK2f2HLQuM69GehhsZD55i1iVHXnASn/9VHfUeFCXp4F1F+XwzY0smZgMXE/z/Oy2t673kdzyyywNUHcB9xExPaxzg4rPSC0H3r/gcdYzJZYP32dBuDtErfX9NzSIkybwprhYfcOqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqfAH4VFcPzJbuMCBavjQhwT+favUgECYTczYXz/76dfvw6fhnDcpXLc+DidvqaRounCM5X4piMQeWjLLVsDi1efBcGe/XG6rGvWN2cHK2YiNCDZfy5B9Zy0tATnAi+PxRfgnLzuyr2BN9BQ0oiSSoj+ZKJuh7DdaARY2TjdcUWgdjKxS789/M4xlV4NbD9O+Nxnyu6vGs1n10MqVlQ5gv6le7J82xhl6gmCzIjBjGm8zOODRR6Bg3qWLNCKKsgAr4/pOdZsMZN1ZROxloIOWXSxi6+YTREmiFo2Rrkx2cf8y4XJgICZO2JdEk7PyDW9x992RgYC/VnCcW1y7DFkzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbZjcKkCp0W0UDMPReFxCmjXlAhDXERQyYu23bdZaW4=;
 b=PjV4w9f/l97bysUuEhYYGL1tMn84KEAiEtpS8lYq6aC2TYeHjZ2KOI0ghOEuH0wcJks9s8pydIhUy6OJCv/7n3amCWS8hrf9n+WATqOnRzKLhsNiFO0JZTmeXikCr0tLqL7+hcDZkaoKzCxHTLynZoeXWNna04OOd1vhss497JoTcMhJD1zF32odU/M9M7BtUA0HvP5ijY1lE1h9zg1cSFtiP3molFaFK590DsSFc10VC6aPmrbq53VHBQf0CDaeAdsCl9AJ0o+vqDYgDd3IhciMSvQCOh0FqRrow4NXjZEXvdlL4Ropxd7kYkH87Xb4TCWkX19NyDuZgsYilHvEVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:f::11) by NT0PR01MB1309.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 09:12:38 +0000
Received: from NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
 ([fe80::6da4:f1ae:9ce:9a24]) by NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
 ([fe80::6da4:f1ae:9ce:9a24%6]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 09:12:38 +0000
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
Subject: [PATCH v2 7/7] MAINTAINERS: Add RISC-V RPMI performance driver
Date: Thu,  8 Oct 2026 17:10:31 +0800
Message-ID: <20261008091032.2832333-8-joshua.yeong@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 78219644-5296-405e-84ac-08df251c4c7f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|52116014|921020|38350700014|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	el9VaS27X1VZFF2wBnI9WmRJGIJvV8di9e5K9eHCtoBfQbDe8TST3RDxqAKgIpn2ctNKYHhkCo61cj9oZouT6MNci4/LmWHLTabSp2Uk1XMhQOttsRu37FVc4iYsHGnZR6ObQ0dgTGNS0sM9KCJM+jjlt+5Ux0U5YMOyBFghG+bq4bGlSrDgu3WIGy60MS8CHy0nVpa07gQk3TOYeeQBmA6I7Nf0TYpUR4rxfQHgpx/zZ1d11H0cAwVP22IcyECWk5q1/Iji0H4xtfq5/uz18+3kW+13NRwnRmA2Gkkowepq5Xqwcj6wFcNRHotjKNUt7Xjv/E1nfaaIwcPHY5bRE2Ol06QvrO/2Cay/kdeduauSdSk6heJsJ6JfRWeueB1Y26AXXZDEDcQSPAIK45qlsJALCKp1Dxwl9qyTPOy0AneTl/cBQdmix/+hIMnnkcrvCv6KF1yZpgSVPgjBRD0NrTEQtbIpCYG8PCAp2zhn+ut4Ny3nkfsBRo3sfR1jcSI3se3UezcykhNRf4ksHhlyrvvSrU2DPcFfW6snTKgfncWcVWLDxxt+8w3Tcjfd/aLDiPRu7hU7b1yZ4LT97y0L9w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(52116014)(921020)(38350700014)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bq8hyugYszB4vMISlhpCqrKFEo40avgAYzANMe8sCJYTPrOabeLcy3vtxt9f?=
 =?us-ascii?Q?56huMhnnpVKdWVVBONWdEE50lDBNZU3J6+dzerbX5+hbtY5Ov1TKur5F/RRe?=
 =?us-ascii?Q?PPuVjBw9d5i5JODx/8ehOiSqFufoZVCeaUwMZSxTxjnDMVvQN+ZPb0AEjx5I?=
 =?us-ascii?Q?fgVuEgwoEBv4vRliUEByj1oIrYLUNbRAqcS3H4y41scwRHjqpQdgufrkaWwY?=
 =?us-ascii?Q?MVGX6LH9woFGC3OOFRLWyo5H3Mnb2po+sn8MdIZN9ldq5bhf/tOjO1YJ2zO9?=
 =?us-ascii?Q?9TQBmIAcwEVcetLsC505FsS43Xu80MNjyzdNXNaV7BNYUJwMfnlxWJjiXUs7?=
 =?us-ascii?Q?ROO74wp1Vm5/ue6mHv5H+RrVmZdspGxeLDKy9sqirsoOp+eKtqb3pyVmY+vA?=
 =?us-ascii?Q?1gN7ptLJNTWt811BfAtF/XcInrc5dY/Bevz2Jbc4XK3Dn8uwpXn2/eBhDvsX?=
 =?us-ascii?Q?wTh9YQCJLSB/S1AAF1qXBqXqYm22goe/NWazr1Nv3ZgoRZ+h3JhtRkw/oPrs?=
 =?us-ascii?Q?SaPV6LXPS1NWCFSxnN6Nraz7NXtzsqN57wH/IyBi9Ug04/sdeYMfSPZA5Vqe?=
 =?us-ascii?Q?9JmQcTcLotYoA7eU3MdnIWL7R2GQZiLsuALilG4elwqfDR6z48sLac9tugRa?=
 =?us-ascii?Q?+ZVghPjF/SteWFqJiKhB0X7NIerfgvL0boEw8dt70oygHRuTSyYYgw1pHZdo?=
 =?us-ascii?Q?Ex2vsoE7pwK38hckCSmSOTXDqz2FwdTr4sRoX/Vkk5rRNy8tsCk5RHduzZEG?=
 =?us-ascii?Q?qoqhgX85ZLeSRYMAr6nKw6ZBjbUw3+nGKENK2lhcQbBdPXMYXlEGDmAitzJx?=
 =?us-ascii?Q?xDxHR0jiXDDvMWDb6r0dFLNH2/7T3KRR0rdQhlWAk70sEWydMhGsL30gzVzv?=
 =?us-ascii?Q?bJoQ25BoSW1QWEwyc2AUpZqmXGFxITT5JIrwKoHpJ0vS3wR2zD9Jd/H09VAI?=
 =?us-ascii?Q?luFi4FDdh8mIFD05N50hrPgSvT1wkQ2SeeACPToyO7yAXCTFEaPEAxA3D84J?=
 =?us-ascii?Q?px+Gt5Lx/xjAwwtkg9/goWNmvLTGmsrus+4wwsd+DGaGtQ9X/GYDbOQv58sV?=
 =?us-ascii?Q?xze7bzN2osOr9CBvy77Gm/bjTG/1CM6EdrXfkVUGyHCcm2kLKv4pESxOvROF?=
 =?us-ascii?Q?V95NLIgCBhiIfGRKpvkQbLLmoOZzFHwnEU5AFy9TazZxlm7wz3hRhiZQHCOc?=
 =?us-ascii?Q?2saHSH/fMKuX2Xyat4nH3wJuIfTgaFXdcFqnBtJLcIkJ4v4/nT5piT+ZnCid?=
 =?us-ascii?Q?FnZummXLm3EQJlmxrZli/XfF6UTGp1QLDBBtkvn/tOeppVD5rQUFk0PppCf+?=
 =?us-ascii?Q?oHahsih2LSm83vgDab4kNFIwPYUIaehp7adOsfTbK61SNTxhlaz/tusFX+Ao?=
 =?us-ascii?Q?g1FxakMOE7mHj1Toxr4LEeuhCihnPt2lvBGH9MdtC6HJRkd5gIKf/3zuiXWd?=
 =?us-ascii?Q?CpnPeQGG79mMbXn9TybGDKCs/9OeZGCwpLEE45Z4JP8BNCknB4DMqpm5l+jw?=
 =?us-ascii?Q?fV9Nx1CNe7cvYCcgkFUZ5cz8H4OM7Sn2Pe4qN8iNR3AThhW8e0+TL3aYzjYq?=
 =?us-ascii?Q?T5FZyo+/RSQn2uZbs99tl+pFqQhFSNubBi2ZEofAg5sGyNawjAMe09Y5BF+9?=
 =?us-ascii?Q?MzW/gQansBPzbS8GVjYydNBkO/n3SOU7Zt77kqOtef2p8UX5p7MI3JfhyOwt?=
 =?us-ascii?Q?ZxwzjFxqxPlOhY+dicxqXMd9WGjFs3/o1e6CT5S62o6whod7DaIgbE5LM1ve?=
 =?us-ascii?Q?pbf+xE7W3QNKr82eFvSq6FK7F48PjJE=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78219644-5296-405e-84ac-08df251c4c7f
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:12:38.4560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: roNEei7Qd0hJTrtEls8w/cP0agefN4L09dow+fqsbCinNnaDY93QZsVZ/q6qx2mPfoOfe3GoBlKV2K7HNMNpio+XBoZIizOiSLKiUkTW2q0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1309

Add the RISC-V RPMI performance service group to the RPMI device power
entry, renamed to cover both service groups, so that its bindings, the
service group core and header, and the cpufreq and power domain drivers
built on it share one maintainer.

Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
---
 MAINTAINERS | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bdee5c7ee83d..b6bb3c6ea8aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23600,13 +23600,18 @@ F:	drivers/irqchip/irq-riscv-rpmi-sysmsi.c
 F:	drivers/mailbox/riscv-sbi-mpxy-mbox.c
 F:	include/linux/mailbox/riscv-rpmi-message.h
 
-RISC-V RPMI DEVICE POWER DRIVER
+RISC-V RPMI DEVICE POWER AND PERFORMANCE DRIVERS
 M:	Joshua Yeong <joshua.yeong@starfivetech.com>
 L:	linux-riscv@lists.infradead.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/dvfs/riscv,rpmi-mpxy-performance.yaml
+F:	Documentation/devicetree/bindings/dvfs/riscv,rpmi-performance.yaml
 F:	Documentation/devicetree/bindings/power/riscv,rpmi-device-power.yaml
 F:	Documentation/devicetree/bindings/power/riscv,rpmi-mpxy-device-power.yaml
+F:	drivers/cpufreq/riscv-rpmi-cpufreq.c
+F:	drivers/firmware/riscv/
 F:	drivers/pmdomain/riscv/
+F:	include/linux/firmware/riscv/riscv-rpmi-performance.h
 
 RISC-V SPACEMIT SoC Support
 M:	Yixun Lan <dlan@kernel.org>
-- 
2.43.0

