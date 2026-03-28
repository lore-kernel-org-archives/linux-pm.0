Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C9924B28
	for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 21:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774733330; cv=none; b=T1kLEvfvfdUMxcnjc8HULU1r+hNVEp9ZEmkVlThMjqHSBlxtwEUK9wpJO7n1VQE8D+ykI0tqYULErGMe7ZfQ2hXLo8Q82tgMPmuzixKowohnqYc0rt0IsgxLHekt6MHBUpnZMJ3RBLwxZf6Qq7HcswouvHQTxBNfBTIpTjK7TZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774733330; c=relaxed/simple;
	bh=u2LfZ8ZJv9ojvw26Q6CAN5gF2pjVh0mrd37Q6nfnnsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UimgeToeBPwNpUuJtdeFBzls2TnHho+tYS6+SaIO0h685+qFcN6vlOtoILZGisfd5sDouuA9g5jGLZLjIuNgesYDnUkFNZtdGNmf+aLyqGcj+bV6xZyYNGjEIgJd2mwAX8ZfXWYGaP01SipbzEm/Zi+p1IhxEExwCLz1nhA7Agk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvM7IuS7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvM7IuS7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C74EC2BCB0
	for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 21:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774733330;
	bh=u2LfZ8ZJv9ojvw26Q6CAN5gF2pjVh0mrd37Q6nfnnsQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DvM7IuS7Mxgrrm+z4aLxaJ4zdLUnxnJuTfA3NOyRSthlcwc/50WkMpZOpe5V3fjqm
	 nTpNrrHDhDLRQGg4dj16gbRSHOG0CBSXtPCAcCzBpEAM7RpY1Rjf7tU6fJfrcJydGh
	 lbVLUws5Ka+Xw1gJriIR+amMFh0musjZV33DCwoz4LShSiFRuNo5M3IWAMOESb4B4P
	 dmkKc9/E5TN3mLnXV+TF9MdfiWS2CDQ/pA2nayqVl5vkT78ptKagYN9okMcwNuut3E
	 Ro18Cm8BvUTmtmn7xYjpyU7AGjrKLLG1YfLzeuOVTX2qEaQdplG+/9F4K3hC2YrBIz
	 M3I5aZH6Hvg3g==
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64937edbc9eso3285316d50.2
        for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 14:28:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVuJgHJTn8OOrV8Vq5M5ZiLWzhJMmvTzTS8nl/zMTc51CyYbtGTkdwQCE6OdvPDTUcddNZ7oxh1cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YySc9O4AmMVV/sJGWitwe550i6o92tAbxjhSlyK7eNdmS8W15n+
	2K2q22shM7Kt2yORXgKDPx2Pt5CoQN0vm/V0MsvJoGUMWRC2zz46DNSMI3xgGeKRvusbzul6ebO
	fO1SmDmXoZJVcun/VRK1KlJJApZFIWeI=
X-Received: by 2002:a05:690c:c4f9:b0:79e:1fe4:80ed with SMTP id
 00721157ae682-79e1fe48949mr1648177b3.1.1774733329955; Sat, 28 Mar 2026
 14:28:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328124707.141209-1-khushalchitturi@gmail.com>
 <177470797266.1536342.6967120656934552033.robh@kernel.org>
 <CAD++jL=_rCmW=eSV0kvck50sC2xaQnGQoEOy=DNcwkFvvWYUUw@mail.gmail.com> <3fa4fad0-d918-4de0-ad80-dad2141d2617@kernel.org>
In-Reply-To: <3fa4fad0-d918-4de0-ad80-dad2141d2617@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 28 Mar 2026 22:28:39 +0100
X-Gmail-Original-Message-ID: <CAD++jLnxoS-OGBSAXxgGPaME7eMTwCQ-C+uzub6m0o9ZgXL_aA@mail.gmail.com>
X-Gm-Features: AQROBzDO4_qbhnWFNVGZ4F3qRHWcIdRD6YybFnRr_U6GSwMhBoMzuoz7d-b9aSM
Message-ID: <CAD++jLnxoS-OGBSAXxgGPaME7eMTwCQ-C+uzub6m0o9ZgXL_aA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: power: reset: cortina,gemini-power-controller:
 convert to DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Khushal Chitturi <khushalchitturi@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 28, 2026 at 6:31=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
> On 28/03/2026 17:12, Linus Walleij wrote:
> > On Sat, Mar 28, 2026 at 3:26=E2=80=AFPM Rob Herring (Arm) <robh@kernel.=
org> wrote:
> >
> >> dtschema/dtc warnings/errors:
> >> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/binding=
s/power/reset/cortina,gemini-power-controller.example.dtb: power-controller=
@4b000000 (cortina,gemini-power-controller): '#power-domain-cells' is a req=
uired property
> >>         from schema $id: http://devicetree.org/schemas/power/power-dom=
ain.yaml
> >
> > Weird, this power controller does not handle power domains whatsoever,
> > it handles the mains power. So it should not have any power domain
> > cells.
> >
> > Is this the result of some regexp gone stray?
>
> The name "power controller" is used for power domain controller, so
> that's why this name must not be used for other use cases. Usual
> replacement is power-management, reboot, restart or poweroff, depending
> on what is the purpose of this device.

So in this case this is just a conversion of the 9 years old text document
which is an as valid binding as any:

commit ba443b5ab454a9b5f49229a94b2dadf06ac8b79e
Author: Linus Walleij <linusw@kernel.org>
Date:   Sun Mar 12 23:36:01 2017 +0100

    power: reset: Add Gemini poweroff DT bindings

    This adds device tree bindings to the power management controller
    in the Gemini SoC.

    Cc: devicetree@vger.kernel.org
    Cc: Janos Laube <janos.dev@gmail.com>
    Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
    Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
    Cc: Florian Fainelli <f.fainelli@gmail.com>
    Acked-by: Rob Herring <robh@kernel.org>
    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
    Signed-off-by: Sebastian Reichel <sre@kernel.org>

The text document was conspiciously named "gemini-poweroff.txt" while the
compatible is ""cortina,gemini-power-controller".

I don't know what came first, this binding or the convention of
*-power-controller,
but it's solidly there for a while so we need to accomodate this, I guess w=
orst
case simply special-casing it?

Yours,
Linus Walleij
