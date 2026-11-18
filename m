Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795033174;
	b=IaPvRbt+34Cr0OXLpbz+nGAT0bz9QsDwB+H6UGxlSBiy68albLaoK8iPxnUdUe7BIfOe
	 MfMiIzz7OEZ0uCBylL0kl3amS1tft4yl1qDEzCjmvEoShN+m8FwM/AHSjJ7Y+l/EiamJ9
	 UeDD7mGHcZMFuwpftnLNHL9leQ5uIIWmP/5NjXc9FKWBLwWdUrWk9Kul8VUSLpmRZA3gw
	 XvLiZsJxQaqz4DGw/Dqs7QQvE81r2giDeaDd1nwOnIWyFS6YZ4Kl/le1E6PAmdhDYwtKP
	 AOZnX7t0Q5grAndO7YI4ay5lXQ6724AEB8KRt3V9o0MZYl1bY8Qlh0LVNWihY/dwO1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795033174;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VIqubSxa6chp+PQfAvvw0Nq36rRNM/+XIF5m2rPT+yM=;
	b=KZx9IuVGnAdlq3rlRF7Fz1CGC2Ha9pGr6bugK6KU0JQirr6J58LORDXWI08J4nnnmfo6
	 KPgWSpOagLrfzq4W107KwQRsqsLl2iFNlQs0YK+Utd7h3BEOR4Ai7T3E+HYo28IrA6mBD
	 5Rsgrc8ElAV41cx2uHTus8Pri0rX5pzA36PXAk6dWApqYTibxeDw1js1oQaujmfcmLBD3
	 Tt3SlMhZtLarkcTUgxpOoRQfYsSVHK7z+0gXNDftOuPPt2uAINwn00yPlwvINKzh63huw
	 SNCJkh2xLJhU5wyPyqb8/jek+oRVvKca6Sbb82hpB65jjfyYsRUuHol2/0jBOs4c5/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O1XCocHm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0899E60A2604
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 20:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O1XCocHm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BED1F000CA
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 20:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795033173;
	bh=VIqubSxa6chp+PQfAvvw0Nq36rRNM/+XIF5m2rPT+yM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=O1XCocHmC1uEbbj94W+sS5HN2aQj/aTWDgTaCJnorv60lbj1qrFLyAyz435tV64SD
	 hjiTpKQP1aBE5Xqtu5DiEyl6PUEt+xKRZPmPy8EcRVZ/gD+TO2QbbYVuo+tY5i/rc7
	 s7yKP/GovMGVe42SGHjiOot1t609AFaWZPHF4bm/5spD5boP/9q0vZOCG5uHrXy7z5
	 FNbVyGMdlFzI39I1E6Wu1jFhLAOzqUm8/3ZPdWX2oD48S9sxkvJ+IWf6g9VQODhygK
	 SYXFlpG6zoGOx49CIleiayWZZt/gXd6lgejMByp6jAVfvl9TaG8rjf7EAA8Yav0ee4
	 ohzqEJK5/qgmw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5c1479be604so1151854e87.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 12:19:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGlDK2inetf09mNkbgcF4mitQoJZUs0oM1ZZGa2hgLUIwdTe5i+/n8j8sN8qzvTc9aFMZ/pwVuggA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+UPDyIvTwqrDzoBX5LCCa9gNXyKfjeo4l50rEixcdvBf8Hl6FZ
	9CJ5CZtamSfbMUvigSdOocZnaei8z6q7Q1LpPl8FRhfI0vJhcJ1fYI5IbSe+kaL1BUfE6outzAU
	LWoqKI5KTtRg468o3Ms3ziH/8EsCsXug=
X-Received: by 2002:a05:6512:3e19:b0:5bf:a592:1d6b with SMTP id
 2adb3069b0e04-5c1aa2b7054mr1382701e87.62.1795033172582; Wed, 18 Nov 2026
 12:19:32 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115-ux500-dma40-powerdomain-v1-1-da8b6e1a0376@kernel.org> <av4CJkri6LQO9FxG@SMW015318>
In-Reply-To: <av4CJkri6LQO9FxG@SMW015318>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 18 Nov 2026 21:19:20 +0100
X-Gmail-Original-Message-ID: <CAD++jL=ZFJFTV6zY=SA+aHMQyjw4MQ8zFgWmUUBEoH6vKDLTsA@mail.gmail.com>
X-Gm-Features: Aa3M54pwwb9o1bjEenCJbSQCJmUNEtUd6VLIE0RDxP1yOLbxmTezi19Q1Oe1J4s
Message-ID: <CAD++jL=ZFJFTV6zY=SA+aHMQyjw4MQ8zFgWmUUBEoH6vKDLTsA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: ste_dma40: Use power domain for LCLA SRAM
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 8:53=E2=80=AFPM Frank Li <Frank.li@oss.nxp.com> wro=
te:

> On Sun, Nov 15, 2026 at 10:26:27PM +0100, Linus Walleij wrote:

> > Replace the LCLA ESRAM regulator with runtime PM of the SRAM device
> > owning the ESRAM34 power domain.
(...)
> > -     /* If lcla has to be located in ESRAM we don't need to allocate *=
/
> > -     if (base->plat_data->use_esram_lcla) {
>
> Does it break old dts's back compatiblity?

It would if they were using LCLA SRAM but there are no
DTS:es that actually define the LCLA SRAM, so we are fine,
all existing deployments put the linked lists in common RAM.
It was an oversight or "fix later", "technical debt" that was
introduced 15 years ago.

After this is fixed properly with power domains I want to turn it on.

Yours,
Linus Walleij
