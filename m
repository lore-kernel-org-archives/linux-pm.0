Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794999148;
	b=337KuU6qDM3HLvXDHqdpcLlR8HbPEk2P6/L1gcm3rtaIMw8JygKky6mvLswx0nBAJg0W
	 n64cnwqIcveQ9EIztH89i1xTNZwlki/4tzEgRMHwj9aDmGCe9lw9kd8wMIFzM6kTuQyEH
	 RxE2cPOPfaYnHX/4VFaXTWZbcnX71wkswvS4zJ4wf1RNQ/nMA6RInreg/uMAyB4WVoKuh
	 CkrQjXSqobBEw3M8n/3gMCTmN9rIl/wr1efntQKobdBTTpm9E1i/IJi1PRQuB973Sxpxq
	 fwuFAujGNoY4TxUxA0nBH2wZW8wmmKlD3dwNQkjc5QfZ0t5j2YCCepBfSmV6JlPeLpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999148;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xrAEk6/4WGNXDqt6SdPWcxivaPvWRQHVDKqiBuuVVeE=;
	b=dm1xJIBSwIO9J72g7PVB2SEx5eKYen5+IMa1i0Iy4Q4boavD7habYv+KxyZVVF+flKvA
	 aENpeMqs0X6jBsw33w/sHd6FfgttdEq0GOvXYml5oT+pMK5iPQxztxfEY2dK4HhHc59Q1
	 2vL1jkHKQtA8C7E+SfA1kQqCbn9uGwr4a7VURIBsDjXZjAN6Ov689wF/11RZJ7lcQZBy9
	 g4dOYTT/rCf89vHoxcFIyGkcC+eyEuzfrpIqFVko2xctI3EOz/4mHhqJmzjCu6GVl3ENn
	 mp04xlILt0DYAYT3QcYZlXNNZ+ymI6YqVmPyyh53vPUweFX/R1G40Hia3vrw9lCJ0jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FLmSuKsn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E3660A260D;
	Wed, 18 Nov 2026 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FLmSuKsn
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794999148;
	b=mg8UbZCYxgwekOA0F1e5ThM4Etrp+N/FjM4oMu5xIbuQkTUSgu50fpZH0iPIXvEpph+X
	 hDRXDn9ybpwKAziPKoHxstjQyhkYBfNpSDdU8+SDY/HcYViw4oIkEGG8iStDFNpGoi1tj
	 3uQLHCxJRCfdDGZicCU4Wisn1xV6monq5jBZFzf6nL1TbvZpZbOwn+QO8NrOoRmD/pMD9
	 uOxdLmsFxXzyH+pUVQ+9A0k9Ze0fUsI0RxvlduvcgGFW+aQ72HYWAJ/L5hNu3aGySyWER
	 Eq8YPbBv6QEqQm0BRGvROISrMccMc9+EAE+8rNG9YfkQKnojpI3hc2rUXd/1QbS98zg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794999148;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xrAEk6/4WGNXDqt6SdPWcxivaPvWRQHVDKqiBuuVVeE=;
	b=rW8aq4KbrhhZDyd3vQmXjVbsbZ+o7LDKu/3qcHNY342OuQSZa0HczBZPRSGSrFlsroTS
	 aLTEOw85Xl/p6zL/b3jHYdg7RP8XdU1GR57WsSEKApHxSScpTypkMgTcrqW1VyNl/1JYd
	 /ZFaSz5rlYnRtYNSujtcI0JC4QEGfUQWDtXDkAhiEsSQx4etxK6AnN3b9R5sWXjF5F1SC
	 /KQcKzb3Xtaao55kDkmbFXb61ajamNteNFxCGqJvWepRITwYk9SsWzDXjpsaQi7iMRcGu
	 GpVvI4+j0mAZZm0/cdqw3tpufRGgCztPmYK/kqeowCquEodHfi8g9MpfCSFNpisnhuQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2736E1F000C8;
	Wed, 18 Nov 2026 10:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794999147;
	bh=xrAEk6/4WGNXDqt6SdPWcxivaPvWRQHVDKqiBuuVVeE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=FLmSuKsn0a8nrabKv3rbcj8Q7aPeYDxgKLK4EBmfDubuBX3Ym6U5yevh55ttN4/49
	 WO4rLPEprjk7HPS1Dga5CaaIk8Ag7E0SQHyB4e2XSy/GBRtuyVI6jKHhORQbsMvhJ4
	 QSuXzEksAZ8rGlwlgZjCyoYZzuU9u3XEo9T5P+ArPukkedHfw1uEbW4pfpvq1J/Duj
	 qsawcGSbje4wxV2a47M9u66T3fvs+kumYQ1u0JmGUdgClnD8qavsdJORXWHvn3Wdlj
	 /6X3+Cmv5aJrFl0hCvRwhmkfJICZgBT3yUyAfZSckZ6KXhmemk5uy9ZZ5MF3Sil/Xa
	 4h96mY/HElIhw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A75664AD1C;
	Wed, 18 Nov 2026 10:52:25 +0000 (UTC)
From: Rajan Yadav via B4 Relay <devnull+rajanyadav0307.gmail.com@kernel.org>
Date: Wed, 18 Nov 2026 04:52:27 -0600
Subject: [PATCH v2 4/6] arm64: dts: allwinner: a100: Add A133 speed grade
 efuse cells
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
Message-Id: <20261118-a133-series-v2-4-8bcec9c9aadf@gmail.com>
References: <20261118-a133-series-v2-0-8bcec9c9aadf@gmail.com>
In-Reply-To: <20261118-a133-series-v2-0-8bcec9c9aadf@gmail.com>
To: Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Alexander Sverdlin <alex@sverdlin.org>, 
 Cody Eksal <masterr3c0rd@epochal.quest>, 
 Paul Kocialkowski <paulk@sys-base.io>, 
 Rajan Yadav <rajanyadav0307@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794999144; l=1665;
 i=rajanyadav0307@gmail.com; s=20261103; h=from:subject:message-id;
 bh=QDA+B3vGjPJfqlQByEbIUmG8/8wRVGARGoza4DrglDc=;
 b=hKLNDqmnQeDuJKQ7lx/vsNw7nGNI8PDmyb6Eo9Oy/s3ocVt9hvtNz/XziotlRlyPxC7g9ztRC
 F8W7C4Be9nyCsMkCNgx/hxLqbVshw8HalMmPmMOMJ7gBbd1MQThH8UG
X-Developer-Key: i=rajanyadav0307@gmail.com; a=ed25519;
 pk=4ZPeiP5qrv2b44q/Obxi2koUS70Q6npbttJnpUoTlgg=
X-Endpoint-Received: by B4 Relay for rajanyadav0307@gmail.com/20261103 with
 auth_id=1391
X-Original-From: Rajan Yadav <rajanyadav0307@gmail.com>
Reply-To: rajanyadav0307@gmail.com
Content-Transfer-Encoding: 7bit

From: Rajan Yadav <rajanyadav0307@gmail.com>

The A133 speed grade selection also needs the chip marking ID (SID
offset 0x00), the word at 0x20, whose low 12 bits the vendor BSP calls
PCPU, and the word at 0x28 with the bin extension bit. Add nvmem cells
for them at the offsets the BSP uses. The H616 reads the same kind of
marking ID at offset 0x00 as its speed grade.

The cells are used by the A133 OPP table added later in this series;
the A100 OPP table keeps using only the existing 0x1c cell.

Claude Code (Anthropic) drafted this change and its message from the
vendor BSP device tree; I reviewed it and checked it with dtbs_check.

Reviewed-by: Alexander Sverdlin <alex@sverdlin.org>
Tested-by: Alexander Sverdlin <alex@sverdlin.org>
Signed-off-by: Rajan Yadav <rajanyadav0307@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
index ba6020989ce..d1164f3b549 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
@@ -176,6 +176,10 @@ efuse@3006000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
+			chip_marking: chip-marking@0 {
+				reg = <0x0 0x2>;
+			};
+
 			ths_calibration: calib@14 {
 				reg = <0x14 8>;
 			};
@@ -183,6 +187,14 @@ ths_calibration: calib@14 {
 			cpu_speed_grade: cpu-speed-grade@1c {
 				reg = <0x1c 0x2>;
 			};
+
+			cpu_pcpu: cpu-pcpu@20 {
+				reg = <0x20 0x2>;
+			};
+
+			cpu_bin_ext: cpu-bin-ext@28 {
+				reg = <0x28 0x4>;
+			};
 		};
 
 		watchdog@30090a0 {

-- 
2.34.1


