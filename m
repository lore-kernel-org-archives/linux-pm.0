Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794817353;
	b=IWnTWYUlU0wiVWPMz+SSc3wPGZb8zbOgMjUw39SmtcTtnXWgnkyHVsuLnhY22SRiubkA
	 hFty94qJGFYyXkOWoqImSOw4tsLHxgn6WXDrgZmrCHUanOpvjni3dG5QP0qcTSYhuVA3p
	 P2qIg+fn2sIE7ygI8FqPufDjgqDWAnrDkwNNiBC0ughjYZkdJW/h4fVLsi9AeO3jAKQML
	 KnLimhsZvO9HTpHcRnJZAkyhd3p9TTOEg2xQafUmYmt19SdptS0MDit9YDuLG7MHrijOz
	 2ygYjoeF1z/+OuEkWngS1J+elfww8aYd1nFzrABZY5qetwSLFQTVk8c2v9i2Dad2nVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817353;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=dKvcVIFhr+1EjKzd87mrkJtUpo8rJyi2I3oWszDEnAY=;
	b=CS6BnxHHFS7GgTzT96S3wPKMyPZhMMwtMwAVs51u7F8OCQA7GJZ7P7yJdPVVH5P+CnL9
	 1McSEvgxijIS7KAN+YEEGgbqdLZmsqAfN+GfOBfTA/69sQh5apDsxZIbOo42bVXsA0yph
	 b8+mQwWZ7xjNjHWPp4qbSjfgTZ8YA12JtTErS9rPmwnc3nX4rlcqpJkEY5VQZ6O7KS+xy
	 srLdlMHztJuRjlN81W26tlEgXAH1Sjs1mY8tDS8EarI1xAkAh8gCVJXV2xoPKxrh5HEUf
	 1V4AwNWBMULLPfFXqw552UYbU+KqdYYRdXZbQUexNmOSOJwwvCzTJADTSSp1Wx9G+Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=VuhyJApc;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A851A606A323
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 08:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A851A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=VuhyJApc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=dKvc
	VIFhr+1EjKzd87mrkJtUpo8rJyi2I3oWszDEnAY=; b=VuhyJApcECKBIkDK7t3v
	ZJ0qCN5fco1JwcdA9llunh3yL4dCYZXDPsS7oi8xxB0fBUxJRX9Io3M7skT519SC
	a3P+0Ibj3oJr4T4xlE9I7+sgxJK4HGfalxqtZErBJFUpZtRqR/e+cbT98XDsgS1n
	K/vmBaM54Dv3yaqJy3yaRFcmiDyJZStrPr8gDd7xwR0X+BiFBkYPlItxy+XcnUk2
	akcZ/TZOYyUfpH561NeKFkbE7b6wWvMCQYzau3OexUi/E1DZTmlP/hIAwnLiZS9t
	/kHia6WmBXgKFOAoFL2tfPuZ+hvyRTMF86kf8v7i2c8YQyw/Y0upa1HtgTsCU6NS
	9Q==
Received: (qmail 1194830 invoked from network); 16 Nov 2026 09:22:29 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Nov 2026 09:22:29 +0100
X-UD-Smtp-Session: l3s3148p1@06iIemBg7qoujnv5
Date: Mon, 16 Nov 2026 09:22:29 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Kevin Hilman <khilman@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	=?utf-8?Q?Cl=C3=A9ment?= Le Goffic <clegoffic@baylibre.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 4/8] reset: Add
 reset_control_get_from_provider_exclusive()
Message-ID: <avq9RULt4TRM7g0j@shikoro>
References: <cover.1792163045.git.geert+renesas@glider.be>
 <b9e68c8df1e545191e0359dba23fe53de31a4ce5.1792163045.git.geert+renesas@glider.be>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9e68c8df1e545191e0359dba23fe53de31a4ce5.1792163045.git.geert+renesas@glider.be>

On Fri, Oct 16, 2026 at 05:55:43PM +0200, Geert Uytterhoeven wrote:
> When stacking two reset controllers, the upper one should go through the
> proper channels: request exclusive reset controls and use them via the
> reset_control_*() APIs.  However, unlike the clock subsystem, which has
> of_clk_get_from_provider(), the reset subsystem does not offer a way to
> lookup and obtain a reset from a reset provider.
> 
> Hence add a public helper reset_control_get_from_provider_exclusive()
> to lookup and obtain an exclusive reference to a reset controller, based
> on the recently introduced __reset_control_get_from_provider() helper.
> This will be used by the R-Car X5H Module Controller driver.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

