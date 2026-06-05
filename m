Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A3047D94B;
	Fri,  5 Jun 2026 08:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780649825; cv=none; b=TfPeufOPCgo9+scDgN/T1guU0C7pdWA4j1hMvGmsZbJv0ksK8dZkstbYEzQx6C6oPRs0Mg/H0RP4HDtKLqjC6bNrRStLBSIEPFMadJcMWyMTCsVpYFbpBiaJFDenfujbowkvAM5R9UPu2di+/PZ0Sxo1OARIRankNoiWprZcKec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780649825; c=relaxed/simple;
	bh=PTua+F7/g6OqbSAv2EDzxGXxT0chxIIflB/YGgF0yr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+cNdeNMHAUpnENal2bTOghsxjgiMtowCLy5O4L3KyGwy++3gjFe5hAJzBT+TSdiBxqBeyrgfnOFRV8sC6wjk3OE/s7EJpZLauEjQd7ELBRdIRTugUbqEPWQRLyg3PNlCkfJV4dIBLc+0e4hWcRrHhXfM28p3Vw0n/wnJ08X4l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0RF6boh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0RF6boh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317DC1F00893;
	Fri,  5 Jun 2026 08:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780649821;
	bh=nryohI88MPjedFqHv6OUsSyv23lX/SiFCDfBdxAC/GI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E0RF6boh0pv8NnOBEWanWuR/NiiqBtDTwsuSTWOD3P3Kbtw7+3JEuv9mCSSSUv6P3
	 6G33NG5wMuiwQEd0vj/EW4eA6CVFlxzyOzWf3bjm4AWphfV0faoGw88f8CRX3pmgeu
	 wUQWWvjwgw4VRiflrOKS52NSKLQcy3w1iq66RKeEuttSfOEE5+tVHt/maU9xRIqNjp
	 stfVufIKxygkKX/dmVMEoYgEKUWglHnYOpngktbK3BgDrCUEvzXNA1wz7toHP5moaC
	 qglPK71aMacXOecbpWL02bM5lpqGwuary17O4v1dPwMsV414Qzl+6V2G8OHfp9e58i
	 B0shKAh6IN5fg==
Date: Fri, 5 Jun 2026 10:56:55 +0200
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
Message-ID: <aiKPV6GPwLMZYtDu@gmail.com>
References: <20260605070826.2995913-1-jgross@suse.com>
 <20260605070826.2995913-9-jgross@suse.com>
 <aiKMPrRq8MFa__23@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiKMPrRq8MFa__23@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Juergen Gross <jgross@suse.com> wrote:
> 
> > Now that wrmsr_safe_on_cpu() has the same interface as
> > wrmsrq_safe_on_cpu(), the callers of wrmsrq_safe_on_cpu() can be
> > switched to wrmsr_safe_on_cpu() and wrmsrq_safe_on_cpu() can be
> > removed.
> > 
> > Signed-off-by: Juergen Gross <jgross@suse.com>
> > ---
> >  arch/x86/include/asm/msr.h                       |  5 -----
> >  arch/x86/kernel/acpi/cppc.c                      |  2 +-
> >  arch/x86/lib/msr-smp.c                           | 16 ----------------
> >  drivers/cpufreq/amd-pstate.c                     |  2 +-
> >  .../x86/intel/speed_select_if/isst_if_common.c   |  9 ++++-----
> >  5 files changed, 6 insertions(+), 28 deletions(-)
> 
> Please split this into two patches: one that does the API
> change only, and one that removes the now obsolete definitions.

Followup, instead of:

  x86/msr: Switch wrmsr_safe_on_cpu() to use a 64-bit quantity
  x86/msr: Switch all callers of wrmsrq_safe_on_cpu() to use wrmsr_safe_on_cpu()

Please just transition the users to the 64-bit API and remove the
unused 32-bit API:

  x86/msr: Switch all callers of wrmsr_safe_on_cpu() to use wrmsrq_safe_on_cpu()
  x86/mrs: Remove unused wrmsrq_safe_on_cpu() API

Thanks,

	Ingo
