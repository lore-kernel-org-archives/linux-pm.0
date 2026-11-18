Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795022747;
	b=guznGorLqmNCqIbM3nOabk+xyK3Z8Fh0sUvZlMPiUQQco2MJW22bt757IdJgEjQyH9DT
	 GAGRDWrQayjNyyUS81ux8Yn7lu6tqa00njcCYOgO59XcTGBcAl9RONxkWdo2rYEvUPe44
	 EmYyExEk/7dxoYrKmTEnKlr6NfdW8i8Q10glb6DxOegEa4slBkCtEmPzp0dz7CNY2Xe4+
	 uZsD3WeHYXE8leVZLWZw6w0JjKqml+nOCSnIUTm/8N+cwBP8lsQqxX3JlEs2Z/A61F8Ft
	 8FOpYw5WoHEyMJtC010kiUcgoODK9Su6LQn1ZdyP0KQB7yuwtAlU7xhGLTNUy30mIkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022747;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4mkoX+OtXZlUYM2KdWyZuMLbP5nRS3AuI75xvEPjRPQ=;
	b=NM8IuhTquI7oB36+LsrtGbSEuYa2btfNf1l95dBAfrva8hhTukuHqZuwQYrUGj3IgxFh
	 2TF7gxi8Lp9q19/ndSEXezipTJFgjcED2/ljDD6YZ6Mj6yy0C7sJiy/u5aKVcOWlnnCoO
	 S5/3rNhGIichGjJJpFgoG2ORHqMHotTWpos8PFjF0+k0q1sQo34ZTPqa+JS4SbADHlEkR
	 dOpSUERxQgcle2F6zB5dNOK8HlXgmUv4iccMl0+T9qXltc5xLoO9TX+eEaQk2kpnskH2g
	 0ktO5er5vyhDZyB1TPbpoyZh8hGAKKdw8Qku9ShdJpLlBDclDPd5tzkBFuYq3yCr9Yg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4o0I1Pr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743FF60A380A;
	Wed, 18 Nov 2026 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4o0I1Pr
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795022747;
	b=ysWBS6kuW5Ejjt2m6q9cyHIXBtYh8ooBJi7xuOHW+K3N/3djL9BzGGKXS6tsUKDEzqiQ
	 HtKogbUm4MyS5nHC4+e+HW3xZrG4VTyvkL8WY0x+FruVNQ5YC1VZ2kCdpm5Fy/wemyFmo
	 3ZKYHrHsxjlRwd4HS13duOGiMmvMVabjRFME0xkQvo1qcbmtayKVNy0LLhhIPDex80ZBe
	 FGwsEAJuyicfT8P/ev5mFdByUFiPTUv+5A/BclqrctRDP/CYCkOdkUYEkHsebN99kObst
	 n+DdbXi0JEoevv93Wo3cqSR6dlQmI720r3BbDTxdHBsHgWh/Qc0Tb90AabSE8iI8CJw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795022747;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4mkoX+OtXZlUYM2KdWyZuMLbP5nRS3AuI75xvEPjRPQ=;
	b=YpYRvzr75uor5P15byolbTdnCx5tM+u3MNi2oBDOTiEjAbB7dB0gPGr1a6orocDHkDcG
	 ifUxQSVsWE+aEKuqeAut4Uxe5oqpP/PRDqxugU7twINXTqZovdPbYTiY7LiK3cZZ8h8RW
	 LnstybnC3wGGXn18CtxD4GYHb1Aety5To6lA262l7RS9gOlTJkMO3qEwi1OXzQ3ZNeCc0
	 uER5GWTC53yHRIr8YGCgn+JXqsp7O+iWYkuDxGtsmJar+xjyeTEgjx+fjm8lXdCv5knbS
	 Enj5bXQGocqRIt/gacP7QWpRHZ3DSeSU5YtUGjPkQuWkctcnGBffSeECJFO7Y2rhVIg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8CE4C1F000C5;
	Wed, 18 Nov 2026 17:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795022747;
	bh=4mkoX+OtXZlUYM2KdWyZuMLbP5nRS3AuI75xvEPjRPQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=L4o0I1PrXTadIg6fub9yq4AASiH/KLu1+8Vn+/m9WSS3JXD6AvhzeE8wT8B5FZo59
	 DU3l3A76P7EXdKZcsHUSIvLmpHiIHmJX90YTrMYhsyn9P3pvz8H6/10ocGIpQS96Iz
	 o+gA7WCuWXbzYbHmqK3jL9VvUFBgqV2JNHK4WYwaW0brfl21pmhNp4B3tU/oWSwmKW
	 z2nBoU+yorlXoQscy61lGjyHZcMFDkU+U32q3veFBFzQUNcXTOlWrQQbz9jg3OwHgS
	 7GevQ9xo8VMrntfaFhyMdxmvmayKrLZLiVxxegfsu2frmyxQPTUv9RcoDs0XM4Kfvo
	 vtqpoHzDrgWZg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 65EFC4AEEE;
	Wed, 18 Nov 2026 17:25:45 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 18 Nov 2026 18:25:39 +0100
Subject: [PATCH v2 06/12] arm64: dts: qcom: pm660: Add node for PMIC VBUS
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
Message-Id: <20261118-pmi8998-vbus-v2-6-3c77a72b280a@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1176; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=YJAh5JKxsMmwh1tjGfME9pip1rZ2KokfphW0+tMoGZ0=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq/d+X4XIJq3Uh7rLMwNZ4NJPm4II+Kh63DpMFb
 /ZVfEWzL/6JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCav3flwAKCRBgAj/E00kg
 cox3D/9cMH6PB7kzKPaSjXBTcH/sfzCqzCHlPHzc7cAPhaMZ7htgH5TjkkbaIcP6iaBd8MoTfgE
 lH6fEDloPOUvbyJQoPbskRvfoQaao3kWeJ8vH0XNnwanu5hykDUUaS3CSzwNZVm8122PqTXYnt8
 d+5FfCfM8qC+BUTLsiHov+92qkfbTFoYiG1hmFyFOy5+/62Q2OW8h1PXz+Q12O4UISLYcvI0tvW
 /TTASCkTiiXAYoXeolQ952X89N9OtE12Ap4BFcxlLQXwhd9PDH3oRKS37Ax6y8W8L6uyrBXNrSq
 Yf992tOOyESMgJGfNem/Wm1g5WdxKe39gQH0w0Gir6PHLyxI72PCKRB3a70fy9Kf6YZfcF9RbZ4
 x6nHFOsD0/G+zDtHCZQ9+l7qSfqXO+5wH2WlTFY+OMaalqcLNhGTYJaBxx3iNy/Ysv9moidC71c
 i4PkMlb9c1OIO17BWzYjDtCtsNesTeqnme2y3IiZC5uEtU8ISIj6WY63qEYQvTiCz5P4n/+Sftw
 5ctFCOw9yWHHSZcB7MN7vhm8FbxhZv1gBysxX/NNZYWjdTdL4KW4cjM8OBoh4DJD/1j8XZVNW4r
 2fXybMu0IlLWiQSZCpMauKy+4W08t7oIZKyGB1iHBJzn6vpN8dIGK3KICn8p+P3xX5WU7Q4atOS
 la1msPiFU5SdInQ==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz
Content-Transfer-Encoding: 7bit

From: David Heidelberg <david@ixit.cz>

Add the required DTS node for the USB VBUS output regulator, which is
available on PM660. This will provide the VBUS source to connected
peripherals.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/pm660.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm660.dtsi b/arch/arm64/boot/dts/qcom/pm660.dtsi
index 156b2ddff0dcb..fe9ef304d64e7 100644
--- a/arch/arm64/boot/dts/qcom/pm660.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660.dtsi
@@ -85,16 +85,23 @@ pm660_charger: charger@1000 {
 
 			io-channels = <&pm660_rradc 3>,
 				      <&pm660_rradc 4>;
 			io-channel-names = "usbin_i", "usbin_v";
 
 			status = "disabled";
 		};
 
+		pm660_vbus: usb-vbus-regulator@1100 {
+			compatible = "qcom,pm660-vbus-reg", "qcom,pmi8998-vbus-reg";
+			reg = <0x1100>;
+
+			status = "disabled";
+		};
+
 		pm660_temp: temp-alarm@2400 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0x2400>;
 			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;
 			io-channels = <&pm660_adc ADC5_DIE_TEMP>;
 			io-channel-names = "thermal";
 			#thermal-sensor-cells = <0>;
 		};

-- 
2.55.0


