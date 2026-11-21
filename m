Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795300705;
	b=N1GacoWlGs9kBVyKQewZKz2TGLT9h/bsybEMMn6c+X3Fm/cbBBENAr/qQ2OSQkDcrTNy
	 WSn6Y4zJeFAcIPqlqaoC6+xxQftS+kno7jMn7DUCsEKyxoinT9TUoMppny84+DPHpJb3v
	 vTGu1qenVcZ+FWgBwns0DKMudqXzUEzVrblFf2u+2iK1k6uUq65WNhYMed39s3CTGbiw6
	 AyX3yyTxE2KvKbPwTFucCGSMtqrFAb6+3wqRssNA7tdxwGoTccRNn2J2gVCl0+nrd8tLy
	 9FE6sCX51pmOMmUEYLDZ17ZrVKutFka1Q8sOzYcvwXXn2fKgccJcTUyiWuatQf1mEFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300705;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gxun9QDC8DJDeaUi0wrOgcELDuQJNUTtE/AzD7PlJ+A=;
	b=uTY7rZR+2gz2rP/mNFzmlOOb+3QXeRay+GicD9Klg4f9+Pa1eF4uQWW203wGeXZeaWK7
	 u6YnmPmI4sie1xGQ0CD4XHAQTVqwwvlRCGn/PbZd/AwtIhZJ4fH/sGlqvgtKJhe8vJjII
	 H9mEEvN7cRpRN4u9uV7NOcVrNO9s48tOWhm6SkRLF/bSe7soo4DHzaYrxYBZWu76O+AM6
	 2088HrG4kd4p0qpihFMwhfIL7K1T+rVccWMEY54CU7NmvPw92sZ0bmM8pSxDiTtlEBkon
	 q9RM3fjpcOTe+MRlexIfRPgTBYccBbyaVxZb0ZuWAxDAHO+7lmTLgZ7cqS0ibih1JFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iZx0t6/j";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01E1606A689;
	Sat, 21 Nov 2026 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iZx0t6/j
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795300705;
	b=t94+sJn18nVeQnMiNoiEIBMq9MbqlOOMGX0v5DG7QrHpQm0CSpMeyR1VWTdTnwVyHl8Y
	 /jKF5h773Z9ZReQTO1cdduUMjuqAYavc8IjraVxZgvR6OOFUTAdmIM3UNf29wLbHY+ujZ
	 CEuUYUfI6SzGZUcFhDV3jM3xN0nNFJTC0e4UAsdtyJ0pHb7A+/kOpT/z015HCrJV2iCPJ
	 TFI1JrwmF6FXjl1E6OUSUhJX0GOnqdBbI3kEsW7TbsIQBmr5bz+/5T4hVEqQfUkV+oJ5M
	 rarNLAi/yUwPKwTTuRgEXh9oGAIqyP0LSGUGL1blr1zCySmkJNO2ghDsMGjLCABtIwQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795300705;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gxun9QDC8DJDeaUi0wrOgcELDuQJNUTtE/AzD7PlJ+A=;
	b=DJGgPxuQ8CzmBJi+y5Ny0e2LG04VTi3knyU2VJqPf41WUXbigvg17/4H/vfSYgh1FdHM
	 xW6Ehyy10EHCAEPibAhwHyai+fw9pgqLj5Mv0aCDQXZD9YFydzg6HsLV2mUVs3LZVKfyl
	 s2pVykBR/G/sa0fRTZ6m9zExVGNqoELeuokNMYQD3q4fXouVaBKFG9kSqLma3ygl+W0ya
	 qo/yN3PuGVtoIE6JtoaH0UAXjcBVLgoJSxBi+67mYbOigG9gg8X4eVkT7jTjJrz0BlcU2
	 5fNQWPtpwg6mKzyKwLIKz8OUHlSWE6X5W12wn2vtmtIvYe/3/gv8YGoaGEPh4mVTm2Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D40771F000CA;
	Sat, 21 Nov 2026 22:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795300705;
	bh=gxun9QDC8DJDeaUi0wrOgcELDuQJNUTtE/AzD7PlJ+A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=iZx0t6/jxdwCrZQUMui4R2MiPpme2CMtqoQMrFNSv7PEzXYD4h8UVXDO3inBVzURE
	 Oq6A2xsLXqf3wutBtmS3xvkYJBIPHznG2B0Da2EQGcTzxUq0TuoeDxL4auoUMwCCaN
	 nMB79AWE91yLTRHhtYhZJfVIz0gvgejkn1EIdfgqC8IiJwJ/MUQT7iQ3jX21kBFwtl
	 m8hWux8INwXGCYVHi9+vP7fiCrdVA2pNRWRTYAMErLiex8ELLnpEA8qqoMVi557/4U
	 34DhmQ3PS+lxGWfwBxHJYrleJM3LJdYcUZocjDY7S3OIzFi+KRXtIi4BZA1NwK+0nX
	 hKVtmOnrsU2WQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B31084BE46;
	Sat, 21 Nov 2026 22:38:21 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 21 Nov 2026 23:38:03 +0100
Subject: [PATCH v3 09/12] arm64: dts: qcom: sdm845-shift-axolotl: Enable
 vbus support
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
Message-Id: <20261121-pmi8998-vbus-v3-9-91ba2e61a877@ixit.cz>
References: <20261121-pmi8998-vbus-v3-0-91ba2e61a877@ixit.cz>
In-Reply-To: <20261121-pmi8998-vbus-v3-0-91ba2e61a877@ixit.cz>
To: Abel Vesa <abelvesa@kernel.org>, 
 Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Markus Rathgeb <maggu2810@mailbox.org>, Rob Herring <robh@kernel.org>, 
 Robin Snyders <robin@snyders.xyz>, Sebastian Reichel <sre@kernel.org>, 
 Wesley Cheng <quic_wcheng@quicinc.com>
Cc: Richard Acayan <mailingradian@gmail.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=957; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=2lgBmUBK0MaeAv9Oy1xMjAHeZ/2PGxZmYEJJF355C18=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBrAh1b4BJsvRNFa2l8cfLZ4YY1SPxbJVnWYZzzH
 KQxHnJ/Ju+JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCawIdWwAKCRBgAj/E00kg
 cihpD/4vpQ/Ai/GFX6wI1ydBxLKNxq2GZDM14X30jXravqIIUy98BJWgXqgDjpevL58+1ZDPS/m
 qgwh71ivI4xlNmuTy7ajuK5Wnf6xXT3IT0uyfhoO2/+7aWal5goKbuxvOyms5/xP6TpgDNwDAwm
 6TmH/SJDpGksTNi1o8k3YY+PQPrHu26yR4YYtzYGCh/hJm19Re0vC6HPKKxdqaF1jwsPZ5RCvbv
 E4MN6eHnhAPpERMQz3pYk29PeeFTFJ+RABz7ATKl1RraI0RmeX06tj7mdYhuHSxgtTdTiJMgrFw
 rWZVTJPlKiBMX4Jz5lh21u4lTB/dAWv9VKGyCOBqGTiY/XQkgdqEfLV+nCbVxTgdbL2ucmj3WxZ
 fUDi/53lcCcRNxl/CGEwAultmZcbgHym+XpM5X/z3xVTLa22lPwj0pbPBfq26B495LKZ9VYW7fi
 OIVVgMGpQlP2amkMLGvhOsNLqTatTvyqOTwQjCfMLSaa6pOxids2xcSqE00GSheN717P/RIlj9A
 7FYRRjsPE+gVHzt6ag9KvmGId1HhltU7sIMoyMg8JSs7I6yncaQ+WJoiDRWk5uKB2/Feg0spHc9
 khoYYy/RDknoyqAMao2S2GPIdT3wghftMvIkiL6m5cDS0t1v8jbXwG2BymMPuyoL9DaMmhXnFJd
 gELXppbGgCiXiZg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz
Content-Transfer-Encoding: 7bit

From: David Heidelberg <david@ixit.cz>

Enable the PMI8998 VBUS regulator on SHIFT 6MQ.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index 1b0eaeafbd517..124717214edd6 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -654,16 +654,23 @@ led-1 {
 		color = <LED_COLOR_ID_YELLOW>;
 		led-sources = <2>;
 		led-max-microamp = <100000>;
 		flash-max-microamp = <1100000>;
 		flash-max-timeout-us = <1280000>;
 	};
 };
 
+&pmi8998_vbus {
+	regulator-min-microamp = <500000>;
+	regulator-max-microamp = <1500000>;
+
+	status = "okay";
+};
+
 &qup_uart9_rx {
 	drive-strength = <2>;
 	bias-pull-up;
 };
 
 &qup_uart9_tx {
 	drive-strength = <2>;
 	bias-disable;

-- 
2.55.0


