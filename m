Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F406D379988;
	Sat,  3 Oct 2026 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791056723; cv=none; b=ssIlgfVgx28jFVz2ucvYq+pGIcqZoAFhRG9N5PFlIyZZnw6nQEbXAM0AAcZlcxogfQEM0OizEAbPOiAEFXQEoTJinvEfXdDsKljHpe2MQJ4mEmW3ug1+5/eDCCZzZdElxXa4NRE3HZprX+lzy2iEkEn3AKIf6ThiG73HMZ63Gj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791056723; c=relaxed/simple;
	bh=j0JUPS3NqAgZfamgFMUUx01rdLyiXqWVMETSSNyBdVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=loZgX7dWiAZnkuzAJt7KbxKGJ0x+DKvv19/mLFzEsZhkxxFwCvqqILcGGAw64h1QYkWbKpA7kwzrofC/LAdSG5xcxpnUUI/uiDGs/Enfl7GDjB6Ge4pb67N+62B+pzWXICDWjHaBps2lQy7pg93Ioqsthdc3C6gQGOIbwbqKRvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQh78b6h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQh78b6h"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FF93C2BCF6;
	Sat,  3 Oct 2026 19:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791056722;
	bh=j0JUPS3NqAgZfamgFMUUx01rdLyiXqWVMETSSNyBdVw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LQh78b6hbVaoB1ukecG+shpP7eZOcI5y+pJMDlxq4ZrP8BWoTWKfwPvA73vQCi8qX
	 Q97ESew2uEiajl9Bcqzk43Uy1PyOwSMhsfZnsLvWxmv07rDafy7uZwdrzoe6tKl/QD
	 3f3Lvbcxj3hYZ774CVOvZQx7hOB4YGvI3Fyj/6dGHUxfYStzj/056IrI/+3kmQYsKv
	 cPuEjYEwMGGNNU6sldEIhq99c6rMZ9MS4/Y0O69I1yISr1NYH2B3p+yZ5dcyUa4rWS
	 E06PLAJEH3bxGOY7ViqyI0WrNAQO2X8dKf+coVS3IkpF73m2pT0yB4SnC0d/7+vxa3
	 pI31mgkIDQHJA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8A6CA5FE4;
	Sat,  3 Oct 2026 19:45:22 +0000 (UTC)
From: Fabricio Akio via B4 Relay <devnull+fabricioakio.gmail.com@kernel.org>
Date: Sat, 03 Oct 2026 16:45:21 -0300
Subject: [PATCH 1/4] dt-bindings: power: supply: qcom,pmi8998-charger: add
 chg-state-change
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-qcom-smbx-chg-state-change-v1-1-fffaef446932@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791056720; l=1039;
 i=fabricioakio@gmail.com; s=20260928; h=from:subject:message-id;
 bh=ACxRf9zQSp49WZNPI7O//QWImpQWoDmjFCaFFKAHtmI=;
 b=+t0z1QY9OEqXZpMHKaaitOEWXzs7uGy8M364T2NPNEKO6I6HKcQ+nOAjfVVCQUstxzj0OVdv7
 758Z/kRv9NQCvAzmNIGESkKKVA4OY1mYE2xLXihRjaEwmIDovipNxPh
X-Developer-Key: i=fabricioakio@gmail.com; a=ed25519;
 pk=TlMUT8bPI/ZQzp2q24BIQTb2qSx/jdUTBlGEXIRCm54=
X-Endpoint-Received: by B4 Relay for fabricioakio@gmail.com/20260928 with
 auth_id=1076
X-Original-From: Fabricio Akio <fabricioakio@gmail.com>
Reply-To: fabricioakio@gmail.com

From: Fabricio Akio <fabricioakio@gmail.com>

The charger raises an interrupt when its charging state changes. Allow
it as an optional fifth interrupt.

Signed-off-by: Fabricio Akio <fabricioakio@gmail.com>
---
 .../devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml       | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
index 70f5cd6eaeab..7dfb0823ccbb 100644
--- a/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
@@ -19,14 +19,17 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 4
+    minItems: 4
+    maxItems: 5
 
   interrupt-names:
+    minItems: 4
     items:
       - const: usb-plugin
       - const: bat-ov
       - const: wdog-bark
       - const: usbin-icl-change
+      - const: chg-state-change
 
   io-channels:
     items:

-- 
2.55.0


