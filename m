Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49E335F605;
	Mon, 11 May 2026 16:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.34
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516243; cv=fail; b=PM2eojdyKU6TSwp6WDe+BqsEr2u79914qOiMeb+0uGo/II6Ge65Pz091U7rcca59sFMP+n6QwMJ/HVI0HMw9HaWewk1TLe2si1HugW4JynwOBLs/0pvPXxISwLKX+Y6Gz+ep9El/c8JtQYXr/MV0MgXSJHG7QZnb1qNpKQ6uej8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516243; c=relaxed/simple;
	bh=YlNpXA0ZYjirb0kHetYibG5zMXuRpQZMN/Kgldmetf8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PF7vcHr8bhOzKhFOEbkJ8+0Jbwl8Cyu2/998nj2eU551O3n5EkrhsaRuPHM5pEAbnqfh1c8GOkpzZcB28pAz2Z2N9vkZLnMrOdFzViQwoQxkabKuFQkIQmlVnVPktP4jyrSnDaQ2HkMKrSnYwiROUeczzXC+fFsuscYbq6FwsM0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OSATcqFI; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OSATcqFI; arc=fail smtp.client-ip=52.101.70.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OSATcqFI";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OSATcqFI"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=yDnzvduw7uwERsoE7hbYxUlsxhhc48NF9Q2gqnzMrZEuXXnPTNACgXF6m6IaIFaoJ7ddIF7Rzta1Wo5gtDRtlZCOHL3NGRYUVZKnO950+T0tflI7gQSC1PObpzuiNyydBOkUd/IuG0QtqqweCkvle/lZjy8FnlYE4fv8d09SKBq5BuAeNlsTANWrzSwbW+3ErUDlqQuE6gKqguyW6eIKYrfvyO+O8Wo4uK3cRDXOnov8Odf+IYRqjCA4CkXyDVSbZlp7oG7L+Vzw5yllv+vybRdilaCbIuz5oaWMUh+x8UZNjISyYYJ9n2o05O/k03hKJFVBRgXgoFwXBwEtu8xf9g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVxNQCYjmP6mK0C+OzpHRWSFSLS7wu0wcj4m7EDMZmk=;
 b=EKaizhutv1dHnNfj2dthtbQl0FKRGpYWf6JcjbYkSQo/0wE6YdBeBHjLZ31sLIGgjhbG/8vB5B/eSKLMulvLW7YvWI3tNfCoOynlsKonGrObp7AUN9hjlFaUO1dkIkxhynSyJ4gFE2MWV+Qg7c4fTGMpTr7//JPZeWH2xWXLhlszS8FLi/WJhsVKJymRCh1hX1z2l68qDn3vs5fOfGu9hIqo3UjE921DZHOR8qGCFi6GGu1Hf5Aqu+ngSecvUYq/BKu9sdGr1Xy+YnrZ3adIO1YzC8o3yEMDYoh6jMNnLEhIpItsQfbu+QY52FpjPL9YX+CDRm2J5372oe70tsw+xA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kylinos.cn smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVxNQCYjmP6mK0C+OzpHRWSFSLS7wu0wcj4m7EDMZmk=;
 b=OSATcqFIbM2Qc2czeyXLQ6eXHpAtEDG0s8546hN8+G3SBaV96A5OcN1S+hUt3X9OQtdcSdN9PZUK78G857bo3f94/X6VizlvzCPZutyN76YAidMmrZfXH9gZ2RGXExrJel9yfadmFjMECPWKDZMKrkX+zUqMcudtXXZym935ats=
Received: from DB8PR06CA0046.eurprd06.prod.outlook.com (2603:10a6:10:120::20)
 by DBBPR08MB6138.eurprd08.prod.outlook.com (2603:10a6:10:205::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 16:17:13 +0000
Received: from DB5PEPF00014B8D.eurprd02.prod.outlook.com
 (2603:10a6:10:120:cafe::9f) by DB8PR06CA0046.outlook.office365.com
 (2603:10a6:10:120::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 16:17:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B8D.mail.protection.outlook.com (10.167.8.201) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13
 via Frontend Transport; Mon, 11 May 2026 16:17:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kt0RKTZdjCCUyKeXNEAdVpAhLp8QNsGvQX+hjkuJrekqQaVTy/jGru+fOxTPHbFFMYpTljnL89gOG5+sbs8/tskU7bDUqHYiyounHIdjAew83oKLUpUvIAVyR214Y3rpHe1r2Q0ra3ICalsVkdXSNHnrMcOWoPceTiUFWHIf09LEA2Q0/55GfBMVSS/FBE9twXiQUjVuglJjFIVCn53sM+JvxHoQNcwEXBO+eBaIefWVKlYkM56tm8SPdouqwGnzgP4HHAyUqkfm3QuyNGKZWXvL1XjcGLw+13nXEeaPb6/qPKvCHrVzRPSC6siAgVdezHpbVhvQcwgfhOysBb36Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVxNQCYjmP6mK0C+OzpHRWSFSLS7wu0wcj4m7EDMZmk=;
 b=oPRFRuTR1NlUq/lK4+BOxfrwNmLlKQ9x3Jhlor6OYPXWEcS8oxnyfI3hVPUXNRysXZIYK5reWu0axX5IdDqmIOLBHUoeq81CsCn6UZVraAiNk1DJDjL8mSRrgVEfe7C9T9hh9zxL6dgpyvcEIZizDsYHB9mPq8yQWaAuZ0eaTgVItrV6HnTaiWtyRhVcqeJyqzKKZB4fwPZEa6PHMRIPrjKhD/YjaUiJQYtwhxIwpKShKWso9reIMHJdOeqYfo3hRC1FT1AOX/fj6aTEOTSn540Z1B5jWYiiFr6qHCDV4EZZPm0FAos/jdjfK2DSBZoQdCLE/muf1mdkvCOC6L2FkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVxNQCYjmP6mK0C+OzpHRWSFSLS7wu0wcj4m7EDMZmk=;
 b=OSATcqFIbM2Qc2czeyXLQ6eXHpAtEDG0s8546hN8+G3SBaV96A5OcN1S+hUt3X9OQtdcSdN9PZUK78G857bo3f94/X6VizlvzCPZutyN76YAidMmrZfXH9gZ2RGXExrJel9yfadmFjMECPWKDZMKrkX+zUqMcudtXXZym935ats=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB10408.eurprd08.prod.outlook.com
 (2603:10a6:150:149::17) by PAVPR08MB9649.eurprd08.prod.outlook.com
 (2603:10a6:102:310::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 16:16:05 +0000
Received: from GVXPR08MB10408.eurprd08.prod.outlook.com
 ([fe80::11da:2693:8a4b:1e29]) by GVXPR08MB10408.eurprd08.prod.outlook.com
 ([fe80::11da:2693:8a4b:1e29%4]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 16:16:05 +0000
Message-ID: <b63b1409-3c01-418b-be27-f7e273b2e73a@arm.com>
Date: Mon, 11 May 2026 18:16:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpufreq: cppc: Add update_limits support for Highest
 Performance changes
To: Xueqin Luo <luoxueqin@kylinos.cn>, lkp@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, rafael@kernel.org,
 sumitg@nvidia.com, viresh.kumar@linaro.org, zhanjie9@hisilicon.com,
 zhenglifeng1@huawei.com
References: <202605101404.fqz0MXIe-lkp@intel.com>
 <20260511075647.206642-1-luoxueqin@kylinos.cn>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20260511075647.206642-1-luoxueqin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0502.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::21) To GVXPR08MB10408.eurprd08.prod.outlook.com
 (2603:10a6:150:149::17)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVXPR08MB10408:EE_|PAVPR08MB9649:EE_|DB5PEPF00014B8D:EE_|DBBPR08MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: dc6cbb05-6426-4963-5503-08deaf78c266
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 CDXzePdI2oMZaPzGSVpGnhv1A7Z+e32tUKPRAcPa+eNWTTO7TyEZDRJQCNW71+egsseCPqq1Zjj+5XMSFXllxOeRDqeolW87xigFGZNlMBUtLaCPE7/b4hzVXgh7AtzL6sP+nB2YcgxrjB5KGO6n92vFwVcamrNFvKmqZy+VmhVWTAmR2TnK3TwE7e3osC/kcZreCdrfvB7PnzTznXveOZ6452vO+vWiplMXUs4UyS19w0Lq0R6oEreFjZhisOF1/gMnz0KezvpX6XcDwORYFBxRiPNZbDUbAfZ+86FgWrJ4nwuYqGiOerTjixcRs1WMZ30s/7jnJvOSfxjoeNwlBgRGSsCQFMRcYfHFTIk9CxwJ7TZ9nrntM2VV4CcbSaNuJQ66QL9fe5+tXCUVoNBnaU0HOzotg9rRHBH6i2zEbBH4VZC0BxxEww1WGEfK432E6lJzY1YhdWkZO77AEOhTpV4vhoep3gzhLRiA0I16uewKRnJj3CSTGAL9rSuGGvqOC0sIgLCbWHp7Mhp2Z8iNrsO0S9BdUsM3uHF2Y7qAojgAqLteg7JBoGNZPUPst80jE4dtntVRapfouBCjmxyTSW94eKma8hFMEnQgMRwwvfklSz6tigKMzy6W0hxn8PqlymfKOThTd5CRK7RUa6XGm6lHhvK+n1x699m2WPmcSqJha5AR0egoHDzO2CBrK8RE
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR08MB10408.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(11063799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 a29q5Q0XgXTKjUs5XwMidPmZp5UTN4a146KzvmgoWOZb6YKszoBvKVCMijBP2y6DyuLTzuEuY8O/tnmIGNlPTugUEOJNWuMM2NaKW/S41tIkSq3TQvZF1tMW4u2mMQpKx9C+N4l2Kry3YMeFQ5kYCBJ3yTGworW16ydsEvRi/5/vjGdKbAtBH6SgC0UiQMmuLMWm9v7lz0+h3Q+HE88n5/E/iRamI1utbWXVWm/mjdXMYGN8yY0PKXLh/yaY8Sp5yN5g3h1j2a2SVI7N3E80knqAhvKqIRAyxToz5PBFr3bJVVxXOmzKFSz1Eiv2eHwaCRgbjYnlgnD2Zdg5/UdOCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9649
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B8D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7c2ff7ff-6864-4d05-42b1-08deaf789a38
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|36860700016|82310400026|35042699022|7416014|376014|13003099007|56012099003|11063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Xvz9K/B4yPOEANfsMF5VLcRYPaFmm2U4sOE3nzBLYDe4d0LwdQt78uTs5onFMw7hldHE4BUXbCEryfksAd7W8DLm1cvyGttYKOFvY6Gm+3R0W8H4Xpc0Q/NgXuaoDX7nsfCl/okwJ6jTkO6fexQAJJxLfjsKdruZ/sf9x4XhG7lS2OxQxfgnn7kvsHNlGkTjWojxs+IPz/khcbTS58iSTKh7KtGleUXmaFb04dwrC4DMUEA3ccqv2mAZua8zgDaZsj3LHKGMc7fCgwxGBAdB0GS5oP656y/GTFZjqWPvBH9kg1Y3yPXxrtLgxopdv6lrTe83OO3sE9k4T2F6FEPrzL5O/0kXlbc66slYHPqmhRwHXfoL97DJH4nXUaBUuMWQQKJOd1zd0YwxxEFIIV3OwyX87qBn7KT6N6w6qjkAzYisJNhhQX5s1b8htwxesRd5P+ZdSP1bnAsx6B0v5U28J89hxghvpwE9XpoXV3UEQdxi2LORVyJj4TS153hM81p32iv138rdpo47VgZymr/QYDGW1HAClH5AwYD2686Xu5QU3o6PpGyBKB/OfgV83s6DphE5sqqnqD8/kMOwtgLyYA4DVfaNKO2wumA1WCtJ8U20cGqTxXZuvVQ6CnzkQRji2nlgIaQHU/9Xn5lWkI3brG4zy1IuP/xDssvMvBmpAeHPZodCk8LSZRLdPM5RBFYZ0zA6E/Oi1kxkAmjJzYb8dFyvnROMB3dmdVdCuNRmsRg=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(36860700016)(82310400026)(35042699022)(7416014)(376014)(13003099007)(56012099003)(11063799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ks02Z46gCUO7pDwUZGbFQe3hBKdqv4BO/G/6fGGubMgjBIEeCgoE/mpz967vCShemn6yaDqbw03IpBMSkdc3qJZST6jF1LkDIConJr/9SUNViCMJwVjBF/Nern+77fgrZ3J+FfXoFUWCbpxyKv9KyVW9DoW3ICDBK8cYTwmebr6s4+27m4Zhs2kCMVy8oHUA+mBL0WarNrysc+5NpOjl0eXXC1XE/Xn6fKeF951vGWAJW7wvEDX3rlBs7oOoF1weGpAFgIuyuncHSO8O97nmldTSpEMQN/GBYqZytfwSUDr6ZvBqMxBIsQewx3i3A7rLbrSi2OxEJpxNzREvFfRzJl22Hu6lqwBEV6l+l2a0MO7RYa1PS5YlQbbsUb13cjqsO/HG7p3iVvWRLTliK084nArnq1yJDvhGxGI6WNzzCT3dZDYfcca1F6jJPTsV1fRd
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 16:17:12.4494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6cbb05-6426-4963-5503-08deaf78c266
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6138

Hello Xueqin,

On 5/11/26 09:56, Xueqin Luo wrote:
> ACPI CPPC specification requires OSPM to re-evaluate the Highest
> Performance register when Notify(0x85) is received for a processor
> device.
>
> Implement cppc_cpufreq_update_limits() to refresh the cached
> highest_perf capability through cppc_get_highest_perf() and update
> policy->cpuinfo.max_freq accordingly.
>
> When autonomous selection mode is enabled, reprogram the runtime
> MIN_PERF/MAX_PERF envelope against the updated Highest Performance
> capability through cppc_cpufreq_set_autonomous_perf().
>
> --
> change v2->v3:
> - Fix build issues reported by kernel test robot
> - Fold cppc_cpufreq_set_autonomous_perf() refactoring into
>    this patch to keep it self-contained
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202605101404.fqz0MXIe-lkp@intel.com/
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> ---
>   drivers/cpufreq/cppc_cpufreq.c | 89 +++++++++++++++++++++++++++++-----
>   1 file changed, 76 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 7e7f9dfb7a24..9184d5570de8 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -843,6 +843,80 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
>   	return 0;
>   }
>   
> +/**
> + * cppc_cpufreq_set_autonomous_perf - Configure performance bounds for
> + *                                     autonomous mode
> + * @policy: cpufreq policy structure
> + *
> + * When enabling autonomous selection, program MIN_PERF and MAX_PERF from
> + * current policy limits so that the platform uses the correct performance
> + * bounds immediately.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +static int cppc_cpufreq_set_autonomous_perf(struct cpufreq_policy *policy)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	u32 old_min_perf = cpu_data->perf_ctrls.min_perf;
> +	u32 old_max_perf = cpu_data->perf_ctrls.max_perf;
> +	int ret;
> +
> +	cppc_cpufreq_update_perf_limits(cpu_data, policy);
> +
> +	ret = cppc_set_perf(policy->cpu, &cpu_data->perf_ctrls);
> +	if (ret) {
> +		cpu_data->perf_ctrls.min_perf = old_min_perf;
> +		cpu_data->perf_ctrls.max_perf = old_max_perf;
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void cppc_cpufreq_update_limits(struct cpufreq_policy *policy)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	u64 prev_highest_perf;
> +	u64 highest_perf;
> +	u64 nominal_perf;
> +	int ret;
> +
> +	guard(cpufreq_policy_write)(policy);
> +
> +	prev_highest_perf = cpu_data->perf_caps.highest_perf;
> +
> +	ret = cppc_get_highest_perf(policy->cpu, &highest_perf);
> +	if (ret)
> +		return;
> +
> +	if (highest_perf == prev_highest_perf)
> +		return;
> +
> +	cpu_data->perf_caps.highest_perf = highest_perf;
> +	nominal_perf = min_t(u64, highest_perf,
> +			     cpu_data->perf_caps.nominal_perf);
> +

I sent a patch to try to remove setting policy->max in drivers
in cpufreq drivers in general [1]. IMO policy->max should be
updated through a callback handler, maybe:

refresh_frequency_limits()
\-cpufreq_set_policy()

[1] https://lore.kernel.org/all/20260511135538.522653-4-pierre.gondois@arm.com/


> +	policy->max = cppc_perf_to_khz(&cpu_data->perf_caps,
> +			policy->boost_enabled ?
> +			highest_perf : nominal_perf);
> +
There might be other things to check:

- Is the new highest_perf higher/equal than nominal_perf ?
Depending on the answer the boost capabilities/status will have to
be updated.

- IIUC it will be possible to update the nominal_perf in the next spec,
so this makes things a bit more complicated aswell.
https://lore.kernel.org/all/20260430142430.755437-3-sumitg@nvidia.com/

- Do we need to rebuild the whole topology ? Cf. highest_perf
is used as the CPU capacity in topology_init_cpu_capacity_cppc().

(maybe off topic)
- What is the relation between highest_perf and the (not yet introduced [1])
highest_freq value ? Since the highest_perf can evolve over time there
is no clear correlation between them IIUC.
https://mantis.uefi.org/mantis/view.php?id=2570

Some of the questions are more spec. related,
but this patch might be the right place to discuss them.


> +	policy->cpuinfo.max_freq = policy->max;
> +
> +	/*
> +	 * Autonomous selection mode uses MIN/MAX performance as runtime
> +	 * hardware control bounds.
> +	 *
> +	 * Re-program them when highest_perf changes.
> +	 */
> +	if (cpu_data->perf_ctrls.auto_sel)
> +		cppc_cpufreq_set_autonomous_perf(policy);
> +
> +	pr_debug("CPU%d: highest_perf updated %llu -> %llu\n",
> +		 policy->cpu,
> +		 prev_highest_perf,
> +		 highest_perf);
> +}
> +
>   static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
>   {
>   	struct cppc_cpudata *cpu_data = policy->driver_data;
> @@ -885,20 +959,8 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
>   	cpu_data->perf_ctrls.auto_sel = val;
>   
>   	if (val) {
> -		u32 old_min_perf = cpu_data->perf_ctrls.min_perf;
> -		u32 old_max_perf = cpu_data->perf_ctrls.max_perf;
> -
> -		/*
> -		 * When enabling autonomous selection, program MIN_PERF and
> -		 * MAX_PERF from current policy limits so that the platform
> -		 * uses the correct performance bounds immediately.
> -		 */
> -		cppc_cpufreq_update_perf_limits(cpu_data, policy);
> -
> -		ret = cppc_set_perf(policy->cpu, &cpu_data->perf_ctrls);
> +		ret = cppc_cpufreq_set_autonomous_perf(policy);
>   		if (ret) {
> -			cpu_data->perf_ctrls.min_perf = old_min_perf;
> -			cpu_data->perf_ctrls.max_perf = old_max_perf;
>   			cppc_set_auto_sel(policy->cpu, false);
>   			cpu_data->perf_ctrls.auto_sel = false;
>   			return ret;
> @@ -1009,6 +1071,7 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>   	.init = cppc_cpufreq_cpu_init,
>   	.exit = cppc_cpufreq_cpu_exit,
>   	.set_boost = cppc_cpufreq_set_boost,
> +	.update_limits = cppc_cpufreq_update_limits,
>   	.attr = cppc_cpufreq_attr,
>   	.name = "cppc_cpufreq",
>   };
