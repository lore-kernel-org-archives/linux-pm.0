Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012049.outbound.protection.outlook.com [52.101.126.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FE438AC83;
	Thu,  9 Jul 2026 03:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568098; cv=fail; b=JJ5TLIzxCBIl+gZRS+OMfi4fe7lNB8a82smaYYZ71iWo36gO0amM7q0XiYMy/UQJlcUWD8BBcVsPQScgb/07Qf2YjT0tGIOh4hrBIXQfHTPEiUBdPnSkn5GBqJ3xOPv93ib4mbkYQLaEo/BntUWIktvvFsQqJm5nNY1qfJeOLEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568098; c=relaxed/simple;
	bh=+ZDfC5ZJakKzx4oYGEisveT7IO1l8SIEBLewJogcS3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D/WZnTEvfmWadLMP7y2wY+SGwos0+js3D5Y0T+USdrOuV9phX4jqtCi8482hsVBIlTDarXLeaIuGd5bVRdgrHncn1yfpjqeWP8Tp0ouWb5uE9vxVVTTbEDtQMNY0nLVhJjFLTtz0TsWaS3WmrS0IXiRDedvBfrdm6wc1W/1xgfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=lOC7nXQZ; arc=fail smtp.client-ip=52.101.126.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lOC7nXQZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uennrdBrZ46ZT+uFfknW2eQqOwogYuU+c3cj/AXxZI402a580tKYvtZf1I5/vInUUi7vzxsR5X2SKDbK1GMQKArLcRbZAit/k8x2/1HPaxBNpDwmKTwsYinH1j3mY8OnGlG4R4nE8Yt+xHMCS3I9V8pmdA3Y8v/l+AyxbaWLrNYUh7kDhVf4/3gZr1X0QsOXZ2dGC0dJIbOj037/hRfV1ZYkMa8+ycQD9T20Z2f72hHNic5M/0T9mPTqRlDfq5FBA57LuByAHkFYrP4a1oiPtv4B698yYw0ED7C0hPVmagB14EF4LkaS7sKQP/n0Ww3kQLL1NtQNjAAf0jKdtYg3iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spXrlhc4nUAfwHBWpn3xUXbl9nCDLyKJk72Qlu49JHs=;
 b=bXemQZ15hDdziD3NBxbwrKggLpXxA4EnHe5ZSI6Itw6SE6zqo26GUittEIRVzcQnHGq2zzp/DGZNmHk5f1kxSrLOU8Xfis60qS8dH1Es7PKqAx0jtRpMjdOApp+2KtD7E7SdhY7AnVU/t/6EZMiXxy3s9s63OBoLO1ewdHex9uWb/sORyZfYCZdOmsie7juMva4TNx0FXHnyQTsbX9FhFB0DZc4S9KB2jsmVoMok33vjNS38GN9/FMPpYZwu+rC1YRL1JX3a3zieaUmAia/ZhWj77xukVeSgX/QozfQ//7Puwx903b1boII0h39U0L/VKcMsgvrCnh30kOPjv3TAxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spXrlhc4nUAfwHBWpn3xUXbl9nCDLyKJk72Qlu49JHs=;
 b=lOC7nXQZ+J7R062NizZp586bT49Q9VqUlxBG5hfClEwLouKti1a4RUKr5yYjVwmfkTzgH5LPFckp2LclZQNAjTaWSUhQ+AHr8yQ9WSuDODFPjceATiZDXCUYOq7untlgnCYC5SM+7K8BEQhn4+LjBlGR5ZdHqYVyqrml8a8KLavI6O48VulfIPl4wKbuI9meXNNJwVT67j90iAcrQ3GBi/VIHgCSvfSqLmwHgWaWIHY9sKj21mVpkfKxElx7mo0atpP3CdJoTqSc4kmZUeOkF+zoakuzE2rZVAWU7Ffe/ssSzxUiw4xfPmtfM+a+TW2LigLvKudB0D+Zqj4iVzxQ9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB7253.apcprd06.prod.outlook.com (2603:1096:405:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 03:34:52 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:34:52 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 02/43] power: supply: 88pm860x_battery: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:33:41 +0800
Message-Id: <20260709033428.362970-3-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709033428.362970-1-panchuang@vivo.com>
References: <20260709033428.362970-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0017.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::9)
 To SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TYZPR06MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: d191c9ae-1321-49c4-32ad-08dedd6b0975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|52116014|18002099003|22082099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	08FXpBP8pLxzRTEwtrZUUWZOnujzVxY1WF4lKQIpM6Fefqw7jR4E7aHcdUFJgHuwoI16N6Nio2m9fEKoCYxp0FHqvCkc6j1j7/KFxP9TGC0mYuVABZdJDJ6HhVa+6bxo69J7lN/N4gU02kUKMigpefuqfVwNK2DjbpipuDcfZ1PVNiq80DXs36Y+pD5eFpIPDpuQD6fmwucDJLuXZfQ3KsLPtf/WYXqem7MY2z/cbKIABTF0FlRubsjrGvOcGaQkh3f8q0HdwB1OQUN7mfePUUnjyuHOlAEongm4u9U7LfME1xrtqEUzSAt8v7ASOWEuKhqFm/CP3vl7ENEPSUKLlhyHp+fbWrxxPPFt49FyFo1p2uHbzmBr5TWx/kQXlNGgN0qKjZNv5l+RpshR/y98H0CFn+RAjKqKYpVSPz4XcqfetdN2RHjP6ZdPErdNOSDotPNoi8CoPbGRpGRQZ51M/QW72diHlABQp2NtckOfTqJlYqb5Fw9BEMQVsodEBpgvpUVcm3dfc2caiAzJrFKfRV1oOGqPWOTN1vMkIk92S3yO1B6RJCBXHPx6agDaybWWqU4+vRmVqEwbYgAgTDFJwwcuNnlMhmo6zFFAFLDq8MrMwGdJV6QxZkXR2KAQWJfb/5pa2d7CSlZignCh8GZ36vzhKbWoPiNYVrA5rEzzy/aeINiqR4rM9BAsywrCS7bB7ia7LPZbnU/KjQnnyxg4tMDF16yHpuXbmuIoirJt6T8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(52116014)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?afByQ1F4wUc5Ciw0/ecI8lBlzcHro+j6CCoddm6M4BkS0BVMRkGw+CiUZ333?=
 =?us-ascii?Q?iE3SW3HMdCqvlPyFxWUSF8ifHRnfdgx87pa3q9Led2GFR2PbCNIIE3cYMpJV?=
 =?us-ascii?Q?fDRt0TE5+3NaXGER652T322ckc5r412pKWTav7vrBjqByVsZgXFAqSc0F+ZT?=
 =?us-ascii?Q?VkhLVCesRMniF7X+0p/eOatmlv9OEBBHMdVepUW51n0/cwnfH6ipf/2VXO2E?=
 =?us-ascii?Q?kd52UYfnKE2xvYbI1padcRLxlqLCClfzBg+recaJnfMhAUYiNqf59DTA1bZ/?=
 =?us-ascii?Q?rfY7dhm+55YYmOUnQiRgJe8bnPoZUPct4v4ywK0gN7U5eVZLR/O4eeJhjXEw?=
 =?us-ascii?Q?Y9Uzen3BUnLSh2ugAAV1FVBrTSG0rk8COQY0pAnhpE1bJPhBOdsVOzEnGMmm?=
 =?us-ascii?Q?jQS7js49Pu0abVQQ4fE7PWGMOow65vW4hekp/gjpKhzNPObM3UZG4q6Eqh63?=
 =?us-ascii?Q?stTsIiYvMe2ghXGaPJjkb5stil5Pt2DBFHgkvxHtZxEGKjG6ZEBYuRZdWiSV?=
 =?us-ascii?Q?X10RgaYNo/Bm0SudsEScjeuT4syMsS2RozooXtr9HsdG6hEKXIlCg87ob85P?=
 =?us-ascii?Q?Xdh+glyY3ccr5s63Vx/0hRlqg3Jb0PJ9666lYn7iGKey4oKB/aM1Zw3/aHYG?=
 =?us-ascii?Q?ESHxdg/TOapRjGzjwUq47BWZBYnWRh3Lp2K4iaV6rrWRNCeI0FFsmvZNleLN?=
 =?us-ascii?Q?yGbiefbxQHD/YVTyTDS1kjJhgkGcQAl1801EStniTiSpgeQvgD+oiTVngCoo?=
 =?us-ascii?Q?BKZ4T6rUwXW35b6bcnuq1zIXadMLuth2IhLC28nYkO85JNABCxv6/RfM+ugo?=
 =?us-ascii?Q?erjR6Wp1pjoTrhbBeAR/57Ltz1o3+iXNQAAuYi/qjbb/jfmxRmXNLNj2bZ/1?=
 =?us-ascii?Q?A2MG52O9nvPhTHcfRSpgkhJRRgoGcLMzt8IitqA+6QdcjD3sMYjwGsdlSoHk?=
 =?us-ascii?Q?trsSlHm3rXFICqv+XADJ9a0Yd0yFUwc0NX3vHo2GgDCGViEALf+od1oMrrPW?=
 =?us-ascii?Q?oGhqEvSGHPBWgurw8ewUq8lwAVE5+6cNwftMII+PKcNRYPr2lBo9Ve2EGh49?=
 =?us-ascii?Q?Ymri7SoGsQhsR02xHBp638uLPmsdMVRSntxIk/A5ZEaMetZdCaxu3gZaZhDc?=
 =?us-ascii?Q?taezt4yLLpBzjS1/CQ/++XqQty8wm0fzXXlCsDTng9yhKgfMTv5ZyHOUBD6A?=
 =?us-ascii?Q?uOn4EnoxBQuwH8UBl6r6TKs1N6X6hrlvhfg01PlWvxN8lPDW76qb8bikauKp?=
 =?us-ascii?Q?wEy2FjXlUo/o/ETkw5TuDdI24lYyVmDD87D4AEkeLZlDOXh/+y/YYtSbbkZI?=
 =?us-ascii?Q?MTuMRUXnMU9cyxTFuj5htnXODxe8fibuCNs8s0BAbIv+4U8AeyHwhbeTLJ/G?=
 =?us-ascii?Q?0L+V7/ZHBJnD9OajoVtCI8pjTp3cxLZlOrptePGYkBwULdDhoMMsnKmOuiMh?=
 =?us-ascii?Q?UUbOB8feLCErFlTU86NtjRP+VwLqboyaXfTL+y1DNBFl4IV9vU3OPLSIiGi7?=
 =?us-ascii?Q?z9lRLyKp06Tu6EUvlteexPm3wWt1MeKnXT5QUsP+/mUcDvqROpE+UqjMKFgC?=
 =?us-ascii?Q?e4XV7wizZVSzVI870SGtr+c05DXMl1j0P1110S0VfnLJlEbvFavmhwvcG/Sl?=
 =?us-ascii?Q?3Tv48xFox1M1Fg2B2MTaa2AN3PSgrFKeyXawbXnRY2D3siWp9TfHmLB/OVWD?=
 =?us-ascii?Q?l105dPyFutTATqWBQqT/maQikR3OxVWJ5bC0MJ7qQv7VvmtzZRbXDNwl+QTo?=
 =?us-ascii?Q?lpDskhAXlA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d191c9ae-1321-49c4-32ad-08dedd6b0975
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:34:52.4755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Xx3ysyZW5tNryWFy1ADxeCagt51o/QNz3P2rZEDtRiFWqRIZd2Qpee7eLr2kC5h7V13uBrLKs6Fr1A3+C7liA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7253

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/88pm860x_battery.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/88pm860x_battery.c b/drivers/power/supply/88pm860x_battery.c
index edae1e843c51..8d93c7a6a5f0 100644
--- a/drivers/power/supply/88pm860x_battery.c
+++ b/drivers/power/supply/88pm860x_battery.c
@@ -959,20 +959,14 @@ static int pm860x_battery_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(chip->dev, info->irq_cc, NULL,
 					pm860x_coulomb_handler, IRQF_ONESHOT,
 					"coulomb", info);
-	if (ret < 0) {
-		dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
-			info->irq_cc, ret);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = devm_request_threaded_irq(chip->dev, info->irq_batt, NULL,
 					pm860x_batt_handler,
 					IRQF_ONESHOT, "battery", info);
-	if (ret < 0) {
-		dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
-			info->irq_batt, ret);
+	if (ret < 0)
 		return ret;
-	}
 
 
 	return 0;
-- 
2.34.1

