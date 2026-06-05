Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B9F4BCAB5;
	Fri,  5 Jun 2026 09:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650364; cv=none; b=eQaPSZhczbBFnqJyazxwJbX+/VStu5cQfWsDRBIrwPfY0fPxovap11f0XL1Yyx92+MWBlWl3C6JpPmY7crGhBwnq2p/bwrFfr+DV/IrKE8NSb+g3Nn0IXNdqHvVSldKw4eNqvQFuh+bxq61p0fD+8QIf6Os1/Z5sNcbgcSx/JZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650364; c=relaxed/simple;
	bh=MQ8RMr+sA/65OqRDZ4k+MqdUzcCiQH+pyjaKE1PlXWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Za/3zgrlCaDbmsSog4hZdM121aazM664K7lA1gHTmlkg49SJXSbxzty6m8wkSipsY8iEPB9vxyb2xTTzhQk27K1YxIFNGxh89Z/5bTDbIVKs7ArU3Iom4TjVAscFNkJxKS8CXRCn0Z9mO6JSDT+whqOoSrDl8UfpiYVTi0WBelw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcdAt2kE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcdAt2kE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449D61F00893;
	Fri,  5 Jun 2026 09:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780650359;
	bh=sJJhAg4PWCTaRcX8C397xf+tmwaDzx5IRuaMqyN4zYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lcdAt2kEMmrGkL+FX9F8igykf+TwdTI+VgyH6uOQ/UYhoKQupdlxtx1F5cyHTdw33
	 DLWYJN6GG/UrVaPb7zeiupgO/wtIbYELTXtAW65PkDf8wEFH+pQ+kFQgXQBieyheFr
	 SUASoaU/cMYd6Spj8d6EyYrWRL+W5izABxoJFvlr2opY8lOat+FWnPGPEHpWJUafB1
	 deccz+VV+YD0e4A6bayY8xkD7SunD4u8EKPInMiIHBie1DvQf+Ag41sebzOUCHLpyE
	 5TtUAj4wgmlSHM8xJ4pqO/EZznN20O1i1HjbAWE7e+cKRZ22oSsc8eVO48CMgwpSBh
	 XScghkPUt9WaA==
Date: Fri, 5 Jun 2026 11:05:49 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-perf-users@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>, Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 0/8] x86/msr: Drop 32-bit variants of *_on_cpu() MSR
 functions
Message-ID: <aiKRbRHyDCjmqvGB@gmail.com>
References: <20260605070826.2995913-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605070826.2995913-1-jgross@suse.com>


* Juergen Gross <jgross@suse.com> wrote:

> Drop the variants using 2 32-bit values instead of a single 64-bit one
> of the *_on_cpu() MSR access functions.
> 
> Juergen Gross (8):
>   x86/msr: Switch rdmsr_on_cpu() to return a 64-bit quantity
>   x86/msr: Switch all callers of rdmsrq_on_cpu() to use rdmsr_on_cpu()
>   x86/msr: Switch wrmsr_on_cpu() to use a 64-bit quantity
>   x86/msr: Switch all callers of wrmsrq_on_cpu() to use wrmsr_on_cpu()
>   x86/msr: Switch rdmsr_safe_on_cpu() to return a 64-bit quantity
>   x86/msr: Switch all callers of rdmsrq_safe_on_cpu() to use rdmsr_safe_on_cpu()
>   x86/msr: Switch wrmsr_safe_on_cpu() to use a 64-bit quantity
>   x86/msr: Switch all callers of wrmsrq_safe_on_cpu() to use  wrmsr_safe_on_cpu()

To sum up my review feedback for the invididual patches, we want
to do this instead:

  x86/msr: Convert rdmsrl_on_cpu() users to rdmsrq_on_cpu()
  x86/msr: Drop the rdmsrl_on_cpu() alias to rdmsrq_on_cpu()

  x86/msr: Switch all callers of rdmsr_on_cpu() to use rdmsrq_on_cpu()
  x86/msr: Remove the unused rdmsr_on_cpu() API

  x86/msr: Switch all callers of wrmsr_on_cpu() to use wrmsrq_on_cpu()
  x86/msr: Remove unused wrmsr_on_cpu() API

  x86/msr: Switch all callers of rdmsr_safe_on_cpu() to use rdmsrq_safe_on_cpu()
  x86/msr: Remove unused rdmsr_safe_on_cpu() API

  x86/msr: Switch all callers of wrmsr_safe_on_cpu() to use wrmsrq_safe_on_cpu()
  x86/mrs: Remove unused wrmsrq_safe_on_cpu() API

Note how there's no "conversion" of the 32-bit API itself in this
approach, we just do a straightforward migration of the users to
the already existing 64-bit APIs, then remove any unused APIs.

Thanks,

	Ingo
