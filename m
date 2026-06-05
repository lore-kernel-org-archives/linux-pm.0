Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B852BE7CD;
	Fri,  5 Jun 2026 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650056; cv=none; b=RUzmWTup0SPMIVShQZFBaSlSA9vOIWrzQ7f4/FQToiSlbjXuEJknGtqzad8O2UnVBZdh1C9cOjasyl3tH7/QO4ma+051hLS8KE12zFzvNzYgRuynv+nNqZsStd7VyOeKQmEYwLVQ90G+c1NCdr1YzV08ljoIm2rSF5YJ3iAdGKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650056; c=relaxed/simple;
	bh=vvbeSno2B62nJ2RcsNqfbBHuUaeRlC6mnSj9MhLBpr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyf6SXj+z0X2avCVPsneUHiXMUyVx16pQRkOFahC+LDYD3hVBcJeOfuOJAgaoityLBIrLFHR6VykepJnXCmybscfa1xtSl2YsCNres85q+Fp8nr9AX6BhOM+VRCi9T9B0dI7g/JbvNeM9Dhhh/JXnkrhOdLU8Z0x4ZwRkx/6AS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0oNyScv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0oNyScv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A981F00893;
	Fri,  5 Jun 2026 09:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780650054;
	bh=D+bFvygL+Ug0LUoxpqEMhPDg5pAL7NiWhYFZYkPBBec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k0oNyScvFtXfG/NIp92ANnwVba5/Shc5Vc3Jn1xWbtTHI9JIbV+cSW9sGekVZWGVx
	 FKm7bQsQsqp0PKdErjgJEQsOrSzBsLtv6cC/ODhyinYEQO39ff/hDhhK79bCFgkcKw
	 hBesLqbYDcU9BUH0ZWbbF7bybY+VvYUMkbo3cilZ3uW9iRuWcwYPPpKlfhZC6qyiTK
	 qArb5XKm8tSzLlR0Im8pxnuxGoRi3qRtRYjr3z3COAvAw+tkT7BHDhBUMVBAcfCzFR
	 1qNwbRzoYiX4Smk2bupUbO3FtWmP6L+2rLsz1CHe8uQ1dXVip4Ok8IKP1ceu5dihMd
	 5I2OB3neqmZmQ==
Date: Fri, 5 Jun 2026 11:00:46 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>, Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 2/8] x86/msr: Switch all callers of rdmsrq_on_cpu() to
 use rdmsr_on_cpu()
Message-ID: <aiKQPpGUkDWTQfPo@gmail.com>
References: <20260605070826.2995913-1-jgross@suse.com>
 <20260605070826.2995913-3-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605070826.2995913-3-jgross@suse.com>


* Juergen Gross <jgross@suse.com> wrote:

> Now that rdmsr_on_cpu() has the same interface as rdmsrq_on_cpu(), the
> callers of rdmsrq_on_cpu() can be switched to rdmsr_on_cpu() and
> rdmsrq_on_cpu() can be removed.
> 
> At the same time switch the only user of rdmsrl_on_cpu() to
> rdmsr_on_cpu() and drop rdmsrl_on_cpu(), too.

So instead of:

  x86/msr: Switch rdmsr_on_cpu() to return a 64-bit quantity
  x86/msr: Switch all callers of rdmsrq_on_cpu() to use rdmsr_on_cpu()

We want something like this:

  x86/msr: Convert rdmsrl_on_cpu() users to rdmsrq_on_cpu()
  x86/msr: Drop the rdmsrl_on_cpu() alias to rdmsrq_on_cpu()
  x86/msr: Switch all callers of rdmsr_on_cpu() to use rdmsrq_on_cpu()
  x86/msr: Drop the obsolete rdmsr_on_cpu() API

Patch #1-#2 can be a single patch I guess, since there's only
a single user.

Thanks,

	Ingo
