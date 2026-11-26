Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705666;
	b=mQRNDl38NH6+8wfcVShE3ItAIAxr+aCjIbnaBhBldlbcbGcqd06phAm4TidciWzRCZag
	 s6uYPu1X0k6Y7JHEhwPF6DjFVa68KoNhhT2YCVVEFcvhDNaD+Q8RWhldZjpR3BANrozJ5
	 0AJ9olEE7WjZCF+ZbdqutRQhylzqlpTrsOTniRmJDxhes5RjNs5VFsRlsbH6prURJNnC8
	 4IhTWoahMkVAv1pbngS5cID9LQruNmpYiM6swTOWw9Gafx110wY651SrJTrE71xPYui4q
	 lawOJX3F+xfigDxgUK5662ZNwhD2RJ8sLgOV7AU65sLUhsW833KnO8lQpdvs+fmtvxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705666;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=iVpQdKIKoWDEmtg2zRsII5emwSXKVoMhaTKYLIlBguo=;
	b=xAFZPCgxQdBhSriE0i2dGxOx+4J2b2d99NSBoTMFBcTNxoo9r1PVH0M1JDESK+4DeSXG
	 Iq0yb10a68XLE9rxvyAj4uFxhfLKbZzROraHZ1byrY0yyIZnyrgqDRffwnSCVfptr/6oa
	 WxnyXZ+cNXj5ehUBuCef1jRMJ12QtfkRlV7wZ5QD4p1VzlVDEzBC5Q9pGMl0jO04iAmwO
	 OkFOL2EV1bYg6hl0GBu9WVjqxu/P6ixofoP+vxTDLq9aNAlrMcFYIVJzeKhnRKOt1uR+B
	 5sh40lspTX7r7tnIT7J5fV0zPsGQfoOOl/pbC2tj1vOgxbL3N3Sg2k6tt0b70pb3iVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=avVWTwFp;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5695E606A32D;
	Thu, 26 Nov 2026 15:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5695E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=avVWTwFp
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAE301C2B;
	Thu, 26 Nov 2026 07:07:42 -0800 (PST)
Received: from [10.57.70.173] (unknown [10.57.70.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27DAD3F959;
	Thu, 26 Nov 2026 07:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795705665; bh=m3E4vw/vJFmaMzYQ1RtoDrnMIs9UwyPdq6ADGf8Cdqo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=avVWTwFpntk6oUErRtSNB/5XLCjo5NwTpnrRN4vA4XscKCafZ77tj4tJHKw7AzgNG
	 GrLQ7xsiwIjtadq7CwruKom3u0/f0mHhebRgNCbPfjuE0wgPmhrsifZLBAj9Wlg8BI
	 T0Pp7ZEBAeqAv1uZrTvd8HkniMRrxHgTfifHL1EM=
Message-ID: <18ac46e9-066d-45ee-a6ba-b1b9725a6c8a@arm.com>
Date: Thu, 26 Nov 2026 15:07:41 +0000
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
Subject: Re: [RFC PATCH] cpufreq: Keep global boost enabled after partial
 enable
To: Jiangtian Feng <jiangtianfeng@linux.alibaba.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ananthu C V <ananthu.cv@oss.qualcomm.com>,
 Pierre Gondois <pierre.gondois@arm.com>
References: <20261126110903.3747240-1-jiangtianfeng@linux.alibaba.com>
From: Christian Loehle <christian.loehle@arm.com>
Content-Language: en-US
In-Reply-To: <20261126110903.3747240-1-jiangtianfeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/26 11:08, Jiangtian Feng wrote:
> When global boost is enabled from the disabled state, a failure after
> one or more policies have been updated successfully currently restores
> the global flag to 0 without rolling back those policies. This leaves
> them locally enabled, with their boost-related driver/QoS updates
> retained, while the global flag rejects per-policy sysfs writes.
> 
> Keep the global flag enabled if at least one policy_set_boost() call
> succeeded, while preserving the existing error return path. Global
> boost = 1 grants permission to boost; it does not require every policy
> to have boost enabled. The mixed per-policy state is therefore valid
> and individual policies remain accessible through per-policy sysfs.
> 
> Retain global-state restoration for enable failures without a
> successful policy update, same-state resynchronization failures, and
> disable failures. Do not roll back earlier policy updates.
> 
> Qoder, an AI coding assistant, helped analyze the issue, develop the fix
> and state matrix, and draft this description.
> 
> Fixes: 218a06a79d9a ("cpufreq: Support per-policy performance boost")
> Signed-off-by: Jiangtian Feng <jiangtianfeng@linux.alibaba.com>

What's the RFC part for specifically?
FWIW I broadly agree with the direction of that patch.

> ---
> 
> Validation:
> - mainline ARM64 defconfig build of the complete Image
> - checkpatch.pl
> - eight-case old-global/request/success state matrix
> - independent static control-flow and locking review
> 
> NOT_RUN:
> - runtime fault injection or reproduction with multiple policies
> - global/local concurrency, hotplug, lockdep or KCSAN testing
> - CPPC, SW frequency-table, ACPI or AMD hardware frequency/QoS testing
> 
>  drivers/cpufreq/cpufreq.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 4332cb114070..f23b64c2e620 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2887,6 +2887,7 @@ static int cpufreq_boost_trigger_state(int state)
>  	struct cpufreq_policy *policy;
>  	unsigned long flags;
>  	bool boost_enabled;
> +	bool policy_success = false;
>  	int ret = -EOPNOTSUPP;
>  
>  	guard(mutex)(&cpufreq_boost_mutex);
> @@ -2911,6 +2912,8 @@ static int cpufreq_boost_trigger_state(int state)
>  		ret = policy_set_boost(policy, state);
>  		if (unlikely(ret))
>  			break;
> +
> +		policy_success = true;
>  	}
>  
>  	cpus_read_unlock();
> @@ -2918,10 +2921,15 @@ static int cpufreq_boost_trigger_state(int state)
>  	if (likely(!ret))
>  		return 0;
>  
> +	/* Keep partial enable usable and repairable through local sysfs. */
> +	if (state && !boost_enabled && policy_success)
> +		goto out_err;
> +
>  	write_lock_irqsave(&cpufreq_driver_lock, flags);
>  	cpufreq_driver->boost_enabled = boost_enabled;
>  	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>  
> +out_err:
>  	pr_err("%s: Cannot %s BOOST\n",
>  	       __func__, str_enable_disable(state));
>  

