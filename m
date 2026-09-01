Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012023.outbound.protection.outlook.com [40.93.195.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FED378D87;
	Tue,  1 Sep 2026 04:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237677; cv=fail; b=mzBSJoN2Xupsp6vvJmBJlKW7YY2a0q01C9iuGFH0esBgyhCqsdZUnj/8j57hwdmdHcCdxTB9Pc1wYqGmZebHS6J2ysnExAhVkA/LCpf9+OefsjMLCWyb8wk/kze54PRrrIj0jPHAuauQBVijM2ThShiQGARHYZlh00XS01oaNqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237677; c=relaxed/simple;
	bh=OR/pfQFo4kKaEizooS9Kz45HilRKpIrAuqLOSZ7ZIRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nYm6Zxzz6Z8XuvDy2gasKN0A41kw9RSOvMbyydvPiv82+mraEauKWMrHh3nOxzHywhsL0T4QgK+paTal5SUugisjnsZKdmtr68n+5fscExI7CfQ0BjqcmPlD1tgfGlB9cYq/Y+i9D65NUul2cnFuNAotuet4E6vtMyiEJabqBgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CTmmARRS; arc=fail smtp.client-ip=40.93.195.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CTmmARRS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4hzcalI49Pr1KajlXdrBJt3hoSsloY4GXl/Y+4baeXjbznfIjCuEPOIplVhz9LHkqqtjO6MMXvxV2EtnXhJuv5JCoN4MTuk8Sl3gZyO3mzEhQ5wMIRR8EDaZL1mij5FnF4qLLQkXfVORFimDrhc5y+wwchr0x2euWaj1smsW0UEbnlRY2wEUehn1V9b3Zzuf3HW7n4wa14upUeo6Ua7yEp3oA2GOMiXhrpH58Qgsi61VhUtK6bcl7+48/zYq6KUfOBQyZfYHZOmKZQrzF7SdAjJdiDvjy4vwgmoaXdnJNXShneEA89OEp7bG0TE/XlpfeM/Od3pxcUY5JHedInJfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PF0uJzn0QgaFnynz7C/bn4oK2YlTIulIpGgODEYphQw=;
 b=JkGL4KulOfoQuPCO5yo0zxws5Db/tv1uC1ZZ2Jd7UoxxOk6hGYHxRemaiGlLqZqESmmhX2vMjkAZ8EgA8tMliTvIjM7yPHuiIIBWrjjTrEUt1cbQxtrzpMKy8v9TWKRnQYLldLPnAt8yxbl7BJABHc//y4fll0SIMbiTMuOSF/ged71cBxq14GjOHTg61HmyLtrGJREnnmJ820+wyYLWXhHGMPWGsYmnWAZnJZwgZmX/62qN7wA27AGdOfUZFWR/6rde/1Vj4UUoof9lw7DhiUzYg6LQ7pNFDfgZt1Ke12i/nRzBrohjheG2naU0p2Clbx8v9zTx6WvAKpJDxwNM/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PF0uJzn0QgaFnynz7C/bn4oK2YlTIulIpGgODEYphQw=;
 b=CTmmARRSUahz7219TxucKZ9dr80PwePXa58zavrJfSCAOWscI1fA+HwGcTLG2uB4FQioVfbPj3Cy8GnRBGIHovWyqAQHM4hOmwlK4v3uEwwEesDwnq1ZuOW6cY8zAWbLivDC2i3tVBvTEsSjSB5rkGTDJfPKW+MqW5bJPmtT5Fo=
Received: from MW4PR04CA0155.namprd04.prod.outlook.com (2603:10b6:303:85::10)
 by DM4PR12MB6376.namprd12.prod.outlook.com (2603:10b6:8:a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 04:41:12 +0000
Received: from MWH0EPF000C6187.namprd02.prod.outlook.com
 (2603:10b6:303:85:cafe::54) by MW4PR04CA0155.outlook.office365.com
 (2603:10b6:303:85::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 04:41:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6187.mail.protection.outlook.com (10.167.249.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 04:41:12 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 23:41:11 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 23:41:12 -0500
Received: from [10.136.35.162] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 23:41:09 -0500
Message-ID: <1aab438e-9841-4def-8982-1433f38c0e96@amd.com>
Date: Tue, 1 Sep 2026 10:11:09 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ACPI: CPPC: Refactor boost ratio handling
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <x86@kernel.org>, Vishal Badole
	<Vishal.Badole@amd.com>
References: <20260831194428.2287055-1-mario.limonciello@amd.com>
 <20260831194428.2287055-2-mario.limonciello@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260831194428.2287055-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6187:EE_|DM4PR12MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 42512e90-a036-48a8-754c-08df07e3402e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vZYBkkAoqdvp6afLYLpVN8C31AL/rCdwompEJc9vkwj000hUDhVFZnyZwQ0x1WA85HM0nK2QglrWkc4p6OVMQaNQNzp8pgtDbNFxPo3jR1TIyN13h2f54FVld4b8f9+MAg4feRRsj3pNv/U2/0Smu8OsvGWBX5VwAotoCEvJSQFW6iy4u7reZR3O1mgwItuxgatxh/xUtXKdJpa29d6U387dnO+5RghFLJqQIpBPMq8TnxTuEq7i0TS0mZJYZXhzUK3KZKuLtnZ1rtqfVTwv6M8aKYkkYz8uq3n3gW28h50LE1rm+uvR8lyHebOkv3iKCLhPvDhoGmmbY284tRnYQS5ZgkhJGCv8CekcgsGF9gwpYORamHzwJrsYa7lZ2WHQFTs9+gu95UgcozqKfXzvIVw6FiCrrBxOG/+NfyAPvU5EQy6945CweMnZMlnJY3cnfj0KvEsFyMj72Lr0hX2uQOnff9qkOfFvLiFcZwTEdLwkGPvmrwkCNU7h/UzJHIgtrGRnc+0McmgWnxxH8LOgaWE/v2rY4RQpNypcsXh9Pv1n2y6v/z2SaPJA6b8i0KWSqZRzkUaQLQdjs8Bc/9LYJ+oUVY5EMNCHCgUCPeMGK9v0SGQKo5cw0+I7Yw8+QGiSJ8bjHC5TeRR8KkQ5dDewrGorsaUyBeovYpKcfcykKx/zyuBWsD9lhkG9V6bD77zIHSVInvZjHwnSQRAB1a/hWA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eKBZc4YHr9ryukRV1pW/7XfQggp2jwJNXD2qOx6tcxeHXduf3DFj+JvMndJUCu35eD143mMoLClt57D83D12I4J4wDAVRp5A4JRlQYmjHgCYFCLWU1n4pHg3Y9hXPMOfC9AOAtdW7o6aTw0QaJs4QOUYtvP+64lrZq9aW4krgN9w/3oLKoqn7pLWn1JWkyo+aAbQc3PwHCcUsZnnrKIc+R3iPY07NnsJb8pFsmwtqyyVJevgB0tPm8yplWGu1tWk0C8eDO5fdG08I8+5IGGcpjmfjnTKyqkfrI1r47PPW9OvBYvoFP6/tU0X3jqanIpk+LbiUsLwUJZulSNnwhaxO+I994jjaJaB/3i8mZoeud1R4r+dRpjebz2e6fBasU56zHTnWt7ZBZJ4wQQ2rskZz6q4z7+4r1CJOjk0F442SBGw0vqfmIzWwRdzX05AZZ1b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 04:41:12.4312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42512e90-a036-48a8-754c-08df07e3402e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6187.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6376

Hello Mario,

On 9/1/2026 1:14 AM, Mario Limonciello wrote:
> +static const struct amd_max_freq max_freq_zen6_client __initconst = {
> +	.performance = 5025,
> +	.efficiency = 3524,
> +	.low_power = 2399,
> +};
> +
> +static const struct x86_cpu_id amd_zen6_client_ids[] __initconst = {
> +	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x1A, 0x80, &max_freq_zen6_client),
> +	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x1A, 0x81, &max_freq_zen6_client),
> +	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x1A, 0x84, &max_freq_zen6_client),
> +	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x1A, 0x85, &max_freq_zen6_client),
> +	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x1A, 0xe0, &max_freq_zen6_client),
> +	{}
> +};

So I see:

  WARNING: modpost: vmlinux: section mismatch in reference: amd_get_max_frequency+0x27 (section: .text) -> amd_zen6_client_ids (section: .init.rodata)

Since amd_get_boost_ratio() can be called post init too, I think
dropping the __initconst annotation makes sense for these constants
otherwise we may have issues after initmem is freed.

-- 
Thanks and Regards,
Prateek

