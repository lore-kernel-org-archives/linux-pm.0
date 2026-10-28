Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793193586;
	b=lylr8u0jvZ5kzcwGQxEO46tmvGkMmEdk4OaXCid2LMSHqnVf6b9ymh884ualLW5So1R9
	 dBoLycDCGAqQ9GfCVkp5MOv+aVItNqZrWcNYD9cRLbSPKQGg/vNca7Iuvu/9l6XhsddpY
	 WsQ/z3GTpOj+HCGYfh7MlIo/b158XRo6Z1CbDVK4SgHxh9TP3Y5XErQN1UX3qcy8tV8iW
	 mbJjwlfgBpKgAZx/oJ/S5r4VJrYLDmyQbZXg1OAwm+YZuJiLQIvYPsZe76tNZoue0UWAF
	 q7+IBiilkpvbsujvEFo0fMSdxXeeNk9IlcjNToCIw8K1W3q9vfgkF0V42MQHN/rs5+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193586;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rNrgsfhJ8iQuc0OgyRK6owJ7CKB0QPGDuirnZiNjO7I=;
	b=jtj8rpfuGHvZYrTDGdRgsq++8JwJsYoKfm0BsOQCVTddIQQWEoV8l3/E0o2dqSdCtB/4
	 6liJ3hNmSoOCnSund1H8t6aHprfusHsSRbBYFfwhatNK1mhmm5sE5+lk+BNvmQxzalqpK
	 zPTThWf3Xah0/zMDPj5iAv1oSMvdePhWizePKZutzCQg+5OfKxhroHg3n9QqQk2sVm4hj
	 Fpdp3P1UQOEl+cVZs3n9Ros8WCvjjyWQrw+xqV/QY3PQKnnhncRKNNBIijReaNHJy3TKO
	 Mf0X3ms164jresrSWhcieZPt6NEw4wBIR0AxCLB36hoWyq/Qfi7ILyT633OW3Lv7EFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C+6p5HmB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247B5606A31E;
	Wed, 28 Oct 2026 13:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C+6p5HmB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013911F01825;
	Wed, 28 Oct 2026 13:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793193585;
	bh=rNrgsfhJ8iQuc0OgyRK6owJ7CKB0QPGDuirnZiNjO7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C+6p5HmBaYr5tGiWDQW8DO9OXPVO5d0N/g5bNvmX4QN6kXYA+OyuJ333IWFjCQOxn
	 qsWoUsVixm22DCKopMLEA9H264qL1laJBucEBsgfAeFdeTirQMNVxjvCidjAlfxauV
	 iabQFLG6bem/w//Vd7veKWZa0E5FRIofuKwO90WQoaaGnPXTG3egrkiwxORRmbgSYx
	 PQTKRfUzs+xGyYX0bxZPyaAmYb8frm3RpNxikM8Q3JU66xkpBzG8AKrsqXmNz5z1KT
	 lEW6LuT5Yjsx5QZnDv8rehEivRPxGjsxWCb5OoOzXpauMWPVH88LIRP4e1OQHNiryB
	 h8iNrLjNZgnIg==
Date: Wed, 28 Oct 2026 14:19:42 +0100
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
Subject: Re: [PATCH 2/9] dt-bindings: soc: google: Add Google Tensor CPM
 binding
Message-ID: <20261028-nonchalant-griffin-of-triumph-ccc710@quoll>
References: <20261026214359.3122870-1-briannorris@chromium.org>
 <20261026144346.2.Ib692ddd35c1dbea1757d9b1db6c1c7e938fc4ea6@changeid>
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
In-Reply-To: <20261026144346.2.Ib692ddd35c1dbea1757d9b1db6c1c7e938fc4ea6@changeid>

On Mon, Oct 26, 2026 at 02:43:40PM -0700, Brian Norris wrote:
> The Central Power Manager (CPM) is a co-processor on the Google Tensor
> SoCs, as used on Pixel phones. CPM supports power-management and a
> number of other features.
> 

Ah, and one more:

A nit, subject: drop second/last, redundant "binding". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23


Best regards,
Krzysztof

