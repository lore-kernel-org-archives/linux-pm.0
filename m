Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC9E3264FF;
	Tue, 21 Jul 2026 06:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784614259; cv=none; b=m03lVVHyAobVNpsh+vCbrb0v99f59lv0ehGDnAgoaqHgaFamy2usQSqdY7ISY4nSvwnaEUq938HAwyfI4VI3e0Bk0fh6Bh6BSqnmQJ8g4qJ9AsRoCv26bo0+M83syehvhuXYy25JL2vLaMSyJMi54YhJeYPle3xLxa+8D3cJ9dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784614259; c=relaxed/simple;
	bh=vIBTdW11B66UVwhbfOXj9Nu+e/F6TpyB6aFur5b/Jss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxkwFZX+NhNWBZmHYoulEjaL7zq6XXLYTE3d8Ktf4JgwzuACnRpvl+rL1z4Mw9bQl9DwUx/XOi81Qcsvc1LU8cI2kRgiX1RSZ8Wyzg9Ylzgm026nF9t5bHBC01uMob2y57GocXg2xc+ytYKc+OvVeYypL7tlzIK0usDbucBNiPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DLIFn+Gy; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DLIFn+Gy"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F344B40E016E;
	Tue, 21 Jul 2026 06:10:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GDDcfYPXhO7e; Tue, 21 Jul 2026 06:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1784614242; bh=i23MOeJOF9CKgMPXHAegZCXdvr604f5qBEO4gvDYN2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DLIFn+GyvfZNLjJ0hqi8LQRx9czK22AK4qbq7RXNW8rCT/y29VqDD44KvmWlfPakV
	 nGpdAxeK892CRjUnPT6I+fQoGcxQWay+mgG84nEPfoixwLHU/dAW6FukB1O79s5pAG
	 fs01qovJvBBFJchwZ07v55oErrHWhUmD4W0dNzhAWQmRBD4QCv51pPCZehI6T0PFaQ
	 FtQclI+Q5a46SKuPs/Hd82QczdmQry/I8rQNqQ6jkVbsNhhoaHNIIlrD4XcItoMOMB
	 wRZcFSKq/7XOcOJt/wi1R04pGVAjIAQCZwL68mgivhl1BSb+vTAWNtOMa4BZXLI7f9
	 aSRzHLPXZWYhKIROmeKIbXX0fembYffufMwM6gaUl1/agWCGJYmC+6F5PPotybI+89
	 yPX8KFN+9S3X2tJhGuoo7ULeak5PcB0E15BEF9cDkIu0+TuyRLy+0+PomRkM3uGp1B
	 9oGDzdyPWwIdqb9vCJfbX7PU+lyDc9W1+/fthqpalwuLujFYyNp1VYzYMTUsY9qgcX
	 qIu1BhxXNa1jJEXSIe9Pkvc44/CxOxx4WfqWuYqaCrhNrBsIVLbCV8GpRD+Lcikz8p
	 lDf1NsjIjbiGaHZ4VMyPnRkUtBIVbXyb6VziJoc9rRuFesCWcDRm9qkyc2Hfuj9zGv
	 TT7djvzfPBMWv9wCvQQ+mrv8=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4524B40E014C;
	Tue, 21 Jul 2026 06:10:30 +0000 (UTC)
Date: Mon, 20 Jul 2026 23:10:26 -0700
From: Borislav Petkov <bp@alien8.de>
To: Rong Zhang <i@rong.moe>
Cc: Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Jason Andryuk <jason.andryuk@amd.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Michael Kelley <mhklkml@zohomail.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cpufreq/amd-pstate: Bail out early if
 !X86_FEATURE_HW_PSTATE
Message-ID: <20260721061026.GHal8NUtERK1BZ3iux@fat_crate.local>
References: <20260721-amd-pstate-vm-v3-1-8b59574fb714@rong.moe>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260721-amd-pstate-vm-v3-1-8b59574fb714@rong.moe>

On Tue, Jul 21, 2026 at 02:47:22AM +0800, Rong Zhang wrote:
> The CPPC feature is disabled by the hypervisor as it makes no sense to
> expose them to guests. It creates a paradox that the same kernel both
> disables CPPC as a hypervisor (KVM) and warns about it being disabled
> as a guest.

There's no paradox - the same kernel can be a guest or a hypervisor. Just drop
this silly paragraph.

> X86_FEATURE_HW_PSTATE indicates if the processor supports frequency
> scaling or not. It is disabled on virtualized platforms (namely, KVM and
> Hyper-V have been reported to do so) and is always set on physical
> platforms that support frequency scaling.
> 
> Check for X86_FEATURE_HW_PSTATE as a prerequisite and bail out early if
> it's unsupported. A debug message is also added to help debug driver
> loading issues.

You don't need to explain the patch - that is visible from the diff...
hopefully.

> Fixes: cb817ec6673b ("cpufreq: amd-pstate: show CPPC debug message if CPPC is not supported")

Fixes, schmixes. The only thing this patch "fixes" is some silly annoyance
about a print getting issued in a guest. You can boot randconfig builds as
a guest and see all kinds of messages getting issued because the HV doesn't
emulate the hardware. Are you going to whack-a-mole them too?

Pff.

> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index a74a4cf99d22..b0b651380732 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -2167,6 +2167,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>  };
>  
>  /*
> + * Processors without frequency scaling support can't do CPPC.
>   * CPPC function is not supported for family ID 17H with model_ID ranging from 0x10 to 0x2F.
>   * show the debug message that helps to check if the CPU has CPPC support for loading issue.
>   */
> @@ -2175,6 +2176,11 @@ static bool amd_cppc_supported(void)
>  	struct cpuinfo_x86 *c = &cpu_data(0);
>  	bool warn = false;
>  
> +	if (!cpu_feature_enabled(X86_FEATURE_HW_PSTATE)) {
> +		pr_debug_once("frequency scaling is not supported by the processor\n");

So now you have a second print here. Who is going to fix that one?! /facepalm.

> +		return false;
> +	}

In any case:

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

but only after the commit message sensation-seeking is tamed into what this
really does.

Lemme try with a one-liner in the title and commit message:

"cpufreq/amd-pstate: Prevent the driver from loading on unsupported hardware

... this check also prevents the driver from loading in guests and thus not
confuse users with misleading prints."

That's it - no need to overengineer it.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
