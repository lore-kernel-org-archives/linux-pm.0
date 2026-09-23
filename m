Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5353EC81B
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184085; cv=none; b=BWj+HTv2o02zvBsYerqU6yDa5WCHb3tU4syr/tqqNunbWm9wLTFgs+DumgSFA870SqyWVIeZZiIcxgSI0E0vm0X+7Geun7UqzdIy4ME8c9oL0J9/0YaBIwI1031C4bJbM4T6kNof1XMI+vxTxtyRJikzlaHxDJ000oS8HysnIYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184085; c=relaxed/simple;
	bh=LgsdIdG+zGM1ANt8ONaeUUV61KHbsRslUWzcjqgbfr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YiYC0yAEP2p0qa5KlCysP9YovDCfauDqSDTamnOOQIm9wtrLzRAb06b+dbyrDHXZw8BWDCe/yTFAZOMkGUZjXbXl+4oc7qa1E8TKlGa4u6HKTBTBE74JyHTQHsndl2ZinpB11Fb6VB39sahlStYTOPczAWUFzTh+Q5dBDKdIQ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooOIG0Zf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooOIG0Zf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F981F0089E
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 17:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790184079;
	bh=q85OFS0/wcmxsg3cy/PCsW6K+vmLUTrQvpSWJO/mpH4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ooOIG0ZfNOU4hcI/I0WM2jG6AjFEXMtGvioBZyC8o5eD+6I3jqkT1RdDYPu3dg45w
	 H4SlISHNfqnrbDsZ9yQuoBX1YuNztPBnKk8DhsypnRg19I1kBZie8uHr6arYAtVIav
	 getEYnTmH4y+kww2cHGGTHTq7aa/7m2obuZCKQzRIahoq4qJ7fe+5YFaKqvRfLPomw
	 VN1HsmBxZnOw6kUNpUSR8MlFQxrfRuq6DtiUlD/mk9vZYVpJcRxO6umE6IsC4N8/za
	 XgGzr+nVXoEw0lASaRqTcHbct9NzYzzBqsF0W2v9oEJP9TQuXDfwjIlA0DHOkGbq7q
	 ebiZ7rYVvDQ1Q==
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccbd478cso608547fac.0
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 10:21:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy+4urn8BwDtfSoiXwSRhjfKkUH4KnAoqiiDQEzFj+6+EqeI6+iP+SjE0ytpKGwCbBk1xvh/PjiIQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mtLj2BVqzDJBXzBc6K0pNJrRF6RkgctW4TgxOxXQrj1AacT8Ct
	BVYcOTviin4YurNcQNEAWqcguRXvrptv17VHNjSY96xYnIxrVdHvQKEqhD0vn25LUCdkOSstJim
	3z+H0NBFrC5ykeNgSTa+rzUef+bRj0pA=
X-Received: by 2002:a05:6870:d62c:b0:481:7027:16f3 with SMTP id
 586e51a60fabf-4908b1aa7f3mr3359673fac.30.1790184078838; Wed, 23 Sep 2026
 10:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
 <20260914-ux500-power-domains-v7-1-v2-18-9d0c17e1f816@kernel.org> <20260923152034.GI3864833@google.com>
In-Reply-To: <20260923152034.GI3864833@google.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 23 Sep 2026 19:21:03 +0200
X-Gmail-Original-Message-ID: <CAD++jLk+uqjOoJ8EgRYr2fyM1aXLjyJWMBS-d0TAOTFBQuNV+A@mail.gmail.com>
X-Gm-Features: AclHuK9itPFOvp6R2-cC4u0O4UlC0wT8IFEhaoWAUi8CY_OZQDIKlQwDDa6vJaE
Message-ID: <CAD++jLk+uqjOoJ8EgRYr2fyM1aXLjyJWMBS-d0TAOTFBQuNV+A@mail.gmail.com>
Subject: Re: [PATCH v2 18/20] mfd/regulator: db8500-prcmu: Remove EPOD regulators
To: Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 5:20=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:

> Looks good.  What's the plan?

I need to address some binding issues, then I'll send out a v3
which I think can be applied.

If you could just apply this one at that point I thin the rest will
trickle in nicely through the Power Domain and SoC trees.

I'll add a blurb to the patch to this effect in v3.

Yours,
Linus Walleij
