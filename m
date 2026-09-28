Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011052.outbound.protection.outlook.com [52.101.65.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01803290C5;
	Mon, 28 Sep 2026 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.52
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598109; cv=fail; b=qR42nLR7J3Dj6jBZdYT8FL33AAOp/Wu2/3jMpzh6nqIEfOlJHyyj/xrPkPqWmGRDCy/riaIa18sNA4BWlUp72FEXY8zmhKRfHSx7l2N3OiWobblx64SuOcZDvOhmg94N5uHuYk99jkFHszwcnNxxclFJDpRmNz4ngILWncOuKDs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598109; c=relaxed/simple;
	bh=IeKVBdmRFZuxAZsxmH10tt041RguarhC1LXDp8C9sLA=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sN+JnZtAeG80kSotTxgx8B/H8B0X4ee8RF6MuO2oiRNnEB4zEv5usHstwqSA1uoiD6ZKyQEOlcg4YrImuZgRg4dMZC2oCilGd5pNaDbupO+VpG1/sJaBLzqWOctSmEgDL8381ZKavGDuLHxw6u5cZNC9MA1qDvfDfn2A+v/mcYE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EQJYCsYD; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EQJYCsYD; arc=fail smtp.client-ip=52.101.65.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EQJYCsYD";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EQJYCsYD"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=NJwy2opvOPVaYL1gvT5OVuUXEzjEKA6L1urA8vYPOuh+koHUKFmz0yOaSgprvag7qQZdTt2v79xxzFtWy7GszHJZTahOxNSDNhfcaMtRkc82JOcg42wki/9Vnen9IxlJIBx+nCD5XgB1DAAtce3Jy0G80apW679XvOmqUxMwPxEElAKSL15K1uT9+YOmN/IsvGlwGW7ca0fL3NBr+CcVdSGua4pgy3ZDIODhgABwdN0M98WbCGTspVbeZE4mDGzPM/ZN6Nh/z2juLM9+J6Nf52sqCXrkFKM/nhJswkwanq4q73ZtlnlXQ0ViQ/2uEm4jHKChF8nxsAtzgoDObUV+kQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQY8OLE9s8YJ+eInybIKT9Cvpk5pCYTL9tVN/Ym4Opo=;
 b=Y0NCg9QJdpeatPGNYkzFB6BZLz0P2A8bhN3uAnw1nIk30CCVEYdYY7DTaIJo0jKGmDRlkBTKyJMwwYZ9IiLHwVeE6Vb8f6mKgi9weHuSdfULDTuEjEHi4AiRPAcHYkVxo2HKQ3HdmQ4lLudcDu5gTUcLDqTS0JbvZuZnuEv3ldpRkXjF9vlHVjaVoz+DYTumN0SA9CT1k1GzY0I3AvqbZ7m2hi+fHpVSAKcRQ18M1iM1Emd+ztWM131o4cagrMvVp8S0wL7vFlN+AzpfCr21T9OxN+By2aWIULDfmv+QeE+jN760I5QsRqFG03vurFHwsOBcA/Q0ZkdcemrzS5zWow==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQY8OLE9s8YJ+eInybIKT9Cvpk5pCYTL9tVN/Ym4Opo=;
 b=EQJYCsYD2bMFsdORSD5hwnGWhPiMBYSMRYf/cGfqfsmLxagTUMw2ySkN+r10tJykLYvJvotfoZckJUDR/NeAB1gX6QgtS8lK0CEyrYCdXU1lEdF7IflJopfMXRrg67/fRSSG7gkn9H+qVNQPoO7KYHptY30xATXUxezdwZ/g6Ec=
Received: from DUZPR01CA0110.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::7) by AS8PR08MB9289.eurprd08.prod.outlook.com
 (2603:10a6:20b:5a4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Mon, 28 Sep
 2026 12:21:41 +0000
Received: from DB1PEPF00050A01.eurprd03.prod.outlook.com
 (2603:10a6:10:4bb:cafe::5d) by DUZPR01CA0110.outlook.office365.com
 (2603:10a6:10:4bb::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Mon,
 28 Sep 2026 12:21:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF00050A01.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Mon, 28 Sep 2026 12:21:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9NtOWHRXAcVzIdq2AR/mYb2HFAQDQO0i2TxfmvuREGcYqueIDySl0z8wUv8MgNAsgLp/F8Ob+BkUiNcKtFM7m8DKpu6KWWs+Tz2GvJMKH9vqEpTJG2Ihl16zyIXg0m5vVaL7d2mF/7gLsV6w+Bzo9xIKMGwgmVZ39y1/M6uMoi2fmaKheytVXoSUeateUsAUYQkT1sKbpf6ZQDYBxDCqGdYCofrMQj4Q4BmMDebEWOs1T4WwE02/04IxQfljiJDVUq9lYV8NVA/bJEFpVvY20eMtUNSuqjah24bQk3FIVX+RPTVtcbssXs0wEJusFbxcze4oNWfJcoHbWtXEwJTQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQY8OLE9s8YJ+eInybIKT9Cvpk5pCYTL9tVN/Ym4Opo=;
 b=n0Ld8VDLswLokD32dNswdQwqLVsemB1YbkTOyCICW57+N8+TOpI8Rn1PHpZIp1/6ttskOe2Qvyz6o/cZwIIK/KyQgAj1Odl74/ZMTsb8I8BR5lZMRvU5xcXgSxE3g0SDkqY30QJbDVg6UCI6BYNNo88SV/VXuym4SRrux68ihlUgxl57syTtzjCSDq0UdnniMZwsQ7fu1r8vreEsWuT7vfjbDuHGQbvC0iDsybbZxLBApG9NT1nce8uYVZtEvC9jKKFoVaIjObxhpu0iszWmR+AJ27PLi5rAzgSf1lIwnbvLCnSWYLf7lNqHLGSeYDIXzyVxdR8UdDUHz1YDOD845g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQY8OLE9s8YJ+eInybIKT9Cvpk5pCYTL9tVN/Ym4Opo=;
 b=EQJYCsYD2bMFsdORSD5hwnGWhPiMBYSMRYf/cGfqfsmLxagTUMw2ySkN+r10tJykLYvJvotfoZckJUDR/NeAB1gX6QgtS8lK0CEyrYCdXU1lEdF7IflJopfMXRrg67/fRSSG7gkn9H+qVNQPoO7KYHptY30xATXUxezdwZ/g6Ec=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by GVXPR08MB11129.eurprd08.prod.outlook.com (2603:10a6:150:1fc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 28 Sep
 2026 12:21:06 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.21.0451.014; Mon, 28 Sep 2026
 12:21:06 +0000
Message-ID: <e6ef3dd2-c2dc-4156-b5d5-35cad9c524f2@arm.com>
Date: Mon, 28 Sep 2026 14:21:04 +0200
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v5 4/4] cpufreq: CPPC: Preserve OSPM-set registers across
 suspend/resume
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, christian.loehle@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, lenb@kernel.org,
 ray.huang@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
 kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20260916103820.1760297-1-sumitg@nvidia.com>
 <20260916103820.1760297-5-sumitg@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260916103820.1760297-5-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0138.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::17) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|GVXPR08MB11129:EE_|DB1PEPF00050A01:EE_|AS8PR08MB9289:EE_
X-MS-Office365-Filtering-Correlation-Id: a37f03ae-d424-4630-cfb4-08df1d5b0d4c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10067099003|4143699003|11063799006|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info-Original:
 Je8dWCcQGr0CCD9izOj4nRAyugCJDiTcwcKo33DQvunjFbqJ0LNKuRqV84TkGQEPmR/roJF16+vjtQzAB8D/dhuPgMFrnQL4V8l5C3K0xbGS6l14yFcJH3+dOtsdl3wgbfCOA0x47rLLSpIOwFjWjbhvi4OJ2RQNazsFTrPCtRRCktRrMl0FiUdovt1WZA6GvDWfQNw7nJGMd6zHWEuHY40wcCPh1uqikcgjFfUlDHhRYsC9Y1vejTbO8si9VBLdMAAT1FD6x27JcWawxvcD7re4GZbSJUvRDrAkmlKGH9ffZmSKvT3KMYpWjlj4F46kyDlqtPL0whmJd1C+8Ctv0apji6asc0+qmQIwiCthcL7Jq/2xwULx+ZLlb/O0NV1JUpuglHQu6g36E3oX0gbdFtQLHfy+/zMyounr8VeQyLHbcf27TJ8NIfqwZgS9pbxnSeTBdC1Zs25xPvRPpls52KyWm4R+vOXjy/T0uzx2ZAxjBlbE8qnsFHyz+J4eBIcI4vBewcqwBKmzETnQbMgH7LAU1rUwl9MwWnAp1oTG2qYKj/GbwtywaFXl9ah6GR1kZJEGqjUq4qQvfPLXFq3Id6/JEDi3AqA7GEwis45HOISx0t1LrMYE4N0gA0fM5mchqOK6fiah2wXkzzEB8wDF2A==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 Qzz+zW4DXFmCBUL6d1hFRlcdbCQspOCg614oCSHEwvmOAScgPH8zA+jTPTz0zEWoJZY9fYPLbfH/8FXZWdPt5XdQDTMUPLkQfD8oXOQhGlLw/6zqpoiC1mguSZgS5CsC0yedfSXQUfQpSq3PgASZALH7Rzhtxbe+qI9LyJgTPQDhzNtCPeUnYFGrfJHjvDVFiMYJTmrOAmgYAtwNEk/uEwJ0c3TLfuRJWeHspVuhC8gz4rGO/49QZe8uwqMaXnjnQCRRxGRMLe/m4FyH+RRBIF+B+7qScF3X5wS+Dml26awHcTqcWT+8furabzVPjhcBXMmG/a57ioZJO9+w20fHFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11129
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c264e8bc-034c-43ca-7a72-08df1d5af857
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|7416014|376014|23010399003|36860700016|14060799003|82310400026|1800799024|921020|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	V9x7ZDA+Q4D3GDDAC7QtXVHtHtVoiJ1KlQTXvwBkzXuncV/wjbXBDMqTe9uAq7kTo+a16+QZ4Ov2dfwnyAxu8H4ITgutpjStj/UmBPd9nMjURiQTOAt1a3Yw+6CnEbrtaLVHetZVOm35HlQq3iWEsqmB8mOnLxcUJwii+UcRn9mimnnvYWepGxdMhbuMh9+VeQPIW2ba5UYZyKZYC/Jza6+CALRr+cYmNmPP9P8LEfclaJAtB6G0IRhuQUDa7YX1+HSMJb34CBHdoM6fuLhnBdhVM9Z1hNbVwHTC4weBgIKieAGd99e+cCgs7xFrMB+UzlCADOqVOh45sjcIvg50TxV8qbAuJrMR3j+JdPyk9iCUCVVyN0MjA7NyIqPQ56Ta2R6zkahxf5XDOXOnXkkfWYwg4h5apEDwUTno4K6OgzkI+WswgnwU7MmGykxT2hqKkwowcKkb4YopRgolpp7s2A0XPgc1/AzQwnPjkL2uSXW/IbIGswcuLDmkRejYWk1EBfeyzknsw6pf1aRz7FtQDpdE1cYnnMflyLbBIUj2OmxDYpkNEJ2k0kHpx3CMuTxHgL4SlsPKBAU5mGUkJYcVkquFy2czxZQE9OJG7zkshivgyx7lLFy4ig7lEwMR1YyUTaMiMxkKXKxjUqi0F+lPeuL/Hcem6E6PfyMP9KSYdX6Vf/iOSclk/AYhnHTONiEO
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(7416014)(376014)(23010399003)(36860700016)(14060799003)(82310400026)(1800799024)(921020)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+NJT08Q5R/k99HHv8TavP74TEY+DCkWEYNcIXsheogr3CxBJDjfP7/m+iPpq1Bb1tDyMVFFLBOI6YMk/9DcsvTpzKqBCAYuAW4nVBYyttYS59VW0Z29E1d9bhlR12B1VrF08qaFkTJx1Ultv5TUd6gb64HwpGb0Rjj3wmhhz7lnxCejs4fNBWN+/kq4CaVJsD74PjDFpAmbVHbUknw1XjaUpsCrO3r2DSX7ciSx8H7e8rY0308Cow94W+j3dCMd8as+cPXvhFA3qTZaDC0a5GW4PfgWH+BfeUtfbGQ9Lt3MbLsuvgkku+ojtrhW9Kapzxdqe0Vo0VkxldSTmyUX+T/ip5SyYWwKBvVaKjBQz0zmQn4qaX862eAHdiOVwTAO9Hsj0viDuhU/dgaF3VFB+NwMl29agcMF0vd+MVfxTz+QeDYW2jT/s3Pw32YWR9/t/
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 12:21:41.0982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a37f03ae-d424-4630-cfb4-08df1d5b0d4c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9289


On 9/16/26 12:38, Sumit Gupta wrote:
> The driver preserves the OSPM-set registers across CPU hotplug, but system
> suspend/resume is a separate path. On platforms that reset those registers
> or the performance controls across suspend, the values are lost.
>
> The hotplug callbacks cannot cover suspend on their own. Secondary CPUs go
> offline only after devices are suspended, too late to touch the CPPC
> registers. offline() does not run for every policy either, as the boot CPU
> stays up during suspend-to-RAM and no CPU goes offline during
> suspend-to-idle. The driver's suspend() callback runs earlier, from
> cpufreq_suspend(), while all CPUs are still online and no device is
> suspended, so CPPC access is still safe.
>
> Reuse the same save/restore mechanism for suspend/resume:
>
>    - suspend() saves the current OSPM-set values, restores the firmware
>      ones and sets a per-policy flag, suspend_regs_handled, to record that.
>      It also stops the frequency invariance updates, so that no sample
>      spans the suspend window.
>    - offline() sees the flag and skips the save and restore, as suspend()
>      has already done both. Saving again would capture the firmware values
>      that suspend() wrote back and lose what the OS set. It still requests
>      the lowest desired performance.
>    - online() clears the flag, so that a later offline() takes a fresh
>      snapshot. It also restarts the frequency invariance updates.
>    - resume() calls online() for a policy that still has the flag set. CPUs
>      offlined during suspend come back before the core calls resume(), so
>      online() has already run for their policies and cleared the flag.
>
> Suggested-by: Christian Loehle<christian.loehle@arm.com>
> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
> ---
>   drivers/cpufreq/cppc_cpufreq.c | 63 ++++++++++++++++++++++++++++++++--
>   1 file changed, 60 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index ac315071a979..11f2e8111ef9 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -87,6 +87,12 @@ struct cppc_saved_vals {
>   
>   struct cppc_policy_state {
>   	struct cppc_saved_vals regs[CPPC_NR_SAVED_REGS];
> +	/*
> +	 * Set by suspend() after it saves the OSPM-set values and restores the
> +	 * firmware ones, so a later offline() does not repeat those accesses.
> +	 * Cleared at init() and by online().
> +	 */
> +	bool suspend_regs_handled;
>   };
>   
>   static DEFINE_PER_CPU(struct cppc_policy_state, cppc_policy_state);
> @@ -895,6 +901,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>   	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>   	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
>   
> +	cppc_cpufreq_policy_state(policy)->suspend_regs_handled = false;
>   	cppc_cpufreq_save_regs(policy, CPPC_SAVED_FIRMWARE);
>   
>   	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> @@ -986,6 +993,8 @@ static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
>   	unsigned int cpu = policy->cpu;
>   	int ret;
>   
> +	cppc_cpufreq_policy_state(policy)->suspend_regs_handled = false;
> +
>   	ret = cppc_set_enable(cpu, true);
>   	if (ret && ret != -EOPNOTSUPP) {
>   		pr_warn("Failed to re-enable CPPC for CPU%u (%d)\n", cpu, ret);
> @@ -1034,9 +1043,14 @@ static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
>   	unsigned int cpu = policy->cpu;
>   	int ret;
>   
> -	/* Save what the OS set, and leave the platform in its pre-driver state. */
> -	cppc_cpufreq_save_regs(policy, CPPC_SAVED_REQUESTED);
> -	cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_FIRMWARE);
> +	/*
> +	 * Save what the OS set and leave the platform in its pre-driver state,
> +	 * unless suspend() already did so earlier in this suspend cycle.
> +	 */
> +	if (!cppc_cpufreq_policy_state(policy)->suspend_regs_handled) {
> +		cppc_cpufreq_save_regs(policy, CPPC_SAVED_REQUESTED);
> +		cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_FIRMWARE);
> +	}
>   
>   	/*
>   	 * Stop the frequency invariance updates and cancel the pending work, so
> @@ -1061,6 +1075,47 @@ static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
>   	return 0;
>   }
>   
> +/*
> + * Run for every active policy when the system suspends, before any CPU goes
> + * offline.
> + *
> + * Save the OSPM-set values and restore the firmware values here, while CPPC
> + * access is still safe. Secondary CPUs go offline much later, with devices
> + * already suspended. That is too late for these accesses, so offline() skips
> + * them. Doing it here also covers a policy whose CPUs stay online, for which
> + * offline() never runs.
> + *
> + * Stop the frequency invariance updates here as well, so that no sample spans
> + * the suspend window. offline() would not do it for a policy whose CPUs stay
> + * online. online() restarts them on the way back.
> + */
> +static int cppc_cpufreq_cpu_suspend(struct cpufreq_policy *policy)
> +{
> +	cppc_cpufreq_save_regs(policy, CPPC_SAVED_REQUESTED);
> +	cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_FIRMWARE);
> +	cppc_cpufreq_policy_state(policy)->suspend_regs_handled = true;
> +

Shouldn't we also request the lowest freq when calling suspend ?
This would make suspend/offline() function look similar aswell


> +	cppc_cpufreq_cpu_fie_exit(policy);
> +
> +	return 0;
> +}
> +
> +/*
> + * Run the online() restore for a policy whose CPUs stayed online through
> + * suspend.
> + *
> + * CPUs offlined during suspend come back before the core calls resume(), so
> + * online() has already run for their policies and cleared the flag. Only a
> + * policy that still has it set needs online() here.
> + */
> +static int cppc_cpufreq_cpu_resume(struct cpufreq_policy *policy)
> +{
> +	if (!cppc_cpufreq_policy_state(policy)->suspend_regs_handled)
> +		return 0;
> +
> +	return cppc_cpufreq_cpu_online(policy);

I think there is something raised by sashiko:

https://sashiko.dev/#/patchset/20260916103820.1760297-1-sumitg%40nvidia.com

about the fact that fie is init using policy->cpus and exits using
policy->related_cpus. Is it possible to check ?

> +}
> +
>   static inline u64 get_delta(u64 t1, u64 t0)
>   {
>   	if (t1 > t0 || t0 > ~(u32)0)
> @@ -1356,6 +1411,8 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>   	.exit = cppc_cpufreq_cpu_exit,
>   	.online = cppc_cpufreq_cpu_online,
>   	.offline = cppc_cpufreq_cpu_offline,
> +	.suspend = cppc_cpufreq_cpu_suspend,
> +	.resume = cppc_cpufreq_cpu_resume,
>   	.set_boost = cppc_cpufreq_set_boost,
>   	.attr = cppc_cpufreq_attr,
>   	.name = "cppc_cpufreq",
