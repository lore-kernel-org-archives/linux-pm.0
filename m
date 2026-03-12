Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE15374E44;
	Thu, 12 Mar 2026 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349179; cv=none; b=dbRl3sXWLHhoCMftOeYg/z3Rq6/XapExZXZ61Et7PTvV388v2Zd46rNbBsRqGRtYHBQMwRtvCD8MV5EwfTIt0E8bxD3+3LfEldbSEy5NUxbXlWLcw4ppPwd/4X4DqtoATIAtpl55muH6Tt7IOELcNT5XV6KYfFdPE6Aij3Gbkzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349179; c=relaxed/simple;
	bh=S8oc0n+2PMcBiWyh2gjTmlNW28t+05cG4Lqv5HRCox8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJqwY7dPn3I2QdL0RL7c5ggNAJP7rXZgkuzwH0DxAAyffmKvuOcOWuNnibJtGq5IguniKx1BTjsYG5x00l52D/r46hvSwt7anGz5QSJTbBu/6er02vf1U7PANGnWALfH8ydUruG47c/1ejKa1snF4jQo68Cnzm2Mk/zr6w+LFjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6ncqTab; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6ncqTab"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7269BC4CEF7;
	Thu, 12 Mar 2026 20:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773349179;
	bh=S8oc0n+2PMcBiWyh2gjTmlNW28t+05cG4Lqv5HRCox8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s6ncqTabD8QpUoXiuEsR68wI3wQ/gd2qONWUW/F0gjDqvlwV7DSYWIBmule24OVgD
	 YTJcWm807VvYwaI0du844Naa7px/3t8NmWsbTKtcjBb37sPIJPVUx6bPuYq5WO7LAp
	 Q6lnWUnjBVrxxzInoxtBTli4qlM+505y2IicDRXvlqLhnmWNIUhLIREO5sSzGCkglS
	 iBpepnaR0GltQTdBeJfnFbq1CCwzGzNd3NUQxSsLGm5CQT8kDwLGwaLn3AET0Q4J9u
	 Mb0Jv/MEub15aWDKXXFNHvtPh2Z0pJVbhW/h7Ripb4E+v/QvVdKlwUcKKJIlepor8U
	 ANC9bQ7qycFVg==
Message-ID: <0afb773d-e971-4129-8246-790ec840699e@kernel.org>
Date: Thu, 12 Mar 2026 15:59:37 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] Documentation/amd-pstate: Add documentation for
 amd_pstate_floor_{freq,count}
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
References: <20260311140116.19604-1-gautham.shenoy@amd.com>
 <20260311140116.19604-10-gautham.shenoy@amd.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20260311140116.19604-10-gautham.shenoy@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/11/2026 9:01 AM, Gautham R. Shenoy wrote:
> Add documentation for the sysfs files
> /sys/devices/system/cpu/cpufreq/policy*/amd_pstate_floor_freq
> and
> /sys/devices/system/cpu/cpufreq/policy*/amd_pstate_floor_count.
> 
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   Documentation/admin-guide/pm/amd-pstate.rst | 32 +++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index f566fea6613e6..5fd2a36f8a4b8 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -242,6 +242,8 @@ control its functionality at the system level. They are located in the
>    /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_hw_prefcore
>    /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_lowest_nonlinear_freq
>    /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_max_freq
> + /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_floor_freq
> + /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_floor_count
>    /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_prefcore_ranking
>   
>   
> @@ -278,6 +280,36 @@ can change at runtime based on platform conditions. This attribute is
>   read-only.  This file is only visible on platforms which support the
>   preferred core feature.
>   
> +``amd_pstate_floor_freq``
> +
> +The floor frequency associated with each CPU. Userspace can write any
> +value between ``cpuinfo_min_freq`` and ``scaling_max_freq`` into this
> +file. When the system is under power or thermal constraints, the
> +platform firmware will attempt to throttle the CPU frequency to the
> +value specified in ``amd_pstate_floor_freq`` before throttling it
> +further. This allows userspace to specify different floor frequencies
> +to different CPUs. For optimal results, threads of the same core
> +should have the same floor frequency value. This file is only visible
> +on platforms that support the CPPC Performance Priority feature.
> +
> +
> +``amd_pstate_floor_count``
> +
> +The number of distinct Floor Performance levels supported by the
> +platform. For example, if this value is 2, then the number of unique
> +values obtained from the command ``cat
> +/sys/devices/system/cpu/cpufreq/policy*/amd_pstate_floor_freq |
> +sort -n | uniq`` should be at most this number for the behavior
> +described in ``amd_pstate_floor_freq`` to take effect. A zero value
> +implies that the platform supports unlimited floor performance levels.
> +This file is only visible on platforms that support the CPPC
> +Performance Priority feature.
> +
> +**Note**: When ``amd_pstate_floor_count`` is non-zero, the frequency to
> +which the CPU is throttled under power or thermal constraints is
> +undefined when the number of unique values of ``amd_pstate_floor_freq``
> +across all CPUs in the system exceeds ``amd_pstate_floor_count``.
> +
>   ``energy_performance_available_preferences``
>   
>   A list of all the supported EPP preferences that could be used for

