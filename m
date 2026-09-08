Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058B637FF68;
	Tue,  8 Sep 2026 06:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848408; cv=fail; b=jvdHyaFzBTWxRmtAuyy8vuGwzdAjzZkiurNndAFQr2EaMNRldZEurZpWzlDKb6GWn+G9DQ7oQb6+LZx0N5gcH30/AiYTv1R67EolbHAMw0uoLWsEDEmuZUVNKxAyQT6R6v9xjiduUGKYVKLV4mqGL2A/jR7+Y58WEoKvqoD+hE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848408; c=relaxed/simple;
	bh=FT2cK2vKmUVJ+qG0hPH2vnI/qKQ/3gxBv58QrcuYl8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Pn5eEu5A2308RFRaDk8K2hVes6CEn7HNKtIfTYpzV7i3n5Bj+PmY0O8/sEdxv1dG1KuHNTwxdE/PGZM/VlAKRfZyM29vz2E3Vsnz9ca2KiRnHsaakxF/DlHbSpKSqQZ/Ty7zx3hA6B93po6KL0cOXIfTGtlRzZSEEfpDiUG8gFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eM2DFUbT; arc=fail smtp.client-ip=52.101.56.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eM2DFUbT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqE1ebDJjICY+QCE3gGJ6jbFDOvmNwIsHmCWaSEp6FcXbhYguBPqIzKfqyrbd64/Zjaz41QqkmSN3VQl64Nu3nJGQquaaWQIl9tVUhpQHJGe9NJ4BW+4Pwmntk1+yvve6FM2mDz4GIARmX2G54XL7fTof83HIH02ZOfhLZ7G+sH6Px/eSBprdy/lGLqZ0k2GZ1EYWRffG7n0WleH5VS6DhSLrYzxjVFi87iJmSEhGUMkS1N3rl2irN7oEoxlYXjvfp6q6MUp8anBAwRMPZirXCvHzXD5n0FOKMkIEDQ+8iwPE5VTBJLwIlcbKQmREtC25ihHVXYHIWMBItYLCclA3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4Lz4kenstitT7lFNG6kIP8YMnSl4DPYDJjEKe4R8oo=;
 b=fiMguyq2omo2ONGLeT6GFeDoEaIhdgriUAq8eqP3TJKGf0m7hDsXpxpSx1cvaCeyA5/Dr2yXQ0bakSw1rauosW9qguuQoThQb7RtAe7gMv7WfY8uMEIaPIV+VtZZT86extWNav0I6yH7SISPt1CO9HijPQ7zjcMEUk/uP1UE98OshRwBHRl/9tLKuxOqGI1JIincPpctI5B+wByn4QRu1feLnspFSSOP1rvnt/Jn/OJ2QqYMTXnkTyh14RUKolAXd/fVNlYhiT2hjU6XC7iYpiN8DAzUy954Is4JSrey7BqwLY9K77YvFQo582YekeUunpysRbppFRGtYOlX7McRAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4Lz4kenstitT7lFNG6kIP8YMnSl4DPYDJjEKe4R8oo=;
 b=eM2DFUbTWoONjTqkZzoCy/Kmd6nZGLhU4IJUTjQ8QglkweAjPXfyJbsLpGR1uyKs7YAQIegCzW5nr2nFeJEdfgdMOxFsIayOcSszGvDkpaEomF9PA5AmA/R1tLVCu2pol/DlFOVH+aXdoOG5+wg1MoFxtAaS56bV7SL/y4PzwWQ=
Received: from BL1P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::25)
 by SJ0PR12MB6989.namprd12.prod.outlook.com (2603:10b6:a03:448::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Tue, 8 Sep
 2026 06:20:01 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:208:2c4::4) by BL1P223CA0020.outlook.office365.com
 (2603:10b6:208:2c4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 06:19:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 06:19:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 01:19:57 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 01:19:57 -0500
Received: from [10.136.42.177] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 01:19:55 -0500
Message-ID: <eadc9b88-534c-4a49-b2a5-c2d9ffcf569a@amd.com>
Date: Tue, 8 Sep 2026 11:49:48 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] cpufreq/amd-pstate: Add per SoC and per core type
 EPP tuning values
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
CC: Perry Yuan <perry.yuan@amd.com>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING
 FRAMEWORK" <linux-pm@vger.kernel.org>, Vishal Badole <Vishal.Badole@amd.com>,
	Richard Gong <Richard.Gong@amd.com>
References: <20260908041935.402116-1-superm1@kernel.org>
 <20260908041935.402116-2-superm1@kernel.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260908041935.402116-2-superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|SJ0PR12MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb2f5e3-7b7e-4756-4b22-08df0d7134a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|10067099003|3023799007|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	CW+ddDG2htBhrXUJEEjXQn8Hri4RO5Oa22OmrL60XRTw4vxsaGthXOry7mQUeiOUNjUSGa6DKPVAj0cXuUoFa0NYmMI0iiPfp4iip2/Y6PZH7w5UsYcE4a+Agfsa7KalDF6uPv5a/OiY6qXQl76AZGE5in+qtwwjwpWgKFXYM05Mq+UOpTkU37WZBUxX34buSp0qhLfja7Lrm6W6TsBA0Wukzgj2amWxa/8BXp9jKpkVnZ1R0LWOQ+CLSKqzmN0AkjYR6sUvt4QleWkOE99TH3UBA4fx41bNoZiKZWFMQjb4IDbAk/fo1knLgSj4phE2EccC4h9txo0nN3JVYFklPhlECnSOgZMQxGW8nsqOKYBEcYFrBJsrrTuJ4zOpX4zQOgpl8PrAbzC2eAEKS4wgsLcA7bg7sh2YdiixV73ncpbxcMeIEGi1UcEWd+vg71PqY8UHV3x6MqxdwQL2WyNlCyZZEWim82itE73XCEfGtOIz6C2h9ktE4f1BSaO/wg5Yqai1sKsen16aVqu2q1LIZwxcKAG3T1odcthYyWJcbEVVth2hnTZ0o4Ll5t+Z3e2nOc7X3RfdmhehkWzcG5fxqWuE2ehGevv36Oi4Kmm6ZaD2ye5lSjUdmW/vETgDZT7fCNViyy/JlIrwcKihLXCB4L+EZvSdrQnc7LDT2Biw0U4uHwBF1Rl2WxkdHX2mmqsCOykNtMG4OxYqvHzP5vSkaw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(10067099003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SpfTwNtgS3QNEJwVpcCninDSXshXur2LhADBqYRrIHWoX9b7xOyXAtAc6AY3/pfOlmlapF9fBjMgztu9ejd2q6EIjMne1UxQ+SrGSLxkocRx7s3h5J8l0oeYN8e+tlcw2AgItrY1A8qNhD8ucI8pcM+ZbHOnb/oiCGCmGM1GEXYaDwWzRpb0Fvj6v0yUupIVS41q/0TUj3tJXpqrKTTi32SWDKEbB74IqO2CslNJ/rp/JlJtovIKdORnRY2tlUeX3GWHtBIgS0L6WMWsWAOIT5JXfEuS+1NflLMtobk1JG1KLVNYcSydMCHu2B5J5YmcrZFeX7UyeuYkh8Kkm9XSghXmnLnq8JE6pFAVfBIoK89MEiOSFEs/jgS+Q+YYbQl6eTVyG0WKSdfb720IpDXjuYmMIdDbvA9gcCt+VLkMmDDDegOkjkWKqzqSYYbn42qw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 06:19:57.5008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb2f5e3-7b7e-4756-4b22-08df0d7134a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6989

Hello Mario,

On 9/8/2026 9:49 AM, Mario Limonciello (AMD) wrote:
> +/*
> + * The numeric EPP value programmed for each named preference. First dimension
> + * is CPU type (TOPO_CPU_TYPE_ANY for non-hybrid, TOPO_CPU_TYPE_PERFORMANCE/
> + * EFFICIENCY/LOW_POWER for hybrid). The initializer holds the legacy values
> + * used as the fallback on any platform not listed in amd_pstate_epp_soc_ids[];
> + * amd_pstate_init_epp_values() overwrites slots at boot when the running SoC
> + * has a per-SoC (and potentially per-CPU-type) override.
> + */
> +static u8 epp_values[][EPP_INDEX_MAX] = {
> +	[TOPO_CPU_TYPE_ANY] = {
> +		[EPP_INDEX_DEFAULT] = 0,
> +		[EPP_INDEX_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_PERFORMANCE,
> +		[EPP_INDEX_BALANCE_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_BALANCE_PERFORMANCE,
> +		[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_LEGACY_BALANCE_POWERSAVE,
> +		[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_LEGACY_POWERSAVE,
> +	},
> +	[TOPO_CPU_TYPE_PERFORMANCE] = {
> +		[EPP_INDEX_DEFAULT] = 0,
> +		[EPP_INDEX_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_PERFORMANCE,
> +		[EPP_INDEX_BALANCE_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_BALANCE_PERFORMANCE,
> +		[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_LEGACY_BALANCE_POWERSAVE,
> +		[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_LEGACY_POWERSAVE,
> +	},
> +	[TOPO_CPU_TYPE_EFFICIENCY] = {
> +		[EPP_INDEX_DEFAULT] = 0,
> +		[EPP_INDEX_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_PERFORMANCE,
> +		[EPP_INDEX_BALANCE_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_BALANCE_PERFORMANCE,
> +		[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_LEGACY_BALANCE_POWERSAVE,
> +		[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_LEGACY_POWERSAVE,
> +	},
> +	[TOPO_CPU_TYPE_LOW_POWER] = {
> +		[EPP_INDEX_DEFAULT] = 0,
> +		[EPP_INDEX_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_PERFORMANCE,
> +		[EPP_INDEX_BALANCE_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_BALANCE_PERFORMANCE,
> +		[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_LEGACY_BALANCE_POWERSAVE,
> +		[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_LEGACY_POWERSAVE,
> +	},
> +};

If my eyes aren't decieveing me, all the indices are initialized to same
value so we can perhaps do:

    static u8 epp_values[][EPP_INDEX_MAX] = {
        /*
         * Initialize all CPU types to legacy defaults.
         * amd_pstate_init_epp_values() will fix these up
         * based on the platform during boot.
	 */
        [TOPO_CPU_TYPE_ANY ... TOPO_CPU_TYPE_LOW_POWER] = {
            [EPP_INDEX_DEFAULT] = 0,
            [EPP_INDEX_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_PERFORMANCE,
            [EPP_INDEX_BALANCE_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_BALANCE_PERFORMANCE,
            [EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_LEGACY_BALANCE_POWERSAVE,
            [EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_LEGACY_POWERSAVE,
        },
    };

> +static_assert(ARRAY_SIZE(epp_values) == TOPO_CPU_TYPE_LOW_POWER + 1,
> +	      "epp_values must have entries for all CPU types up to TOPO_CPU_TYPE_LOW_POWER");
> +
> +/*
> + * Get the EPP value row for a given CPU, accounting for hybrid CPU types.
> + * Non-hybrid systems use TOPO_CPU_TYPE_ANY; hybrid systems use the CPU's
> + * actual type (PERFORMANCE/EFFICIENCY/LOW_POWER).
> + */
> +static inline u8 *amd_pstate_cpu_epp_values(int cpu)
> +{
> +	enum x86_topology_cpu_type type = cpu_data(cpu).topo.cpu_type;

Can we cache this in cpudata to avoid an additional dereference?

> +

I would prefer a:

    if (!cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES))
        return epp_values[TOPO_CPU_TYPE_ANY];

here to avoid the branches for non-heterogenoeus platforms.

> +	if (type == TOPO_CPU_TYPE_PERFORMANCE ||
> +	    type == TOPO_CPU_TYPE_EFFICIENCY ||
> +	    type == TOPO_CPU_TYPE_LOW_POWER)
> +		return epp_values[type];
> +
> +	return epp_values[TOPO_CPU_TYPE_ANY];

A switch case might look prettier ;-)

> +}
-- 
Thanks and Regards,
Prateek

