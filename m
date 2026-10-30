Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793369321;
	b=BrJTjpqEJmy+JQWuoSYK6bRu76MfI0nLwap+dEFfctOvynO+p80H6xVyuNfaRfG57qk4
	 7VFyIOCiFuim4Xuh5FkFG29YxBfEeqBeofUf4P/68IcY5VkEFTzQC3ZwX3jIU5ZcTLKTh
	 53B6uhivV9asEDozN9T+b3SIDGRWa0QIMTRIg+FKNsM3yMeZltHsNEqb8OxE9muQtG68I
	 4PQtDr2QB1oIhe1VuJ9HEfdGjvBl788uiFt/jWp9Afb0ELhQhlahaCs+AVZLCHaCgaAxg
	 vW23nfaivUxq4J7Buy41wQp3AX3Un2SGZSG8oVEjEy9pfoVh1i5bIhjeQE6zxQ8DFHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793369321;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=yBYwPQBz7+UhQBhyVl24JuhcrD/xAeip1eHLjzG8jq4=;
	b=tawShL7Q3zQiaBWFp/SYI9D5Bxy+IkuvAfddw5Zz7WSmrQXHOmLAOg/Hkdg+cRtZd1wQ
	 q6unVKM1cHyiwmfcgdbXBBoCk8xzrx1fT0wdJA4WWUAojpb4M8eAX3WaDnNhQWoS5Mkfw
	 PXe4hhS9+f3wEXivRDAHtnLYZRXF9Fct/uzRfEsQtGYjjLI9czyTe4HvmozXg2q6v2/AL
	 KOJ5c7J4dehaAbtoLBUG6nqV3JkdSCKvsFVq7xvbkJSwJpL/q88mL3G+YzMsTuwm8nbio
	 LShQLtCqu3Pjd9yFgvSSJ5rNjTxVqkixrI85cPR3zm3lZKN2FmDjepqNyMlECP4j7nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Zhs8w9dy;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDF9606A329;
	Fri, 30 Oct 2026 14:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CDF9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Zhs8w9dy
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54DEF1D13;
	Fri, 30 Oct 2026 07:08:37 -0700 (PDT)
Received: from [10.57.13.127] (unknown [10.57.13.127])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5527C3F673;
	Fri, 30 Oct 2026 07:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793369320; bh=DG8ml6HdWY7nXgpm84li/+TfZGx2R9DU1QknKf5wDmo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zhs8w9dyCcMJza+mmkrMI4zvEaQ9V7oMRNrr7YwDltZfpROxSUGA17E604tHMSqJ3
	 S8wv3nm6jvkspvjvFqnQX8bFB/aHXRx29n+Aqujk5sVi7MCRBVLgPas/ASA8lUDUiV
	 ANiHU03veXB7ves89JdMh512DiKVGunRkZX2aQss=
Message-ID: <c614e414-0f9b-464f-90bb-dc1cd63b09d2@arm.com>
Date: Fri, 30 Oct 2026 14:09:08 +0000
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
Subject: Re: [PATCH v4 6/6] powercap: dtpm: Add RK3588 hierarchy
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, rafael@kernel.org
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Shuah Khan <shuah@kernel.org>,
 Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kselftest@vger.kernel.org
References: <cover.1793288783.git.daniel.lezcano@oss.qualcomm.com>
 <50f06fc06f0e83ee59ecf9037071e02344ecd15b.1793288783.git.daniel.lezcano@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <50f06fc06f0e83ee59ecf9037071e02344ecd15b.1793288783.git.daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/29/26 16:56, Daniel Lezcano wrote:
> The RK3588 has three CPU frequency domains, with CPUs grouped into
> three cpufreq policies.
> 
> Add a DTPM hierarchy for the RK3588 with one CPU node per cpufreq
> policy, represented by cpu@0, cpu@400 and cpu@600. Group the three CPU
> domains under a virtual package node attached to the RK3588 root node.
> 
> Add the RK3588 compatible to the Rockchip DTPM match table to select
> the new hierarchy.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
> Changes in v4 (since v3):
> - Rebase on v7.3; no code or commit-description changes.
> 
> Changes in v3 (since v2):
> - Rebase on v7.3-rc7.
> - Fix __initdata placement and the RK3588 match-entry indentation.
> - No functional changes.
> 
>   drivers/soc/rockchip/dtpm.c | 48 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
> 
> diff --git a/drivers/soc/rockchip/dtpm.c b/drivers/soc/rockchip/dtpm.c
> index 5ae00680602f..664764f4b460 100644
> --- a/drivers/soc/rockchip/dtpm.c
> +++ b/drivers/soc/rockchip/dtpm.c
> @@ -62,8 +62,56 @@ static struct powercap_hierarchy rk3399_hierarchy __initdata = {
>   	.nr_nodes = ARRAY_SIZE(rk3399_nodes),
>   };
>   
> +static struct dtpm_node rk3588_cpu0 = {
> +	.type = DTPM_NODE_DT,
> +	.path = "/cpus/cpu@0",
> +};
> +
> +static struct dtpm_node rk3588_cpu4 = {
> +	.type = DTPM_NODE_DT,
> +	.path = "/cpus/cpu@400",
> +};
> +
> +static struct dtpm_node rk3588_cpu6 = {
> +	.type = DTPM_NODE_DT,
> +	.path = "/cpus/cpu@600",
> +};
> +
> +static struct powercap_node rk3588_nodes[] __initdata = {
> +	[0] = {
> +		.name = "rk3588",
> +		.data = &rockchip_virtual,
> +	},
> +	[1] = {
> +		.name = "package",
> +		.parent = &rk3588_nodes[0],
> +		.data = &rockchip_virtual,
> +	},
> +	[2] = {
> +		.name = "cpu0-cpufreq",
> +		.parent = &rk3588_nodes[1],
> +		.data = &rk3588_cpu0,
> +	},
> +	[3] = {
> +		.name = "cpu4-cpufreq",
> +		.parent = &rk3588_nodes[1],
> +		.data = &rk3588_cpu4,
> +	},
> +	[4] = {
> +		.name = "cpu6-cpufreq",
> +		.parent = &rk3588_nodes[1],
> +		.data = &rk3588_cpu6,
> +	},
> +};
> +
> +static struct powercap_hierarchy rk3588_hierarchy __initdata = {
> +	.nodes = rk3588_nodes,
> +	.nr_nodes = ARRAY_SIZE(rk3588_nodes),
> +};
> +
>   static struct of_device_id __initdata rockchip_dtpm_match_table[] = {
>   	{ .compatible = "rockchip,rk3399", .data = &rk3399_hierarchy },
> +	{ .compatible = "rockchip,rk3588", .data = &rk3588_hierarchy },
>   	{},
>   };
>   

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
