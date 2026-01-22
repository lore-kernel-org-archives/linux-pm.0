Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F7723AB98;
	Thu, 22 Jan 2026 08:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070691; cv=none; b=pbfVWnr+AkuBmkLqNgCGdEpW1qiD/LnsZ0/Myw090g9BPEe2kHwxabkys/dLZLnCpBw4t+/5xQFWL+Wu3WL40CNPxo/ERD+3Hts+/KPoa46r7KO2oEupornxteqaj07PhusuC8taFdWaCBhrmGuKSleyE0lGVvb5DbjjEcgObdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070691; c=relaxed/simple;
	bh=2xA31qQAvq4VXXtUn7T9PG11OBDVCjOSXHfGGTG0WtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TUiIlyQ65we2hXtheVpn/hVKrBi7Xl0M4yykMfQZxWN12/K9RqSHw3x0cUkZCEygAmTIGYSXmKemwVihBAD5YLapY2jL/136VBgm3mt9v1c+yfjb+HGsF3yxX043xC1D/BEfbzViy0FFSul75PovUJHWwx/Mk2o2G0IZewA7hU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=0KLzKQor; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="0KLzKQor"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=umcwphYtnL9lqP5zR6KMGW2RfVKx0uCr7p26EpoeBhE=;
	b=0KLzKQoryoB8Wy11zD40OU/dQSQpsRRj236nsLdZlyV3MXK/zxnXGXUe7sPL8y2Gery+8Wm96
	UYgBUtXlIcBkyzVKIj2YbBGb94owZKg9VA519Voh4f/TZOTVzFgXjwPqYAviMWjWH7Wj2mGLcAC
	dxHVPvYawDG+tg4ma73lpFU=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dxZ1R086zz1T4Fq;
	Thu, 22 Jan 2026 16:27:23 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 083C140569;
	Thu, 22 Jan 2026 16:31:27 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 16:31:25 +0800
Message-ID: <c5619a18-2d1a-4860-b87d-0b4ce261d350@huawei.com>
Date: Thu, 22 Jan 2026 16:31:25 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/9] ACPI: CPPC: Rename EPP constants for clarity
To: Sumit Gupta <sumitg@nvidia.com>
CC: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<ionela.voinescu@arm.com>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<corbet@lwn.net>, <rdunlap@infradead.org>, <ray.huang@amd.com>,
	<gautham.shenoy@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<zhanjie9@hisilicon.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
	<vsethi@nvidia.com>, <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>,
	<nhartman@nvidia.com>, <bbasu@nvidia.com>
References: <20260120145623.2959636-1-sumitg@nvidia.com>
 <20260120145623.2959636-4-sumitg@nvidia.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20260120145623.2959636-4-sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2026/1/20 22:56, Sumit Gupta wrote:
> Update EPP (Energy Performance Preference) constants for better clarity:
> - Add CPPC_EPP_PERFORMANCE_PREF (0x00) for performance preference
> - Rename CPPC_ENERGY_PERF_MAX to CPPC_EPP_ENERGY_EFFICIENCY_PREF (0xFF)
>   for energy efficiency
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/acpi/cppc_acpi.c | 2 +-
>  include/acpi/cppc_acpi.h | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 22d7fd669a6c..a09bdabaa804 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1615,7 +1615,7 @@ EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
>   */
>  int cppc_set_epp(int cpu, u64 epp_val)
>  {
> -	if (epp_val > CPPC_ENERGY_PERF_MAX)
> +	if (epp_val > CPPC_EPP_ENERGY_EFFICIENCY_PREF)
>  		return -EINVAL;
>  
>  	return cppc_set_reg_val(cpu, ENERGY_PERF, epp_val);
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 6573a759eb8d..4d644f03098e 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -39,7 +39,8 @@
>  /* CPPC_AUTO_ACT_WINDOW_MAX_SIG is 127, so 128 and 129 will decay to 127 when writing */
>  #define CPPC_AUTO_ACT_WINDOW_SIG_CARRY_THRESH 129
>  
> -#define CPPC_ENERGY_PERF_MAX	(0xFF)
> +#define CPPC_EPP_PERFORMANCE_PREF		0x00
> +#define CPPC_EPP_ENERGY_EFFICIENCY_PREF		0xFF
>  
>  /* Each register has the folowing format. */
>  struct cpc_reg {

Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
