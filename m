Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9CB409627;
	Tue, 26 May 2026 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807852; cv=none; b=fzlt2b9UViPZ5u9oCwxUPGgutYlWOfUjspjSBFlGjLWwIJ6x4uu0Cy2kZPdoVBU7+ZzSBryMFcZrzwzXmWvHsDilVQV5WII8pKkBj6D4jxv6NTUqQX6LtcNDdvJ2+qzMdWTpqZVKVVbpCNuoI1xyrjJT0tnSrSmPXEGvQFlZwbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807852; c=relaxed/simple;
	bh=ghBBPmfAMZD0FXV9IlYCHCzN1y7DPGx8BiE3fwMjzZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KQWgG6PVnc6Sraz7QRQtzvqoZn79R8nPFKcczQ+d55pBd1n9BOA+xzcwVoK3xmbsAv4zxXNK6IUZ5hZFZhMD6vlPmLT7zOpaZNi499LyYN+zrvhk/5z7SOHqy9zA9rZcA3gEq5Mvk9zmFjJuI6mr0C0RTkxtcNwdqOyAL3GTGVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5SodGf5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5SodGf5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5FE1F000E9;
	Tue, 26 May 2026 15:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779807850;
	bh=+UubJixd5g6siAFU7WLRUGTaRVftZ7Wg+nGMvljRVI0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=f5SodGf5bcm+DA3a4oH2e8QJTAAGc5Eh1Aq+xHTCZZhDSOwrMAkalam8/17RspxTp
	 WBoJxlqvLpMTBFcKdgQ8N7/iQzr6SDSNCOfZwfHWwocHXR0tJ4VXiBMRxmFm2ZmT7p
	 Xrl10oDnY5nqY+3cJ1PdsC4uZTkLZMQoXhS2BD6JvjJBNv4EAsKTPx4SfJIla+HrgT
	 pCdp6U0GnnVGtw0ekfL+6gLwVJaRQ5xst57QyHEjwa1d0jDJTBIBlHvoebp/37jAJ/
	 rrHX6P6Nn3oHiV2jQm2bQq8d3ndaKmqMrx9OiiJ4/Hm4UAaxsYpUBO14nLQzUKNDMx
	 AkMIGmlfSUekw==
Message-ID: <89fecc75-1eac-4caa-b8a4-805dda2dd940@kernel.org>
Date: Tue, 26 May 2026 16:04:03 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: drop stale @epp_cached kdoc
Content-Language: en-US
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>
References: <20260526022131.1302373-1-zhanxusheng@xiaomi.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260526022131.1302373-1-zhanxusheng@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/26/26 03:21, Zhan Xusheng wrote:
> Commit 4e16c1175238 ("cpufreq/amd-pstate: Stop caching EPP") removed
> the epp_cached field from struct amd_cpudata in favour of always
> reading from cppc_req_cached, but the kdoc above the struct still
> documents @epp_cached.
> 
> Drop the now-stale @epp_cached entry.
> 
> Fixes: 4e16c1175238 ("cpufreq/amd-pstate: Stop caching EPP")
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Also added to my tree.

>   drivers/cpufreq/amd-pstate.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index e4722e54387b..23e8baa05849 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -84,7 +84,6 @@ struct amd_aperf_mperf {
>    * @hw_prefcore: check whether HW supports preferred core featue.
>    * 		  Only when hw_prefcore and early prefcore param are true,
>    * 		  AMD P-State driver supports preferred core featue.
> - * @epp_cached: Cached CPPC energy-performance preference value
>    * @policy: Cpufreq policy value
>    * @suspended: If CPU core if offlined
>    * @epp_default_ac: Default EPP value for AC power source

