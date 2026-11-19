Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795068700;
	b=45axo0JIUr7JUgX0AX1D4LXg4qmWRhUtwJwkJFi6ZseNxyD0sUzc6OEPChPVvyCbPM7b
	 nXsTYqzaxZmj4n/HD3KQdM3Yds3D37MNow+4pkDlS1KEg6QxHMc9aR5HgBPCwFXhwO85R
	 QP7oQALEg4vsJSoriBQpi3FWQXVoo5uR5+Yy+TANpEpJ9P9mewNaQxtxuycCXogEB8Rhp
	 mUd4iWN+OOcV6mblVtG9QW8adxiD6nmnEwgQ1Kbk/CnttcQ+dd4HVr+ubqTZ9O/Hb3rOO
	 O5I285fUHOp8FyzaF03SGlgmzjG86lNr5NEJ/dLTdKGd2lB9AEMAhc0rK3s/xDahqUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795068700;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=+i7fLpQgbGWXsa4bKAmBMh9yPr9gG6NW6Mco48SKmuE=;
	b=oZeVWJr7K0/VXb17fnpajnNPMXvMB/3go6dXAI4BBvu07vuhUHOmmLQMyH8jTTL5Vgnf
	 14jx4gTbRkrtsskk2mnFdrWFgJga8+jSKYnQSNYqOI2Xn2hj3TzkxyEeH50pnEoh1j39t
	 LZ8E5huMFt8NXtUzWD32mWrd/vwJD34wZntYp+zZteh/C+0ofqwQq+EhEsWATjXRRyTBn
	 xO0XmmWZMctJlTEc+U+t07SlXoTgv9ORT0gUVMPLIymOpZjR0ZxNblZCEQw7CqfUc1FV2
	 MZy6MccT/36bM0Rw4tXC6nfzfRTK6G8QHpF97ebbQLYG2so8h7FI4roFzVBwI1/eT4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=U4mnEIRn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6377B606A320
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 06:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6377B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=U4mnEIRn
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67c58f18765so1324058d50.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 22:11:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795068699; cv=none;
        d=google.com; s=arc-20260327;
        b=Bn9ZmlTB3ejtagnMJ+DWENPdzP4Tmt85ixnGDohnVvJXt/6IXd73wemuIsG/0Ohs0p
         nZbOn+j3UxGhYl5pTXZ5lIXc5lmziYL6xPxJdCPIpYQhbwZ4wEOEmJB3FVFpRP59ioyF
         mJ/W9rrIiF+It6dSC6tv38nkncMIbyGkCo2dZz9AtbVW6hE0sxaRh/a3X/cG490XSgOo
         lZAMY23PXP3KXOZvGBX15n1h8wnNyZOvHLel2tkljUUQqSWgnllRsk+eQz/Jfg1DAFzn
         +/87uayTVMaxGiFdINxUEKlOojj763JMtpEMkMsyGaApVNsVkSItn63vUyW7sbtsV13A
         t2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+i7fLpQgbGWXsa4bKAmBMh9yPr9gG6NW6Mco48SKmuE=;
        fh=g+QKp0kMDm3L/MwQgOT0bt6hcEfXpRcDClOJrBKfZlQ=;
        b=G0S5641b+aznnnV8F7493NKqvDH/znjTP3+pu6bnm/KLencnf7cjPaZY/Ic4kuqtu5
         sGfKXM0mlixfogj7RFxBpY8q25iDM6LarDgIVv2DfMWOLkiQsRFMKRzkjL+NviACtOL6
         nag2E1Yd6sIOHMT0rk58wRV7olth8RK4G4nHvAcZ1cFntIDLVlFsas1YhQpQg6Wsw3il
         93pOhqb87yJXkZBN/Lf1eWSqMYqzgsplOLTPalI9ziulTLHIruIBhEzDYBBvO227v41D
         5wRBxmK24//BQx6SJQlr5mHvvJ1jktTG04g9iFqt82erIjwsybN0ZtqekoRrCzzC6uUj
         hvzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795068699; x=1795673499; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+i7fLpQgbGWXsa4bKAmBMh9yPr9gG6NW6Mco48SKmuE=;
        b=U4mnEIRnOIJzuc0QmHuxU9tV3N4an/q6D1UgnsUgZemoxg1Q88SL1yGGAlc/jmxEMq
         7kFSMRpo4TnTvtl6trNPHFRR4ABXgRNScK+szwWRTISaA4ejH08dW+QLHc1umkXoEBGr
         uJs9+lwqVd9qAXrYVi92Pf9eiaHyX/40a6Odb0LtGWI6MqEu8q3Qy9PZkIO9nf8pOiYi
         CQcI84dqINbjZk7l1aN0pMYFSZQSBL69onhtNlz5LSOhG7D1NfVhISitmaw4SqlP+MMp
         fGqTQ9HuHZv5SCdk7+DSLFuok7GFgjD0TErBfWJMZe2odqBSiCJR23eUNB/6wAMBmRNJ
         mdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795068699; x=1795673499;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+i7fLpQgbGWXsa4bKAmBMh9yPr9gG6NW6Mco48SKmuE=;
        b=xw7wNQ3tUDOotSri2N5/H9JN3Uw097N/SNMZ6R/6w/FVqdOfWdHZ+u+Sg/T5jZY6JB
         xQerdN5nogJUPF+SqONDXT1tSUrg2fmE2s1vOQzfFERrlBHCdBZ3PQ5hHQh8VDxHT+H0
         8w5MbKvO0FGWIqQsa+Toid5ZdIrCtJSgr6G5cQViYBhIWt6jK1k8utmIOmKDfH+pIag4
         aMqaY7UsjwPj22HxVuh7HhISe+J4IfU6Lqwt87sqE0DIsnPDqbLWJOZ8DcdZcoKGkt6K
         xm2aPPqDR8aqXmwf/wz91OKfPd+b6f6CSl97cd1HluhPBJYxMDNv4LvMHNpD13I56aGO
         PXbA==
X-Forwarded-Encrypted: i=1; AL+hErHHekOvttpL35YHX8wnNcc1WYpQy9XyrBCgAAjfRJIAxJ2zTz75u6hb6PPNxDQcEnEoNpBG5bRDcg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/AvuusnisBShyd7tM7LZ1hr7oUSVntVXnJWswzWbGoPFXoSVe6
	xLo/lhNDBrDQF1VxEFDM/6KtdQQkSPbLVjowpeaHg+p17oc1bbKNDwXJRz0meSZPYWjgcVMyCVB
	mZO1K0IFlw8MQIq47ioaT78Nw4p0/sZs1kYt9MBmYow==
X-Gm-Gg: AZFdTZe7WkgfB9PFuHBlg06axRpzjSDlm+nUxUNO3PHyG12F+GqbafNhjS1kzgjLE4k
	Pf9qp3LUWTPAenIpM/6yldZ+8oDs7eKfFmT1HSohJG4lROZeVUFsyM2cBCPRJmaGGtcWOtZvo6y
	4JwngKXP7iPt6BQJ8V98Onmok3PFdhqY1SoYmQqUCDvOj2I6DdC7N8fgPEPXvgZD6jCbEZbpsiV
	y7D/n3RjFeh0UELj4GJHaLayl5PMb6WjdxGHG6a9ZCh5yIcdwZHm+Zfgb5zK8KOOosErenNgIuu
	b7puc/rN/9x92JRuuGLWJlWl/M8ZqaPnTpT7qUwjbgunIRw9nifivGJ1tVFobYlJc1OeJuSGluN
	HPwTuOw3sudai6Ry/YlHiAQRowvoDvm+xH56pNMsK7JpN6ME1ADFxLdDD2Ga8FNfXIbPL3S3c21
	yTXyySXDUkhvFoEjd79ugFGOlzOZDHjlj3MrRQoKIJY0frPBFsmT31M1tsviJTke9DzpJUDp/kN
	1r7CjMhr8xNvPv+R2QIgaqjM/xup/G1vXiiRgAQC3lRhZ8dL15bo4Y1foq06evqwf9J1nf1dJpw
	hqGjQd4gLIGi6X6yWy2Ng/HphJsicOYcx4XPuN3wjq21V84J+osIrt4Xf2f5BZN5ioRkV28sh2e
	ZIBxzjkG+fCUs7hUT7EfFR0tgjI9xHWiU3PUIh5pPu7Nug9rXIc2FE7sJyHhf3o2ys5ttAKo//H
	LxOLExoOEjB67u8/4i5TojYolHdzSWnxY34zi77qWSlqose8AlrUeweZWat0Iv+JSy09yn
X-Received: by 2002:a05:690e:158e:20b0:672:9f72:7c0b with SMTP id
 956f58d0204a3-67dd404ae39mr1379048d50.109.1795068699305; Wed, 18 Nov 2026
 22:11:39 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1788259938.git.jasmeet.bhatia.us@gmail.com>
 <a9e23066-aa75-44be-ac3b-9a15f4cf6047@app.fastmail.com> <DL6NCV1KQ9F9.6K6XZQCS4AF3@gmail.com>
 <c3ca811b-a6eb-4f4d-bbb2-4feef02e3db2@app.fastmail.com> <CAC_iWjL9jDsRaU7kEemYfwk292Nxa49cK0Rq=81pC=FWNRDhvg@mail.gmail.com>
 <b66f68b5220ddcadddb41340d3ea3388@gmail.com>
In-Reply-To: <b66f68b5220ddcadddb41340d3ea3388@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 19 Nov 2026 08:11:03 +0200
X-Gm-Features: AclHuK89rr8JCP4LjUM9lxwdzxvtIWH4RA9tyZloAfhEcmTE7ZH1lrQpq4myxc8
Message-ID: <CAC_iWjJ1L5MYWy2vHG3AHYcfqx7urJmaTYP7vuyvZm8GSnWCDw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] efi/tpm: Preserve event log without changing x86 E820
To: jasmeet.bhatia.us@gmail.com
Cc: ardb@kernel.org, rafael@kernel.org, pavel@ucw.cz, 
	linux-efi@vger.kernel.org, linux-pm@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jasmeet,

On Wed, 18 Nov 2026 at 04:57, <jasmeet.bhatia.us@gmail.com> wrote:
>
> Hi Ard and Ilias,
>
> I wanted to follow up on this discussion after a couple of months.
> My bad at being slow, at keep this discussion moving.
>
> Has there been any more considerations with the preferred approach,
> regarding the EFI TPM event log reference and kexec?
>
> This issue is still relevant to Framework 16 owners and the temporary
> fix has been confirmed to work for other users despite not being a
> proper fix to this issue.
>
> I'm always happy to prepare and test any patches once we decide what
> direction we want to move forward towards!

Ard suggested we discard the EventLog on kexecs and I agree that in
its current state it doesn't offer much to security. Is there any
specific reason you want it to survive?

>
> I appreciate you time and patience!
>
> Thanks
>
> Jazz
>
> On Mon Sep 7, 2026 at 8:57 AM -07:00, Ilias Apalodimas wrote:
> > Hi Ard,
> >
> > On Fri, 4 Sept 2026 at 19:39, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > >
> > >
> > > On Fri, 4 Sep 2026, at 17:45, Jasmeet (Jazz) Bhatia wrote:
> > > > On Thu Sep 3, 2026 at 7:18 AM PDT, Ard Biesheuvel wrote:
> > > >> Hi Jazz,
> > > >>
> > > >> On Tue, 1 Sep 2026, at 13:34, Jasmeet (Jazz) Bhatia wrote:
> > > >>> The EFI stub currently allocates the TPM event log as
> > > >>> EFI_ACPI_RECLAIM_MEMORY. On x86, this becomes an ACPI data entry
> > > >>> in the E820 map.
> > > >>>
> > > >>> On a Framework Laptop 16 (AMD Ryzen AI 300 Series), the EFI allocator
> > > >>> can place this allocation at different physical addresses across boots.
> > > >>> Since x86 hibernation validates architecture-specific data from
> > > >>> the firmware E820 map, this causes an otherwise valid hibernation image
> > > >>> to be rejected on resume with the following error:
> > > >>>
> > > >>>   Hibernate inconsistent memory map detected!
> > > >>>   PM: hibernation: Image mismatch: architecture specific data
> > > >>>
> > > >>> Allocating the event log as EFI_LOADER_DATA avoids changing the E820
> > > >>> map, but doing that alone would regress the kexec corruption issue fixed
> > > >>> by commit 77d48d39e991 ("efistub/tpm: Use ACPI reclaim memory for event
> > > >>> log to avoid corruption").
> > > >>>
> > > >>
> > > >> As I replied in the other thread, I am not convinced preserving the TPM
> > > >> event log across a kexec makes sense to begin with. This is the firmware's
> > > >> view of the state of the TPM PCRs when it handed over the system to the
> > > >> first OS.
> >
> > It doesn't make sense imho. The only thing you prove is that you
> > kexeced from a 'previous good OS', but without knowledge of what that
> > OS did before kexecing.
> >
> > > >>
> > > >> If the first OS boots, loads a kexec kernel and then boots it without
> > > >> measuring any of that into the TPM, the TPM event log will match the
> > > >> TPM state, but this is meaningless because of the missing measurements,
> > > >> and the attestation chain is broken.
> > > >>
> > > >> If the first OS does perform TPM measurements, it would need to record
> > > >> them into a log and pass that on to the kexec'ed in some implementation
> > > >> specific way - it cannot use the existing TPM event log for that.
> >
> > Hrmm, that might be problematic. The EventLog needs to illustrate the
> > state of the TPM PCRs. IOW replaying the EventLog in memory should
> > match the current TPM PCRs. But that also means we'll have to teach
> > kexec how to properly extend the PCRs and update the EventLog.
> >
> > > >>
> > > >> TL;DR perhaps we should just discard the TPM event log reference from
> > > >> the EFI config tables after consuming it. Or add a special case to the
> > > >> kexec code to disregard it.
> >
> > I can't decide what's best here. IIRC we don't expose the final event
> > log config table in systab right? So we won't break any user-space app
> > that depends on it.  We just copy it in
> > /sys/kernel/security/tpm0/binary_bios_measurements. In that case
> > getting rid of it would work.
> >
> > Cheers
> > /Ilias
> >
> > > > Ok, honestly that makes a lot of sense I see what you are saying and I
> > > > tend to agree. I'm treating the copied event log at something that
> > > > survives kexec in this patch because of the corruption fix so I'll look
> > > > at dropping that LINUX_EFI_TPM_EVENT_LOG_GUID reference and rewrite this
> > > > patch. Hopefully, that will avoid that x86 E820 instability as well.
> > > >
> > > > Appreciate the guidance!
> > >
> > > Please don't send any patches yet - I'd like to get some input from other
> > > folks as well.
> > >
>
