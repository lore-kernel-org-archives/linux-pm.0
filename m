Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793369195;
	b=vN3ahmwTnH8MZWK+e3GuD1bDbZ5pm+JHwVBDvpQFKz6KVuidIJAQlakYR8vhsSwjKfZs
	 ALFNMQlasnBfQDyEwjn6LBwD3SUrvJZZXi1ZmZJ34NQik8OFFoVdYxP6IezOoGTl0yErI
	 v68RFWavYkuAmreOx7Nm8qe2HyFruTumWYYbrnGt7nEFrZ8EWcuKQMvnf2hp4GOI32tEu
	 OIi7RcGhaIxn55dtwMymJ/D1VsxKLce/CDiGyeBhcEzO347u7BJmeBOJ5Z6kYkfkmTRzb
	 EWjv7OCprABcy5ZWqTCPkeBtM7u/b9YiPrLAKG5GWxs63HnA/AGSPW+ZznhaB/aBN2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793369195;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=NLCu8TR6LhnwPxFua00Dj/D0rG0UINndH2TWXr2KdOI=;
	b=1Vbq90o1dB8XSVNl56nYbGgwqk9D+uXtK9CSAfjF53+TrZTZWoTxsy66otvBnkWaOLXK
	 ZvPG7gCJoQO5AZNSLxQLoTPvW/VO635Z8PbC5frEu2NCbr4pCJP87iQ7lbs0LIhqUxRKv
	 sIRcjpN1tW9Jt9SV0ByD7jST2qLrzwrNIW8ePR0MTNvGnqyjPuwGeMwqmTD9viT7MkmMN
	 159Wa8G48M0IThM1J4/2yJDbwMvozhih+zSySltxs3xlqbR0KB2ML/D6vbw/oz1rOi3Ng
	 mFh0rpsQdVXMe2LYOnl0lFqP6XkyXvpl6lFCkX16gRxYMixdF9L9l3jKUsgcOJEqNdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=oLwAGCkI;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDD6606A31A;
	Fri, 30 Oct 2026 14:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBDD6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=oLwAGCkI
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33EE21CE0;
	Fri, 30 Oct 2026 07:06:31 -0700 (PDT)
Received: from [10.57.13.127] (unknown [10.57.13.127])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52E613F673;
	Fri, 30 Oct 2026 07:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793369194; bh=nLI0d8mXJNn/1KyLy0u4f2Q9bqsXsorDpHIkyD1jVKA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oLwAGCkIDoNHp61txC4fL7ZJCs4qQYngVcfJ2CSGI4ojTpNgZAprg/Rq1FXuLe42A
	 05w9BZyMNji5KigDN4knB8DovlU0Zv3wssp/SDxbh9c+2S77mDiwpm0MRrK3f9hRoy
	 3IEAoz0haSQbyjIIE0YciD3qITM9mqorpbHRvcKI=
Message-ID: <825d47ed-9656-4467-bf37-39c65a7d4d79@arm.com>
Date: Fri, 30 Oct 2026 14:07:02 +0000
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
Subject: Re: [PATCH v4 5/6] powercap: dtpm: Rename Rockchip virtual node
 descriptor
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, rafael@kernel.org
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Shuah Khan <shuah@kernel.org>,
 Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kselftest@vger.kernel.org
References: <cover.1793288783.git.daniel.lezcano@oss.qualcomm.com>
 <063f0587a6c951ca57e941ebab39617a0d0a305c.1793288783.git.daniel.lezcano@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <063f0587a6c951ca57e941ebab39617a0d0a305c.1793288783.git.daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/29/26 16:56, Daniel Lezcano wrote:
> The virtual DTPM node descriptor is named after the RK3399 even though
> it does not contain any SoC-specific information.
> 
> Rename it to rockchip_virtual so it can be reused by other Rockchip SoC
> hierarchies.
> 
> No functional change intended.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
> Changes in v4 (since v3):
> - Rebase on v7.3; no code or commit-description changes.
> 
> Changes in v3 (since v2):
> - Rebase on v7.3-rc7 and refresh context after patch 4 style cleanup.
> - No functional changes.
> 
>   drivers/soc/rockchip/dtpm.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/rockchip/dtpm.c b/drivers/soc/rockchip/dtpm.c
> index 222d9098cc98..5ae00680602f 100644
> --- a/drivers/soc/rockchip/dtpm.c
> +++ b/drivers/soc/rockchip/dtpm.c
> @@ -11,7 +11,7 @@
>   #include <linux/of.h>
>   #include <linux/platform_device.h>
>   
> -static struct dtpm_node rk3399_virtual = {
> +static struct dtpm_node rockchip_virtual = {
>   	.type = DTPM_NODE_VIRTUAL,
>   };
>   
> @@ -33,12 +33,12 @@ static struct dtpm_node rk3399_gpu = {
>   static struct powercap_node rk3399_nodes[] __initdata = {
>   	[0] = {
>   		.name = "rk3399",
> -		.data = &rk3399_virtual,
> +		.data = &rockchip_virtual,
>   	},
>   	[1] = {
>   		.name = "package",
>   		.parent = &rk3399_nodes[0],
> -		.data = &rk3399_virtual,
> +		.data = &rockchip_virtual,
>   	},
>   	[2] = {
>   		.name = "cpu0-cpufreq",


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
