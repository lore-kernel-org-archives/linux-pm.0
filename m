Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795300706;
	b=gtPKsfmouhuY0UqBTwwsp+g4cEMAailyxuLQtP1g0u/zP3m5TX1N6PcRmYuy4VaYJoaX
	 ua//rXFCbnimbevWAToZJ58wdTUV0oR5wTVMI92t+Q4xMQnfmvYQkEQCQqQHA0uXKPBbu
	 R1UFae/MvpZHM1wf9ptfoBQkeztrkp0REA5u557aXLaxBj8+tdwwBXlw9vCaiHcWbneAu
	 Vm2ODcmBfR4NH2ce/CHW2YevL/ETm0xCJu24nrfcCo3IKyat/MtIWPXWW4nFLaV/he5BQ
	 B+fUQLay2tMyyln7SgEaZkCFZ4k0Dc5L5O2yI5WKEDokjcoOuviDNe/49MErVP8q6Zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300706;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GrxcA6n+UdsaPiHE9Aox8jRjvrLPm0x7b7S4S4MZc9o=;
	b=jk8u8YfiOPaFXLicAxLNKPJydPAyqovvad3zDQkW83rtqGag004LD5rwDvAu28+tgdCT
	 0xjnIAChPxKxmGCQ9/1F1u08TXhLnT9T1jj5AjdWegyehFjl1bMsYJKK2Tp934DPhHDgU
	 jYmAa9pIn+uqtrqSetDURccmPoVus586rGeA3zNx7ogXcSUVROm03jf6Pr9SXP3StghZI
	 y5R2MgGWvpdf86XMWz/npSUgSr4Lj2SnZgyY+6y37B0RwOOw3Agfz0KsgYXwOMCqHGDBJ
	 +4Rm36L9DO3w8e3gOen33uu5uDPGpPiBbdy4ZZ7flaK9W/x79V+lD33zN4vJXo4NlzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WEZ30Ixb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4643F606A691;
	Sat, 21 Nov 2026 22:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WEZ30Ixb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795300706;
	b=ObFh99gBilJnPDPgjl1PzSz099yOYmZL/kZWfk6FWVidAHJD4dJrcnPo2VWMRsGm2i32
	 JVYLRf01JYKWi0uIsCPwhaqE/6nIsPp00yfMy/avClTmBtB8CM/6P4X40VEPjFlcSspAf
	 qcgIMXot5YKD+Y7JTdzYOmJQDo7nUHqnDhsUiFG7GID4/FhMIS12BaDSuL9QTBCiHdIEA
	 ycDj39BJBpOLg65i7sdsIh4I/hLj3hwg9yjB/8+k+x92za2/5f/PIcN2fRz4J2VV8rvsK
	 yFlS2lDcV1PtVi4I0WmCUauQYiw4fIoyTDKPc7Qkxk7E/ilIkslDody7xLHWvhgKcww==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795300706;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GrxcA6n+UdsaPiHE9Aox8jRjvrLPm0x7b7S4S4MZc9o=;
	b=ZhvqVidbZNtQxcKETRYTg9Da5ur6W3uuEZjbLBCdEiRhpwUkV/pEQPDfBq2AJUCX+1tV
	 tJ+QGvfnpNkKcrXD0f/y2yI6iqDM8zfN1BVUNhI0TpPTk9dfjOv8TnDc40jfZc0FABJrN
	 Kys116auNmUhhqWntcaLuMykTwQa8c1CFvJxgEjY2BV4WF61eoD03vx/LhydX0Boxr1u3
	 UvCBYi4KY/UNl2LfhvjFWbbKEmWEc2im6WbnBBDxafK2761MwGGz//d3eVYcExtmsgV+z
	 B6cK+UAzamefquMF9d+aycqIVs3JtboeJZ2sENBkMAwxT9xTKBNzwWRO9NopSWcL4/g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3CA721F000C0;
	Sat, 21 Nov 2026 22:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795300706;
	bh=GrxcA6n+UdsaPiHE9Aox8jRjvrLPm0x7b7S4S4MZc9o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=WEZ30IxbBHUmZPhttVZahY3QrXZRytTmVLX5+qInkdVbzzm4PFC0S8tgAEb7s51np
	 5C2v67jcQieq9nuYmgPZBUUPTrCKzBbGGIptX6NjUaeZ98cbHpgt16ukDies00t7kI
	 sZgaYmAeF2HevSz8ajmBW6YWDznmJbRJo2vdzS0Smhd7v2bN2CdfR6I/VNt64OEGG5
	 pJUb0mrMKXpYdRR9Gj46wtJI5QL8sImFcvPJNRhi8AatYbWZth4/MNX7Muv/dAMyzq
	 dLmmfJtzdlfK1s4xBoWmCr5OxK/ZrjxT39zMGVo9riUePgo1dU78PsNsApT+WL2GMq
	 srpx2V3127Aiw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EACA14BE4E;
	Sat, 21 Nov 2026 22:38:21 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 21 Nov 2026 23:38:05 +0100
Subject: [PATCH v3 11/12] arm64: dts: qcom: sdm845-xiaomi-beryllium: Enable
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
Message-Id: <20261121-pmi8998-vbus-v3-11-91ba2e61a877@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=972; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=o04iq89VavkM6zZ1sRS5syuscytR/eIqNM1KHm+uQPE=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBrAh1bVQe0BIJ83CUaUBg/d1rWQ1DypQbW3xYBM
 Mr7hbwg2LWJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCawIdWwAKCRBgAj/E00kg
 ctNPD/9FC5dcqjq80O+PKcJnHQwHspYIKbvSsScd+T7SoTyRMty8bXQXrCFhFEGDq6jAmDRnw7e
 6mXcr0Ph3Drj8uHrhleCrNsfMqAqsrFFX7scZhv2kzfZfIK/XiwYsv6dMEUP1Smuwsr50wo5qbn
 1g6irwbiT9uyeNT0a7NmUSRMbyooZ3llkO9dYuRA6CObW++rWbSgCpvkcyXOlf0edDmKTAkLEv3
 TIfVzVXTEfkphCjTkpQafQZnNz8Zi2k25koad2jBG/qR3+WGXjGI7E6MRqKWSq93s1QUYNunSPv
 PLSPe6dldctvZHQPfR2a1o38opwfh5G6xpu3pVzsIENipvHMojpMLWJf5MO8RotLsGbD/0MEn7a
 vbfT/ac+g6Dw72P3VDWfHmpZARLwzZTtxEj6Wmd4yvEiI7qTdQW7KG4XAfKfyIGiJ9baOM03L+U
 T1wfPH2QPcWEfVC/7oYV2vP0YeFPcd2QpxRj/ZKUzTwKS3JindWw5ZCX3Aeo9vggz2b2vKaByBZ
 h40fY1lSizv4j+f3eqRSB+kp06PD9cewkcepkmEsFRmr77bDhvnD7AdxvcaLR3pL5IBVFyLIcYN
 rW6zXis1Ee0rkDwY3SJwBzYvh3On+M5CtGvVGe3BFcyYKVBmaQ9H0/W7dbI3xmfm/HlgXG291fX
 fsUW7I446JKNX4w==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz
Content-Transfer-Encoding: 7bit

From: David Heidelberg <david@ixit.cz>

Enable the PMI8998 VBUS regulator on Xiaomi Poco F1.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index d57851b0b9419..98763608d5310 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -418,16 +418,23 @@ led-1 {
 	};
 };
 
 &pm8998_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 	status = "okay";
 };
 
+&pmi8998_vbus {
+	regulator-min-microamp = <500000>;
+	regulator-max-microamp = <1500000>;
+
+	status = "okay";
+};
+
 /* QUAT I2S Uses 1 I2S SD Line for audio on TAS2559/60 amplifiers */
 &q6afedai {
 	dai@22 {
 		reg = <QUATERNARY_MI2S_RX>;
 		qcom,sd-lines = <0>;
 	};
 };
 

-- 
2.55.0


