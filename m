Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79299363084
	for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 04:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776400528; cv=pass; b=VfvqHUgyuNDp7POEuKM6S+J3dTEHcmeyk71pQSKNZ090Mq7QmUjeusIhbcuK0eXQCBhazkLE22ilgfLKpTnchTFPJjjLM5rKhsDkeL6onZCqAuE40Zv7+RZeususNR6je3CjHxVzF0mZJww/UACbseMYsu6TiPGZ07DvU+FVYm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776400528; c=relaxed/simple;
	bh=yZEfdFikqNCQqqcj1GsMSU1ULCvyRuyLeRRABP/tDbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iiqwADW7UXJNL79GxBEW0ItPmuYFiUGXyIQwEaZVAMem7WQ1ptfglY6KSyUzYXxAMJRjITAlWdOLqSs4OERsVe9W7phMAt58isPomViB3QYuKNeargetZUSaoBKlQujfp8UuF/5hnZGxVBBXmZDlgYXQSjdq7L2LVdYiek3AaWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9haOR77; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9haOR77"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6725295a113so450913a12.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 21:35:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776400526; cv=none;
        d=google.com; s=arc-20240605;
        b=dDDQFY1IDx8gsk6DkfEjA8DR+bgtSquUOgvgL76ONgeBN3w3GWFc0DOTtcTxTZZ5TX
         j6M69+8hj+98xJT/Wo6nK7cTz78nv+k/8lozdS+eDlbA4KJn7TFCD7obEm7JttQSRhMs
         FmhbXD//iA2JPOy4mLNbmErx5SCqI3VR8sW470931yCwCzUWbXj5KNqhUAp5Llo+d2rj
         ENf+4GXx7V7Vw8qQwbAjE+OtRV4qdEmrIm728JxNeMBii3QPlJmGNvuHHEdR65kmEyL7
         qeueYWOpIPcQ4QeebHHKWsI6bj8L0TJCZ2MulpRISspiRXZ8H2+tTIAqJhO1DcDPza8H
         7fMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qoI6/ycUsThfhLzSR7pbYFKrkQWOkM+tNO3IWZnUttg=;
        fh=jQypZRRZaMuZOfNiU9MONOPenDoiPAnXv0E1Zi13OVI=;
        b=M/9XfE3h9+ku/t3f9OXtVeh8nXdVhlatis9WrDoHT6k8DJzDPefj74QcKGl6NctrlC
         qDgfBhWZbcuboij9OfTq29ydNTANN6ukjVPxHF+Ey+ilvTiYtIB/zK2j9LPHisAV36YO
         IG483hxz6lzaKZRvbEoW5/cIefsKqVfpLxFrn4bmnRLJA8FM0P6xQAd+udSdNS00KNt3
         z7oU8UGzkdiujneBxVfUoMqZCGMGUI7GY1zwDAkNAMICOVDQWm7zzd9AjiG4521+wdZn
         K6nGXoJR3Aj4954wGWiBzUAVZNzWE5ANy/3FvmYwGrkUnV8ebRhxP8tXmfno3zfY7gTH
         eyWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776400526; x=1777005326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qoI6/ycUsThfhLzSR7pbYFKrkQWOkM+tNO3IWZnUttg=;
        b=E9haOR77gDsLmJe20g0tpxLTaILavNZ1XkCP2IHeyn+L5YT5V+AYr9IxzkJ4RsFJPX
         ZKhXshXktwlVD1FkADnkgM80DOXtTuYb+vsju5HwG9q9OR8Be61/04Fc+IAYePe5d7ox
         fGWtidDgsGVWqvz3nNt1S1PvG0F5wK31IiHsFliHGWFM/x/9l4ABycj6TmUrxKawB2rp
         5ULmW7yGZVdmsiuMjwbC3NPednZ67hkHHBHEyXGQbmIyJDBrLBMPEqqOLAcdA7AlDK/9
         M50ZrECX34Q8KVOC+KPv1+zfSQU9TSePxreuNRkaZE1ZZqViNvaWFKDAO4Og4YiXA5N+
         2tgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776400526; x=1777005326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoI6/ycUsThfhLzSR7pbYFKrkQWOkM+tNO3IWZnUttg=;
        b=Snd1e4P2lQVi6H7IKDS/4S1z6jYV0Nbkv1BOagfwBq77Nv/B+1Rgt/14eUHy1BV92t
         /DjMdIv5UhH/UrReV0PjOuck5iWW/GhksQbuz6vJaPJ/6zIZmm/dv3YBhq6aYn139+Qw
         nkLGAbRA5/ayMCToY1m0XWd+cteENtxj9eHAmXvxjdtnrsILYotYUyvunt0tc2e8hQqD
         QdyyWWxS3Os8BnAzw+gOig95UndyZBI9m0MGJyR0S/5pLxb2ja7MV7VsbbrKAwT+maZr
         W1aSYmMVx07S3aCnBUEatmhUVRsmH17CIQuhNVZZsqBHNnOWHs/EQhDXdbpmCaoPAdqa
         ao4A==
X-Forwarded-Encrypted: i=1; AFNElJ/PdLqrneyuMTUeYAGCR7aXfSV/a0nx+KhIEh27Dy7S7t8RTNyfp6CN/e0iEzrbHxu4ej6YrGCVkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxO/3DNbnJ6fLcmhYskPdZoTL6saMHSIddFVfeTVKz0q/F4J6zd
	XMd3rs5xPgo4Zz2uG+//v5lPeDsBEfgm1I7yyifDZ+8jJX/7NXI07yZtmL9bNrhkbqScRw7hKhl
	PG8RdTkr6ozk/TMHvbTnrFRWWVfp2D94=
X-Gm-Gg: AeBDiesap077P/xTs2K4cv1HMbaz1UJFTkSOE3GfhwRLdVgY0prg1CRnpH/8kV1SyH4
	yYhplg2NapJXfqHdUzzSF5ca1zT77VvlgibZV56EY2/9Pc0zitNUo3jJ++r0HdzHI7tn0/jFeXU
	UB8uxwnHkojMH1eSzBMAWyn1vqe+cSh7KO/3XGtYik2+9lAnEjMc0nop4Ck78B+Gs2S6GL8mmN7
	mY7QPY4wf+/b/U8GmKNQ1hvkLuuFRtJtyN/p9bFupuEW3K7ib9s6Xs/3wkkARzSLJFnyrVdBCxF
	ALpi/64cdUgA8jYE2w==
X-Received: by 2002:a05:6402:324:b0:671:b7f1:6e35 with SMTP id
 4fb4d7f45d1cf-672bfd86fbbmr406243a12.1.1776400525628; Thu, 16 Apr 2026
 21:35:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416144621.93964-1-dbgh9129@gmail.com> <203f2e52-bf9d-4055-88bd-d911bfecf082@oss.qualcomm.com>
In-Reply-To: <203f2e52-bf9d-4055-88bd-d911bfecf082@oss.qualcomm.com>
From: =?UTF-8?B?7LWc7Jyg7Zi4?= <dbgh9129@gmail.com>
Date: Fri, 17 Apr 2026 00:35:14 -0400
X-Gm-Features: AQROBzB-q18tJ5JBdFybdquAFcqHl7aT_6Q1xXRQJA3P4u0Uy_lc3kZlETv28RQ
Message-ID: <CACrCO_WDW9X+h8pw8zkQEEBzhRFrmTRMvOJ4BGj--oLkBGtQuw@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: pcc: fix use-after-free and double free in
 _OSC evaluation
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Kim, Taegyu" <tmk5904@psu.edu>
Content-Type: text/plain; charset="UTF-8"

Dear Zhongqiu,

I appreciate your review.

Best regards,
Yuho Choi

On Thu, 16 Apr 2026 at 23:29, Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> On 4/16/2026 10:46 PM, Yuho Choi wrote:
> > pcc_cpufreq_do_osc() calls acpi_evaluate_object() twice for the
> > two-phase _OSC negotiation. Between the two calls it freed
> > output.pointer but left output.length unchanged. Since
> > acpi_evaluate_object() treats a non-zero length with a non-NULL
> > pointer as an existing buffer to write into, the second call wrote
> > into freed memory (use-after-free). The subsequent kfree(output.pointer)
> > at out_free then freed the same pointer a second time (double free).
> >
> > Reset output.pointer to NULL and output.length to ACPI_ALLOCATE_BUFFER
> > after freeing the first result, so ACPICA allocates a fresh buffer for
> > each phase independently.
> >
> > Fixes: 0f1d683fb35d ("[CPUFREQ] Processor Clocking Control interface driver")
> > Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
>
>
> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
>
> > ---
> >
> > Changes in v1:
> >    - Drop spurious #include "acpi/actypes.h" (Zhongqiu Han)
> >    - Keep kfree() between the two calls and reset output.pointer = NULL
> >      and output.length = ACPI_ALLOCATE_BUFFER
> >
> >   drivers/cpufreq/pcc-cpufreq.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
> > index ac2e90a65f0c4..a355ec4f3dd4c 100644
> > --- a/drivers/cpufreq/pcc-cpufreq.c
> > +++ b/drivers/cpufreq/pcc-cpufreq.c
> > @@ -352,6 +352,8 @@ static int __init pcc_cpufreq_do_osc(acpi_handle *handle)
> >       }
> >
> >       kfree(output.pointer);
> > +     output.pointer = NULL;
> > +     output.length = ACPI_ALLOCATE_BUFFER;
> >       capabilities[0] = 0x0;
> >       capabilities[1] = 0x1;
> >
>
>
> --
> Thx and BRs,
> Zhongqiu Han
