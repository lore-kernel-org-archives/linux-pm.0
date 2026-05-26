Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D29039733E
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779789854; cv=pass; b=AfyL1/QKyWTVzrUUHjICcn32kR8NfMFp2CBcHmNoQHeCdyLiK32plKG6kIjZVO/Nu6NkxTe5aUkZ++mAqj42t62tH+CHC5GbAf5WpScZjl1O+gNlD4WzKKF2GRHO1EwzEl3Lkzmf+GdyLOfuutsSjUQfyV7zPkY9kQwsjKdI75s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779789854; c=relaxed/simple;
	bh=6JdPCZF7Dk+LCK/fQNMCvQ7TciVuLce0qtseH2AlqEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7DjapCezv1DP5YOcBrcBeXIysDZpDHiepeLt8hLb/u2WiLTyoLshXDOC3Ud8loZLdHNw1ARES9tQ7cVMzzjKR9KjZTOeMMlC/vnxDC17+mZMbYfEEAbCGDV/ibBRc4SmcCi+bFc/DAH3LRnAk6lLFjAReF07PhGvLBd2HGdPMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8kZupkx; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8kZupkx"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2f0ad52830cso13154823eec.1
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 03:04:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779789852; cv=none;
        d=google.com; s=arc-20240605;
        b=K7cRItYSGk0VWFjmUsZmUHdbW2+q4Ku2a+6H68xDBpkX4GFQb5qFppTEuQCzkgcNm+
         Vx/2awT1LHsDQ1LuNvO63eCSIKnK5i3QSS6arrsgxIWz7IPjZDVdFovd2WhT0p4MB7Dn
         5/E41r8WUQzM9EqFGXvbF1+nGoa1Kv7Y4ZA6ny/62MHgKeclxiAGVS7sL+Vvdo9p1bYS
         CYAAJwCplCmkBPADk7GR4YwXf38fOKdCbLETm2YwejJ7m1D7EtCnrLmc+vGFQgcsubYP
         J/9nQbfMMlCRTNCYZ0H7vHuel0Cdn87K+XCUzrVvf6Lp7J/rJrN1mdO/jzbT3PxUwThj
         3C+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=is3W8B8GsxatajI5hJo1ERga8VuNN1wrfiQOz6wOJ7A=;
        fh=EYLqiu37ewGVKd+nB1JNx1UatvvGj6YrOqc/+cy/K9Y=;
        b=iRpLBzAZ2uDErruNRws4fwLktPJaH7a47o9vO9V+5so4gHUjcOFVwgXUQV9pFHUp7z
         TXHDBsmzi5SuPbU1J29JCRsf6h752KLij6nQMj6slr2Gx40yj/Yq3MJ3xUXtsYfLTqvN
         iYkYXowNlw8ndZX5lAG2DSQIoqeDUyJmRCTbptMOFt8CUeaOkOvGFpmWqciVt1oaeYAJ
         k8rlcFp3ldlV9V/hxcixlxw670fW8+24ygwE147xK2I1aG/R2K9VaBNIWIP4GRRnLXNe
         ACYzcPrvUaMnwRq+aAQxyaycojZ+ZhUutJD2OdDueq45j0dAPCHzPn97wcFRU5utPoeR
         kDNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779789852; x=1780394652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=is3W8B8GsxatajI5hJo1ERga8VuNN1wrfiQOz6wOJ7A=;
        b=V8kZupkxI/vE6LNmfw+m5id719UJZN+8pHBqJQfq9WNiMxBM28M1L7LMN9KFuHxigy
         hwvP1ysr5IjDocyqcfOCI9p8kgJF0t2/fdewG+AOwI5Z0tNbBpgpBNnDOHr5uOjkZZlu
         Qt1aoJGckN/eQsU6r5aosRy2wcH0JcEqtqXI5CjB3IDioRlu7+tUNbAxaOsdw4aMtyIV
         V3c9WaTcDvHh04DcVh+PoD7Uu6orfCRys22cihxrkoDkzQVQdTMAMWYaj2J4rNRFihtb
         lp8qaHB43eNJXbpzW3yQXZRNR0NKdnSbi2gD8RQES9F9NrD/MZKwPRSAotMOASG9YTVs
         2qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779789852; x=1780394652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=is3W8B8GsxatajI5hJo1ERga8VuNN1wrfiQOz6wOJ7A=;
        b=Aurk23dPKESZORxNWCTqVPRLVc3Bx/9+mZeNFMm8L6WP/i4pKx2CV8c++yxu7mA9bn
         CGEO084E5B4kv1ftzumE8TMbxL37u/rbGG51O+C1se6bJVF+7fJzmGqgvYtX4kBefhe1
         P3UUrOqmWcpXxokG1QIHoS3/7Qb+Pd0o6K+FPKd5HLNwo+CU+yFxsrQZLY0XauJXR3iE
         6WwWmyUzNREBPKyW+5G8EhefNIkolxDPTtYQh1W2bFPkg8INPTbnNE5yMU6khLhmX7To
         59Rs1hqp88o/gQH2/+D3vDb1R9YUpembprzt4eAEIUVivAl5kbZ5Zo/UU+Mw+MB9gEQw
         GMww==
X-Forwarded-Encrypted: i=1; AFNElJ/+8mQoMts/GqhAFb7cXyN1FjKfz4QqUr3JmR7kKh1WwhmDOUqeGdhIkRGvOa5zMQC2PYy815JMkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6/4IbUk3+B77JKViLwKriSRZiBCyUjhV/0HjTfwTHUZ+z1w1r
	GeCAvnmll/iOX7wA65RnPMQbd+kSt8/m1h3E/P5MC1tZFNx6xInbclnBRcYpL1kEjz17ry54TXm
	EYU1TLqgUFjCBgeYD3b6UytLOua9PXSQ=
X-Gm-Gg: Acq92OEKdfhxMnivCtX8fDEJ7awFTXTIT52zE5xrJhCu1aryCdiZdy4eoIuh1H34wTX
	Ifyc8QT+RcOY4ZR1o62E3S2DSeEFQjxO3wzKvLTmcDICbVwm4aoTlDUmTeW+dZvU+DpHHlNGZom
	r+gATgDUve2Y5YO5766u2rIG5xB2ABUxDmlyoRjlidxKiHpJNrDaqt7n/DeTx6Z+3YnCEHLNAdQ
	RxIjKGS5yyo+CJPIVu36Z6LFJp5DqN2uFCVAyw4CwKiZsH6TOoB2jjcDwlSGBtGiRBUlyIx9Yun
	uFFxs4gb1qLg1BLKOoU=
X-Received: by 2002:a05:7300:e826:b0:304:8881:b82 with SMTP id
 5a478bee46e88-30488810bd7mr2815420eec.1.1779789852421; Tue, 26 May 2026
 03:04:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523085102.51000-1-clamor95@gmail.com> <20260523085102.51000-2-clamor95@gmail.com>
 <CAMRc=MfXVwD2u0e115RapnyLzf5JRjWMs=2PSNzMnm0GDd7aaQ@mail.gmail.com>
In-Reply-To: <CAMRc=MfXVwD2u0e115RapnyLzf5JRjWMs=2PSNzMnm0GDd7aaQ@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 26 May 2026 13:03:59 +0300
X-Gm-Features: AVHnY4JzVg_O8P7k26t8Ze2LsHov-mbPzQTfo6cA9NaMmsFopTOCr3ZbuuFWfFQ
Message-ID: <CAPVz0n1G5Yu2X5f+=q90RAbnsWi9psMq-L5tWDMM4JRC4R_mPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: tegra: Document Nvidia Tegra
 modem pwrseq
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 26 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 12:5=
1 Bartosz Golaszewski <brgl@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, May 23, 2026 at 10:51=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmail=
.com> wrote:
> >
> > Document the Tegra modem pwseq used by various devices based on the Nvi=
dia
> > Tegra SoC, describing its usage. The power sequence provides interactio=
n
> > between the modem and SoC-specific interface configurations.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
>
> ...
>
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    pwrseq-modem {
> > +        compatible =3D "nvidia,tegra-modem-pwrseq";
> > +
> > +        enable-gpios =3D <&gpio 165 GPIO_ACTIVE_HIGH>;
> > +        power-supply =3D <&vdd_3v3_vbat>;
> > +
> > +        nvidia,usb-bus =3D <&usb2>;
> > +    };
> > --
> > 2.51.0
> >
>
> I assume there's no such component as the tegra modem *pwrseq*?

Hardware component, I assume no.

> What is the relationship between this node and the "infineon,xmm6260"
> compatible node?
>

The xmm6260 has a phandle reference to it. Since there is consumer
matching logic in the pwrseq driver I am leaning towards removing this
node entirely. This patches is still in non-final stage and I would
like to hear any opinions on the way to improving it.

> Bart
