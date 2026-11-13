Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794576308;
	b=oOZfuzfrCoqJYUJkEMvJ4fJlErrbSQPVJjlHzAADX1u9P8TDBvUgiSivviBCK8PNMhBI
	 Ww+ypEjIRWuM52WYKCfvDE2/7T98L1ni8HmQ+pIpSFU00knHSB0mR3MLJGl4aF27hyCD3
	 fG6M8Y5YTCtQYmTLPpQaQVv0tbV9fs8sFpKi+Xk72zQayg0o8MxSkX5PJoLrVHLTuJZBO
	 4SQU5KF6cbY7DDMhTq3DJGztyPyRfSe4EbNSbOFo0SowOoA+bRdOPShIyd2nE+SuOO9Ou
	 jyt6oizsfH7qqi5TIuN/SSgIYqjtdvf6zdNqUR8cc5Gipo6fcBcwdOHZqftifpYHWOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=I7/mj3A4GX0Fnjufd1AYb3hkH0efHKhQVdz09tQZfZs=;
	b=nsvHa/k/HAM1uZ/Dcua1mieKrZPtsNk53FsjuOCcQSJASO+10nNQDFQiJTWp8DINSKW8
	 Xaav8CmSvB1aobOUaz2wzjsz737/fGA1o7/uk7MZBO5fVJYsAcOsFozspCRWDEC6eyjVa
	 YF8lXTAN4L+hBxb37EYeH5JiTPQDHt6Q2VLgmiIWUsnDVNO5L2lMA0jnCjq/dB7f2Etqb
	 DsMbHWg72XiY9yTmoxOhl6jo/m2I6NKF3gBFrMdSPUzcylVhpYSZKAvt0dEGKf4Cg94dz
	 devy2MQ4HCgnFJpFwKYvHRTFa6lE5NP/EVTzxuVnYdXQ+1aUlj4uomeBzv5PKePXV0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zPfUO5Uv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7770760A382F
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 13:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7770760A382F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zPfUO5Uv
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso1189600a12.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 05:25:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794576308; cv=none;
        d=google.com; s=arc-20260327;
        b=ZPDvzgv+++2Nm5EQUS9k0SWoz1mEGN6RV0Oez/r42U8ohS0pfY3cH0B1dIiEFsY9Jn
         9GWR7kRWFc5H5nKctbZqJlDdbd+3S/HL89449x3UO0ijwSsYCbdzoIQFHVM6yXLI2f/M
         sTzfw4dvIocAXyo6bdDiWJB0YOzQQ1TPhrkB4xN70QyAw3ByDXFbOylOdl3JD3Fn0WHG
         FeXbpA+9Fjq75gprKucoQsThTHRwnpOiFo16d5DCEr4V3wSYlVSWQfeZl/vuC5gUxbpj
         kOaY+0yA5qbw9Xwdjs20wXPRxBt1ERxUVF/xkf5vA9jvpqD21f8kmOqj2ZULZQSH4BXY
         H4ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=I7/mj3A4GX0Fnjufd1AYb3hkH0efHKhQVdz09tQZfZs=;
        fh=tHRyfcWDkMK2Owr/C7yNIAdfWebyfqO5Ru8jbiAWhKI=;
        b=CI1jQc109HStgi0HeZGkRBi8ASbGvfq6Bg7iGUjjOZevXRCN/wQuWR+bKbh/4Ip9i2
         UGuJq6a0h/Q8TlVUzYOWqbptfk+dA+tJ73dL6RIe8fgDU3O2odfsRSY560RTuF+AeMYs
         1vlLxbVEfqCfkLtw5G0/j+8YGLDr6Zfa4A8HNrn0WAWw9tDgoXQVUgjALDOcSSShToiH
         1WldAT5aIk3wnTBCfJcolQ3+wwWEutHPvy4TzggxyPlpzOT51wuCRq0CPh7kpKXj4l/N
         rz0U0THiSPQ190Dpj4BBOKvInA53j/1Qzl3hW5ls/hfyKBPlAZHqPN8LrLNB0xSuC7Ga
         +ZtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794576308; x=1795181108; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I7/mj3A4GX0Fnjufd1AYb3hkH0efHKhQVdz09tQZfZs=;
        b=zPfUO5UvqcBR2FNacPMuUTq26YY2GRrlBt33eHQz1ImceJ4LHszUfOGyIjlhgGMDFt
         61Dg6G//C3CGsNm8Jwa9C5sjLsY9gCBJi5jtHBTSMTuKLsRD7igxfV/F7lUJB5JLMbg+
         RcFGqK2A685ZGpZtAjqSMiWTf3S9VTCBJ/b/Mek61mqMh7gz8piorIiTUC7EBdlDlTqk
         gXt9p4RrIUpyleZxfwzjxNOL7B4jOj5ufcISHVmIifrTZ9SrSI+r8NoPs9re0uabg25m
         7xpt8j3uzsTU7fNSm1OPj0u1UacP5ZxKXh00fPThuzwyvfsLCQcSKVJ8n7EO4HMM4yxi
         QIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794576308; x=1795181108;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I7/mj3A4GX0Fnjufd1AYb3hkH0efHKhQVdz09tQZfZs=;
        b=0wZpRKYFnofwiHySXELNgvtj8tf3nQbSjx3HLyPrYRgKaeV/TL/snDmdsjDhX8yhWB
         XyGahawaHBSCRXYj1S3JQ0OO6eqyCuCAjsv0LaYmg9nqfq67uqa22vqTKMVYANJjxiOz
         OihtF8yc0yrhuVK6+/1bvRavjHRAfQgQhyUowt/HHTC+oPjGSQrkNtJiVOLL0Nc3SrAP
         L0/u4areASGlNnmdR3aic++qhYQl9OYmGW6+ddv3snIlalEtR29NGZqu4+TuM+WcuVmU
         BCnBU+VIPuWjUWxDZV9zN6Ba0V/gdHPRtJKdzc+VGzRSFIbCsdznTSsfllE0pbyGJsH7
         bkWQ==
X-Forwarded-Encrypted: i=1; AL+hErHs276ZefG5oZjUgN3f5pq71n5aiCNYjGw2Alm1XiIMcNx4C6BUhm6AyeZWUmTHnbTDMVA0tvWyxA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/yluubuMa4I9+x6omGpV1xd9oRhaPU8RvoZKCXd+1PD4MwvMdv
	xkXAekaWg5YVr2T44FaildfaVB7tjxmdRUXFlxwtbrjTvBwVJYrdj9BVQyCkxCRbwgkfV58eXRi
	R3n3+zzsi2ioLc4VZgyg9IyBUbaLNsg==
X-Gm-Gg: AYBFou3hkakXsn7PCVo+P29g9QjGD222zW9+NbW341oT//GatTcRlruikBFBpPvuFMu
	jz3K5KYjOkRFN7DXb69s3VEtiWgHyB5ljYZdbn6rAFlJzmhUr1emVz9EknRT9yq0shdfXcvdngb
	uqH3zjelrg3ewDQLPOPk5BUl1IknAD+hWd6SNgqwJ5u/Ocrz1pxtIcQF6b3oByI2GrPJc9SGDZV
	JW/AKIsLtbQAVPNxIyNAR/hrhear6HY5bqD/gBygs1a05hu3KD1Mi6q0Q21TnZGUQUY/Qr2bUqX
	zYqj8Ne7o+MKTsN1yl+DWyhv6mCL4s7rDRiMTYsNzo8e1i4sfJRUTJFtiF1qz10v5WIJGt5UnEP
	ex1AKZk+MgNayzUlk0ISIBc7Mkc4XkDvDUd3P
X-Received: by 2002:a17:902:f60b:b0:2e9:5c29:995e with SMTP id
 d9443c01a7336-2ee0dc2bdb6mr25549575ad.41.1794576307662; Fri, 13 Nov 2026
 05:25:07 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-sm5714-fuel-gauge-v1-0-b9d163fff6ff@gmail.com>
 <20261111-sm5714-fuel-gauge-v1-2-b9d163fff6ff@gmail.com> <20261113-fuzzy-awesome-shellfish-2d93c0@quoll>
 <CAARotke5983-NFonNAnLbpzhEU2QZ=mt9CSNi=CdBxVshcpD_A@mail.gmail.com> <b72ccd2c-d26a-4559-b09f-1a0a2207add8@kernel.org>
In-Reply-To: <b72ccd2c-d26a-4559-b09f-1a0a2207add8@kernel.org>
From: Asdlerto Korry <korryasdlerto@gmail.com>
Date: Fri, 13 Nov 2026 15:24:55 +0200
X-Gm-Features: AclHuK-uu1jJJ5-OWPL6fdC7q-L5bATE3bIoG-NpwgnpCOGdUy-cDFX7oyzGFms
Message-ID: <CAARotke3nDJfYEG0Qskrj0uXAXCGyTE7rq-y8mR7daPFdCZjDA@mail.gmail.com>
Subject: Re: [PATCH 2/2] power: supply: Add Silicon Mitus SM5714 fuel gauge driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

You are right, sorry. I missed the series from Nizat Mikayilli posted
on Nov 8. Please disregard this one.

I will review and test Nizat's patches on the Galaxy M52 instead.

Best regards,
Asdlerto
