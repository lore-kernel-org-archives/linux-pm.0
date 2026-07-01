Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011012.outbound.protection.outlook.com [52.101.70.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AB53603C0;
	Wed,  1 Jul 2026 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.12
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923116; cv=fail; b=uxFNWWisfAJXPcHE7ttINr39h6Q60IfnkUKxdyIjkVMkwnJVJ33gGwHAehZXELOeSTf3Vo+/x2IXaIFeMTp/jGSL2W4n2FgXI1pu22FQVEDbzYqXHy65HL+TUnkBBZZOze8bkyFfXjSyrycF6EoO5CA5bqOinb+W4iHcZ0n4+i8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923116; c=relaxed/simple;
	bh=q8i/CuRdO85dBxSfLeWWP0290ujMMn8OuGd2ddMhoAw=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ADdEpotnTDrTyW3shgaJVNOcZoNJzMWebb496QB8C++rGfJRQqYeN7O886/u1b7dLremmNAEcGWOWMUER/cuR7o5CCq6oUPoE0zhRSaKp0y8P3E7ansNFpNjtaN75Zbr8qdwRti228PklOImhZCvvD0NxzCIJR62TtE1+1n9kJE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MfGWjBg2; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MfGWjBg2; arc=fail smtp.client-ip=52.101.70.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MfGWjBg2";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MfGWjBg2"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=uGEWXZ6SLVwctQymunvmArEtcg8u0NFFVUjUNyj7u+ddvp9P0+VQ8q0OdO5UHSfYk8+5B9kWbsDoo4R+GKW0EN6JyDWpgheuC+VRg87q/5JGbrIMG9XsqyARVM0RBMcjxk5Aee/eJroPyWMrvAOnEMc0W2jmQhH8Qs8dEkGi2R/Xa026mgJ5b9NQLy+XATNlUhfJA7sSQGEPtfXHVaTFMC3/QFHY3rey4ODGfNVcBgWIZyCKM/vX8XvN1XRflFt9fAW672RNg1soMiQViTB5yyg4SzuyySBeZX5KCCXJRsKH39nV4GnHlxzefs8xFuGUGOB0eImtIk7I9IXxn/pZWg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQLYcuiI60TJc34NejVutZT8GiTY8t7G9YjJnNfGq+4=;
 b=BQ//MRo0Oyc9rNX71DRm0X8oA/eUL5qgDifKrFFYIjJlxQtDQtyLYrk+sBIoh5/19hX7D4S6U7l1JoSM9PwflnHz9vYUeZKzZ5HKt6hXyl43Huvf4YtwE9cUnoekmj+ispusX2IDDgXhC+IeEZFT6sSVTtoD9z3XsvTL14/NrhN5QuOyZ8EWDAPrw72SAs83XYZeQCrBeZkh+cRBvh2cHDSalnJ+MgLIrTcxZc6urLJN2XL4e0J3ltWOXmbERi/NIwtd5vVunXQujFYjfze/XvSp534gUGkmM7AKbB/EUdEzYUAG2L/1xR7boJmLYsDxO9AGJghlBmeaKzoGrhn6mw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQLYcuiI60TJc34NejVutZT8GiTY8t7G9YjJnNfGq+4=;
 b=MfGWjBg2giSpfqvmgawzanObcKFjUu/yPrH8Bq/srgsePOFTSQqCyncNwBUz3iws4zkk5dOC4bkklpYtnFVIYrp7omAp9lalyZXHv78UuZBvNTYt2iRISKRJ1BUEx9ZpDKU/HbngPR3CdGTEqJ4ts2b3+lCTYMk8D3bZ4MSFDwE=
Received: from DUZPR01CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::17) by VI1PR08MB5341.eurprd08.prod.outlook.com
 (2603:10a6:803:135::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 16:25:06 +0000
Received: from DB1PEPF000509F6.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::74) by DUZPR01CA0023.outlook.office365.com
 (2603:10a6:10:46b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 16:25:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F6.mail.protection.outlook.com (10.167.242.152) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Wed, 1 Jul 2026 16:25:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ig/zO6+ZqZNWIaGxJQGTcWjN5NxH7m1F/SSBwVPt84IT8H2bBZKCDA93pRfAZ+0jU5OwQGbgmUbgxDI2XO4hRo2bAFD/Jan/iNRgFoBkXfR29ZgIqzIve8eEg0W69WlHBtiKPdOxhxsj1Q7EieldgM/u+iJ7Kf33l7w/5VVcnrtWNcW5R6teunfnPVwLvvec9PEIuCIsadwFE/UlBMTV9ohn0QtxJE4XVycP3M1yHG179kTCLzPpdq93yn3RpaxeD/XmBBoDFhlSW6D3SOXFnFPPQ/KkBEjUw8LMQqYzZILcWDV3nT/Dfr602WGYbz2RExFanM5O+zT7/Nwszroyfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQLYcuiI60TJc34NejVutZT8GiTY8t7G9YjJnNfGq+4=;
 b=zMMIXlHjKDYFOURNtVpgLoBNVJfaDatk3+KZfVf/BTvzdoXFJfn8NHs9yXMBn1mg3wgTpa+k4+5TX8ajprwfN9Ke3FIwYTIbKvDMxKOm5rl2Q+6AC9/a4sFdPT7SmvwRtnK2Yj7qj9nxBuHoDJpDHmSFHlqVCHDnV1vDR6dgK262eoQuasrKlHXsmB6HVqPityhSeyhuIiag+iN0LfFrn52wGgketbkdgn+skaCngBxMXlqffwg/zkqns3WctUzvWikh+4oNjiK3G/5NoHYYDSsIdCtQxyP+LJtwC1z6nHks9P9VtcK7+gPYb/RvH3dK+3fNhHiw4icXMMTAorp0Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQLYcuiI60TJc34NejVutZT8GiTY8t7G9YjJnNfGq+4=;
 b=MfGWjBg2giSpfqvmgawzanObcKFjUu/yPrH8Bq/srgsePOFTSQqCyncNwBUz3iws4zkk5dOC4bkklpYtnFVIYrp7omAp9lalyZXHv78UuZBvNTYt2iRISKRJ1BUEx9ZpDKU/HbngPR3CdGTEqJ4ts2b3+lCTYMk8D3bZ4MSFDwE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by VE1PR08MB5646.eurprd08.prod.outlook.com (2603:10a6:800:1a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 16:24:01 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 16:24:00 +0000
Message-ID: <b665ecdd-31c3-4663-8f1b-d734ef0c630b@arm.com>
Date: Wed, 1 Jul 2026 18:23:58 +0200
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v5] ACPI: CPPC: Add ospm_nominal_perf support
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, zhenglifeng1@huawei.com,
 zhanjie9@hisilicon.com, linux-pm@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com,
 bbasu@nvidia.com, mario.limonciello@amd.com, linux-kernel@vger.kernel.org,
 saket.dumbre@intel.com, linux-acpi@vger.kernel.org
References: <20260615185934.2383514-1-sumitg@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260615185934.2383514-1-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0236.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::15) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|VE1PR08MB5646:EE_|DB1PEPF000509F6:EE_|VI1PR08MB5341:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ff9e0b-207d-46b1-5c36-08ded78d4fcc
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|6133799003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original:
 ZY7c+NVrd2XAnO8VvBwuXsc3OtXCWqWweWePIppHOnk3tg22J9lyc7onQicVpnn4K8WwU6kzRdFye1/rJbSR0IchByEf36TqHIHR3U/2AcQYw4gwfN1KYgtGp+/2bStZQYn9AUjvOLCpzTHum2bOJB1q32di5BfcEn4wWSSA8+o50t0jObxd2W6Zi6FUAqMacl8Mi8GG0xKmEobIcHN/L5TWv7COaITkkkkkqFwZ0KIKgepfgJCCe+8sMFZSZVGElOLlYuaF/AJe60MESj3lQE6HgHyW56+dmdTM2DF3qt01typW1sS8n1WJ1y0j1+UQEPaQvRmdkFXCN05als3lDpW7lhf3Xi2a13NJTCzPcp3q/2auNzN1D8Bhxjy61GtqAd6aa5usBl3iN8mkpj8gJEsh6VHckcFUu/XHVRPqmqXoVdHxlCkTYNgnskxbcUXAkJmZ8d+CHSx5/nGmW1N9FcE/wkRP3cdV0fsLSGBhParc+doAsWZV0W9Ej2HKIoQ9WEKKn9ayDTmvFZ9I0vqbz+C3liOa9Fal0pmOfEJCrRTIcv5f40+MCjKLS4nSrplqLJLn+x/M3YL15HOx9KZBEQsO0qMame3TrtynzMyOB7ZG1t4HtM8Bzfq93izunltEehOMya4hFmfxS4uiOw8k8j8FwlG6tigkaTkWargSVwM=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(6133799003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 Z8zKW5M3sLjlfd5yMsmc3mzcVNQs+ilfDF3vPLbd/WoiMBLdubCiEpuLCfNzAw8dGgQxG0czYDLHPaHLa8FSlmSbCsxx+aGyVLPPKDuAWGiHOssWzkdCMWDOtazFyV023WlHtL9KVfXr4tY/mewUHUJskfqoPFy2f5EiA+PpV8c00UAb3xgda0LXyowJAuqGZ/ykf2WTEBFjiZ4rIKYrOwdxZE3mYQ1KyGv5xHUHyMJ7x0wnTvRn8PBx8FYHURUEHPgfjyfmGU1g+Zv1TOhfBeYALwspCfudZtgBx0A2y0KKR0jYjBD/m5vW2cOSvsjsVdhO/lwfIEXZfilBis3oAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5646
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F6.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d6a1a280-2aca-4948-c477-08ded78d28a3
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|7416014|35042699022|14060799003|11063799006|56012099006|6133799003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	RtpVaCO3bDTavzsHsDSqoX8PMMOBLUZOQNr6RhW0SZKxy/n0ccBqXtvsTdlhaviNovJ1TtxYHU03S0p/IEocmEA+2M+4d9lapsdAiOufYOQD+iOs7vO6s1f+isK9IbZ0MtKMdTq0G5giLI/ppSafaRY70YEw0onBNoqw9pzy7WdVCIUvRWMmMe6Q2fK85OHGmvgt90rBICkGBfrd5Efjz39/SRfbeWD0Xgyszb5/E5hosF6pMJWle2IRHnJPKujqOKvHJ8P+vs1LqYCag2mzdH4kXtL54uSqX3XJ1ua4jLxpuVX2K3Rk7TbHrCmQ8BiWI+CZWv+sDOiKLzFXeNWF+SksP9B6OYVKW0qq9PgI+Y+KMDxpzWvudUmqy2D+1yew+pARoGY69cO8dEobZbWH9E64pHMzMVt0Z4N4RUVMPMKhuKiiHsgYoMJ7scVWB+HKqO4j8j0N5TxsA9To1kvYlMnbhR4SCCfZxc8DXqTRYUw7NSZLEPH0RbvypcoMqdYkqqGj16K+4b+dUP43c4wiU10GB6PW9ihmKGD2XnYufJuoCFSi650EbQNNEKdWhR38Q+FDE3gWnXZq/aSqbYbabwxzVqj93ECkK8KFAKHZjTqUfW/Cu0kLdqcbxnsKe1LDa51EEgm9cdlvXSzGSTEzSl/5SvoJ0uOg5ciyoDXR4B6NkwRGg77HrQ9lsdKxLH4CkijL3H5t7LukROOOy9rtkw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(7416014)(35042699022)(14060799003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yqNZHQgRvFhMs7l5qBgLMyOzt2Jws9bQbLBh0tEsE2KS4alF6ddfAIRx/06zroIpHs55QbbWXbOO2o9i2tZ6U6aLuIdO9oXlF6XONJ/m7XDvVnpJyhQjqil5lIOYIU2uITdqKf0COo7v/DqEMf/NXuRrGtu33tAV5pzcSAhBg8MXxjUOsuqyMdB1D0RJRvPMwUsgWU466eWAc8b/KyEHCyroG6+sibwxdmVjkAKiGbLuuyaHBVMdgCvJDObvqVpZHUDsZGvYYOFNb2sCr2oPdZjj4ALOWosR2SC8Msj9GsKgmr0P9UC6Li9MDPgGY7hp95gZUrJiylpRiWWr5D6Ktz3E/sRWsow/1X10GrywgdODraiweFop5rD9W9h3G0kA9aLnyjhoUOkD2AVFCInNUXx6OHZHl1+4g+JxtMnyTo/r7dRdq6GU479yGjrSYH3F
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 16:25:06.0437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ff9e0b-207d-46b1-5c36-08ded78d4fcc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F6.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5341

Hello Sumit,

On 6/15/26 20:59, Sumit Gupta wrote:
> Expose the OSPM Nominal Performance register (ACPI 6.6, Section
> 8.4.6.1.2.6), which conveys the desired nominal performance level
> at which the platform may run. Unlike the existing read-only
> Nominal Performance register, it is writable and lets OSPM
> request a lower nominal level than the platform-reported nominal.
> The platform classifies performance above this level as boosted
> and below as throttled for its power/thermal decisions.
>
> It is exposed as a per-policy cpufreq sysfs attribute in kHz, to
> match the cpufreq sysfs unit convention:
>
>    /sys/devices/system/cpu/cpufreq/policyN/ospm_nominal_freq
>
> The attribute is documented in
> Documentation/ABI/testing/sysfs-devices-system-cpu.
>
> Writes are converted to perf via cppc_khz_to_perf(), validated
> against [Lowest Performance, Nominal Performance], and applied to
> every CPU in policy->cpus.
>
> On read, the current register value is returned, or
> "<unsupported>" if the platform does not implement the register.
>
> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
> ---
> Patch 1 of the v4 series ("ACPI: CPPC: Add support for CPPC v4") is
> already applied, so this contains only patch 2.
>
> Changes in v5:
> - Add cppc_get_ospm_nominal_perf() to read the register directly.
> - Drop the cppc_cpudata cache variables ospm_nominal_perf/_set.
> - Show_ospm_nominal_freq() returns register value or "<unsupported>".
> - Register rollback reads the register too.
> - Move range check into the sysfs store from cppc_set_ospm_nominal_perf()
> - ABI doc: update read description and add a task-migration note.
>
> v4:https://lore.kernel.org/lkml/20260527194626.185286-1-sumitg@nvidia.com/
> v3:https://lore.kernel.org/lkml/20260514194822.1841748-1-sumitg@nvidia.com/
> v2:https://lore.kernel.org/lkml/20260430142430.755437-1-sumitg@nvidia.com/
> v1:https://lore.kernel.org/lkml/20260427051823.280419-1-sumitg@nvidia.com/
>
>   .../ABI/testing/sysfs-devices-system-cpu      | 26 ++++++++
>   drivers/acpi/cppc_acpi.c                      | 32 +++++++++
>   drivers/cpufreq/cppc_cpufreq.c                | 65 +++++++++++++++++++
>   include/acpi/cppc_acpi.h                      | 10 +++
>   4 files changed, 133 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 82d10d556cc8..a8d592c08823 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -346,6 +346,32 @@ Description:	Performance Limited
>   
>   		This file is only present if the cppc-cpufreq driver is in use.
>   
> +What:		/sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
> +Date:		May 2026
> +Contact:	linux-pm@vger.kernel.org
> +Description:	OSPM Nominal Performance (kHz)
> +
> +		OSPM uses this attribute to request a nominal performance
> +		level lower than the platform-reported nominal. The
> +		platform treats performance above this level as boost
> +		and below as throttle for power and thermal decisions.
> +
> +		Read returns the current value in kHz, or "<unsupported>"
> +		if the platform does not implement the register. Write a
> +		kHz value in the range [lowest_freq, nominal_freq].
> +
> +		Note that tasks may be migrated from one CPU to another
> +		by the scheduler's load-balancing algorithm, and if
> +		different OSPM Nominal Performance values are set for
> +		those CPUs (through different cpufreq policies), that may
> +		lead to undesirable outcomes. To avoid such issues it is
> +		better to set the same value across all policies, or to
> +		pin every task potentially sensitive to it to a specific
> +		CPU.
> +
> +		This file is only present if the cppc-cpufreq driver is
> +		in use.
> +
>   What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
>   Date:		August 2008
>   KernelVersion:	2.6.27
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 9f572f481241..1fcc22a10b4c 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1685,6 +1685,38 @@ int cppc_set_epp(int cpu, u64 epp_val)
>   }
>   EXPORT_SYMBOL_GPL(cppc_set_epp);
>   
> +/**
> + * cppc_set_ospm_nominal_perf() - Write OSPM Nominal Performance register.
> + * @cpu: CPU on which to write register.
> + * @ospm_nominal_perf: Value to write to the OSPM Nominal Performance register.
> + *
> + * OSPM Nominal Performance conveys the desired nominal performance level
> + * at which the platform may run. Per ACPI 6.6, s8.4.6.1.2.6, the value
> + * must lie within [Lowest Performance, Nominal Performance] and may be
> + * set independently of Minimum, Maximum and Desired performance. The
> + * caller is responsible for validating the range.
> + *
> + * Return: 0 on success or negative error code.
> + */
> +int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
> +{
> +	return cppc_set_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_ospm_nominal_perf);
> +
> +/**
> + * cppc_get_ospm_nominal_perf() - Read OSPM Nominal Performance register.
> + * @cpu: CPU from which to read register.
> + * @ospm_nominal_perf: Pointer to store the OSPM Nominal Performance value.
> + *
> + * Return: 0 on success or negative error code.
> + */
> +int cppc_get_ospm_nominal_perf(int cpu, u64 *ospm_nominal_perf)
> +{
> +	return cppc_get_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_ospm_nominal_perf);
> +
>   /**
>    * cppc_get_auto_act_window() - Read autonomous activity window register.
>    * @cpu: CPU from which to read register.
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index f6cea0c54dd9..d160ceced7d9 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -1011,11 +1011,75 @@ static int cppc_get_perf_limited_filtered(int cpu, u64 *perf_limited)
>   CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited_filtered,
>   			 cppc_set_perf_limited)
>   
> +static ssize_t show_ospm_nominal_freq(struct cpufreq_policy *policy, char *buf)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	u64 perf;
> +	int ret;
> +
> +	ret = cppc_get_ospm_nominal_perf(policy->cpu, &perf);
> +	if (ret == -EOPNOTSUPP)
> +		return sysfs_emit(buf, "<unsupported>\n");
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%u\n",
> +			  cppc_perf_to_khz(&cpu_data->perf_caps, perf));
> +}
> +
> +static ssize_t store_ospm_nominal_freq(struct cpufreq_policy *policy,
> +				       const char *buf, size_t count)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	unsigned int sib, freq_khz, failing_cpu = 0;
> +	u64 prev_perf;
> +	u32 perf;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 0, &freq_khz);
> +	if (ret)
> +		return ret;
> +
> +	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
> +	if (perf < cpu_data->perf_caps.lowest_perf ||
> +	    perf > cpu_data->perf_caps.nominal_perf)
> +		return -EINVAL;
> +

Sorry I didn't notice in v3, but this function is the only
one setting the registers for all CPUs in the policy.

In v2, the interface was per-CPU. The main issue with that
is that we need a mechanism to aggregate values of CPUs
in the same policy.

In v3/v4/v5, the interface was per-policy, but the
ospm_nominal_freq was set for all CPUs CPPC regs individually.
If we do that, the sequence:
- unplug a CPU from a policy
- set ospm_nominal_freq for the policy
- hotplug back the CPU
might cause inconsistencies in the CPPC regs.

Maybe it is better to continue with the assumption that all
CPUs in the same policy have the same interface ? This
assumption seems to be made for auto_sel and other regs.

If this makes sense, would it be possible to:
- add such check and warn if it is not the case
- set the ospm_nominal_freq value only for policy->cpu
(and remove the rollback mechanism)

When updating the ospm_nominal_freq, we should also:
- update policy->cpuinfo.max_freq if boost=0
- refresh the freq. limits
- set policy->boost_supported if it is not already the case

Also, update cppc_cpufreq_set_boost() should rely on
ospm_nominal_freq instead of caps->nominal_perf as a reference.

Please let me know if this is ok

Regards,

Pierre


