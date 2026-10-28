Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793193043;
	b=p9dMm81/OUJOaFYXktXp0hEFz/XxTi4+P/YxG0dVr6ibAD+afTRKlTYvss8Ux8/Ey332
	 IlktBAG8TA9/05SM7sWcwHg7XXn9TLf61t9i/vrv9ez2Q8GayuP8NWN9As3GDmy0XoRID
	 RpEFooMzX5wj9fqz9P7WxZg/4c0xis3pYxJbkdyUYj3fk4PjDEtw+azsEY28RmkiwVyuM
	 WIIn2ckUKbT/5u01CmiyueoI7QsBjJeOBXbFzFFcmN5H/hfJdw0plqHLUNQr56nbHHNFF
	 UpEjNfMb5WWiFN1azH2+BUouWocNbXNA/TzaNtsJh0GJLqILxGpbaHWIAkyljRlgnUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193043;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=S+BwsDySfman4KlBED+rbWuh/PEeFG4gD/brcjcRbmA=;
	b=HRNah/ofr64Ah1hjXEx8L12v+ZYc2SfzkPU0oFXrzVurYJ4vCTJ+FR9bYJvty5Io4MXz
	 1RUyX7Lt1QCmu9eOJ2w0ZJnbO2tJnHPtyWKmV4gpBJa/DwUswNPMTPHj1wVHlQ1vptqKJ
	 93+KJXByNKxZDFcz9T801fupihejqvs91vjqKkXNrtDbzXRs5mE9SpoJYN/UvSly6ppkL
	 Vzl00BlvXQHn/3Ya0/s9d9KS+8xGyHn+Vx/bGiwvRYsG19D4u+3ZTPqhepOYy2J07Lv6a
	 kalaZB6gYfEBIGZ932DrbVeZ/pAoZiPjAbMmOJ9P1ucOQprwNL32C6dwUZBdp2wRowQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zp8PMlmm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19183606A31A;
	Wed, 28 Oct 2026 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zp8PMlmm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB6B1F01825;
	Wed, 28 Oct 2026 13:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793193042;
	bh=S+BwsDySfman4KlBED+rbWuh/PEeFG4gD/brcjcRbmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zp8PMlmmp+uq2NrV/CIJxtvqhDBj/gd4PK5onF/ExI55zN7hdbIuINn/Y/Bx0SQTG
	 Pz3zRx1vjsGKw+kCvbTFuB9hwLQJ9ea+J5fitXzF5CoTeKky5T/qCnyLx3ZBS0WYBT
	 rrelRx43Xnt15tHSb1x/LvW0ymiAvWdcZyZF4m6PaMwfkkqvcREXo7cvnKSmmzQXZG
	 MvSFAD9MtUrvKq13ppO+VsCPE3zxuIAcco87RmHiuLJZt1lEwAZ5zQeMtyk91bjRyp
	 MbLlVj1eC81yXn8LBED5fX5P5voF+Em9MWxTirvz1wKftBuV1ZUgogLao7zUw8Gcc9
	 oynvvkCNg0qdw==
Date: Wed, 28 Oct 2026 14:10:39 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Thomas Gleixner <tglx@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Peter Griffin <peter.griffin@linaro.org>, 
	devicetree@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Radu Rendec <radu@rendec.net>, 
	linux-arm-kernel@lists.infradead.org, Mariano Marciello <mmarciello@google.com>, 
	Douglas Anderson <dianders@chromium.org>, linux-clk@vger.kernel.org, 
	Jakub =?utf-8?B?R8WCb3dhY2tp?= <jglow@google.com>
Subject: Re: [PATCH 1/9] arm64: dts: google: Add Laguna CPM mailbox array
Message-ID: <20261028-handsome-beaver-of-gallantry-b1b3bf@quoll>
References: <20261026214359.3122870-1-briannorris@chromium.org>
 <20261026144346.1.Iaf8214205f496225013f482f6e0035e89ac624f2@changeid>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261026144346.1.Iaf8214205f496225013f482f6e0035e89ac624f2@changeid>

On Mon, Oct 26, 2026 at 02:43:39PM -0700, Brian Norris wrote:
> These are the request and response channels used for communicating with
> the Central Power Manager (CPM) found on the Google Tensor SoC known as
> Laguna.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> Based on WIP bindings from:
> 
>   https://lore.kernel.org/all/20261023165211.v2.3.Ia186a29119b4b5c409815b755e0c2c3965b0495f@changeid/
>   [PATCH v2 3/4] dt-bindings: mailbox: goog-mba: Add goog-mba mailbox bindings
> 
> which is part of this series:
> 
>   https://lore.kernel.org/all/20261023235408.3063350-1-dianders@chromium.org/
>   [PATCH v2 0/4] mailbox: Improve the mbox core then introduce the goog-mba driver
> 
> The binding is still under review, but I include this anyway to help
> prove out a working solution. This patch should not be accepted until
> the binding is settled.

Regardless, DTS goes to the end of patchset (see submitting patches in
DT bindings dir).

Best regards,
Krzysztof

