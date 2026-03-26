Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013058.outbound.protection.outlook.com [40.107.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05464398915;
	Thu, 26 Mar 2026 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774526692; cv=fail; b=O6aNmZ3x8PlkZn7F/LFBQ2Lbbbv/CTwe2pHatgLUMfSgzpMDueY3NDhmcrCzz3aJBtt9frFr33qa/eHlBnKHCo/qbEXp3LWOv0fSbMdemF58SiJ/50DEdlMRQ2EbkstuHSQNkEL+vyhAkbbtDYgljea24jWaiU5BCm88or+lRTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774526692; c=relaxed/simple;
	bh=cTgeRJsuO7uAN/H69Lj3hIOz3vHJBKEcIRrHF5xO8Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tP9scL70g44jCFWs72m4DraP1b+CqGEY/IqjnsbOFm2dnNgOEHbon/27tHTIaxKgs9071g0olgiKJz6BEkH2f0i2nxIZbR0HYhyJ939/K4D8PEEvnihy1JYJ7gGZqEz9TjVD1CrPj9U3/wzRPfjly65xAeuI1q8SqLCSzzd4w7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fSCs0Kpq; arc=fail smtp.client-ip=40.107.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fSCs0Kpq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+v6HlC3SmwzRvar8iWPx+ECbBbRGpcpk/FXk/aka3zHqu5XprfBBCbVt0Q1q9pkyc/RYsn1eJKds62yJKEMAfwr8bRRoTQX9QdQpQlevkR2kzxafcOVTWu/9XPa9iQDWmRa/oRTUaZLCmko8gvyatgTzRDP5Y1JQFbM92B1iXlUoeQxJ+PdGQ5X0DGddlGDF+hpjR7J9zoMkLVojCf0IIEXzRjaqdXo4THCgR7p3O0u4kQaee94SNZXpJAg4MElVw6PRsh+WoznPFgr++SfhY/+8Gayl8zYqW30yzUX/AUcQCR4AN0+OYcvtm0j4HkUDyMyPdlwGdcIaG1Cp094cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzihaTpdr1xuNjGQOWDAgYyGIR7ISvgd/Ez4jaFAiLI=;
 b=pL1y39y9blPJyusJ1KZgTl/zXcuVcufweByoPbCBCMpejPQTtIJnhozQCmsUxlASXCmOLTI4z5hygvpDp1MkgFocOpgRRM3mV8D1aNzW9RUbOLYzrlCrib+nspflztC51OFAfyPAylEjzDX8YnECxBk6congmiLDxy2EDu7HyN3KLTjyIL7qHqoFHn4CBvsfk356qZovi6CjB/WM2muJoAXd3ZduApiBVYyaaM4pD97UpF1qXM+SyZ75z+WKyPPnuBnXq0ZUPLpKVu1ilvHOmmnECwPptHqI88GPtd7Bm12KbFB+S8n/kmlUuH/dETZZ3ncsNfMJCug8LqoqwVcSCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzihaTpdr1xuNjGQOWDAgYyGIR7ISvgd/Ez4jaFAiLI=;
 b=fSCs0KpqjTKfvo6OReS5ZAQDtuDeripa0KVJUktyzvStnQ/7N6JdPetMYLiCtt0QRKV0hjy7lexEaRY98S6vBh4MJInWecQIaZAN9FlTKTOAJHl/6NTkleAjo0hdGMSuL0RYvgu1g3RLnRfKvDPrhPTa0VCtmqCAfZCCSkHWMpU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 IA0PPF7D094C5BF.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Thu, 26 Mar
 2026 12:04:45 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a%3]) with mapi id 15.20.9769.006; Thu, 26 Mar 2026
 12:04:45 +0000
Date: Thu, 26 Mar 2026 17:34:31 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>, Perry Yuan <perry.yuan@amd.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Bert Karwatzki <spasswolf@web.de>
Subject: Re: [PATCH v4 2/2] cpufreq: Pass the policy to
 cpufreq_driver->adjust_perf()
Message-ID: <acUgzwk+ULSjW8sW@BLRRASHENOY1.amd.com>
References: <20260316081849.19368-1-kprateek.nayak@amd.com>
 <20260316081849.19368-3-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316081849.19368-3-kprateek.nayak@amd.com>
X-ClientProxiedBy: MA5PR01CA0180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::6) To IA1PR12MB8240.namprd12.prod.outlook.com
 (2603:10b6:208:3f2::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|IA0PPF7D094C5BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 2034af78-694e-40d6-553f-08de8b2fde88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gM7FeJQMnUVerJzZAqC1Htm7RN1i9vdlojoIBBBwI1LLtwblhwl3EsLJWqtBf03jXxTVV5bvw9yEWYxDMUWg3SHUboCTCG9F0bx+ja1fPy/lsKmTqcjSpyVRmsEgb7aRt+H00g2OHhOXt5S54MKawbtm+IAwV49GNu/+Ulh8BlwbLCM4wcMYp3xXAzO+yCpazbwviXulb9UKYJdbzF8T74tvGANz5RwdEGUOfNbOqlw1ZYMn4QLXkwOY6n5B70/O+9JzCGExTGeKqUgZPQuJJ6gwSI2SqwOSKOdgk4rjh+3h4Msfu9hEjwespX+L8jTFYGsrDfrhFKAlFdTpOog+gFYqzj/pF6hn/4YvxNANNWj5XZ/2gaQe2xZj/tEgVKJ1/I/8w7A10QkOIU4fZWLgu6GsjRQg9R5WIPP6zQtdu/8pYAeLrrdmIg9LIrW3LQXy2xnSRWL/p+FfiIJBIdnxqz9TOXjmzI3h2SX4OQjb6PJU0Z6W3eQnDHppnmJAxMs35MQrz1qcbR8stKv4iTd16wr4JYJ+nxWZbyfw+QDtiWRSvGqeUtlatfUBwseL+rXbkrs1v+bMpvuwKUsA/DfcnjiaPAFKWogwTpkTaWmZA7fN+ZQ/Ul7vYPxgbT4mKR8qZNRte46f67qLOfogv/Oh7GjEzKWcn8xKqbhNWL+qifibPVVzvhEAH3Zj3jh2TFxlNCSBDmBrOq6JogqZe433OzhaFJ7nYDnvHkdgWlD0KDdwL4EzveOUrijGKVi5rtsx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rVYntwqoWZRzPTp2c33KqopxYQ1mnRDzFO9UV7EYX87Xh3zU437j+FNYxd+5?=
 =?us-ascii?Q?JC5EJ75Kfxv5NuULsfNk30B+dWNiqhrDKTrCn9u/jVZM6nyDsk1dSZhXuJVl?=
 =?us-ascii?Q?tGEaqBQXfPwP0x+dtpiaBdv5LW9IH9+JTY/Kh+Rl5H8kphsHrTxWiVdjh40P?=
 =?us-ascii?Q?Aj22eLEdZF1g7jjBNmcHCX+6jWociwh6rc7/ixKS+Q1cTLjhWfQObHNTnWBc?=
 =?us-ascii?Q?9KFRfiuYBh4mI+n1WLaoyocCTOY0Ksdki0nH7jCmk/1EfvCHBWvp8cjEKhar?=
 =?us-ascii?Q?DM9/CgJOSt68QDhkHD6U9kqXKsnT2axHjY+Id5N1VRa35vB/MRw5yLeeHtK8?=
 =?us-ascii?Q?Px15CaHhvePDcy7/1v/HTFSjSF7NUEoSl+QoTih5QUfdeaSMUq64N95IHdHQ?=
 =?us-ascii?Q?K8Qtk4eQzMpFWInh7gC8IWjnZJceiHPxj7UfrEnrSw5SOvBs2jDM1+Usseaa?=
 =?us-ascii?Q?HWxhJ0cmu14kyOKorTfZjZeAENA75vnu4zko56VgqdciVl1pEi7jUsyr1ZXs?=
 =?us-ascii?Q?hA35TmoYMDImyd8/dPEJCZ4y+n68/SK/swl+1FeGIx/67Z3KEyclWvvIZ2ap?=
 =?us-ascii?Q?zycZ0BwEXF/uAViSd32mXsz1kxtdAM9Smjf+C+/AL0mqkL9/0p8QP1n1+REL?=
 =?us-ascii?Q?CZ3s8I72I3f9Oo2T6k9DmkTtW3/CYbe1vCdL90iPMNoPjuS+ibAeOJ1Uwpy8?=
 =?us-ascii?Q?eveSI/QOeBUm9MKBrvw9n96MFKzPiUHyvMVukNjaYazsNJhUQr+2Kou3SqA5?=
 =?us-ascii?Q?Oy5OYIKwFn0891nM6rDgA96VyiH9U5APGqEgsHWbEpo4PZrt1b+Ni8/8achW?=
 =?us-ascii?Q?J8VvPsOFkO+eCzTe8k/vh1FcPAuEWSZDUPLFojgJRZN6HvUSpCd0/9S9JZij?=
 =?us-ascii?Q?sGtB6Ab2GtTjGo0lzzFp2ZoBNw37C59G/DN8pql4n5z4GqVOzyTVH+fpOSBl?=
 =?us-ascii?Q?4ggdcLUkQOIBdBBOOiYviMH0NytQ+N0iyNPSNq8sUCXEOdx8CGLFLmiZnuHq?=
 =?us-ascii?Q?qyw1NyWw6cID8PcnG6Tk6psNqdFVdq6rqG3aFXqjV4NxZAf8yaWOKKUshuZf?=
 =?us-ascii?Q?XCJaAf8jrQVYt+Xowf8A9zuLrtyQ6+ZgtTqWiGlCf5PPZHqcLTj0mLq6OiF+?=
 =?us-ascii?Q?IriyQ9L0YRD6sqMHgYjcqGatEH/Ceb/BAErdW/R2lT5BdmKW8GawDnh/lDO3?=
 =?us-ascii?Q?J4VGmjUm3x6lVWjTHXjEMb8/4kzOGtmbg4WzyMXzyhS3FC9quaAv0L2l5sDe?=
 =?us-ascii?Q?lgVZ0Az0R4oq2YqFPnCtazV2QMMZLy7f1qZPVRceeN/IlfxzVG+rCK17imey?=
 =?us-ascii?Q?1+/bl0o83VHAll8IwCn5up7eknTqAjXKy5wDCXvnAajmO+tjgfc4zfTzN2jZ?=
 =?us-ascii?Q?2ffmxCP04mdgtoofhis36Cuz5eYw4+NQ/0QdrYPggBK6CTJuSOsib093dFo9?=
 =?us-ascii?Q?VHbHaTZ7oCSX9wRz4b96ludHtPO3fFbil+iU1j6BF8EamSEOqtR+pBFAiioV?=
 =?us-ascii?Q?15HK33TJq/6kdOEHlia/EqvIdvdKBxo2kKNkQTPay0Okval6fxZsP5NFggRh?=
 =?us-ascii?Q?uVhb4TxzMMwkm9VzRhzeFPWjyYWFqK4XO2xCI4ifFjfJwb6FJNSVffmiiZ1s?=
 =?us-ascii?Q?MfEGpVyL/833TSCaXlR5D1gHl9MtLF884tBEuhNWAh7GDyy9dfDjEpZCD7vZ?=
 =?us-ascii?Q?/oDsKZ5U2eT3Su6wcSGX7wovip8rQk5i/CVn8ZHU0QIZm9Xy8rpO+9os4416?=
 =?us-ascii?Q?3z/o81DNIA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2034af78-694e-40d6-553f-08de8b2fde88
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8240.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 12:04:45.0911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVRo68jiWU5ncCrKJ2GnU8KLgrMuma2X6/764NQT6gw1m5VuHj/VpvPwbgJDkOHo00OhShH+wSkqfFUk5BoX7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF7D094C5BF

On Mon, Mar 16, 2026 at 08:18:49AM +0000, K Prateek Nayak wrote:
> cpufreq_cpu_get() can sleep on PREEMPT_RT in presence of concurrent
> writer(s), however amd-pstate depends on fetching the cpudata via the
> policy's driver data which necessitates grabbing the reference.
> 
> Since schedutil governor can call "cpufreq_driver->update_perf()"
> during sched_tick/enqueue/dequeue with rq_lock held and IRQs disabled,
> fetching the policy object using the cpufreq_cpu_get() helper in the
> scheduler fast-path leads to "BUG: scheduling while atomic" on
> PREEMPT_RT [1].
> 
> Pass the cached cpufreq policy object in sg_policy to the update_perf()
> instead of just the CPU. The CPU can be inferred using "policy->cpu".
> 
> The lifetime of cpufreq_policy object outlasts that of the governor and
> the cpufreq driver (allocated when the CPU is onlined and only reclaimed
> when the CPU is offlined / the CPU device is removed) which makes it
> safe to be referenced throughout the governor's lifetime.
> 
> Fixes: 1d215f0319c2 ("cpufreq: amd-pstate: Add fast switch function for AMD P-State")
> Reported-by: Bert Karwatzki <spasswolf@web.de>
> Closes:https://lore.kernel.org/all/20250731092316.3191-1-spasswolf@web.de/ [1]
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>


-- 
Thanks and Regards
gautham.
> ---
> changelog v3..v4:
> 
> o Added the Fixes tag. (Gautham, Chris Mason's review-prompts)
> ---
>  drivers/cpufreq/amd-pstate.c     |  3 +--
>  drivers/cpufreq/cpufreq.c        |  6 +++---
>  drivers/cpufreq/intel_pstate.c   |  4 ++--
>  include/linux/cpufreq.h          |  4 ++--
>  kernel/sched/cpufreq_schedutil.c |  5 +++--
>  rust/kernel/cpufreq.rs           | 13 ++++++-------
>  6 files changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 5faccb3d6b14..ad4b5f84773a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -710,13 +710,12 @@ static unsigned int amd_pstate_fast_switch(struct cpufreq_policy *policy,
>  	return policy->cur;
>  }
>  
> -static void amd_pstate_adjust_perf(unsigned int cpu,
> +static void amd_pstate_adjust_perf(struct cpufreq_policy *policy,
>  				   unsigned long _min_perf,
>  				   unsigned long target_perf,
>  				   unsigned long capacity)
>  {
>  	u8 max_perf, min_perf, des_perf, cap_perf;
> -	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
>  	struct amd_cpudata *cpudata;
>  	union perf_cached perf;
>  
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 2082a9e4384f..17a5b8e0ea1e 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2231,7 +2231,7 @@ EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
>  
>  /**
>   * cpufreq_driver_adjust_perf - Adjust CPU performance level in one go.
> - * @cpu: Target CPU.
> + * @policy: cpufreq policy object of the target CPU.
>   * @min_perf: Minimum (required) performance level (units of @capacity).
>   * @target_perf: Target (desired) performance level (units of @capacity).
>   * @capacity: Capacity of the target CPU.
> @@ -2250,12 +2250,12 @@ EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
>   * parallel with either ->target() or ->target_index() or ->fast_switch() for
>   * the same CPU.
>   */
> -void cpufreq_driver_adjust_perf(unsigned int cpu,
> +void cpufreq_driver_adjust_perf(struct cpufreq_policy *policy,
>  				 unsigned long min_perf,
>  				 unsigned long target_perf,
>  				 unsigned long capacity)
>  {
> -	cpufreq_driver->adjust_perf(cpu, min_perf, target_perf, capacity);
> +	cpufreq_driver->adjust_perf(policy, min_perf, target_perf, capacity);
>  }
>  
>  /**
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 51938c5a47ca..1552b2d32a34 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3239,12 +3239,12 @@ static unsigned int intel_cpufreq_fast_switch(struct cpufreq_policy *policy,
>  	return target_pstate * cpu->pstate.scaling;
>  }
>  
> -static void intel_cpufreq_adjust_perf(unsigned int cpunum,
> +static void intel_cpufreq_adjust_perf(struct cpufreq_policy *policy,
>  				      unsigned long min_perf,
>  				      unsigned long target_perf,
>  				      unsigned long capacity)
>  {
> -	struct cpudata *cpu = all_cpu_data[cpunum];
> +	struct cpudata *cpu = all_cpu_data[policy->cpu];
>  	u64 hwp_cap = READ_ONCE(cpu->hwp_cap_cached);
>  	int old_pstate = cpu->pstate.current_pstate;
>  	int cap_pstate, min_pstate, max_pstate, target_pstate;
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index cc894fc38971..4317c5a312bd 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -372,7 +372,7 @@ struct cpufreq_driver {
>  	 * conditions) scale invariance can be disabled, which causes the
>  	 * schedutil governor to fall back to the latter.
>  	 */
> -	void		(*adjust_perf)(unsigned int cpu,
> +	void		(*adjust_perf)(struct cpufreq_policy *policy,
>  				       unsigned long min_perf,
>  				       unsigned long target_perf,
>  				       unsigned long capacity);
> @@ -617,7 +617,7 @@ struct cpufreq_governor {
>  /* Pass a target to the cpufreq driver */
>  unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>  					unsigned int target_freq);
> -void cpufreq_driver_adjust_perf(unsigned int cpu,
> +void cpufreq_driver_adjust_perf(struct cpufreq_policy *policy,
>  				unsigned long min_perf,
>  				unsigned long target_perf,
>  				unsigned long capacity);
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 153232dd8276..ae9fd211cec1 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -461,6 +461,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
>  				     unsigned int flags)
>  {
>  	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
> +	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>  	unsigned long prev_util = sg_cpu->util;
>  	unsigned long max_cap;
>  
> @@ -482,10 +483,10 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
>  	if (sugov_hold_freq(sg_cpu) && sg_cpu->util < prev_util)
>  		sg_cpu->util = prev_util;
>  
> -	cpufreq_driver_adjust_perf(sg_cpu->cpu, sg_cpu->bw_min,
> +	cpufreq_driver_adjust_perf(sg_policy->policy, sg_cpu->bw_min,
>  				   sg_cpu->util, max_cap);
>  
> -	sg_cpu->sg_policy->last_freq_update_time = time;
> +	sg_policy->last_freq_update_time = time;
>  }
>  
>  static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index 76faa1ac8501..a83aec198336 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -1256,18 +1256,17 @@ impl<T: Driver> Registration<T> {
>      /// # Safety
>      ///
>      /// - This function may only be called from the cpufreq C infrastructure.
> +    /// - The pointer arguments must be valid pointers.
>      unsafe extern "C" fn adjust_perf_callback(
> -        cpu: c_uint,
> +        ptr: *mut bindings::cpufreq_policy,
>          min_perf: c_ulong,
>          target_perf: c_ulong,
>          capacity: c_ulong,
>      ) {
> -        // SAFETY: The C API guarantees that `cpu` refers to a valid CPU number.
> -        let cpu_id = unsafe { CpuId::from_u32_unchecked(cpu) };
> -
> -        if let Ok(mut policy) = PolicyCpu::from_cpu(cpu_id) {
> -            T::adjust_perf(&mut policy, min_perf, target_perf, capacity);
> -        }
> +        // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
> +        // lifetime of `policy`.
> +        let policy = unsafe { Policy::from_raw_mut(ptr) };
> +        T::adjust_perf(policy, min_perf, target_perf, capacity);
>      }
>  
>      /// Driver's `get_intermediate` callback.
> -- 
> 2.34.1
> 
