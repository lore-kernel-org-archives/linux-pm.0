Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEB13D8907
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 15:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773329965; cv=none; b=KkSzcJqUkha1+UaaaGO5esX+UT5JcAx6fTXku6GLnaM2lAvqjndFQR2JSeDT7t5+QI1A8wcEw5rbdxqrbdFIB+iH0iD7LltUwua7KYTPek7XWJoZOYlUQ8VmIFWm4olK5ZR85Evc7DQDkRXdQBi3CDNZl3Bjwsa48EaVAtmahPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773329965; c=relaxed/simple;
	bh=XXvLl1JMNQ39aGONuxM9Xyq2A8SuZ0XcrOSi1495jRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XcPl/BsJCffFC/vT3x0iAnbnu43zjK+6lNvyauyCXIe7RmbiLqldTG9mpkNV+ewEOmDH1xcbs1HVR74//lKsrqG+n8+UKm159wxcUR8PVHV82n4deeGuRpx4n+P1asIQz2KMkoY9mSYBNzznx1uDiosIYahcXDN5Q7iEbAtdQTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ue+sCaJP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ue+sCaJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2E5C2BCB5
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 15:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773329965;
	bh=XXvLl1JMNQ39aGONuxM9Xyq2A8SuZ0XcrOSi1495jRg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ue+sCaJPdbhAEOWzvPHVLaPyvnzg01KwD4B65c+aw9s0Ei1P05V43wUb8rSXgLrmZ
	 fByCIylTYRTwsBtN5hfdzNl5ApMZ/CocaUe9QQp+ffto1cRZs32yr1u560PXqDG8ZU
	 bCvG4zTCPlz32wpkblyaHWhuJxAe50WyULlXONm2UrSxfpobZ9dwlqStnEi26EucZN
	 5WOHNLa10CRqkhRhJwQbHuuOZLx+PA7keeoZyfGZAOU8Pj4JC3d09OANr4JferUpkj
	 ZnJgukMQhS8i32W0HAxUr0g2Yy3umDBSMfrYAolJISlf9lGI+o6eP+hDtjNny6nWbw
	 CSV/MYpp1YWjg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9358bc9c50so150849266b.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 08:39:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWT1HZj+3KNY+OzfoWrK+0vWCa/xLHPd/LvNYbCOnbZak+Cn3Fbzz70Z8UKh/rbUeb8UCHbDRF/TQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzP/kZyzMnOSszkUWttDXHyVkpmeCJ+EidVNzQFehDC8Cm4szCN
	zFe/JCFa0an4tZYkbudNAOah72D9ngKuerZx54oQ69hfbrnB1V6Z+oE3I+0iw5aYkc5EMgGe1YE
	H/7+DyfyH8RbW3DwRvDsbd6oSf/xElA==
X-Received: by 2002:a17:907:3ea8:b0:b97:3bbe:e432 with SMTP id
 a640c23a62f3a-b973bbef8d2mr287604066b.23.1773329964022; Thu, 12 Mar 2026
 08:39:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312085258.11431-1-clamor95@gmail.com> <20260312085258.11431-3-clamor95@gmail.com>
 <20260312152057.GA3156966-robh@kernel.org> <CAPVz0n2GFgsrqo4_MkvNwd9t=DMU4ZGQzrpNjU+PZ4_Ysx_jcg@mail.gmail.com>
In-Reply-To: <CAPVz0n2GFgsrqo4_MkvNwd9t=DMU4ZGQzrpNjU+PZ4_Ysx_jcg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 12 Mar 2026 10:39:11 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKP-uYZf3MLFd5JrrsZ1+pxj-y+te_3uiM9N+5Xu4phUQ@mail.gmail.com>
X-Gm-Features: AaiRm53TzVm_dQOjnoVm3K-wLtXfqwBBSfOhKn3tw-hQAbmwJ_qep65WpVUysIo
Message-ID: <CAL_JsqKP-uYZf3MLFd5JrrsZ1+pxj-y+te_3uiM9N+5Xu4phUQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] dt-bindings: pinctrl: pinctrl-max77620: convert to
 DT schema
To: Svyatoslav Ryhel <clamor95@gmail.com>
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

On Thu, Mar 12, 2026 at 10:34=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmail.c=
om> wrote:
>
> =D1=87=D1=82, 12 =D0=B1=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 17:20 Ro=
b Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Thu, Mar 12, 2026 at 10:52:55AM +0200, Svyatoslav Ryhel wrote:
> > > Convert pinctrl-max77620 devicetree bindings for the MAX77620 PMIC fr=
om
> > > TXT to YAML format. This patch does not change any functionality; the
> > > bindings remain the same.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  .../pinctrl/maxim,max77620-pinctrl.yaml       |  97 +++++++++++++
> > >  .../bindings/pinctrl/pinctrl-max77620.txt     | 127 ----------------=
--
> > >  2 files changed, 97 insertions(+), 127 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/pinctrl/maxim,m=
ax77620-pinctrl.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl=
-max77620.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/pinctrl/maxim,max77620=
-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/maxim,max77620-pi=
nctrl.yaml
> > > new file mode 100644
> > > index 000000000000..4e5f997317ca
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pinctrl/maxim,max77620-pinctr=
l.yaml
> > > @@ -0,0 +1,97 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pinctrl/maxim,max77620-pinctrl.ya=
ml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Pinmux controller function for Maxim MAX77620 Power managemen=
t IC
> > > +
> > > +maintainers:
> > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > +
> > > +description:
> > > +  Device has 8 GPIO pins which can be configured as GPIO as well as =
the
> > > +  special IO functions.
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/pinctrl/pincfg-node.yaml
> > > +  - $ref: /schemas/pinctrl/pinmux-node.yaml
> >
> > Don't these properties apply to the child nodes?
> >
>
> They do, but not all properties defined in those schema files are
> applicable for this binding. I have marked those which can be applied
> in the node patterns.

Then additionalProperties is appropriate.

> > > +
> > > +patternProperties:
> > > +  "^(pin|gpio).":
> > > +    type: object
> >
> >        additionalProperties: false
>
> I will move additionalProperties here then.

No, moving it is wrong. You need it here AND in the parent node.

Rob
