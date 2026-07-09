Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012017.outbound.protection.outlook.com [40.107.75.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1950C3451A9;
	Thu,  9 Jul 2026 02:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564336; cv=fail; b=fh/lu5sLymYNE+u8JvGEpEyU7B4COGnzGbboU4MQ4cEKYuf8mDKHSC+RjKuqt+JWAd+L/j60htAedpBwPGhwadFSGnyFmmHjS9mTZotyyr1AZuDH4YomSYoEAWFykK03uZXYZWjYGTpbwmCZXCTucHYKX+9y/anJHQJM2ZVumj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564336; c=relaxed/simple;
	bh=FxRPTCjjkyg9aOcDcBcn+gwj/jnKnAXyrWLBT+k5y98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aJjMRLxlBqFGjRSRCLEcXP6dUasQoKigWiM55sAqjSAdeyHK9Hw7hXyYSiM0sb1wq7TN6yI+MzymWuPlls5QOVEkfvgjHV0pFPFkvNd8dQP5fdHjIu2+vMbeUhsdSv4u3Xq2TLKZ4Hm0Lby4HWhURdLeujR2+0imtaoB7TqqWoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=B55hH/P/; arc=fail smtp.client-ip=40.107.75.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="B55hH/P/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CdwhaYXrEQM2RklMTGGhdn9pc+U+jwDbgR+blbf5rQ/kB6As9MFxpeBuyCQjtwyZ1w1qmzdCpVmrMhKLXyTAYC9CUNhowGp+CoRlNASpZ8dhbBv4QGY4GHv+8l7vdsYDVSKm/2rr7NbBaYkTQow/1aablxMPtrqhs0HL8P85lOzJAAvHRFjloFu1+cCrwpUOkqK8yAYCWsx5/X30/IslwX4JWQfOZDBrlMp+0PpcqNdwHwp5M0oQUmdyB4LQW8qgRCQB1wHAKR5QRtiTu8Ih9hU9MU5GkdUC7nBl6cjsLh5/clvXb40A7yejAoSEy5v/QEZ1fgjB62ALQMhJr1Mguw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktrXpbKqZqG2gAYmnuuNWG0PT2PdUZg+yG2C8Xc49wA=;
 b=Qbnok0ck5DkRde0QMYiDkq125gO3B0oEHJdjLsHTOYa2p7YSkaxC5kTPMZtBylKuE0YgXgFJSjX+57KfKi41RtqbhPLwSoFL8doiD1UQwOpYO+vGULw8F7MXaiclN+TcjabYskrMtfaHnBmDy07qiI4D//xqE7AdJGEC+SGNtRF23v7eS5J1u/+rDuHPgvjvl0N/ZriZwsIwcFAdY37xZ1znFbQNQhLre2nWQhl/rrCWCLnUPULtL2w6VPGP5Ht1Yj8hv7ciWw1j4ABYbgceMVOuc9/ECrJZ9wPVCE4D6EcULPSV5d6eZTRnFgRJtFVGPZy7sv+wKaSFNK7EjUgX3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktrXpbKqZqG2gAYmnuuNWG0PT2PdUZg+yG2C8Xc49wA=;
 b=B55hH/P/Uz9jWvagbrEK+Ikolp1flw6Bk/f4f2l9TfCqmGyWiSVOJAQx+9tVuiED7jq+4gc+SnVvShl7w+eY7YwuKzQ8urSh9ex/UNucQvx+nOsx8FLI73hrnGOlWmboJNNWZssD2jT2BPnNbYgkYhigh1SM5m9Ow9DIRl5BMBC7k4Jle9kiRdCKBBcdE7qwmu69RK/d5eVxIv3LZH/UrogvOEne9YIrlQSh+CHupTV8NWV0Li9YbbBXqBxPv2mpUhcIuGPwkqgRyRhHFS4lLVyQwkkz+ujpYn0TAiJ1JyJsBIAD7Trcy54aFqxl+f4M+K6iur9NH3w9Z989RPGDlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEYPR06MB6278.apcprd06.prod.outlook.com (2603:1096:101:143::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 02:32:10 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 02:32:10 +0000
From: Pan Chuang <panchuang@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Laura Nao <laura.nao@collabora.com>,
	Mason Chang <mason-cw.chang@mediatek.com>,
	Fei Shao <fshao@chromium.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support:Keyword:mediatek),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support:Keyword:mediatek)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 12/18] thermal/drivers/mediatek/lvts_thermal: Remove redundant dev_err()
Date: Thu,  9 Jul 2026 10:30:15 +0800
Message-Id: <20260709023048.599150-13-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709023048.599150-1-panchuang@vivo.com>
References: <20260709023048.599150-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0019.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::14) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SEYPR06MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d89c22a-ed6b-47e8-0bf0-08dedd624748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|7416014|1800799024|366016|18002099003|22082099003|11063799006|56012099006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	HQFqOn5yl7sSF4CYI74zr7JL3BuEiwP5w04pAW7qH3xEFOBPG4daOjiy9YEL93zLvPMtf4eRixXLhRBEjd9wka/VyG2mcy8PItcHhSVsWzNv+3Z4PhbL4ZIpAMO7bN5uqfD5XfK60f0hW7scbicIO6XmsvtPCowW98gu+Q1zxExCP86FrnEtCul+9kXmf2WSnk5MCTlm5U1NqU9Tp4mTzgNPZBuakv6MEdE9kzVkg2xG21ZAuOqhGWVQMLG1PopG13+mD1mih0O8dKa1oL8EOzEDhyHyOu80Dt0rezU4QtcR1daZ7fSjl9by6aN2m/PIter7Ta9A8MHh6hy8yfUoJKsk/e2Acl30z54XbvzATn/Etk+SesO59YWYV4BNsfxnOIvnzHTJFRHYksMIwVEL3Hfq1HvUnBt6oNxQB1NVjynAuu5+a0TsCN54K+jDsED69xmLSF3QWjVKvVcwctUPtzEe2iM3YkpZs8g04ot7Bfxk6+sm7t6se89wbcWdYXPTHcfocwv7nZf+dBGUsSvHOmVI+5uYW2TEmDEIIi601cV+/PbULTMUbvlBspWEJafq1qKYcIt6Z+MALvnFarHWvhMHGJDxf1kBMbQYjrlU1JR2jjWwH2HnwuHGgs3u42e5/2OMaAZcTMOH/Li9wcf05kB9L58QEd8hSFsMxH5XpbSF5cEyWgNKM5OtpuROGRD6tcih9w2l8gOsOflO6+ju3x3gyjnavQx4YcNzIi3c5OWXBAm7k+uM/U2ZgJDn3yqX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(7416014)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mmg6TUwHE0cWqz1JVLy9fG5ZrXjVT0LdUg3fOuAzzzgPf+qp+xyDFamrCBC1?=
 =?us-ascii?Q?jitfEZO7+ALlu7X40EMYrgatpRsFOB+LmUE9rg22MQ3ntRMfkE3wmJzzVEpq?=
 =?us-ascii?Q?f+/N2DPh/FN0m3sdLyFmHC5gpccPiYjg6hy59oYfgNv5oXnrQjTNjZvE6aaU?=
 =?us-ascii?Q?adroVI3lRfk4FVgovvWnFJJuK/o957hCtobKJfZRiZaGBO1IIu4EunmIYnwD?=
 =?us-ascii?Q?yZw7+h30B9NNLBh6W0hFVJSB4SUPXfYdGUfp0dhXj3GoSaBKORqwDidKHRxW?=
 =?us-ascii?Q?3MqCsbWZUo66Wgj5Ni9a0G2hroGIyJuIjuk4/tqPgUfdrMDteCYJld4g4gL9?=
 =?us-ascii?Q?lofFY8Ji12D8UqXQ20GU2DZxtG5prjHPnhmjErbaSJvP8yaFPQTCups/ZUto?=
 =?us-ascii?Q?C/RjY3osH+p24R1QndcqKhgCQ0nP+lCRDYqMvJE/MY9rzSjimeozYWrgk01v?=
 =?us-ascii?Q?BBSnTiyiR7yK/uB6u7S+aYwe2VbkLRrHroO0vQdCH+BlZrHTL4vNISZ3qCUT?=
 =?us-ascii?Q?kh5abTDu7eFc+qN/SPbqUZmRauTVfGgWIMXIK98uMWoW/q3CdkudZi7E2l/A?=
 =?us-ascii?Q?afXDSZnFGOy0+uSSfEqp1J99kTBFQmypwe6F3fLWjHgNDOrbaUugom+4sbfM?=
 =?us-ascii?Q?g9dJt4QUVwrTiJwZ9SKoslJCQomWEWUiaiiIsQsLpNNP0huwpveQkpKESG2m?=
 =?us-ascii?Q?hm4XtsOb1N6KxMd/cHKxEk5LB1u9uOpMNF2CRx2mLuv0Zx1oWUNAO6yKAl4O?=
 =?us-ascii?Q?HlAQCDsMjGh0DVPZ/BF3IMEArRQ9h8/mBELN4C1bvfs5OXvCYdKQASfpoq0W?=
 =?us-ascii?Q?9R9dxGMp/MikW/G4sYtIyKv4dtwl1Hy5RDjLBHwHvzuoWqYvbzfae3j+wfxC?=
 =?us-ascii?Q?23bEolwuAT8+B/2oOQTM5CcZwVXsl0+mLPpa2c5vutsk2T5oh6afQTg1kGCz?=
 =?us-ascii?Q?U6aealFncjYdSAtudh7XSrVHjxr6bP96WKD3BRLBL9vSDuH0sSTnyJSrvh3d?=
 =?us-ascii?Q?OmuG4X4yRmR+0c+VTCg95CtTmVkeaev42rwjp45BJYuqBKoqis2X4l5xLeUi?=
 =?us-ascii?Q?N+JWmz6cf9C4Z8z+HZaeHsiSuhirHAquFsEUWNVks4ezdISEHwjJ40jPwZkw?=
 =?us-ascii?Q?Dn5bZvFxOP9aF8bVmVv+cpm5qIxZQAg62PEO7nuQ4ykoQzLZ9pd/WzdY+TCa?=
 =?us-ascii?Q?JeXV8Ee8G1CgzZyzrqTL4wpYnTXgM9+4gzHCu/6cOVj+U6DQvEQ7CejKfJZQ?=
 =?us-ascii?Q?DkbRQdPDow+R1BD05wB0WMHag/+VyAiWEGulG0C9p5jP5pJwKdaKkh1KJ0c7?=
 =?us-ascii?Q?lx5ePMV115ieFhrO6LWL5CXAVfHdCZ8fhVORAq5q8VL7jpynDsKuAFJ/VO2G?=
 =?us-ascii?Q?bstquX4ynvLHOYp7gchb0CxIgb06tNYRLXpsIS7/ZKht3WPUBWv7dQ8pp1xx?=
 =?us-ascii?Q?upTdBtpCl98L+YyNl1GqCOuPy5EYSf3RYRqYr0a8Dwlr5Lom8i7fT4fZG5+u?=
 =?us-ascii?Q?tR1vZExaKc+YGB5GHO89aLAVfD3Dv8L21Uv12Vievy+aEU1/Xb5kxL6iJO4h?=
 =?us-ascii?Q?WlIEghD1nFuNEBSuZazjzg3NE2Lh5nfGJMmN81yDyr9E95g9tkdOdhDe8/2O?=
 =?us-ascii?Q?bs6ZBUXNBT8M49vSctwk/YyEyhuKDYCZn3/4VF6QLImwwbDXZ+rxwq5Edspu?=
 =?us-ascii?Q?wKjRJVS5sJ9jiqBdmqb9kCQ0XvsZ7G/agD2Nr3Rggi+K7ztALPh+EJruEDS2?=
 =?us-ascii?Q?euuSYPgLnQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d89c22a-ed6b-47e8-0bf0-08dedd624748
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 02:32:10.7964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5L4MAO2ABt8SJ02KhiyFZchStDsF35w2/IAdDCJWEuREOVXqeGd6reT+6gv50CykTBwGmaJGTnKnksiE84M4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6278

The devm_request_threaded_irq() now automatically logs detailed error
messages on failure. This eliminates the need for driver-specific
dev_err() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index a9617d5e0077..d357968f362b 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1491,7 +1491,7 @@ static int lvts_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(dev, irq, NULL, lvts_irq_handler,
 					IRQF_ONESHOT, dev_name(dev), lvts_td);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to request interrupt\n");
+		return ret;
 
 	platform_set_drvdata(pdev, lvts_td);
 
-- 
2.34.1

