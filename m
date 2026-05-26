Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19783DEFE7
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794091; cv=none; b=QFGRvomcSINecqyATgOP1EeDhYV1V66XRgRzUYhCHuvz7tT1Ok0qoGReMonqIwTGTWtnJMFChxs1EZ8PJN6X71ZW+i2tga2xRbiEd6QumgEbCaXMJmic9DkeFxmgnYRiegrm/Mf//gycs+p8SOcpYBAootZPvc0Da1K5WMoI4p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794091; c=relaxed/simple;
	bh=8x7v1Mv6tuIs9sjMbBqRcyLtfQG/Nl3LqnbWxIpVYko=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=baY8tIJ/CqPkVWDJS9bu4UZPlMOCK914pQ1AzyMeOzSDHIj3Kt1RTNYQUoR851CSoPXgQZE5SUpGRoPxuK8YsPZ9wPQTVdE6RRFGsB34X2vSuf4dQxA53ikfjFMjZzQpUyLorTonH4wbsiUoT/N+XnPdWJBOXOzqc6kCJ1CBM20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHs42++e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHs42++e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529361F00A3F
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 11:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779794090;
	bh=E2kOdFDhgWIu+MPmwrmzf4P6ZSq1/YuSms4C2k+gQRg=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=QHs42++eN9Hq+gywnoG2SxUijkwj0RfbQ1EibLSsZqGBmVDIcqgmwzk1TEy0+XRF7
	 xlZFi4LTRfvpJivbojpXE3PWke7paRh5MAuZKje8TLf6GzRugPZtKfCJzgrZRdWp5B
	 eixGeKt7kLvPREF3XDCZp2CMWtKpJkJ6gg9SSYslAV/auP5yxoAnEV7bDl//qQTd17
	 Q2NBvTu0yAdDOx1qJkYUO/DOFqB1AnwEFlbW0ChR7ac41GkgjGP0jOKj9OTuZohWyo
	 Ad89S60OeuM0TUiRUoRy+ptY8zMvng8MrlQd/swUULu/8vy+XzJu80d+NsI/gtM+LW
	 vJ6UTxIQUMsOw==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38e7d983f79so96439531fa.0
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 04:14:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/3V0qFHEFiz5vfksq4bEOgh9AX5kayDzgYekbRdIdc8Ykr0O0f/9/BFHZz0wxpjRGkL5pgKP5DJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKEsscB6KdHNpjTAL1M7EPLxaWHxVD1b7WuEMqdfInUPLaiJ4W
	vYPKUIdhzNjNlahnmXrVr3ZV6sb7LEhArLuCS0ldpkam7Bp2Llos8J929Ndh1QysFmwb7XmQUzt
	HwbZX4+dXjhJJcXH5tz1yAqBaK1XcKHdRBw3Z9UIR8g==
X-Received: by 2002:a05:651c:1586:b0:392:454a:47a with SMTP id
 38308e7fff4ca-395d8dc6495mr56382991fa.28.1779794089011; Tue, 26 May 2026
 04:14:49 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 26 May 2026 07:14:47 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 26 May 2026 07:14:47 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CAPVz0n1G5Yu2X5f+=q90RAbnsWi9psMq-L5tWDMM4JRC4R_mPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523085102.51000-1-clamor95@gmail.com> <20260523085102.51000-2-clamor95@gmail.com>
 <CAMRc=MfXVwD2u0e115RapnyLzf5JRjWMs=2PSNzMnm0GDd7aaQ@mail.gmail.com> <CAPVz0n1G5Yu2X5f+=q90RAbnsWi9psMq-L5tWDMM4JRC4R_mPg@mail.gmail.com>
Date: Tue, 26 May 2026 07:14:47 -0400
X-Gmail-Original-Message-ID: <CAMRc=Me4G-YqKoFan3epofXk2OWzxY1iPE1mP=uwEjs9wgA6Cw@mail.gmail.com>
X-Gm-Features: AVHnY4LR9l-b2s5D4U7lp3jFcFTBHEkrzcFP4aWpe-PQvVMcMIisw4oZPWQMLPY
Message-ID: <CAMRc=Me4G-YqKoFan3epofXk2OWzxY1iPE1mP=uwEjs9wgA6Cw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: tegra: Document Nvidia Tegra
 modem pwrseq
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 26 May 2026 12:03:59 +0200, Svyatoslav Ryhel <clamor95@gmail.com> s=
aid:
> =D0=B2=D1=82, 26 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 12=
:51 Bartosz Golaszewski <brgl@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>>
>> On Sat, May 23, 2026 at 10:51=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmai=
l.com> wrote:
>> >
>> > Document the Tegra modem pwseq used by various devices based on the Nv=
idia
>> > Tegra SoC, describing its usage. The power sequence provides interacti=
on
>> > between the modem and SoC-specific interface configurations.
>> >
>> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>> > ---
>>
>> ...
>>
>> > +
>> > +examples:
>> > +  - |
>> > +    #include <dt-bindings/gpio/gpio.h>
>> > +
>> > +    pwrseq-modem {
>> > +        compatible =3D "nvidia,tegra-modem-pwrseq";
>> > +
>> > +        enable-gpios =3D <&gpio 165 GPIO_ACTIVE_HIGH>;
>> > +        power-supply =3D <&vdd_3v3_vbat>;
>> > +
>> > +        nvidia,usb-bus =3D <&usb2>;
>> > +    };
>> > --
>> > 2.51.0
>> >
>>
>> I assume there's no such component as the tegra modem *pwrseq*?
>
> Hardware component, I assume no.
>
>> What is the relationship between this node and the "infineon,xmm6260"
>> compatible node?
>>
>
> The xmm6260 has a phandle reference to it. Since there is consumer
> matching logic in the pwrseq driver I am leaning towards removing this
> node entirely. This patches is still in non-final stage and I would
> like to hear any opinions on the way to improving it.
>

The node attached to the pwrseq provider device should represent a real
hardware component. Are the enable-gpios and power-supply lines connected
to the modem package? Is there an internal structure to it, like a PMIC to
which these lines connect that controls the actual modem IC?

Bart
