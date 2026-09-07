Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05B94F649A
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796692; cv=pass; b=hCZJw0X6lMBNnzqYxQwWhYTkYq43bxSWGJHIZ6yNdKpVLUuBKB+YyjPB0SS2c58SOT1iC1iEiFCJQ9HHymxr+ZHvj0IGXIWSbJw75S+cbG2skZttxyScSfSdG+CgkYE0T/aqoOiqs3YmfwKwUC4NmUg7lvYl03PlJpMaFXymubQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796692; c=relaxed/simple;
	bh=Rs8D6euDZzTcW61TMY/tcjJU4GeLI7rZpkYbKx565Qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1ovnPDTn/GLYNQQgG1AglhK7uL+zP51NvedPTW3ECCmJsjdap1isjqHcFXEC1ryVWNLjxpejp3ZcGcp7/fqOaa29XcrSu770STJYfGl1lJE9canjmMUx1L6tfdE6sDLUYrF1hywJ/+qn07wDh4JFV2D06Hk8dbPMQJozq4yOnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BE7wg4P6; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BE7wg4P6"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-861145fc841so29964517b3.3
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 08:58:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788796689; cv=none;
        d=google.com; s=arc-20260327;
        b=iGWJAaC8U4QDXgsZWBPGkhQUAJb2CRd7b0MVA6H/D71+H4oyKxfVibZFP58AqdVRSV
         MxFm/3EijwOYt0sPst+ie5PYM4eXP8I5AoKhK6pQUd744Qk6ACfGRZqJxgId3YqV7F6S
         LmyZTlnUHIPJ77Qz0XDd3NpJyEUx9hL/TJEu9AXmZV4CVQS0ElSS8fk5q6G0b9BClETq
         J3fytn1jBryRmzvxSNQRbqMrg742DEmA+Nq1Se+0pYEMmfkMiD0ycx+Rjz+NYcgxmCnS
         5dUqbKp876UiRt7NZRzAzBIF4pzsI6w7OS1ytcpNioBlt2bjim2r2GrB9oqkjj42+EqF
         O0qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nopJoLIJVNXWQLeDX2Hcvbg342jeNYWKWWtajWtfO0w=;
        fh=gTh1WUsJaEiSORJH02DYB+O9OEqQ/2M2C28uGy0azsI=;
        b=Ly+J0HB8lFXROtmGUQzyuLG7sv7lJs6STmikES7RF2cHZjUgVkQh8pcldId4JVHzQv
         Dz4N9aRQcg1jqgfvA21CJEe9LkB/cyy4bMHXrj2LxIVb5ydpKBExx3Kk6KJAqqbgVOa1
         AoSZHVWGJgbWgr9qNzc2cL5bE1pRLUmDOkp05jetJrzE7fgPYcmWdG018SkQbbul6XRn
         e2sASGRlGtv10Wx4EX4pIzm1wMpco8pN8DEHZhMZ+3xIgGT3F3GXBAqt7CltP59JOWcQ
         891uw7RsqmnPEIIWHULbq2OnlpXRWsNRbXVmIv6U8myKlc3JWrunMoakiNd7eO2z5KGH
         kIig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788796689; x=1789401489; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nopJoLIJVNXWQLeDX2Hcvbg342jeNYWKWWtajWtfO0w=;
        b=BE7wg4P61rtRrpCjhDri5gKeyy1+PPBfaD/r5HnTWSDgOOk0DN4wYIoUD5kKYJ/hk4
         Xfi5FP4m4hZ2AYI951XlqruwSGLAGanWCzEA2J3mGutidrhKUh4SQNqybOY667ZbepVh
         sv9RaVlDLBm1mu/M6lfoEl0Uo41D97cqSGkPkrBo7ynSK20jcFT9W1cmvjy/57UzdKmM
         thAlOiEBseHUUcH35thUKacDDqv102mZUvOajUbx/K4H2UM3JFgRHGETOaXU43mbLONV
         2g5Li4Rb8bqwGK+lrmfio6QbJeZP6I8RYBT7KFYztAMgE7q/MOpvtmOUtrDjWezSDXUz
         Ue0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788796689; x=1789401489;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nopJoLIJVNXWQLeDX2Hcvbg342jeNYWKWWtajWtfO0w=;
        b=G+CGL5UfU+DNkBY0VfYVzoqzbwF/HJcYO6Gr/dImP7qVJpExulLlhOdm7YPM/GsAd0
         XPtgjLeV3mMoykM9guC1RFB2pvLzX9EMm6RrVe3c+IRXZcWbkW0fWBl35NrM3Z1rrBRW
         EASb8/IZEWrUW29+wvZRKDHe4C5PHqqSVHIMycNf82p1Ci+BvCYup1UFEWBH60R2bJr3
         sMNet//zgmJJFiBsbG3KOQ7RvkGIzMzeMBZrjALwvX0PRobMl8YrSaZHftenJA0ZgJhL
         4mQSximM3N8evlmnD3Z0c53d8joEDK871Tqr7tKR6V8ZCovDVmED0mTSXSLdzLWTN6tG
         c/Tw==
X-Forwarded-Encrypted: i=1; AKwUvByiExhpyXVELkZ0xOCmpxcUfyJDklZPlr3RPEf1xUONETaB/RBSe/C+S3bJFgJHcb5F4+S5MKf7uQ==@vger.kernel.org
X-Gm-Message-State: AFuF++k2vsSnor4myClFBDjNZkwjC0XFMtYge8SPxc7gcK7GpWuvknpI
	L55UVFIICAXJNuOUURJ0hTZ3lPi2VqksMxiwOk2TVA4bDJHhO343PBAnDSDCCntnhETvoAmj59m
	BMFuk/52sJyq5QxoNqkIwctAfTgwDZOLXrYe91F3cSg==
X-Gm-Gg: AYBFou3hEFA1CgnR0NqRvGgyh2/o3yhSevZsYfa9x0wfTvHfvCFAnqlsqTOUmc0X0LI
	E6frZ/cgoM6Na4E/PZZrJvHfantjTiC1Cv3RBIpwF//9WDHPjfzP90Yrb3R60qcm5zTXMGesadZ
	7A85SdcOgSH2TPZV4UUsJ7grcvg6fsN9ZdZSXZSxCO0N4rscRNCyKq5WqaTUOSkDDUDEAXj+vza
	2nW8LJjFGNupnBLVySJmyjiacRcr+IriricAWmO/Y98Ojrr0+k+3g9DAst2BhpdLErFAfBuIq4A
	NmK2D+aObsw6+2G8PiIDfDztOLuDofx6TWiK1i1rPXK4dP9RQw2sUuzOuRgiBHnDvQ6UT/Zhyqd
	Q4TF/xf41AUHqBLK1SKdi0Xyzwi6d8PGA9mrqf7Dv8ZZvkpIfnlA6GZxUWed7SGqF7srm/4AoK+
	YTS3tP++M95M7MjBHTi4JrRqDp3r6i27TFXKqXGP5RkHfQIm+os5B6UtOyY1YMgXgWEqc1P83OI
	hmxh9OtrDfQm+fvxSvYnbnls+e3YMXsbN2Ldwk9cV2KwT0jJlLYZR61nEgVCXUIH9/XWwprqAno
	keci1MG0L04YBoO0a+t7OK3FaC/S3tjoDg0fkI7OivvY2bPP9B+FV2DoGiQHAX9LskZKg7HBrYI
	jHJB3lgco4LjFfVbhxhcMpv+H/czqA/Ih1lKItwqgje4=
X-Received: by 2002:a05:690c:f06:b0:81f:e7c5:f420 with SMTP id
 00721157ae682-87128eb5216mr102573537b3.20.1788796689408; Mon, 07 Sep 2026
 08:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788259938.git.jasmeet.bhatia.us@gmail.com>
 <a9e23066-aa75-44be-ac3b-9a15f4cf6047@app.fastmail.com> <DL6NCV1KQ9F9.6K6XZQCS4AF3@gmail.com>
 <c3ca811b-a6eb-4f4d-bbb2-4feef02e3db2@app.fastmail.com>
In-Reply-To: <c3ca811b-a6eb-4f4d-bbb2-4feef02e3db2@app.fastmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 7 Sep 2026 18:57:33 +0300
X-Gm-Features: AcwNN1X5lVzY-VVghdr231z6GdYRJyb_3-BGRdPWok47tN8y6tOFHleN_U7rMRw
Message-ID: <CAC_iWjL9jDsRaU7kEemYfwk292Nxa49cK0Rq=81pC=FWNRDhvg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] efi/tpm: Preserve event log without changing x86 E820
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "Jasmeet (Jazz) Bhatia" <jasmeet.bhatia.us@gmail.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@ucw.cz>, linux-efi@vger.kernel.org, linux-pm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ard,

On Fri, 4 Sept 2026 at 19:39, Ard Biesheuvel <ardb@kernel.org> wrote:
>
>
>
> On Fri, 4 Sep 2026, at 17:45, Jasmeet (Jazz) Bhatia wrote:
> > On Thu Sep 3, 2026 at 7:18 AM PDT, Ard Biesheuvel wrote:
> >> Hi Jazz,
> >>
> >> On Tue, 1 Sep 2026, at 13:34, Jasmeet (Jazz) Bhatia wrote:
> >>> The EFI stub currently allocates the TPM event log as
> >>> EFI_ACPI_RECLAIM_MEMORY. On x86, this becomes an ACPI data entry
> >>> in the E820 map.
> >>>
> >>> On a Framework Laptop 16 (AMD Ryzen AI 300 Series), the EFI allocator
> >>> can place this allocation at different physical addresses across boots.
> >>> Since x86 hibernation validates architecture-specific data from
> >>> the firmware E820 map, this causes an otherwise valid hibernation image
> >>> to be rejected on resume with the following error:
> >>>
> >>>   Hibernate inconsistent memory map detected!
> >>>   PM: hibernation: Image mismatch: architecture specific data
> >>>
> >>> Allocating the event log as EFI_LOADER_DATA avoids changing the E820
> >>> map, but doing that alone would regress the kexec corruption issue fixed
> >>> by commit 77d48d39e991 ("efistub/tpm: Use ACPI reclaim memory for event
> >>> log to avoid corruption").
> >>>
> >>
> >> As I replied in the other thread, I am not convinced preserving the TPM
> >> event log across a kexec makes sense to begin with. This is the firmware's
> >> view of the state of the TPM PCRs when it handed over the system to the
> >> first OS.

It doesn't make sense imho. The only thing you prove is that you
kexeced from a 'previous good OS', but without knowledge of what that
OS did before kexecing.

> >>
> >> If the first OS boots, loads a kexec kernel and then boots it without
> >> measuring any of that into the TPM, the TPM event log will match the
> >> TPM state, but this is meaningless because of the missing measurements,
> >> and the attestation chain is broken.
> >>
> >> If the first OS does perform TPM measurements, it would need to record
> >> them into a log and pass that on to the kexec'ed in some implementation
> >> specific way - it cannot use the existing TPM event log for that.

Hrmm, that might be problematic. The EventLog needs to illustrate the
state of the TPM PCRs. IOW replaying the EventLog in memory should
match the current TPM PCRs. But that also means we'll have to teach
kexec how to properly extend the PCRs and update the EventLog.

> >>
> >> TL;DR perhaps we should just discard the TPM event log reference from
> >> the EFI config tables after consuming it. Or add a special case to the
> >> kexec code to disregard it.

I can't decide what's best here. IIRC we don't expose the final event
log config table in systab right? So we won't break any user-space app
that depends on it.  We just copy it in
/sys/kernel/security/tpm0/binary_bios_measurements. In that case
getting rid of it would work.

Cheers
/Ilias

> > Ok, honestly that makes a lot of sense I see what you are saying and I
> > tend to agree. I'm treating the copied event log at something that
> > survives kexec in this patch because of the corruption fix so I'll look
> > at dropping that LINUX_EFI_TPM_EVENT_LOG_GUID reference and rewrite this
> > patch. Hopefully, that will avoid that x86 E820 instability as well.
> >
> > Appreciate the guidance!
>
> Please don't send any patches yet - I'd like to get some input from other
> folks as well.
>
