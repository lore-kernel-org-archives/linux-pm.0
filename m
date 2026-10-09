Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAE53CF21A
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 21:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791580609; cv=none; b=rQV8txGCM1efgsrgx8KKYFrnSUlmCZM2zxpKy4b3C6+5VzknS1ms21Qk86gz+ocmb+Wy4u7hm7p4wnma797tJiOL+XsqTkhHanhaGxMVH7hkE6fkwysXcEmgaMEKjQpI2Dl7z/RVbmtp1eJW+wlZN1TGDIU2RmgcooB1PU5dlfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791580609; c=relaxed/simple;
	bh=pOjh8O8Oq6aRVh6JgsLLuSInkH3+kGN0eVIPZ+j+jmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRLBUpxnx+3z+z6Yo+sS6Tyy9WPqWlrBJa/QZPnMPdD1alnNnL+ebd2TmHGCNrQWnaq//yeUB4C2GoqP/wxYnyIVs/PxgUIl8Re22X8K2YK6p7EnrUd2wpytRVUx2lxXwC2QgOWwAsWuvVGWIxJhrIwP7BgfqW0a/s9DEqlr3/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cG+2CrOd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cG+2CrOd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8AE1F00899
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 21:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791580608;
	bh=pOjh8O8Oq6aRVh6JgsLLuSInkH3+kGN0eVIPZ+j+jmc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cG+2CrOd/QgTwToV1AwTrkzyFuPmqfc73GdFV7wNvYOFnXZWbZWW/rrgmv46M8QYd
	 /coo1iRKTKUtKMdYTOT9l2sZy7jyZF6JHKG42SK9Yvohzctg1HD/lqYGjIZ9leOfAE
	 tV94AUotzs5KkNtvmqM0jwdlURnWerRBOt1KAvdHH9uVLTv8lBAUYBGp+WV/73feVu
	 SP0MhUlNc6O/DtAyJEWAWEmsKbt5y5f2OTFgYewpx1UmHilkQ/atenLnBQ23ZWxisa
	 wVylB5egjye+9e7J6pojE2czF6KCRzjr2GjzIFc1QRrtLA3ggcgPhYLStpTLCEqGG6
	 z3/NcrfY8ydGg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3a9787a14ecso1882491fa.2
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 14:16:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzKVjauEgodiOvsSIn+IR+SovFA9/vyvzGDCalSr0Avmwv9ofcWeQd4uMJEMoBBwUDNYH5X4g6L8w==@vger.kernel.org
X-Gm-Message-State: AFq9FYI2OONB0kgjUxtwHm2xMTWiVpptZUFP1+fHSzA7rojhCSxX2i+j
	iLs1SUdSiQy9wKEA98ry96bHWCHmeiuQ7Xv6jI6J+yiRT0tqMzC23rWaVIKK5YY82TIvUwM0tND
	xAwO28i9ZylaiPs+OJu/ThnsVPa5oEa0=
X-Received: by 2002:a05:651c:198f:b0:3a7:69bd:80ad with SMTP id
 38308e7fff4ca-3a9c5253754mr7279251fa.6.1791580607219; Fri, 09 Oct 2026
 14:16:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
 <20260921-ux500-power-domains-v7-1-v3-5-9352be6b86b1@kernel.org>
 <CAL_Jsq+1O+os8=YGUoKg6zCm-r0gQ35baKX=z65uTQNB0i=RVQ@mail.gmail.com>
 <CAD++jLm+yRo9e1UDhnaYrdPq28mdyYKQZ6tdKuUa3UG85imkNA@mail.gmail.com>
 <20261009131902.GA1195061-robh@kernel.org> <CAPx+jO9F6wUG9M_cV-xiF-KAKD5kJ02n+yE6L9vocs=KWaKFTw@mail.gmail.com>
In-Reply-To: <CAPx+jO9F6wUG9M_cV-xiF-KAKD5kJ02n+yE6L9vocs=KWaKFTw@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 9 Oct 2026 23:16:34 +0200
X-Gmail-Original-Message-ID: <CAD++jLkkWUpkg6gwZuRzwwLU5E_9AsLiv8PSjT04dvNFj4DBBA@mail.gmail.com>
X-Gm-Features: AclHuK9p2mVaeX7VK8JUI4a76kwVWB2K8tlFEwycQPwaH1SFyM2rvP_ArIybIGc
Message-ID: <CAD++jLkkWUpkg6gwZuRzwwLU5E_9AsLiv8PSjT04dvNFj4DBBA@mail.gmail.com>
Subject: Re: [PATCH v3 05/18] dt-bindings: display: ste,mcde: Allow power domains
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Lee Jones <lee@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	dmaengine@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 4:38=E2=80=AFPM Ulf Hansson <ulf.hansson@oss.qualcom=
m.com> wrote:

> I have queued up three patches [1] for next from Linus via my pmdomain
> tree. The patches are also available for you to pull via my immutable
> dt branch. I assume that should resolve this problem?

Way quicker than sending and having a revert accepted, and
way way more productive :D

Thanks Ulf!

Yours,
 Linus Walleij
