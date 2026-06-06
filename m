Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562A94071D3;
	Sat,  6 Jun 2026 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780739494; cv=none; b=fLnhlCZVJT7XJ72Pd9IV1IQe2sSRrfqhcqCqGENAmP4QhwoORSY6tm4K4bccMkAbqlu4zxwEOjCgAAS0rv1r2FuHw3lrryrsvJWPu7TUUsFkAQbwmJmlgDBj1b7JvZxEKye6AK147kjiRG03ulPiqGemyqY9YPfC8xsJbddz3sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780739494; c=relaxed/simple;
	bh=yVi0RQy2fCZa0xIuE5UE/Yq1XXZPe4Vk/GKCO6smb+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUdVTd5SRVjQlYxhXgK3up/5JPz0nLe1Ww/10YkUunFyqgyRFtehtttURvXF5qT8MnNOAndji4eTkai3yVB1wWZ0z0JwyVbTV7u8TdwVYxJy4wrKKB8cKIjq0GzfElK8Nnj8WhaAhzaH5S3BIrLhLGjMdfwMsyA70/13s/lgEvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWVgT+oL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWVgT+oL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0723C1F00893;
	Sat,  6 Jun 2026 09:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780739493;
	bh=Krk4Rr3wfG6UXCFyTshqQSrzOALxRYf8/Ak3XSg2jH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SWVgT+oL7RSLWItjTTUwdLKMGq8d/yYe+l1TcmZD/OKAwkM3z+D7GqE4QNVfT1C2f
	 542xdt8iluDCkU1q4dq/rXSawqWqHjPPsqCp4LLAKdplPt9RxN6M42f9nBVpwghwxq
	 0GTHAYNWdPLUMx+4jB6lzgKaFPIeVM/83ixGYPIPuquqbNfehYQWIS6tPvsQsOY6XN
	 Ig5Vtd2CiHooQWxYw4vErdQmjgWNmdvC62jRgQSlGm10tgbPH+kmhQ+iNn1HWjk3/5
	 nu2FfxBDQu8g1sCMxbv6CNMocnenuo+xV0xblE1QaoEOMHA2GwmxYHI6FUnS2dTHBJ
	 8pyNtrLFFJJ4A==
Date: Sat, 6 Jun 2026 11:51:26 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH v2 07/10] x86/msr: Switch rdmsr_safe_on_cpu() users to
 rdmsrq_safe_on_cpu()
Message-ID: <aiPtnrkdHDHc0Iqz@gmail.com>
References: <20260605144314.3031049-1-jgross@suse.com>
 <20260605144314.3031049-8-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605144314.3031049-8-jgross@suse.com>


* Juergen Gross <jgross@suse.com> wrote:

> In order to prepare retiring rdmsr_safe_on_cpu() switch
> rdmsr_safe_on_cpu() users to rdmsrq_safe_on_cpu().

> --- a/arch/x86/lib/msr-smp.c
> +++ b/arch/x86/lib/msr-smp.c
> @@ -190,11 +190,22 @@ EXPORT_SYMBOL(wrmsrq_safe_on_cpu);
>  
>  int rdmsrq_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
>  {
> -	u32 low, high;
> +	struct msr_info_completion rv;
> +	call_single_data_t csd;
>  	int err;
>  
> -	err = rdmsr_safe_on_cpu(cpu, msr_no, &low, &high);
> -	*q = (u64)high << 32 | low;
> +	INIT_CSD(&csd, __rdmsr_safe_on_cpu, &rv);
> +
> +	memset(&rv, 0, sizeof(rv));
> +	init_completion(&rv.done);
> +	rv.msr.msr_no = msr_no;
> +
> +	err = smp_call_function_single_async(cpu, &csd);
> +	if (!err) {
> +		wait_for_completion(&rv.done);
> +		err = rv.msr.err;
> +	}
> +	*q = rv.msr.reg.q;

While technically this is another API user conversion,
I'd split this out into another preparatory patch,
because this changes the API itself.

Thanks,

	Ingo

