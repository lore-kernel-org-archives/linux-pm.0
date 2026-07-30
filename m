Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6448E3C7DF5;
	Thu, 30 Jul 2026 19:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439329; cv=fail; b=PwRb8ReuEGwg+dAh4V0qgDveO7xrMeFUf3uJtQdL0TIZxLxs0lyWNQCP/xqq1VS2jmKZvePMpJOk9ECKSjBfej88/SX156cpqoXDkphKAJrW42xVg6nTjhz5k6kEWV72YuTQ/GxPZigsRrebMWcTHdXVU93LRT5Ol3MyfyrlOrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439329; c=relaxed/simple;
	bh=3wwY9rax8pSPpcZ9pHrxmH92W6fGiafQgDRTzVjqx3I=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HVQyiLTqWPeeSn5nWdWWVZwxT/2kEzvbBtl3FTCZR7boL0lJVxYFMrA2e1sYExclVnIMcuZTwX2PD0yLGUY/G6N8esnZDH/ZePt2mL57DH2g6A9ub9NXSIN4JCvf/xWEyEL0wKkD5oeNDKcrMQ4sF8Ansd6mIkDAATBfFpKL7G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=TIn/byH8; arc=fail smtp.client-ip=52.101.69.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="TIn/byH8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCP5A1x6q5FnSBDsY1ZM7kEcSQB4SJL+3wDxf75j4DHVXd/7TVauruJgYr23cM17P23mn1EmiSm45zDFrT78LtERM656NexcVm6nyWtfwbBlevaW74Pqx7P3cewrS/gGw5KrBVfy67tM755ttDvSqkeeHCW6idReRAe9pkuHhIt9XBjD7WsnM7rpNPwJwNJOIb5hYPBfhLL+ZLAaUhS4myUiYt3QRV40wLVYq5XyU3t25W7RC3F1wUB14C/SU8q6dsycKFMFAAMexiOK6ROFrtBTHh0RUO+1tep+SQGtwItcS+ktM3wX2ze6AJrLsH4hmZrilAdjpX4S8kwP3DXQtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wwY9rax8pSPpcZ9pHrxmH92W6fGiafQgDRTzVjqx3I=;
 b=x3dGBT5I16cTG4UzV7fHvz2d2lq7eny5fVm89hkCyQC5wYEU4t0WleOqjiRv8OBpR8TCqcOhzURy9OwQGhRPlVCOhIywC1EJOS7MzdimZNbpSJ2ytst+M3uLwxVbQkJqi5uwhFZTlpyWwVKEXXZx8sY7hnSt9F56Q3X7TazOS1pmj4ZIOuxTkC+hIKWkmTT1Clg0ITC19nfJCwFA3wE2wYdvw2CRMdc0oHanccyz3iNhhxDfdHs2eF27oLCRSkehazQMBPxRYkcg584BdBXMH6N75xxnYsblzM/lozcME+2w84HzAu+t7eq1sd/n0v3z7CGZLxHyhA0YFe7JeykuVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wwY9rax8pSPpcZ9pHrxmH92W6fGiafQgDRTzVjqx3I=;
 b=TIn/byH8a6WPVi0a6+Hpa8ksFP0XiBDSMJWDmJzo/ODc3/qKYIX3cSCriLk11v4gIvefjjWYeeYExan6Ks8YJkg2H4KMwbnz5CWqhcs+B/TbvwK8AZs3cqI6vxiX0X3Xr+21lN3zU75UDzDDCTOlmtaEZ9sBWYJsPavZN6CzaDc=
Received: from AS9PR06CA0014.eurprd06.prod.outlook.com (2603:10a6:20b:462::8)
 by GVX0PF4E0DC6E54.eurprd02.prod.outlook.com (2603:10a6:158:401::b10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 19:21:53 +0000
Received: from AMS1EPF00000049.eurprd04.prod.outlook.com
 (2603:10a6:20b:462:cafe::6d) by AS9PR06CA0014.outlook.office365.com
 (2603:10a6:20b:462::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Thu,
 30 Jul 2026 19:21:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF00000049.mail.protection.outlook.com (10.167.16.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 19:21:53 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 30 Jul
 2026 21:21:52 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Linmao Li <lilinmao@kylinos.cn>
CC: Sebastian Reichel <sre@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] power: supply: bq25630: Initialize hardware
 before exposing the power supply
In-Reply-To: <20260730011713.3332913-3-lilinmao@kylinos.cn> (Linmao Li's
	message of "Thu, 30 Jul 2026 09:17:13 +0800")
References: <20260730011713.3332913-1-lilinmao@kylinos.cn>
	<20260730011713.3332913-3-lilinmao@kylinos.cn>
User-Agent: a.out
Date: Thu, 30 Jul 2026 21:21:52 +0200
Message-ID: <pndh5lguvu7.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail10w.axis.com (10.20.40.10) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000049:EE_|GVX0PF4E0DC6E54:EE_
X-MS-Office365-Filtering-Correlation-Id: f18ed586-7099-403f-1464-08deee6fd014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|20046099003|22082099003|18002099003|11063799006|56012099006|4143699003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	eks3ECF39abxlH/0vR7bILYgsGE0Z4tWGXWE3dLXYUskvEmZvGnY1rxUcIGdl2SY1eEcIchupgifXaMAlmjDrljI7xOfyjD8znJto+QoHY35YCdXkOOSssKdHgpjb9GlQVTGrMUCE8Wa+vcabQR3lMRd6UGzgdXneI715W+OCuE6YDLN2B0pBfZGmHLHynLiux5+uYa7S7jtnl+UIxxQj7ZGdKntL5PTkui4/GhUDC/SejfuMrNJ7PYQG7hqhOHG3hWQM9OONBVepxrMe+cDyPT4C9YJ28CBX/rMsrmGu5x1p23JLFLJV0rRZXY4IOCpQiVQSCfm38/c6Rgwj88nNAUHU8nxlww/nRS7Nyz4MwKgwF9IAKsrIEwk86QC4LvUyPNfhX0EXBKzLoLLMvLI4/cOHzdNR43lC/LOkCCGMvwp4U4v9TbQrtdC14Bs7I0LJhUO+v889FB+Kukkk4LiKN7JXKcDRvgbttTdmaTJFkqJvRlCBve7Itspd7G0CKYP7LYZVwSp4rtgvMsuJMK67lxGoXMqJl9Jip6ECAsGF5h2nIsgJKqsKInLN3R6hpLu8lwGldvrhec2qq4aa0+m8A1pEfdTzszBThM7nK3BeFn6PEbJskD4Sl7DrZfTv6RZBCWJ28upmhsttkwMNqXr36xF6ylNx1oTkqtMCKqRbW4a8EMW7rErnQicAMQTc2h1f2/3KavjZAbp3IIQ26f6iQ==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(20046099003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	imZ4X6jwgEXrQV9uRpDVl5o1L7J0bDJ0rUPxzroq9b7hacWTABBOb77MYQiWpsceSFnQJGfGP9yRAw2dmFpKAOBleopjkLAtmVHGRjzAmiR+ax5zKieO3LbBo/tDE0Q3JHe36Sri4uIOIj8/SDO/6KO9vsNO5IaUQj5uNuyb8G474giSrBoBYHYOjrmrDO6Csny9qGpdBdBlV8qmAx4Tl4EnGQoXx1SuzBo28UQ5JSKlSd9fMUl4BazrN+v/ge7IE/AgQtIcN7jtulhP23RsiJpSSiUA5Q7L586xUXp4bv1X6L0CRrG/FfpNtAxMY8PbLQxCTf+zqhRUPeanTxKuhRwN4x0+MgMxkocG8K3hd6oXUr5+elJo+uvDaH/GVAqiKCB1tLuELGkrvKBLdHeNf7jUAZxV/xw46c8d8zBa/ZA+d4a6Owg1+LnFqhDRe+Rr
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 19:21:53.2553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f18ed586-7099-403f-1464-08deee6fd014
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000049.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVX0PF4E0DC6E54

On Thu, Jul 30, 2026 at 09:17 +0800 Linmao Li <lilinmao@kylinos.cn> wrote:

> bq25630_setup() resets the device, disables the watchdog and programs
> the charge limits from the battery information. It runs at the end of
> bq25630_probe(), that is after the power supply has been registered, so
> the device is already exposed to the system while the hardware still
> holds its power-on defaults.
>
> power_supply_desc::init runs during registration, after the driver data
> and the fwnode are available and before the device is added. Use it for
> bq25630_setup() and drop the explicit call from bq25630_probe().
>
> The callback is passed the power supply, so take the driver data from it
> and use it for the battery information as well: data->psy is only
> assigned once devm_power_supply_register() returns, which is after the
> callback has run.
>
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>

You didn't include my "Reviewed-by" tag? Anyway, here it is again (there is no diff against previous version):

Reviewed-by: Waqar Hameed <waqar.hameed@axis.com>
