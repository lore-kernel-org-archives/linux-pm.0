Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C4E3E317F;
	Fri,  5 Jun 2026 09:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653398; cv=none; b=NdUweVl3oIbJ1TIYzibydTx+Wkc0mONJLWmUauLq0oRE9Q3Rui+LXNWtVZARdVk7aex0zPbuIwhaF7tHpuose2D/XPRnjJLnRJFGye3tSAIPz14OOCOtx/MkGtygxWh9HoTnSvPO7DJxPdbsJdWeATu19IXKPUU10dWuKxh+P+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653398; c=relaxed/simple;
	bh=8H9wKx8dX+figccFR5stRhiGN7VkGAlYossHDGGegbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBdfuXgUB0gzTqrliT6gls2up2xX1mj0xNEkNL8Umy5KPJRR0zds2+edL0Kf9AhIDEYRQsYOInMYzSEYuxmtwRfjw+FZT1twRLnUr7CFi2dYPOrYD6fkCVcmhY3fGeTlJcCW25sKuOVEItgz7MmO5q4BL1G1HM5PX+zJa0qNt6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWTWaD5U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWTWaD5U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E531F00893;
	Fri,  5 Jun 2026 09:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780653394;
	bh=rBm+sJBFfKQ0leM+vzL2fC/5FBNBaXDvMZmqXAxdLgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fWTWaD5UKYA8ZBiMMzBnwQnsCEEbZRqWjY8KkeV8T55z4oMapSdIGT8x55ANdZcfO
	 yeaSGfCP1KVRCkHKOKBUiVJu7aE+EeLsz01uJAN+AT9mPY4F9XbZ4yq6NB36FtzwF3
	 SH72fK3lkOYuBLTY24KZNPoiXxB1IV3k+HrEsmsLJ+FUmWWrJ2MIIcerWYLEnKS0N4
	 7rPn14xyfZII3BBI9MjSfPQV5BVauGP1ySggA48HhQ8zAVNPB32a31GlwNg6eWPkvI
	 5KnwoaCdBy1gDKoOD//KuccY8zHarlc7miybJmBPZXeQMm7vGKP3BqD3UULw/HPP2F
	 d4oLewzRl1yuA==
Date: Fri, 5 Jun 2026 11:56:24 +0200
From: Ingo Molnar <mingo@kernel.org>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
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
Message-ID: <aiKdSPS-YT6KZV81@gmail.com>
References: <20260605070826.2995913-1-jgross@suse.com>
 <aiKRbRHyDCjmqvGB@gmail.com>
 <a477aefe-e1c8-4652-b263-86c4cce09eba@suse.com>
 <aiKUenaT9VD0DrpW@gmail.com>
 <b7e799a6-1f1a-49ef-8aac-0d5fd4a06dc7@suse.com>
 <aiKcz6I8GO-TG8uq@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiKcz6I8GO-TG8uq@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Jürgen Groß <jgross@suse.com> wrote:
> 
> > > Well, we had a similar discussion back when we standardized on
> > > rdmsrq() and wrmsrq(), and we use them as our primary 64-bit
> > > MSR handling APIs. Why have a different pattern in any of the
> > > derived APIs? It should really use the same conceptual namespace,
> > > not some confusing mixture of two naming schemes.
> > 
> > In the long run I'd like to do the same conversion for the rdmsr*() and
> > wrmsr*() interfaces, too (so only offering and using the 64-bit variants).
> 
> Why? We had this discussion for the original MSR API namespace
> cleanup a year ago, and decided to standardize on the rdmsrq()/wrmsrq()
> namespace:
> 
>   c435e608cf59 x86/msr: Rename 'rdmsrl()' to 'rdmsrq()'
>   78255eb23973 x86/msr: Rename 'wrmsrl()' to 'wrmsrq()'
>   6fe22abacd40 x86/msr: Rename 'rdmsrl_safe()' to 'rdmsrq_safe()'
>   6fa17efe4544 x86/msr: Rename 'wrmsrl_safe()' to 'wrmsrq_safe()'
>   5e404cb7ac4c x86/msr: Rename 'rdmsrl_safe_on_cpu()' to 'rdmsrq_safe_on_cpu()'
>   27a23a544a55 x86/msr: Rename 'wrmsrl_safe_on_cpu()' to 'wrmsrq_safe_on_cpu()'
>   d7484babd2c4 x86/msr: Rename 'rdmsrl_on_cpu()' to 'rdmsrq_on_cpu()'
>   c895ecdab2e4 x86/msr: Rename 'wrmsrl_on_cpu()' to 'wrmsrq_on_cpu()'
>   ebe29309c4d2 x86/msr: Rename 'mce_rdmsrl()' to 'mce_rdmsrq()'
>   8e44e83f57c3 x86/msr: Rename 'mce_wrmsrl()' to 'mce_wrmsrq()'
>   e2b8af0c6939 x86/msr: Rename 'rdmsrl_amd_safe()' to 'rdmsrq_amd_safe()'
>   604d15d15ebd x86/msr: Rename 'wrmsrl_amd_safe()' to 'wrmsrq_amd_safe()'
>   7cbc2ba7c107 x86/msr: Rename 'native_wrmsrl()' to 'native_wrmsrq()'
>   eef476f15c83 x86/msr: Rename 'wrmsrl_cstar()' to 'wrmsrq_cstar()'
> 
> There's several good reasons to use the 'q' suffix in the API names,
> why relitigate this? :-)

And just to be clear: I have no objections whatsoever to
phasing out all the old 32-bit APIs, like your series does.

Thanks,

	Ingo
