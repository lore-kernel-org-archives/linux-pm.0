Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793459123;
	b=FLwk1WYCwWHjUU4XOyVc0xa2rMJ4Z5qUNj7+qhJcZnEqR0G6B+f6wVLA2AB7dnNZ2lXY
	 xzZ76Tm0PpguFYhPOP9NIF9ZfzTjPufjBspbjU1RhX4JTPcm2WSHP7O4YXiefVsNhbTBy
	 mf4aqlWjFJZmCBDXH1pdLkNaCclgPiFMzD27vJfXyKb6A/2F2SrFpVJnzg9xQeZRkEbNZ
	 m2VyK9nvUHYrg1BTnrkPTi4woLPxJ5jEQ4J2I/VIpNcmwmntpRi8nL+oVzX6Myd2VzuVc
	 4FrnpJaEpkfNdSIWi969MF2+xZv4yvA9gMiRF2nFLxAGY/Kj88Tz+/DU6SmbGeyadPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793459123;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XiBVYY9Pj1d3wCyHUQPb6/u7BjXKfayo72bDkp0mxRc=;
	b=MLtKuh4nrMUhCXcnoK+cgV2Xd/QXYhNYbCRcrTWIaDxATmmVzcRQ04CPxACocEqpvRXM
	 E3tr3WPS2TxjJMjtw0hSWfOqyO+gIBdoMX4QJrEnCFthbfiQoxhzde65b0LYrGzJSQkCh
	 LFRoQt81y1dq5BaKgnk9Jh/W3JDp/sQqBr+2J4XtQTkF9LSxTdzejwOLkTNrtqqqURmr+
	 2CYTA8zuS5pdXY34VAAp1b8jpSsGIHp3PQw2oKTciReRXJ4z5IDhw/CBed4arMBh+5Vwv
	 q1BnP0aTXeRoAv/P1XM6EwjK7IGYxX9DKZ7CLxD6ZKedA/uSkOyeGftTE4GJ+ESI8UQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vg8PaQQ6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E886606A324;
	Sat, 31 Oct 2026 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vg8PaQQ6
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793459123;
	b=NK9b7+a3GQe0wzAcRPPks/c/FRs1JYyceMsN503QwnEngTIJ1tDu/0X1fXPFhLozP90s
	 HEiRciMB5bAIfwHGRzDts41dYW4O0Lav6fe3mxUSWSrswRnE8T884MPKDHbpXDQo4rcBN
	 +nx9gIIMYiqc1Woyi4VYWCHvh4GGKXPdQ2x56jUGA8olCmHS8PdvF7oZpCp+5xroZKCkZ
	 BqAhJ4jhA7VYJ2moNGoxytAbRMs9E+cNSbQ9mGz8AzbwYTa4NC2epyjWWD6QxpAIykczc
	 AKzmYqsXZ4hs9/WWJTy+BppDMWP4iDxL6Z5ehHotza8FbIlT45iVognM+r7NG0ywk+w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793459123;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XiBVYY9Pj1d3wCyHUQPb6/u7BjXKfayo72bDkp0mxRc=;
	b=n1SWR0XEOCzlnJrzasFcarAP9jNCNgI8+cuT6T1/4OqSEAxPm70CYBsAzUVbJU8NnBw8
	 i8T9SsQIXWydNaZAaomavyKbr5FRVuXAUFF1+3/NoWDB5LAlML4QdFUh8fXynaSA/JnQJ
	 nqwLsAwpxrrfMdhoBA1ZreDa7XtRzCv4OJxyRbF71eOeiox52QAuMpYijfePP2uP2EAP3
	 pMzpSXAwrjsYGWMu44aN8Suzy+ukc9bX8MvvOihLoNtdwOW/M7maiqdV85o+4qyWlQvbK
	 /sfCGJKwucPyykGPunIHx8gpjuIFW0QFueA61WpmjMDQAYZ51mCSaMuSFtxLHxv/PDA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 036521F00A15;
	Sat, 31 Oct 2026 15:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793459123;
	bh=XiBVYY9Pj1d3wCyHUQPb6/u7BjXKfayo72bDkp0mxRc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Vg8PaQQ6KknMYMIX5rvEH5fHN5UVoSUGr/G6lNuXA8wLDbJM1r3qUtiKwL1bCXARy
	 m8ZC6ZfeMK+UNGHST486ZXDBUDo6DGeZoeBovh4VRZMciBIVwyguLSxQua9Bwk1faO
	 P5/Vj7S4lxqrESHpJWTocYOLS2hgyKnsomUhQsN3uzc/ayIE86c/Z/K/ZmydcGL0AL
	 KDDO9XsuI5YCzGhk/bnBAYHhXWUBttHtlPuDuvopIFp6wU1BVVDpJaNgeiukbY3HGF
	 MpS5Idf8QKV9w3Y7JrgKAUS4sNPBQ/3+UaxwSEdF1ciWo4tluA3e9PGGmXhNHp0Uzd
	 muSr5++17PHig==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 77EEF45F0F;
	Sat, 31 Oct 2026 15:05:21 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 31 Oct 2026 16:05:01 +0100
Subject: [PATCH 04/11] arm64: dts: qcom: pmi8998: Add node for PMIC VBUS
 booster
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
Message-Id: <20261031-pmi8998-vbus-v1-4-4d805e5a0f27@ixit.cz>
References: <20261031-pmi8998-vbus-v1-0-4d805e5a0f27@ixit.cz>
In-Reply-To: <20261031-pmi8998-vbus-v1-0-4d805e5a0f27@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1178; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=HpvL6iFTwrelyJpOxklGc3G9PcqLuzIuZ5tvJd9wb+c=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq5gOvX660ezv4WbP314Ec4yNJVhTKt2nRttV2f
 EGDQsFCJB6JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCauYDrwAKCRBgAj/E00kg
 cg6oEACYSSRn0je6bPBHxaafWX0LcMljCeYF+zilR36komre2XX4m703G6rYow8qbisD4kNZClU
 wFqQr/U016Dqx9FOELaxZ1G+GaXP9cb5XmpDThPdhM8xq6YvcXaJ8CKSbwfsnEPVYXBqF7dB6R3
 G45IjpCqlcXNmhv1ahvf3IpyGdX/3/3c2rZXU8aUMnir4jTeKhjVagnz4nxVcIJ5AyZR0l+awTM
 hqbe83sEsIvEQjJp8R5XZbImUxSTuSpKZMYpuWlxVeSoEBmyc0l1PtFUvNuAvPvqkXoByKCZ7nw
 4FEnJRlOfZs3kJqrgeSidJW0nvvsgMxH284Xmo87iSuhmX/cPEGg8xoH/RSbjCe0vAIxiLm4GJC
 iT1qBnSxKgEHlN3UxSHIN6aJ3sz706QuFALWMr4xhIwXgnXUSbqxAS9npHuNjcNDrXygEb7FsiE
 bzt7qejpw9kH2Dn2lU6II9n9+DkPELNHTfrzYGS/ewSCH51d1crDK4ayPLldXYlTzF2RCVomEtO
 ZQqdDwONac7UNxwxN0HlRJER5Mi2tPqbYRnBVYOzKNnTJPjhHSVRlpYZdKXdvCQ01WfxngGif5a
 xt85hRjiKyJg8oGrxGgwekTmrNyhzAiCnzjIdqgG8SSZen4cr9q/qVXI3seKFOfOnM/yCsxpRzk
 AINIqMmoKwyuPmA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz
Content-Transfer-Encoding: 7bit

From: David Heidelberg <david@ixit.cz>

Add the required DTS node for the USB VBUS output regulator, which is
available on PMI8998. This will provide the VBUS source to connected
peripherals.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/pmi8998.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
index cd3f0790fd420..86640ea6e592c 100644
--- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
@@ -24,16 +24,23 @@ pmi8998_charger: charger@1000 {
 
 			io-channels = <&pmi8998_rradc 3>,
 				      <&pmi8998_rradc 4>;
 			io-channel-names = "usbin_i", "usbin_v";
 
 			status = "disabled";
 		};
 
+		pmi8998_vbus: usb-vbus-regulator@1100 {
+			compatible = "qcom,pmi8998-vbus-reg", "qcom,pm8150b-vbus-reg";
+			reg = <0x1100>;
+
+			status = "disabled";
+		};
+
 		pmi8998_gpios: gpio@c000 {
 			compatible = "qcom,pmi8998-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
 			gpio-ranges = <&pmi8998_gpios 0 0 14>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;

-- 
2.55.0


