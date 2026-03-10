Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A3143CECD;
	Tue, 10 Mar 2026 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773135360; cv=none; b=uJe1pFd+j28xVcVIYQcDRlADyNLjlS/7JlctTxavoPeayz3I7vcdJGckY5cX7AVDI0ZwZ+6ZtOeutaJK3EhEuzX0hZXfkxN93N9qPyKivaMT28OQmOFEyVS8iUVtD9Qr53Lp9ooIMvV09w1iBHMAOUVvbuQfQb+48wpxd9qsHNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773135360; c=relaxed/simple;
	bh=utJK9+4LgqnSu3SSGlMH1Ib5e/nF7vBLE1VZv8YUy6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngm+mjCwahPkufgj+LH6AxgiPpKzxFPd/hbqx0/e4vHfriRfA/TqLhi8kgF06xWKuk0cVSAORhuvayh7QhNoJuE59NzBtytp+vXeGHY05iMnyEvFXYAHHF1Zxd4Pi5yocxtfuM9VeT2pd6M/pv4lYGhfcew18fFm8g33d5JqpOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JyOWUJPn; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JyOWUJPn"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 87F8D40E01D5;
	Tue, 10 Mar 2026 09:35:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2EyzAfmaJ8nH; Tue, 10 Mar 2026 09:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1773135348; bh=g+bExdJiu/wp/hnE2AJ8jSjgsLggH720+baR2keRc6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JyOWUJPnoPjyCir8SfZA/zuVwQ1/hFSMw/Gri0lBWLiSj4tPNrYpIS5xc4hA1ICyf
	 F5kXDhnOnYQRQXyWfwpnYEMN7FzjaRnymcS/sh0FuRtSd2tXlWGFOF8hBK8EysdMK+
	 zMetGzxYsWO6tvvLKuT76tuXcIuH+WWOsmdIYLvrKMUUiavdTbrmDK3deYssYcBnjr
	 19p4ju1fYIiBVKbFg/uu295ZWSZ0zry05Fa2ijEYE7hFdP/eIQ7/PAjA45brMbH9vj
	 UJB1PkUA3DCX9wNaLPqrkrvSTrJCe9ZXV2Dro0GcnTKDgLxd9cJh/ZBgrSauA12KXX
	 yiqfFZmzvBCoAIkiB/IiIJqz6dLXDqmEPIdC2YxSlDc573+1Hi5AJr9XjbFxpVJquR
	 NhIIy9OpEfG263sav0FFtuEwPMHPqzhkJSDeHCYE9We+tOKQk7puiFlO0gFdv43D06
	 iqTh+1v9J9BVaOWD6A5Jm7KuIXwDNoWG453jYWDmwKa/LVwTrqlSRCO1kJhsFv1yZr
	 oODiqwGyjyK6YdESVBGXIZLLVgCPM6DjtbUCAMkYEi5VF/eq1ISU/4Uqokb5tIWFNO
	 3hdux9l6ms3Ld2yyNNra4RhiKyVcNinJgUwtE38jVsvTCaeIdQK9JUZbqsqDCbiyja
	 mXKutQc6uME6JKaqEzPmiffE=
Received: from zn.tnic (pd9530d5e.dip0.t-ipconnect.de [217.83.13.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id E5AE340E0174;
	Tue, 10 Mar 2026 09:35:37 +0000 (UTC)
Date: Tue, 10 Mar 2026 10:35:30 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>, x86@kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>
Subject: Re: [PATCH 1/4] x86/thermal: Add bit definitions for Intel Directed
 Package Thermal Interrupt
Message-ID: <20260310093530.GAaa_l4ij2mAgKEFbb@fat_crate.local>
References: <20260309-rneri-directed-therm-intr-v1-0-2956e3000950@linux.intel.com>
 <20260309-rneri-directed-therm-intr-v1-1-2956e3000950@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260309-rneri-directed-therm-intr-v1-1-2956e3000950@linux.intel.com>

On Mon, Mar 09, 2026 at 03:19:24PM -0700, Ricardo Neri wrote:
> Add CPUID and MSR bit definitions required to support Intel Directed
> Package Thermal Interrupts.
> 
> A CPU requests directed package-level thermal interrupts by setting bit 25
> in IA32_THERM_INTERRUPT. Hardware acknowledges by setting bit 25 in
> IA32_PACKAGE_THERM_STATUS, indicating that only CPUs that opted in will
> receive the interrupt. If no CPU in the package requests it, delivery
> falls back to broadcast.
> 
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  arch/x86/include/asm/msr-index.h   | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index dbe104df339b..487bf9da0cef 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -364,6 +364,7 @@
>  #define X86_FEATURE_HWP_PKG_REQ		(14*32+11) /* "hwp_pkg_req" HWP Package Level Request */
>  #define X86_FEATURE_HWP_HIGHEST_PERF_CHANGE (14*32+15) /* HWP Highest perf change */
>  #define X86_FEATURE_HFI			(14*32+19) /* "hfi" Hardware Feedback Interface */

Leave a space here to denote there's a hole

> +#define X86_FEATURE_DIRECTED_PKG_THRM_INTR (14*32+24) /* Intel Directed Package Thermal Interrupt */

Also, can we agree on one naming and stick to it?

What you have there basically screams "OMG, I am trying to say *everything*
in that single define name but there's no room." :)

Also, the defines you have here are all a little bit different and good luck
matching what is what in a couple of months.

So, how about

#define X86_FEATURE_DPTI	 (14*32+24) /* Intel Directed Package Thermal Interrupt */

and the comment explains what the acronym is?

>  /* AMD SVM Feature Identification, CPUID level 0x8000000a (EDX), word 15 */
>  #define X86_FEATURE_NPT			(15*32+ 0) /* "npt" Nested Page Table support */
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 6673601246b3..aa1c652a9581 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -995,6 +995,7 @@
>  #define THERM_INT_HIGH_ENABLE		(1 << 0)
>  #define THERM_INT_LOW_ENABLE		(1 << 1)
>  #define THERM_INT_PLN_ENABLE		(1 << 24)
> +#define THERM_DIRECTED_INTR_ENABLE	(1 << 25)

And then you can do:

#define DPTI_ENABLE	(1 << 25)

>  
>  #define MSR_IA32_THERM_STATUS		0x0000019c
>  
> @@ -1024,6 +1025,7 @@
>  
>  #define PACKAGE_THERM_STATUS_PROCHOT		(1 << 0)
>  #define PACKAGE_THERM_STATUS_POWER_LIMIT	(1 << 10)
> +#define PACKAGE_THERM_STATUS_DIRECTED_INTR_ACK	(1 << 25)

Ditto here:

	DPTI_ACK

And you can always add comments explaining the acronym...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
