Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C912BEC2C;
	Mon, 20 Jul 2026 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784574113; cv=none; b=at8Qv1fFenPZFbCN2ZDKfCFrhBn55F8dphthExgubSMx76fzWZQetSJHPV71Y3DYbIJOWrDa/UWZ/ZvcpS0tgN/eYGCqAn8TyP6uaDWpMS3YEcED64MmnlkbY9Hm+aeLHVG2goTaCeoHDqmmkcEGC0cXRrMqphs+uIosu9XIF7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784574113; c=relaxed/simple;
	bh=ZZ/sqpoAZBc5LVKp/7yXcmiDwNH8uJaRmdlO645n07A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1MxyssIs0FWTpYir2dNJPTn/4dsyeoP+tZ+AeXPSeYDr3XMTcYoXM82cUG7cfho7Xv+CTzZhbngDtSxdQnMwuKHtenG5nn58tWLrJ4kUYbWW1+yflLe1aUEC1wKfwWDyuaZ1WhmwOkfLZhGzjlNCPP3Fjjw5m2H7GjSOgftDWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xcc8fVKF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xcc8fVKF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF4C1F000E9;
	Mon, 20 Jul 2026 19:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784574112;
	bh=uEHlLDkK5rkivUu8706eDnB9C5bcKVgdYUNU7PZAd9M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Xcc8fVKFpldcqbgB61TxfWOqHbiz60qrfHY1Ok8NMDWzlUxN4CNu6ovm/lM/a3wsy
	 W5waHO+6oaPYrmssP1ntYniJKXmCIzFUB8OSogtD409jgppadG+8QizwENj5Fc6/Vu
	 MTn83/yaLpVlXNS4AlWrEiLrkb8mb5pIH0kg15DkPz4lAt8FFkIAYpXRn/EcuCqwAy
	 S9IFEfEs/KNMeBsd4B1p5XhU2qGxui1YsiR6nZS2sJcXsZUY9y7wp8PSYklA3O+Zdx
	 Cp6BaGK9HDc02pPovaxrYHWsrFxitvFEC7b1EHcylSV4q+kLuH4q1JJE7DYQ0jf1RM
	 EtEOE1WYRE8Tw==
Message-ID: <c357ccea-4eb7-4493-b148-280aceffc24d@kernel.org>
Date: Mon, 20 Jul 2026 14:01:50 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpufreq/amd-pstate: Bail out early if
 !X86_FEATURE_HW_PSTATE
To: Rong Zhang <i@rong.moe>, Huang Rui <ray.huang@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>,
 Jason Andryuk <jason.andryuk@amd.com>
Cc: Michael Kelley <mhklinux@outlook.com>,
 Michael Kelley <mhklkml@zohomail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260721-amd-pstate-vm-v3-1-8b59574fb714@rong.moe>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260721-amd-pstate-vm-v3-1-8b59574fb714@rong.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/20/26 13:47, Rong Zhang wrote:
> When booting a VM that simulates or passes-through a relatively new CPU
> model, these warning messages are printed to kmsg:
> 
>      amd_pstate: The CPPC feature is supported but currently disabled by the BIOS.
>      Please enable it if your BIOS has the CPPC option.
>      amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled
> 
> Technically the check is not wrong and acts as a safetynet that prevents
> the driver from being registered incorrectly, but the warning messages
> are noisy and incorrect, as the CPPC feature is neither supported in a
> VM nor disabled by the VM's BIOS.
> 
> The CPPC feature is disabled by the hypervisor as it makes no sense to
> expose them to guests. It creates a paradox that the same kernel both
> disables CPPC as a hypervisor (KVM) and warns about it being disabled
> as a guest.
> 
> X86_FEATURE_HW_PSTATE indicates if the processor supports frequency
> scaling or not. It is disabled on virtualized platforms (namely, KVM and
> Hyper-V have been reported to do so) and is always set on physical
> platforms that support frequency scaling.
> 
> Check for X86_FEATURE_HW_PSTATE as a prerequisite and bail out early if
> it's unsupported. A debug message is also added to help debug driver
> loading issues.
> 
> Fixes: cb817ec6673b ("cpufreq: amd-pstate: show CPPC debug message if CPPC is not supported")
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
Acked-by: Mario Limonciello (AMD) <superm1@kernel.org>

I'll get this picked up this week.

> Changes in v3:
> - Move the check into amd_cppc_supported() and add a pr_debug_once()
>    message (thanks K Prateek Nayak and Mario Limonciello)
>    - The check is added before the existing family 17h model 0h-2Fh one,
>      as print_cpu_info() already shows family, model, and stepping, and
>      will help debugging even if the new check overrides the existing
>      one, but not vice versa
> - Link to v2: https://patch.msgid.link/20260718-amd-pstate-vm-v2-1-6ed5f3b2c89e@rong.moe
> 
> Changes in v2:
> - Check for X86_FEATURE_HW_PSTATE instead of X86_FEATURE_HYPERVISOR
>    (thanks K Prateek Nayak)
> - Remove the check against Xen dom0, as it doesn't need the amd-pstate
>    driver (thanks Jason Andryuk)
> - Reword comments and the commit message
> - Remove Gautham R. Shenoy from the To list due to email bounces
> - Link to v1: https://patch.msgid.link/20260716-amd-pstate-vm-v1-1-2ac97d3cf6e7@rong.moe
> ---
>   drivers/cpufreq/amd-pstate.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index a74a4cf99d22..b0b651380732 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -2167,6 +2167,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>   };
>   
>   /*
> + * Processors without frequency scaling support can't do CPPC.
>    * CPPC function is not supported for family ID 17H with model_ID ranging from 0x10 to 0x2F.
>    * show the debug message that helps to check if the CPU has CPPC support for loading issue.
>    */
> @@ -2175,6 +2176,11 @@ static bool amd_cppc_supported(void)
>   	struct cpuinfo_x86 *c = &cpu_data(0);
>   	bool warn = false;
>   
> +	if (!cpu_feature_enabled(X86_FEATURE_HW_PSTATE)) {
> +		pr_debug_once("frequency scaling is not supported by the processor\n");
> +		return false;
> +	}
> +
>   	if ((boot_cpu_data.x86 == 0x17) && (boot_cpu_data.x86_model < 0x30)) {
>   		pr_debug_once("CPPC feature is not supported by the processor\n");
>   		return false;
> 
> ---
> base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
> change-id: 1cc24037-amd-pstate-vm-d6ab4c959bd3
> 
> Thanks,
> Rong
> 

