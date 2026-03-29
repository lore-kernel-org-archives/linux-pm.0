Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D04E158DCF
	for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 18:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774810683; cv=none; b=d6mjy8VWQb5kaQgwhIjWdI5leZGBw1DRryPnmLzOkq9ue8KZ8QFxuTAc8/SSOUftyi+DWJo5VHHMGmMYrH037lHL+Czk0luZrr89dSPXF3moTUgJrfQsupiX8f6Av8O3DYeIOQsVpqH7Uk481iRSjNzS0gcq1gIT5SOhzHxSWpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774810683; c=relaxed/simple;
	bh=Ghe/jUUjVDW2L4xnqDOkzXXcs8fY2TKEnFZTUKI/5JI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m33uQLWXQ9pQTXGWEifHTaP+WHgfejwA9hLhOU0WmnkD6K1QiYD+RNKzertmGCxNncD2DxV5LF6Dfqj4p8SCZp6DKbpCSOV2XOeXpT+uUtTKbtmXFG3eOZqMJuhCMHiWTwySzhnBcr+pearEQmbcOi9c9nEhTtangSD72hZPiFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDFLSuWk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDFLSuWk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A13C2BCB4
	for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 18:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774810682;
	bh=Ghe/jUUjVDW2L4xnqDOkzXXcs8fY2TKEnFZTUKI/5JI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BDFLSuWkJpfjn++ImUs539O9NjNKsEALgIoopk3NGDCleLws031FgcGlAnajunY23
	 2YSmXk+5xyyLe2AKhrSm50w5YuMkZuJugkFuSZngJwprMOTOGxZEs9d9D/kLOY04mA
	 BDfPcI8+bLc88/ua2PFrp0CR/ASbJ6LFD0toIkiVeYCZNO0RxrSFg9UpiQXAkT1TZz
	 +X/Aq1SxBeCVFBwT+Ehef39d9JY0FOreBPy8SeGpGDDmD9RKzDlmPfxaNwxQxPsa8P
	 JpJ2sHc0en3Dkl8DOse5j7llC4N4s1Ch+ZEGR7AM0UAwAtrgwzJ5Qbktq4fFbMdkD9
	 nR1lFOOt98rlA==
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6500040f172so3001645d50.1
        for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 11:58:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHBhQsTz1gv7BuTPDOOe12QVey2CODNPecaXV5iri6zpFxGCaC10JBuqhJe4pdNqeBW5BnBcXQ+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZPOMNo3ZjYaawpkMSsUwAGVGH7+ffqqUUz7dTgH0h9HZpWjqO
	+jPDwDDi8OwMtkgZTJjovUpXyEYpDPuyfxR+qoYGW6ihQFpCwNT0ZL/+baPKgSADtxgNnSUdClp
	q6Vgroabj9HEi/ELHJ7STnES2iixZTLg=
X-Received: by 2002:a05:690c:6e87:b0:79a:bf27:fe65 with SMTP id
 00721157ae682-79bde0a01f5mr98501667b3.35.1774810682145; Sun, 29 Mar 2026
 11:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328124707.141209-1-khushalchitturi@gmail.com>
 <177470797266.1536342.6967120656934552033.robh@kernel.org>
 <CAD++jL=_rCmW=eSV0kvck50sC2xaQnGQoEOy=DNcwkFvvWYUUw@mail.gmail.com>
 <3fa4fad0-d918-4de0-ad80-dad2141d2617@kernel.org> <CAD++jLnxoS-OGBSAXxgGPaME7eMTwCQ-C+uzub6m0o9ZgXL_aA@mail.gmail.com>
 <aciItMCdBbrVvMKB@venus>
In-Reply-To: <aciItMCdBbrVvMKB@venus>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 29 Mar 2026 20:57:51 +0200
X-Gmail-Original-Message-ID: <CAD++jLn5qQqx5nAOWNifJcNPb00B_CtM=xF16qjB4qXGENmL9Q@mail.gmail.com>
X-Gm-Features: AQROBzBuNEJozOlp-XpTGjISujTF0by1_WHh_XBOvopTnZtKwpdl_n91dqbbiDc
Message-ID: <CAD++jLn5qQqx5nAOWNifJcNPb00B_CtM=xF16qjB4qXGENmL9Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: power: reset: cortina,gemini-power-controller:
 convert to DT schema
To: Sebastian Reichel <sre@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>, 
	Khushal Chitturi <khushalchitturi@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 29, 2026 at 4:09=E2=80=AFAM Sebastian Reichel <sre@kernel.org> =
wrote:

> The problem is the node name (power-controller@4b000000), which is
> reserved for power domains. You can keep the compatible.

Ah, sweet, Khushal can you change this?

I think you can use gemini-poweroff@4b000000 because
this is pretty much a poweroff thingie.

Yours,
Linus Walleij
