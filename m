Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793994090;
	b=nPYRiwyrwyAveo8re9PqQkicDJgVF1p8+y/scY8qWaMovZPlbAA9V3AdoDI3K7FH1OK4
	 MgUioTdxjpFc7SmTFJ+U25lqwouPgVTAsAEizwte0VSsehtZ0RBanp616ym51/ZyW9krr
	 TpMUAtwK370uT5yTTb6zRPytf4jnQLg4t2L82t1Gq2Mne9UvYJwml5w25F1XUBVBHf84n
	 Aa+Q5t4lcVS/aSFIJRtcXth3dct+kCYfmt4y6U5nSdMeLxlCJC6po7HNDCwNJx6hCX2mS
	 9BbxekQC3CPb78A5ucpgw7M5TnqFluAdOtzwlkYFd1p2wHPrdRKqnCy6AKtl5cg7/nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994090;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=0sJnTvTIwCUMqEIvWSmIp/R0LwPfW88aqxkk8F5wStU=;
	b=R5BeXgSqL9TtpabmEAsv7enTKIHfUm541e6ZOs0Cv2nzHhgCMll0vDapPHVfNRnIsCCZ
	 GREZ7tTKD6HzjBf4Jgjw6nReChwRv3jROlGhvhOV8f3TTzhrXU8PyJVy0FQP0O8l0NCFE
	 Ei4gpDZd4f90pX0zFHD321zpV4R4I2IKIsYHMEL4SI/5oa+eH1R+d2mf45IM7bexJWtaD
	 wlAX5dJ8Yphj0x8JyRRLqwcyofL3DFhG0JS1kggF4DcDj4Duzc3qbZfe53xJIBdzCMIk5
	 v/SOkcEHoLGsxdWxyDNiuT5cHBf5Jj8G/05fQbi9Uvb7v41sKM97gAWMhEmS54GKgTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BfDa10aI;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E59606A333;
	Fri,  6 Nov 2026 19:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3E59606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BfDa10aI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793994090; x=1825530090;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lu9luSVPu9/ZJIYiQZYq+QgP7xm0bIdpZHlk42TGXFk=;
  b=BfDa10aIMh2xL4Ey6sc4wibWFBXA+3pXWwja0q2G/xpyEXg7YffWSPOV
   hMXuk5uNnTgogxvZFFYuZu4vL01kL9qYTIrj2Z1ICUegV8OUUeez9HDBT
   617qSLyBd2Yr++ZXFZaRSq0mfjQhr8RZOSopK632FUcmEdLN6Ir0df4qj
   omN802qsP4U0o6l6Q6CKMU8W28DlDhhYhXYpv46rA52j5PJVhfOwVOrP9
   Kl359rAHdjjXds/Nx81jOrZYzX5gzQzF/neFoRoRn2o3SZ0AExihuHkC8
   3MOdX8M110MoQdg6ihqiicfxr8N3/yylvlqGoWwrcv97H4rQlZGHd4yIS
   Q==;
X-CSE-ConnectionGUID: Js0WgKPRRl2Zt4qiIKVPUQ==
X-CSE-MsgGUID: FCXwZxirRxSNa5YjylIYAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2915240"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2915240"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 11:41:29 -0800
X-CSE-ConnectionGUID: xAGiIvoQRdi1ZYRaINcayw==
X-CSE-MsgGUID: 5Rl+VzXGR4aTcCiYEZ6Sew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7248293"
Received: from unknown (HELO [10.241.240.140]) ([10.241.240.140])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 11:41:29 -0800
Message-ID: <d10e4235-dd25-40e6-b682-bf7530ab931d@linux.intel.com>
Date: Fri, 6 Nov 2026 11:41:28 -0800
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
Subject: Re: [PATCH] powercap: intel_rapl: Expose package CPUs in
 associated_cpus
To: Dennis Chen <dechen@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261106183046.208283-1-dechen@redhat.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20261106183046.208283-1-dechen@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/6/2026 10:30 AM, Dennis Chen wrote:
> Commit 525e0064f3d8 ("powercap: intel_rapl: Expose all package CPUs in
> PMU cpumask") expanded cpumask to include all CPUs in the package.
> Since perf opens an event for every CPU in cpumask, the value returned
> for power/energy-pkg/ is roughly scaled by the number of CPUs.

Thanks for catching this. You are right. perf treats cpumask as the set
of CPUs to open events on, so a package-scoped counter gets summed once
per CPU. My change broke that expectation.

> 
> On a single-socket 72-core DMR machine the reported value is roughly
> 72x higher than when perf is restricted to reading from a single CPU:
> 
> $ perf stat -e power/energy-pkg/ -- sleep 1
>  Performance counter stats for 'system wide':
> 
>           8,052.48 Joules power/energy-pkg/
> 
>        1.010483558 seconds time elapsed
> 
> $ perf stat -C 5 -e power/energy-pkg/ -- sleep 1
> 
>  Performance counter stats for 'CPU(s) 5':
> 
>             112.15 Joules power/energy-pkg/
> 
>        1.009685587 seconds time elapsed
> 
> Revert cpumask to only include the CPU with the lowest ID in the
> package and instead expose CPUs which can read from the PMU in
> associated_cpus, akin to uncore PMU drivers with per-package counters.
> 
> This retains flexibility for userspace tools while maintaining semantic
> consistency for perf's use of cpumask.
> 

Is there a user of associated_cpus? Neither perf nor turbostat reads it
today. The "any CPU in the package" support that turbostat needed comes
from commit 7537bae8b6eb ("powercap: intel_rapl: Remove incorrect CPU
check in PMU context") and from is_rp_pmu_cpu(). Your patch keeps both.

If there is no consumer, I would prefer a plain revert of 525e0064f3d8.
It fixes the issue with a smaller diff and does not add new sysfs ABI.
If you do want to keep associated_cpus, please add an entry under
Documentation/ABI for it.

> Assisted-by: LLM
> Fixes: 525e0064f3d8 ("powercap: intel_rapl: Expose all package CPUs in PMU cpumask")
> Signed-off-by: Dennis Chen <dechen@redhat.com>

This has been in since v7.0, so please add Cc: stable@vger.kernel.org.


> ---
>  drivers/powercap/intel_rapl_common.c | 43 ++++++++++++++++++++--------
>  1 file changed, 31 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 70cab5f08bc6..4197f7146afc 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1139,7 +1139,8 @@ static struct rapl_pmu rapl_pmu;
>  
>  /* PMU helpers */
>  
> -static void set_pmu_cpumask(struct rapl_package *rp, cpumask_var_t mask)
> +static void rapl_pmu_collect_cpus(struct rapl_package *rp, cpumask_var_t mask,
> +				  bool all_online)
>  {
>  	int cpu;
>  
> @@ -1151,9 +1152,15 @@ static void set_pmu_cpumask(struct rapl_package *rp, cpumask_var_t mask)
>  		return;
>  
>  	/* TPMI/MSR RAPL uses any CPU in the package for PMU */
> -	for_each_online_cpu(cpu)
> -		if (topology_physical_package_id(cpu) == rp->id)
> -			cpumask_set_cpu(cpu, mask);
> +	for_each_online_cpu(cpu) {
> +		if (topology_physical_package_id(cpu) != rp->id)
> +			continue;
> +
> +		cpumask_set_cpu(cpu, mask);
> +		/* Stop at first CPU in package if not all CPUs are requested */
> +		if (!all_online)
> +			return;
> +	}
>  }
>  
>  static bool is_rp_pmu_cpu(struct rapl_package *rp, int cpu)
> @@ -1430,8 +1437,7 @@ static struct attribute_group pmu_events_group = {
>  	.attrs = attrs_empty,
>  };
>  
> -static ssize_t cpumask_show(struct device *dev,
> -			    struct device_attribute *attr, char *buf)
> +static ssize_t rapl_pmu_cpus_show(char *buf, bool all_online)
>  {
>  	struct rapl_package *rp;
>  	cpumask_var_t cpu_mask;
> @@ -1444,23 +1450,36 @@ static ssize_t cpumask_show(struct device *dev,
>  
>  	cpumask_clear(cpu_mask);
>  
> -	/* Choose a cpu for each RAPL Package */
> -	list_for_each_entry(rp, &rapl_packages, plist) {
> -		set_pmu_cpumask(rp, cpu_mask);
> -	}
> +	/* Choose a set of CPUs for each RAPL Package */
> +	list_for_each_entry(rp, &rapl_packages, plist)
> +		rapl_pmu_collect_cpus(rp, cpu_mask, all_online);
>  	cpus_read_unlock();
>  
>  	ret = sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpu_mask));
> -
>  	free_cpumask_var(cpu_mask);
> -
>  	return ret;
>  }
>  
> +static ssize_t cpumask_show(struct device *dev __always_unused,
> +			    struct device_attribute *attr __always_unused,
> +			    char *buf)
> +{
> +	return rapl_pmu_cpus_show(buf, false);
> +}
> +
> +static ssize_t associated_cpus_show(struct device *dev __always_unused,
> +				    struct device_attribute *attr __always_unused,
> +				    char *buf)
> +{
> +	return rapl_pmu_cpus_show(buf, true);
> +}
> +
>  static DEVICE_ATTR_RO(cpumask);
> +static DEVICE_ATTR_RO(associated_cpus);
>  
>  static struct attribute *pmu_cpumask_attrs[] = {
>  	&dev_attr_cpumask.attr,
> +	&dev_attr_associated_cpus.attr,
>  	NULL
>  };
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

