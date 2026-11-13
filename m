Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794569137;
	b=lLJknUJWygCoMj16N8bl7wWgN6keedYGHmJoU0VTus/+4V91tAEgcy3tl8mVARZc++/6
	 BLGIVjAjnrEP3Yvn3UFXRdMc9Rdb6EUmDm8ZXD0EhZrcgDp6I+zc05VrB78lOoa6ZHz2/
	 6OAo5OY2U7047mlQySMEotX99wevbTOAokHMI47d4iYrpKH+UiVfLUUSBC4zECfapt+Dg
	 eCoBTi93OUfllQGsTPKtvXlgJD1dLF1514EMlfD/KnsagfHd2sm+m2qtpG4x77OoNoNnC
	 YWOpB/Tp1xooEShduDBQ6thBwkxyxmslRqIxNshQfdfmh9CEFhkB4WXS1+ybe2Zcd5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794569137;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=j6N78RKpAXF+cz+vbvK8x2MeOj/i26p0QjCWKU872eM=;
	b=OS5NLuG1ST6N7u9siEQkkz2BJAShVV5XnZWZDiDXDgyKYgFzAtVUrHcln1YEbjyXe8wL
	 cAfLBfrAo4zT8L3qPvSBkf+Q74q2Wozky0pf+bUkG5SvfIuwd3ffvXuthMwqs3qSdWIJd
	 Wh6s1guizWKmfSqDlFKnwtGQDjlXCTI3YLWL0/BI7fOE7eNFUX2Ad2y3Rs8QfyfP6WwpA
	 kZPYUW6HuYazY7UZ1jNUWGGjIBAl5fbjmUBoOVjazWMf34Rb8F+yNXhjTytgJGemM07hU
	 5nsp8Xq6PsFwns2m3yyu813RorIsJKyV0GO51UHGP0t+qX5bQgpBdadrlGHeMmnx75w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lqyPAsUP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6FD606A321;
	Fri, 13 Nov 2026 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lqyPAsUP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358F21F000C8;
	Fri, 13 Nov 2026 11:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794569137;
	bh=j6N78RKpAXF+cz+vbvK8x2MeOj/i26p0QjCWKU872eM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lqyPAsUPWLJM9qQI9khXZpMOGAyQbf7KcXZFt/4kk0JF/F848/YU/iUoZO0Jo3my9
	 OGGwg/gMrSJr0zX7BMwznd6SY1+c2ZyPmBZUmgAP2WiTHnIE5fxwIMFsilB2H+nQh3
	 P0nSqj1Fn8aOG449SXeTtKCq/Ux6PME1Q85g4SeyU+LxtTmi6sHPwE/WzFRyf2GRxD
	 PuZV3VgvjZWdx1ac4LotFZSiG42jt63dYkEcO1lVGLYYDhS65F+uXwY0bfLNtaQkEa
	 FxW/jIWYLZZphtZK1+cMyrG/RFSPO4C85FjcORjnfhfMvzDILQB0LcQ1qVUk8arvtc
	 YAEAGaB83eVsQ==
Date: Fri, 13 Nov 2026 12:25:33 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Val Packett <val@packett.cool>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marc Lainez <marc.lainez@gmail.com>, Luca Weiss <luca.weiss@fairphone.com>, 
	=?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>, Danila Tikhonov <danila@jiaxyga.com>, 
	Sebastian Reichel <sre@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, phone-devel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: qcom: pmi632: Add battery fuel gauge node
Message-ID: <20261113-bright-funny-duck-c9b9fe@quoll>
References: <20261112170841.2189322-1-val@packett.cool>
 <20261112170841.2189322-6-val@packett.cool>
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
In-Reply-To: <20261112170841.2189322-6-val@packett.cool>

On Thu, Nov 12, 2026 at 02:07:31PM -0300, Val Packett wrote:
> Add a node for the "qgauge" battery fuel gauge at 0x4800, and for the
> SDAM region at 0xb100 which contains the full charge capacity.
> 
> Signed-off-by: Val Packett <val@packett.cool>
> ---
>  arch/arm64/boot/dts/qcom/pmi632.dtsi | 33 ++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>

It does not look like you tested the DTS against bindings. Please run
'make dtbs_check W=1' (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).
Maybe you need to update your dtschema and yamllint. Don't rely on
distro packages for dtschema and be sure you are using the latest
released dtschema.

Best regards,
Krzysztof

