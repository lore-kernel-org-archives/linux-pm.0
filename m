Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984581;
	b=tAPqv+icg/WFoYFfKEwBy8N1OEtKDhY8KQMimasjTJTaw9DXML9yUXqAqsQomGJdQehK
	 f2MMeoduCLdkT0WhE6C5jFkMpjHWZ5yCuCSbdkbvCc4NI4vCdKpJzZQ8Gwj5Iy8jV9b0D
	 xs+iMMyC8GS5iY5FjuL4CxR1CqZ0+qnLovEBjBJsZaBjQ00/FhgG9+LvIVNBOY73cU5DX
	 MFOmhFA4ViH+3ogB/NEP9Lv2AIM1kDT4df48GSGDXwmPZZ/R4lZ3cBa4EeMBN6KzRYDzy
	 a2ZRizyGRfJNrjxKJctZa1JbAk7WaFnOKdmwrG8+9tbFXLHqryGOUX4QIReDgc0XFBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984581;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=cySMBrE2QBdv9vmQzigaERg7qPfpgxa8/2jg00Kn2eo=;
	b=US0HVtOflFwOM2ooXEWXaNIloyUxAqIo0w6xZ5w68QEOecgV2nHLeYQt63vPHigSqKlB
	 o9I+mxv/HaJ0i1va48f9L5mIk9HujluELH4RymbrBo+tBECFwKtsZGlWHDwJxPtp+xmOX
	 wqovCYaL+Tdm1lv9f2BLPbJEkORrQ/pS82CXD7KGsLp2qR8vUFZr40ckuQnR3EetQUzA1
	 kbSXYuE6nSrlUsuvVVLMaFVJlK6uMpMV/EyomxRl3QildPWURsEnxl8oGkxWFx3WzWQso
	 RXVVOP/FqRFDLADa1AGiaqGNbAcGC3pz4LJW7yZZ07gkxenxf8S4ZfoOh3F1Lk6IdUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DNTJbKo3;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAC6606A326;
	Fri,  6 Nov 2026 17:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FAC6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DNTJbKo3
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BD9115A1;
	Fri,  6 Nov 2026 09:02:57 -0800 (PST)
Received: from [10.57.68.162] (unknown [10.57.68.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 289CA3F673;
	Fri,  6 Nov 2026 09:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793984580; bh=b4nKFAyTKZb/XeIgj1L3cVf2VLczFRd4xjdAuz63LQg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DNTJbKo3gOQ09dHhOfylnMDlXI94aYoz2ZlLNMA11MN0s1bBduT+cYN9mXUFc4USc
	 eVzgmBxXCPi6p8BTj5PlqYarFV2rOaqL3wPuqINUEo0Vqc4QIcsE8qZbR4K6+R36+O
	 GT469Wkmr0gZ2iBv0AX0mY/zPOIIqsqhXpgkN/bE=
Message-ID: <5da74b0b-27f5-407b-931d-ecd6c6a1934f@arm.com>
Date: Fri, 6 Nov 2026 17:02:57 +0000
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
Subject: Re: [PATCH v1 1/2] cpufreq: Cache post-resolution target frequency in
 __resolve_freq()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Vincent Donnefort <vincent.donnefort@arm.com>
References: <5176274.31r3eYUQgx@rafael.j.wysocki>
 <14161745.uLZWGnKmhe@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <14161745.uLZWGnKmhe@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/26 15:04, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> get_next_freq() in the schedutil governor returns the resolved
> frequency from cpufreq_driver_resolve_freq(), and that resolved value
> is then passed to cpufreq_driver_fast_switch().  The only reader of
> cached_target_freq, acpi_cpufreq_fast_switch(), compares it with the
> post-resolution target frequency, but it holds the pre-resolution
> clamped frequency, so any request that falls between table entries
> misses the cache and falls back to a table scan.
> 
> Address this by making __resolve_freq() store the post-resolution
> frequency in cached_target_freq.
> 
> Fixes: e3c062360870 ("cpufreq: add cpufreq_driver_resolve_freq()")
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> ---
>  drivers/cpufreq/cpufreq.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -488,8 +488,8 @@ static unsigned int __resolve_freq(struc
>  
>  	idx = cpufreq_frequency_table_target(policy, target_freq, min, max, relation);
>  	policy->cached_resolved_idx = idx;
> -	policy->cached_target_freq = target_freq;
> -	return policy->freq_table[idx].frequency;
> +	policy->cached_target_freq = policy->freq_table[idx].frequency;
> +	return policy->cached_target_freq;
>  }
>  
>  /**
> 
> 
> 

