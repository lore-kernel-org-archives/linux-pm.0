Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313B23FBEBF;
	Wed, 25 Mar 2026 16:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774457764; cv=fail; b=V1AmBS+RZeEy7hJllY/4zvWFl0AS+SaW/AkB2N3XsrWvr7aAy+E8bf9zrhnITgTk696nrdeCka06JE3XMgHiba2/HfXihY2toalzADp+Xo4FDuKNGApd1pV6XWaEhP8DMIOFuyLus4m9sq5kbi3dGqsUyUKHt9yfhO7hWYYS9Uw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774457764; c=relaxed/simple;
	bh=PbSQqhg+bv4DObG5fc7x2B692af8r7SKzeg7BB3yumE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vd8uBKS/R0HvG2hlT4POojYxaX2iQnA08PTmfXTgsiP2p/c9c5OKslf91lgX8dCmiu0n22b++P1j9/fk8DMF4htEVDnbRGjYP9EPXhY1nJU4EszSMxEcTR4hiGrwYkFSgW8bS0idtqC5F10u1qELoYkHhMWbFd6pEskUfG7GH3o=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=D2jp4Iix; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=D2jp4Iix; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="D2jp4Iix";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="D2jp4Iix"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=s8hbNGE+r+y4DViYyGSYpnzH0hYmCTh9BoIschT6yyx1uYkTg9MiIJRT53RDKklKw7CvS9aQMcMvNl4A3z/wKX1Ke5fetfXbQUk3CgSxes/9Si9inLyRQbZVHSoAYDEUqKMTvpCZyOnVK7x4tXRzsfGdKeFaIMi9khd/dfSFPeCHXoTKtaVfEsjJUJ2+2KMEM8HAbCp+aw6E/ozn7zIj7Ohm/ibwXnFPdLIJ5V8vuOg+tcAaj742P8dnx9EToY494HOqtDlnseF1Mjb10paGPbsKXctji/B2jVEu0r7415i5tK+bAu4s8VX9JNRxEh8yDmwkO5XpuHdrXvcEnfv8/w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SKY+ZRfcuNQS5S1Xr22lEWUBgBAXZTRSf3PW2nx8Mk=;
 b=XSRn4c7uoqzi1hsyWYMf6UFmPdNRO3L8xUAFxDqPKgfBkcBDFRxcI9nIPmEAcfAitgPQcK+jN3HRaTAIXTrbKwEKsvkYQA3ZShjNbRp6LbnVKnvuhWH6wXSncAmMYNgNg4yypfv8LzeX3aEu3co0mqj1pGstTrJRQd78JEMziomAXFp/xPhain7dGNEXBz566hwGQG4jP6PxUPQAtbdLpZpfxJRtoe7nvzC9qg5sAk7/wxR4neA628NK6AZSA8lpgNEeSS9llPIsTd/BvZ2fNPqyJl7LOO0IdRYBOMf+m6lhygppZxDZdgy6SwIwRxjs5hq/VM1mPHHJzHWWkVF1Cw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SKY+ZRfcuNQS5S1Xr22lEWUBgBAXZTRSf3PW2nx8Mk=;
 b=D2jp4Iix34VC7jCLF1uNyPfZlsZv1SsP13O5y0L0Dn0qfQQzH507yVufuOFLLSF2PP/Oj/gzTvBRcodVtaDUYM/bGqi5SnYJh4biezVYy3ONa0DVz6O9uGnMhB+yuld7F37bwchXYmsbualp7sR0r6rvJmCOPIWG6+4J2WITnoQ=
Received: from AS4P190CA0007.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5de::6)
 by FRZPR08MB11139.eurprd08.prod.outlook.com (2603:10a6:d10:13b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 16:55:55 +0000
Received: from AM3PEPF0000A78D.eurprd04.prod.outlook.com
 (2603:10a6:20b:5de:cafe::c2) by AS4P190CA0007.outlook.office365.com
 (2603:10a6:20b:5de::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 16:55:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A78D.mail.protection.outlook.com (10.167.16.116) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Wed, 25 Mar 2026 16:55:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYMvKqvix4AwL+FdxFNzlLzAJlaguyc2DNSVJzQ2Er4o7P5v7RYJZYi4juf6TUhIiuZrePr4/ld1EXK2HZirQdAGiCrQCE+WD2Ond7paIN1+1nA8+CstVOELRp6efSz5F0mDoQs5S5t2IlNT2dArxvhfuZQlaUPLFLq47VtzpLjUXFd+z8UfsFyXtZUwfxgx/X70aoDP/Uoyev6i5jdzQBt/OixRHMO0Uu3Sbf6BCLggf3B5alF8Ddm6kaqKS+XajFWPc6ZRu2IyFLs4BKYVzcwj42gXeDijKefKexb941KVfekZPssCebRrLkkmsxrz9Boxh4nLSz5xEXLqXtlcfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SKY+ZRfcuNQS5S1Xr22lEWUBgBAXZTRSf3PW2nx8Mk=;
 b=Yl5SO2PxMF86VB1OZ31yXey3CLmuTv2seVb+5I8u7VcfJQtrAE6cMClF5fLEbO9zB6dIuhMhEwGeRI8NYNtVyQ42vBz/Cks9Aa+FsEwVnEBgLeshxwr/7l+5TZVbfKVInS//TNHZrE3i3Ow7B90kPl2TrXvjGDGjIClznULc5w6Wn4i0BJaCg5YiAYbCh6EdDr/4duMtMcQdEdMBDdMKiNkoEVDkMfIogh5cC4l9y9QheqBfD/KoIUthBXbMEMa4rqmIEh9YuoW/EZtb9VtVH6TYR0E/5SKUZdeGcIBJKumI4M/GuyFq6AfhWhrxNyg4989lZP97b7XqddYzjpo8/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SKY+ZRfcuNQS5S1Xr22lEWUBgBAXZTRSf3PW2nx8Mk=;
 b=D2jp4Iix34VC7jCLF1uNyPfZlsZv1SsP13O5y0L0Dn0qfQQzH507yVufuOFLLSF2PP/Oj/gzTvBRcodVtaDUYM/bGqi5SnYJh4biezVYy3ONa0DVz6O9uGnMhB+yuld7F37bwchXYmsbualp7sR0r6rvJmCOPIWG6+4J2WITnoQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by DU0PR08MB7993.eurprd08.prod.outlook.com (2603:10a6:10:3e0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 16:54:49 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 16:54:48 +0000
Message-ID: <583fd75b-d510-488b-854d-51312dd18e56@arm.com>
Date: Wed, 25 Mar 2026 17:54:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] cpufreq: Set policy->min and max as real QoS
 constraints
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>,
 Lifeng Zheng <zhenglifeng1@huawei.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 linux-pm@vger.kernel.org
References: <20260317101753.2284763-1-pierre.gondois@arm.com>
 <20260317101753.2284763-4-pierre.gondois@arm.com>
 <ukxdxr3xv7x6pqnwwafxgvhvfh5n7w67y3zwunhnk7b45tz3t6@d6ehl4vqac6t>
 <ab06e8d6-d430-483b-a2a4-9e7d197aa6b6@arm.com>
 <ir3mvkz7bbzwtsydrfdhnkkkseaj6fclzgiw3soxb673xvhczk@fukk5ad7jrtq>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <ir3mvkz7bbzwtsydrfdhnkkkseaj6fclzgiw3soxb673xvhczk@fukk5ad7jrtq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0294.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:370::18) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|DU0PR08MB7993:EE_|AM3PEPF0000A78D:EE_|FRZPR08MB11139:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b2cb225-d502-47a9-ff8c-08de8a8f6145
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 0ERuLynvqspcNFIuKT6Fdl6xz8hvVIDQsa9L/EErUEaSiVLujkYI0lj7rCOqJATecxSGpPZsjpt22XtoR3MC9O3iZH4X4hku50n0nRAjxrXQnru2zW3KktAHIhCZe758Z+uRpDHjEp8CbTPz4/aagi6QKABk9ItFsTXn8Ebelvs3QSjAl6QosNnDmLUmigJ2xZaK4pkeaRkQyQYIgmeBkFPGM2XjJdm4UcPwQsFzcgZT474C4gVXHaF7ZscHLaHAgdVfpmGHGc7uyWC2C9OQpHhybwbFFW3DMZvwo2Gc6c3r07mnUHMMcR1dUx3ENV4QBrMmmf0J8AkCgTg+4dX37QfJ4VnhclYorhQWgMOsyX+jATkyTg+EqRkF12K6ka3OkvcQpY8yM+eec1gKzA902rK0HKOhKgQ3DWyjpeAMDDmDUD0XsepjKaEYgqUJS32ij6gAjZIcPkN1bAauaTTafBrD6PpIWk/BAv2CeQZRDqS3KY/yJWViTDpwDidMHxryPaRGGvVTZ4rCX0EpSEPlZX2VhEJ0yUtTzxQq5dOKhgKccjItFBR+lrmFhzV5lpccNum06DBHW4v1jv38qw2A0DpmaI+CIxdq9RsNdSSwGtfKW624QFwTZAQRoJigO31GtErx+jlKLEznsWxAl6fcT5e73YrsSx1UuAE3nidyOlcRW2s8rXR2PdhFwYDU7smS
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 vamdpfJxqdBTkdVgpY0pUTWcARzx/yVNYpzQw/sKosoAvhM79J/K5YLd2UW3ycoYECWbsshZ2D6+ysf5rjcUyYSP3Pfe25y/1XjweWTEAZUL8F6Bzh2GmnLRSbX5wzQRhuNbVflliiWshcWH7+yqySdygl8msag9+7gG0YDIXZd0gu5WnYqtQ5u3UJfSv27b6CXkVBgThs0XuI07XY7RcgkvZkDbDUpoo5FcJkMDAppmJAE8RKOrRQFjfMmrMDWlNPO4vGuGI4NvRtB19HMT5OXNofM34olHHOdYwggqh8LZHq7leOoHunMmKIRPzZgHz6lA5HBbNGD4IYmDRXEAiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7993
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A78D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	08ee5e6f-fb35-4a09-6ffa-08de8a8f399d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|14060799003|1800799024|376014|36860700016|7416014|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	urJobnbKnXWR6lFIcMCFvvAGdNMKAEe9tnMs5N8oZchVy8QrWg/7THG++AAfOg9pmQGIdPeIITct1TgyM7jbKILKPS8o+u6qJV7SeFrWFSYXO+WdwWtcGaKwKf9+vBfF6GYLGoHxOWhuxOB5eIi6viMP6poQJSlXKmLGjqeakh+32Wa/Jfy1z1HjCi+9/tbJHrUv786j2RdRdcC1E3GLB7YfbepV5RobhZRMpAFSUZFKJUNYoMmrpzv2GowTAGzUqClWphaEhUhCY8JJF1BPspBHo0j5eZuTa/mRIMJzMMWHhJECRmIkXAM8VCyvV0zi8RGJiPL2iu1zhw3vDPoYRahDYjR4bDjl1VQedzWqUBqEe/jihLSV2bKBY58qcker+WB+tez1yJ0Y4EmbYBaFrnd9H4Ig5S+hUqiAH4ec4eq1aTuVQgPE7QtMaob95df20NY4MOuhdsVDIEyXQ9WtIZjxdxTy49ewVIyl2tJeKH5AE71fXkS4LTaMPn7BqPmfBUHs+HxkvsS2d5JHfl2b9/DAXiv7bolKLj03crgRPcfHRW/PPH7NpIH694q0Azvk1jz1iAE0UIRmPWRrQSFXB7v1pYWLIY4+glavKm7DzAyXDuWnrUyaMOH5rk2sposKCAD76vUjzm5LiR2iGX8iUs88CrmPRJass8mUwC2LxQanmtFTWk+Ny2DfiKaGkcgWWhIUcDJDlKTFNhvwQmzQuc3VaH5aMzKkjmoYH4yvyVk=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(14060799003)(1800799024)(376014)(36860700016)(7416014)(13003099007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EP8X8TOGHXyzi27SBofBLAbb4chbFl7SRpeooLgPNRCt8Gv5IzkPyTMzu+Gv3Ik6p9wEcsIQjCKwAKkGHXnYlDg/SO8fw2WTsjGMSvaak+DwIwF2mEDatj8ULe6DMZpe1vlsrcUYd2DHNzAKO8Ni9JmY21L355GLV4WC6PKKC2roxsWhqsLhin952pzQlYT7dapLer4ot6JE8kcVyKadfaR5X2J/6APmOWMJVNgM6IiNGx74cz0Ocu1eIoB/jdqrochR7wHTcuksihh7mZvIXXhpdkqYSpckoFBQ3rrVzW8X/KlCzgQi+QQVFKQXGAHrqxCK+z9AfcNWXlk5UxwcNbGvGDZfMXktb8TY4S27p855OxgB6y6ZAhluZAN7DSK0+nVQKG3z3pamq8l3ECkSkslbEgv3vVoEV7tGxtjiKbiMpctKaKe44SYP1QdrPmMU
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 16:55:54.9048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2cb225-d502-47a9-ff8c-08de8a8f6145
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A78D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11139


On 3/25/26 07:49, Viresh Kumar wrote:
> On 24-03-26, 12:40, Pierre Gondois wrote:
>> Being able to set the min/max_freq_req from the driver might be
>> something that is needed, cf:
>> https://lore.kernel.org/lkml/20260213100633.15413-1-zhangpengjie2@huawei.com/
>>
>> It would also allow to have a common way to set policy->min/max values
>> as they are set to the the cpuinfo.min/max_freq.
>>
>> On the other hand I agree that I didn't test all the possible paths
>> for this change, so this is a bit audacious.
>>
>>
>> What about adding the following to have the values set for all drivers:
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>
>> index 70814c567243b..3a1e5f58a301f 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1530,6 +1530,9 @@ static int cpufreq_policy_online(struct cpufreq_policy
>> *policy,
>>                                  CPUFREQ_CREATE_POLICY, policy);
>>          }
>>
>> +       policy->max = policy->cpuinfo.max_freq;
>> +       policy->min = policy->cpuinfo.min_freq;
>> +
>>          if (cpufreq_driver->get && has_target()) {
>>                  policy->cur = cpufreq_driver->get(policy->cpu);
>>                  if (!policy->cur) {
> I am okay with a separate series doing all these cleanups. We can set some sort
> of rule on what is expected from the driver here and what is left from the core.
> For example driver only sets cpuinfo.max/min and core takes care of rest. This
> series would cleanup all the drivers, etc.
>
Ok,

Is the current state of this patch + the above modification acceptable ?

