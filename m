Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012049.outbound.protection.outlook.com [52.101.126.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A314D38F930;
	Thu,  9 Jul 2026 03:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568111; cv=fail; b=FNnB/WKC2bTrUjM1LhtZKjWH+1NZ3Qu6G6wVxTtRehLWhzvI/guB5p79cOuQtWI0wmTLbJpkm2o3w4zI7IqqfxUsJpZ7nvTxbKbGnUN/VMYIDcyqIFgccwJ6bEAsCJ9zA2f51ByNGQ2nIEGR2sdjUJ6LQzBpbabznDqxgkAoGNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568111; c=relaxed/simple;
	bh=F3DJm2WXfEEJX8Qxz5Uaa5+sm5Do5S0Y49GuWMoIPIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SIMYMCPSBgwyX/u2SfDeUkGaTrB4EgBw729I4d9BqBRhDSa8KdofsSr4VVHXZ4JyYQ9dwbZLrocpjqQKR8XEAUj3EFo+gxpDKuq78uYmjlD24rA6HbiYi4hBiAgTQLitrhEP42xG+yFIdXDbPiYy452FGN0HHjXbiCU8YYEE1mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jlVCHukL; arc=fail smtp.client-ip=52.101.126.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jlVCHukL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDOdXXAHF3etSGe9WgCqI7ZzlYt3F54SGDDZd9WD7CRf9WylfaKc+f6/RSVktYZR6nyctUhYTzyebeoXI7P2Fuqn+QNFKgkgkp6+pZ7Wj4qMCPjOKCjHgYBtNYzGhQm/PVT4hQWJCHUrdjAnclkCu/+GfslHuGbYBM9P1qo+Wdbcp1fwff6zMnp+7GIXaW+taa3TGfgyi+9WX+krtiSWEtz8zjoULg/q/XyGGR7mAP1MqKWT9qpbcVYqRJCdsvEnVZ0UMuYKp+ePgdDok3rhogSfMFJBrXKZLhLIkDwT9he/bzqkasBTSnPkfbhkd2z7XbQBhDfv45ZZzuwZmg4acA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+1hKTWPt9LSHo6FmUliX3Q2Zu0kv4H8zO4gt8ip6TQ=;
 b=mXvnFqMjCZbo7Rw3edIUbAqgyXuSVhBGSTCpjT4ZDhl7Hoeqvte32pyKE67xf3OGKtKEtIbhl+x27Dl+l+aakN3AE33UjPgIYSGukl6caEKjypyF5Cnu+uJxV3bJObGOxKn3YHKHPtFLlvG+yW2CbUqbuHL/ZS70WFt6que8Q9/kztOPzLmY/bSs4oeKTYK1Vi017ArUYi4iSoVQEVwIdGkEKprGzJc9x6bJtoQtXM2aUUGj2rJbn+RA+hjs1QfpbyUqJ5gld2vZ2CM8y5GnDwcM0EolAlynLmEGpQWyYRutXE/8Dr1u4ZO0h7IslRvl9PJhWzQMvMS/G6uO1TAj6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+1hKTWPt9LSHo6FmUliX3Q2Zu0kv4H8zO4gt8ip6TQ=;
 b=jlVCHukLKXKajLI/30GhytSGWp1phDyInKR495R8NPByaL2JlSx9qRkmc0fjDBqxlrAKK0bbku2txPrm3/kVNQiQbx1AB1ef/c2xQhvBXHvZSYcFY9HdI5MfIeEhqjFGmQF6+anrQJUTZcAP7McvTX/cHH8tL9sxj7opZyKQBPYTnk2FxbhjbUXMfXrWliItAGu7y5COCxAUWTEpKkMPZE6ocGJNekVpb3zkMgYi9rO6bRGjUwzND5uTA7hc2EwuusHZFBsy6Sdbilgx/NqSa+xLNdcFhpC0lE8Q2OTPYBEaP1pt0F+tjAlQ7AbHCDSjlcceoUviX1a93jmysvIBHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB7253.apcprd06.prod.outlook.com (2603:1096:405:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 03:34:55 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:34:55 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Linus Walleij <linusw@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 04/43] power: supply: ab8500_btemp: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:33:43 +0800
Message-Id: <20260709033428.362970-5-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4eb0beaf-dfc5-4060-331a-08dedd6b0afe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|52116014|18002099003|22082099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	FsXBc5UBLfJFbJZj3f7eUoIsf6ND6cqBHIyDGuyTaAe8fJfxzfPZ/0k/SDNYxFyWCnPQB1tRdFB7DUE9fQN4XLooFLIRv2GJAHIVn7GHkRci/wliiBcoxcrT635nJkDiyg06PzP7/DVuB8zLSJjX1/4LRh9uDNWTUxAAnlIJfU0kqAFc7CZAjnjV24EqITzxxW81gpVQK+cZ9jq5SakV1hhNkhM7tdVdeSOhkMaDsUd83wElWmUBEndd7F5mRdf1NmyXkaCyTiZb7PhqrHrZ+bJotttzYJ3FCj10+++GPPE3OJTO6SafSeYxWxr4JLSnXFluvBWMJK5I/LPtKPguDB6GQnPQTg/0kz2pOUW3nImXVmRkcne3d21F4uLcZPsH0BHXg14QNhDcQdPt9DChNc9lKFv+UDS/QYqudx8hOUehj3clI/5YXc41Kwc9rUrivtDWY8qv/omZIKEbMtNnGsi5ISgShZFJc3Yr3K7+RT2jvjB5RPTL0SFM7rVZELR0pjb7jgU6zDOymXyPhoGyS36NNyWhNJUe6wqO7lUhlZPfPchE81CY9tB+fwPx10/6t5IZ1qJGNq79Y4j3MDpJ0sY2E2pLz3FArEfLp6aEVjgWGiIqMz7wVOROOdlBB+8YM0iu1VPaNNp9tMucNPWn1fRSsJJdhdoEvLU7nCWMg4UvnDrKHb9KCiWuh8ooWa46UiRMqBGpOhgQXreCQOwW0sXhl6L0Cdw5Ix4SuYIVIlo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(52116014)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r8WSqleRtpFYaM+kG0CTEeaPc6I3WJF4Gj/DlFfnIPA9Yc5MwgVj4FQ1lBzh?=
 =?us-ascii?Q?aXyT5P2E/WVz1cXOU9OaBHVwW0f4/P2M+bTwkcrDlZNEHOh3iv1kUDIq78oQ?=
 =?us-ascii?Q?O/FWPHowQozcTekfcLMtm6ZQV/EkLPqvHjEdeEuC/ZDaMUdWyuejRpn1fs0H?=
 =?us-ascii?Q?OuNqmuJPq0U3fTxBK7aae2orVs0n5szjjcDY9BRgyg0xwYvm/he995s74CdP?=
 =?us-ascii?Q?QdfMY49K5dYu+Z3Dm91ffnFpN99P43hL6Vu4l2E2nHdNpFo0GPV2sLFUCAKa?=
 =?us-ascii?Q?11prf6n7Q8/30EurKP1fwLShAAe6u5E6TKBxPP/jOBEfTtuQvwV2llRSgtO3?=
 =?us-ascii?Q?+zENd2LiIqKI4bQzjfOlupn8QtvJ5NAsr4nDuLSSlMEbtlm7dYNxr6XVh/Xo?=
 =?us-ascii?Q?u5tb2c2mXYSWQoL7Zs5PCDWBLB5sssaAr2VFmR1+V/eqFb1RXaom43hdAx3d?=
 =?us-ascii?Q?iQJBHHx7fYiMi9oMN+RTGwCo1MJY6p7UKXpqu6mUSv0aKs1fkBOHfFaojRSo?=
 =?us-ascii?Q?2Qy6ueruLqKCYE0mWnbjiPS/7hWwI/mA0jo2dbSWmIIRbN5bHBc0Ben0UP7V?=
 =?us-ascii?Q?kY1P6ubDpS61hvKWccHTirztNkOy2bxRPbHADGPG8zBnPp4KSukPN5VjXn1i?=
 =?us-ascii?Q?y3rAZdbO58ZP6JM5+Xa3/+s5gqKd+nVltZdv+CdlBvws8tZIWYiHAuzq+XJv?=
 =?us-ascii?Q?HpkHhOXqkkRZKJ0ckyjAmpwNGozQTt+rHSHIw00pWX5FgPlqFJCuK3A0YKy2?=
 =?us-ascii?Q?5UV9GLqhTR7xfhqPt9JH8YwnSwFjJnAZKdvlsKaVq9Abh7fMnHtTHbVXMmYl?=
 =?us-ascii?Q?F5V+OpdFe6Z0yCKHqh+ekcC0QPPI94jnoHV7XvJkG+dQQdDXhKg+aaQX548F?=
 =?us-ascii?Q?aqp9QEyevZjk32wYyDgZiKJWgZM4eKnIAwT7/aLSH55R6a4C6SxvQ2htmIL1?=
 =?us-ascii?Q?AeNR4yRtBZF6DBmJze4/KZY9S6uAUUVnDsWKJpfJgnLMdeOz46Be8HPXARJg?=
 =?us-ascii?Q?KaJFSQEWMjl+3ByRHu+7OK+eZ3ttuY66zThM2oRkZ2ynZ2DKrzVtzRzoMfal?=
 =?us-ascii?Q?mlo0UDmPEYJCc/o5+N+HEW0DvxE1JUQkdSHqu77AYUL+p1qFT4twYxSvqBZa?=
 =?us-ascii?Q?LaSIswJz4Por0//2RfyCnhqSThdljDGkRGJnqQ9Pw0LzJtfvsgVS0EPIvIYT?=
 =?us-ascii?Q?lLJZl3H1wdhzApBr2sWcBkED9yAs6uqinjcG1nrH6gp3pDHwTu74Igaw5u1x?=
 =?us-ascii?Q?WmhXYo60Rj1Xv2GhaQAINAwTyZSRW9bd4eG4Za8QyKLIqKJXHVp6Uy+abTl3?=
 =?us-ascii?Q?7L5NK+gCVbScjX4/thl36zhgjCgxvKRauCKJjyDEX0RxZAfQy/FrdPflOY8s?=
 =?us-ascii?Q?nm5SlDCQtIbGB2Z4NYLlCK7J1271XrD1+kiem7etzbUKHuTea4vLadgVrw39?=
 =?us-ascii?Q?52baeqLTHpjEK4EO2cLJ81FBaM6c0vC/JC4BVqAJhrhuSd6/F6PKfuGNHLRG?=
 =?us-ascii?Q?spbp2XoWZHEgmRdrf06kIl1Wk4hKk9qJVMxDMumlzFT1ncctOA2HMUuXKwAG?=
 =?us-ascii?Q?bq1QZXH4Q3unelMAsuhldVhqXOj2Jvspf+QOWa639TMVzvz/H7IA+//t5qOV?=
 =?us-ascii?Q?6q+85KAZmCW7mtUrSp6KDI0otPKeeZwzxBJwksMICkKeJRouNR4cXtVgmzaI?=
 =?us-ascii?Q?l6Djy5fKm54GeYWpPBhQb4KDW44mvRZkav4DeqztYBoffa14eRfr+xhGu5By?=
 =?us-ascii?Q?awi7RKBRyg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb0beaf-dfc5-4060-331a-08dedd6b0afe
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:34:55.1573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFxXGWbvya7StU3xD6cjjk2t5hmmXoah57qFP635ylVnv4GuR2qmpQ7A9geOe+Dffrr6hmYO8wTTjaZrbjDS7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7253

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/ab8500_btemp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index e5202a7b6209..032140bd6682 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -787,11 +787,8 @@ static int ab8500_btemp_probe(struct platform_device *pdev)
 			IRQF_SHARED | IRQF_NO_SUSPEND | IRQF_ONESHOT,
 			ab8500_btemp_irq[i].name, di);
 
-		if (ret) {
-			dev_err(dev, "failed to request %s IRQ %d: %d\n"
-				, ab8500_btemp_irq[i].name, irq, ret);
+		if (ret)
 			return ret;
-		}
 		dev_dbg(dev, "Requested %s IRQ %d: %d\n",
 			ab8500_btemp_irq[i].name, irq, ret);
 	}
-- 
2.34.1

