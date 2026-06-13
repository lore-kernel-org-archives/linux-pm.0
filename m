Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3CB25487C
	for <linux-pm@vger.kernel.org>; Sat, 13 Jun 2026 01:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781315765; cv=pass; b=I2p2Ww1FW8IrF7Nzs5HaOOJJJube9faUuXn44hXUf7Q/CdoNXDXfYBPDPwOOnLC5SrU5GyWyqBMX2gSJxtCpqHD5S00FRU6Sifgu6F3BLIvuANd5+8BP6MWGGTTD9sXxh5eWoEftFIBDKWsb0qxv7eg+uzpfa03wJxsTW8NYWdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781315765; c=relaxed/simple;
	bh=C1fSXcd59Yhj427eHVAEA9TjAEqxXzJGDETsarH2sLI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=l4Z0MR1KFrhsFB+5kTzixSMxIaJmtOwWZiCD1+HbEPIBKUnny7xvLmAZf+icFvV/zPgIJbDBsrtYTQxbM0wEWS+7sxaEymh/Iqe0Q+j2dCH35OElG9x2sK7Re9bZzJolOddw7/rm+xW1nubR7gbvfiRjnxsFb6VL7pDYGlWlZ2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbrZ0eQu; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbrZ0eQu"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-68bd9fce347so2935719a12.2
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 18:56:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781315762; cv=none;
        d=google.com; s=arc-20240605;
        b=c8am5g0qmdpf7R+fPhq7TACDGVPoMzezQ/1aiI5++MQlc0X95iRO/SNEG8MvqqTcDL
         uQBQRQOdPWt/FNWVHO0klSo5A7emkl9oQvzHH4WXqVQBZ42lHO3f8RzPx7AmHDDL4NAc
         so5kKtlrBaY1Q3QnWl03YdQw/+RohEaLCkT2j0W0wrXHekuvB0iRMqpuJ6muGxVSVC1d
         rnK5n5j1qMQzztgK1DQqVt7yOFQpRRA9L9OzxHo2QlRubVo6AxL6Q8PEby2wHzsGkOvN
         +UZ1WGNBE16Exoge8ldWXX1j7z5a/QG/SsF3XXEUqrDUx6NKIGFyE7C4v1M0BmN3MB9b
         fLUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:mime-version:dkim-signature;
        bh=C1fSXcd59Yhj427eHVAEA9TjAEqxXzJGDETsarH2sLI=;
        fh=nFVvB7/ze3C2sIfTKiRKyNn/TxridmehEhhROYx4MGU=;
        b=kmgMRXV5cp1BF8f1ODu9H8alArKZRH4iWsTlPvsEUVDeqXvaQHEtPpbqKb/xX6Fszl
         fgFjuiDmuOvuNT6ftnk3bvtrCj9l/ToTUQpYPI3lFPRg7BKGWCNFfFq3NZ+MNuNZiGN7
         fFhs5Wvd332Yz7pKSy+W9pNB6lPRueDi5G25oSawVnsZ3o7s+y3b/4WVxAIb1MdvuuXm
         yumcNr9BPQKedGdYXXuF2bZg67wQvc2vY+1bEuOVkjcfcf3phT504iPKydx59KP1PTO3
         6TVgcaPHV0WXlqwnoVKqVd3XbGDarO6e4qM3Nso0H8oQUbwZ4FvlDBoehKfUlWTsPZWk
         MZOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781315762; x=1781920562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C1fSXcd59Yhj427eHVAEA9TjAEqxXzJGDETsarH2sLI=;
        b=ZbrZ0eQuo2LacbkpfcAXObZlocQGIV4fKvWjXQLIQQL4k8K5SAAEmlaX0Y+JIPHM2n
         nYwGGqbOGUtD/g2yS9OGiEM7dK9DIu3RZRGK2/yk3BcOKeJdICJvtfXs1dcdo7cUc8V7
         dcuSjMANbOrZDxzEyQ33LRgvkgQcmbpc/XCwU65+fPH05WK5+fbfoAVdFC6zXvnakcce
         1DR1C/mLatzyfZdVoMwHiHr6SJEdA4ULs1JMZ94Dlm5pFELmKZQDQ4PJ7MHqoQ++sxwy
         AI8oPJCk11h1qPcE6sMc30RtMlMsO+FWMEH9R36+ow7J9mHd8j1dUKGJReTd7tc/EJ+w
         xCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781315762; x=1781920562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C1fSXcd59Yhj427eHVAEA9TjAEqxXzJGDETsarH2sLI=;
        b=ByN9a2yBIabdKNWnZZ7MphcZV09MC0f+7nKEEJYyQJ1StbEKRNfZkFlzgUaJYsIARN
         6KK0UaGFxU3n1j8DOH73NbnovEmzNdpx43CScX171T+rsmkLsbu1DTpb2BAtDIE9C/VM
         6SBcng6Pkfv74WtzIi4D6R3B+Rmd5MPX4LyCHcMRgIEmtegaWLB09Ps69bN/UTF7n9GG
         AstqNBSs0BT2VxmkxEbWFHjGaXmdmTS1abG4vWRc1NeeaJz3W6m8Kw9yFCuqb02RKruP
         h6bvCzlOL0nTsw1+NQJtI4YR6XwvuvxADmsuSO3j1xUiKrnVDy2eGBeovabI1SwuzapX
         AbIA==
X-Forwarded-Encrypted: i=1; AFNElJ/Sy3OjZgsbSqQ5hFzv+0UoSMDKWZ4c6JG/fQwjImufRoqdekvioLjSccyukVh8PnN34q+flyKPBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZLeRIgJhXRMfKjANfkwAsK9qUxuhLoXD25UOVuIi3PW3sR/nE
	Ip5rcbUfy9Wi0issh0I0Mv0pMGom2dD1hJROEMzfHgDgiLhr96z8zhejRvTVnFXXqdoliKNPCTa
	A4XRbjnjs09/ClfwrPKGck9mSuW81LK0=
X-Gm-Gg: Acq92OELxkm12cfX7NFlcMWEw6kltyi1B+r8Kpin+nVOLCRWr9N+I7lTKtSzBYKrH7C
	dJ5ZJD0vDSAKiq3OKzgCmRrHr02xV7+UeEay5/ygwBV8cSuAZp/7hvhi8BddIqsXGfnu79QUaea
	JDKZJB/pr+MInKnIbr2BCeKQBa5qkYuBtzsaGxLqZUij6gKHsdiDrMA7LmoT/IB3lPv1VmN50q0
	X6hZAk4iSoh/3w/ARe5klF0MajSVZ0iNALIBchBs/IaFoV5akx7xaNE3d+YDjr0Yega3/tfp06y
	OE4fnwp4OAToRKa10qyEIgfjtVxGK8qAnbAkXDLlSiwij6QELw==
X-Received: by 2002:a05:6402:518f:b0:68b:489:df9e with SMTP id
 4fb4d7f45d1cf-69378176e41mr2685393a12.23.1781315762403; Fri, 12 Jun 2026
 18:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: ludloff@gmail.com
From: Christian Ludloff <ludloff@gmail.com>
Date: Fri, 12 Jun 2026 18:55:50 -0700
X-Gm-Features: AVVi8Ce0K1gV3HAtxRTCm4ojA13r-51q9UV83kgFu_XUzHmt4VDOaaMhola_fJ8
Message-ID: <CAKSQd8XPUHe3VLMwrwTWjDwqsQAxkSj802vo0-c5C1i6Aoh=yA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Fix three racy updates to MSR_K7_HWCR
To: Jim Mattson <jmattson@google.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, bp@alien8.de, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rafael@kernel.org, tglx@kernel.org, 
	viresh.kumar@linaro.org, x86@kernel.org, yosry@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Was it [HWCR] core-shared on older platforms?

Fam 15h (BD/PD/SR/XV) BKDG #42301-3.14 Jan 2013
section 2.4.1.1 says:

"Some MSRs are implemented one copy per compute unit instead of per
core; these MSRs are designated as SharedC (shared coherent) or
SharedNC (shared non-coherent). The absence of SharedC/SharedNC
implies not-shared, which is the normal per-core instance programming
model for RDMSR/WRMSR."

In table 8 it then does *not* list HWCR =E2=80=93 so it's "not-shared".

Naturally running with non-identical values is... a bit exciting.

--
C.
