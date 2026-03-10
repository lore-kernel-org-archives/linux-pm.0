Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013041.outbound.protection.outlook.com [40.93.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1713BA232;
	Tue, 10 Mar 2026 03:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773114313; cv=fail; b=Ww+aDYuMfoERQpz50Qd45yz9xqMWLm2ws6pqJ4oKTqZYG3kBQl+UDiuK2Rwh1ATIDmE0kI1+QKFROV6Mwe0ac84UuTQcYW/c/oRzGlaEV6DydzlBBYfko+OOsEFYGat313rmyn8wI6sTWyBt/sC2M6xSIcgYz0vb7wXpCWA58ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773114313; c=relaxed/simple;
	bh=ZGI0oungSfGcT5Y3ms/fxDKKOMOjfzbEj15VIjEVH2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Uruyh/VmkLrne3ZL4VV3r+hMkpYOp0Bf3vx5i5/XTjWQk1E/VY8azvdvfoadp9CNCuyDc7W7cY/gQ2E82idmsOdULvTe+3PDsBn+tzIK6//fdu4YgilPeKjD8Qo6o7+us56inGc7H3mO1e5iqKWy7hgjcO4IeGa66cGrmtPZxPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4G2TF611; arc=fail smtp.client-ip=40.93.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4G2TF611"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9m/GzI/KsB9P3/TSTbwPycQ/SEsfi21KVBbAuuVI0SvgyUs6JaJ/tgD4nqMXz7kPhwQqgtKEurRmJ4EynTxaEy1bpTAWrmrhPeLMoorQeMrdjqB5TxRRH9TlU/e7mqkGCah2HVCUTxaQKj7yBcbP8TqHnuDkMJ+ygORd87Ct0UuCc581Gpj19uKjLTzgDDjGyl/8PLRGwrbElT1gq5Cn1Z+jfcKKTamcwZt2YBZabGrruqvxrboI9VuVoxntErJn+DyMpFaXgy7T0PhmP3ZLinIykWi4XZyDIicE5+mtJTPbxfqNBXkAw8bA8jTp0xy7Kw+DuldUl04gXYQyPmrWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3WPNX6JnWjR3cYPtHpH7EArFx/xu+T5k56O45xT05I=;
 b=pT6Vnbo7VvNnq6Ld0aoECRl4JO+SD2x/VmWb6A1cVz4l1iU9iIkZhSBoR7NpbeNaF4/EVrFjXEpwZ2z9FkAF9lw53ylh6zmLkFh/vyxPXF2Lnm5LRU7GPGgISyk2aVph4qoFHOBGtW59TVxqxyyP+NvVRSiGAzD32lfHJnLoXE6UpLXsRC+LSZc4wGD+duOGHkXQzcnZ9EjmS4t4YsZ8XSezkYD2QNy8w+VNlyJ6xjjrIVLLanDuYo2Yj1u3aplH15vqAYDuadd7wqNrNJ8d28Kql9sqHgDdVZEMRcfmPx74jftqVf63lF8DL6f3lWyNbKDQhCoG5L9u/KxmIjBAJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3WPNX6JnWjR3cYPtHpH7EArFx/xu+T5k56O45xT05I=;
 b=4G2TF6116A7dJFKIa5micaFluQZfFgxc3v7alRy4yeEDUOGG8AoSN/571M4zJFdGk7ZRa9t19F6iczbY980trhNlCGySZJe1cB24jGUJBnfDCsTfyiP+9Kr32RizU8OeyWRjUCOuyx9cAps1TVyzYAptLZH4Ld1xxx48Pj43y2Q=
Received: from BN9PR03CA0534.namprd03.prod.outlook.com (2603:10b6:408:131::29)
 by CH3PR12MB8402.namprd12.prod.outlook.com (2603:10b6:610:132::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 03:45:07 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::e5) by BN9PR03CA0534.outlook.office365.com
 (2603:10b6:408:131::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 03:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 03:45:07 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 22:45:07 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 20:45:06 -0700
Received: from [10.85.46.243] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Mar 2026 22:45:04 -0500
Message-ID: <aed4a704-6043-4741-ad0b-d98b3aed7666@amd.com>
Date: Tue, 10 Mar 2026 09:15:03 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] Documentation/amd-pstate: Add documentation for
 amd_pstate_floor_{freq,count}
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Viresh
 Kumar <viresh.kumar@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
References: <20260306095753.17155-1-gautham.shenoy@amd.com>
 <20260306095753.17155-10-gautham.shenoy@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260306095753.17155-10-gautham.shenoy@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|CH3PR12MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d73e31d-2b6c-4854-adb0-08de7e576c08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	BfJg8cXcu1DcapyytrHDif8lqUZDEIXvfwTg1KQ4F8OwsugWjvwSi3VkW9I1sS5l87Aunoi2WwPLBKUuoS0RRHjFWRJ1BAsAmicbBxDLG7WJ+21o0c9T0h8UwabfzFgqboLaGPeSbxJl1nddD7xVtxUSpmRL8LllDsB2Z0XJVlRZBclfLFCYKNQ7p92TOgPKRc/0mMcfOprmpTOllCpgeqqPQQCrEPhLXSyUE0QUJ1VHfnzT8cRaxKgRZzWfcVRJLEL/XqiCrENPkx/FYloSjiiGhSjKg4QdpcN+SwIa7fcdAeaH/RUbJsJ9GKxvY9AnZPwdyiHKVdYTl8BkuuqQ49jBKc4P+gdXzAYbuongOL+qtVHgjCiJEK7UDn4aoDXmASOEIAJlugdF92smmfEJtpcZt+ygZG4EcIFrOMu7z15zKlnaoUpYy8otkrZ58L8AVn28WmA6llHX+kpAZkQYnJMusWcW2MxU/8NiBI8xb6MBJTD/F7svoI3HJGOJEszmY7qUMD41ms43yol43nEE/4AKWM3v/cE2Gzxb3mDy+1zTIeD0WWPRiS0mfAz0ToHrc4c0MHq9PCOGKH/xS8bGPst+Y8kgFMYXsfDolm93UpQ9h7tL/ZxWosZrKtFwjF5gm6kRoXfTS/mFUXXYEi8qBl+in9RC2KeYreP0QAgzEZx+n5t1mQ8G546Xq3oYTkhQbqpStdRpYa7ZUU3BAhaWSi7l4ND2l9r1QKJn764cJjMwgPIuoN0aNcc8Evt+6C/3XYvu5KpNJMSGBb4izaiORw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	C7fT/24hTwsfbTrs00zfWuDxDKSp/utAZt+bQbgSnHV8KJjNtEqbueZvdkskjrfJ8ujn12AwcZmxijNXp85BM7ei4xIMJ7o4n+kVor7BU0mwS0SPIcuNq9IW5sfxrLgHGKT+z4fxfuBD2HlArlmvV83vKsU/Ccpxvn99Tw+p5OecWGIAPz9IxEgmOjufChrjG2NUPBAm8kvlFQRdcH/3/yIfu1PBJz6AV/If3GLxOEN1skaN2cvJoL8HpOqgMB/+JzgA1UcfR01pOL+DjCVO5A4+6o4QxQtf9b+8qoxPDNqFsVQfDap4OricZtgTqoTAj6Lo5IGp0SXQqU6Mm6Z0oRNOquscHE+ONLXGN8W2L4B2sshIHomkHCKKyqCuicBHnhwBHayc25FFafT/n5p4kzkx3hLJP4nsN8UAhhKRt+G9FMGkYgxHnud4FVTHYHH8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 03:45:07.2554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d73e31d-2b6c-4854-adb0-08de7e576c08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8402

Hello Gautham,

On 3/6/2026 3:27 PM, Gautham R. Shenoy wrote:
> +``amd_pstate_floor_freq``
> +
> +The floor frequency associated with each CPU. Userspace can write any
> +value between ``cpuinfo_min_freq`` and ``scaling_max_freq`` into this
> +file. When the system is under power or thermal constraints, the
> +platform firmware will attempt to throttle the CPU frequency to the
> +value specified in ``amd_pstate_floor_freq`` before throttling it
> +further. This allows userspace to specify different floor frequencies
> +to different CPUs. For optimal results, threads of the same core
> +should have the same floor frequency value. This file is only visible
> +on platforms that support the CPPC Performance Priority feature.

nit. Should we note that the driver caches the closes perf value and the
read of the file will output the corresponding frequency of the perf
level?

Otherwise, it might come as a surprise to the user that the read of file
returns a value very close to what was written but not exactly equal to
it all the times.

Or should we just cache the raw frequency value when user modifies it
and keep the perf translation bits opaque to the user?

-- 
Thanks and Regards,
Prateek

