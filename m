Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110873;
	b=Y5tKVto6KJXuy25SAQkpkhDYW2Zkcw1XGrnzqmRQegNmTxOSL1k8P87vO6NvZeSA8+U0
	 5rEJam9Gmqg6/RsBjTzWRhvinB4H16vvkO1fUeOmgtljPkrQC3LCBYGPzzVSJSaPfLVFE
	 7me/8KwwX6B7VIxgmaHQHHhXYKqF3DkYZs4jMxYak/fMLrf3p4lra0PeXQ5n6QCyBtTUN
	 QQ8pqFhLCzsdoeJ+6+d5u0NFZr1qGCd4xqXvK1iVL1Qgkp2DV0O7d8Y55PKAl2RnB8mG1
	 CLMxMlrf9NjhIyUUz73Zsk+s9tFNx9P/z+PHoIeRUSAxOZHD1ljYLeqjEj17RTVimwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110873;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NbaKo2EojPBVQVK7LV8aGSsd5gN1hbSzP/sBhHan3BQ=;
	b=pTOe+OThkACJ/jQhpk5YtkgDsLEGw3PZUdAyFhllP7cnhj9cSzNa9Ak2ch4v5jfiWRYl
	 G/F/GMxT6NZRgO7nua0GMOXt5DqZQr4iIgJ+m4GikX2EhxIpqT+mpEYOXptGef4dSltq0
	 1P3M1u7+8DUrtHCM8ej9NDUzIbgu18c6HB0Wrl2Ee6hi6yk0tRFxlwfl2goVoy0YIeiU+
	 6dTgvcjfMWrVUyzKYChGtpSEu8WtzX7Pvxjfb4MxL2H8DHUoo3y2/15UeEnpwRz8qPzXW
	 xlOsz7PDExZQmqXs+npRo60QUzkXFML3Pj+5m+ua5RhmP0Heni6sQuCSwtoKNqScQ1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ofhIRjS8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1580606A31B
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ofhIRjS8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4251F01828
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 14:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793110872;
	bh=NbaKo2EojPBVQVK7LV8aGSsd5gN1hbSzP/sBhHan3BQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ofhIRjS8UEcNYvRQ7QGnfdQbpB4M4tcgf59FYC/8+tx0dVDsCcJERBhUt/ywGnGS7
	 Z7sw8QQSG7uwU6gjncZs+IwlfvhcrwE6aCGfPy4jNRVkGLuUnk63x7MGS/amO8dmHw
	 y4lQKO41tkZaNFLPiG2aan3Gg2+Zol2FedDrEmOyui0AkwlLkM7Ya49QyeaelD1Css
	 LDNOpLnYlgg2+jG0xMFwJrBzCcYuubAckbNCOAlJLP0KvnbI2YkPnBAT2eRDIRenUU
	 rxSu/IvzW4Ly/hucGVFn1y3e0XFgUnfZZ2rRXkQw+fT8W7KUEDOufo9jKr81kh6tzu
	 kTa8p1cfiEAbg==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4a89b4a59a1so792618fac.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 07:21:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwE8S6bP//S8h1qNS8MM7nb8bAj0lc3m0qSvzR3bQ7Nnc+B+P75t96Icwq6o0ROYRikcoHnaNEJVA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIda/FOtbfFLMXbRy12NVrk0xiC6ZmrdPninM2G48UP7KDL2NIR
	16ZEgJM+gMlxK1YkN3OguysnjpFHxwn4sPmP7Bup4yWAamv5LRViA6fn/cFJGMmvSCZarwZQ50s
	JoggXLs47UjO6lyqfb8iCB6rO2wbSCEk=
X-Received: by 2002:a05:6870:3047:b0:49e:50bc:79dc with SMTP id
 586e51a60fabf-4a89b6135d3mr1718291fac.22.1793110872016; Tue, 27 Oct 2026
 07:21:12 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792776697.git.geert+renesas@glider.be> <f9de8214043ad4c8748fadce7fd2cc2fa95b1291.1792776697.git.geert+renesas@glider.be>
In-Reply-To: <f9de8214043ad4c8748fadce7fd2cc2fa95b1291.1792776697.git.geert+renesas@glider.be>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 27 Oct 2026 15:20:57 +0100
X-Gmail-Original-Message-ID: <CAD++jLkrF-Fuqa_ojSyeO8ogDrY==nupNvZAUC+nPoK+PNJc4A@mail.gmail.com>
X-Gm-Features: AclHuK9wpK2sOZ4pxVax9gNRbt2j8VY4zFskPh_vnOw0mDesf_mVGe4CvELlVTU
Message-ID: <CAD++jLkrF-Fuqa_ojSyeO8ogDrY==nupNvZAUC+nPoK+PNJc4A@mail.gmail.com>
Subject: Re: [PATCH 3/7] arm64: dts: renesas: r8a78000: Add GPIO controller nodes
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Magnus Damm <magnus.damm@gmail.com>, 
	Ulf Hansson <ulfh@kernel.org>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 7:53=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> From: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> Add device nodes for the General-Purpose Input/Output Ports (GPIO) on
> the Renesas R-Car X5H (R8A78000) SoC.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Co-developed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

LGTM!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
