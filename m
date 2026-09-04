Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5353C381EA0
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536736; cv=none; b=ZojzzH7+83CfCAkrFWc+oQpT5zn9jmCKr3WD9qAIPpLys7S9bl10ibcKOzDKyQUJ2hCT+tnvr83Dffr/vU7LJWuOG+VamXRHjhISBepNqNCHUUEsO8Jom45keV5LgI9B9DB7dnkjzLbQyLtLSYxSeZTXKJQ8nPKAtc2/BXS9ERk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536736; c=relaxed/simple;
	bh=0i2ur6bxtGesXmSKwhHP+Be/MOfypFS0q4OAYvJgvzc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=ttEc7Tn5SO7HWzrd1ozkK1fdIfDFx2pzjOO0yxtvzajgGUerdoDvk1l6MfvIC0q94bEdM7WqadVeAofoJF44Uu/cZRSyS40BwkUpwX4CLQQel3faMVZX4PQ2p/VVQzIgb+6ifXvYtruYEWSYcycBoBoJpjvG0NBpEImEusRqY2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdiRSc6r; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdiRSc6r"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e9ecd7216cso1075735a34.3
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788536733; x=1789141533; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:cc:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BdtITZOav3pjxc4SwRDxA49yanevszl3jiRD/k4W2wY=;
        b=mdiRSc6r5WoW+yNAAv7KediiqRmlIppeS3eaO94ejHpsjvSAW2yR0Zc1wR79aVRtut
         VKgTA8RAM5mDy1KoCU92lEH7lz64uT3Ad5/BeCTbKAyTLRFhoo6qLFep8YsUk7hxAnLt
         SGp7UDRIdptJoEj1NkKVBnkqHss2bFkm07n7+72xeXcOnkpFMjKqLKmpM/nzAlY6tWWB
         cHq2nr9Iwlx2jEZOJ7iJ77GxHL8HQZwVKXbIK9qp3VcrFutLNDtXcG01Zm81CKqAeelq
         vVfrCeMKlpmD1plMZecK6c35rQVh3TzzOP4N7bk3eIATJMz5qkzny9VEMxXvYQ/aGK6i
         2zjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536733; x=1789141533;
        h=in-reply-to:references:to:from:cc:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BdtITZOav3pjxc4SwRDxA49yanevszl3jiRD/k4W2wY=;
        b=En1whBK8KyoJ/HZBDxCZdzY+aioM1wZtGqoMiQjCo6dR60uTwOe+tybbyLzRKZvwKu
         wHu9F5wAAcgs2ZcIC6bNbVDD/0fZ6F0NgbO1NSPeNfGJnx8oHupU7u+In5wMnBT/pI2s
         p6piTUAWhe4HqAprp38KyudIa/LlgL4oG8/i83WEOd7texnKfhXbJTEwQn8vGMnJrMS7
         waUzp4s0rMo/dhC0vleg9LREHkxMDYi5NWymjqRII53IuZpuVWe1hJ6Yau8XSmrtY/GV
         9d+XNiYAQYbE1K3yTrvr5Mcov7Xqslgn9UvPrcpLHPx2JQ69aP8xkysDXI6NVQ8yGdjN
         REUA==
X-Forwarded-Encrypted: i=1; AKwUvByqvPZJS89B+9SkUNZmryShmLc4Cqxsn6Iomr+NH1bEIH1eFBwMb1pbHVIAb4mf4ypigRP2Z1xqtg==@vger.kernel.org
X-Gm-Message-State: AFuF++kSopZkbOsAWhXbMYAQQpUVpbwDIS8ZSnn4zZRi6npGzCobuu/V
	QTbKMZaRKIi5H4L8N6+T5v/rGhmavw0dooupsoAn7A9NQlcOeVBSX1ZQE9lG8J9pt7Y=
X-Gm-Gg: AYBFou34pMKq16NPftSLc4jVMoscy5JL2cFOFMYnnmrxw8nXOOUiw6FH+uK30Lc77p3
	cKg6q3eIfgZj1YKYxpVCGdtNCy/8NyEWiE4i9tONZDNv8QW/wB7+MAkZXRWFB9CFafH9x6iG7VM
	AtgtOyeM8vvbn14nY29WLv5rs0WFxrOqYpxwlOAVvbRWkb8C6vdf+rSWs27UXs+ABB+XcxSM0lA
	T1SQ3PWjuTYEkldSgjiqK1r3wRwHsNQMQTrWK2LvXPOb5z2dOGkJWRa/hVCOHYS1rDjocml8iiT
	qymdxAY5uT6bKpO8uM650FEcoENpcR7Bx++/cKGmJ+G4iDqvDUwNEWrGfWOkT+e4AGc1vwynPKq
	FS7J5rJrru5KBumHKsvaWU5cy59SnfG8Yg8tYzZX1ARV4SaJFepRQrHWai4OzSkV8JHTnOQIPWU
	mR7+zLN/D5sVw+fsAnxD85gla0C97+3R4ysFRI4Dys0PgMaq75RqFA8ZOGjtnlKGqu/61kfuw4Y
	V+roINAliQUySevTWTc8SM=
X-Received: by 2002:a05:6820:179b:b0:6ae:774d:45ab with SMTP id 006d021491bc7-6b6fd8cdab9mr5371183eaf.27.1788536733038;
        Fri, 04 Sep 2026 08:45:33 -0700 (PDT)
Received: from localhost (ip68-107-67-45.sd.sd.cox.net. [68.107.67.45])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243bfbe3sm7513320c88.11.2026.09.04.08.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 08:45:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Sep 2026 08:45:30 -0700
Message-Id: <DL6NCV1KQ9F9.6K6XZQCS4AF3@gmail.com>
Subject: Re: [PATCH v1 0/2] efi/tpm: Preserve event log without changing x86
 E820
Cc: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "Pavel Machek" <pavel@ucw.cz>,
 <linux-efi@vger.kernel.org>, <linux-pm@vger.kernel.org>, <x86@kernel.org>,
 <linux-kernel@vger.kernel.org>
From: "Jasmeet (Jazz) Bhatia" <jasmeet.bhatia.us@gmail.com>
To: "Ard Biesheuvel" <ardb@kernel.org>, "Jasmeet (Jazz) Bhatia"
 <jasmeet.bhatia.us@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <cover.1788259938.git.jasmeet.bhatia.us@gmail.com>
 <a9e23066-aa75-44be-ac3b-9a15f4cf6047@app.fastmail.com>
In-Reply-To: <a9e23066-aa75-44be-ac3b-9a15f4cf6047@app.fastmail.com>

On Thu Sep 3, 2026 at 7:18 AM PDT, Ard Biesheuvel wrote:
> Hi Jazz,
>
> On Tue, 1 Sep 2026, at 13:34, Jasmeet (Jazz) Bhatia wrote:
>> The EFI stub currently allocates the TPM event log as
>> EFI_ACPI_RECLAIM_MEMORY. On x86, this becomes an ACPI data entry
>> in the E820 map.
>>
>> On a Framework Laptop 16 (AMD Ryzen AI 300 Series), the EFI allocator
>> can place this allocation at different physical addresses across boots.
>> Since x86 hibernation validates architecture-specific data from
>> the firmware E820 map, this causes an otherwise valid hibernation image
>> to be rejected on resume with the following error:
>>
>>   Hibernate inconsistent memory map detected!
>>   PM: hibernation: Image mismatch: architecture specific data
>>
>> Allocating the event log as EFI_LOADER_DATA avoids changing the E820
>> map, but doing that alone would regress the kexec corruption issue fixed
>> by commit 77d48d39e991 ("efistub/tpm: Use ACPI reclaim memory for event
>> log to avoid corruption").
>>
>
> As I replied in the other thread, I am not convinced preserving the TPM
> event log across a kexec makes sense to begin with. This is the firmware'=
s
> view of the state of the TPM PCRs when it handed over the system to the
> first OS.
>
> If the first OS boots, loads a kexec kernel and then boots it without
> measuring any of that into the TPM, the TPM event log will match the
> TPM state, but this is meaningless because of the missing measurements,
> and the attestation chain is broken.
>
> If the first OS does perform TPM measurements, it would need to record
> them into a log and pass that on to the kexec'ed in some implementation
> specific way - it cannot use the existing TPM event log for that.
>
> TL;DR perhaps we should just discard the TPM event log reference from
> the EFI config tables after consuming it. Or add a special case to the
> kexec code to disregard it.
Ok, honestly that makes a lot of sense I see what you are saying and I
tend to agree. I'm treating the copied event log at something that
survives kexec in this patch because of the corruption fix so I'll look
at dropping that LINUX_EFI_TPM_EVENT_LOG_GUID reference and rewrite this
patch. Hopefully, that will avoid that x86 E820 instability as well.

Appreciate the guidance!
