Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9313E5A09;
	Tue,  4 Aug 2026 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869399; cv=none; b=abVfofXbg8grv9g6IrHelaHXL+aSt+nyrW4Mi9G2yteUjmBIiuFwGDjnzhqP7pCzsiPwgu3mF007u7HSgEoMVZLXtVLGWtIi9Z0QD4Cn5y4+djudB1hRk6AYknOYk4DU+uwHFpckHxKHDAEoT5OoF4j4lHhH/d68yHWlkrOGQtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869399; c=relaxed/simple;
	bh=NfnRqyEDQtC2UWJqFZYYpE9YtnU00mUM6F9dwitVwig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/lptwmmnPizNvDv8Q1oTiZXDSzM7FO7VyU/SOkqw9xaFwWxG2eDmj8iU1XL3KamNSygc8oPMZ8feudXILORVjXF1DYvUl29mQ4XjL6iTa7i5MKI/Wk7XX2EPOi9Uld3enV2DBIrp01IE11gntduTZpmcCVPtW5t4jtobm6zEpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MTec/dYY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MTec/dYY"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 35D5A40E01CE;
	Tue,  4 Aug 2026 18:49:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fqE_V-rzFjuR; Tue,  4 Aug 2026 18:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1785869375; bh=szOG1XqzgEIyu7x0nRnqYMDlVAXKjoc3bI8pnOPitHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MTec/dYYtohtqTUKVQU4yM+QLUShejJHoC4fgj3DXZGNUSdRZHdX79UgkYhHn0rtG
	 +Cn0fXMmDv9DuSSiS3Sc2ASsCWL72z+6D6f+OGnU6wskZ/4pwVlMm95maihh4rIt1I
	 aeR/rhK5WErPztKQ3X7VpjqLTgWzWci/XfF72CR90TNGJlSgb6xtiDs1Nb7tNvmkRR
	 Curfg29JS7qEA+tvx+OMKFA9VIwbyWeRuG8td779/R0j7NjWjmuxk4oF69sYhE3BJO
	 uCUlIz3jZpSGuBxzn+jdHqi0DxK+KCIDBzz6FRvwWna6cwYZouDo6H8DmHiHeBwmkt
	 QQdYWshalIIopRNXEshtzWkl6Nc8fL2GNuhxcdcqz5qsQWCKONoLWdCLKVlj8abLbZ
	 jmCTK0x0S6YFfe0Bh8Xnmrs3pfLIOcdt/pdwH8cEZYg60FyyFVqZXNbqE/Dg9OwmcD
	 HoHcmexpOFEXUYZbrgVaCbLXhnb5U8eNvoeDtbYP9piXfVAHvhqh2KbIJ7HmxxxKIK
	 DnqBJspIJsqWVrMjkitohQB9DiRm0X74uJ1Nt5H0/MSG8bc21zjvDr8ehAhUlzFRcT
	 bZptyFTv3DP4iaEMhIixzL8TtJbAEGyH3Sd4mKDnBI93FWTxsCSpHUM8XIBsZWh2kV
	 7kd1hvhSh0OjyRGuaHV7HxmA=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7694140E0171;
	Tue,  4 Aug 2026 18:49:23 +0000 (UTC)
Date: Tue, 4 Aug 2026 11:49:20 -0700
From: Borislav Petkov <bp@alien8.de>
To: Sean Rhodes <sean@starlabs.systems>,
	Mario Limonciello <mario.limonciello@amd.com>
Cc: x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/pm: Save AMD CPUID leaf 7 across S3
Message-ID: <20260804184920.GBanI0MCMbnglz7Ncc@fat_crate.local>
References: <4430d02d34617dd2d3cb506202fe44d5e45c053b.1785838418.git.sean@starlabs.systems>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4430d02d34617dd2d3cb506202fe44d5e45c053b.1785838418.git.sean@starlabs.systems>

+ Mario.

On Tue, Aug 04, 2026 at 11:13:41AM +0100, Sean Rhodes wrote:
> Some AMD systems return from S3 with the boot CPU CPUID leaf 7
> override MSR reset. On Byte/Cezanne, CPUID leaf 7 EBX becomes
> 0x219c9fb9 on CPU0 after S3 even though XTEST still raises #UD.
> Userspace can then select RTM-optimised glibc paths and fault after
> resume.

Do you have the latest BIOS on that machine?

> The x86 suspend code already has a small MSR save/restore list for
> firmware-modified MSRs and restores it after resume microcode has been
> loaded. Add MSR_AMD64_CPUID_FN_7 for the AMD families that can modify
> this MSR during CPU init so the pre-suspend CPUID mask is restored
> before tasks are thawed.
> 
> This covers family 17h, 19h, and 1Ah:

Why?

> family 17h has the Cyan Skillfish
> RDSEED leaf-7 quirk, family 19h covers the observed Cezanne issue, and
> family 1Ah has the Zen5 RDSEED leaf-7 quirk.

Those RDSEED quirks need more details as to why they need to be applied here.

> Tested on StarBook Mk V (Byte/Cezanne, 26.07 firmware):
> - without this restore, dmesg showed "ACPI: PM: Low-level resume complete"
>   and "PM: suspend exit"; the post-S3 CPUID probe showed CPU0 leaf 7 EBX
>   0x219c9fb9 with hle=1 rtm=1 while XTEST still raised #UD.
> - a temporary PM resume hook clearing the same MSR logged
>   "CPU0 MSR_AMD64_CPUID_FN_7 0x219c9fb9 -> 0x219c97a9"; the post-S3 probe
>   showed hle=0 rtm=0 on all CPUs.
> - this patch booted on Byte and registered the MSR save path; dmesg showed
>   "x86/pm: AMD family 0x19 CPU detected"; pm_test freezer/devices/platform/
>   processors/core passed with the same boot ID.

For future patches: testing goes...

> 
> Tested-by: Sean Rhodes <sean@starlabs.systems>
> Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> ---

<-- here, under that line.

>  arch/x86/power/cpu.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
> index 702f30eaf9c4..b85061f4cee4 100644
> --- a/arch/x86/power/cpu.c
> +++ b/arch/x86/power/cpu.c
> @@ -467,9 +467,24 @@ static int msr_save_cpuid_features(const struct x86_cpu_id *c)
>  	return msr_build_context(cpuid_msr_id, ARRAY_SIZE(cpuid_msr_id));
>  }
>  
> +static int msr_save_amd_leaf7_cpuid_features(const struct x86_cpu_id *c)
> +{
> +	u32 cpuid_msr_id[] = {
> +		MSR_AMD64_CPUID_FN_7,
> +	};
> +
> +	pr_info("x86/pm: AMD family %#x CPU detected, saving CPUID leaf 7 MSR across suspend.\n",

I guess pr_info_once() is fine here.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
