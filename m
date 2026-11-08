Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169382;
	b=qesDKyTW8TJMbiVVu/nw3GVf+ykY0JAOXBhtz8YVmG8iz2DY2e2g3gm7KmJZ/6ByEldH
	 UJkt2HgZvaYQvgIlM/eggI0lUUwWgMS6FDo8HYwury5Xynq9EsZNoV6c+93kzF+hW5p3M
	 cwIMenV7WyzUlX8Q4S0jdoy0h/lD09GMmLlMIwmScdMtVNUDgH0++SdRbH7zoiLoJXYZb
	 WiOLJfPdHPFVPmUbLjhX0OxRD1qfNbJkFXbE3vPuvWdg5u8KwAbx0z4+nXMqBAcst6035
	 raz99H1crK3WqAf18EMCUU4x8XWm821TiDI6/tpH7181HQclXf0816vpkMNqWWrm6TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169382;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=un5KME5VaqGRyFymJ1U5KruFxksDbs/z7sIbDgLE1d4=;
	b=Sq/3Qz9EOzCob4gUcQGJ9MhWRLQICV4GJm7PHGQNDJ0AaOyKa5RrrSuR4EwlITThRLaB
	 5D3S4EA3ly9hSovq901Xr8yvRrHvEsG63mclSZYFCuIPslfcm5DbbphdSgRkkNTWDdvnj
	 WqKZE86/5au87vXCAk8r9TBRUVXCIjXJ8/lgWkra7t9KV2pvvcleEBxAPlSVL9CWWREZy
	 aFMoOi5DrLXf3koS5nzdG753Ll0dSyCdnPhEQ55/uUhsWDZCfzmGgBZlisNbz2+D859fq
	 wj3Bx/j1V7QnW4i6LJ8ibPPWGYnM9w3pgpnm9HQ9vCMxSz7D3it2TswBmuWzRLROung==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="L/ec+uta";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1454606C772;
	Sun,  8 Nov 2026 20:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L/ec+uta
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F111F008A2;
	Sun,  8 Nov 2026 20:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169382;
	bh=un5KME5VaqGRyFymJ1U5KruFxksDbs/z7sIbDgLE1d4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L/ec+utavsY8iBqw++e/nOeROwDx9p1l+BGDvUSPB/x6PGhhnQLadBDy8q8MgJBoX
	 J+BvFryg3jLMl1cVgQANHzzhrvBTt4vaQpoLKk2wai03wWxo1JPpELRN1YQyBThx6v
	 fZXdsp8MKvMI4w/np7N9/bXMVhkOAvE+rz33SfvcvjdBMlklEOGf/qAjZ+jeTEuKkP
	 i5oPh7feOb/HuAuPoOd4igUcxIBkJGeudxBA+TuJmWhEGxv0LSjH4JRk3v05vDoiXL
	 lr/cgQ5fLNot9LKb0H9IwSg4UtsPns7dQWz2Bnz/t555mHjEsU1oSg3sp7SX9QNjyo
	 zcRHX4xxBhkkg==
From: Bjorn Andersson <andersson@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Reza Kurniawan <imkyufie@gmail.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/2] Enable USB support (peripheral mode) for Xiaomi Redmi 5A (riva)
Date: Sun,  8 Nov 2026 14:19:54 -0600
Message-ID: <179416929246.628393.13881108135908117642.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912-riva-usb-v2-0-997fe0171ee5@gmail.com>
References: <20260912-riva-usb-v2-0-997fe0171ee5@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 12 Sep 2026 22:18:10 +0700, Reza Kurniawan wrote:
> The purpose of this series is to enable the device to act as a USB peripheral.
> It enables USB-related DT nodes (controller and PHY) and modifies the
> charger driver (BQ256XX) to expose its VBUS state through extcon.
> 
> Driver change is required since the device has its VBUS connected to the
> charger IC, which means cable connection/disconnection events must be fed
> from the charger IC, to the controller driver to dynamically enable/disable
> the USB gadget functionality.
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: msm8917-xiaomi-riva: Enable USB support (peripheral mode)
      commit: f6a4df4921fb88f1e729a19a48e7aede852ed6a6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
