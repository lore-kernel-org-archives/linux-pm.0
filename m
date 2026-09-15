Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011012.outbound.protection.outlook.com [40.107.130.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F95C34EF07;
	Tue, 15 Sep 2026 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467022; cv=fail; b=l9C0NgrFGRQaEyHfvynXRwUUD95x5AfhSGsQ/Oia+hX7Ef967IW/kHAIgRFfobGLGFno2eqRMdY9cXuBtijYFPU6DJQali4F0nnheORUM2PBRpI5wKPyW6YktTdttSyU20HDm+Ngg53YlQv4RzA6h80/Ox65p5WMq4/KEVViJlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467022; c=relaxed/simple;
	bh=cNqHlazxp0S9xuZrP0ZhfNEmcLdUDS1w8h4KRTu9dlY=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=uG+mGpis5XYi3qfLkJlY/etbF2EYsSLLpCLjF25+11Y4+dtrXBMmQheDMVwmWnp5k8T/Ch2WH1xZ5M1kiWqFit2H9XGBaHNWRlMdaNezZ4/Hcu9zZOYjFPss0UAMdT7atihZU3q9bgQBgw9Ql56OR8Ng3DPGxa7gzXnlvg8o4Kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZcWpbBOd; arc=fail smtp.client-ip=40.107.130.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZcWpbBOd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H22NXylwBL4y5wtB8W+MZjBfCzwmuNOslagKnijGhyzGAFlnS93GF9UioQcoyHFtXVr0byLR3Njf1jNHLiCZGeGz/H5/6JkhhdG/kNrj0UpGA/tKlBEZ0b/Kk3S6wlOSZoknCq/GBhLF0JthFWLl84szc1pAHWR9OGwN4eQy3JL6dsr5I9Gf8uDZZam9y3pnPqOlafPlo3RWdYP5kkabeECZAsYXELAmkqWcdvM1N9DM1g4mUmpXWQvd06UN8/n3EkPljD6AUwisNRIZCrdbbiNTRSO0bebpd2aRT0c45GrtUfPzoz2Y9g0UwqkvyRN2oSaz7mL3vkhjgCK4fQs5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oM6zKzDbgrXCsO4fjfJRk1aE+nDWKg8Uk6Fz/nHHrmQ=;
 b=IPziOSOOFh089K2P6mQ4z3ikL1qz1pAqu+RrSLVeLrt1X/MPM++nM5JSbcdPRuMAINFaIfK4ClGAiIWyaGm/CRS6KDKzdCX/EpRCG5hht4WdsUogx5+zs2WLtSOZQ8L3iYDpd5oso+CPJzHoI2so+SJTjsdSybg+pJxTDMv9m4c/i6Y0EbNe+Zk7DHBMhtPY3jX9Ytav7zalXsepQ+ZbvVShON/kYAG1LmXZ0acA6eqWgaKySoE4eiltM9iGXL20lp+hnPqhrSCwRZyD3mT76gRanIq4X/RfE4W6SeRIYNdYscHgFf5G8GBKXsx1tGAIDYE4A6tt5p6U61+SCGo5/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oM6zKzDbgrXCsO4fjfJRk1aE+nDWKg8Uk6Fz/nHHrmQ=;
 b=ZcWpbBOdcl7a2HQGE7pl0BwYeieTvFlRSeuTpZT4g3OxegKFS6KJcz62jekynZPz+eRoMGJ5zduxUJmFRgkfhBm1N1s80HRKUvQpoNtywua3S5uTNui29w7woc/WhnZ2is5CA+Q4/yFn/L31/VjcMMbDIEiaF+TQkYvoWnBv8e56PLc8nuIqC2Y7VqcH5zWnhpd4CmLFIZ2Xb56stOHGoim2/6LhL9MRUiXCND9L6EioRTDvcBAAtMu7m3u7a9TDsF56z/urCqQcGeW8TtfqwU4LlvJykg9WtLvxI+hWI198vUEexmrY1TKPPlePnt2xmbnK4KhVHwWYNyLQ6YCghA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB7PR04MB4698.eurprd04.prod.outlook.com (2603:10a6:10:1c::21)
 by GV2PR04MB11979.eurprd04.prod.outlook.com (2603:10a6:150:2f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 10:10:15 +0000
Received: from DB7PR04MB4698.eurprd04.prod.outlook.com
 ([fe80::c571:bdf2:afe7:c03c]) by DB7PR04MB4698.eurprd04.prod.outlook.com
 ([fe80::c571:bdf2:afe7:c03c%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 10:10:15 +0000
From: Ming Qian <ming.qian@oss.nxp.com>
Date: Tue, 15 Sep 2026 19:09:43 +0900
Subject: [PATCH] pmdomain: imx8m-blk-ctrl: Serialize power on/off across
 sibling domains
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-imx8mp-blk-ctrl-v1-1-b3b4e6e7e676@oss.nxp.com>
X-B4-Tracking: v=1; b=H4sIAGYZqWoC/yXMzQ5FMBBA4VeRWd9J2pLivsqNBTUYf7dpEYl4d
 8XyW5xzgCfH5OEbHeBoY8//OUB+IjBdObeEXAeDEkqLXErkac8mi9U4oFnciCbRjdJpFos0hlB
 ZRw3vz/FXvPZr1ZNZ7g2c5wV/xnttcwAAAA==
X-Change-ID: 20260911-imx8mp-blk-ctrl-c46f26783073
To: Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>, 
 Peng Fan <peng.fan@nxp.com>, Lucas Stach <l.stach@pengutronix.de>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Zhou Peng <eagle.zhou@nxp.com>, Xiahong Bao <xiahong.bao@nxp.com>, 
 Ming Zhou <ming.zhou@nxp.com>, Ming Qian <ming.qian@oss.nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To DB7PR04MB4698.eurprd04.prod.outlook.com
 (2603:10a6:10:1c::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4698:EE_|GV2PR04MB11979:EE_
X-MS-Office365-Filtering-Correlation-Id: dbfbc6e3-862c-4eba-f5e0-08df13118995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|19092799006|366016|6133799003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Ct6M5isintg8TV9rYcUcy+2el7McOAYFjyIY4QTMsYPxNJ8NEE5x9UrvWx5VO1uVSgrH3ZnsUJSnNSQitlPXpRbqBKhAE1ZHARs8xwnUOb0CdHOWBO6h2PmJQjjdXoqGPqDwyBWdkl+o4AKqJdqEhFY8tgoInBMx3iqhZ+EgIMMMeMSsggXQZx9CY2CyC7fg3giKXOvEbWl6FyDadavy9cCzrPDOENvWBb/dqdhefUostAEEsjBJMxwz8ikD4wwxd+3PU1vPdz9oN+MgQv4EKOD9XzpES2w7V43I8mdJPXxRX3LwetIF2K7L59JB3h0/3AJ6ov/E+2/6jwJZ7J505FhRxrMe3QNp1Id1SWWsjEPVNUZCpGqscKnQdU6tSMgd8yTqWFm4XUMFUPN1NHxzM5WdOlKhsGwGXphh6gYeyNC8YojH8kHb5Lck1bDJ1/PQWrobhavOgrzlhnCZDhmrJ3RP5+RuSubjACgxcthKT8rAW5x+5qYJaPvZu//iNYtdL7aYtAl26EAOYYVOYj3NNjySOxFxFFxSGnVbaOF3SVHwdMWaBuxawD+w6vxPl2a3D2oPFUMJ0POccpRwQlj7RT1SMWNPjslGjLipOOzZ3umTvBUUWcquyUMgGjeceNrHpLsUupspCflgAWu8x5+JSZARCKDDRmBO4Xm28n/FruM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4698.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(19092799006)(366016)(6133799003)(18002099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2hxRm1yMjZDaE9GZ3hQOHpKMFByeEJIbStaeWhyOUNWaXZsN0UzT1ZUNytR?=
 =?utf-8?B?eUxZd092d2hsclg4ejZreXRrT05yZ3JQZVZTRExUYzV0eGdwQlV4QUNXVTI0?=
 =?utf-8?B?aW4wTTRVODRFRzhlMmVpaE9lejlSbURnbS9MdG5WUnRNVUtqTk1leDlocUUz?=
 =?utf-8?B?R3FEci9jU0FwK3o1WWMyT1lmM1ZxV1JMa1VOc2RYd2d3U0pVdXduZndRYzA2?=
 =?utf-8?B?cWJ2Y0wwTG5UQVZMZysrUk50OVVYRjlFTk9PNzRaVkdFNlAxamY3K01KWFpq?=
 =?utf-8?B?WE11cWpnNHhTYXBwcTlSV2pSbWhzYTRKWEljNDdRdnZJOWlRM0U5WjNWVlJl?=
 =?utf-8?B?bUVMdmQxNzYwckR1QkhPYzJqSlVvVktyOElBM2hpZXpvRDJBUXRTMmxRQ2k4?=
 =?utf-8?B?V3VWWHozUmJTWTBITFNEazJidDBrVnZVYXErbnRNb05NVGVnYytHQlREMDJH?=
 =?utf-8?B?TXdUeXh2akZpc3BVMHV3enB4clpQMTNydlRCbnBseXAwT29CR3pqLzVQYWlS?=
 =?utf-8?B?QzhDbzFUWEtERkgyM0tNN1N4bW0xL25tbHJoVzlkQWRrVGVHVEZFRGU4SUR2?=
 =?utf-8?B?Y0N3d0JVUjNFbElYMGVJTG0zeEViS3dycElaeVNkcVdneUxsM09sTURHWU5E?=
 =?utf-8?B?RElLNmNIWWlveXZjTzY3Q3pTNEg0YTR4RDBsUTlrNlVGTGg4bGRMbk5hV09o?=
 =?utf-8?B?RXBMbGFnblIzRjFveUhwdGZJK1A4NGJMOHorTDNub3BEUVc4eVhLVVJLejRr?=
 =?utf-8?B?bzJrRzFDT1VxUVg0WVlSQUNFK1Q0cWV5TUdjR1AzdWEvdE1iRTBIWHhaT3gz?=
 =?utf-8?B?dUZJT0lIVW94bzcrN2VyNWxKRkRneklGK3FIT3NOZlBRVzZKZlR3dXBtZEZn?=
 =?utf-8?B?M3RMeU03WHJRV2dhVlRJT1FSbDU5ZHpoSGRFVEFPeTBybHUzWkEzMmNGbnIr?=
 =?utf-8?B?SUlvYTZDMWN3dlJpNTZqUmNHSVZFN1R4a3hJbDZOd2p1OGlTT2JqcWxwYVRj?=
 =?utf-8?B?MGM3TkpPUU9USzV1QTdpQnduWG5uT2VDcFJTNXR6RFI4S3YzZlhJYTZmN2VT?=
 =?utf-8?B?cnBDR1lnOU50UzhQdzVMckV6M2MxVVh0T0RkRm1IUE9wVk14NTdmYzRGQXlo?=
 =?utf-8?B?KzRGelFoL2YxczluQ3p6a2YxN1hndmVCTmM2Y3dKUFpjSTFhcmZBOVRjUlRB?=
 =?utf-8?B?ZGh6MVdXRW1rbGlHeGhQS0xKWVFwWVJUdVlCSVhKRWhJaVB2b1dISndhQUV4?=
 =?utf-8?B?UENWOHBrdHpmU1ZVUnJvKzhGbG5kWDlZOVdiSUYyR2xNU0dkRkpwajJ6VmFn?=
 =?utf-8?B?b3FRbGRUaUF5WlpicUFyblI5NWNXdGM5L2dmRUIxMG1xV0lqODJiTHExeWZt?=
 =?utf-8?B?TGVNVzVXZ0RHU1N5QjdEcGZtb2ZpdTRyRnlOLzM3N081NHZxemx1Qm5LNXFN?=
 =?utf-8?B?cERXc2pXTE55bTFudDJoUUdCSUVKTm5wYVg5TjhMaWJRREVWYnVMNXMwdVpC?=
 =?utf-8?B?MUNtNWN1SVRDRUpWcGx2dHNiN1NhNFlYUUhXOUhkUlJUcnpBRmNlQTFRTndT?=
 =?utf-8?B?NWJKY1l4djdZSXorZDVSTjZjN3g0M2FQWGdHN0FSNWsyQllKN201eU1zb0VS?=
 =?utf-8?B?QkxHUXRaYWR1SmREZU1UdjRsVUtYNVB4a3hZS2tsSDZXbnlOM3RwVkhsM1d2?=
 =?utf-8?B?U2ovZFhmejVZanBPMEZFQWpSaW5iZWl2SXNiSGlmMHJ6TEJ5b0ZFMkZGWjJj?=
 =?utf-8?B?ejI2TEVtMW1SREFsUG1qcWwrWldRTFV2SnhNTllSM0lPL2I2elhEeURMUkJt?=
 =?utf-8?B?MjcrT24xN25xVzE0dmp6S3dDTHhaZ2hWTzZJb3dGMVc5MDFCZG9DMENURFZv?=
 =?utf-8?B?NGpwWHIxUENPRVRkYkwzdWpZSEFNdDZJc0FtUE9QdnNWNkFwNmxqRyt2RThV?=
 =?utf-8?B?ZGp5L3p0aWFDSzNZVHR5OC8yM3ZQWitIY3BvSnZMYVZ6REFOVTJlRlBaaEVO?=
 =?utf-8?B?M2NtL2crTnNRQXc5bWV5SGdwRXJlRG5vNldCMTZsMFJXNlNjeEJNQkJrRFVZ?=
 =?utf-8?B?aFlZNU9LNWs5cG5Mcm5PaFdneEtxbnFMMkpEWWdTdFErb1RVbk5CdU44Q3ll?=
 =?utf-8?B?TjhCdU81RC9DZDJ1Q25tMHE4dVVJY3hldWtGYWlvWmRoSGNqZ2hERVhvMXk2?=
 =?utf-8?B?VnpmTjdJNE1UblVRcWFaK0ZGTHJoeHdFeTc2ZU9nVVhiL3NZYXBXUWFaTVRR?=
 =?utf-8?B?bXc1YlFVUHZyQWpWK3M2WEgxdG8wMXd1U1ZuMmtHWWFqdFljNndhWll0OEFU?=
 =?utf-8?B?ZCt4c0ZLbFBiRW1uQjFNR1dPSElKbDVkU1NTS0FQSnFCQTJCZGVqZXNpenZh?=
 =?utf-8?Q?I27SM8TfBxf75HkLx1Nu2F1EXaUgldIBWXO2q?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfbc6e3-862c-4eba-f5e0-08df13118995
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4698.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 10:10:15.6861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3WIQAteWn+ACkIYZE+WMuDxOWUIhS0hPH/82M9nZCwkHQBWskRk0chcM2AZNWTIY0EYOaYZo07geP96qAi9hwCvx4S9UCumkWPN4k/hpfHrHh6ibFMmUb6vY+q0GXcp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11979

On i.MX8MP, running the VC8000E encoder and the G1/G2 decoders
concurrently rarely and non-deterministically leaves a VPU stuck in
reset: its block registers read back all zeros. A decoder then times out
(G1/G2 reset failed) or the encoder fails its format check reading a
read-only capability register (VC8000E reset failed). Raising the
runtime-PM autosuspend delay hides it, which points at the blk-ctrl
power on/off path.

The VPU blk-ctrl exposes G1, G2 and VC8000E as three separate genpds
whose power_on/power_off are serialized only by the per-genpd lock, so on
SMP the callbacks of different domains can run concurrently. Each domain
only manipulates its own bit in the shared BLK_SFT_RSTN/BLK_CLK_EN
registers, so this is not a matter of siblings corrupting each other's
register bits.

However the sibling power transitions still interact through the shared
VPUMIX resources: the VPUMIX bus power domain, the VPU_NOC and the ADB400
handshake. power_on asserts a domain's reset, enables its clock and
releases the reset after a short udelay, relying on the reset propagating
through that shared path. The GPC does not ack-verify the ADB400
handshake on power-up (it only delays), and per ERR050531 the VPU_NOC
handshake is timing sensitive during VC8000E/VPUMIX power up/down
cycling. So when a sibling's power_on/power_off runs while another domain
is inside its reset window, it disturbs the shared VPU_NOC/ADB/AXI clock
timing and the victim's reset fails to take effect, leaving its block in
reset with registers reading zero.

This is a blk-ctrl defect: the VPU power domains' power up/down sequences
must not interleave, yet the driver deliberately avoids a genpd
parent/child hierarchy (to meet its sequencing requirements) and so gets
no cross-sibling serialization from the genpd core.

Add a per-blk-ctrl mutex around the blk-ctrl register and reset sequence
and the synchronous power-up path, so a sibling domain cannot run its
sequence while another domain is inside its reset window. The GPC
power-down is queued by pm_runtime_put() and still completes outside the
lock; serializing the reset sequences is what fixes the observed failure.
The bus domain's GENPD_NOTIFY_ON notifier runs in the same call stack
while the lock is held and must not take it.

Fixes: a1a5f15f7f6c ("soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl")
Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
---
Reproduced on i.MX8MP with an Android 6.18 kernel: running an H.264
decode and an H.264 encode concurrently hits the failure within one to
two hours. A VPU comes up stuck in reset, its block registers read back
all zeros, and the decoder times out or the encoder fails its format
check.

With this patch applied the same test ran overnight, over 14 hours,
without a single occurrence.
---
 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index 479789009c7f..f8105e87ea3c 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -15,6 +15,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/clk.h>
+#include <linux/mutex.h>
 
 #include <dt-bindings/power/imx8mm-power.h>
 #include <dt-bindings/power/imx8mn-power.h>
@@ -34,6 +35,12 @@ struct imx8m_blk_ctrl {
 	struct regmap *regmap;
 	struct imx8m_blk_ctrl_domain *domains;
 	struct genpd_onecell_data onecell_data;
+	/*
+	 * Serializes the blk-ctrl reset/clock sequence across sibling domains;
+	 * their transitions interact through the shared VPUMIX bus domain,
+	 * VPU_NOC and the not-ack-verified ADB400 handshake (ERR050531).
+	 */
+	struct mutex power_lock;
 };
 
 struct imx8m_blk_ctrl_domain_data {
@@ -98,6 +105,8 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 	struct imx8m_blk_ctrl *bc = domain->bc;
 	int ret;
 
+	guard(mutex)(&bc->power_lock);
+
 	/* make sure bus domain is awake */
 	ret = pm_runtime_get_sync(bc->bus_power_dev);
 	if (ret < 0) {
@@ -164,6 +173,8 @@ static int imx8m_blk_ctrl_power_off(struct generic_pm_domain *genpd)
 	const struct imx8m_blk_ctrl_domain_data *data = domain->data;
 	struct imx8m_blk_ctrl *bc = domain->bc;
 
+	guard(mutex)(&bc->power_lock);
+
 	/* put devices into reset and disable clocks */
 	if (data->mipi_phy_rst_mask)
 		regmap_clear_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
@@ -202,6 +213,10 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 
 	bc->dev = dev;
 
+	ret = devm_mutex_init(dev, &bc->power_lock);
+	if (ret)
+		return ret;
+
 	bc_data = of_device_get_match_data(dev);
 
 	base = devm_platform_ioremap_resource(pdev, 0);

---
base-commit: 6e30287eaf3e41b86dfb86df3b811526693d74b4
change-id: 20260911-imx8mp-blk-ctrl-c46f26783073

