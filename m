Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795300706;
	b=f00rOqcLS4814CYtLtJPiRvwb9u64JLi5pP71/BmfqLQQUxl4F3ciUb8HZ5vsSamr28S
	 UXPbauz4sn00MaCEW8bchHhkaHB0CA3eQgUFSWTjzL27g1HQIzUs6D1hsU/FDt7lqEdaH
	 mxIosz9gZO+AA+8ODLO4IfOvz4kkGLkRKGIKk88cVDmyJTZdYmMJ9hfP8uest4CrFNpUe
	 umQaq8zWGJQevkep2ss4ljQjIIyLRz+VOKfN5npfdg+a4FpQTK0gd9yaorhEvXtWSudwu
	 ceEAAgBCBugpeKsMgw+jGIX+VEclImDzj/lehn1I/2n5QaUm1jlvru/FSIXUP6tRtkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300706;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FIHDD5s5KE8PXxWLtY1YUiakfZ/FvtGVk9HnUru71fk=;
	b=hzCYS2EETsrnX60+c8Ri6xXoU1v1LAgDERj/NYf/4ddhoIpz+AG5ESIfdB26KbrT8pO/
	 lA1v0iHNRdz/sSJT8zpO3kGSs9OXDXp79Hz4bonnWm9tvrNCBLpkuD+Rk6584HBrkQnah
	 KtxFOjeERNUQ9d5Mz23ExIfKejSWHYOJM+EPpHVzjiHvwK3IU0mAoM16G0REZE1U8huFv
	 9tKy3Y5kGcCWBe7WFdnQKfmNqJHFdqbykxC/DkmXPWk3dZcuDlogz6njRE8/QPLx9kp7b
	 Judd78ooRE+WpGKJi6bvrsoHZzsFb88zjB/p8tm6wQjuInr5q7xfoKXoxuqIOeiQh/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MmT1RLLv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E94460A262B;
	Sat, 21 Nov 2026 22:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MmT1RLLv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795300706;
	b=d0D54STq8A8H52NpUqFF1xaiC5sII+VI9ejuISIxijzAcTAxZKSdS84Kbqq1svaF6Jdt
	 rMJbqYo8/vYzSMV8n9GMTMRCmXLaeBSYmxIQL7ik5YsUfecxsFSTL6Z5OwtixtxXynFfs
	 +x4SJUHG9AN5GZvAbjuqub9VPS0Mb0CrI18AzEf9n67FbZkxAGf7FYUp7dkl5hRA0G7FU
	 abgJ52DDDDV51GZMvJJw0pT0gMdeM6ox0lEwXOlec6Ul1Np57CxV/sU2FBPBKLaZFDw0z
	 94nwebff3650qK2paA+ldj1UkoqWEMC2QrLEkUStyx5mQapXTHp+07MCrl34a/Knvqg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795300706;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FIHDD5s5KE8PXxWLtY1YUiakfZ/FvtGVk9HnUru71fk=;
	b=rPXza0EH0exk17QUwch2CeNa4k9IMTmXbXV3UODm7iD2jhdNDZ5uZsvbbRFpYzSJ0dz/
	 vmm7iCQ352iImJfodOfulqR4e+IOVxuSzWFcMMWTc7bI/F62cS2ASldIopRwsJdlfA8Lu
	 ynadElFgib98IQ/WSenoG2Xhkq5pAZpAzLsU0RfXK40Mflz+mMwQiI1jhQCKJx9gwfKHk
	 c3GUWXPxR0f+1vbk9uMPEsi9HyoW0AVAGGgyKkSlp70xljTtkWfcaC+rGsuPrUptznXMb
	 K5lr99TBBLeUONrmj/PtOWEq/Kc9/WrD7t168+jnmyJg7+crsujEyOdEk6nX+tQVgQQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8CAFB1F000D1;
	Sat, 21 Nov 2026 22:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795300706;
	bh=FIHDD5s5KE8PXxWLtY1YUiakfZ/FvtGVk9HnUru71fk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=MmT1RLLvamUlUco5rGenSxdEJZdVW8TLck3qbM0uUk++QuvGiJ9KRwwJWoF/sRS+r
	 EFlbdeYJ5h3O5Y2xNhRJWdhPavQY7pS2lGx8PhZK2CBcgJfkeuJcGLLHL9aYzjahjF
	 UdTWT3kCDwJCo7nSQy3FDRgDRKO63Dg+927MHnO8QzrRsrWEJWviy3y/w8EQ7fCec7
	 PtWSuS+fuG14pZ+Qn+zkSsNlxqD69lPqY6rlexIBzd4lAxN3iLk9C35IWMf8PWVIwN
	 hXeYnrJm75jBrL2VOZXdN11HOlF/op1s+frKVMeKQ0/tUr73Q+P5ES7bNVmNljlkJH
	 SD52EZzSr/vkA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 96EE74BE42;
	Sat, 21 Nov 2026 22:38:21 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 21 Nov 2026 23:38:02 +0100
Subject: [PATCH v3 08/12] arm64: dts: qcom: sdm845-oneplus: Enable vbus
 support
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
Message-Id: <20261121-pmi8998-vbus-v3-8-91ba2e61a877@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=982; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=Eep6bEgeGbDyrRVKlPckzaAdcuWR7pnxVVrNTNmBXbY=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBrAh1b0pSd1UM0iCZHqOvsoxr3z/FgkiN1GZXom
 F697+iWiTmJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCawIdWwAKCRBgAj/E00kg
 chYrEACT7wqVshGwHQCSqc3FSIeDpiIPp9C2PKf7TgNYhC8h8P9ynbXYtonM3Pkl7x/mOUiQX/V
 XH7oTyEWq9zIQgt6iXE6gjXmofn8Q0mS/6hp5bm6Pj5BuPPKcIxCLbu3uUMY2SYLGu/iQunc5G5
 9HSP3mDYCAlZwBUOIevgR3PU5XsEyz3Wb619XzTohZg0ADphRHzDV+C9G7mQ2mvgsmGYiEg8i0p
 b61k0mLWbgvUgepOubQMeTmZO8uEg1BkcY+MjDnFBAscuky8nXAtqAPn95XZWtTHMyUCa67mKUj
 IhJhMYdq73AyDXP8mCmaczDab6SJxtqkNDEqydEhSfNBDhrT+EK3mGIKf1Ol2O3VAwu2zG2H84u
 XYD2U42DH5OYNy3McpflODSIHx1L7USz2laVKUFJpvhEFuHMjEzWqv1XW9xQJzizE/TUDSwNhYX
 VBLwz024Cd2EZu9YzXka1tdhfqj+yXOkBA8iIIzm6/DRvSFpf7pnde9nGu4t1oqmPaimZy7+9Ev
 egrNpKd1hCFhc7JNeQX2G+Alqom0qH3hzq5krUOXybpkYkvkNVNL/tUONxnRm41EGxFzYdmdfkW
 YZl3ag3IuG/P9ocMc64AS4alFLQ5InInzgGzCXNCqnXrh01GwEpVyl63DRlJDy5KQqM1o2NRO+l
 zUHby47BtqnW1Uw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz
Content-Transfer-Encoding: 7bit

From: David Heidelberg <david@ixit.cz>

Enable the PMI8998 VBUS regulator on OnePlus 6 and 6T.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 1df09da3c4d71..4996ce24fee36 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -660,16 +660,23 @@ led-1 {
 		color = <LED_COLOR_ID_YELLOW>;
 		led-sources = <2>;
 		led-max-microamp = <500000>;
 		flash-max-microamp = <1500000>;
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
 &q6afedai {
 	dai@22 {
 		reg = <QUATERNARY_MI2S_RX>;
 		qcom,sd-lines = <1>;
 	};
 
 	dai@23 {
 		reg = <QUATERNARY_MI2S_TX>;

-- 
2.55.0


