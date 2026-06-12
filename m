Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36393D5672
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 23:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781306525; cv=pass; b=YDoYBlXe4o7aGJLOwzmpK1au9wpxRfvnUrOk/gFoanQ8+Pqe+jqx66ayslBggHrkBgKa2c/glZVSQ88Fz87fCq7DDQRBFixW9bws68vv1PCQuVRyKk2Cwa2aLYmGAM/SeFM2P/JO2FCIKEsnhj043ehT/yt0a3H8IrNvGUiI61U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781306525; c=relaxed/simple;
	bh=PsxMqZs+xPaFSRfacdS8ILHCyyJFZ6pgXvkJ1KRhrEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2h7rtGhABnj3FNMgljnJ/WHBYVvSVfOmbFOyk2f01nM72oXGBaxbkFQATkI2Dq5uUtbnA4yUSszRzYQPqwsg6qtYAF7IJYRAI/5QvxuS3QqP4abonuJOXNFspgqTd8xMAykO3ZpONGMoExJIPzdPm0stOkTBG2wA7aJ8/y+ISQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YL15ZvZC; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YL15ZvZC"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68bd7ec2371so1871a12.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 16:22:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781306521; cv=none;
        d=google.com; s=arc-20240605;
        b=ePNHp7UMSiZ1SFsFQoKdxTbqzOyiR7oEZ0+IgiedgcSfdNck/qHkLXnxgB5W/NyAwL
         qCFKAN/dNCXIdXVUDr4vQwMAzJHqcGT6e9Ea9HntDB9s3dQXJZ6CiasyiUTyyYl7UZ0E
         qUZsJD9cgiu8F31HuvqCZKR2EuQEK80P1lT+RH9rV2F5H3FBhQKvMPLoKi/Vd9qHq+E1
         0uy3NCarfw+jYYSOregeU4XR7qjrtgVojwajWY60u6h/lzUy/yjF60nTf//z6CBSuDeW
         kLoLHEkBYh6aZnfQN5mAXkFrLO+fxb+9XaXMMQb89xddP6H1OnvTsK6BUNkAUTRtvUGM
         Tg9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PsxMqZs+xPaFSRfacdS8ILHCyyJFZ6pgXvkJ1KRhrEc=;
        fh=3dX+joz6Uk/Fo6E4iFc2fmgTEMDtJSvNFWt9VL39dSs=;
        b=eBkHNO0xMWjmFcuPxozIRc43tfVrwY6MZx3HwE2gpFuYTggfIudRi6EkD0o2UAh4zx
         fwOjx4pBcw+wKeX/dr+grbZ+pqwhE24fiA+ymeWKUyOQm3WF51Ew44hBX5xbDKeCJJoB
         wEU4dNaoFs1ILLlzomm4Zae4wvFX3VM2GgppPHog4Hx3k+El0JCaBMwW2XFEtOA7R7uY
         3aaHVrQiVDreGZKsp9XiilOHDXN5GCY9wUQdj9KBGuhPuI5XzBolG6Sv1sTIR7QSTpbi
         EcKW6HySwvKLs7VSmB2y8dQImOCe+GKtfb28mAvllZbtp0yT3okHngVEm9z4ndykfZjk
         LeVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781306521; x=1781911321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsxMqZs+xPaFSRfacdS8ILHCyyJFZ6pgXvkJ1KRhrEc=;
        b=YL15ZvZC0HK43C+j2xVMK74yRgKAhVRyaZFTWiEXDxf6Uc0yBBVQhsymxCqNE31g6U
         IeY2T3VvofmBsr81KxHxCETTEmxibvsfj8nYHcX8V6ZdNd6OKDic40yEsTNu7f01l0cN
         trDrtukylm8FngzxSswYEDnsCvux4pbmW3/XluszKCxaK5Ys4U3LhCw+cboHRxA6GzvY
         kk/mtvwskfKio9xwpju9qpp0v0HL7NNkgJ0np3zL4T3Wstxt4nZ/GWQrKMGqCMtjOJ/C
         76bLQsdJa7WQVnBdr6gzLa98SoJMo+aJn12qGcxbfj3paCBFXby5sreLoPuSROka60os
         ublA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781306521; x=1781911321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PsxMqZs+xPaFSRfacdS8ILHCyyJFZ6pgXvkJ1KRhrEc=;
        b=eeld8qh4wFccEn6yZnq5jXgvF7/OiHu/AhV68/1aSVn94xI0rWLa0JRS5M1KMknMkU
         fB5Kot6l2U1OxuwpJYtZZTf+0xZu/tVhxY3rIyjyADZkg08OjJhR1gH52dC2Y9ZSPc+j
         bc0/1NvZ4ibV43Ojch/nQVPb4Z82lZ4RfTnL5pOkAvaEDwBFeZkKvi1OsYZeby8SRzL7
         UM/ay3RN6NESZNYAjPKwDeVIcvwZ2JK/dn3e6Kc5K/liwdHvRalYdmlqYC8sjBGs/B6h
         0myyRgXrwGeFTbnd9V9mFlb9VQCpnn0LeVA5QlMJ2MgtPQvgrAeJhkC/3WV1hRYXFQvQ
         qrfQ==
X-Forwarded-Encrypted: i=1; AFNElJ/H2VGw/DOyoPf+2yUvpfi/9Ax+RnPuAnkNfytCTvYFI8CshyuUEyabtrvJEX2Kl9shtceeI0GylQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7qUNNo0fQBlKYbvz/xxkfH9CFjHtVF5+GNcM7nyR42y4X8mxm
	JUYFbS1JGvWfzXA5E/q2OG0S2uJpmmb9z7qEmMFkImPi1ZMAsALS4Ns+3++m14dki7JKYIIahcS
	A3FZhDCg0sw53glaeB2XR1gsOwe62AqS/FZrXk6xg2LlaldpxWwyuKf2rqgM=
X-Gm-Gg: Acq92OHWEsdHDX7hR+eYRQwY8ME9lqGhSVaFs2H4L8LW9nZRaet5qkapbVt0LsRqIwr
	shJ293Jp6mQiuDZWXJfVtYe2QUn+hOkAR/Zo/V66C0ZBkRCsCtjJkLUrZZ5q8SlZK0t2FsUcfi1
	sWrGAJ/nCbh2V1q1zKBDpEDERMeXuBr5/eA0PFlc/9xm+/wRJ5I23QhGCymQu4IMt1OAImPjoTZ
	1l5pRTw5BNr80ZHkUEEuef2wllJkgeFLOQYSKcINEReLtfIhDDPQkfI3kpBNtVOLIkpOXLWpWN6
	ox8RD3Hhxzpk3fj6EQ==
X-Received: by 2002:aa7:c516:0:b0:668:c2b6:9fa2 with SMTP id
 4fb4d7f45d1cf-693d19bffcbmr6682a12.7.1781306520361; Fri, 12 Jun 2026 16:22:00
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612215729.1532175-1-jmattson@google.com> <ced074e6-0316-4e12-848f-52a15a4e0389@citrix.com>
In-Reply-To: <ced074e6-0316-4e12-848f-52a15a4e0389@citrix.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 12 Jun 2026 16:21:48 -0700
X-Gm-Features: AVVi8Cdne-pAC51QRpLesV8hpEBuM8acXP5rJu67F_mIn6ixnXClT4gLXWDAfb4
Message-ID: <CALMp9eQaiS-ga0hW4vPS7SuDWXwYgNKOxeHiFttdsBQv6K1AWQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Fix three racy updates to MSR_K7_HWCR
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: bp@alien8.de, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rafael@kernel.org, tglx@kernel.org, viresh.kumar@linaro.org, x86@kernel.org, 
	yosry@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 4:01=E2=80=AFPM Andrew Cooper <andrew.cooper3@citri=
x.com> wrote:
>
> > hoists the HWCR update logic out
> > into a new helper, amd_update_hwcr(), which performs the read-modify-wr=
ite
> > with interrupts disabled
>
> Add some `perf` to your test scenario and these bugs will reappear, this
> time caused by NMIs.
>
> I don't have any good suggestions. Core scope MSRs are horrible because
> you can't update them atomically.

I agree, but I spot-checked a couple of (Zen1+) PPRs, and I thought
they said that HWCR has thread scope. For example, in
https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/progra=
mmer-references/56255_OSRR.pdf
has:

> _lthree[1:0]_core[3:0]_thread[1:0]; MSRC0010015

And, earlier:

> The absence of the instance parameter _thread[1:0] signifies that there i=
s not a specific instance of said register per thread and thus the register=
 is shared between thread 1 and thread 0.

Was it core-shared on older platforms?
