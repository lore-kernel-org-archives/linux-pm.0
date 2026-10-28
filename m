Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793224582;
	b=KgP0yldJXgkb+jo3rtMCIE6kYpIRQPlxJnKotng00Jv0PxRpLVZYuMJ0F+9nqvRbQgRO
	 Fgl2MCS4ZdzJBCmYWnlEgDZHzZY6oAzBFp3FkyQ+JS8iCXs4+4i0Qlk6w2e4bJUGfs4GR
	 3TIvKKNYi+yu9eFgEleKmZwpBIjGuFeuxbkHrsbkN/9X5IyDXHgA4uWCN3i8To20+y8EK
	 OEGHmZmH1FHR28IDSji1qZ41P3d/a+7RM+lqxXakjn4O3p93dBNkIgCyNSDn3Xw1/Peo4
	 7ZPWrveLzd1PAxT7qa7Gi1w3gkfGGwYiuV37TRPMUEKnMgmrOccMuTgnqYcloz4ojvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224582;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=MtpaFdQ7hPqJN0G/pPs9WAdM/YiS3FKjmsp+WlP0qg4=;
	b=ZNBOJuZ6h2iXSPhVI3tQkncP+wpGKL3Tfws2+kAcDYIgISerCpBKNZrbaQbYnw8WfkQI
	 +MX3qDQcnlDxma7Nqt8dOk1YeY7Crn6MB6nPAPvNeJDCdW88fifHceFsu+WTqeTbbi4Vk
	 jLK0tSRjU9Se6rV3ioxcHqXvL1ZNOZLYz0qfIMkVZpUHrTlEeb4VuN3xpH9On45LvfNI7
	 e4wrLHBioBYIhcjI9vxzHOurxnScI2hhDZrsSb2XABOVe9vyFtHJ2BWYk2BpTN1h7Dfqw
	 YAt0GgoAkoY06NqrKDBvJr/JPVlzCgG6n78Bb+22yg1qfIwtxJOlmJueKXaXaZ6IofA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=aWBhRvck;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.44
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B7D606A333;
	Wed, 28 Oct 2026 21:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85B7D606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=aWBhRvck
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeyntteV+Lph6YVgM/SQpC9tf14IgaJxsR6nTOZLPlWsEcOAn64sX6kDOnvt+RKQOFPKPi88NtXwzclJHm2Y0l52TmmH+1NgV8rgMaYap6u5qJCehaad0lNAIWZVOG5SVEc6ANsliIW/b+atJi6O0sFx2cU0uPEOwra5ALNh9n2RoSCcrpPjSMMAuK6cHiIN2rn7OqkCC9OcS4iqzcTfHNDtdKwhqJo0Uz7im9dxx8jo/7dOOcgR6XuL+zLcWLNq5+UDaNtuMy9+RdGewSbBIGhhL2mAcX/oudo1kw+K0xaHQyA1RShd6HsR35t1I6AfCvGAuCLPfbQGU9ltQFxpDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtpaFdQ7hPqJN0G/pPs9WAdM/YiS3FKjmsp+WlP0qg4=;
 b=nqpbrRMIOiFgAX+3FWi1mHZgHpAFD80KD0B122ZAF32zqqTgBvaPSpucCIT9L/BBmbvfrqVPUz2o+mVafKDT/W7fAv+yNGc3bBBfERg9WRlGGsQpj8QLqndfYbMD3TTPUCVaykwZ3mvLmM55HMiYf7v9ZjE56VgE6RGqztcf6G2l593hI/Uy33LCnswptUW0+VboG8NLpqToUC/DInjmBDjjrIAWn2M/mJeyB59lpVrkMpFnGhUdl9ivJ1FKS98i9JU1KQEzSTYzLv0f+/IdT34wmHMbijco1E1I0yFr7vRqPPlMNnirKkt8cF99TWQ8O/ro+PGdW+r9GczRFqJeNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtpaFdQ7hPqJN0G/pPs9WAdM/YiS3FKjmsp+WlP0qg4=;
 b=aWBhRvcklwpnmaqDC9DrY5lSc3KUVBiBwSBv20tJi7JmCsj5FWrhgqcer04j98GuO7Q5Ij9VI5MTd18z1cwWVnQAn3uYvF3hmtNua9qRH8F/iIq1jaIK/qsrx/Jmeua0Q8Zx4Gzchct1vZOxC/e/MQaV0NMFN7mXkCfHiN2A1RM=
Received: from DU6P191CA0011.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::25)
 by AMBPR02MB558853.eurprd02.prod.outlook.com (2603:10a6:20b:81a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 21:56:18 +0000
Received: from DU2PEPF00028D07.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::81) by DU6P191CA0011.outlook.office365.com
 (2603:10a6:10:540::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 21:56:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D07.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 28 Oct 2026 21:56:17 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 28 Oct
 2026 22:56:15 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] power: supply: bq25630: Add macro define for IRQ cycle
 time
In-Reply-To: <cover.1793223841.git.waqar.hameed@axis.com>
References: <cover.1793223841.git.waqar.hameed@axis.com>
Message-ID: <c5a65c0505242d04d6c30e8fb7e97bb2bcf67e1b.1793223841.git.waqar.hameed@axis.com>
Date: Wed, 28 Oct 2026 22:56:15 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: se-mail11w.axis.com (10.20.40.11) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D07:EE_|AMBPR02MB558853:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a7607c-c92c-489b-5d4b-08df353e4b76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|11063799006|56012099006|261009223027099003|261021121427099003|10067099003|261021123027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XJT1yKb4xn9aXn9WV1XETFouS2lCTfV2MEaKwv/hUFctIKu2O7hDG4yfL3LhDew2dWPIur9eMfPqYg7YaY2Vj4lIH4qZqHkQW0H9Zm7FSoALfH69GM/7IOSHLnJIsvWaSECn+snDKSaZoMrtKLbK/4N+zFuFia7XhEyXhFZnpBrsLqeX7W+tqGgDhWnfARHX3WblizO12e7Ze8Tg6DjdAEFPXvAP/+XdbFXfxsR+89h6u6vdMowBHymOLdOBLH2LPt6jLX3LP9vyWj+r9mt8vjN2xv4t1G/skEBC4Ut1aYepDk3OV8XGdlYgaoGjIJiSnfsLXZjjnAntpQSGgf9W2RoJ0X09WZpLEmPM4ajrNixbjO88nAEyp9iAee3vWJDeNnBSd+6T9mkVgfm4nmfkOJvnPcrXwfiXyKhMGI7hHi9MrdyRoor3c5OAbYWhu3tS6PQQct9SWaiV9V3ak7GfMz10p0LP4BNIjQ956vVzLEfI/VoEhXLYcG+PfpmfPCBcmE9ECYhtKN349aiYed2/++kAkAJ2wjGva6eJhWQZ7MTsCJe/Yq5y7p7C5p33xTiIRAUJKBsMXG0JUeVmSBxKs0lKc5Km+TUWXmpGmFXB1s7mc0TaKckpV0dUKzipk+Vu+6zyGVmh7gGtjLcOP1kfN7rZvvlyXi0cxnr374FCGd6hRpnMmjhxJJXwHyncfPbtjgOTn/zm4x0iNVv6/41y9w==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(10067099003)(261021123027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	P+3bbgLEhK1VQjglQ3B2DdV2GTQyhEQXyFd8fn13Phmfe0qtaIxfxFe7i3XIttNX6MXFtFsAdEgA9oGTSKdyJXPlpNAf//Ahq56EA9eYTKIMsWEhu0/3TB1Kao+H3DhRKGjPoJeVe8QKnl/1nclZEqukQd4UCiyZBbeZkQElAYf2VPYgPg0oy52XQCUTW/6zQsliL2YvZUa02qXkTnDGsL26MfiOhWCjsXnQLJSU6LvuYol+eCIvHX4tstNuxwRGuNd8m+n+7BAWKNVcSnUS+Y/FrRxnDf+eapnfxgr+ICVnTldMqf/DUanoFtr15TAaHt26m70BC4TZx3oe5L1xRHlljHhhIt+baCOgI62XCKplLUrb7MMsH5L5xp33aqHF9eJbZe8TUHHnmOqIGE3l3P81lRSnMy4QYf5cSGEIGVapi0JR9s9spieWWNT0MKm7
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 21:56:17.9685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a7607c-c92c-489b-5d4b-08df353e4b76
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D07.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR02MB558853

The interrupt pulse time of 256 =C2=B5s can be seen as an "inherent" proper=
ty
of the device. It is currently only used for when polling the reset
register, but it could/should be used when polling whatever
register (e.g. liquid check). To facilitate this, add a macro define for
the interrupt pulse time.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/bq25630_charger.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq25630_charger.c b/drivers/power/supply/=
bq25630_charger.c
index 3106da710d6b6..a934f3deba63b 100644
--- a/drivers/power/supply/bq25630_charger.c
+++ b/drivers/power/supply/bq25630_charger.c
@@ -15,6 +15,7 @@
 #include <linux/power_supply.h>
=20
 #define BQ25630_DRV_NAME "bq25630-charger"
+#define BQ25630_IRQ_CYCLE 256 /* =C2=B5s */
=20
 /* Registers. */
 #define BQ25630_REG_CHARGE_CURRENT_LIMIT	0x02
@@ -726,8 +727,8 @@ static int bq25630_reset(struct bq25630_data *data)
 	 * this register field to 0. Try reading it for some interrupt cycles.
 	 */
 	ret =3D regmap_field_read_poll_timeout(
-		data->regfields[BQ25630_REGF_REG_RST], regval, regval =3D=3D 0, 256,
-		100000);
+		data->regfields[BQ25630_REGF_REG_RST], regval, regval =3D=3D 0,
+		BQ25630_IRQ_CYCLE, 100000);
 	if (ret) {
 		dev_err(data->dev, "Could not read reset register field (%d)\n",
 			ret);
--=20
2.43.0

