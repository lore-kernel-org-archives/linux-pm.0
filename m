Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1B448C417;
	Fri,  5 Jun 2026 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780649136; cv=none; b=GBBogjTDT7Nh/XWjxwJZ8cppvX8sO9bykwNsH3Yo719Tk3IICLzJE3rJMx+9yBrirs6T6OGq67KH5dWKx9JX/27HN85KPxaCJcdo//uX03kGxm2cR9y6ummw+rK120kcD/LvsQUHL5tozLUlfgLy7k/cyUwulzEUqg1zvrJzIHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780649136; c=relaxed/simple;
	bh=OOKHrCamVzEbHi6+XFUoPPOKZgaOuApb46EKTp5fVEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUvk+FySR6jZ8O01ZXRzwCVPgaLv5736Qgyqr7Rju7WkgZXO9BqnoRuJm4Sp+hU8Mamq0ZJmBa9KVxKiG9TkliRLccPaHNaE6VsJcZUCyThMvWQegWLxGNrS7ahPoNJoCup9WaDlZ1o4ms/muaT0t/5SL+iruAebRSfXNe2B8Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2RvNuu4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2RvNuu4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6798E1F00898;
	Fri,  5 Jun 2026 08:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780649134;
	bh=hzbpTcp/XRtlHpOpHICxcowF4VJ6ElZzNchcOA/cyfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E2RvNuu4ouHTKg9UJXX/m5aqCsDM1pH4r/c2BiBgVRQyfTqLkLFPWYChQHAR7p3JM
	 EPWQKgPIyI6z0g2doWUEWD+MAcFidyl1Li93oXr9mmN5T3IIJu03i/+FEME91Ra/6X
	 OtP7pqiR1KkmoWj40aNpGgbKEZc9HoX/xWhT01PC8/1n6IgGEyIihdIySzaoprX5A7
	 iwsTJktArkvFf0+be1NZH5CAk/XWf5ALgupV4fwEDMra2yUM2ZsuRb0Hi7m4UEdV3F
	 2Rgtzt8HzgF9q3JMN7li4XM1+kG4gWFQM1knrYeH2nltVcRHZaDxAOHl+q8DhZzhoJ
	 AYVkFc89dPP2A==
Date: Fri, 5 Jun 2026 10:45:26 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-acpi@vger.kernel.org,
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
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 6/8] x86/msr: Switch all callers of rdmsrq_safe_on_cpu()
 to use rdmsr_safe_on_cpu()
Message-ID: <aiKMpilpXBj75rfx@gmail.com>
References: <20260605070826.2995913-1-jgross@suse.com>
 <20260605070826.2995913-7-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605070826.2995913-7-jgross@suse.com>


* Juergen Gross <jgross@suse.com> wrote:

> Now that rdmsr_safe_on_cpu() has the same interface as
> rdmsrq_safe_on_cpu(), the callers of rdmsrq_safe_on_cpu() can be
> switched to rdmsr_safe_on_cpu() and rdmsrq_safe_on_cpu() can be
> removed.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Similarly to the other patches, this should be split into two
patches as well.

Thanks,

	Ingo
