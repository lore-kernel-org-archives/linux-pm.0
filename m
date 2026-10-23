Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792760403;
	b=zaI5+Zy5ikdmzdXsuukrGXsJcBe66JSrM8GznkzFy6e9uXHVkr+jTv75japHo3KTmLXo
	 1W+O5NCbqoSBwnBG19as4Q7nRtrjMNODsS9VGOlsBz+bbSsSOKuRcNJhiy+YUilKPHFsw
	 FCvvgZJLZmDdhX6l1aj9MdbyNM4o6eOv1qzcNX1W9ti9YMaKXXj9xqtWFP8abkZgj7UcE
	 wblB1P0JYYH2qxnCZXp3nXAtl+SVWMZ8kBBZS6RDEMBv7x9lk642f8qk8IooyD9MD1vKP
	 YvNMcw357yPwXJ2Sumo+Wy2zHyc1SXDtPlxPfAGYvo208ixQQUZO2rmxcQPvu0c6u9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792760403;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sr19VKYUvxwLrJlgEMdcLVEIVJZklrD+FybJ3ZeZXGw=;
	b=uQNPP2/fszUXDgMEBR7xR0cQz4cFXgaoE42CS5V2y634+RMpXjad/rUh43G3oWrXKaEn
	 hDPv0ODJ/1TTEAlpPfaIz7NZ7+9nSrFtt55Tpl5m6gd6jo3c73Ega6BbjDAl8zFVexPNt
	 O7cgWT3SeblVfEsKpKWy4r56KN26LcNwui4IfnUNtnTob/LFRDoPwW7P3iJDTTKcdX9Ge
	 qtHZAfcEsMdrXWE0aeu4crQteMSu8KUugJ67hWGz79OzYFU5QtZNHeKUO7YiVxlli+gcw
	 gzRAlj5cYoEkPKevomLN4FDtriZz/q4TAUoVw0qkbUVzH8yc1EFiUaMFDg2sS+IRFuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n3b048kK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8252A606A31A
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n3b048kK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555001F031E1
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 13:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792760403;
	bh=sr19VKYUvxwLrJlgEMdcLVEIVJZklrD+FybJ3ZeZXGw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=n3b048kKb1PgtvbhAx1oJQLSk/xFZgNmv8qTeNvWni2JXqRPAezw+xIkNJtW8uarj
	 eNfLC86mRiNlo1HYYvauwH5Y4zlYITncn7JnpGtbsxk7n4cGeETq6R+MwRdb9nKFUu
	 RZzgS8/zXAF0lOg3lI/sJVzLrBfvrz1BsYN32R+98eMUJQ87hhhnpaTlUuh4AvtEk1
	 yT/hUx4TCKNCtMTnkGzm8I76x339WOoxQm4rja12pod/FwXYpLgbAXiyM0M8BQrc/W
	 yjsuqbpbDNPYMihVezf9pYFVzYL7xp70t1bvJBHg+e4eraqugYKki+NLkEqxTR/ptu
	 Q2jx4BzZBKi1A==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5ba3ec92031so895219e87.2
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 06:00:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz5WONqkYExfILDKCqhwaMESQxTk1FYLkM0XnBbgiJ4y2EdiP9LT9QTUZxcjlaiSuYggpEVVe/lCg==@vger.kernel.org
X-Gm-Message-State: AFq9FYI6J9Xf6te64lp3XKSSPJ/GW21KSqz1sg+g3B3F5wZFyQOqAlKx
	EGsOI5ElNWchMdEZS2EVHqYuZzb4YFgVCFtvIJrpPPvRrdVanI8FVxD/6FS+9fC7FgMydrswkXS
	ze/1FW6t/6mpc35aA6jr3kXe1sCW2T1A=
X-Received: by 2002:a05:6512:1244:b0:5ba:3632:cf9 with SMTP id
 2adb3069b0e04-5bfb0a4f3a8mr756271e87.66.1792760401405; Fri, 23 Oct 2026
 06:00:01 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260921-ux500-power-domains-v7-1-v3-4-9352be6b86b1@kernel.org>
 <179242679515.1178810.16625867453853597322.b4-ty@b4> <20261019163732.GH2663669@google.com>
In-Reply-To: <20261019163732.GH2663669@google.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 23 Oct 2026 14:59:49 +0200
X-Gmail-Original-Message-ID: <CAD++jL=8ZgrUHoRuPA=tWnP=iODE7hR_zOGUmTS1p7iRNggivg@mail.gmail.com>
X-Gm-Features: AclHuK-ukw_Hgb4DIFvnusEPhIMVNTAyp8V0dmIgTflHNqlHHkK-tLLwcaoopM4
Message-ID: <CAD++jL=8ZgrUHoRuPA=tWnP=iODE7hR_zOGUmTS1p7iRNggivg@mail.gmail.com>
Subject: Re: (subset) [PATCH v3 04/18] dt-bindings: mfd: db8500-prcmu:
 Deprecate EPOD regulators
To: Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	dmaengine@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 6:37=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
> > On Mon, 21 Sep 2026 00:48:10 +0200, Linus Walleij wrote:

> > > Deprecate the db8500-prcmu-regulators node and make it optional as EP=
OD
> > > control moves to generic power domains. External consumers of VAPE an=
d
> > > VSMPS2 now use the actual AB8500 or AB8505 buck regulators.
> > >
> > > Stop requiring the individual regulator child nodes while retaining
> > > their definitions for existing device trees.
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [04/18] dt-bindings: mfd: db8500-prcmu: Deprecate EPOD regulators
> >         commit: c8132247fe4df52e9982d74c986bb199d792b85b
>
> Hmm ... or would you prefer for the set to go in together?

No this is fine, thanks! :)

Usually I prefer to trickle in dependency patches.

> If so, how far off are you?  How many more Acks to collect?

Not too much, it's some review comments from Ulf that need
addressing so some banging the set into shape in early -rc shape
and I expect we can merge the entire set for v7.5.

The endavour god a bit sidetracked because there was a pile
of technical debt to churn through to fix bugs in the different
drivers which were of course extensively refactoring the
same code lines...

Yours,
Linus Walleij
