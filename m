Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795022746;
	b=E7ZiDDBXN8qzGzdE51x8ncBQaoh/8EVRQhz8WaQf/x5ESnRbT53TxbNC7XPcYhyiM3C2
	 IaLMBuxcaj9UBQ8Hy242X4REDmEoEjPUY0OTbj/olDxV+sZ2lvu0GXDlz5/todytq35vw
	 VtXzGliHFsatz5YGJrFMRrFxbofmccoySruNYQNYrRsKZvnjiSPbe9WZrrgB1vfxZE7Uq
	 S7aAjiC4ZU9wY4eeJvR6qAkyYcVWgV+GP1+LCHk9A6e4XyvrymTYJSeGmz2zs8PKbUOpr
	 iJpkXnRtPpcJCFAAC5yraF5fbtIz/D0dEJtAWInnzoOusTpB/KG4mGpvwKwHNbt9S5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022746;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rboQuHxOmmu88XioB4K1KS/EAzIsj/yoeukyg9V2m3Y=;
	b=aoF3HRbspQxVnShrFN1Zuzd3ONua2G07Yzq4AOES/o961pCvn4xGM16u3tlaqtZ1+RiP
	 azT+hfBDfiWQrKrJADjrXGzjNWBlYVxpyV8nPmBfb3UBbucx3j7Xo5QHjXX+s8PBy9ysx
	 QRGjCi5GE9mrfbeUqq4MUMnlD7sq0T1oma9y8g0LBhM4iDjCpF5iLF0iUJVw/Wr4FWrpo
	 Uyudh9LzxJs+PQoWliyN+fbu9KrpWIESKQIuZ0ImCOWVLQA8K+OKCBUCVwxl5c+n7lZlE
	 /8KTjuXLTkuOLyoUUYvoMs2aKe8uD70XMVtjBrzwcXT0U47BqW6jeOoyWU9Ym2d0QXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iO3RnXWu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAFE60A2602;
	Wed, 18 Nov 2026 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iO3RnXWu
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795022746;
	b=N+Km3deuiTmxD1yUfBFifXa3u3SUabpgu8fSpTeKI/LZyioF1Ah+3W3LoC3JpVy60op7
	 E08eYLJi9KnwEoduvF/Z3sst4oy9/6RQAl481IblRPuWYv+W25XUCShzpQM8t9AB1w/9B
	 7MNPXQbEH+SnZm5NT3P4FL+pohjI9LLUr+ZWXSxp5AAvriSA1NbgGXmO6/wyg5AuHawuS
	 5KFFESgNaFoqxW7lTP040JnMIik3IkLTSGng3eYsqsfRDU8tSrLr4v/Lwli/ZuSDnB7fL
	 W4VNk/8CeH3pxUFJxGo/wN5PsVAI4HwWFkuD721xCFJN6Pw2PvVVw0ndibkPhOvZG6Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795022746;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rboQuHxOmmu88XioB4K1KS/EAzIsj/yoeukyg9V2m3Y=;
	b=UvjlMeOV6/w8Ge+5E0WTPkojuFvYHVGODxshBfslYqW9Gk2zO24cXlxFLqKuLR4eGLsI
	 6gab45dJB5yTOg8qxC2ezD/jJhHUqYzXmA5/nSi1Dblc5iYA9AmWbJQvrhq5knA7lWeie
	 4fhYZBQp1XwOytwQz//5Qzf3YMxxqFUvOE223hYsQs1+JmMADRuiWLU+9uF8+fOOVy4t9
	 4UcvHn7QzsFESY7eucXVbQi3kpia2ODr9j5RVeSOTs5SEJVKA3HgFxS+pVCfa0A7DuD+8
	 tH6e/7PYi9tHB1bNQqOCJzSdAzLIHkKWOL31lQPaFgQ1ubwPiFW4blNydMCikYmwAhw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 64A601F000C4;
	Wed, 18 Nov 2026 17:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795022745;
	bh=rboQuHxOmmu88XioB4K1KS/EAzIsj/yoeukyg9V2m3Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=iO3RnXWuNwcRO0+YfaFjZiooCexjcZ6+UMHmwuLGe24LB56pW3Iztr6Hf/4Nssm/x
	 8vCmuPmim/X6SNXrMmS/LYnaxbtxlxorjwk46EFpeFxf8tif3cZASGWLOJhPH49AKe
	 4ex95uESkq3h1qQox8z2i2AGO06DB6vCepwtqilwo07/1UNcKAyKWIS0dV8iI31uOd
	 0bfoOumba7VZedCGgm9/PP357DNRgo8d83ro/Co4S9SgyLajYUi2SFP2IMMtrxsshW
	 lbWUryFHqqZtZ9mdRlqv1OTNnSmhGBwnqd8X+2HdP2cxkLYWx1jJfy8Z0CGm9U3t3N
	 oCH0bkg61eO6w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D38AD4AEC9;
	Wed, 18 Nov 2026 17:25:44 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 18 Nov 2026 18:25:34 +0100
Subject: [PATCH v2 01/12] regulator: qcom_usb_vbus: Fix the
 MODULE_LICENSE() string
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
Message-Id: <20261118-pmi8998-vbus-v2-1-3c77a72b280a@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1232; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=6MCm0tUZg6K77qclXj7MxDYC5mznSlasM+gfjuaMpWY=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq/d+WCvmEc49O+Y7h/zvw8H8UpZW+GqBBvKKzK
 lbCjsxOyYCJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCav3flgAKCRBgAj/E00kg
 crfpD/9hYzqBBAGwbfwHsX3WZ2LNhqt+/S6RTU/pqZmHLxXub/7XKXdB4B3BxavgdSqQchMplIc
 mIBZ9/pOGqb64x957Hb6uOAuiBNzNFg3Hs8wwS40ardiAsvSxXpDwOowr6wGylJv6S3sAcoDm5/
 WhZxhd8nqdnqwI3y6ZG0deEOnggo4JbjAbVv3bwCz/5OXzsCin8uuo+UFZb/M8hNWaBpBycBvaS
 2pcYwd5r8/ViKiEljpXP/12ARctl2prH2vs2kUfhjKwj+Y/2eFDaJctvl/CgzkwtAFatP/aW93g
 1UMYvd+2H7FzrQqLObHg0Mf2iT92h3ASePHjbg4bJyQ7PWvJWRm9wYk19xvvziFvOmVcPaDucym
 evyibJ9eDrHo3cdF0cdOoCYCkA5hEmgKfTH4rLZQZAqd/H2W5FqWEq7HV63bRG4IhYBev8VCDQ4
 xjXuZUDt7dqqESbofr6mySdSbJVD3cSPQVR1pjxLyyXvT12cpND3cjeK5G64HcsB058VMlAHotN
 cpmy55WLTC2uV7tqx+WJK0QHaQajM+1ZWB8FJeiQS2RV8VgOthvJdTjtERbXQwWFHxWwUZnoyZe
 f3sxcWPvFs1q2oGxeIKyIw9RA+7UI+Ip0xDQekP3Fmcc+QXk+CxvXkPH3bGW0gw7CnDdc6uG18W
 8OLxT6zqmi1x5AA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz
Content-Transfer-Encoding: 7bit

From: David Heidelberg <david@ixit.cz>

Replace the bogus "GPL v2" with "GPL" as MODULE_LICNSE() string. The
value does not declare the module's exact license, but only lets the
module loader test whether the module is Free Software or not.

See commit bf7fbeeae6db ("module: Cure the MODULE_LICENSE "GPL" vs.
"GPL v2" bogosity") in the details of the issue. The fix is to use
"GPL" for all modules under any variant of the GPL.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/regulator/qcom_usb_vbus-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom_usb_vbus-regulator.c b/drivers/regulator/qcom_usb_vbus-regulator.c
index d909a6f2b7f14..88f5a6ba79e6e 100644
--- a/drivers/regulator/qcom_usb_vbus-regulator.c
+++ b/drivers/regulator/qcom_usb_vbus-regulator.c
@@ -176,9 +176,9 @@ static struct platform_driver qcom_usb_vbus_regulator_driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = qcom_usb_vbus_regulator_match,
 	},
 	.probe		= qcom_usb_vbus_regulator_probe,
 };
 module_platform_driver(qcom_usb_vbus_regulator_driver);
 
 MODULE_DESCRIPTION("Qualcomm USB vbus regulator driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");

-- 
2.55.0


