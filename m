Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793459125;
	b=hr3VCIxGQc4c0g9fB0EaJwO4rHZltD/8VSvu/i1OUvbFQ7US8s2qI3FMT2ahFUsBjBXa
	 OMZlLaPoIj9NCCs06YV6RwKOCCYiWxkvZEOgdU+6vP+C0KKMd2paKWL4LDi1BBN0FI6mX
	 7rVferwvxs3n6Xz3lcFrRLZQA7xgeqk0j7hU4/JbkMnXCpPnMJJrFRnQo+yYQADLkIhxD
	 T06YCVT6uclox600OvR75hc3swM56wUTh91JZIp47OrKpfkKLNjiRMMUlxFA/lUqJxVei
	 Mc6SUXY1YUA71jRVf4aVd5ntPtcgbvwocz3ca9jr/UoQ0vErA544augwh+eVyhiR7pg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793459125;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kQFjPtDhKiECvlNFy24aWTOiOsluNBmbWJZdl5md1UA=;
	b=SEyEdipDJRqWC1lE9N4Wp8T7R3aKdN3KZ/BSdI/aBDic3pOT0Js1my+hMj0EQ8POs/KI
	 vB2KwhrH6pRii1KuBN2zyJPg3te7uVfVPDGsM4erhNCV41W+0SVUhmJhA325Jt6iDiE4c
	 m/mYtzAHODKMsRzT16ogO372u92fXrxgL5EjXntRPW9M0zirhMyiSAlNifGKypdta4Zr/
	 iL7cMOegP2TSAjdViX8QjckBcUdQk7yCIv19Ikf9VLZzSSOqHY4HbAuSiYAPeQFszbIza
	 qStZXdkei9+u8efJ8eQAvH3xkFYnUIuUfqo9D0FuNMpCLf0cWuyRpJbe4WE4jlVLSBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OET2pBRb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEF360A2608;
	Sat, 31 Oct 2026 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OET2pBRb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793459124;
	b=YxJTHrPGYuBVZBpaNiboWkE/zGwUvD2bTZtz3e+c/eiPJbdSVakhf4yA0KgsphyfpKkX
	 U9YOMpUxePYAEusLz5ktdUXmotLUuF+dF37admQWgxz+N1Zyx2oojbaA/2f8A5A2bdZVo
	 a52sX3h3nVc7JmehHaa4ezz2LJWshV642Bzb3M2JW0x1wKu3yG+ZTKcjj0ImRoopeD3MQ
	 ggmJbyVfdcH8BhVePEVAQdb/V4H61bdlzhW/yDHkDK5sQZ5JhJseSj46JMjfrdtWaoE2z
	 e6GsBU33qAhTf3eObekCR9gnBcr2Qnima9qZk259UfrCVJN1A2wMZjH+ByJmd8/pN+A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793459124;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kQFjPtDhKiECvlNFy24aWTOiOsluNBmbWJZdl5md1UA=;
	b=udjeJuI9lpI9sgqYhSM2/SdwOjw9nUKdDGwm1rRzGzAcSL4vrbCg/waqKkowvBUr66ji
	 DQmAX0KY3bYr1dCukZI2sinYEh4nMdkKcdWoZw8VOUVbYa8yMuRCAME8ooBGpK5Dgfh4d
	 /o4TnbSRaYnKLh8FfDUHn1v7EpL5whl+4YrA54i91wxQhcnF3Z1v2RvnNKodVFzkM5VX8
	 dWcj7rwqF4n/gQJh7do00I6jgBNg0ronfLQBgg8dX2qITerIZNPEO9bIVrvLomj593F8x
	 bJJn9732wC3GYjfhhpwshyPKyBsZzWNOg+oQ4T42D0G721mNSFsOnmJVGvTTfFILSKA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E84D31F000C1;
	Sat, 31 Oct 2026 15:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793459124;
	bh=kQFjPtDhKiECvlNFy24aWTOiOsluNBmbWJZdl5md1UA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=OET2pBRbXkvYId1HhWig1yzjNmDgmWzBWlzOJkEUJOsi6OoVCQgMPfjvdLcPFZ9dX
	 m9a8W/nZUq6Tt100KDkHyca1VWr06YRnp/FKf+VRFVgxtWrRcEOIywYxBa7ssFYI2B
	 0Joko6tYeLTNU49VFLdQ0mtJVZjYnvFT6I4sgIhFAMVLvBqNMjoxxGW+1qe2+7SQ7X
	 8C2JuKQM2eQ8LuTceuQvGc9sXaQle1C0sKGsdY72RyW+uQ9UHVCgoLmVAGPM8rLZay
	 GWRcaq0cvQ6IcaEnvDgVxj8p/kVPnSdw9S91ugxaYw78Z0arecHtA5qgiE6TB3Foab
	 9rN7/YZfbWvyw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5362345EFE;
	Sat, 31 Oct 2026 15:05:21 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 31 Oct 2026 16:04:58 +0100
Subject: [PATCH 01/11] regulator: qcom_usb_vbus: Fix the MODULE_LICENSE()
 string
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
Message-Id: <20261031-pmi8998-vbus-v1-1-4d805e5a0f27@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1232; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=0vIIV4exeWwbtrGHfz1u0SZa5CA6vOAyO+STZ9EWoY0=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq5gOvB4xWLh9WrazYpdCCBZa+F16420W1sGD8c
 8qX8EaxbdmJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCauYDrwAKCRBgAj/E00kg
 cno8D/93p3H8YLRZBhTAzf01g1NXN2ySjYQNUKD+tKCdydBNSPaJqG05KoIoPU8UkBEKFgc1r1N
 +AA/ePDT+TLBrbfpAxnSn/WV16q/jp8TQEH137C/sgiXiybYiQMpPz3ZzHuqg+ZAhMza18DTuN6
 +y/dSZNNbohbLBXCimwkwxXpo2AnJbFHP5Pqey8vyN5ASWWPTOFQeFJ2KEA/AR32vZB1RzwJvRb
 BoUYxkg9OsMCCxwwP2vMMU69p5LZ9AZRZv8pQ5sT+zNXuWAUe9koEu9TZY2bjzFASrV/ItyCTNf
 D8eut1lureYu88R0dBc5tIpQeNh61xzWX2PJ6swT1eHIqnQ+5zMNJyVnCkeJQ03A9s9LML0S7wi
 6Stmgowp96gizeGqGWVy06DPhanm0tnXPNE3BGd3086V5xPz45YTEcBsZ9bYw8Bj55nrTEsfqAG
 g0ccc1FbGEHLV4SNLWr2WRKtweSM4hW9yF/uU6j1TNqWyxIBnGEjVYWRRn6lgSZZnnKDVclpMxc
 hJYaum7uxrq5TWVhAue19IgeiLjdNUutjoeklKxUZQV3vg/U5K+eWKxqfcARd1r9VpeTSDyLky8
 zile/LXQlH9Dlv0DXb7JvJaNoE84FsnOW25KeZcZ3mEM7lTu5kGCxEdCFX31zI8BtmQkjwBSNbV
 sY5oJ5Vz6vkOnDw==
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
index 9aea68876284e..f189e1ed4f3f9 100644
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


