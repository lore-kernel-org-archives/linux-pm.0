Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389EE495021;
	Sat,  3 Oct 2026 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791056723; cv=none; b=j/OmZfdI3TY/jcHfO38MNYi6/oCHVMhXPYMCheVOCGgCYXXPrwFdEwTSjEWY2bD3H49Dmkf+Ix5Czh5bpzgE8ZhQ8fzw+iyviN6duZlLzMzCHDzpgWqsw13ceO2idVuc+xcNkNZiaPOv/yBhZWVGN89M6y5uPcaM7UMPqNaCWyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791056723; c=relaxed/simple;
	bh=E+N5FsWVr+3U2IATk4EB4OXYHsVwPtNZfTs1KDEbiEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jyf5Euczjvc1WEKY80lADD3A1RSdQ9PjI2rfb9/MTXIOkU7UXDBmRBYi8KyTRdSINY5Hg2nnuM6xBPOd0jL6fm10KxI3eKuu4hb7+tcIzv6n9eSh1j9jtXvZPBgx05keGjMO8BMM3Fi/f/BsxjX5jvEnfUoz7iejbHBBhJYfBWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNBhAn/Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNBhAn/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0A5FC4AF15;
	Sat,  3 Oct 2026 19:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791056722;
	bh=E+N5FsWVr+3U2IATk4EB4OXYHsVwPtNZfTs1KDEbiEA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uNBhAn/ZzBwNeSHhc/TSYiwRWs6r7aFBcr0JZu0zgWjAfs9QllTgKijcFLVU3Pgu8
	 TsAtg4y9MYHzu0KopD9xrT29GyzITe/NJIvSqkTqk07hjAUGjyk8ymcNc9o+xZyI4P
	 K6r5sTWDzL7Jf8V6GtTLtIvS+FZp5Kn88V6sxYP7a5Blcy/tdi307sUolrFnVheR+G
	 54WXjnmJHZKTn3Fy3RUwOsiz5bakhLaADxFBwonfu5zaGZdeMHhQ+8rFV4r9Hmk4i2
	 APZncU1ofV/v7oC9cEtnCW/DKpyZs/Vxh8utt6n2r7KEdNbdRYI+R/7emjHrKX3Ycu
	 V3NR6mtt7lWrg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13C8CA5FEC;
	Sat,  3 Oct 2026 19:45:22 +0000 (UTC)
From: Fabricio Akio via B4 Relay <devnull+fabricioakio.gmail.com@kernel.org>
Date: Sat, 03 Oct 2026 16:45:23 -0300
Subject: [PATCH 3/4] arm64: dts: qcom: pm660: Add the charger state change
 interrupt
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-qcom-smbx-chg-state-change-v1-3-fffaef446932@gmail.com>
References: <20261003-qcom-smbx-chg-state-change-v1-0-fffaef446932@gmail.com>
In-Reply-To: <20261003-qcom-smbx-chg-state-change-v1-0-fffaef446932@gmail.com>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Robin Snyders <robin@snyders.xyz>, David Heidelberg <david@ixit.cz>, 
 phone-devel@vger.kernel.org, Richard Acayan <mailingradian@gmail.com>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Fabricio Akio <fabricioakio@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791056720; l=1108;
 i=fabricioakio@gmail.com; s=20260928; h=from:subject:message-id;
 bh=fPok6iXSi+v6rT0DKKTD36U7EXn5qf9X9GpJo6/gwRU=;
 b=+eylQCsYjVqiQGl2wnWDuJwVDidnVbXqOw/1gBDHEaioEjV92Uhc0C66RtWqbmpoFNW66oIyU
 GBO0Kc3xk/mA9fkDXQQnz6pD1crX8DYEwHrcHJQ2oF2kPF1615+OauM
X-Developer-Key: i=fabricioakio@gmail.com; a=ed25519;
 pk=TlMUT8bPI/ZQzp2q24BIQTb2qSx/jdUTBlGEXIRCm54=
X-Endpoint-Received: by B4 Relay for fabricioakio@gmail.com/20260928 with
 auth_id=1076
X-Original-From: Fabricio Akio <fabricioakio@gmail.com>
Reply-To: fabricioakio@gmail.com

From: Fabricio Akio <fabricioakio@gmail.com>

Describe the charger's chg-state-change interrupt, as the vendor device
tree does.

Signed-off-by: Fabricio Akio <fabricioakio@gmail.com>
---
 arch/arm64/boot/dts/qcom/pm660.dtsi | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm660.dtsi b/arch/arm64/boot/dts/qcom/pm660.dtsi
index 156b2ddff0dc..9e84f16f4b06 100644
--- a/arch/arm64/boot/dts/qcom/pm660.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660.dtsi
@@ -80,8 +80,13 @@ pm660_charger: charger@1000 {
 			interrupts = <0x0 0x13 0x4 IRQ_TYPE_EDGE_BOTH>,
 				     <0x0 0x12 0x2 IRQ_TYPE_EDGE_BOTH>,
 				     <0x0 0x16 0x1 IRQ_TYPE_EDGE_RISING>,
-				     <0x0 0x13 0x6 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "usb-plugin", "bat-ov", "wdog-bark", "usbin-icl-change";
+				     <0x0 0x13 0x6 IRQ_TYPE_EDGE_RISING>,
+				     <0x0 0x10 0x1 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "usb-plugin",
+					  "bat-ov",
+					  "wdog-bark",
+					  "usbin-icl-change",
+					  "chg-state-change";
 
 			io-channels = <&pm660_rradc 3>,
 				      <&pm660_rradc 4>;

-- 
2.55.0


