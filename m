Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013011.outbound.protection.outlook.com [40.107.162.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E9A38553F;
	Tue, 10 Mar 2026 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.11
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140924; cv=fail; b=pTBSrFPmBEhJqyuy4ubIyZC4zboCQcePILy5gKeRfsNXwHUoeM5+HLD3bBgH22kCxlF5DvE9mQ3GwLCQxUUw86Klc2lu5sNBn+r/wCkU84ougjAMaqpFGiBUbrR8scuiTazE8eZ41/7YBk4n+6um1i7g41OfzayW5palri5TjRs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140924; c=relaxed/simple;
	bh=iql14QYbI6Hg2wYL1c4TyDAk72mlvGfqvUqUiDzDt6Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hb6Q/+98Mi/0npVqssbDmWEXnLjRIk502cFbdPBXxvvEoIcTRWeMRnAfszC3+RyN3i9iAM+T0Y9Xa6ggjJF9wOHgRINrHTKJJkskY+Wrsk5bcA1vehGNG6RGcuNHAkIC4mydXq1oIb0Pj7e8CH5MWlJuLc/U57erQW2nT824Fjs=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Vd4ZG391; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Vd4ZG391; arc=fail smtp.client-ip=40.107.162.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Vd4ZG391";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Vd4ZG391"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=jTVVBMmUcNaFnulvTQ0iPUsq71aeLj51n4I06vD5BLaoN8rsFqXup14SwsbWskZ63xm+G9sFu4axXy1R/oczxX3+Xs5pIGA/ZS7fZQHAuhR8X+J5Ueq9CMtnslSMgA2dcbDvzBM2Nd/2U8p8/MS+w5VCtTxFwBvDy7vQAFgZVTKcYs7wqwIrbB+lIpXn3azRz5RhPNHPMZbzRz6PLG71ZommFJa+LDk/Zz23XUcQA5Q6xd2Ai/vUJnoE3OxV1mJPWMXGokJbRWmyheFFYaaTGk7r/LE5vUuODQjfLKsn382xylAgoRQ4hL1q4L+hAf4UfaWNgnp4FgJaKpz8RynozA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONnnaC+LJDRQUQHUwe6krEhZIKTzUm7YO/1+k3dpULI=;
 b=UZNW03BJaaGVdNjQUB3K/ZtarcjiGliqDOs+0Wqb8vz8HjItK8wjxUlt9ZlmNsVrqiRAavjJafxoD5xvUgvt/LZ0d3Brz3sOqQwAtJYMbTbLlKLEMrNxLsKlrm+JHd+7Ej7xX8zl2Gs4acnef1gtBxnv6LNupXUv0VlzPVbpH4AT0tRrdnI9QXgbuLkTQhELCPP1HUJoDGK/9oqocdFXQZ7or2HbG7rqzZrYBWol2S8EYveq7lspR3OJeZM6Th2TK6V/aJkjgvohEr0Yo0lEKl1nGvgI/7NkyrLnOgXtnJMHFUEEi8alk0Ep/uPOB2LchoxtaN0acQPzHLPZwYPkzQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=hisilicon.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONnnaC+LJDRQUQHUwe6krEhZIKTzUm7YO/1+k3dpULI=;
 b=Vd4ZG391Bni85j+6WDX3jCG29fHQ521BmNResqwYEu7oy9XmTJxjqfTi1IvhWfR2hVT0oWKMd3n+KbJrkFiSxqR/+vEuxLRIZmO0zGpQ4nvdkQ1kfgQgC4/JVqwD1PYJUKpQwaN9nVHlQzadzTjjjY9s+0z7QPyFfKU4lbIDTrw=
Received: from AM9P192CA0025.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::30)
 by DU0PR08MB8637.eurprd08.prod.outlook.com (2603:10a6:10:403::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 11:08:35 +0000
Received: from AM4PEPF00027A6A.eurprd04.prod.outlook.com
 (2603:10a6:20b:21d:cafe::17) by AM9P192CA0025.outlook.office365.com
 (2603:10a6:20b:21d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 11:08:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A6A.mail.protection.outlook.com (10.167.16.88) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Tue, 10 Mar 2026 11:08:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKqGPnYzocvIKCr+xh/gI0lNau5vg8JV54yQnzEFSMD49r1rSmkLlk0T2nvsfMEY/iFaihe0F6UFxhGaJoauLZO4UpKbrKAoAFbXwFg8KAiHzNjxFHDItF3WAfI69x2k9mbMqBSJTY9o9BFY17X+8utCRRMm9OfMtEqcADnXbSq+Ct1TQ60uqAkqVpOwKwDibNpktwOWNKbJg+gcc0N6scmnn6In0+Q+jWEfXHGPnRKvquU2sf82rNftNvkMd5xknVBYHxHpo+rybBAzDBcZjsN8kSPndDpYC/pAeCDq82WD0XpLCJ30WO/ZxwEae1SFx4GmRlJVwbVfoFir+qT4sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONnnaC+LJDRQUQHUwe6krEhZIKTzUm7YO/1+k3dpULI=;
 b=XujXEG0BfchboKkYdoRpAHBb5Q5YnS04YBShCQsfvcBCfOXT7bt+/3I4iKFNpUxPj0HSk4POLhk3VXdMCCiZthanNkDlGS04ll+FQRbSJOU1PhoHkEwqgFzf0QGxFiKDlnF59eGYAlVeyAi5Q2vvlIOYvusTiZ4HiXJOsY0G5PfUjhanUSNC0pA3MphKaTM8NLAjfOhAvEAYaQboeNmv6AQXkV3os3n+5MU7fPW4vE6+okCHBkjDFYm2TqGgPfhbor4Afb8whPHZyqZL//BPZ3S7d6IWkg+BJV8+pouK7NuDYGdp1pTrLY4ffex8I1scCtZsEwGHTHxgltxo5ZY1ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONnnaC+LJDRQUQHUwe6krEhZIKTzUm7YO/1+k3dpULI=;
 b=Vd4ZG391Bni85j+6WDX3jCG29fHQ521BmNResqwYEu7oy9XmTJxjqfTi1IvhWfR2hVT0oWKMd3n+KbJrkFiSxqR/+vEuxLRIZmO0zGpQ4nvdkQ1kfgQgC4/JVqwD1PYJUKpQwaN9nVHlQzadzTjjjY9s+0z7QPyFfKU4lbIDTrw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by PAVPR08MB9116.eurprd08.prod.outlook.com (2603:10a6:102:327::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 11:07:29 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9678.020; Tue, 10 Mar 2026
 11:07:28 +0000
Message-ID: <41a342b8-0b57-4b0e-bf25-a460ac77d3ed@arm.com>
Date: Tue, 10 Mar 2026 12:07:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: cppc: Clamp default minimum limit to
 lowest_nonlinear_perf
To: Jie Zhan <zhanjie9@hisilicon.com>,
 "zhangpengjie (A)" <zhangpengjie2@huawei.com>, rafael@kernel.org,
 viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhenglifeng1@huawei.com, lihuisong@huawei.com, yubowen8@huawei.com,
 linhongye@h-partners.com, linuxarm@huawei.com, jonathan.cameron@huawei.com,
 wangzhi12@huawei.com
References: <20260213100633.15413-1-zhangpengjie2@huawei.com>
 <cd08cee4-7923-459e-ad75-164c258a189e@hisilicon.com>
 <bdf22931-ec91-48e5-8050-ab4c899b5860@huawei.com>
 <ab94db5d-fbe0-4095-9a28-24055edcfdfa@hisilicon.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <ab94db5d-fbe0-4095-9a28-24055edcfdfa@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0104.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::20) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|PAVPR08MB9116:EE_|AM4PEPF00027A6A:EE_|DU0PR08MB8637:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bed53d0-65b6-4613-2020-08de7e955ed7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 DxWK1ItWeJPBlCTVP2iSuoTo5l27NIYza3drvIQmW+iw+7rGfJr3HfWBBpx699QAZAsV0H6vV2sgr02QezmDewOlrc9nzJeV8e09G/JvRlfN2Xf23Uul351spZopFn0F1Yd1NTyS9bMr5mXnHbfP3XEIGNLoZhaLsRvfJ59V+qN9+2a2KCNBc1T1Hyqvq9xxMQHEs/xjEc/R12qTb6pjPlpJwgDbduPY0zaStvxFFgWjjsOCLFpCUJWbmbkPPf2Om+ZVGhvxp5Q9/0xuocHQ5AJc9bQmjm5crVxIjdQioxs5IT+K9jYH44rnMBy+qh6dxAJNO72DGtzAZfSXydU/G/lIOCB6C0DvEjvLv14Ju4Ld5ZDlbmO27Evomcpsm3d0PvxWIouSWqIrS5sHnh3vq8x/23tUvV1d9w4/SGSjgzILM8Ft78ukiPQWpr1ujzZ7ZxZv0jMasI3ziIMumtQ2VaXHxJV0ZXB/x2LXzZ6LQFJcUoW3X7wjlPhKgZSCGM10UhPbdEimQe1os3GwLdg51RRK++Gly3oo2DOWMrJtdycq7uZN+BLytHr1VBcfOf+K+I3+NxHQ8KoP5K18sLrxlPZHbq+dNbIQynviYOk3a2a8y89zq23FFDEL4pdbEMmGWoRJocQ0PB1y28kTFfqywMoZtLtsH5ssIzYqNo6pNs2jP/CjQkqJpCxNotc300A5qDRyo2V8hzZSGWqvuGwf+auV1kIRjon+PRGUAfUIuk2RvwIl0kBazvvBL/nTJx22
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 l+T7M917ouwReBexd+Ry/titycQnETTCdwND7SoH0rkg9TnC+IlgZD9N02k8LProD6Jf2YIU5zGccseK73qc5ObsaXm+cBl06SFxwLrgxlncrJaHjJL4uYwKhfb2MRXqDjShJvXSYC3UdrISqWPDclo5b0oRiqGRrmvPtVoStyWrEOdLDmET+LztRYBDwWCyDoKOz7d9J3Hm3SRLJENxM5wlVWXvdWmafWWdstWGQW5k28haJmaEAl8FdmXuAiphxiCBvsh2g9CQYEjJ+3e0vI0rzvrEtbwMfVHF/Fa7tZCnsywkWu429FS0fP2rSBT5N763Jd+S5zdZgo4GAYqwiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9116
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2adc0674-ac4c-44f0-932c-08de7e9537d7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|30052699003|82310400026|35042699022|7416014|376014|36860700016|13003099007;
X-Microsoft-Antispam-Message-Info:
	0kvxovbvuiUIlNRb/tEGUe23Edo97PcgOkb6Q509mBElXFZvBCfuZ9SKy83nT8+wfpOZl44s6Y5hjm0FbAo+1w8wwgsHVjosLBh2M2BDsxT0G1mB+mYdhl1OqsFFAxH9fifaTHmPsJC9Ho8f9vkOha6QF9gl6ba7rjrr6jVJeoweDCtbCFzqU7AVrBND5YDsoxsUt3VmU5HVgkRrAgJMqDiqSCm4tFYrnICzVvi70OcXx7l0rGKAOMym1tuBsGrE2A+tq0JdUufWsIPaX+vgA4CaS49i1XZwj8TQxbLsmUrXyfBp83A+9TBlRd8RsLpnOzlk+bRCGBvD5obKq5YlJ4QGGC48AXtC91Q3gj8LV6cD2nkNTDa6YP4vvoONL1NcKsAATKKO3xBaN6i9EMxYjxhT3UvHouQa6YU29AufBdxxUirkhaW97ZbpPrILly+wJVdFREqvpbP/weE2dKwjqOKX7V2VAoOWvXX+F2Z9gi0IKUjTYhFBOx4QG5qlfIei5m5v6AG6Oae6o+Cwu8u0eJmJlI4d27l9ppbCnqpJ7AAjObhkK5ZW3zPBJt7R8dist2EQsROzkgWAnCm10JYOjDO7YGHQynO+3rGGL69Gy//Rf91ZfvJG3qh274+6+ghHhD0tqHqfNHuUct04cd903C52+acsh27p5Rshb57hR8ORwzOHqTqpqKaVeIotBfc4tL/eqAeeCUDeXMvoxfaftLf/e+z+LNUjEgXfdtLrxYrhJidUicZR1ALlHlTSgXmVsEqDQnRFngGt0QYBdJd0JJ5VyyJrcZk0bsDyFZgOEwQ=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(30052699003)(82310400026)(35042699022)(7416014)(376014)(36860700016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eaeraJ3wzRtuXtiYTpnkZTrmBGm7TVZAr9tSwjsfkj5dyrCqdgqTaZcR6nfKLCWKjQTvuT2904lKQ6ZcAx5UO+NkR7axSs23rN8JZb0ZKJYX35oRzmtFYP59ZIwvU6LJ+PEttyvfBJK9ZrRYoUFYWoiIITz7Wm/b9DzKRsL5dlfbah2CtkQyvQO0hYB/T2+I8kwR4qivP+yfMEGvK6iKCULM8cGQlalgx8iAutSZvzJDFpVhe8BTmuE9uFpCAdt1FfThZBgSA4iihWri9OUnWvQQ+UjAlBKlEY37amHTtZBzLqzGhg7OYarRDRUHrNCCyUG8pdwLbLKhgqJQOtCOyRBN59FuArNILyWxMwyDjZ3lt+7qOP3WRJh/79ihSSB1lRxzLU85Y7ZGz0U/YE2pHtI7fXSRyxst120b+DkSbRkvh2lGEShVZZOEIDayyC+3
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 11:08:33.8514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bed53d0-65b6-4613-2020-08de7e955ed7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8637


On 3/10/26 10:12, Jie Zhan wrote:
>
> On 3/9/2026 9:16 PM, zhangpengjie (A) wrote:
>> Hi Jie,
>>
>> On 3/5/2026 9:49 PM, Jie Zhan wrote:
>>> On 2/13/2026 6:06 PM, Pengjie Zhang wrote:
>>>> The ACPI spec defines 'lowest_nonlinear_perf' as the threshold for
>>>> linear performance scaling. Performance levels below this threshold
>>>> are typically inefficient and should not be used by default.
>>>>
>>>> Currently, the QoS minimum request is initialized to 0. This defaults
>>> I'm more curious on the original commit that overrides the policy->min set
>>> by driver, which is:
>>> 521223d8b3ec ("cpufreq: Fix initialization of min and max frequency QoS requests")
>>>
>>> The changelog says:
>>> "The min and max frequency QoS requests in the cpufreq core are initialized
>>> to whatever the current min and max frequency values are at the init time,
>>> but if any of these values change later (for example, cpuinfo.max_freq is
>>> updated by the driver), these initial request values will be limiting the
>>> CPU frequency unnecessarily unless they are changed by user space via
>>> sysfs."
>>>
>>> So, instead of doing what the patch did, what about calling
>>> freq_qos_update_request(policy->max_freq_req, xxx) when cpuinfo.max_freq is
>>> updated?
>>>
>>> Jie
>> Thanks for pointing this out.
>>
>> I think commit 521223d8b3ec intentionally changed the semantics of the
>> core min/max QoS requests so that they no longer reflect the initial
>> policy limits set by the driver. Instead, they stay at the default
>> "no constraint" values until user space (or another QoS client) updates
>> them. That makes sense for the problem described in that changelog.
>>
>> What my patch is trying to address is a slightly different issue in
>> cppc_cpufreq: the driver currently treats `lowest_nonlinear_perf` as
>> the default minimum policy floor, but with the current core semantics
>> that floor is not represented explicitly and gets lost during policy
>> initialization.
> Yeah, the current status:
> Setting 'policy->min' in driver->init() is pointless at the moment, while
> some drivers are still doing it.  The effective place to set 'policy->min'
> became driver->verify(), but a minor side effect by doing so is
> 'policy->min' can't be preserved on switching governors.
>> So I agree that calling freq_qos_update_request() when
>> cpuinfo.min_freq/max_freq changes is the right approach for stale
>> request updates, but I am not sure it addresses the question
>> for `lowest_nonlinear_perf` itself:
> I was talking about calling freq_qos_update_request() in commit
> 521223d8b3ec.
>> Should it be modeled as a hard driver constraint, or only as the
>> default minimum policy value that user space may still lower explicitly?
>>
>> My patch assumes the latter, although I agree the current implementation
>> is not the cleanest way to express it.
>>
>> Thanks,
>>          Pengjie
>>
>>
> Does [1] also solve this issue by chance? especially Patch 5.
> If so, I think we may follow that up and get the framework to a sensible
> shape.
> [1] https://lore.kernel.org/linux-pm/20260225084930.1692228-1-pierre.gondois@arm.com/

Yes right, this should help:

+ /* + * If the driver has set policy->min or max, + * use the value as 
a QoS request. + */ + min = max(FREQ_QOS_MIN_DEFAULT_VALUE, 
policy->min); + if (policy->max) + max = min(FREQ_QOS_MAX_DEFAULT_VALUE, 
policy->max); + else + max = FREQ_QOS_MAX_DEFAULT_VALUE;

However in the patchset, policy->min is not set to the lowest non linear 
freq.,
so this would have to be done aswell.

------

It also seem preferable to set the min QOS value once at init rather that
re-computing it on each ->verify() call.


>>>> the performance floor to the absolute "Lowest Performance" state
>>>> instead of "lowest_nonlinear_perf", allowing the CPU to operate in
>>>> an inefficient range unnecessarily.
>>>>
>>>> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
>>>> ---
>>>> Changes in v2:
>>>>     - Renamed the patch subject to better reflect the logic change.
>>>>     - Updated the commit log to clarify ACPI spec details.
>>>> Link to v1:https://lore.kernel.org/all/20260116094555.2978887-1-zhangpengjie2@huawei.com/
>>>> ---
>>>>    drivers/cpufreq/cppc_cpufreq.c | 18 ++++++++++++++++--
>>>>    1 file changed, 16 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>>> index 7e8042efedd1..4a3031d9fcf4 100644
>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>> @@ -333,9 +333,23 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
>>>>        return target_freq;
>>>>    }
>>>>    -static int cppc_verify_policy(struct cpufreq_policy_data *policy)
>>>> +static int cppc_verify_policy(struct cpufreq_policy_data *policy_data)
>>>>    {
>>>> -    cpufreq_verify_within_cpu_limits(policy);
>>>> +    if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE) {
>>>> +        struct cpufreq_policy *policy __free(put_cpufreq_policy) =
>>>> +                          cpufreq_cpu_get(policy_data->cpu);
>>>> +        struct cppc_cpudata *cpu_data;
>>>> +
>>>> +        if (!policy)
>>>> +            return -EINVAL;
>>>> +
>>>> +        cpu_data = policy->driver_data;
>>>> +        policy_data->min = cppc_perf_to_khz(&cpu_data->perf_caps,
>>>> +            cpu_data->perf_caps.lowest_nonlinear_perf);
>>>> +    }
>>>> +
>>>> +    cpufreq_verify_within_cpu_limits(policy_data);
>>>> +
>>>>        return 0;
>>>>    }
>>>>    
