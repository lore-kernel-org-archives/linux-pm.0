Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795300703;
	b=mA7dyFCSkBi1oZ1pyCaADq/7SDVRJyP6WcGgycWXmm0bTZebrCJn+emFXpj99dS4p82a
	 WQbEFB0v3QFR/m0jioO6kLqi+cC/zW1o4rEkq5G5o9ksKBHq9s8MligayPq5N72WBHF/b
	 PIESyi3cA58evA4OoumvBJrECXx5FIogbKVDxd4e99zWELjkNrs5JVg+xDsyqeHa5LXrn
	 z7YExC4GUXJ5Dirx9Zfxhs9Zu1QaZQ81JC3IBkM8I5XO8Klx7rH+Cycm5BZWf3SqZKlak
	 wRtIylR0+FZOBODhPkVWykU6sOODqBOdjGzY6WbaHxUqPDS8pFIpZbS3qBtKnHUXO6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300703;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YWo/ZlwwGh1F92uA0N4HboD19wiKvOaTYvLMFqTnUkw=;
	b=tCaI2VO2hALSyY34J44+KbrKO9+wvvaOZvHH8j9SzB5D5T4g+Sw8llJha92rke5c2nF/
	 H4va5AYelZeEVePvpHfKxt07KyvOXgIyFY4dilDdHNsPLGycV8blRXRxmLMoItxdtlmWt
	 TuJGzzxytrRkjGhhnhlthcT+5fnJA83fkbfDdfXT4c4vkxyv56HTkJXWWtCTWlkW7R5nd
	 D5GpYmg4UHaDcKKH5VMJaWL5GxO/SbIfkJF8XcclfYmR6NBSlxGzrw/AqWhNesbeErYyx
	 ORK3qyk8jOcuD6hBiRzaVpCbf6bFVJ2OYMA65Q0kE+iiWOnjwtGsek1OSp6pu08pzFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Edjp2IeQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6F9606A680;
	Sat, 21 Nov 2026 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Edjp2IeQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795300703;
	b=oPaT8GrzYqmDmvzW4ZfImBcLRuYXVWJ25YLNcbYRsUgdAy2GCGvQYn67vPmBKLL2Dm6c
	 LPEK2RA1klZ/FRCHwJu3ZTTpCAMKzMytw4Csci47esLL4/vY4ahBw9dVkFJ7KErflWtwO
	 TNiRRl4/oCj7raQ7su75H89XwF1naWosRf51BLST+EQHqMlx5GPshgjPMhFi7BP/nm49A
	 tYt17zqQDR4fYMKx1AqtWz7eidBhGxXhDub+WgNj+QXBi7lwwNSPZT0rqnMvWGokRNiYJ
	 Vx+VQ3Whkrsvc4DxJAWeImtOFLlGFeAZTmOrIN55xT3jbcpLH9y7ZqfGH872TudZ4pg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795300703;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YWo/ZlwwGh1F92uA0N4HboD19wiKvOaTYvLMFqTnUkw=;
	b=gN6Sq56kcglhKobCWi0XhyF5bLMnvDKAm146q8EABDgi9pHYCSm+68A6iPWaPhIyWtWx
	 6O5JYnt9OcKtkoo+UInBFiPzUg/eyo23s40lUdTVqqYvl/gOfd8m4uHBRqO0klKX5FvOr
	 hzyq+IheA3aRIRF9eNJT7XSnEsYyw9IVPuEuok3U/QABK3qqX+IDLnU5q1sRR8WMPakx2
	 cdeyXAfKt7Zrar90J1jefL56BbWj8nbkx81ElhHllUWMgTrBgiptoM7NmwywxQvv1fDTF
	 Dfq+bqTscdxeo36Qnu1WIoyCmXD0NyzwQAPiZe828UuqeEMjs0vsKC9KlIA3TtyeeGQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 682AC1F000CA;
	Sat, 21 Nov 2026 22:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795300703;
	bh=YWo/ZlwwGh1F92uA0N4HboD19wiKvOaTYvLMFqTnUkw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Edjp2IeQTHjrEUaMbRFLiZR9LgofP2Gih7+uyQZBvuf4Tf3j3d1nCaFoF9I9/A5NM
	 k1LLuUzX/WIhHc6+zoUq4hIaKjFqxpd3mDuFsA71eH5XEkLaYDedL+7m6WGrQSF5yx
	 sd9/K2puy97ftQdzlCqLEpyOUaq6Q0opbp2hENhzhK8bjXVZdCTc00QVj7VxoVjKEW
	 7EHi05GjoTpVLSnP1SsTF9K5ryGGoGn2AAMQRPmUUEcSgVe/pQxHV4EZKu8W2tRrH7
	 k23lStyD1GL74Ytff27hRuY1RgOVZvMpYEl4mWPOBoiy06fOp5KRfUfNRlAgFzdZgg
	 siw4CkwbB/KWw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E598B4BE2A;
	Sat, 21 Nov 2026 22:38:20 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 21 Nov 2026 23:37:56 +0100
Subject: [PATCH v3 02/12] regulator: qcom_usb_vbus: Fix the
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
Message-Id: <20261121-pmi8998-vbus-v3-2-91ba2e61a877@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1233; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=F79nBmxItmBKLY+5BEM13y1NDT1vp2palB3VbLLu0zM=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBrAh1afl3rcaq6g4wTWEwFc5CPeJ3e6HObeuEC9
 li6KnB8sT6JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCawIdWgAKCRBgAj/E00kg
 coMcD/oCe2oRgElpBSGKInEhx2e7IDBu390+H5o9R7XOLrWmCdtAN954iUPufOnMmFauwcxTMWo
 QSb0/MTt2JoJ9QUXqMyg0wN0BHc6tODnmAwkhDBE0Ta/ivviYGNQdWpskEFb9NAViaWQw9BF2wc
 x4oLYEDtkopMivVuwTkYuMghDiXfm6woMsBu29Ju28C0WPGdBQjLX4vTWg1HswaCnYuAVBNAQbs
 BiLEeXIqAvZtfa0tMkqtAAfV0m8eSVQJCoeTeXUfa1rEMqVsoYo/tDuFfj4eUr4VfY/VZLk/DgK
 Hp90WoHufVh4+WH0ZMISXE7XHbMCFb4Y9yiaLFn+beTVCpCnkZmDP1g2Q0ClxbnEtX0QU6aNpZn
 lc3n/ltQ5o0qvXYgNf/kIS5eKBkHrAq1EOq6sacootAZdWzPfa6mcRHOn2xGa8pyI658Jyw40lK
 Mf3+1zlWfDN8Fwe5+JbiUIStwLIDQi/CsnTLpoMqvxnl/UuqadeE3vAt4ElI66d2acfuNd7/iqS
 ovv5338YMGo8RDM3kE4aaexBCM2Ka0dGmcwmAfmCYUx7EEB4THsCIahFvJ5vGeQuUvdhec/BpR5
 bTsr+/D9II5wEzuK+rdmjSwIDb7aaWTz1rQJLO1RSExxgNuT6jnUeQGWWjLFC83NzySkdcYXZ8f
 x7va73EyaUSbc5Q==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz
Content-Transfer-Encoding: 7bit

From: David Heidelberg <david@ixit.cz>

Replace the bogus "GPL v2" with "GPL" as MODULE_LICENSE() string. The
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


