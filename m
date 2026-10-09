Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3A43D9DD4
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 05:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522361; cv=none; b=C0JLlQmamV5xgcrbbqGmB4qZAu6Y1RjKWKj/zybiPDtnZx7wEYyGr1eK8bSD9AspEO3bHbFfqFSDYj4xNyEjQvCvbuhLDA3tSzux8MtNj0kxYZJF/Khc7d+gEz3kTfxMVgCT1kVz+O/q1uxBrEoi7jPJ2X4PzpUpTF7qa0034dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522361; c=relaxed/simple;
	bh=dNt7AVdX9HdpFjlTbBqrFzxS7d5/VDxYwM3HX1VcHCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GE9tlT3G5t+buW+FeTz2Mn5+XspahzOhnmUOnxQWPWo0Wpwvhr6zn/2sJz7G5Pgt4z1olamJuXanB7Pif6YgimpznXw51oDbsR5uvnjInZLYgUqgKCfiWm3mNjjriQBGKhav9NP3/+WjHBfsxaan0xF+Mjq4pKhckyLBBc2MQ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CChd7zzJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CChd7zzJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7561F008A0
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 05:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791522359;
	bh=I9YO0eJYB2iuGA2U/VJdUhkPCHtdLj+gjfpQldoRh8o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CChd7zzJcSynPfXkJUfzvxWOXcF/ySNL5XLqIhF7VLTfAK7P3aIpLnm+B46PQeoU8
	 OZjRgCzQ+tYcXIfYiAAgYjz19+3/yg15qtTHp5L3BaiXWrYb86nld+0jZodxPrY5NZ
	 7428JZRZUy6Wdp4CaOEkfcDqHUtvBSqewIqBF0hUISdx0Y3T7bPA7U/Qn7ovgrg4CH
	 nxIvUKtw/DWAXeK1pGG9NprsuRdn64u9pw19YsclC2bhoEcty/jxOe2Mtfe/CoS6Ul
	 LHKR/bAgAfWLLB+IZoPsSho4UyzRdVWIsrrL14Ld8SnH2Cp1G2FfkB9yz0yV73+QxG
	 PXJB1ozmuLebg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3a7858d3a20so51699731fa.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Oct 2026 22:05:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxLeoBMzaT3LUHjv4Nmri3Fp4bjNRdSdy9tIdmoLCvXy3N8eu0W8qknNUDjhk4B4+zKz86xKKrOeg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLyFLdZmGfHkcZ9/fq8HtuCSV7Tu8z7tQIdIQWpanqTQPFSQGUe
	TcYCSVxOMP8W7ZHzf8P9lhf44s//Vqh4jBcG4FwmV6BMcI866Nmt/8brLD3eInNsAk52+xkIeMk
	+cVxhuPWCwJ4xEDyrgWKdXNxBQ2wA+9s=
X-Received: by 2002:a05:651c:a204:20b0:3a7:812b:cfc with SMTP id
 38308e7fff4ca-3a9c5362e82mr1036541fa.14.1791522358331; Thu, 08 Oct 2026
 22:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
 <20260921-ux500-power-domains-v7-1-v3-5-9352be6b86b1@kernel.org> <CAL_Jsq+1O+os8=YGUoKg6zCm-r0gQ35baKX=z65uTQNB0i=RVQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+1O+os8=YGUoKg6zCm-r0gQ35baKX=z65uTQNB0i=RVQ@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 9 Oct 2026 07:05:46 +0200
X-Gmail-Original-Message-ID: <CAD++jLm+yRo9e1UDhnaYrdPq28mdyYKQZ6tdKuUa3UG85imkNA@mail.gmail.com>
X-Gm-Features: AclHuK-Ex5IjXhkbtgEhkucoevwygfmCnjR6ilMQmzKovj4MIFQJsLkwQxsWcf8
Message-ID: <CAD++jLm+yRo9e1UDhnaYrdPq28mdyYKQZ6tdKuUa3UG85imkNA@mail.gmail.com>
Subject: Re: [PATCH v3 05/18] dt-bindings: display: ste,mcde: Allow power domains
To: Rob Herring <robh@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
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

On Thu, Oct 8, 2026 at 7:41=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:

> > +      power-domains =3D <&pm_domains DOMAIN_B2R2_MCDE>;
>
> This patch is in next, but the define is not breaking dt_binding_check.

I screwed up, I forgot the dependency on the new define :(

I asked Ulf to merge the prerequisite which would resolve it:
https://lore.kernel.org/linux-pm/CAD++jL=3DgFt9kKZH9T-m8B_pbwRvzc35tTrMn5V2=
38d3528DpUg@mail.gmail.com/

Is it very urgent so I should just revert it? I could also just merge
the single patch adding the defines into the drm-misc tree if
Ulf is OK with that.

Yours,
Linus Walleij
