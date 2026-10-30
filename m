Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368984;
	b=rhx8UCW4Kc1EA++1X3oJDikRKP/+UriKgL7qtMR1Hmn5TDcsKdKk65MUlpPF424YgHsK
	 OogXFftK0lT/DgB8BdRqdr0U+JdMIWrRUcD+hKgL3rVHNVlLPJJhVGeCnafGhZfQV2GmZ
	 Y16w3iuZYS4TLOCnHTAUeMv/ICdjQlf0J5L/pE+TVH0ixvZgArvOwNzhRjvA2nalq8aR5
	 BXBYmHLvLtZHhZnOhUkMMqPfpTSNQFOJfp9Dc22vNWjJ7TjTcuLwjA/4yUDCzmNGwnAVG
	 VdV86FKg1DWMlOBkbS2l7NGbtvbcuaMKasxrA294zeMfLCdqqIr9FccFFtGJC9sBmtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368984;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=TSHFV9p0o4fRFZk9gFzrl1PkSDFKqS4z3PC8jypGJsI=;
	b=hSmlqzBD3GJTioSqZO5e8YvferhFhIxhOgngnsbjW39JV5DrfraACq0wyaQ2E5FDJCrV
	 FtEvJShV1RlW8V2/3nOrlsL2OxrxhVxmRrUqQnRaZwNrgf8uzGWqejwA7TG6Eom9+Ug5h
	 ddqSz7JA/47/UH5ysMfe3yuoOMIhVZNQB4jAVVzxNEKzWnV0G1SSJ5usRTduOsgSIRStp
	 Oexf351R/AiJ+CrJlxVcO3A4Gtlsfj2bFYlE0N5MVr3GbHetMI+dulhlpTl7SHzJMb7C2
	 CFhWdoGAiuy4Op6DcKwsuyWhFKAC2Rh5PzGCk9iqAsQNCmLwbEC8ys1j7nARIrlVD0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="g+s8b/GP";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA0C606A337;
	Fri, 30 Oct 2026 14:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EA0C606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=g+s8b/GP
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 551571477;
	Fri, 30 Oct 2026 07:02:59 -0700 (PDT)
Received: from [10.57.13.127] (unknown [10.57.13.127])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EEBE3F59E;
	Fri, 30 Oct 2026 07:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793368982; bh=I1FUwJlvLdKX7LF1hbS3q4Ks7XyfAy+gx/3lbFUXJwg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g+s8b/GPOmL4UjKBohYUzlRu7cb+Lv7nMWcoRTtPnk3ayEIAKWU4tKYFnH6gF245N
	 EJ/BgpFY0HLsFd4A4fdl///R9dePyn6U/pFFFMfXCbyRCTXd7JM7FsJ3lraot/sAHb
	 fOOws9qF1Ev9boGoj3uHhM/UuZbJh8DulbgMkOWU=
Message-ID: <233a55d5-48f4-4e57-b816-3a59d9ab2b73@arm.com>
Date: Fri, 30 Oct 2026 14:03:30 +0000
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
Subject: Re: [PATCH v4 3/6] powercap: dtpm: Remove duplicate RK3399 CPU
 hierarchy nodes
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, rafael@kernel.org
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Shuah Khan <shuah@kernel.org>,
 Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kselftest@vger.kernel.org
References: <cover.1793288783.git.daniel.lezcano@oss.qualcomm.com>
 <141ad25a137cb50516bd92f9a13dda7ec940f6da.1793288783.git.daniel.lezcano@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <141ad25a137cb50516bd92f9a13dda7ec940f6da.1793288783.git.daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/29/26 16:56, Daniel Lezcano wrote:
> The DTPM CPU backend registers one powercap zone per cpufreq policy,
> not per CPU. On RK3399, CPUs sharing the same cpufreq policy therefore
> map to the same DTPM zone.
> 
> Remove the redundant CPU nodes from the RK3399 hierarchy and keep only
> one CPU node per cpufreq policy. The backend already suppresses duplicate
> registration through its per-CPU state, so the removed entries are
> redundant descriptions of the same zones. Keep both CPU policy domains
> and the GPU in the hierarchy, preparing for one created zone per generic
> hierarchy node.
> 
> Also fix indentation in the Rockchip device match table.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
> Changes in v4 (since v3):
> - Rebase on v7.3; no code or commit-description changes.
> 
> Changes in v3 (since v2):
> - Rebase on v7.3-rc7.
> - Fix Rockchip match-table indentation here rather than in patch 1.
> - Clarify that the existing backend suppresses duplicate registration.
> 
>   drivers/soc/rockchip/dtpm.c | 22 +++++-----------------
>   1 file changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/soc/rockchip/dtpm.c b/drivers/soc/rockchip/dtpm.c
> index b36d4f752c30..e71f315fbb6b 100644
> --- a/drivers/soc/rockchip/dtpm.c
> +++ b/drivers/soc/rockchip/dtpm.c
> @@ -20,30 +20,18 @@ static struct dtpm_node __initdata rk3399_hierarchy[] = {
>   	[2] = { .name = "/cpus/cpu@0",
>   		.type = DTPM_NODE_DT,
>   		.parent = &rk3399_hierarchy[1] },
> -	[3] = { .name = "/cpus/cpu@1",
> +	[3] = { .name = "/cpus/cpu@100",
>   		.type = DTPM_NODE_DT,
>   		.parent = &rk3399_hierarchy[1] },
> -	[4] = { .name = "/cpus/cpu@2",
> +	[4] = { .name = "/gpu@ff9a0000",
>   		.type = DTPM_NODE_DT,
>   		.parent = &rk3399_hierarchy[1] },
> -	[5] = { .name = "/cpus/cpu@3",
> -		.type = DTPM_NODE_DT,
> -		.parent = &rk3399_hierarchy[1] },
> -	[6] = { .name = "/cpus/cpu@100",
> -		.type = DTPM_NODE_DT,
> -		.parent = &rk3399_hierarchy[1] },
> -	[7] = { .name = "/cpus/cpu@101",
> -		.type = DTPM_NODE_DT,
> -		.parent = &rk3399_hierarchy[1] },
> -	[8] = { .name = "/gpu@ff9a0000",
> -		.type = DTPM_NODE_DT,
> -		.parent = &rk3399_hierarchy[1] },
> -	[9] = { /* sentinel */ }
> +	[5] = { /* sentinel */ }
>   };
>   
>   static struct of_device_id __initdata rockchip_dtpm_match_table[] = {
> -        { .compatible = "rockchip,rk3399", .data = rk3399_hierarchy },
> -        {},
> +	{ .compatible = "rockchip,rk3399", .data = rk3399_hierarchy },
> +	{},
>   };
>   
>   static int __init rockchip_dtpm_init(void)


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
