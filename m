Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CE62F7EF3
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 07:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786520556; cv=none; b=MUszEKHB2/NX5q2d6a2gYFlpBlVOde/0ARshfPqFs2R1ts0cxQxTvAof8DEMAoWglk/luP19O7oz/yJqvulEVIUkN3+T/hDVuF75F/sDt5P1+/8Fc9TAnFLbrD1pL4sdHiIZU5jitomw2q2YwYKdD0WBtu0plcFR6hbuKy7z1Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786520556; c=relaxed/simple;
	bh=4QEvNJOcg2DH22aJEJgIoY5WejDiWG2sqe6WEyhW54A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8ylV9aNxdQtOE4COmLT2PVySwMQR3MaoNt9zyAU2E6zZEYHv4F2lf+oyobNq+P5hBdF97La2VD3XmKS+I0yhyCw67O+BW3uTue9XDwu3eO6YhEqJfDKweCI/FhcNbrEnd8OwwWAoxjNDlCpybWJ0dg+OOy6OI4c2SGkKfrQU5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MivWXtoo; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MivWXtoo"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48000c5d6d3so256404f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 00:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786520550; x=1787125350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xDlUymzYH5qGZ8x4wOLV+ZUwGNw/karbkHQKYgOmugk=;
        b=MivWXtoohr79J6tO2lq0u09MyogjAkKyMGzYaVMhesnEsgq1M3ZYjJubbdrf7vcCN5
         4uLwuqyw9Snlta5WdX/pJzVj2vUM+yLXbifjHc9fow+nbKyK7mip5m6l6FFUL9Pef2DO
         9fAizJwjnkvdFr5sTOBNqp3EmuiJwUq53XghfaAq40zGRpyphwhvAx4D+fdAM8LU8sKb
         0biZpkDjCYB7gLpkmZtv+VB6AHc4mz7vAZXaywG28ng/Y1VVkbIVwTtQ9OTYdChCGKjA
         xmVCeInFLhFLye0Gu6+47MTgKBGmqEl1vURW1ZrffIeTMJmBpWolnH6wrpS61b+oGBmN
         QvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786520550; x=1787125350;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xDlUymzYH5qGZ8x4wOLV+ZUwGNw/karbkHQKYgOmugk=;
        b=ZTXmG9lJ6wV0yoFfZSDj6Ng7XQZGPY0gPCG+wdso7Mc3dA4p9412RcRIa9j3Qj1Bs+
         HVNKIAYQxTOh1R3GnB2ZgVwekSSjkR+wHO/8nA8IOqAkTCFVFDI+OoUxSMxk8YUA/eEV
         I8YWUvNzn6aZWGg7my2AMFIKQxG/jF+jAS+c+hT6G85AThte6VEJm4mP8jmgkZa3o4KV
         dgTR2KHdqqTCipKXw4VWZ3PBXVT/GSvCIjTAg4zqYdeLfm8T4lVyhBBJHceQ1HF8gyA7
         kefYouYBX1MhakrFP46eSObHQoKXR89e+J2sP+VYo4JOqK2hg8GnivUow6EBOuj4VY8m
         VGZg==
X-Forwarded-Encrypted: i=1; AHgh+RqZv2sN9wdDjQyOTwInGc8N4sQ1o+IWhyGOgMHp0vuWlAhv9izkfQwn0SBI/tWA2edkzodRSZFQXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqSWC2gTk0bZDVZniqivZQGnjfvPNPdUJs8l7u1lQKiPElTjlU
	9de7AOjmM+hv86RYzSZUO3FOsExsIdREWvpM1H1ZavHX4AI3Chebe8L1
X-Gm-Gg: AR+sD125vAbWmO2Y09I/eQ9I5hnAx7l8vWoxHovPndfnZEZ/W2G8WPq6P0lnVmK25SV
	JkBohHY0MQM9prlJ+nNaIhr6st0h5nu7uUlL/DBq/CvASF4xYwWYnvqSt7npZ+iuNTa3rjLDSRJ
	OJ9V5wnJOi+bOUGkYzp1BoJBB5UPC7mcRGsIOyPdUGGqyARQqC2htkRjKAcfV9bn1YjEOOGqDhK
	In6ZGM/4VVC9WJrUgDI5q41yPOus9gah2PPJZFgAOiyZURawzeZoZ+wSw4Uek6WWL1WLWAKAflI
	pTQXRqHzEGZlNfiRrJsq2UUvqPzkR9jTKDxj5C8ZPS4+2aAlqGjfgHLBHpuXKV55P+WIPsB4kVW
	VYD2nxgvwcKuPuOoLB4AW4SqAThWIjSg8IxjVFzZ3TA6sG9godltuUNSiwFVMVYUKXAkN4PV7kA
	uarZn1YsQLljfSgwhx1q8mQJMw2WBoaM3twq4t4Yvf6tNml8C4nk1k04aRpZsGmqLco9DUHivBp
	FeIOAnvDekBHH4u0cBis7njLTU=
X-Received: by 2002:a5d:5f04:0:b0:481:4697:8808 with SMTP id ffacd0b85a97d-48152cbb647mr3790254f8f.22.1786520550537;
        Wed, 12 Aug 2026 00:42:30 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150c06b73sm5092600f8f.12.2026.08.12.00.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 00:42:30 -0700 (PDT)
Date: Wed, 12 Aug 2026 08:42:28 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Sean Rhodes <sean@starlabs.systems>, Mario Limonciello
 <mario.limonciello@amd.com>, x86@kernel.org, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/pm: Save AMD CPUID leaf 7 across S3
Message-ID: <20260812084228.66e7a3dd@pumpkin>
In-Reply-To: <20260804184920.GBanI0MCMbnglz7Ncc@fat_crate.local>
References: <4430d02d34617dd2d3cb506202fe44d5e45c053b.1785838418.git.sean@starlabs.systems>
	<20260804184920.GBanI0MCMbnglz7Ncc@fat_crate.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Aug 2026 11:49:20 -0700
Borislav Petkov <bp@alien8.de> wrote:

> + Mario.
> 
> On Tue, Aug 04, 2026 at 11:13:41AM +0100, Sean Rhodes wrote:
> > Some AMD systems return from S3 with the boot CPU CPUID leaf 7
> > override MSR reset. On Byte/Cezanne, CPUID leaf 7 EBX becomes
> > 0x219c9fb9 on CPU0 after S3 even though XTEST still raises #UD.
> > Userspace can then select RTM-optimised glibc paths and fault after
> > resume.  
> 
> Do you have the latest BIOS on that machine?
> 
> > The x86 suspend code already has a small MSR save/restore list for
> > firmware-modified MSRs and restores it after resume microcode has been
> > loaded. Add MSR_AMD64_CPUID_FN_7 for the AMD families that can modify
> > this MSR during CPU init so the pre-suspend CPUID mask is restored
> > before tasks are thawed.
> > 
> > This covers family 17h, 19h, and 1Ah:  
> 
> Why?
> 
> > family 17h has the Cyan Skillfish
> > RDSEED leaf-7 quirk, family 19h covers the observed Cezanne issue, and
> > family 1Ah has the Zen5 RDSEED leaf-7 quirk.  
> 
> Those RDSEED quirks need more details as to why they need to be applied here.
> 
> > Tested on StarBook Mk V (Byte/Cezanne, 26.07 firmware):
> > - without this restore, dmesg showed "ACPI: PM: Low-level resume complete"
> >   and "PM: suspend exit"; the post-S3 CPUID probe showed CPU0 leaf 7 EBX
> >   0x219c9fb9 with hle=1 rtm=1 while XTEST still raised #UD.
> > - a temporary PM resume hook clearing the same MSR logged
> >   "CPU0 MSR_AMD64_CPUID_FN_7 0x219c9fb9 -> 0x219c97a9"; the post-S3 probe
> >   showed hle=0 rtm=0 on all CPUs.
> > - this patch booted on Byte and registered the MSR save path; dmesg showed
> >   "x86/pm: AMD family 0x19 CPU detected"; pm_test freezer/devices/platform/
> >   processors/core passed with the same boot ID.  
> 
> For future patches: testing goes...
> 
> > 
> > Tested-by: Sean Rhodes <sean@starlabs.systems>
> > Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> > ---  
> 
> <-- here, under that line.
> 
> >  arch/x86/power/cpu.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
> > index 702f30eaf9c4..b85061f4cee4 100644
> > --- a/arch/x86/power/cpu.c
> > +++ b/arch/x86/power/cpu.c
> > @@ -467,9 +467,24 @@ static int msr_save_cpuid_features(const struct x86_cpu_id *c)
> >  	return msr_build_context(cpuid_msr_id, ARRAY_SIZE(cpuid_msr_id));
> >  }
> >  
> > +static int msr_save_amd_leaf7_cpuid_features(const struct x86_cpu_id *c)
> > +{
> > +	u32 cpuid_msr_id[] = {
> > +		MSR_AMD64_CPUID_FN_7,
> > +	};
> > +
> > +	pr_info("x86/pm: AMD family %#x CPU detected, saving CPUID leaf 7 MSR across suspend.\n",  
> 
> I guess pr_info_once() is fine here.

Would be more informative in the restore path if the value is wrong.

	David

> 
> Thx.
> 

