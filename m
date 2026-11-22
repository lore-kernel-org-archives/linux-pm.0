Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795339581;
	b=Smac72dwLZq2Vmm5Vtkyjtha6L92jowCeKORViBQv5tFDQTpSF5Y17Ue12hgPtXJDnC0
	 7WV0iY3pq/Z9fmOg+087ezqodKMpPj69Qd+dhhr1v+zu7f98V4xTxpxXhP9Sjo1KYyJqe
	 LETSUN2Trqs197BQpEpSkW6WzwfX7DzW7kkFC7TePkicd3ob5ZSzBC1Uq1+RMOu5ZbVeM
	 O4NZ9evrTT6X74QWMfRgq20XHpwQcTszSrZ2JGOJDyIMtWv2VSao5P5PUphM/eXjChIR8
	 3KSCFZW/DvChpm5DbmaX7KBT/k+UvuREanZuRr+HmhhdvcOCqfr2/cHCD8hJUdwaIuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795339581;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/wvawJ8wNc6NBpYFbJy9IZ7NlJE5h0W6cYFfyspH7rY=;
	b=WHDR1U0fAiXq5bB1s3b7vVvucyDb8Kb7niCTwo8R4LL/T+CsGmTBvV9lFXZzrZOZ6cmz
	 EVfxyyfj8r5RYceAuP1YyBs8D65cYiKmsrVsP6IXpcVx8pnFGN1D2hxuV42SsNfEbFxTI
	 3k/HqN6u1gAt8G/rPlCL/1pwzZOmTF/U+UcvQlZJG9VNLMR4O00XReJqcu+Bnz1ZAnKMI
	 0KIALisbMY1oOvD4XaNzIL3/AkSBim6e5ey/lodUbgFIoQpFJp2ZAek97UWcsMzPCk9ej
	 UGBW/S+Wy9bS6C6AasHmzv2bSFoZWn9u2hURC+2Ttjq2EZNCL4o02mm/Eqn3i0H3ocg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mD9w5WS1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49703606A331
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 09:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mD9w5WS1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA941F000C4
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 09:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795339581;
	bh=/wvawJ8wNc6NBpYFbJy9IZ7NlJE5h0W6cYFfyspH7rY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mD9w5WS1kcMPyBz6NUe+kvsnT25LLV6Yyadr3FGhEfOW5qtLYQkKuyeGK4Cab0YpM
	 Q51WtaVIa4gxT5Jq0zcfiXF+ZRHCT61WOjHiXnqjIHUhPdoPTaKJwGLaHFf5mykM6Q
	 j01jFjNrpmlAvSm2fyRkXz9MXngB8w2XqGX5XGJ565XKBccsSoW46TPODDbpgT5uAh
	 NkB/KL4aAJugat+kwsnFHxUWGp4NwsrlhA3rsIkmRSSJNtBhId8W+/tLqUDkz3Krj1
	 I4186LxxALG5hONKictziOJhnbvLnAFbTwPdTdVlc347+8gJodIQJ463kvI9nVnFB2
	 mWVVUaFlGT/5w==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5be3ed646a5so3182558e87.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 01:26:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHittDFeTNm7V6erUkMTnxzC9ox4jWINqCH04z2NxcoxvQ2sc20IPW6WzTZG1yOlsQp01q9D1ZzoQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z85dMtdQTauUHM28dk8aEzKCgaeDP9ZIsnLWgTffokNfjBZpHBo
	v5g+3iDPzDR1wo247H3rqmdBd4U/prD1xo2L/rjlB2LhpyIAAOUW4wM8AH2aNse7OHsejCw06Sx
	GjufkB+VA52L+Wdd8QfBs96QCmZdpg9Y=
X-Received: by 2002:a05:6512:3ca9:b0:5c1:4f88:9af6 with SMTP id
 2adb3069b0e04-5c1bc8198fcmr2613273e87.54.1795339579651; Sun, 22 Nov 2026
 01:26:19 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-ux500-timer-twd-binding-v1-1-58099a54a440@kernel.org>
In-Reply-To: <20261116-ux500-timer-twd-binding-v1-1-58099a54a440@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 22 Nov 2026 10:26:06 +0100
X-Gmail-Original-Message-ID: <CAD++jLma2AZstGAAmCHRFouwC7fNQB5d3=LTjx42fSQBKsHDOQ@mail.gmail.com>
X-Gm-Features: Aa3M54oH6pauVybRm7ssp9GjVhjox8gdVjmBgukmIsJeJcWrZK2JGKkIS_nXdRQ
Message-ID: <CAD++jLma2AZstGAAmCHRFouwC7fNQB5d3=LTjx42fSQBKsHDOQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: timer: arm,twd-timer: Allow power domains
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Mon, Nov 16, 2026 at 10:48=E2=80=AFAM Linus Walleij <linusw@kernel.org> =
wrote:

> Allow TWD timer nodes to reference their power domain.
>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
> Allow ARM TWD timer nodes to reference their power domain.

Is this something you could take through the bindings tree?

I don't think the timer people would mind. (Or else they can
say so...)

Yours,
Linus Walleij
