Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795332829;
	b=k1i7LJiSjqSplv4zAWG/8hJaz3+YnzJHdFOTmo0xL5LSAnf2wqYHZIk0q0nUSwLzy28n
	 7FThbgbbgSKUbF8jS+FRq7BOCi7LNWW9sikiUxImdUxmNmv6y4L2CM+u22vlbrFteJDb0
	 7mFMF2dPfefq4BBMBbduR9MnpztLl4LFVUpdZEW5IxQGwbNpf9385QvjkmixmdIGHE6CB
	 yvAgo6SvsFRqMZkY0ln5yMTm64I8bx8cZJJ9kQQFHyscRg3P2KB2nsGdsP0NG3ULlia0l
	 VV8sGLUzjxbkMy1cY0Ib0vKnzhffrxUujTexkEr112AwDeh1/tW3c9JLqGyThzdXlwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795332829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4Jc9Q03F2saooXo6TTb3sNlYecivQhO/Q+XUXZ3Oiak=;
	b=mkSZs1BjtWAOM3VlS4P/ec1MvliHloxRJzWh+Rr77jAhs89/1xPkT+uTA5ldH3R/N1Rv
	 2io7PD416Tl7eQ7B8HqUx+jNFmpnsOD0AaVwyKYqgO9Dh+93YnyAw5MDG3wC37DK7AJtb
	 b0Y9FhVfEL+moiYOtO26SeFJJPJTrDIXBB7+VLnBioYqcN1JD4un7fzeL+PbzYgONfCa2
	 tqzfRvYqRbLRPSrlAwME0T2aOyCiwP/wJaLIeRozCcY6WFQkN7DztnTKo4Wngd4BSjasi
	 mQs+zSbkSYEo7d/u5hwpr1PNbm9w1PMFuywBlLiTK9ydWLDF4+KMLm4I28e9t5EpEqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iHharhHN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10077606A32A
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 07:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10077606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iHharhHN
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-38699cf08dfso1656993eec.1
        for <linux-pm@vger.kernel.org>; Sat, 21 Nov 2026 23:33:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795332828; cv=none;
        d=google.com; s=arc-20260327;
        b=oANQlUfWrs+diGtlqo4L7wn0wGmXXRU/d7jT2cEO7aaPnWT0vQ893sxW5H/GRtWqA+
         PD0TZQH2Eh/TQp60M9YkZISPj28V8hZdEsLWDGbS91nD4Za4GlEnJN+M2KhsGqyJy3qe
         j+s/u8ls1ZlxEYufN9Cy49eQq1Hv1TP28hH/mXeU0eEUnipgOpoEKUtSG8pWqovjxoFp
         kJDSso/hZcffXPVWA0B0b/EhtLKwoHC0mT7eHmy4NWh9Or2muXAWEDx7gNC+HMDNoX8p
         88bZTRvrAE32ZLzigbCKR6+Op79RWS3TqxdRWC40saudYUOwQcIvoL6kAyAnlyWGoxQK
         Nmig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Jc9Q03F2saooXo6TTb3sNlYecivQhO/Q+XUXZ3Oiak=;
        fh=+ZukHH5Ug84ik4W2+knMxu7emeKrDt2Qp8svyEzzRns=;
        b=ILSslDnRYEACoIQLtWTlq7or1c06SAsxKL2JgXUZeqmLIJNur+PuqlUQJy28cyYp2C
         BwRZlpW002OkCRYNG3se80LP7b/M9Qk7F1jy8/nzyLpcQLu3Egv4D7PyJRvFLuGIbtlE
         T7UNxwZ0P2DK8VbcVPLplSYgZ5uxMFPENV75QUzjZKFjgzllBZW4Oj2Z0q/JVZtBPBis
         ls+5aOZKD58kEMJgvxFBasrbmGTlCyiDYvlZs1zOexPOiKeKMQsZS10pAkGnwGIsDkXz
         i/DwMYhNBZmNDt+/n9opk6vDDjPI7N3/3wIzuyFuOE0hVVp60egdDO0cT/ul37E8L9UN
         OTDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795332828; x=1795937628; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4Jc9Q03F2saooXo6TTb3sNlYecivQhO/Q+XUXZ3Oiak=;
        b=iHharhHNAvWWmMNmSJORl9CiACUuHi3i0ws3GR9vxP9SD6imQbfrumKrQ+D+3/h4VH
         DUQz2t9UyojNEslSFUoVY0B+eVTMj5udjH/m3y7IW9TI7lh4CDy8qVX2GkJ6WJ5xrNZ2
         uiSYPjl3+zim7UYVdOOK+MxRuB9mWbWEKcTr2Aa5m4eIFeQ1Ij51S3nFtx2RzuPey4z4
         vFrTxVw3E5xL1mbSQxKca2N0FjBwLxtAIsB5K/65SkSc/BFJEELAkUPMlFodi6c8/UKY
         xZjRmXPYOcTChmt3Lp9r4b/KMaSJDe9/30QlmCGKnRQWJwZAM0vmtvtrBa/jXQF0Hk0f
         O/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795332828; x=1795937628;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Jc9Q03F2saooXo6TTb3sNlYecivQhO/Q+XUXZ3Oiak=;
        b=bU3FS3AxW9sgBL6UHVrX/mGGLT6eqB4OYlzBKnRqRSyeLIDedq5T6fjG+xlSNWMpTV
         0bfiaE8Y8mOOa8UBXBNLe0eyz2tsEx5gQV+HP/SS/jq2h5+KtvFpCJxqMcOBXwe4MQex
         llXvI8Dz9Aom73NX2QiUfHyrMNzjdABg6blRFyQrUDaK/Jw93arvQjeIm/Qk8zaC6z4W
         fSgfetsyTyP0QkLS0qYHeJf9M1GfwK+GMNSN9cv6b1zP2ul8o/r+q723C+nOFeVHLgY/
         JkYa1mORYrIVoWxkMWyWnZQNSSQFI46dUiwYBOk7bWIwswnseJiLEgVX3/EnrCQWCWBo
         4oqQ==
X-Forwarded-Encrypted: i=1; AL+hErHpfCAduzls+Oicn6EtBGzyXEPfHvvKPUWqUqKKw6Cv4X4HN/86vL+9RlKwfqyc5rLSCq+JOlyQ+g==@vger.kernel.org
X-Gm-Message-State: APuU4Z+gxiYbW9cs3pksJYuKLnMoI1wEM8+cOi4dDGWK7cPkfkhXVLvN
	+CP0B7Gu7JE1ObhSphxMXnbZyz8j9B0bLtakOUljOZ42ZwEBdFGPYVPdVLbtSYIDnZiDPb6G40E
	Ytx/yzAoVKXlEe9RtgYxF/aKeX0ttlok=
X-Gm-Gg: AZFdTZeruYMVyVX023Q3oWPdfEc/4SNLCKCeaa8zH/dNsZPkpZnZ+E/DPgYiugitQA2
	9BjsDwUI55dvkZ4tgVm+NEV1xkD5PBrLFYpTHyAM2hepwhZS5viXQpHq9UMStKhqb6zveARccmC
	Udy0+PnVKt7fstln3J6DRIIwBWKAyRsj01WBr0aWE/PhHJhOyGDDN/SPDXeqCGEjK8TXQ2uBm5/
	endEzxkvSojIdrJZzXTmYmo6crFtgTobe8FNaRQgblVhlekvsnk07L28lU1A1ZDxxW3tv0aOcRT
	h0ZOygSouvH2/fUooLZoJNhi8oEftmFZOoMPo+3LOhRjy0eksXH+FKJoGR4ZssXfINL3eLP8xj4
	L6h4F46NPPr3Z+aN/WolX/qvVNk2enjaX64DnhlzkCKrLdilkqV02BfY1SZ6jEcLl/veoHjHlgD
	XsIz2KcIkucuo2fEN9pLXhvGbe6R79Ag==
X-Received: by 2002:a05:7301:d813:b0:386:8bd2:da35 with SMTP id
 5a478bee46e88-3868bd2dbe9mr5806237eec.5.1795332828030; Sat, 21 Nov 2026
 23:33:48 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930072450.61836-1-clamor95@gmail.com> <20260930072450.61836-2-clamor95@gmail.com>
 <179305276926.4032096.5720095014424223708.robh@kernel.org>
In-Reply-To: <179305276926.4032096.5720095014424223708.robh@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 22 Nov 2026 09:33:36 +0200
X-Gm-Features: Aa3M54qiQFO3akCNwqI_UUbQKp2SRj0lVcvXQw852BKZ9oO4Dql8w1L3qsKBEpI
Message-ID: <CAPVz0n3-63X8fQbohNERGJMdytfpqRGSOPOMoNRpWxgmMaMrUw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] dt-bindings: power: supply: maxim,max8903:
 Document MAX8922L and RT9524
To: Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	"Rob Herring (Arm)" <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 27 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 00:1=
2 Rob Herring (Arm) <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
>
> On Wed, 30 Sep 2026 10:24:50 +0300, Svyatoslav Ryhel wrote:
> > Document MAX8922L and RT9524, which use a similar charging control patt=
ern
> > to the MAX8903. The MAX8903 is set as a fallback for both chips. No dri=
ver
> > changes are required.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../bindings/power/supply/maxim,max8903.yaml           | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
>

Hello Sebastian! May you please pick this change, it is schema
adjustment only and Rob Acked it. Thank you.
