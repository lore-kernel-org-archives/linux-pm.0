Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012063.outbound.protection.outlook.com [40.107.75.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECF134A773;
	Thu,  9 Jul 2026 02:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564311; cv=fail; b=An1K//navTPEnYrzVDw8zBZlKqo1ygHVub90oP2sBZV1nnSC/YJ0kiYFoHgSK7sXJxD77OZhXQnYCEPpKmsilZRlktXVZStWEo0TIcxGY+L5thExZKw3nvvk9BGSTRcOaCFFMxfXtMZZEBOAqO/B3WMMm8haZm+2cfaQkL3NGvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564311; c=relaxed/simple;
	bh=vlEJQEkYL2oL0EhvvjM6Y3NHMx9vVjDAbNvXl1vJYhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F3PwV3DTac6dNBQN5IfDZXRiWoxd0UX+FCpQqrYhXZwVirEmatApNBdv/wLTh44wgsZbrElW+CoexM+9y9hjsnIhpHpMyXbuglzbjjNakPCpYja5ntxBag6UuT3niy6C2L/bTNbaNRkV4xoH21lnUUQJgxm62rvfLGi2sDmUQGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=WzJiP74X; arc=fail smtp.client-ip=40.107.75.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="WzJiP74X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6EfnBbTxKsccW6zTRyYRKaeg6AbCvfoWJc270WiMwV1lGWvXw3X6K1MkrrnZZbIfoegmT7DcSlVkaDC97ZPsRI+wjTHn3xP219RAII3sckRaO0lpFXVNcpj4wNQYP4hK+7vGdjMvhNZ2ccV050Tjl40IGBvbAz6CE6JiW8dPocc3GLbuZryobWAghE33qCVOGiysOUTzJABNxW1LJs/TSW1hCd2hQQwGomAuOf7a2KwG80MjBg3CVPzzcwBmcU2W6D7SHrqBT4IbHYCQNJb6fhgFVb5wktJhUujSGBBNRHYQDJehewaFDHHnkK7ubiYeiaARAgzHabmx2XFE86iyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiRqur7eWpShNjhVCypNpQ6cXLhE/3ELebQc9+jjTj4=;
 b=zVIJsxASbPwM+8/bo3LYYQYKrw7cCYAqYdmzD1AmMmJUEyTFbdKAUc00T0XRJldyWvsRHfU9KQ9HTS6F1c5HHtLDU3uxdEJSWQ/MwKSIoxLHRLaJfSKxfalmw8yAgyf2mjTBzYdEkwjpTpRbmCW+LP22baUec41PdamMog/UCgKcvl6P2FhWpmEUbOwsdYW4FSKexq59C/dsbNKf/xXF26Tm4fxpsAQ9VK/X6JeI1HU7iwa178ZLKt8dEAVI5QOwU6eJZg1mRFWCyJijw1/jHvFmhAfoeDL1JCn+fLMFVKgOgS16WCIu3RzrERr8kDGsDEYyhmgzp3tLfk/D0Iv4zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiRqur7eWpShNjhVCypNpQ6cXLhE/3ELebQc9+jjTj4=;
 b=WzJiP74XaOwAROqbzPg6KYoeFKMqq4Id04lQFhOxozdiLg26evnTKIpyo3KBOSyTVENba+JMfsZhnRHNDAt+dzrgtjfojX4HgqSzgRc/zEQ41Lxem2zV6lQOTxH3yTouf33v6rSk6IHlb1wwb8SZEayY/7Y+oLCAleD0YhUE0mHkc7k4f5VRwnLTE5GFwbK33Mqvd6GI1CJGu2ecjVGs+z9xIfcxNztrsyMLunKP5fwe66Qnl9PhlQddZ/r3Dh7d5lmfXjXpTeIehFuU/HTy16t9Y140V+hx9R6gn+BdQm/vf6HuPnF90duSP6B3HTw7xeC5RPOsq9aZDmA8wM9CGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEYPR06MB6278.apcprd06.prod.outlook.com (2603:1096:101:143::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 02:31:42 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 02:31:42 +0000
From: Pan Chuang <panchuang@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 04/18] thermal/drivers/hisi: Remove redundant dev_err()
Date: Thu,  9 Jul 2026 10:30:07 +0800
Message-Id: <20260709023048.599150-5-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0ba2411d-b708-47f6-818d-08dedd623626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|1800799024|366016|18002099003|22082099003|11063799006|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	8mqQwoyuWsgoQTnAyzgUAV3BEpuU+011b14/wUvXzo88BlWRNa6Xj0+1na54pADg6/Zhff8pKq88QfWLZLiluLi2tljnQ4NwxgwY3gwsiUdQj+xsvDlwOg/7JG1V/db/T1ZdUuSm66UoyLgSvtjd1JxOZIk7Gd74boJOB0XCJ/xNjkQGTDJBmtQ8wi0+4ASDXN3irT5Kcd/WNVUypGXBjSPfiV6xkjVfWg6BBCfhCy6aP58K+ES7Y9ieBVjjcq8I7GLs/GeCT7lv64/Cmlik8GTILrvsDpA/RPGA0KS40BEn387kFggs/QJU5hfRdq364INS/OCQU1ijoYcPtHi0+D7efAd7A5bvU7z/xgdso75bbxG9CdaVATWNyEFltKuNG3BStAJB1ZdikWdXlkSRKDGCi9g0wBpFRf2VSut1tAYMolT7VZckSe+cMxMSerF4CVNSjDDXgSRKGpKDp5HEguM6VBEfV6hk5TfjkB4y5I0DKzZVzcC8grV1IpuxlXRQKdKwYEYhZPhFfKFixu/9uY4YED4VVPVGTmuXpfTrnitbK8kwso1dyysSTCtQDRhpZc1iLRrFQtK4YEc5IkQXSU8sT2lEsLF4OVuzCZWtrqdBLd008B03Wh54kFC7J14t3ekSAiepPBaSUL+TIvPtD0D3AhGs6VQfHRVe9PKujvBJyJQnh59/WdNOO8eEO9DaZW61dMjp+lSzxdRqVxEknJdTvIjnu8vVT3THTkqOF/U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f3x8663cLqxutHqkFTFJQEwxvOOEf0+iU6qwkX93Kuc0Tsl2zZ6r0ZCqGbfH?=
 =?us-ascii?Q?K+f27qjhAvZFjvbYaqYErYhvfsP4ipHDmqRlcwJ72RhNUNeoAOTgnTJi1jRZ?=
 =?us-ascii?Q?F0i9HS9faj6VFBGsBmxUCF3RJINlSNMzNm1wLoK3jeBqxLhKe+H+PQmyeq8a?=
 =?us-ascii?Q?ewyjVXip2IoYXYocHao5JkosFZu2dJoeDhkBzxZko0rt/lsb/8wLvIFpdeol?=
 =?us-ascii?Q?tF8gOEB7t6fS38aO3iiSE2JIBKwx2dEtVZatTEOni9Vh6OFW8jPmYuTnLsHr?=
 =?us-ascii?Q?wJhS6AS9bg3nRFFy6omVAbpplJbquzi1C8wxRnb0BM65pEaIx4Rntf+TMMKE?=
 =?us-ascii?Q?O4CzXcSO9wO99o1XqjkRYht/aT8Cv+3jbeS5hX0fm6bxV0kPNBNsvGfyjqWj?=
 =?us-ascii?Q?P8NazHyxk3k6tHsPkRMNZPdReaUX3JjcXTB2NTQGi1UNGLylZbub386vEyhj?=
 =?us-ascii?Q?mbJ3xDLSXtKd0NYBdXlFnclh9IMgiaFWrRrKuAtf2Ez/keuE+CYpG1tjs7d4?=
 =?us-ascii?Q?UHPisv/h+3BdEj7BOs22za6DUf3ptVZ8v4fzPlRl/VkFR6SrNfJnHkBNaIY/?=
 =?us-ascii?Q?ab9O5BpyMv7kEraGr+zCQGQe/hyhOuM/qNOI67gzGWzxAyyOniAzKbnoYPZv?=
 =?us-ascii?Q?DotMjaYK4srbgpwehMFKA4n4r4UzVBw/PlWpgp9js1ReJI4V04tmFNJtUHBX?=
 =?us-ascii?Q?Vr/APJdNcx8yA5aalU930mK6RwrTD0lrLUqqc4uf8J7PI8SVhuMU5/MDCCz8?=
 =?us-ascii?Q?cWG+11vbDa6uCqxMF9i+N+ePdDNVEipZeefKjg9cIhbRciGoetd9o/Y2tDae?=
 =?us-ascii?Q?hz8rfBVCJLP+jvw0lw3hk1obFgBM2p+YFSf1+MZqWOzmhqgyJvP6JC1RIKKp?=
 =?us-ascii?Q?lYesui3AqQgMyA63gurYtUWNuYRr04tpvFy/ScJU1QBviwokjc05NYObt87Q?=
 =?us-ascii?Q?kri3WabWtGYKQuq0T4huqRKdLBe91BB7OqsI0wscRAeKT3WhXHYtNiYDaIXM?=
 =?us-ascii?Q?lQtx26+nkYMyJM8dJxrIFJrlNmkhGq0uwjeb3IIvPJkEliIgRW0P2QX8ivoP?=
 =?us-ascii?Q?qkB7pyjzz0wTqmj+B2BvKlgO8htLhVmptRNvE7EYoMxmEWkCZ2NN3y8ZuHNC?=
 =?us-ascii?Q?Wr2j+cOaHj+ygI3rmE3TrdfNpN3P5enOCnUyeQ5pb4Dce9aKTWa6W58EP4sd?=
 =?us-ascii?Q?5uJp5jkEqmb6/TxM/nkZTiJphZAHAtJOux132kCE504MnlP2brxWsuzjWvRX?=
 =?us-ascii?Q?YdI9/YdS/r8VYHgFdTE16p4oZV6RqwTH+iME6Cc9un4P9eMyKAvvvy4IHgVS?=
 =?us-ascii?Q?3/AktKFS+pi6PV034C0fVEPSuqkwYN82b2LMxQnL8ocT2+/BJ9gxdj7HrEdy?=
 =?us-ascii?Q?gjW487z/xz1dirT4rzk7yDXePIXfYsCwuDsZlJ/toJnKh/jMChPEqsxsVznG?=
 =?us-ascii?Q?Us6ouVNZrdeYgup5QHqVq+z7CE3uUsGN++AM3xjwHsmSdZBVvqJo5Z8w+JEN?=
 =?us-ascii?Q?pPWaIUOr3NdVkspwHApeReaj+0rxVIZ0JZPJHANHhvCXl96DbB4g9Cat1KGr?=
 =?us-ascii?Q?UoH9wOPCmWKXDaR5YhkOAVQNveRjgy/SQLRxtiQaW6G8wLlTJqva5iklUIE7?=
 =?us-ascii?Q?iL1QnSQ/dGD3YFAnL9roquGqpfpTzc9fvG7IkSwWsDi5I8U0Psl+/W2dRwCf?=
 =?us-ascii?Q?BD8iRYTj4xPMm5x0jgrkqCNN+5momJ8l2Zc6uhf59TLWwKOiEoIxMMeV+wAu?=
 =?us-ascii?Q?8nJTEOnd3Q=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba2411d-b708-47f6-818d-08dedd623626
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 02:31:42.0065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 300c3AJH5g+/fsDf0bDnzvl606JItJ1TelEq+cyST0iCAtP3OOqJWmk9E3Mru5i8J04RbF5o6Fmdrort93Yg7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6278

The devm_request_threaded_irq() now automatically logs detailed error
messages on failure. This eliminates the need for driver-specific
dev_err() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/hisi_thermal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 4307161533a7..17ed0c5b7767 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -578,10 +578,8 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 						hisi_thermal_alarm_irq_thread,
 						IRQF_ONESHOT, sensor->irq_name,
 						sensor);
-		if (ret < 0) {
-			dev_err(dev, "Failed to request alarm irq: %d\n", ret);
+		if (ret < 0)
 			return ret;
-		}
 
 		ret = data->ops->enable_sensor(sensor);
 		if (ret) {
-- 
2.34.1

