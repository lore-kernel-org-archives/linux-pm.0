Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636783F7ABD
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332838; cv=pass; b=Z9KOpITRqg85KzOOB3H8gD5fUeyamCJ3g3bO1XCAxqmwLg1V+MZ8SDLSyZgwPv1yBRtFrXb3XCUqu1CEy1xY5iq3CF2Rgxo8eUXiFaYwMB8jHyMOgCa6rbWsQg3RuMbl8CzroDvo6VbeDbNmZBaPfonCAiYj+9y+x3l63MwwYGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332838; c=relaxed/simple;
	bh=uJhH0lI1sVgit2CkGLU8u1v8dwsbJYGM2kBA3mKuxJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZV4o89mIY3X9wNn0eZavA4+RKbidrFoDYGcBWFZO2I/OW0Ji1M63E7uUU9OVl1+clpHD7sDSSo2+EGrDrS+rbsEVgZf/lXI93EUKpOyJYb33jDRY8VSMG+zdL2HzGiaXYI7Z8h3r0+q1PSE2UdazQtcQCuACA9I3sbQY7ouPXXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPxyPH1U; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPxyPH1U"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439b78b638eso1368128f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 09:27:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773332830; cv=none;
        d=google.com; s=arc-20240605;
        b=h5r3PxohJ3O9oO0TGCDys2ETeoO4sffo1C3zU9J+Y9+Zd+mhgTwXqQ4j7vQ77Almz/
         QsAg0iL4lRKVaHqLXGF04vjw2PJ2p44tUYjmYwgaP9P/b+62aOv8RDZInBjYtmjxcvT8
         K0w0HVDfzbMVw0+ETaIRQN9tgGbUP/lwhMqKBLdLk3kjBsrLUZKcRL9xxe/LVi0B2Ahl
         G0aKom7ngT+Zy3RqoVN0ACpJ4wWWSWBBtLtO8nhNa7hczomgam7f4OUnuapfT+MAv9ZJ
         Js9YQpDoJSa90/rBJR76JivUvROdKPtlk60gKucx1oYHlOECmdJeNTB0edtkhktphJFz
         oLdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I7Vb1PKX3Lf9CJi8XSxHNY/kA1vBSZWZueHJy5RvI9M=;
        fh=owOaV7JuZ7+INr7XWJ5TInvoYRcvulhpz53Lym04ImE=;
        b=WNdzV3mEZOzUsCge89If0awe31bl8DqL41bj8WnegHl5aucsXUCojBi5EnIFczMfh6
         Wdldhf2eXxCACHQgrI4i+uWjkyBjVdCW5QEymCOIIUGVsJapBnh7tB05fncpTvOlvvNK
         XN8ZeJaZiSfyoutGOPICJkgohrf4A44ENT4+q9kpSjLAuvN4X3889Pj9AB2kBVGIOhq+
         xigpplsVKxwjFB5/sFU1P5iHSMfFC7Ubfgep9fP4pStF2jJmffuLd8M41vyr50V5R1//
         yIYwgoEWQx4R0cumjcuXt53cSyminmUP61UjNvWr+4GsN/+GP54KpSk2EsnKjfxpKB6n
         SOBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773332830; x=1773937630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7Vb1PKX3Lf9CJi8XSxHNY/kA1vBSZWZueHJy5RvI9M=;
        b=NPxyPH1UQiE56iO1J+Krg8QUq3kWeZN7ewAXlAKDSXLmD9rc8hiJXV6zw0tU7/4eTb
         7K2JV4eNu1HVViAEQvcpPHamtWMW9R/RN8dUfZRT/xFaWFh9ziB0R5y2vk9d81IG3Wql
         edW3lf6vaRoQETYACb7EsiIPOLgLy+DXqMWa/ba0Ly/gq0fFrd4Fe251t/u+qF2R0qAx
         WlxFEbxFqV3HI7hNcrpjKS/KmbHQAInOSmxq7YsBwBCt9UwCRd33E91N2vZYjjCu+I2n
         vM/xSlfa1htcXHU0nvfP4y6p4mEtMIFjElfxdykA5Ty1zJkkklrZKn+EyInyIw2oLdX5
         IGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773332830; x=1773937630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I7Vb1PKX3Lf9CJi8XSxHNY/kA1vBSZWZueHJy5RvI9M=;
        b=giNpHYxr688PGnl9igFCI+kst333wjwn8ZcdTFMdtt8E9K8h2C0c6FPNBnc/XQhnDw
         pIGymryziKiv4LwNkvCI1FvKtjYGbX/1zhWs2ffNA70CZbvMtqEBUHcmVHj6/nEOnpdj
         GaW7rlwtAkCszNGhapocLwKc6NzMphV9SEx724e27+btaFdKNOji2WF1/hSbYhayVP4h
         ENK2C8qUZlk2QdB47jy9U0o076U+O+Eec/tvqM7FtAWA8C7O45rmUyd0xKGrcWsf+pMD
         NEyJ/eLrG74omqzZAbDuycDXWO2McT5uMARpNFW8mIy2WvjH2+FZmVuBHB9A/5LXelE3
         /8oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzVouP00ua/qh9ApXCgQdoHI6GRJZYlJfei/GtP8VmpYZjTeXzlqyF8IkeY4DoOdgDqv0Y5JvyQA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8M07ScOuLebId+9HfnjTsmKlaHH5z07iKNtqGo3pAaNIcaA38
	fu6kbyupTeRFAS7MJo8kNFw2zKg+Bdz7ILXQcEgFvOeYcuW+EqX7UMm2Tm8Yu6FeryplNHaUP73
	lXlUD2GafNWnbCrMzQ5t/0KKXyp6XKC0=
X-Gm-Gg: ATEYQzxxnn18aBYSvA+WnrkAskyKmtBVuYRv4jv6kP9zGQvhCo1KsjhvhvSFfbtLCOp
	PowWbBI1I9WkPvqe0qTKc8yHSGws/ut6uPuwSSsH8dSwWzf3Ow25QFRIt8AYtK98FiK9w7zYs5I
	1tZjbH+Pu/al9R6f8X8mbqKNjayuP9kUE+sVwCd59P8qpUP5OYat40tHrnUj7U7DtWrEOtk2zrW
	9r2WIu5iFlbU1RmSPXrmwXKPHXB58vQYVuAgn3qRJZNDHSsC8pVKRnyiZ3DWlXrOjeFDh/6wCKc
	frxrV02z
X-Received: by 2002:a5d:5f88:0:b0:439:b671:1d8f with SMTP id
 ffacd0b85a97d-43a04dc0ba5mr539681f8f.45.1773332829453; Thu, 12 Mar 2026
 09:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312085258.11431-1-clamor95@gmail.com> <20260312085258.11431-3-clamor95@gmail.com>
 <20260312152057.GA3156966-robh@kernel.org> <CAPVz0n2GFgsrqo4_MkvNwd9t=DMU4ZGQzrpNjU+PZ4_Ysx_jcg@mail.gmail.com>
 <CAL_JsqKP-uYZf3MLFd5JrrsZ1+pxj-y+te_3uiM9N+5Xu4phUQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKP-uYZf3MLFd5JrrsZ1+pxj-y+te_3uiM9N+5Xu4phUQ@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 12 Mar 2026 18:26:57 +0200
X-Gm-Features: AaiRm51Esg3lleAiftngJqOtXTsbfFUPZvmyUsPO32KC3v38pJrGNn7u4Fa_N7g
Message-ID: <CAPVz0n0aTEkmb6tFn72f7O=BvJzvkJ6ri+_TmQbnroNrWQppzQ@mail.gmail.com>
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

=D1=87=D1=82, 12 =D0=B1=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 17:39 Rob =
Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, Mar 12, 2026 at 10:34=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmail=
.com> wrote:
> >
> > =D1=87=D1=82, 12 =D0=B1=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 17:20 =
Rob Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Thu, Mar 12, 2026 at 10:52:55AM +0200, Svyatoslav Ryhel wrote:
> > > > Convert pinctrl-max77620 devicetree bindings for the MAX77620 PMIC =
from
> > > > TXT to YAML format. This patch does not change any functionality; t=
he
> > > > bindings remain the same.
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  .../pinctrl/maxim,max77620-pinctrl.yaml       |  97 +++++++++++++
> > > >  .../bindings/pinctrl/pinctrl-max77620.txt     | 127 --------------=
----
> > > >  2 files changed, 97 insertions(+), 127 deletions(-)
> > > >  create mode 100644 Documentation/devicetree/bindings/pinctrl/maxim=
,max77620-pinctrl.yaml
> > > >  delete mode 100644 Documentation/devicetree/bindings/pinctrl/pinct=
rl-max77620.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/pinctrl/maxim,max776=
20-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/maxim,max77620-=
pinctrl.yaml
> > > > new file mode 100644
> > > > index 000000000000..4e5f997317ca
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/pinctrl/maxim,max77620-pinc=
trl.yaml
> > > > @@ -0,0 +1,97 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/pinctrl/maxim,max77620-pinctrl.=
yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Pinmux controller function for Maxim MAX77620 Power managem=
ent IC
> > > > +
> > > > +maintainers:
> > > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > > +
> > > > +description:
> > > > +  Device has 8 GPIO pins which can be configured as GPIO as well a=
s the
> > > > +  special IO functions.
> > > > +
> > > > +allOf:
> > > > +  - $ref: /schemas/pinctrl/pincfg-node.yaml
> > > > +  - $ref: /schemas/pinctrl/pinmux-node.yaml
> > >
> > > Don't these properties apply to the child nodes?
> > >
> >
> > They do, but not all properties defined in those schema files are
> > applicable for this binding. I have marked those which can be applied
> > in the node patterns.
>
> Then additionalProperties is appropriate.
>
> > > > +
> > > > +patternProperties:
> > > > +  "^(pin|gpio).":
> > > > +    type: object
> > >
> > >        additionalProperties: false
> >
> > I will move additionalProperties here then.
>
> No, moving it is wrong. You need it here AND in the parent node.
>

Oh, yes, you are right, it seems that I did not notice while
converting from txt. Thanks!

> Rob
