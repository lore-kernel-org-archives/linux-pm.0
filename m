Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF14337F8D9;
	Tue,  9 Jun 2026 04:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780980352; cv=fail; b=j2kUivUAeoATkdJKbDv7Q6pihKORHl7SXUqbHkwUQfuGt+X+wbwxwiWgbDkNlXN1CxKpuhTxgzY7G3j8b6EZmNr+eQ/bVUWe43ilIywj0uowTpAev53YmEvceTQfULRkwyk9Cdrb71C46PMXjwi5hDPeSk0fZJxYCZ37pch3KvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780980352; c=relaxed/simple;
	bh=yMHnpEmEsCdZwz4aEjcGW34Vejbs8+e9x+5Xi8RD45I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lU+FmdZkiCGZN/HhWerkoZ+BZygej5cVq4hspNBI9AJYgn5zoz4LDenVosk9H7AKhJDUEu7Ij8AZu/3RqtPejk7g9VPm2s4LU8mbsA4WN9BUVtGJ2QL27bPbF3sPDMdIFn8mrWd65N9wF8IHwZxMg8d80+txC+Zy0suSJdBJpQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lBMnML9i; arc=fail smtp.client-ip=40.107.209.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lBMnML9i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKJXTi13KCDZTKhqT24M+8+wNEBNvG6YdUDAOQZNKNhOOaNCr9EB2iyKLdJMwjXr4glezCnp3oxyc7FUrzKKu1diD1PKJ00COnd75IpewNoi3lblqn0T+90wQCX0fjMvHyi7LwLWx7FIxI1UplM+i3CvJQMg/UmOoKCoOEYemUBLXFAT+GqY568n5axSSIQCZt1biB/P9VYZwY5LfmsCP4FeZ5XsogSbLanqOyJpkG5mDQexlN4HdPvifzxgh0tQNdN7x6yuUiY18k90QRKCypDPY+aBy6d5FjMVI8FYiR629BVFTD8HFdps4oMk+dYeR90qyMPH8h7LD7FLdFh40g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y09JfVOEkodrwtURCxoFhLfLD96l/Ho54Ki5jm1HR4Q=;
 b=Mj79oR0NZ7v1YqPHGZNWLhmzqUyBulTejjOHl99IhV4yAxiU3i6wz1hVGOQLRY4asWQ2L3nt8KmN9A+ITnj9lkirjLVQkyqjhBWZmsKw03gohNox8m80QCGw0at+QxY+ARDz8781tTK4Tcqqdc1cemF8TCBr/sWBVYWr3tBPP2ZtdfKd9JJi6WOHIrc9FDIfP9KsUyKAIhX+mTocGT23fHsArCA7PE2mWJMh5Vv9RcVHWqD9fiK0CX6IbxuM9aei+3VL9WXKmyxh1a4C2I+G7scuU0RViSkfuoxdQJS3ionEF4ICQACUtjKEG457tkYzXRurAfCefV0prEKiZoUPvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=disroot.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y09JfVOEkodrwtURCxoFhLfLD96l/Ho54Ki5jm1HR4Q=;
 b=lBMnML9iSBMRncCG5idDsD724hU/FiqPs6WFXuEDFX7gfBCtuSnvLU55lvLTzirbQjxFuZwUdKPgIQAX8+Hl9RBPU/liyalH3eOOdzydr9BgFO/1PoJTjnfwpk83MonbOrRwuTceQztNTcpPhudMpwKai/cWhtQR29gYvN2ArXs=
Received: from DM6PR07CA0113.namprd07.prod.outlook.com (2603:10b6:5:330::16)
 by SN7PR12MB6981.namprd12.prod.outlook.com (2603:10b6:806:263::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 04:45:47 +0000
Received: from DM2PEPF00003FC5.namprd04.prod.outlook.com
 (2603:10b6:5:330:cafe::78) by DM6PR07CA0113.outlook.office365.com
 (2603:10b6:5:330::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 04:45:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM2PEPF00003FC5.mail.protection.outlook.com (10.167.23.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 04:45:46 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 23:45:46 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 23:45:46 -0500
Received: from [10.136.43.95] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 8 Jun 2026 23:45:43 -0500
Message-ID: <ec7f34ec-3ffd-4011-a643-91f2954e82c8@amd.com>
Date: Tue, 9 Jun 2026 10:15:42 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] cpufreq/amd-pstate: Fix EPP return type and handle
 errors during initialization
To: Marco Scardovi <scardracs@disroot.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>, <rafael@kernel.org>,
	<ray.huang@amd.com>, <stuartmeckle@gmail.com>, <viresh.kumar@linaro.org>
References: <c97c81f1-1254-44fe-80b2-89f82fec73f6@amd.com>
 <20260608073614.5738-1-scardracs@disroot.org>
 <20260608073614.5738-2-scardracs@disroot.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260608073614.5738-2-scardracs@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC5:EE_|SN7PR12MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 662081bf-75bb-4d77-0323-08dec5e1f8ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|4143699003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wIyE9VEq5jFzq7YpGo6ZZlt5tscjFSRc9h17JrQoWxQqfVz4nB4SW/PYSPF9seZpfsty4on0NbQxvi1hEEM1ILQI6QBj5CCdoTIVUXJvaNmMyh5tXPGHoSz1Ue05knwCRZoPiT+IU0EuAyPplb639AID0/mze2wmjN8cHi4xcBIwpuNFPbcb+dQB52v9GfFAN3Neps8aof43FoiZCdYWRLHUaEt5ATWXnm/xUDFGPaxzPXNqEd9l2XeS6BnBZfXbHeaBOIXKhC5aS0Uju/52or3201AbVAZT3is4NjamsR2p36wCYKfuiFv4/W94UadM3WyxqIsQvxQ2jhIT1R2EqzkuLi3NsGRcX8+ODysNag24RWeT0e8cKnc9HosNz4o56F9Qha/a6JdVljcuagJWeV0twH4G/dv6HA/l4oLsN01gRjwzxgTuRy1uY3X9VeYrb3t9NrRWXvI3YcrCFt0f0lxznYglz8nx2/h2IkZY/KS6gOfTMumUtJ3NGmC3XR64NfIhb7u4afPxL3VWKf5wHhqmh1bp7PX92k2pO504Fy+W09d42SfqLT9Bu2MvyTDMDV8rl3kyVNh11/odfbHLjoRtCnd2jylg3ouWp/okHTbIRMr2UCHko5HhXb8sT9Di7s6DOxeKBgmSA+Xelqg8hxeqcaDJHeK+/rLNRSrv3O7Yj+8QuTY64FBDRAKXugaHnXW3Q3ZGaDiYlqaJuUM/glJAsysGLKYX8J/LrK9TCSk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(4143699003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oFIbKl/dGkAM1O8gFZIQn3GZbQN+weapTgDccxrBVpdM6n9aTt43T/pdPsFsrs7GffWta9akPXX2ut+Vdnu99pkDc6IFOkVEfQLowOUoluDfXYCgB61em3YG3wBYqXqRmeeg4GxqZBbuYNrT8XWnHXcf56oGqb56GUoa4Lf6rhGUXLn2PbDxQhWcrpKX80xZLXOuommZWv4opXbkPD+VWVCGP9gsU19ZEsYtw1GIJkr0HLqNCor/Ng3zxjb3gZ2ojIyP6hSzSukVljPHJqhNbjKFl4iq7yLmG6aWE6W+M1lGowkx7WsHZ60wMhs6DsZWqO+ZKtI69iPi3CF0K8VYYu+YYRR+clEt+zg2hhOIdB1RhHg9k4GGAFkeEPDBOHHhhM0lNotcMR8wQiwci0rxt/BvasH1Ewqq8C3yf1eZA5a1myvoICwqC5fsPSLbPekS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 04:45:46.8226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 662081bf-75bb-4d77-0323-08dec5e1f8ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6981

Hello Marco,

On 6/8/2026 1:01 PM, Marco Scardovi wrote:
> Currently, the EPP getter helper functions (msr_get_epp, shmem_get_epp, and
> the static call wrapper amd_pstate_get_epp) return u8 or s16. This makes it
> difficult to correctly propagate negative error values returned by the
> underlying MSR read or CPPC helpers (such as rdmsrq_on_cpu or
> cppc_get_epp_perf).
> 
> Modify the return type of these functions to int, allowing them to return
> negative error codes properly.
> 
> Additionally, in amd_pstate_epp_cpu_init(), fetch the firmware-programmed
> default EPP value and validate it before assigning it to the EPP variables.
> If amd_pstate_get_epp() returns an error code, propagate the error and abort
> the CPU initialization to prevent subsequent configuration failures.
> 
> Fixes: 555bbe67a622 ("cpufreq/amd-pstate: Convert all perf values to u8")
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Marco Scardovi <scardracs@disroot.org>

Thank you for your patience during the debug and helping chase these
issues down. Feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.anayk@amd.com>

-- 
Thanks and Regards,
Prateek

