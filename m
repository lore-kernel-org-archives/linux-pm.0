Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793220681;
	b=T1XW2Na9dukFIeUM7RHsmhvJXKsMTLGQAfUTXIG62nTKv64CDolKQGHq7pc2F6QwfWsM
	 iDFzaDrff2Y2wTSc7SrS+qPMbg9toFGyuZqUP3KZ6iTLlO1eI5rOPGDm1tAuMBJR0NMTv
	 ixrt2PNl6sqiyHJHJ2NJnU+7+9je0O7Yo4jMkgIXitia/ftOtTJ46/et/J8fR4MoNTtU5
	 n7i0t3+P1lI9H/e2NZ7iV9baTdlXYbunDcTjjbvO+JjkZ8/bY+jizlL8TxatGNLVEAwlc
	 pVh7jbgDg77ePIzm7/B/WOqbQ5nGzAgO3f61I/a686UJGDykEuV14caoKLmcYGs4VdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793220681;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=CnLE/9Yyq9h6HEWa0hx9EplI14IOfhOhWCn1DJXK6OQ=;
	b=eEPMScSuwF9PYZf9t6SCBkWARhI2MWhiS0vQPNVYLkKLzLG85l6llkBTnZP9dCDO/lrZ
	 VoT/k893qVMXT7tLsqFdYp51vhXjAIrQtjc0kf8U7LspOsrVAvNXFrcVS4wnZgOpcv5jB
	 3G89DnO0XzWPDaTkPMrb/rX7nLbEt8hAFcdvRfL92UMy8dqOFQVLkd4ptWzW7jO/f3id8
	 dQeOthcipJO01kKjvj7nR9cw6/QvppyIUnZJXvWT0UxU/o+Lq/G7awKbDxXB9lQl4DQ9u
	 TeXIe+Em8cw/nE+b8yWtj0VZuYzRzBT9bP7YawluDmvRZ1QnCsh5jciVm2IX4mj7LIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=k3XiuxfM;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E7A606A31F;
	Wed, 28 Oct 2026 20:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7E7A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=k3XiuxfM
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85AA41BD0;
	Wed, 28 Oct 2026 13:51:15 -0700 (PDT)
Received: from [10.57.78.105] (unknown [10.57.78.105])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D7D63F59E;
	Wed, 28 Oct 2026 13:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793220678; bh=9kdRVBvR9sVCVVnrcS7mwNRTl9/bAJHDllxpfqPKu54=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k3XiuxfMjLIS2Fl90mZmLqTYpJHYf86UAEIiCN7f7A7V/lu8UdKQMTAbb5TEWix6m
	 lDKJ2sGS6iE0AKuGrHz8BzlNYPEDt6pHgmtiPY4KoXv+Fm61h2bpmbne/NJsepIO2C
	 JOFsS1MqFMLiE/VrvrypqIZNQ4kpASGP89Ek52Qc=
Message-ID: <d9fa8052-f562-4867-9e9f-1fd2a66fa794@arm.com>
Date: Wed, 28 Oct 2026 20:51:13 +0000
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
Subject: Re: [PATCH v2] cpufreq: CPPC: Enable boost by default when supported
To: Pengjie Zhang <zhangpengjie2@huawei.com>, rafael@kernel.org,
 viresh.kumar@linaro.org
Cc: linuxarm@huawei.com, zhanjie9@hisilicon.com, prime.zeng@hisilicon.com,
 wanghuiqiang@huawei.com, xuwei5@huawei.com, zhenglifeng1@huawei.com,
 yubowen8@huawei.com, pierre.gondois@arm.com, sumitg@nvidia.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, mojunjun4@huawei.com
References: <20261022075901.3436021-1-zhangpengjie2@huawei.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20261022075901.3436021-1-zhangpengjie2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/26 08:59, Pengjie Zhang wrote:
> The CPPC driver leaves boost disabled by default when Highest Performance
> exceeds Nominal Performance. Userspace must explicitly enable boost
> before governors can use the full advertised performance range.
> 
> Enable boost by default when at least one possible CPU reports support,
> while users who prefer to stay within the sustained nominal limit can
> still disable it via the boost knob without determining scaling_max_freq
> for each policy.
> 
> Check the performance capabilities before registering the driver so that
> the cpufreq core enables boost for each policy that supports it.
> 
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>


Just to be clear I'm not blocking this per se, but continuing my comments:

I just wonder if this is a configuration worth keeping.
You mentioned your platforms have a BIOS to set nominal==highest or not.
If we removed interpreting highest - nominal as boost entirely that
would also make that BIOS setting obsolete. Userspace could still
query nominal and restrict cpufreq to that if it wishes to do that,
we could add that to cpupower for convenience (i.e. set all policies'
max to nominal).

With the changes that are coming with CPCv4 we would save ourselves
some headache (like keeping track of boost status when ospm_nominal_perf
is being written).

The question is also how often the combination of "enable nominal < highest"
and then explicitly toggling boost at runtime actually happens...

> ---
> Changes in v2:
> - Drop "even" and clarify the commit message (Christian).
> - Link to v1: https://lore.kernel.org/all/20261015015812.867988-1-zhangpengjie2@huawei.com/
> 
>  drivers/cpufreq/cppc_cpufreq.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 80893844353c..0a4255a36f60 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -1052,6 +1052,25 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>  	.name = "cppc_cpufreq",
>  };
>  
> +static void __init cppc_cpufreq_default_boost_init(void)
> +{
> +	struct cppc_perf_caps caps;
> +	bool enable = false;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		if (cppc_get_perf_caps(cpu, &caps))
> +			continue;
> +
> +		if (caps.highest_perf > caps.nominal_perf) {
> +			enable = true;
> +			break;
> +		}
> +	}
> +
> +	cppc_cpufreq_driver.boost_enabled = enable;

Any reason for the scan instead of just setting
boost_enabled = true? Platforms without boost would
also expose the toggle, but that's mostly in line with
the other drivers? (also again the ospm_nominal_perf
angle)

> +}
> +
>  static int __init cppc_cpufreq_init(void)
>  {
>  	int ret;
> @@ -1061,6 +1080,7 @@ static int __init cppc_cpufreq_init(void)
>  
>  	cppc_freq_invariance_init();
>  	populate_efficiency_class();
> +	cppc_cpufreq_default_boost_init();
>  
>  	ret = cpufreq_register_driver(&cppc_cpufreq_driver);
>  	if (ret)

