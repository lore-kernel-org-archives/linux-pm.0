Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A1B37E5DE;
	Mon,  7 Sep 2026 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770249; cv=fail; b=VnMSCq+XUAMXrOfZSyu2Cm3n0MAX+RS+Sn48YK/Qj3c12KQAHJRn6c8HYBEsHkLzpsv5VtIkXnyMfCmTEkoyz/Ytn+PMZigW1c1WBRkcJxGsqWlxaurrApYubuf4D8QkebzHLpV/cg8QuGM/Rwnqc8OdV0wbfmL4ffMntSYvgO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770249; c=relaxed/simple;
	bh=6g3evBy3rRDDDfC9qCQ4SN9sF033FzxqaH5X1ybBdos=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=QZHXKff/WfRBaB3KRXDJ9sXA13DLaaGcRzEp1LC/V/7r0XMCPJLlO7zvmmcsHzBA0jAKf54u1Gklzf6EwL1Njliup+zy8wJJ2wqSx5P0PyOT5iI0xvHrQWNV/SEpIPPMg3p9Jje180Qyi8AcZOeKvRXKol7gkTr/89HoUUlKvbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0EzZ+6r0; arc=fail smtp.client-ip=52.101.62.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0EzZ+6r0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xaD5qOhEQ/CQpQAF8OWOpy9M0sQod0NBoRCAjTTu41fbWan+by+0FqhAIh2+g4mkRMSjXVbfcvHpR1eAKclPHYRQ6im2dFHuIKbJjqBLJ0QgB64Ik7p9ZBCuPwWx1XYGPDKEc/FzDq2Pj754OkJF4Jx6K/rhcaTeht9gKud3w/C5SweNqpDNyRcvH9R7QKD00CWKagX48TZZj64d5ihTv6ihMGEUNyZGpeGDLQAGFohNui5xeNnnSUtxITDqSTUNZ45SC9D3CGsJ0M167K47/VXymaRPJBEnnaFJAjKOul+NHQTcfm244+JINrAOvGkkZmHG10P/r3TTIyvAIideow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6nN0PyL9NoU9V3LirbHzgkSfqx9WymYmFTS3mgrM+o=;
 b=YrMuvWfokqDOVOjNvMN4qTfg2+1k2TnjHwA6tiWIrh+1buq0r1agfgwqkZ5Tu9oknfftsMAdW2XMVBESuN1GOSJIGAYga5fNiHajN3Ol8q4+Wz0ojiMFiUxqPmndIdVCqn22vpa4q24XZOYGDGh46HBPQ7vmOitNaF4yrJs4MXUOJUUMlHwNUgiAD7aZhqDovdPgpcMB2YCHRZUW9slh4Z/5RrwWjnbQOkxWW1LU8I3z1li5VEgZfowiDsXYQg8hE7CRuUPw1VzFcTIfIqpe1XqEuD3/jkctrC+eSevE9PS8j4Zu/kYTdaynpGvCNQvFppriXuRNPab8rgMGu2TZ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=transsion.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6nN0PyL9NoU9V3LirbHzgkSfqx9WymYmFTS3mgrM+o=;
 b=0EzZ+6r0ZyKfyE6NHvKGmVyL19k1x2oOAksZQOEI+YDO/xXapTCWqkObmMQxg4BNAISsL1l++eyDTFOLgHd2Owdxd8DO8Q6MrlSN4kZXGvLw9iHcQJyfI+AKpxJffNrdCzXC4Kpj8F066GnANa36YOcTeaHXgbYdqBg8Ge2Yl8E=
Received: from BLAPR03CA0116.namprd03.prod.outlook.com (2603:10b6:208:32a::31)
 by LV8PR12MB9271.namprd12.prod.outlook.com (2603:10b6:408:1ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 08:37:24 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::6d) by BLAPR03CA0116.outlook.office365.com
 (2603:10b6:208:32a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 08:37:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 08:37:23 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 03:37:22 -0500
Received: from [10.136.42.177] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 7 Sep 2026 03:37:19 -0500
Message-ID: <4e39e935-2339-442b-8b14-a688b605c35e@amd.com>
Date: Mon, 7 Sep 2026 14:07:18 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Only apply cpufreq pressure where frequency
 is invariant
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Hongyan Xia <hongyan.xia@transsion.com>, jong wu <jianyong.wu@outlook.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "zhongyuan@hygon.cn" <zhongyuan@hygon.cn>,
	"huangsj@hygon.cn" <huangsj@hygon.cn>, Vincent Guittot
	<vincent.guittot@linaro.org>, "Rafael J . Wysocki" <rafael@kernel.org>
References: <20260821073927.455475-1-wujianyong@hygon.cn>
 <fea033f4-a680-445f-b231-2a0cc1dded8b@transsion.com>
 <F16AADE6-B6B7-4997-9CC1-A2E323498B7F@outlook.com>
 <CAKfTPtCxMA-7BX20LNhdOT+BQysdnOxOALrLvhTFNYJLbdsoCA@mail.gmail.com>
 <SI2PR04MB4931F65C44962845CE345B79E3B72@SI2PR04MB4931.apcprd04.prod.outlook.com>
 <44993024-f1bb-4b4f-802b-a22f95101171@transsion.com>
 <SI2PR04MB49315D05AB89CFA3B0E41BF3E3B62@SI2PR04MB4931.apcprd04.prod.outlook.com>
 <f38d55b1-68f8-4cfa-8b97-47fe58bd9ed7@transsion.com>
 <d709498b-9572-44bd-a93e-bbed23fd7372@amd.com>
Content-Language: en-US
In-Reply-To: <d709498b-9572-44bd-a93e-bbed23fd7372@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|LV8PR12MB9271:EE_
X-MS-Office365-Filtering-Correlation-Id: 2debe487-8c15-4f99-34ec-08df0cbb3d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|32650700020|1800799024|7416014|36860700016|10067099003|56012099006|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	s/urOLSGP+MHooDEqXHXINoIebXqz/CzhzguCtYU1O7ELTgJ+QDskGc8LbhdgQVxcuSbetdZU10lapMzfLYI/sCdNEDtHJiJ83aWUVYqeQ5IG+4Lbi/AhJuXU8sENAT2ApMyfxl0jjk7BXuZVg988FmHgCNvWLTfEtm+hpkOe85W1cBYPqFHmNxou4wS9TPs6E9xCe9tocqdmRaJXX74pnA3DqrmHhSGf64QjWoXc/tMGpNZoAh3hrh+U/6vwclYbypKJ8zX7qbtvMo1fPwK8AzBAXAHenx6NtuWum929cIzMEK6dQ+k8bLO31FYJeh8cJy7cNfCS1IsWzRE3xexr5d6dl8BIyf3Lc9h9gYgNwFwmohNEdOoE3OQH7qPtrGDbTXoJ/ScHbd+c6NSoRMM0teSkosGS3U2gI7ROdZwWYvPoi7ki6ofjphJixR96p1CGejtDt6T1fdaY91tphawdITdisivzAxZXcLKO7LTyuXbS36s2/CoxvVdak01mjBqZVRpPTpOCpYv8PRSfybaLbc1fH/J2XKf3mZXs8gOobFEkMA2k2JudbCJQAsk5rxBOm8RAquBGJ03+8danJmlS2lGdsJfrYeAIWp/chDqSTtlOmDJkdPwxEn/LyrSMvHVaU8nOAjr+ZLuP2HIiV8QsB98ndvrcoUBlcDppZb8m82flFn+4FdSYRw6HdQPoS9H27sX/6CTfggG6ZhMQJXIjQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(32650700020)(1800799024)(7416014)(36860700016)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MiT9yKyI5qjVQyWV80MbuUZdC1Yb7CkTSZrG3YyP3T+uKCUc+tzjobIuaq5ECnptmgZGe8YN7FQINq2LTPGLBVlsNY87FKhyoKgKVhNoXXYoZO9jejPbGLUFFwNKPEPabmm9/NVyXKs+hN5iOgtjgt4fhsHchjdH7ZGMyB/hIdy3O4qfH2bdKUFNzyey/0UR9u9g1UZOCg3oqCic12N7gPHDSrIjhccYIC/+WWivTs2rXXNrsWuj1jGY6ulhCpvO5+Be8PBFF1gmrlEcPW0LoqayK9Y8LdWU1VRLcNNxoTqiwmxCBhgqWWZozbnKzzbMb4riFDzbffwKkDs89y/KYMxvTraMtGpX6kYjDSzvdOYuLJ7d4yzlOdHl6R7ZejU8XG3W3edrFetAlHUDnldN4DiE6P+uuU/YVNC3NNDgjumjAFJ2oyYOUbkzNes4Ihi1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 08:37:23.4581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2debe487-8c15-4f99-34ec-08df0cbb3d32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9271

On 9/7/2026 1:37 PM, K Prateek Nayak wrote:
> So, I've been trying to understand these bits and looking at
> cpufreq_policy_init_qos(), the "policy->cpuinfo.max_freq" should be the
> frequency including the boost range but I see cpufreq_update_pressure()
> and it says:
> 
>     max_freq = arch_scale_freq_ref(cpu);
>     if (!max_freq)
>         max_freq = policy->cpuinfo.max_freq;
> 
>     capped_freq = policy->max;
> 
>     /*
>      * Handle properly the boost frequencies, which should simply clean
>      * the cpufreq pressure value.
>      */
>     if (max_freq <= capped_freq) {
>         ...
>     }
> 
> 
> Looking at this, I feel "policy->cpuinfo.max_freq" should not include
> the boost frequency, or x86 should implement a arch_scale_freq_ref()
> to know when boost is enabled vs disabled.
> 
> If cpufreq_update_pressure() indeed has to disregard boost frequency,
> and anything above P0 is not considered as pressure, we can simply
> do:
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index b898b6544069..068e6d6e15a1 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2586,8 +2586,11 @@ static void cpufreq_update_pressure(struct cpufreq_policy *policy)
>  
>  	cpu = cpumask_first(policy->related_cpus);
>  	max_freq = arch_scale_freq_ref(cpu);
> -	if (!max_freq)
> -		max_freq = policy->cpuinfo.max_freq;
> +	if (!max_freq) {
> +		max_freq = __resolve_freq(policy, policy->cpuinfo.max_freq,
> +					  policy->max, policy->min,

My bad, that should have been other way around and use the cpuinfo
fields to prevent capping based on policy limits. Updated diff:

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b898b6544069..97f4a3ba5107 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2586,8 +2586,11 @@ static void cpufreq_update_pressure(struct cpufreq_policy *policy)
 
 	cpu = cpumask_first(policy->related_cpus);
 	max_freq = arch_scale_freq_ref(cpu);
-	if (!max_freq)
-		max_freq = policy->cpuinfo.max_freq;
+	if (!max_freq) {
+		max_freq = __resolve_freq(policy, policy->cpuinfo.max_freq,
+					  policy->cpuinfo.min_freq, policy->cpuinfo.max_freq,
+					  CPUFREQ_RELATION_H);
+	}
 
 	capped_freq = policy->max;
 
---

> +					  CPUFREQ_RELATION_H);
> +	}
>  
>  	capped_freq = policy->max;
>  
> ---
> 
> __resolve_freq() will cap "policy->cpuinfo.max_freq" based on the freq_table
> entries if it exists (acpi-cpufreq), or otherwise return
> "policy->cpuinfo.max_freq" as is for drivers that uses CPPC based scaling
> (amd-pstate, intel_pstate).
> 
> Thoughts? 
> 

-- 
Thanks and Regards,
Prateek

