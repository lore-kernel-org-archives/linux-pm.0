Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795022750;
	b=MNOkLvSr3rTjEnB7EZzfOZJOf6C2LFGgtGEN/SQd39ulJ36E5l9kkIhTE7SNPRYdydmr
	 0h8bbbF4HTf9b1kjqMvs/YcSVG1IFMh9yi/NEP5LwAM1fy0GGCYJGvotxgaD8DdjePD9w
	 oqhMqrsx/q7Nf2I/TgkfgV2KcntQWJJuY59eMm0hhly8+phdQm6IMlVuR3R78YLNP3ePZ
	 MfOdi9cN7aakbrlrbxcimkA1GRmQM6zv3sN1NKWl9DK9UPNYO88hrd7GHAPRlxC9OS5ki
	 V/aGOmrXDSEBVTKUG0QlIamZBCsGyyAkymxs5iDPRmgKAYCZ9x2HgaCMmoj3uHhWncQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022750;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=cFcuKyUMC82WAVuix9I1qT0/usvQApJ90CHf2UPtVfw=;
	b=nKnEx51TrWZ/rKD11VowmL4gsU8SMHhAMm5gaNnQYvghh8vG7ODG4NKS6eBf179tZBHQ
	 lYo4cRs0hX4I5egMYk6oNlWR5mlkL+QpJOzUhBS1Lm1fNKBHLCOusuwHWAUMVYYYpsUxZ
	 7YyMUpZBV77DQpfVKOh+tntmaqTcEV/M6ut+W/FdLY6FKf3jeXRAFvWttYlmRcfEVTLLt
	 DTl9jW7EqM7dxC/aj4r30e3BxgEYucEqxK6rd/XlGQml9tgbYKHbZ3xkgxbIxMz1da/n4
	 OjMudYCye5q6hA4P0BhrCJBcTNwkSlS+7ojlEW+d4Yyo2DMxMt6weOjGKt0aj6kOicA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Td3U0K//";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261D1606B5E0;
	Wed, 18 Nov 2026 17:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Td3U0K//
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795022749;
	b=qXL1/oD5ArdokEBq8Vx3ampH6h1IWaVu+dZClJ/cDaOBv4nKPQVJCMesfBEhCUuE7zrz
	 Rj+B/+dZLxhmy1EJLmYBp8KJdpuaKzsx9VR4QJu26s7BWE4kd6mxW+HU6EHFbVRCzO7sm
	 2YFBeosII/Vz8TOn31O6erK6r4eLuPyFpBIdvOKmZtw3xAr+X0v5RHiVxh/7sUU9Z+5Zm
	 k01B2vKA9c0+OF00XZeeDpKcJvjiLlyjqv/yEHehtnyB/7oHmFF6a8NYW/z5jt1Fo1gjg
	 Xav7/9jQzz/LPV4ruH0e3OHilFSxrJr52OH9GEMz6wGqi9fOWU1URx9gq8muoUOWuMw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795022749;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=cFcuKyUMC82WAVuix9I1qT0/usvQApJ90CHf2UPtVfw=;
	b=mlGsc3mKlqVUB4/548LdCpF6c51r3CQbRWkrpte3BGYmIP66DHkaOatKP35q0YDaC/DC
	 D1qs71GK9W7eOxXbXHqBYCH0m+59gV640f/5MceGobWvQo2dY2L2s6W7azvcOZOoNaR3g
	 7k7Ut547BWfFKpjMPsPcZSDXxopbp5HaOdTxwn26d1vnA4hvu6QXFuQpGa+rNBeXQ5Wcw
	 d4+dU52yyFoW4kU9RBQHVD4wqf+zflbdD9UvDNvEbjg5/lQg2jR0reL6/+nIl3EF85MaX
	 uFZP0MMbs4ev9j0WJYU1+bJGxj68mNGu8l0FjxnxEZ+5ho3gRK3956+EXgjWlD9Gy9w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 38BAC1F000CE;
	Wed, 18 Nov 2026 17:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795022749;
	bh=cFcuKyUMC82WAVuix9I1qT0/usvQApJ90CHf2UPtVfw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Td3U0K//BeRRMtjDsatJRhWXGXXptyOvoN2N+QiqpQah9FGB54bB2sP3dqRC5OGQm
	 MbdJV0iMvwIdiTYyNe6D0Afn2z5G6rxLm1/SNV1TuGUwYTpsCwOv7Je+MAOP9eT3fH
	 xzwfwJik8fh7cVwdCq6lUPoDS1oU70SeFnXOEfEjseiREgkRIE7P0U9ZYkIwLYZafm
	 uoBSGV8juIS1ko94P8Z4zziBp6cEG4enUmvTfOPTt+Z+HkUR7dskiL8mW5g4vh8rG6
	 hZxv9ytY67o15s0h8GHqVRkPx2K+DUXJFB5Mr/jCeSb8iCHyt+ShcLjdiXbDepSpGi
	 21i6iRz/K+5GA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C54834AEFD;
	Wed, 18 Nov 2026 17:25:45 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 18 Nov 2026 18:25:43 +0100
Subject: [PATCH v2 10/12] arm64: dts: qcom: sdm845-lg: Enable vbus support
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
Message-Id: <20261118-pmi8998-vbus-v2-10-3c77a72b280a@ixit.cz>
References: <20261118-pmi8998-vbus-v2-0-3c77a72b280a@ixit.cz>
In-Reply-To: <20261118-pmi8998-vbus-v2-0-3c77a72b280a@ixit.cz>
To: Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Robin Snyders <robin@snyders.xyz>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: Richard Acayan <mailingradian@gmail.com>, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=933; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=zzz1wDCTzc1/fIjXGnK2jf9q0XuYTFpC4inv6HpNgto=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq/d+XjjM2rY8s2yzYBWJxS4HXESt1659FNQHKM
 trBglWfKK2JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCav3flwAKCRBgAj/E00kg
 ckU/D/9X9hSuPKpnrY3w9JVtGO+oAT0DR9sSfV5c4waWBsyepm6QCrimBCLO2hcHv+KIyhgydb7
 4cjlF3RmDu12/YYWKOb4cmAIj/17vwUSHMiuJFehk2Evo8E6qh0+vuDwd26PNPuloM2gXjERNUJ
 rUyVZ/exJlWlikakdwgadlBbWrM6oYTeSTKrAdjrAjbOfrvrsJNdmfJFTivn6VCPOO6D0Nf2yth
 N6WETfrp21jTbQOdcnp5IrT4cAg8T/SHrjkjXIARf+MoOV4Ole7jEOoKo8ALrdnUoBUWZVkYcLe
 y2DIjdQrj78lvKXZ8jPvnGjg2ktgV1OeUbYPtUxRJWh8O3VGrJkSgyuo41RsbLZshxLRa5NXTHZ
 onVnXIOHkiv2pYqkUWNz06m/pJBBiCs+/CtpMT6YCURjk551uG30sluIyGg/v6AfL3D58J4krfH
 cIOucEyflVVi57V1hUVco5+bIPmwFt38Ntq+8VfJdW53oGgi7gH9UZaDNocFc81mAZpQRybx1qd
 Q5YLYO61JsQmPJrDQwcjnlfLR72J7yX7W4LUgljWzB3ahkUw5zfpMhb4ozsuyGp3YgMqG9mdRT/
 gY/4glDShY/+vGnrlAedHZ6lUIKiFE9sgkshzMh7MwEeh8fIZgTUovVViQyx18Xk/znY1qhaEwf
 6OFt3WqH0VKkN+w==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz
Content-Transfer-Encoding: 7bit

From: David Heidelberg <david@ixit.cz>

On this device, vbus was setup and switched off by the charger driver.
Enable proper driver.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
index 6989532584251..e868cf44956b5 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
@@ -548,16 +548,23 @@ led@4 {
 
 		led@5 {
 			reg = <5>;
 			color = <LED_COLOR_ID_RED>;
 		};
 	};
 };
 
+&pmi8998_vbus {
+	regulator-min-microamp = <500000>;
+	regulator-max-microamp = <1500000>;
+
+	status = "okay";
+};
+
 &pmi8998_wled {
 	qcom,current-limit-microamp = <20000>;
 	qcom,ovp-millivolt = <29600>;
 	qcom,switching-freq = <800>;
 	qcom,cabc;
 	status = "okay";
 };
 

-- 
2.55.0


