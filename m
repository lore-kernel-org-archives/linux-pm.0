Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8AE223DCE
	for <linux-pm@vger.kernel.org>; Sat, 13 Jun 2026 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781363371; cv=pass; b=O0QaXfQzMO5fbHnYdN6VLp26qCPY+bVfsQUxG3u3RAPd/kGq2rOKSL6poG+jy2xxGBJQjBNSNKVFezxUH50hB/9CfyuOK/7MNgnSE5zhJpHL7wKO8W2McP3PMngGn6y1NaFdo712W8M8iSITWhFsHLIp8qu9PewyjwEeUUYf5kI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781363371; c=relaxed/simple;
	bh=S4Zow9ulYfL0fAiSU5mq1YiOXlIBHlgZy7hq/LbV2E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdwwWtEh2E4T3JfgNhBqc7Do3xHnTnVFoPcAaO5PpxO6FxTNoBPoeAHuuKCJ/dTCLW1Dg7sMkXV2k3uE0UAgGzBcr1pZpMp/velL2BYAgA92yoZKuMcZV6c4m26iqRvyqZaaSdy1cG9MJppfNN50VaT2AB/XSIOwR1xw9qV/7uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k1+cxIHX; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k1+cxIHX"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-68bd7ec2371so3706a12.1
        for <linux-pm@vger.kernel.org>; Sat, 13 Jun 2026 08:09:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781363368; cv=none;
        d=google.com; s=arc-20240605;
        b=WwIjVt3hceCMpo3yNzNwII5EPtdyCFyGDfYVLrfJncJl3eqryIXJCoY9p2s1SVnv0+
         iBS+ieKaLUmhnaSHPqgcWzOCSwFGkFHNIWP59xviJhfUGvQvCbsDwxmNq2CckZxqzzYK
         eih7WEMYJmZ8TF1AwP+ewiqjUZZs2K0uTwZlUfnMSYWk0Ma768bOqngGf+VTRcQzojHE
         2CYWANGzOzL4FGu58BNJCRSiDE2kqi614p6eh4DHBwwgByd61jbY9ks3ehnjBq2nS3KZ
         vLfi6VMF98BQY8j+GpafmnyOnkOiidld3DMz1Le5CeVo4LSWSbhM0n7n5vb6R1e9KkdW
         aTAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S4Zow9ulYfL0fAiSU5mq1YiOXlIBHlgZy7hq/LbV2E8=;
        fh=WZK5z7Nbw09NkqF6E4V9FnXXFRH1j7UlPLT/f6rgnTs=;
        b=eNzca6GVqXmRLv1kkSUbIGrmUPunudY2fXYidVLhvbuPuH8gzv2ytTeGFLSwQfxXmZ
         khZOxhquhEaDHCCMJt47TBK+4wE0H+1/9L918WVnYhSS5sceNTBmng0fiZWTKSeRipXu
         p/CGs/fq9YkaKRSKo/qHaPBuiYPo7FKTK33q9W1I2bAyyE87aPxM7q1HEHenMOl/s0Rv
         mDeseA2oV1QvAXoDyIK08bQn/e6y9LTbIEAujehlB515ym0M+RZiDWEDWKIrxy3ehXzw
         NwR2vaB7OcD3wGsiq5EottpahVZyJy7/FssqLahizH0liBSuK04AihqF70ekQMnpBnt7
         fvRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781363368; x=1781968168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4Zow9ulYfL0fAiSU5mq1YiOXlIBHlgZy7hq/LbV2E8=;
        b=k1+cxIHXYmKjTNlw28K+TGoNctEhNKsjnNo3ac6CITxKtJtGaUgkUatoQYn3JiJ9pE
         teNHXi5/42Q4sVMXosfo/YydEukbwPnLXPJOwSxlgZMF8DkjRdzMM0XLsvOgMvC7KigK
         CqG7Np7yud7j4vD96QwBGfy0hWS4CbO6/jGUtyVWRMofCaKY2Rc8KsxBa6m/TWuMrPGW
         WDIKDUmqTrPUjnsWg3B1wA3UKXWgKnJzdJoRkT4nSCNpc9L4ynR11rZqWShzC2cIyON+
         s3w7Sc0SwmWhng2icwpm/0R/bKty+krjftuRAfotOjdum1FWrHNurbUUzm0iMJ7Z3w7C
         /CIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781363368; x=1781968168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S4Zow9ulYfL0fAiSU5mq1YiOXlIBHlgZy7hq/LbV2E8=;
        b=JsytQWJEm8+d8uN+NVFmCXkacZ2rmRSj8bnQsX2pU3/E7D4YgpC+vdj5lUkRIX1TEU
         EHeK77TN31pJ/NNZVe/aW+pJePdjaJ3zMBEkUZPKGBYpqonFhmxEVsNsp4fSy4mpQWrW
         JEdXchoyyX045RN7T3Vuulbymo+jMn31nYuLwPlC24K+YsLJi3rLvogAqYiGPknkj61H
         m/zzFKNxhXS7EJRLqVAa/7LR/n6M8HKqvxCWSDJuSBliRJ/Km3c+9m9QH8afd4iSwl1y
         SGQLHT45VbK9qv8qXeFCEuMz1Z6TQR2E+tQoOl9xQxoj5edJQBIPaJSX0Pfa2J4XyUrI
         nPMA==
X-Forwarded-Encrypted: i=1; AFNElJ8re2B+JymaeCWvm0c/b6Xx+/VvtGpqx5m0vDny4NrqrV/mfeF11ItZ7rQY989qMDS7jhRzw9FsDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBagp4xGX4ksf36UKTTpdHFuI5cNAqYkciecTmttkZ29THJM4q
	g226NFAeAX5X/hGyOQv+omdUXyPsEndbjyHYixLBcLPd8caKcMrBIpZVqNIWr7JWysoe+mp/EtN
	OWdi3UwZYeyVn3K8W73fnpeyhinCz4PelrD6I5W/9
X-Gm-Gg: Acq92OEG5RV/Ysv4b08oH93dMehZX9EwXqQGJ4UV3XtI3HJS5biARKKwyEpubBBDPuh
	oy5+KDAqxEOWlsRT0KyLG4Y6wvBY2HzzVlg8eQhsgcOyO6B2hMeOo4HVG0Gia3I7Xgs+0E+/foo
	SmudYDxVrOTyZhe/7yrum6Xw71I5pZ7aLFMmAbyqw92F5N7Axu6j8mEG7BO6f7n11FQPNDLs0Ok
	TwBRuqa5Jn/3+JbN5Zw12bVBVu7lyzvoxmqZdWjCGfOYtTIbmw5/xDLA9JF6mRAUdpEoKkji7yE
	IU6QRjM=
X-Received: by 2002:a05:6402:a0d2:b0:683:33ae:8689 with SMTP id
 4fb4d7f45d1cf-693c6a6bcfcmr40065a12.4.1781363367753; Sat, 13 Jun 2026
 08:09:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKSQd8XPUHe3VLMwrwTWjDwqsQAxkSj802vo0-c5C1i6Aoh=yA@mail.gmail.com>
In-Reply-To: <CAKSQd8XPUHe3VLMwrwTWjDwqsQAxkSj802vo0-c5C1i6Aoh=yA@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Sat, 13 Jun 2026 08:09:15 -0700
X-Gm-Features: AVVi8Cc9WnxbUNBHE-XxqxvfKL6AnSW1fdfORcD8zuVmbzpVWqdzNTCug5spU8Y
Message-ID: <CALMp9eQXKEqV5TwhCW-CN7ZgJyNNacvG1zPO1RLbc2R5SV40=A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Fix three racy updates to MSR_K7_HWCR
To: ludloff@gmail.com
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, bp@alien8.de, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rafael@kernel.org, tglx@kernel.org, 
	viresh.kumar@linaro.org, x86@kernel.org, yosry@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 6:56=E2=80=AFPM Christian Ludloff <ludloff@gmail.co=
m> wrote:
>
> > Was it [HWCR] core-shared on older platforms?
>
> Fam 15h (BD/PD/SR/XV) BKDG #42301-3.14 Jan 2013
> section 2.4.1.1 says:
>
> "Some MSRs are implemented one copy per compute unit instead of per
> core; these MSRs are designated as SharedC (shared coherent) or
> SharedNC (shared non-coherent). The absence of SharedC/SharedNC
> implies not-shared, which is the normal per-core instance programming
> model for RDMSR/WRMSR."
>
> In table 8 it then does *not* list HWCR =E2=80=93 so it's "not-shared".

Amd in that document, "compute unit" =3D=3D core and "core" =3D=3D thread, =
right?

> Naturally running with non-identical values is... a bit exciting.

That depends on the bit. Non-identical values are quite natural for,
say CPUID faulting at CPL>0, which is admittedly quite new.

On the earth movers, I assume one would want non-identical values for
MONITOR/MWAIT user mode enable, especially in the days before L1TF
forced us to adopt core-aware scheduling.
