Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E4D483BEC
	for <linux-pm@vger.kernel.org>; Tue,  4 Aug 2026 19:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785871374; cv=pass; b=BTlbBIETBWnmunrs+3kHaKSoLwVt/xUAZ9g6Fpmcci8hV8eK9S0YhM1kAcnU/gsZOWhHlhd8/NfWIfZgAtzhQUsrPeDihcUJ6qmY4/Rd7WPO5S0liZptAaVnz+AoT8nw+SJQkzO4w794c33H/rKeUayUZZU+U7tryB1End+wiQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785871374; c=relaxed/simple;
	bh=XIYNJf0f+J2VM3gE0Hse8lbSUp+bgptoJPO1F2hMacM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyQsiryRvkHh9/QMe/s0MQpeRDBtUiWeC9uZnRSXfzqyQ2JxwLondLuJufeqClhf0zV3d/49YMw0PybK8zUzo5R8V4HUSlpgwGukInP1QZX1MYHEI7z4NlxGL72pCf7EvTBODp588mDWqfYEn3Hb9wEoNlrjcBxWhXfq+PmW64U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=yO1DkzFn; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="yO1DkzFn"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6688dfaed31so192076d50.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 12:22:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785871368; cv=none;
        d=google.com; s=arc-20260327;
        b=MhaZS9Gp746nsDrd8I4GlnLBT/j+woVTdlFXwplU+S9mSMd17+ilqWj59+xhY72JkK
         e64xJNnG0w61Z8cPgXivryXhbz5ArUp5mNfBX3fGngKavP0GqdF2igdQywC1++H4xpMs
         mfzTDpcWPeQXkkRmhzPSKhA5NBfRUqut1U8zirCm4JZ7qdFaCJskLVgeQ9OKS7sQTfQ0
         1e/GPVDKRNOk7QsrZWQ7xcaif9vawkwAj/miVTWc1JKD53HsrtQfjh+mxJJCOPlpLKZj
         80nmHtaEYjrCGxvSS8jXPL4Ia5x3s1B1n9VN/06s1VzKCqVOJq/llJdT1pT2q1mZTGq1
         PtiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8zWGNN7c+fUe4PrDSWd+N1/Re//sH2cOYO9r+zdO50o=;
        fh=5g+R/eH2aQdL9YC/+b/nlgMfF3uP81POf6Xi4PxREmM=;
        b=gw02B0kvRzNjEs4++7FIlN29EhT617a2xPmISLE+pvlZ38R27IlnVPpkHQuFi+DAfC
         YV73bUj4RuO+Qmt6kFRAxbiGy1Mh3WWAcsy7tVP69AVKGlw3XILYJWqvQztxNUzpK2Cw
         uDTEgg7vz+M/0CIPkXL2eQXQ5RWDQN15jrehU+LlidpOt7VqTFRESl0J56E5fzJ+GzRI
         f3Wxs9ptwm4KN73uRBtVbSM0CBJLeLGmH2pWLmdQxGkX+q/p0OCZR8osyff96KTz6aFc
         hr0kpHk185o+q7yPv+wFRNEwTfZwsHIemb0kO2kq4HIpDAhLN1iIqmYymcuaQAnOnMr1
         AdrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1785871368; x=1786476168; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8zWGNN7c+fUe4PrDSWd+N1/Re//sH2cOYO9r+zdO50o=;
        b=yO1DkzFnQSW+S3dNFceCc83JKTDl9QxuZbzCclVE0Bn+zJLmqqLdxls5uZdJSI+WRx
         WtDNDObVrkWrWB87ClQMZ/Wdx5keru4U+DNh+1LOlER0fIqjPUXcbKTThkFoDhOJij0C
         hF72nXM8uufqBWD82wwMqrc2U2q7QIa1/GgzxaupjjBSj5S2BvrVT3NXUKigsfmA91Uv
         9RpnAnpuYIZSurE1QUvHlkC8AAeb85LDlJmLaDIrTpF3/MelN6SyTD2hWAqFPkyFPPHo
         X+X6q3SEunMajLm00ZuL4L+JvjikK6ZOtzzRhAE2o5AvkRUJC+9cA1o+WTAmfW5rxo13
         1gLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785871368; x=1786476168;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8zWGNN7c+fUe4PrDSWd+N1/Re//sH2cOYO9r+zdO50o=;
        b=R1hDmTXihSkOEoTW50AJB4IYiD3PM0ATpjfXIomt6g+rBleFGR/kwKcbD52139Xnt2
         R7OeBAQRvBE95Vn4p0eNL3PpT3ymPVciEFFN7MKhG+ExqZGT7+/O5Uhv0nD8n8JzyG8z
         R2W2H0IqMHaer+S1gii+c7GlXuoan9zNZ/j+FzXzA+0R8O2UDz93pParKkxP/qQLfuN9
         AhJEVnqxtm9RGYSyCLuEh9edTYja6sHadSAUjRsOeJqePcqd4nktbYg6kDVgehHc0uYA
         mlUbwncfST3G12AepqXTZRLTqLrNfBa0SVpcb/mU2bOA5VClmLAEyXA1R1JIBlh2FNyo
         aLfA==
X-Forwarded-Encrypted: i=1; AHgh+RrR+iXOBrlXu3LvHTT+ZsI5BBleycqnIFifCcsmDKFCdMSYyYlPz1l8OL60lTEqxZB/p6IV1ZZVtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXPh9f0Z5+ys7plMHmscxAm2MQzRN5vjlDwhIx1YeTWkOclHO0
	0o0GV8lIlo5kCGW8fbx1ajZ4LSBIvGxtlifpawLoYaOZ7A5IiS7TMEx+EwA/zVP3ZdAOUee92yb
	Xi5anKlcGli7/Lvsgd0Ft9fIJOphL+aCOjguq6dGn
X-Gm-Gg: AR+sD11vUK8MLDNeO0grbSzCHfka3epcaBMbPlxLdE6iv7v1O+chCHLhxsFbxm5iTyn
	ExGeHHgsgtBE6SXF/8HwGs2woXkE2qy5gB/+UmAQka7C3MhDUlaYly04L/Kyq3xbqDLCf5IUXKE
	D9dzzep4VLqqbZN+znXjv4Vz6oukt51VxUqDCUx9C3BVxKxRuJRjTjAPvtwp9LLzaEUkCfpbPsK
	QhK0j2KAn/pzZAE/6Hs/Qs2KSPfcoSK7E/Pq4y5QYSn6Z4tu79hF4YGsbCzhHPh+OT+aqflS6HI
	udv3/mtJRXSRlM5lnFDfmBQuhqVr2RqaK35B61h1b+r6tGfzFUSjDyMG+9NNixW+pOVlh1MpZlv
	dkRtEetiEtQ==
X-Received: by 2002:a05:690e:4507:20b0:668:6c92:dfc2 with SMTP id
 956f58d0204a3-6699a916533mr612302d50.5.1785871368334; Tue, 04 Aug 2026
 12:22:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4430d02d34617dd2d3cb506202fe44d5e45c053b.1785838418.git.sean@starlabs.systems>
 <20260804184920.GBanI0MCMbnglz7Ncc@fat_crate.local>
In-Reply-To: <20260804184920.GBanI0MCMbnglz7Ncc@fat_crate.local>
From: Sean Rhodes <sean@starlabs.systems>
Date: Tue, 4 Aug 2026 20:22:36 +0100
X-Gm-Features: AUfX_mzaXfPvr4LajhzTiypTnMOuvV-CMibI0s_PDHlpItF7Pv_EvMN3JDYnz7Y
Message-ID: <CABtds-0MUDmxK_Vd_P8CijwzUhQEV4eWNzx1+DbN2wfnY4dbrA@mail.gmail.com>
Subject: Re: [PATCH] x86/pm: Save AMD CPUID leaf 7 across S3
To: Borislav Petkov <bp@alien8.de>
Cc: Mario Limonciello <mario.limonciello@amd.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Aug 2026 at 19:49, Borislav Petkov <bp@alien8.de> wrote:
>
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

If you're saying that because there might be a firmware solution, I am
all ears, but this issue is present with AMI CRB and coreboot+FSP -
hit a wall trying to fix it there.

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

Why not?

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

Ack :)

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
> >       return msr_build_context(cpuid_msr_id, ARRAY_SIZE(cpuid_msr_id));
> >  }
> >
> > +static int msr_save_amd_leaf7_cpuid_features(const struct x86_cpu_id *c)
> > +{
> > +     u32 cpuid_msr_id[] = {
> > +             MSR_AMD64_CPUID_FN_7,
> > +     };
> > +
> > +     pr_info("x86/pm: AMD family %#x CPU detected, saving CPUID leaf 7 MSR across suspend.\n",
>
> I guess pr_info_once() is fine here.
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
