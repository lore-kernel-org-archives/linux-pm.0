Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9162C3266
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 03:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789095800; cv=none; b=d84sQfu76f6KXVtEqxpW2NCnGOnUPeOItvXi3Z6rkJQ9eWMi2Tw+4kTQu00QxyVAaF7DEvEOCpI02Z5dF8YDxfmrixbcJ/wOb4abGSie+95lamPr2XBzLkDZVijg2Y7xzP+YyrBnGidryTi8sAvqBbJvJrA6Le7YmfwsMP6fq5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789095800; c=relaxed/simple;
	bh=UL4IaLvDYf4eZDrQo3pMfd8B5yVZDGWQIefeXbbQrAM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=V16/F7k7NxIe3kVZYcb9S4BpTEmztZYk5qV6C9lfMTlFB/bz4EOklv3OBfT4//0r33fLMWPRR9YhUtp6rjpZyZr/hJbuKRak/aa/2OXAumJbTLfJR5hTF10DFWimjzTTznyZ/ZtJ0QhRQCsQiD1+arY2B4/DXQDcgakjsfVNxJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTTsMU2t; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTTsMU2t"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6bd07679624so505563eaf.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 20:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789095798; x=1789700598; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0nnirejavAbxn9gQ8vj1fIYctFpSqsa1QzZ3kmf8s7Y=;
        b=JTTsMU2tAVJBPl34IX0LC5kUjClmXfeInt0mwTvfREf920JKgGQnPQO9/KLi0EsXG2
         feMKvTyMWEQJVmCjtcE1OrAAzfvlZHXuGT22b4n9y4wyp4L/I9GdkmSZJzJvo6XmamZV
         1GLj75qZFGgZhRMmHtOBzLCTJpmRHzjQScmsdg71+CyzVIoBvh/W+OE7SuzLUwUDZije
         QPPiH/5/4W22/dW+xnmQXanAYNLlhIaDAmD5otRORKS5IxJ2dRBElrO5Z90bcDdbHt+S
         O5iV3m2xtBRTMLYHY2dwG/WGWm07tyFtEeON8Z7/gDOcGE3fOT5Ow13WA1N5gWVkXuKR
         ZG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789095798; x=1789700598;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0nnirejavAbxn9gQ8vj1fIYctFpSqsa1QzZ3kmf8s7Y=;
        b=Q8t75HYQEzIQdiX0HrfpI6ECXbSxGXAs3inLebuCoYbktqWB1evBpKY/FWKrYp/jnZ
         WuDfybF03izZ6n5ti2/cF1tuXVIzfJse71OZWJ0uIAiOsxG6EeJuP439CbK99xJzOdy+
         mfL1W4hnAzRcqtT2RQ7WQGqp/BQf0r6UyOjb+QLLVpPjME4LKmlCnfF9BaiKxBu/eU5t
         mB4kwQ3nyG2KPcYtGUSaH6e5FBuK++gAVjNmirdS8jepj6sWYFvaI4gVhToH2aR3AFmF
         NpQT4Ut73rAu1915hy85PIGOCiiVyDaaEg2M1Rwfq8t14S/gilSy4iS9q7/CazGDhjfh
         t4Fg==
X-Forwarded-Encrypted: i=1; AKwUvBwXUz741tVj+eD1bTeMDftwrTJa26Fi8OIzsGzNF5e7EwP9O9kwn2Ks7N/EOcQgwoVrFuo/isC23g==@vger.kernel.org
X-Gm-Message-State: AFuF++lQ0qOiL7d45pTIcbvqZrajfioyIwoWYsiO814szJHNDUhcU9Is
	o2YxL2chjrf/zyIh8hQWGhGuDY0vXQnrN2bea8qkKgmSCi3Iuwj6nCGH
X-Gm-Gg: AYBFou2wSJBu/Ozc78xRpy3+AIQe060x+CPiPvyX/Hr788oFQ9A++HNG4CEZVeBxJQl
	152b8EiVwAg1J3fD2ncrATKKamoHuxwXOnlw4BHxdQ0qKFNjafaEEZUNBHcFOZmGaZCxBufR4yu
	QAGaUu1ogeigFhvu9HPXz/F0I14K0UETM+uZH4USapy9Bepsx7RuBKw/EXzkI8jMsJvDeuHJgJ3
	54MAiHAIzaUf8mwvaDfcrzvrnZ+MLPXZNhe4/2CXFHQ81uOG3dBu51ol3U6VdL+8JAEU4Mu6iHd
	DACYq6J7aASFBGjaaIp/c/00XSg8g+XEVXcZuyr3frYn2p/gLBUoBXZ6b07EOoU9qm72wXMj3AO
	A5by5ChTCsNJFTgXCi3LczOAkSahczqqd2lQX9UIFigQTKH+jQ826LcYUvxdogV4/54RJwVquEu
	lyjSq0yo1/N3PZdECP9dttpqCbDMk/q/eZ55Ms3yH6TQ9h6sP7/T7CD6861e+6dT3jQqQcDFht+
	OSfPumPtYVtUxWviBrKsZax6OsMKFMm5A==
X-Received: by 2002:a05:6820:61b:b0:6bd:fbe8:fb95 with SMTP id 006d021491bc7-6c0be1502f9mr1256940eaf.60.1789095797410;
        Thu, 10 Sep 2026 20:03:17 -0700 (PDT)
Received: from localhost (ip68-107-67-45.sd.sd.cox.net. [68.107.67.45])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e9b359sm2093108eec.14.2026.09.10.20.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 20:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Sep 2026 20:03:15 -0700
Message-Id: <DLC5J1TZ2XOC.NRYCTBZ72424@gmail.com>
Cc: "Jasmeet (Jazz) Bhatia" <jasmeet.bhatia.us@gmail.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>, "Pavel Machek" <pavel@ucw.cz>,
 <linux-efi@vger.kernel.org>, <linux-pm@vger.kernel.org>, <x86@kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/2] efi/tpm: Preserve event log without changing x86
 E820
From: "Jasmeet (Jazz) Bhatia" <jasmeet.bhatia.us@gmail.com>
To: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, "Ard Biesheuvel"
 <ardb@kernel.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <cover.1788259938.git.jasmeet.bhatia.us@gmail.com>
 <a9e23066-aa75-44be-ac3b-9a15f4cf6047@app.fastmail.com>
 <DL6NCV1KQ9F9.6K6XZQCS4AF3@gmail.com>
 <c3ca811b-a6eb-4f4d-bbb2-4feef02e3db2@app.fastmail.com>
 <CAC_iWjL9jDsRaU7kEemYfwk292Nxa49cK0Rq=81pC=FWNRDhvg@mail.gmail.com>
In-Reply-To: <CAC_iWjL9jDsRaU7kEemYfwk292Nxa49cK0Rq=81pC=FWNRDhvg@mail.gmail.com>

On Mon Sep 7, 2026 at 8:57 AM PDT, Ilias Apalodimas wrote:
> Hi Ard,
>
> On Fri, 4 Sept 2026 at 19:39, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>>
>>
>> On Fri, 4 Sep 2026, at 17:45, Jasmeet (Jazz) Bhatia wrote:
>> > On Thu Sep 3, 2026 at 7:18 AM PDT, Ard Biesheuvel wrote:
>> >> Hi Jazz,
>> >>
>> >> On Tue, 1 Sep 2026, at 13:34, Jasmeet (Jazz) Bhatia wrote:
>> >>> The EFI stub currently allocates the TPM event log as
>> >>> EFI_ACPI_RECLAIM_MEMORY. On x86, this becomes an ACPI data entry
>> >>> in the E820 map.
>> >>>
>> >>> On a Framework Laptop 16 (AMD Ryzen AI 300 Series), the EFI allocato=
r
>> >>> can place this allocation at different physical addresses across boo=
ts.
>> >>> Since x86 hibernation validates architecture-specific data from
>> >>> the firmware E820 map, this causes an otherwise valid hibernation im=
age
>> >>> to be rejected on resume with the following error:
>> >>>
>> >>>   Hibernate inconsistent memory map detected!
>> >>>   PM: hibernation: Image mismatch: architecture specific data
>> >>>
>> >>> Allocating the event log as EFI_LOADER_DATA avoids changing the E820
>> >>> map, but doing that alone would regress the kexec corruption issue f=
ixed
>> >>> by commit 77d48d39e991 ("efistub/tpm: Use ACPI reclaim memory for ev=
ent
>> >>> log to avoid corruption").
>> >>>
>> >>
>> >> As I replied in the other thread, I am not convinced preserving the T=
PM
>> >> event log across a kexec makes sense to begin with. This is the firmw=
are's
>> >> view of the state of the TPM PCRs when it handed over the system to t=
he
>> >> first OS.
>
> It doesn't make sense imho. The only thing you prove is that you
> kexeced from a 'previous good OS', but without knowledge of what that
> OS did before kexecing.
>
>> >>
>> >> If the first OS boots, loads a kexec kernel and then boots it without
>> >> measuring any of that into the TPM, the TPM event log will match the
>> >> TPM state, but this is meaningless because of the missing measurement=
s,
>> >> and the attestation chain is broken.
>> >>
>> >> If the first OS does perform TPM measurements, it would need to recor=
d
>> >> them into a log and pass that on to the kexec'ed in some implementati=
on
>> >> specific way - it cannot use the existing TPM event log for that.
>
> Hrmm, that might be problematic. The EventLog needs to illustrate the
> state of the TPM PCRs. IOW replaying the EventLog in memory should
> match the current TPM PCRs. But that also means we'll have to teach
> kexec how to properly extend the PCRs and update the EventLog.
>
>> >>
>> >> TL;DR perhaps we should just discard the TPM event log reference from
>> >> the EFI config tables after consuming it. Or add a special case to th=
e
>> >> kexec code to disregard it.

Assuming we drop the LINUX_EFI_TPM_EVENT_LOG_GUID reference after the
kernel consumes the log, is that going to impact any in-kernel kexec
path that expects that efi.tpm_log to remain valid? Or is that reference
only needed during the initial TPM event log import?

I'm trying to understand whether removing that reference is just for
stopping the next kernel from re-importing the stale firmware log, or
whether other there exists other users of that reference.

>
> I can't decide what's best here. IIRC we don't expose the final event
> log config table in systab right? So we won't break any user-space app
> that depends on it.  We just copy it in
> /sys/kernel/security/tpm0/binary_bios_measurements. In that case
> getting rid of it would work.
>
> Cheers
> /Ilias
>
>> > Ok, honestly that makes a lot of sense I see what you are saying and I
>> > tend to agree. I'm treating the copied event log at something that
>> > survives kexec in this patch because of the corruption fix so I'll loo=
k
>> > at dropping that LINUX_EFI_TPM_EVENT_LOG_GUID reference and rewrite th=
is
>> > patch. Hopefully, that will avoid that x86 E820 instability as well.
>> >
>> > Appreciate the guidance!
>>
>> Please don't send any patches yet - I'd like to get some input from othe=
r
>> folks as well.
>>


