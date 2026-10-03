Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C54495037;
	Sat,  3 Oct 2026 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791056723; cv=none; b=F2LB6fLaBsEz4ofrKAxqMmdbS+pArFvk3ewfuD+N0Iv/B0dPz50Ud5I15cpYsTZv35uZAgUHN1jkvbdwIvPCMzUPGsOpG8rE5SwM92UvtZu5cxGFvByNW04jnSd5hjZgtU6DomUDuCZwFuJ06+Id7KFfrgGFNdsTFKOMVFvKRBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791056723; c=relaxed/simple;
	bh=e4d3YIbpCboRqV6LBtpZBs+N7k1vOBHFMF9qD/0dOGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KXqPH7dHr091Bmgas6ZRcTiu0498yxu3FKQJ1mwSHsn13NQCAh+Ej9GTqDDYH13ll2bL0vTvLqdBi9WRkM5j2YaJCRSt8CNSCOpyuh85PItEyHW3CthxujkFeJC4Dkg3W9Rh1EzlN9mlZ8La5xZ6uknYT5aMscKvZpSrMgToqxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NofembfH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NofembfH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB3B8C4AF4D;
	Sat,  3 Oct 2026 19:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791056722;
	bh=e4d3YIbpCboRqV6LBtpZBs+N7k1vOBHFMF9qD/0dOGo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NofembfH42nqRmx/+f4kDQVOrB1yvfh7O2dC301v1D9n9hAdq2FRC5FO4/KhwyGyZ
	 jnSu7TeH3/KSXYcvpHO2cA6JFji0C3280gGsGmvpvAYUKFpTnsJHNDuYPnVA4kZ0vi
	 YL+GmRhfNo4oLvdpaqdK+M5tX7/FjmHFlUqKz7y1XruJc5pn0AAzNqOHCN9Z8UAcL/
	 zMdEqiB+wwT2zmVFAMukm0oZUOwfIMJ620YAeAEziEPlwASaSkzito1pDt8my+Z8XV
	 c/NwLULVB995ly576s3dNGt2uaC4dKQY+/R4XwvA2uBET9l5bnZ7IFwHSdKtZuEk/X
	 rd4eMa0Dao+Sw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23A9CA5FF2;
	Sat,  3 Oct 2026 19:45:22 +0000 (UTC)
From: Fabricio Akio via B4 Relay <devnull+fabricioakio.gmail.com@kernel.org>
Date: Sat, 03 Oct 2026 16:45:24 -0300
Subject: [PATCH 4/4] arm64: dts: qcom: pmi8998: Add the charger state
 change interrupt
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-qcom-smbx-chg-state-change-v1-4-fffaef446932@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791056720; l=1071;
 i=fabricioakio@gmail.com; s=20260928; h=from:subject:message-id;
 bh=7C77VJn5h1hHh/I/VZZaiNv4WEPYvSZpJOqhhjqRqHc=;
 b=0exrXWpGGiWrGFNj6VZv5rb5FFi3oEO9R9FhA38JvxlNknm4uAx73x2StdvgjRHBaFwqQcy2U
 E5Yh9gFzZNMCxsvBiC7f1jgm+L6wIE/O/8hD7zkoPbE4Sa9XwkoY0hB
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
 arch/arm64/boot/dts/qcom/pmi8998.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
index cd3f0790fd42..bd07ff137947 100644
--- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
@@ -16,11 +16,13 @@ pmi8998_charger: charger@1000 {
 			interrupts = <0x2 0x13 0x4 IRQ_TYPE_EDGE_BOTH>,
 				     <0x2 0x12 0x2 IRQ_TYPE_EDGE_BOTH>,
 				     <0x2 0x16 0x1 IRQ_TYPE_EDGE_RISING>,
-				     <0x2 0x13 0x6 IRQ_TYPE_EDGE_RISING>;
+				     <0x2 0x13 0x6 IRQ_TYPE_EDGE_RISING>,
+				     <0x2 0x10 0x1 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "usb-plugin",
 					  "bat-ov",
 					  "wdog-bark",
-					  "usbin-icl-change";
+					  "usbin-icl-change",
+					  "chg-state-change";
 
 			io-channels = <&pmi8998_rradc 3>,
 				      <&pmi8998_rradc 4>;

-- 
2.55.0


