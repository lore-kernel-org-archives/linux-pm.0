Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012059.outbound.protection.outlook.com [52.101.66.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA83E37186B;
	Wed, 18 Mar 2026 07:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.59
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820653; cv=fail; b=lHjsLE2DaMxeC9G+iQhdUNSWRuGsFAIkFi6PlvC5vMEWttNknMoHwkjuohF3CZNPZWb0ZBsuIKLQWfw+qMeQyHzGNmwazttwA45r/BIF7V2qwSvoSPDgm75EnM9RDP69EhVga14Bx8/+VBrinnOPfbWPDfKepihK6NtiIfOjd2s=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820653; c=relaxed/simple;
	bh=tPS0aUrTZJHWK9AFMm40oxY9PFLJKREwFzojCPIaRes=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p/NVkxf+fyXtN/Aw8S1W7PYBz9csh0WBAYM2Z6/N8hQduzAlTLPFJXtc2RDe1DMS2W6Lue5T1tUQSwFDA5C2VRJ+a883nVyAt81xQFWpMYspt+5r0Wc2c/U6G11cC1WMU8hLHLhgr7QMIV6XGCjCXN7MDROO22etn6lx1eYcs90=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UnkyZud/; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UnkyZud/; arc=fail smtp.client-ip=52.101.66.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UnkyZud/";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UnkyZud/"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Hx8sr9m9k51zrLD9da6J9BVYFxUxWgX0tfuCuhcmeRrH+D9+2ZYA1+S3Ty4xdX2Nt3oQlZR3Jlj3nSZRyJ2AZLkQQ6A3gRYVMUCd+MefyBYZ+Y80Q9A/yDF41WK1V3rLrJYIDvEyZrBKMbYjiFaOjeNz9mBtFI+KpwhAwWYNiD8rWS4P2D82SErGbL3S+LslXMh5V+t+GooSFV4rLB8DAGqCZGB7PEAOOrdJgCY2zjWCgRSpP1/GaGszxF8yijpoUZtQPPZKrSs8v/I+bfq8QdPwc50KziEA70EwmMrDP8i92J9cMrSkF8FMm5FhxNkJ14kUtlEAfUwFtC6dg9tDGw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2wTgek502EZQXZ4tD0/lfYj/7bczf8uhv1Lx0V78gM=;
 b=h2fDEAVzyT+1/+UXdRzyjvPEAuc4mfO7vN2z82Ox/JOO2FqWlMMQ7EnaqG1I8gzF2NfM802p19uesYD9pM5wpNbmTXRbXW9eGQoMuY2+y1ddvYmLGwpdl+p0dDjEW7f+Lamd0Go6731gSqQd+Ks3UBYGVgGPANcs2mlFl1h9OWehRkOkaT8+KEXEL6JkvyGlxwB6BsIpj2XNqQLVFsvY9Oaat0YHyJLtNJgd7srjDuiIleIVN4HKDdnDFDFgC62jLEkjmgEWUoe2ia8sNx6vH8cziKlqQcNWMTvZY6YidI3k6vBTNWNoF7Uj/Yf8mf3qv03gMGOXCx2AOEPao+gGCA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=huawei.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2wTgek502EZQXZ4tD0/lfYj/7bczf8uhv1Lx0V78gM=;
 b=UnkyZud/CIoOBBqDnR2FQfVYasTA46zAsfj4OTjvhhLNZxhZSXwu6Frq7C3Mwe3TcYnulvy9y06eTkWTp4UvSwB+FJwHkogsRh3rVthLWLMxme/rj74gRdOg5Jcu+Hc2VMbFmETVytxN3wrGuYzW1Tax3pcSryxW0aU9tK7tBCs=
Received: from DB3PR06CA0011.eurprd06.prod.outlook.com (2603:10a6:8:1::24) by
 VI1PR08MB5373.eurprd08.prod.outlook.com (2603:10a6:803:131::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 07:57:22 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:8:1:cafe::43) by DB3PR06CA0011.outlook.office365.com
 (2603:10a6:8:1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 07:57:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17 via
 Frontend Transport; Wed, 18 Mar 2026 07:57:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4ZqbPrqd5Fb2DyflXDsGWvgeWU4xnpTYdWohhoXM2Zn2XfBhm5GIl8ozJTcHVrAx6H1ftSNZ+wmvfNqawB276hO1w1HhxcVmoK0RvBbeVlKYqSrgwPolMnmRE/jxGsBXifcnECqZ7X4tllfHT1DORzC/96ukx95bdWZx2U62edS13QER0SugticA0Dz/7ZSlqKtIGvM9MjaSqMqaK8qp5+uiifUA3y2sX7Yz1ZXeqWq2vCQFqTARdY+zvGH2uUsaqsmqXRLM0R4h6VOaRduVd/OqgFdWHdov9ybxmEupFafZPooNr5Drj8f7DneTQf1u4+gaPK+5QBSfTPfXnn+Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2wTgek502EZQXZ4tD0/lfYj/7bczf8uhv1Lx0V78gM=;
 b=yqDN+j3AvZhZul23kh0BQa6u4CUqnnLbqzFQrpHw2lY74TWXn/jjlfOmQajWXBuks8ITWHo3xyMhm5n9nZQ9WWGWP8AhOzf7TVMwLUBGT4Jwlku88RTNLWDXpGxyQ8x6CukPixfKvh3Cg2/NDuPw4EPE3gOlyoQZXMIK45x8Tu71MGAtvGJs4atkHJxoVq0KKJUAs6OaT4lSyjRoKNyu41b6WNwqD27V22UPguY9+KS5wRU0liBMOvJOSXFh0BOddXAnx8QCIOR/aFgbjaTh3FKcmlw8fBLCdG5GEUSknRQw/SiYx/Dr7IFSy7sWuqvVmfO+mjaH0OmEtWlB4/D6Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2wTgek502EZQXZ4tD0/lfYj/7bczf8uhv1Lx0V78gM=;
 b=UnkyZud/CIoOBBqDnR2FQfVYasTA46zAsfj4OTjvhhLNZxhZSXwu6Frq7C3Mwe3TcYnulvy9y06eTkWTp4UvSwB+FJwHkogsRh3rVthLWLMxme/rj74gRdOg5Jcu+Hc2VMbFmETVytxN3wrGuYzW1Tax3pcSryxW0aU9tK7tBCs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by DU0PR08MB8163.eurprd08.prod.outlook.com (2603:10a6:10:3ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 07:56:16 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9700.022; Wed, 18 Mar 2026
 07:56:15 +0000
Message-ID: <7604db81-f012-4faf-b558-2bd7304632e1@arm.com>
Date: Wed, 18 Mar 2026 08:56:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] cpufreq: Add boost_freq_req QoS request
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, linux-kernel@vger.kernel.org
Cc: Jie Zhan <zhanjie9@hisilicon.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 linux-pm@vger.kernel.org
References: <20260317101753.2284763-1-pierre.gondois@arm.com>
 <20260317101753.2284763-3-pierre.gondois@arm.com>
 <ccc646b2-6af8-48e9-a2d5-9c9b55ae0848@huawei.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <ccc646b2-6af8-48e9-a2d5-9c9b55ae0848@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P191CA0037.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::12) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|DU0PR08MB8163:EE_|DU6PEPF00009523:EE_|VI1PR08MB5373:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c5808a-a429-4570-1b59-08de84c3fc4e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 vUCwr5s+Z3UAGJ+PbDIPyyfN1O9JX+dS72c/fU7YrBamJ3mcDKkHSByeP4ygZ00OBV6UXvYkyegn5s0Wlcqyj02ju/6zFgpoCZ+lb/hu5uizlH9jwd2oLqc/fzi1FzNssbMmqJDyi/Td/f6l97fGDSiEcSQOji7JX+uRvSeJKUP3A0EOxD52jOzXNzwZ8gfh1F+l5QzfMYsPG0YnjnnJ8/7U4QQNRkXYKcIhf7Yi+JlwpiC5IL0sGpHkY6rJ6XN6WWRQVxUFWmcVW/LZFG0Y61noDgVhuIEvvDcUrZZFalUxKSZhYQLuEUAInETkerQgQmGMHkCfsBj+aHw2zwvgMC2wXO361f8iOFT3kZ+sAj3ITsAPjnL1mGFyrnTqjtWrONoZHyaBpZBTZfANIrBJW7EC3EUeexgrI01a1somyO3Y33Wt4FXVbiiop0wsVSZjz/gooPy9QeA9t9zYf89S7NkAXih7bra3yzomOsAG3bbf4mwMlbHZPqtW0/uYZioqvu4aETX0gVe1VO40PXzWOU4+VpTCyn6DiSAnix5z+OL+72pUkaJ4sFvtg7rCTfO2QiO9pc/nX53tCoftkSO7g7aSYqyijd3s5hsV5GtLq5YfUe28x6Bo/g9/6GWiXdJgt/0fAEr1TL8SYmzD2WK3Z4KLiWXhnnXYxZVn6b35hHUt9PssFVX8GLh9xJuwc2iM5vSVLfGpHb2r3tSHf9R2ahxxqvg71bXW1SPhvr+eoC4=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 eR+2Kw+FXea4tTizhpE2vDUq6YxsW+hwtL2aT1rrpLhuMxqKbTp1oP03kL0LZKbLaYGTDC/DOm1GmjoRSc70GSr7amPBIPab+LTjXZ74K0TApNAMSPhEUehYWyN2Xj5yNAXiSdabA/8MJB3UXDp1Okt5XyT0OyFFsGTJH61c2EmZbSQfZiBP87ZIE3Vf59mfguPIu7jQG4Bc5rfAKkmldRiuAj3gwMaSpBou5pKLbm/mStRZPgyL23cw7V68ELW/EO6idAxAv18wyIYCM51JjhUXYtMKx8uXJMYoXUL5bE00sVZQWaZJNAbglMQ1VJRnk4sj0uQJ3FfEMauxW98eww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8163
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	71cc6898-7ddb-4d18-c47a-08de84c3d4a3
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|14060799003|36860700016|7416014|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	FTFFoF8CyKHKbY/z8mAovziIOJvzZfKLasMo/o709FePlgdopwuQUhRh2u+s04B0v4ey2VdKTueAf+V/F4FToMtfD82Z+G9G4rZ7R+ZwDK3j3o4hilKlmZ7XtPJJEjuq1MjtUmBc1BqyzMuMtD8and69doAwyu3NCiEeEECfQOpuQpLH1TwwOIHH7rr+HYpyqaieJ56LRxPVvRcBfPl4/+KYMwl6o8Gv4KrYy29jgOZJSxkRmAKDMYST0JkWNWDJLxR28T4v4a3xGSl3GhF1CTCwVoSgKQVxabY/yreo6Z49iUSxxWDTaNJRTRngeLGWM7yai7M7wIBk2sax/4fHiNGZPsgk27nmZxokOU4TyeV51MhfM1raWkdX+FONIw0d2Ga+aj4na3viTK9HaSY/jWERxXrzWXYjaCAMTlUpP9CIlrdvIMvHCgP+YM4MkIs0+pdPSfIKDTRGW6anYqrYa14D/Bxqh4CKtUU3pbCU7EsDDUStZAZhLj1Qbk0GYr6QrK42hnJqpIdJtgLkv1ItiCy/nnwFRJRhgw2vYro50Snnq8S1C82IgcxQInB09e68G+pCb3nNEvxwM/fqV0bZRxppioMHy7w5xBPvKQce4FXhsB1Xc8VbtxkTmB+sevumZJZlOFeg8soDUfaT9zUItGlzHaKKpB7m6fcvkBqKkv6LNqmTEBjtv/IrV3xoXEBHII6ZiEvKGMJZ6H6+13oaaHYXsy2soTabtD2oYv/vZuw3EcVpEMpSkshvYXp9G1mPG+Fj/EN8yoxj/LIOgVkxVQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(14060799003)(36860700016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EjcA2G25QiFOInn2DA/k22Id3SBZ7b4+pW2aXCzVfUkTRq/Tnty7PCfhfoMFByXI/vpF14EhQwwHlRsFyijmacGNHLm3KD/4W4CRV0lfBo5m2871SlI1ESvPbQ0cjlmDry5R4TxGuvhCyHdvTR7TA2Ldy6sBoTEhPz/SfswZBbNX+yIycDVBa/D8bXNSLvFxTmQzLJbnCbRvqpxxh3pUF0NeLOACBxorOn5zcfOFoadZ5d22iZZf35+tkDcYaZqjMAbtbZjzfCGvA7Q9Xxo8f0vhItdX5aF3FKLwr8wJatREqxEZy8EgGRIaa9mg5C7DtJnnSbS3OSHKlj9yro3JK1rzpoUZCeIOM0cS+dTMtyaezkeIlJzAmO8Pyp+HaZAa9u0o3puXfyafXM19DIQNNUvq7RRHLhg8cgL6DFt795iI2lTL5lBBMYZN5g5KjgCV
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:57:21.8531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c5808a-a429-4570-1b59-08de84c3fc4e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5373


On 3/18/26 03:50, zhenglifeng (A) wrote:
> On 3/17/2026 6:17 PM, Pierre Gondois wrote:
>> The Power Management Quality of Service (PM QoS) allows to
>> aggregate constraints from multiple entities. It is currently
>> used to manage the min/max frequency of a given policy.
>>
>> Frequency constraints can come for instance from:
>> - Thermal framework: acpi_thermal_cpufreq_init()
>> - Firmware: _PPC objects: acpi_processor_ppc_init()
>> - User: by setting policyX/scaling_[min|max]_freq
>> The minimum of the max frequency constraints is used to compute
>> the resulting maximum allowed frequency.
>>
>> When enabling boost frequencies, the same frequency request object
>> (policy->max_freq_req) as to handle requests from users is used.
>> As a result, when setting:
>> - scaling_max_freq
>> - boost
>> The last sysfs file used overwrites the request from the other
>> sysfs file.
>>
>> To avoid this, create a per-policy boost_freq_req to save the boost
>> constraints instead of overwriting the last scaling_max_freq
>> constraint.
>>
>> policy_set_boost() calls the cpufreq set_boost callback.
>> Update the newly added boost_freq_req request from there:
>> - whenever boost is toggled
>> - to cover all possible paths
>>
>> In the existing .set_boost() callbacks:
>> - Don't update policy->max as this is done through the qos notifier
>>    cpufreq_notifier_max() which calls cpufreq_set_policy().
>> - Remove freq_qos_update_request() calls as the qos request is now
>>    done in policy_set_boost() and updates the new boost_freq_req
>>
>> $ ## Init state
>> scaling_max_freq:1000000
>> cpuinfo_max_freq:1000000
>>
>> $ echo 700000 > scaling_max_freq
>> scaling_max_freq:700000
>> cpuinfo_max_freq:1000000
>>
>> $ echo 1 > ../boost
>> scaling_max_freq:1200000
>> cpuinfo_max_freq:1200000
>>
>> $ echo 800000 > scaling_max_freq
>> scaling_max_freq:800000
>> cpuinfo_max_freq:1200000
>>
>> $ ## Final step:
>> $ ## Without the patches:
>> $ echo 0 > ../boost
>> scaling_max_freq:1000000
>> cpuinfo_max_freq:1000000
>>
>> $ ## With the patches:
>> $ echo 0 > ../boost
>> scaling_max_freq:800000
>> cpuinfo_max_freq:1000000
>>
>> Note:
>> cpufreq_frequency_table_cpuinfo() updates policy->min
>> and max from:
>> A.
>> cpufreq_boost_set_sw()
>> \-cpufreq_frequency_table_cpuinfo()
>> B.
>> cpufreq_policy_online()
>> \-cpufreq_table_validate_and_sort()
>>    \-cpufreq_frequency_table_cpuinfo()
>> Keep these updates as some drivers expect policy->min and
>> max to be set through B.
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>   drivers/cpufreq/amd-pstate.c   |  2 --
>>   drivers/cpufreq/cppc_cpufreq.c | 10 ++-----
>>   drivers/cpufreq/cpufreq.c      | 52 +++++++++++++++++++++++++++-------
>>   include/linux/cpufreq.h        |  1 +
>>   4 files changed, 44 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index c45bc98721d24..310d5938cbdf6 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -756,8 +756,6 @@ static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
>>   	else if (policy->cpuinfo.max_freq > nominal_freq)
>>   		policy->cpuinfo.max_freq = nominal_freq;
>>   
>> -	policy->max = policy->cpuinfo.max_freq;
>> -
>>   	if (cppc_state == AMD_PSTATE_PASSIVE) {
>>   		ret = freq_qos_update_request(&cpudata->req[1], policy->cpuinfo.max_freq);
>>   		if (ret < 0)
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 9eac77c4f2944..4c46c7ea318eb 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -775,17 +775,11 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
>>   {
>>   	struct cppc_cpudata *cpu_data = policy->driver_data;
>>   	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>> -	int ret;
>>   
>>   	if (state)
>> -		policy->max = cppc_perf_to_khz(caps, caps->highest_perf);
>> +		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->highest_perf);
>>   	else
>> -		policy->max = cppc_perf_to_khz(caps, caps->nominal_perf);
>> -	policy->cpuinfo.max_freq = policy->max;
>> -
>> -	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
>> -	if (ret < 0)
>> -		return ret;
>> +		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->nominal_perf);
>>   
>>   	return 0;
>>   }
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index db414c052658b..e4f24754df164 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -603,10 +603,19 @@ static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
>>   	policy->boost_enabled = enable;
>>   
>>   	ret = cpufreq_driver->set_boost(policy, enable);
>> -	if (ret)
>> +	if (ret) {
>>   		policy->boost_enabled = !policy->boost_enabled;
>> +		return ret;
>> +	}
>>   
>> -	return ret;
>> +	ret = freq_qos_update_request(policy->boost_freq_req, policy->cpuinfo.max_freq);
>> +	if (ret < 0) {
>> +		policy->boost_enabled = !policy->boost_enabled;
>> +		cpufreq_driver->set_boost(policy, policy->boost_enabled);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>>   }
>>   
>>   static ssize_t store_local_boost(struct cpufreq_policy *policy,
>> @@ -1370,6 +1379,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>>   		freq_qos_remove_request(policy->max_freq_req);
>>   	}
>>   
>> +	if (policy->boost_freq_req)
>> +		freq_qos_remove_request(policy->boost_freq_req);
>> +
>>   	freq_qos_remove_request(policy->min_freq_req);
>>   	kfree(policy->min_freq_req);
>>   
>> @@ -1439,12 +1451,15 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>>   	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
>>   
>>   	if (new_policy) {
>> +		unsigned int req_nr;
>> +
>>   		for_each_cpu(j, policy->related_cpus) {
>>   			per_cpu(cpufreq_cpu_data, j) = policy;
>>   			add_cpu_dev_symlink(policy, j, get_cpu_device(j));
>>   		}
>>   
>> -		policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
>> +		req_nr = policy->boost_supported ? 3 : 2;
>> +		policy->min_freq_req = kzalloc(req_nr * sizeof(*policy->min_freq_req),
>>   					       GFP_KERNEL);
>>   		if (!policy->min_freq_req) {
>>   			ret = -ENOMEM;
>> @@ -1479,6 +1494,27 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>>   			goto out_destroy_policy;
>>   		}
>>   
>> +		if (policy->boost_supported) {
>> +			policy->boost_freq_req = policy->max_freq_req + 1;
>> +
>> +			/*
>> +			 * If boost is supported,
>> +			 * init the constraint with cpuinfo.max_freq.
>> +			 */
>> +			ret = freq_qos_add_request(&policy->constraints,
>> +						   policy->boost_freq_req,
>> +						   FREQ_QOS_MAX,
>> +						   policy->cpuinfo.max_freq);
>> +			if (ret < 0) {
>> +				/*
>> +				 * So we don't call freq_qos_remove_request() for an
>> +				 * uninitialized request.
>> +				 */
>> +				policy->boost_freq_req = NULL;
>> +				goto out_destroy_policy;
>> +			}
>> +		}
>> +
> Something we discussed before has resurfaced here. CPUFREQ_REMOVE_POLICY
> notification will be sent without sending CPUFREQ_CREATE_POLICY
> notification before if adding boost_freq_req fails.
>
> What about adding boost_freq_req before adding min_freq_req and removing it
> after removing min_freq_req?
Yes right, this is indeed what Rafael suggested looking back at the 
messages.
I ll wait a bit before submitting a correction.


>
>>   		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>>   				CPUFREQ_CREATE_POLICY, policy);
>>   	}
>> @@ -2782,16 +2818,10 @@ int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
>>   		return -ENXIO;
>>   
>>   	ret = cpufreq_frequency_table_cpuinfo(policy);
>> -	if (ret) {
>> +	if (ret)
>>   		pr_err("%s: Policy frequency update failed\n", __func__);
>> -		return ret;
>> -	}
>> -
>> -	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
>> -	if (ret < 0)
>> -		return ret;
>>   
>> -	return 0;
>> +	return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(cpufreq_boost_set_sw);
>>   
>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> index 0465d1e6f72ac..c292a6a19e4f5 100644
>> --- a/include/linux/cpufreq.h
>> +++ b/include/linux/cpufreq.h
>> @@ -81,6 +81,7 @@ struct cpufreq_policy {
>>   	struct freq_constraints	constraints;
>>   	struct freq_qos_request	*min_freq_req;
>>   	struct freq_qos_request	*max_freq_req;
>> +	struct freq_qos_request *boost_freq_req;
>>   
>>   	struct cpufreq_frequency_table	*freq_table;
>>   	enum cpufreq_table_sorting freq_table_sorted;
