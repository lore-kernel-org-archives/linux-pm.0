Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E1634A76F;
	Tue, 28 Jul 2026 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785251195; cv=none; b=YWcVyfhUwebt68KNABqfbozFY4bAlQ+2Va9QHNeh29Hr6fAxNlzcXK+5iYslwHx2Al7XAlvzV8aKMJi698LDVuaN3P6uc3RUuSwVThLE+pY4DvVxxuesrrqXwhp9BMrH3MhnifQPda4N4adqDhUzmtv/a8xWKqUJeYyOvAI5Plw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785251195; c=relaxed/simple;
	bh=xeX1TVUQBAd4eMINZ/oGbSI/TJjybrDMwSdKwYC7Q7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GiZ8MG1prs0KjFmvMDIZBjY0uQv94LNI8kNuqcv9/jlmytJyefY6EY8fcSbHKby4zdtBB2agW9UtZCy9bgXBo3JTIyUPZc0hScCRJF72D0N5oYhK5kGvPKv1YAXizajM5rjICqPDrkybhN+cuuhAA/UwRFo8b5LUO1i8MQ7gwVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOB/DEPh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOB/DEPh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1961F000E9;
	Tue, 28 Jul 2026 15:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785251194;
	bh=cH6ws+Quhn6KX/TnsX/JV2tCldI0dP/OZQEBKMVk68U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KOB/DEPhTK8qMIxetNecZ1BjBLDWVoXrSkCWkpZOrrUhFRN2Zmo8OXBDRAP5VkC7C
	 fqp+oWdvisVg1H3ihHn14YuoqzsCo+mr2TamRPM/xHYMSHYwAAaZg6uA45VoLlBRxl
	 OpDRQoQQe1T/gKyzgWWah8r6zX8JUUK4UcAprz32EJkf5mef3wQlSzIe385XXhiwBR
	 fEKWsosLZ9dEeS5vJu1chq/M+yquD7wZV/MNzXJc/OFYjJ4Q1x4EYbkB0HMmoqMlfh
	 bu66iwhl/vdHkA3BLeA+tY/CE36a8Hqh8cGhRKvXFC/xE9rm732shw1KBYSybH+YW2
	 IzPvKxm4GK6Og==
Message-ID: <6922d983-d1da-45fe-b402-7de54ce2f180@kernel.org>
Date: Tue, 28 Jul 2026 10:06:32 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] cpufreq/amd-pstate: Document missing kernel-doc
 members
Content-Language: en-US
To: David Vernet <void@manifault.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Changwoo Min <changwoo@igalia.com>
References: <20260728073150.54964-1-void@manifault.com>
 <20260728073150.54964-2-void@manifault.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260728073150.54964-2-void@manifault.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/28/26 02:31, David Vernet wrote:
> kernel-doc warns about five undescribed members in amd-pstate.h:
> union perf_cached's @val and struct amd_cpudata's @raw_epp,
> @current_profile, @ppdev and @profile_name. Describe them.
> 
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>   drivers/cpufreq/amd-pstate.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index 23e8baa05849..99532595150e 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -32,6 +32,7 @@
>    * @min_limit_perf: Cached value of the performance corresponding to policy->min
>    * @max_limit_perf: Cached value of the performance corresponding to policy->max
>    * @bios_min_perf: Cached perf value corresponding to the "Requested CPU Min Frequency" BIOS option
> + * @val: Raw 64-bit value for atomic access via READ_ONCE()/WRITE_ONCE()
>    */
>   union perf_cached {
>   	struct {
> @@ -89,7 +90,12 @@ struct amd_aperf_mperf {
>    * @epp_default_ac: Default EPP value for AC power source
>    * @epp_default_dc: Default EPP value for DC power source
>    * @dynamic_epp: Whether dynamic EPP is enabled
> + * @raw_epp: Whether the last EPP write was a raw numeric value rather than a
> + *	     named preference
>    * @power_nb: Notifier block for power events
> + * @current_profile: Currently selected platform profile option
> + * @ppdev: Device registered with the platform profile handler
> + * @profile_name: Name under which @ppdev is registered
>    *
>    * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
>    * represents all the attributes and goals that AMD P-State requests at runtime.

Thanks!

This is a pure doc fix.  I'll pick it up from the series to include in 
my 7.3 PR later this week.

Acked-by: Mario Limonciello (AMD) <superm1@kernel.org>
