Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794554983;
	b=P38v7gZqltakhS76j6q1YO42t9KP9F2FoJ42pZFLj5zjmgHphjdVqgZKLdZp+0rM+lme
	 mCtq0RGTmwlsIqeVTJWmYUNtwpR4vVHaoFld7pb2uusfw1Q4myPycPNbFcNEGBJ3NoWkj
	 fj/NE6w80kP3W9+xkqWVw0rDS9Qdfxv5mkvOMx2+lWMmPP/S1aNwp9r85r3Oq71WFl2F5
	 lpJ3FZQQxd8NoNNmv543z/0wIX3hpDFE+8skWmIZFd7E8J0DLZ12XyQs2PG/JoNcOb8P2
	 lg43+lt+Zhnbodq0A/0xCLIDJ3tGOrNhCzcFuBQfv6q4ulGjNUTIqa1iyYJ7XZWtaGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794554983;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 CC:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=wRIcrpyDWChJDcVNPHacjJnD4RBw7RagVq+Z557Scy0=;
	b=Bupb19jYkduxdaoNBLbMlkk3y3srCq5+6OeR6fivvImD+j9ert9MNfT9vndK/KSUaQda
	 /GNE+p6GiSGpgN7AmMYOGGrilUmEqq2yVESP48KaXzBT5UeJfd50eGuYA2dBKVUc8oFio
	 7VCLB5Hon5PJwA86cUdBN3aAfogKsgFojA3Z8iZOiw3yKwVQ4YTLtGUjMDpQ5t+ULbNmD
	 iXSlzrgrBzLcEqKAerjctjZZDmH3fmkw/t+oICRkoMgOpUVBW22YujOoH8ahgJH2A6Ut2
	 Xiv7tpQbL0+gIYM59H9lN0mjT7N0cIAopYb5sJW09qk9dAxmzZhwqAWbeUphg9FBClQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mVdCM2bk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.4
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E429B606A323;
	Fri, 13 Nov 2026 07:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E429B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mVdCM2bk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dICK/NGK6AB+xyFln+RI0+IwZh2N+iRlwZp8ClyQPlRzVTZme23kUBguj4H29R4p/scL/OfnKV3NVadK0eudCVyzSKsnjxb8HPS8SXYAhnbvARRnI4OGAcPFNqqeYLhY1i3sslvOdHW/sfpo+Iv5BWvRM52n96E+IMzf/Zt1+5zTh5FVtWcY7b61MfbjpgaS9wjzqLvj6ihDc8ps58tcArakMHLdUNtjl2i8osmeUKkWc9en5YEPaIadYJOXScGgjhnHYU5kx+nIE1M1AreZep61t8hCmq6OMug35uZszkYoZ+49bJb1zUJ3MKVpdkA+G4XZv8fjYI50Nz5dRG7HPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRIcrpyDWChJDcVNPHacjJnD4RBw7RagVq+Z557Scy0=;
 b=vEJoiUyZmVPOU+KrJPjooL5ZgO+oc69K+elEzXExfHo/VqVKE4whUjBKIBbC2uP0BFiRhiKsCOkqsWPup7ejbt9gqwxxT2d7i23Q4/gvPBu2SahSAgunuUsB2vA9HuB6zckMHg2CWu0FReEtcCYCt0Uoxx3IXHxwJMiKoL0LhQJ36TKfWCPKg4dqhvlSJ13GU679G2oPVKyILZeQNkpq0hji9HiaT3kQF3gNyNuZQTNr+R7qbEBtk0SoP4qcDBKH16PNAP4VfA7KLEl/lyw7rf4Esppc6UZqXfcRn4ha6xowFMmYYYbEOL8CcvFYhmuM83Xm5e8qNP/dNZVxnfCSOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRIcrpyDWChJDcVNPHacjJnD4RBw7RagVq+Z557Scy0=;
 b=mVdCM2bkRT9RpHrbQEBOYLiwOzo2lTCCbc/wOpvcTthYeznqSGSQNdvjJXSOYOajUPvqKwR+AvAxXwsZBMOlxNIlqFKHo6ubmSXbRd0MAJL0BhKGLREfDibZvFKNsxdnL5z42fijFDJfs2uUPg/3IAsSuiaLUwZ69QML4ZKVAmw=
Received: from SN7PR04CA0025.namprd04.prod.outlook.com (2603:10b6:806:f2::30)
 by LV2PR12MB683086.namprd12.prod.outlook.com (2603:10b6:408:414::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 07:26:18 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:f2:cafe::4b) by SN7PR04CA0025.outlook.office365.com
 (2603:10b6:806:f2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Fri, 13
 Nov 2026 07:26:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 07:26:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 01:15:46 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 01:15:46 -0600
Received: from [10.136.34.22] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 13 Nov 2026 01:15:41 -0600
Message-ID: <bd326953-f693-4994-91e4-f8301430557a@amd.com>
Date: Fri, 13 Nov 2026 12:45:40 +0530
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cpufreq: amd-pstate: Enable hybrid CPU capacity
 scaling on heterogeneous Zen CPUs
To: Aiden Hecker <heckeraiden@gmail.com>, Huang Rui <ray.huang@amd.com>, Mario
 Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Hans de Goede <hansg@kernel.org>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Vishal Badole
	<Vishal.Badole@amd.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20261113022934.13397-1-heckeraiden@gmail.com>
 <20261113022934.13397-2-heckeraiden@gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20261113022934.13397-2-heckeraiden@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|LV2PR12MB683086:EE_
X-MS-Office365-Filtering-Correlation-Id: 467328c0-bbf5-4ea1-f35e-08df415768d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|7416014|18002099003|22082099003|6133799003|261009221227099003|261009223027099003|4143699003|11063799006|56012099006|10067099003|261102123227099003|261022105027099003|261026121527099003|261022075727099003|261028144727099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	xq4Y7V2QOddS73U2Y0PN8Ayx7oAPdO6uV8bk936vUNMAgrgu8mq7PBTNqOnvO0TWSPnr6tIBUNnC09zW6CYOLoD9iTkLKSqA0tpZtTNclSrbIcoNJeNoC3ITiY8xAFMYf7vHzM1tzpXyyFvL2ysa64ZTSPcVC5/4l3mjXv964RMZByjtdDYCXxihOfgWOSF9AumrG0cfWYGVl0YFHwppWfCz6UoUeedWxtP3sZOUixyEZtLxX3A4iRno4aC3iFHTcSmW1UCFR+4swu3sGlRVFYzJnkHuWLXRQ6bu2ULrqw9UQtZBINdOSe4UJT8lJMJOkJW8nk2Kql1h/i02yk1EOzwmA5wQpX+oTj5eVxzPOWACR8T/YTI2LrMkzICIagF9wCKyGyrwKVbVuB8wrBg5M2rTxO4WC2eBq6lwgneWEwPAoGfvoqiUT52lut+aQ4HzC9EcBJZohEGUrtFpDAWw4XJMXkq0Bv55XU7EoQV7JE0UnozcWhPfTnyQp63JqoAfrJpsWZiAHD3YpnwBDL/xr5NH3FOYey0kWv/0Ky8gDY4EUGOACOr3xp/ECX3YhJiFMD5LL7U0GmCQ8GNO8pdTvSDIsR7MZQnkxnmv7virxLrL4mMHPCL8JTyo69ao6KS9rDd0u05Z7vc0hBHNxqbLUvRMUqtqomPpqlDtbKio3fETX8V4nJ47E38+6QcHe8T9ngaNZYOnBrudqqtOFKhM1g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(7416014)(18002099003)(22082099003)(6133799003)(261009221227099003)(261009223027099003)(4143699003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261022105027099003)(261026121527099003)(261022075727099003)(261028144727099003)(261021121427099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eoc1eP99d1gtyG/ovZYLBl1K+xwe/sBbTSfqZDN3XHh2HkWHaQeJ07H2xbykB/o3wAJWTEC8rhYZ6EIE8+OFnT3LY69nGvVkJXrG0Y4bjl9Bvi8v8VBNt4dkISoFL44s9lxy4f+pmfxjhpBTYoHDALy/8UbVbzY0ZD09f7swJ6AY05aD9j1fDPPzcDsO99qcSn/9CZ0AaZ7o5R+oEPs0qCqq0xaAddj2snX3QHeEBWaRxUSUbUX4OxDwrjDxHJKJSpNxicwvOeuJVM8+8Hc9XSGUcrMGIBgyYzU8xhu4anYBBvGEEHqqi2FJP4iSlflcGqDDq2umcMUNQ1ahfx5NI7WK2daYaE3LiTbccUY0g3pes7P3ao04tsjj5ooJwsGHHQZvsbcMPBN0XHw+QK4VER90JsCuyRU0et5K3xIQbF0aIsMkV3XrtkZJe/dTVVSE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 07:26:18.6220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 467328c0-bbf5-4ea1-f35e-08df415768d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB683086

(+ Vishal who too was working on this)

On 11/13/2026 7:59 AM, Aiden Hecker wrote:
> +struct amd_hybrid_cpu_cap {
> +	u32 highest_perf;
> +	u32 nominal_perf;
> +};
> +
> +static DEFINE_PER_CPU(struct amd_hybrid_cpu_cap, amd_hybrid_caps);
> +static DEFINE_MUTEX(amd_hybrid_cap_lock);
> +static u32 amd_hybrid_max_perf;
> +static bool amd_hybrid_cap_enabled;
> +
> +static void amd_hybrid_cap_workfn(struct work_struct *work)
> +{
> +	rebuild_sched_domains();
> +}
> +
> +static DECLARE_WORK(amd_hybrid_cap_work, amd_hybrid_cap_workfn);

This is probably not necessary - more on that later ...

> +
>  /*
>   * The numeric EPP value programmed for each named preference. First dimension
>   * is CPU type (TOPO_CPU_TYPE_ANY for non-hybrid, TOPO_CPU_TYPE_PERFORMANCE/
> @@ -969,6 +990,99 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
>  	sched_set_itmt_core_prio((int)READ_ONCE(cpudata->prefcore_ranking), cpudata->cpu);
>  }
>  
> +static void amd_pstate_record_hybrid_cap(struct amd_cpudata *cpudata)
> +{
> +	struct amd_hybrid_cpu_cap *cap;
> +	union perf_cached perf;
> +	u32 highest_perf;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES))
> +		return;
> +
> +	perf = READ_ONCE(cpudata->perf);
> +	highest_perf = READ_ONCE(cpudata->prefcore_ranking);
> +	if (!highest_perf)
> +		highest_perf = perf.highest_perf;

I think it is a terrible idea to mix the preferred core rankings
with asym capacities. You should just stick to using the
highest freq as a reference fot capacity.

> +
> +	guard(mutex)(&amd_hybrid_cap_lock);
> +	cap = per_cpu_ptr(&amd_hybrid_caps, cpudata->cpu);
> +	cap->highest_perf = highest_perf;
> +	cap->nominal_perf = perf.nominal_perf;
> +}
> +
> +static void amd_pstate_sync_hybrid_capacity(void)
> +{
> +	u32 max_perf = 0, min_perf = U32_MAX;
> +	bool updated = false;
> +	int cpu;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES))
> +		return;
> +
> +	guard(mutex)(&amd_hybrid_cap_lock);
> +
> +	for_each_online_cpu(cpu) {
> +		const struct cpumask *sib_mask = topology_sibling_cpumask(cpu);
> +		u32 sib_max = 0;
> +		int sib;
> +
> +		/*
> +		 * SMT siblings share SD_SHARE_CPUCAPACITY and must expose identical
> +		 * arch_scale_cpu_capacity() values to avoid scheduler warnings.
> +		 */
> +		for_each_cpu(sib, sib_mask) {
> +			u32 p = per_cpu(amd_hybrid_caps, sib).highest_perf;
> +
> +			if (p > sib_max)
> +				sib_max = p;

This should never happen - even with preferred "core", both
siblings will have same ranking (but you should use the
amd_get_effective_highest_perf() - more on that below).

> +		}
> +		if (!sib_max)
> +			continue;
> +
> +		for_each_cpu(sib, sib_mask)
> +			per_cpu(amd_hybrid_caps, sib).highest_perf = sib_max;
> +
> +		if (sib_max > max_perf)
> +			max_perf = sib_max;
> +		if (sib_max < min_perf)
> +			min_perf = sib_max;
> +	}
> +
> +	if (!max_perf || min_perf >= max_perf)
> +		return;
> +
> +	if (!amd_hybrid_cap_enabled) {
> +		if (!arch_enable_hybrid_capacity_scale())
> +			return;

Capacity of a core derived from the fact whether it is classic or
dense, should not change at runtime and you can do this full setup at
amd_pstate_init() when the driver loads at boot.

That way you don't need to rebuild sched domains for mode switch
since it is done before the sched domains are built.

> +		amd_hybrid_cap_enabled = true;
> +		updated = true;
> +	}
> +
> +	if (max_perf != amd_hybrid_max_perf) {
> +		amd_hybrid_max_perf = max_perf;
> +		updated = true;
> +	}
> +
> +	for_each_online_cpu(cpu) {
> +		struct amd_hybrid_cpu_cap info = per_cpu(amd_hybrid_caps, cpu);
> +		unsigned long prev_cap;
> +
> +		if (!info.highest_perf || !info.nominal_perf)
> +			continue;
> +
> +		prev_cap = arch_scale_cpu_capacity(cpu);
> +		arch_set_cpu_capacity(cpu, info.highest_perf, max_perf,
> +				      info.highest_perf, info.nominal_perf);

Nope! Please don't use preferred core rankings for capacity.
Use amd_get_effective_highest_perf() to get the largest perf
value use that as a reference.

> +		topology_set_cpu_scale(cpu, arch_scale_cpu_capacity(cpu));
> +
> +		if (arch_scale_cpu_capacity(cpu) != prev_cap)
> +			updated = true;
> +	}
> +
> +	if (updated)
> +		schedule_work(&amd_hybrid_cap_work);
> +}
> +
>  static void amd_pstate_update_limits(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata;
> @@ -1130,6 +1244,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	if (ret)
>  		goto free_cpudata1;
>  
> +	amd_pstate_record_hybrid_cap(cpudata);
>  	amd_pstate_init_prefcore(cpudata);
>  
>  	ret = amd_pstate_init_freq(cpudata);
> @@ -1769,11 +1884,14 @@ static int amd_pstate_register_driver(int mode)
>  	if (amd_pstate_prefcore)
>  		sched_set_itmt_support();
>  
> +	amd_pstate_sync_hybrid_capacity();
> +
>  	return 0;
>  }
>  
>  static int amd_pstate_unregister_driver(int dummy)
>  {
> +	cancel_work_sync(&amd_hybrid_cap_work);
>  	cpufreq_unregister_driver(current_pstate_driver);
>  	amd_pstate_driver_cleanup();
>  	return 0;
> @@ -1985,6 +2103,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	if (ret)
>  		goto free_cpudata1;
>  
> +	amd_pstate_record_hybrid_cap(cpudata);
>  	amd_pstate_init_prefcore(cpudata);
>  
>  	ret = amd_pstate_init_freq(cpudata);
> @@ -2149,6 +2268,8 @@ static int amd_pstate_cpu_online(struct cpufreq_policy *policy)
>  		return ret;
>  
>  	cached_floor_perf = freq_to_perf(perf, cpudata->nominal_freq, cpudata->floor_freq);
> +	amd_pstate_record_hybrid_cap(cpudata);
> +	amd_pstate_sync_hybrid_capacity();

Apparently boot CPU can now be a dense core which means if someone
boots with "maxcpus=1" and then decides to online rest of the CPUs
this bit must go and adjust capaity for rest of the system since
reference capacity has changed.

On MSR systems, you cannot find the core characteristics / highest
perf since it requires reading CPUID / CPPC_CAP MSR of an offline
core which isn't possible so you must account for it here.

Sched domain rebuild comes later so just adjusting capacities
should be enough.

Also, it all the classic cores go offline, in a system with
Dense and Low-power core, you'll have to start using the capacity
of the dense core as reference and adjust accordingly.

>  	return amd_pstate_set_floor_perf(policy, cached_floor_perf);
>  }
>  

-- 
Thanks and Regards,
Prateek

