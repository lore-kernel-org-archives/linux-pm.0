Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011016.outbound.protection.outlook.com [52.101.70.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8827740DB40;
	Mon, 27 Jul 2026 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155360; cv=fail; b=J9IUsvEKUz6jH0ju5f4DrsIR+uKtIUE4ox6TnKgTOwaLHpXr6qv5I5+T8MJtuwzrV+6Hpm5yay9LergJp5C0ohT0lk35dgJ+NHMf/BeGfCTRoSQLLLYa7oypsTi4aNkoyG9BO3b/NOIDSD/bzjnnido2lRMkQ10zNLgIknUDvyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155360; c=relaxed/simple;
	bh=AD1EOnml7lT2ZCMJ6wZdERp4P+fNQgSzyGI6cx4ZVQI=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E1t2xUlUlC703BgZ6/kJOpxVT5ZriF0Lcaef7G0fAExaHcaod/uAmCZsj7YaOBKWI4iJfHwiiRIRwHhuhBAw+25sUkfUx5furFzPJuCpcpAqcP3VWufbPvlLAfZJfK2ycKWIFeix1xnAXktHoqneH7KLjAYNaCT3aW4+chKEvcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=IBUR+n8k; arc=fail smtp.client-ip=52.101.70.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="IBUR+n8k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XveR6bbR+8FTeZpUhIUbSOgRV8bxXhfoV72JpUQT5eCqyCdFjJqIb+2r342H9etC6hmDKn9nvS6msQLEGQN3/O6dFMtkeIEBLk2GVxwQ6/DqAQnCl4OI63GlFforLwT+STYMoPBYj0+OAwm236CGMGPZ3Bg8OKIJDumooMDp93+dkJsnRHozsOvicvC1c1OyGS0HCXNFiZCGRiEe58frRrT7xA2h020KSxBE8oP95DiL2Q0zLJaT9G4QVW342NwhZPE9wbWT7fgQXHS9fbIg49R9Smi8cYWN3jHKtBpjOu86gWVty2JV5Kf1WKNoNqE3au5VJ+bsaT/Q3uQyYqp6rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tfcqKH+mT+3EheBAR38k5qT8tMyx5J6PlQxdqj6xJ8=;
 b=lLwpa17tALygT1yEfLKlBCI9n7O3VUHe5EW2B03bgXrmt7dveJ1iAspW+vD9D+OHZfAlE8PbtxYyHSBsBOCJ5Bd1z14zTonOYZnHONsCquYrkjxD9Z1ESopihcP3tZm+DjeT2eeLbsKzVSG0Znwvw4hAgYIT9vTINMIeZF//R7mxR6SK923atmqNDF+apC6xY0ax46j6jD7JYHc/MNW1g3FLfLuI59sAFA6nk5VVdaUItF/41dAdDm+TNDDy69XGUcoE3sVss0mv00gZa3J0Hd+eY/SRI8rik+IAC/iSKigXxF+QA5dTkYCgLjVbI/7AdVGxA4oIO+Aeq4HBElIhYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tfcqKH+mT+3EheBAR38k5qT8tMyx5J6PlQxdqj6xJ8=;
 b=IBUR+n8kS/5a6FlvomfSJQ8cUgzg/pC6UpJ3DzKfr/dhjKdabC7JMHWdEjzqPFF0yjroCkxPvtIrnFILv7tvcEj8pI5mF3z0opHuTbQm55+0LcF2aCCba9DVidJmetffbRStmEDWCguTdJ+Skvs/l8subIJoHRClFkynORpIsFk=
Received: from DUZPR01CA0074.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::20) by PAXPR02MB7312.eurprd02.prod.outlook.com
 (2603:10a6:102:1cd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 12:29:12 +0000
Received: from DU6PEPF00009529.eurprd02.prod.outlook.com
 (2603:10a6:10:3c2:cafe::34) by DUZPR01CA0074.outlook.office365.com
 (2603:10a6:10:3c2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 12:29:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF00009529.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 12:29:12 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 27 Jul
 2026 14:29:11 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
CC: <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] power: supply: Add driver for TI BQ25630 charger
In-Reply-To: <amQD4oydNkzlOIeC@venus> (Sebastian Reichel's message of "Sat, 25
	Jul 2026 02:57:51 +0200")
References: <cover.1782683551.git.waqar.hameed@axis.com>
	<ca5228dc74705adf96f0af5363ccb65bb965640b.1782683551.git.waqar.hameed@axis.com>
	<amQD4oydNkzlOIeC@venus>
User-Agent: a.out
Date: Mon, 27 Jul 2026 14:29:11 +0200
Message-ID: <pndpl08obu0.a.out@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF00009529:EE_|PAXPR02MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a500ae-4197-4cb8-51e3-08deebdaaa54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|6133799003|18002099003|10067099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	W/g4IuAjnAKsgGt4MAcB/xHzeEPi+G3UyAV/nAFLg3RHd7ISg7FQnkQPr4PVRXpMayaPp9a60s44L+NwbVVe/VoNHOvNWTty5ojDVmok6niOtHF1vsNine1QZH/4z7KmkN0ZULcsIrFsFJudl4CXFYmcS+MCNbJv7TaTPHh1F3T7KoVgybw5Va6muCPt5x4owakzdDKgHGqFEQebqCs/aoWFquE4oo9rD01h9SIKGwyedjIv9Y1/I1LflI/AbIhuOI/knn0Xk3efyeVPfEXpLvAzWIdSaqPCP1ea+huO+zoGIMZ8KyOP5gzG+9jhiScY22iFrXvH1NZsSu+mk16qGjlh4pRdVW4W6IPt36BKOyRbgBhB27gQX1GdUvRQ/LvFjazE+9I2RsSqdZMkairv6SfTwFiHGm6dt0zqQFwfNut5kQrpJnCgu/UykDAGwEIpueLuUF3uQFfO7PZ4rAuEJmVdMTPHvUBexsiqWk2nJbByMVKWQVLz6dcfRHsEzQH8eo2NW9ekRlNJODArJxXPUoUkgn0ys/LnjMGfyvD/gYWTQ7/pX/otstjLjZ44mrJGorT9mcJNvl4fsPV7XR6vMxhpObAvGesE9f3rYWNGMeEnmvyDiFrfEYOJegFvmz0W5j/dL7vtUhwWTRHctJkxvQnEXta7TU0HCT3XOlvY7fxIgq24dL99XjcgQnp77Sw1hIDMWLsJPyZF0qekvW2o0g==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(6133799003)(18002099003)(10067099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MTqenSigi29BPxXei35rLvb8phDp3A62+lkZmxoEEfIaaAe2blPmAzxEHZxuvL3Z7vnoq70pq3UJidhJ5ST3oDe0HXZeQjy76NbgvWt2KPIXELcP9XU75mN4L0fqYfQHSoQGIiPfxrBh/k3xEZfKBMdyOHiEBC5y5Je5v/GQ4jeU4/kSwe5jGEOFpXpTQFnTAGo8pcII5bxQZeufx//Ci0/g7l0RGvVzNcaNYdCLlz1ZtpYmdY0+I049GD6dS5W7gr0Mz1sZgO0V9L//jAP8FO47qbbRbIpyndmr/a9jk3fVTiv4ZBOeDaZXehPGISb0r3+rex0CAFXhlJweWpqn1WfG8JMD7ygdbDuwrlSBa57oI4zDabRQLNxYAq0WQhjwIFPTizLtx9oyeonxHaVWhAFdtfoxZWkWnNjHi4EH9x04Ir3vKFOBdatXFLticsM+
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 12:29:12.5760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a500ae-4197-4cb8-51e3-08deebdaaa54
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7312

On Sat, Jul 25, 2026 at 02:57 +0200 Sebastian Reichel <sebastian.reichel@collabora.com> wrote:

[...]

>> +static const struct power_supply_desc bq25630_charger_psy_desc = {
>> +	.name = BQ25630_DRV_NAME,
>> +	.type = POWER_SUPPLY_TYPE_USB_TYPE_C,
>
> Just POWER_SUPPLY_TYPE_USB, other USB details should be done via
> USB_TYPES (as you do already). I just cannot remove those types
> because they are used by some old drivers and exposed to userspace
> and thus ABI. I guesss I should add a _DEPRECATED to the in-kernel
> name.

Yeah, maybe we should do that. It would surely help the next person :)

>
> I will fix that up while applying.

Thanks!
