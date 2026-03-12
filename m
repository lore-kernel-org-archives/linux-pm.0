Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86883C8725
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773329644; cv=pass; b=u3YTEeWMYVUb0XUbTtRmXkmqxHf3X4BZV000rl9ivbbPNT2bwelmVPmpxUcLA/yZKnPFNj/5cctEAGil0NXKlz5lMevX3tCb5WKAz8MB6PlmFB0acTdDUtm5c4aP1DxtSvVxnN7ofm+Ax5N/hhaQ3Z3kGg8YmqhLkyQc9Ukjl7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773329644; c=relaxed/simple;
	bh=KsyKo+bsffknCW+m5t5eF8i8EeVtUEF5tsB44WLjUoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWsn2zzF7toVRT7Ecx0CIUK81FnUbJv2/oZ+zSGp5sBuox9YoP3NzkKgzct4rxgcVkyJwfQFNcQDi+NbVIunNmjrz9p4dLtvsdPLLfXVn6KJKD9wZKEqwtelOLh6PvEQg+ZqcDmZJrYy6sUDCmOTB3annEpVmpbd6e4FYK597Zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbcfhAkr; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbcfhAkr"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439fe4985efso1019817f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 08:34:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773329641; cv=none;
        d=google.com; s=arc-20240605;
        b=ROkZ5Rg9Bp/R4ETF3QFhGuZr+I8d28nAKWrjnXmRi9KoHcy6kBZl+UKU/zHi7S/Hls
         zzx9fz2GGzba4PIhzZqRslhdJDtv2GC1lEW/hTIa3/4jlktT2S9dnRrzZgdmo0iTz4uB
         8MUR0N3+XZCvyz8U0Gp3OpGMb1phZrMMiEoBI0+SdYgpKba4OB4nq7EBmevImmH/HQ3Y
         U/HkBWXhyLzt9RtDwwr/fbvJa6JwbnDfAbvFkF5EfV9apQYNo7paRskB4aoMRcO5OPk6
         +a6OtQ/BPGgyfWwzbspwindtsHS/38CWlCdjF0IDcAiW9is9icvP3g6cBkl83lWfdkJW
         4Clw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tJIj5/iiczZuhVB8h8Ir9kBxoso1VQddtPwfDCja9rE=;
        fh=9r4Ecwbbrmyd4PCvvrKatUJmTsqbUcFnVc+f9LNaDdg=;
        b=LOcVurYost1DWndFvsYg0vOO1ukVJUfIMW60sAs+zGZnWKAmkunTWcchcnQmUCeQsd
         EdUxxRVf3cAlkzloIqU854SYva/XQj0EjEhjI3yKQU8N+LbNDwAnRU8FQT/Ki1tDv67R
         xirgnWpdiTpLwvLiFjNxnor3OKnbYSWYVQf98IJaRwjorNOVYSVxCOXUxk8Ny8f/Mf+X
         SEgTtJkK7Mu9ByrB+eQdExEkmAVqvZqqQBw6RupYWgerFb2WAH5TF640Em+cxqt0MMY7
         l2CjiQEHViEqIowv29cCZTI2y08sVMroPRuUtk2lXAm/+X/RejYHNdnKLJj3WR18Y/SP
         TMHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773329641; x=1773934441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJIj5/iiczZuhVB8h8Ir9kBxoso1VQddtPwfDCja9rE=;
        b=PbcfhAkrIjrzhYKgNB9bo/vxeZVGfbmJY7Kton07Ph/mmz0Ncox4MLGecXe9hpBl/6
         2VvHMOiceB/k/MHHA/cquy4e1B+udM2pTb5Fo0vE9qi8LYtstCbqa9bFOzmoVLdj/fQK
         0JGJ7iCMrW60/KxOZfmgdB41qgMWJBrimrkqhrKF9VSprszy0IUA7TQuxC2bKci1+6Ax
         Z+NOfJovYLGEv+MWvqQ6tkzSW9pjyY4vwrEtYrKp7vmex7//+k+6bGtV+4OHMx1xNV3u
         IgA31LsfDkJ+e1Lr51ziQ6SO1diC0Mfb6fcfJhWTsOV8ptW63Bj0odd4HF8S55SYf9zs
         1F1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773329641; x=1773934441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tJIj5/iiczZuhVB8h8Ir9kBxoso1VQddtPwfDCja9rE=;
        b=Rcf27nRxKFkaL0XHdMgzKwQL/a2bXAFGjsBZBKkYpwbxkHgMEZh7x2GSPrMatl+vhO
         pO2OlFs6V/5KkrwkBQsu9Gp+5+5/dvcFydVuYbCV7p+kpAwrATAGPO/QH7W1AnskhOpd
         Rvh8nnLOHT2G13TP569sr75k4SqzWjYBtv/uESH9ov2apdw3KXIZnwXyMW0/ZbDGkYa1
         wXhM3EJ3JI8RPPiPfFF0ciJoWNuKYcMx7QemM/+LHJfeKthO3uTkIwsK9o1HTJf/gV/1
         g2VvHz9pnMu57uhoTtAQZKFRmRpVZe4Wo6WOhk8ssVKZIyr/9wy1PaPDH5Y+j9hAvKUG
         5Glw==
X-Forwarded-Encrypted: i=1; AJvYcCUiAJIZ7UaLF43EZMZlDdkEuT7hlB6k58OzDXGMXjus/fmFfdhzgXp3HXePb/y1OX0uWUb7h7dH/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxvdGffXdIfV4CSnsCrt8u/DT687oGu05l4PDs0rIa8r9rlgNn
	3WwxA4r6TtKSQvqHEOHzhdmQtXQku4th+68gGO2DFp7evDzh0BlfZXHVUSi7y/z0Tb/gqm8hMgb
	vnahTe0IqdxOoIjBHOEQ42EWNok2UbLg=
X-Gm-Gg: ATEYQzzVTRbS7EuMFeZ8u+8LzGfEpPFB1SaNdOeKyAHe/CFwNVRL53Z+Szed8cM8vjF
	jLz1fLRdvlFKuzSNVTNqooaLLYBJdilPgt3FjttOwWsAw41RpqPiaHiXBvVeRdNFQE5WNwZPy42
	ALH91uJy0yI7FnzUlO5/X0SAGLKyi/KYncLszPS3HiZZG0OQicYyt7xQYeQwfPSZ/IrzsTzHtor
	Y3R9Ryb97mlCvE/rToD1VA8zz58JJsZAvCHOY5kQiQ7qpOesxCmqBXyt/TCiLPZC66bV4PW1NOn
	Y1SbfQ/K1TEpbahsrBE=
X-Received: by 2002:a05:6000:2001:b0:439:b374:c6d8 with SMTP id
 ffacd0b85a97d-43a04dc0df7mr188244f8f.46.1773329640809; Thu, 12 Mar 2026
 08:34:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312085258.11431-1-clamor95@gmail.com> <20260312085258.11431-3-clamor95@gmail.com>
 <20260312152057.GA3156966-robh@kernel.org>
In-Reply-To: <20260312152057.GA3156966-robh@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 12 Mar 2026 17:33:48 +0200
X-Gm-Features: AaiRm52ThY9ToN1AUcz1wSgudV_rFXLHUlXwRDrBsn_7Gy5q-dftuHNvcbnGNg4
Message-ID: <CAPVz0n2GFgsrqo4_MkvNwd9t=DMU4ZGQzrpNjU+PZ4_Ysx_jcg@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] dt-bindings: pinctrl: pinctrl-max77620: convert to
 DT schema
To: Rob Herring <robh@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 12 =D0=B1=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 17:20 Rob =
Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, Mar 12, 2026 at 10:52:55AM +0200, Svyatoslav Ryhel wrote:
> > Convert pinctrl-max77620 devicetree bindings for the MAX77620 PMIC from
> > TXT to YAML format. This patch does not change any functionality; the
> > bindings remain the same.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../pinctrl/maxim,max77620-pinctrl.yaml       |  97 +++++++++++++
> >  .../bindings/pinctrl/pinctrl-max77620.txt     | 127 ------------------
> >  2 files changed, 97 insertions(+), 127 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/maxim,max=
77620-pinctrl.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-m=
ax77620.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pinctrl/maxim,max77620-p=
inctrl.yaml b/Documentation/devicetree/bindings/pinctrl/maxim,max77620-pinc=
trl.yaml
> > new file mode 100644
> > index 000000000000..4e5f997317ca
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/maxim,max77620-pinctrl.=
yaml
> > @@ -0,0 +1,97 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pinctrl/maxim,max77620-pinctrl.yaml=
#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Pinmux controller function for Maxim MAX77620 Power management =
IC
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +description:
> > +  Device has 8 GPIO pins which can be configured as GPIO as well as th=
e
> > +  special IO functions.
> > +
> > +allOf:
> > +  - $ref: /schemas/pinctrl/pincfg-node.yaml
> > +  - $ref: /schemas/pinctrl/pinmux-node.yaml
>
> Don't these properties apply to the child nodes?
>

They do, but not all properties defined in those schema files are
applicable for this binding. I have marked those which can be applied
in the node patterns.

> > +
> > +patternProperties:
> > +  "^(pin|gpio).":
> > +    type: object
>
>        additionalProperties: false

I will move additionalProperties here then.


>
> Or unevaluatedProperties with the $refs moved here.
>
> > +
> > +    properties:
> > +      pins:
> > +        items:
> > +          enum: [ gpio0, gpio1, gpio2, gpio3, gpio4, gpio5, gpio6, gpi=
o7 ]
> > +
> > +      function:
> > +        items:
> > +          enum: [ gpio, lpm-control-in, fps-out, 32k-out1, sd0-dvs-in,=
 sd1-dvs-in,
> > +                  reference-out ]
> > +
> > +      drive-push-pull: true
> > +      drive-open-drain: true
> > +      bias-pull-up: true
> > +      bias-pull-down: true
> > +
> > +      maxim,active-fps-source:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description: |
> > +          FPS source for the GPIOs to get enabled/disabled when system=
 is in
> > +          active state. Valid values are:
> > +          - MAX77620_FPS_SRC_0: FPS source is FPS0.
> > +          - MAX77620_FPS_SRC_1: FPS source is FPS1
> > +          - MAX77620_FPS_SRC_2: FPS source is FPS2
> > +          - MAX77620_FPS_SRC_NONE: GPIO is not controlled by FPS event=
s and
> > +                                   it gets enabled/disabled by registe=
r access.
> > +          Absence of this property will leave the FPS configuration re=
gister
> > +          for that GPIO to default configuration.
> > +
> > +      maxim,active-fps-power-up-slot:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          Sequencing event slot number on which the GPIO get enabled w=
hen
> > +          master FPS input event set to HIGH. This is applicable if FP=
S source
> > +          is selected as FPS0, FPS1 or FPS2.
> > +        enum: [0, 1, 2, 3, 4, 5, 6, 7]
> > +
> > +      maxim,active-fps-power-down-slot:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          Sequencing event slot number on which the GPIO get disabled =
when
> > +          master FPS input event set to LOW. This is applicable if FPS=
 source
> > +          is selected as FPS0, FPS1 or FPS2.
> > +        enum: [0, 1, 2, 3, 4, 5, 6, 7]
> > +
> > +      maxim,suspend-fps-source:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          This is same as property "maxim,active-fps-source" but value=
 get
> > +          configured when system enters in to suspend state.
> > +
> > +      maxim,suspend-fps-power-up-slot:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          This is same as property "maxim,active-fps-power-up-slot" bu=
t this
> > +          value get configured into FPS configuration register when sy=
stem
> > +          enters into suspend. This is applicable if suspend state FPS=
 source
> > +          is selected as FPS0, FPS1 or FPS2.
> > +        enum: [0, 1, 2, 3, 4, 5, 6, 7]
> > +
> > +      maxim,suspend-fps-power-down-slot:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          This is same as property "maxim,active-fps-power-down-slot" =
but this
> > +          value get configured into FPS configuration register when sy=
stem
> > +          enters into suspend. This is applicable if suspend state FPS=
 source
> > +          is selected as FPS0, FPS1 or FPS2.
> > +        enum: [0, 1, 2, 3, 4, 5, 6, 7]
> > +
> > +    required:
> > +      - pins
> > +
> > +additionalProperties: false
> > +
> > +# see maxim,max77620.yaml for an example
> > diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-max77620=
.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-max77620.txt
> > deleted file mode 100644
> > index 28fbca180068..000000000000
> > --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-max77620.txt
> > +++ /dev/null
> > @@ -1,127 +0,0 @@
> > -Pincontrol driver for MAX77620 Power management IC from Maxim Semicond=
uctor.
> > -
> > -Device has 8 GPIO pins which can be configured as GPIO as well as the
> > -special IO functions.
> > -
> > -Please refer file <devicetree/bindings/pinctrl/pinctrl-bindings.txt>
> > -for details of the common pinctrl bindings used by client devices,
> > -including the meaning of the phrase "pin configuration node".
> > -
> > -Optional Pinmux properties:
> > ---------------------------
> > -Following properties are required if default setting of pins are requi=
red
> > -at boot.
> > -- pinctrl-names: A pinctrl state named per <pinctrl-bindings.txt>.
> > -- pinctrl[0...n]: Properties to contain the phandle for pinctrl states=
 per
> > -             <pinctrl-bindings.txt>.
> > -
> > -The pin configurations are defined as child of the pinctrl states node=
. Each
> > -sub-node have following properties:
> > -
> > -Required properties:
> > -------------------
> > -- pins: List of pins. Valid values of pins properties are:
> > -                   gpio0, gpio1, gpio2, gpio3, gpio4, gpio5, gpio6, gp=
io7.
> > -
> > -Optional properties:
> > --------------------
> > -Following are optional properties defined as pinmux DT binding documen=
t
> > -<pinctrl-bindings.txt>. Absence of properties will leave the configura=
tion
> > -on default.
> > -     function,
> > -     drive-push-pull,
> > -     drive-open-drain,
> > -     bias-pull-up,
> > -     bias-pull-down.
> > -
> > -Valid values for function properties are:
> > -     gpio, lpm-control-in, fps-out, 32k-out, sd0-dvs-in, sd1-dvs-in,
> > -     reference-out
> > -
> > -There are also customised properties for the GPIO1, GPIO2 and GPIO3. T=
hese
> > -customised properties are required to configure FPS configuration para=
meters
> > -of these GPIOs. Please refer <devicetree/bindings/mfd/max77620.txt> fo=
r more
> > -detail of Flexible Power Sequence (FPS).
> > -
> > -- maxim,active-fps-source:           FPS source for the GPIOs to get
> > -                                     enabled/disabled when system is i=
n
> > -                                     active state.  Valid values are:
> > -                                     - MAX77620_FPS_SRC_0,
> > -                                             FPS source is FPS0.
> > -                                     - MAX77620_FPS_SRC_1,
> > -                                             FPS source is FPS1
> > -                                     - MAX77620_FPS_SRC_2 and
> > -                                             FPS source is FPS2
> > -                                     - MAX77620_FPS_SRC_NONE.
> > -                                             GPIO is not controlled
> > -                                             by FPS events and it gets
> > -                                             enabled/disabled by regis=
ter
> > -                                             access.
> > -                                     Absence of this property will lea=
ve
> > -                                     the FPS configuration register fo=
r that
> > -                                     GPIO to default configuration.
> > -
> > -- maxim,active-fps-power-up-slot:    Sequencing event slot number on w=
hich
> > -                                     the GPIO get enabled when
> > -                                     master FPS input event set to HIG=
H.
> > -                                     Valid values are 0 to 7.
> > -                                     This is applicable if FPS source =
is
> > -                                     selected as FPS0, FPS1 or FPS2.
> > -
> > -- maxim,active-fps-power-down-slot:  Sequencing event slot number on w=
hich
> > -                                     the GPIO get disabled when master
> > -                                     FPS input event set to LOW.
> > -                                     Valid values are 0 to 7.
> > -                                     This is applicable if FPS source =
is
> > -                                     selected as FPS0, FPS1 or FPS2.
> > -
> > -- maxim,suspend-fps-source:          This is same as property
> > -                                     "maxim,active-fps-source" but val=
ue
> > -                                     get configured when system enters=
 in
> > -                                     to suspend state.
> > -
> > -- maxim,suspend-fps-power-up-slot:   This is same as property
> > -                                     "maxim,active-fps-power-up-slot" =
but
> > -                                     this value get configured into FP=
S
> > -                                     configuration register when syste=
m
> > -                                     enters into suspend.
> > -                                     This is applicable if suspend sta=
te
> > -                                     FPS source is selected as FPS0, F=
PS1 or
> > -
> > -- maxim,suspend-fps-power-down-slot: This is same as property
> > -                                     "maxim,active-fps-power-down-slot=
" but
> > -                                     this value get configured into FP=
S
> > -                                     configuration register when syste=
m
> > -                                     enters into suspend.
> > -                                     This is applicable if suspend sta=
te
> > -                                     FPS source is selected as FPS0, F=
PS1 or
> > -                                     FPS2.
> > -
> > -Example:
> > ---------
> > -#include <dt-bindings/mfd/max77620.h>
> > -...
> > -max77620@3c {
> > -
> > -     pinctrl-names =3D "default";
> > -     pinctrl-0 =3D <&spmic_default>;
> > -
> > -     spmic_default: pinmux@0 {
> > -             pin_gpio0 {
> > -                     pins =3D "gpio0";
> > -                     function =3D "gpio";
> > -             };
> > -
> > -             pin_gpio1 {
> > -                     pins =3D "gpio1";
> > -                     function =3D "fps-out";
> > -                     maxim,active-fps-source =3D <MAX77620_FPS_SRC_0>;
> > -             };
> > -
> > -             pin_gpio2 {
> > -                     pins =3D "gpio2";
> > -                     function =3D "fps-out";
> > -                     maxim,active-fps-source =3D <MAX77620_FPS_SRC_1>;
> > -             };
> > -     };
> > -};
> > --
> > 2.51.0
> >
