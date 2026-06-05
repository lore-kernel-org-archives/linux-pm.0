Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0102B3DA5AF;
	Fri,  5 Jun 2026 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780649037; cv=none; b=C8NUYS11loReblI5cdM41bPuxzFhZlrDkpudyFXad4kHfyUm7pXcoSWh/n7G3Fk7LASfsO+drsyiGSPmcXsZlENDtSxnLPBmM1rUKz8UJcF5MaCI/HRvCm130sxOpyyhzrkfa/PlFg1c6aTGifmp8EOKccCMwVJmaoFirN1Soak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780649037; c=relaxed/simple;
	bh=5kY0SdNOLkD/upRiu9I4ZSPEc5KcN5sQY5h0qbPKDt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhh7gdVq5+wejWR48HiSvK5mpgYNsm7V0SLrdcei/zhJRCV0yuoCDBOtAjzP5ZE3EwZD1XXrsB8YCPzXRkak5a3FePkbJN0YsTWSnwY5Qynx7dtinyZtTORREycrvUvc4WcziY8cgAIo6uddYoomIwElfe+pbInnNoVfhIWDUtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5lwmU8k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5lwmU8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC6A1F00893;
	Fri,  5 Jun 2026 08:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780649030;
	bh=i+hW4ytAOigS4mfiRcAysHWhzYMzhB9lMl5JVvtlgA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R5lwmU8ktC9qf+AOWY6fRx7QgE6WoOKWyKzB5G5e5VY3snqB7PY7T0FfHJg/No2+2
	 vccltlh6WFpZQhbHGQ0DGJMW92L0J/NUVJmPUTgVDXQooLdWlVWuvJoxI033TG3cky
	 gibi5eUlbP1DOwuUxVfEyx2+AvOAmJCgAEDrmD45nf0on3msYR+FCfgZVFO0SEHO7A
	 yqTXS8NQOeDZdIUAFK4Q4qFJVpr7Gjo5JBempsnfSSfpsOUbNPeKDax3PXeWVCrQJE
	 puCmY0hzVErHOnG5UDbeV8aHadsiP+JPJ8x0Z7BYq7SSY55o9Aprztnz2dxYcu0RCp
	 QQEuYl6XzmUww==
Date: Fri, 5 Jun 2026 10:43:42 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
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
Subject: Re: [PATCH 8/8] x86/msr: Switch all callers of wrmsrq_safe_on_cpu()
 to use wrmsr_safe_on_cpu()
Message-ID: <aiKMPrRq8MFa__23@gmail.com>
References: <20260605070826.2995913-1-jgross@suse.com>
 <20260605070826.2995913-9-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605070826.2995913-9-jgross@suse.com>


* Juergen Gross <jgross@suse.com> wrote:

> Now that wrmsr_safe_on_cpu() has the same interface as
> wrmsrq_safe_on_cpu(), the callers of wrmsrq_safe_on_cpu() can be
> switched to wrmsr_safe_on_cpu() and wrmsrq_safe_on_cpu() can be
> removed.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/include/asm/msr.h                       |  5 -----
>  arch/x86/kernel/acpi/cppc.c                      |  2 +-
>  arch/x86/lib/msr-smp.c                           | 16 ----------------
>  drivers/cpufreq/amd-pstate.c                     |  2 +-
>  .../x86/intel/speed_select_if/isst_if_common.c   |  9 ++++-----
>  5 files changed, 6 insertions(+), 28 deletions(-)

Please split this into two patches: one that does the API
change only, and one that removes the now obsolete definitions.

Thanks,

	Ingo
