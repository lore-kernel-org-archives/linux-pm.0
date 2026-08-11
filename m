Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1926E40F722;
	Tue, 11 Aug 2026 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437470; cv=none; b=tGccE2nhwSVxu/PG4TEXpsJ7kN2GpjXMfSgoBwvtDZpzyJeG9v4Mfw9t9jA+rCJhhewT9cetmYtFWtPOQykx4YFdCiQOF95uPFmYU/jUfEx/maHaL90wzjTJw0EW2YoaPCkE8yxZ5pXYyoUWEp8cdKXhu+qLLSZk20xLFrf5guE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437470; c=relaxed/simple;
	bh=GzrpcxMA0ZCgLTnY5svAVFOUAwdgmcNMnZmmZrgpe7E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T7ccXvDz/H1pCoKhCTm6MAf8pmXP/r+5G77yjaJlfN+VmO9mf8AtggXA5Jv2VTJyEXLlK8YJ2e3FLaBh9mB0c5elpCqcBKbP5/iIO5nAR1yHwUyJlrlNbBnBn7j0GSL6E/sT8GIug3tGKK2a47G/KTt2dhqHTBhd+RulNip0e2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sq2fps8p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sq2fps8p"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A13E4C2BCF4;
	Tue, 11 Aug 2026 08:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786437469;
	bh=GzrpcxMA0ZCgLTnY5svAVFOUAwdgmcNMnZmmZrgpe7E=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=sq2fps8pPAmNwYIgMpcsr3QdZ3HnCTxK+CCN9GFZSE6ytBHrrhtK+fTM7MUHRfyWG
	 Ic0LF6sMNCKb2maEnf8k9HrccY7n4A9iWZYF//UwuJ+/PMGJsoKmLimrcW3MWRM8BL
	 nRKZ9zW4yF11gLHjqxaZgTXaoGD6iLTcLCBNe2wQbH7vC1m4wNQ1vRnssG2L5rZd76
	 Z+9bWYFLMlaTv9uJPHKpYKxqJ3+DC0sB3dXF2Om88WNLs70E+hcv808T6g8ugzDMaH
	 iTDwkIIenCuWKkBjpQ63++dCfR8/7dGUp2UAkZkTnQ6XL0cgz1lo2pa9Ja8F+wl5vz
	 OoOl0pZXi/CUw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6D8C5AC67;
	Tue, 11 Aug 2026 08:37:49 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v2 0/2] thermal: Add support A9
Date: Tue, 11 Aug 2026 08:37:42 +0000
Message-Id: <20260811-a9-thermal-v2-0-7ddc33b11b9a@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFbfemoC/03MQQ7CIBCF4as0sxZDIdLWlfcwXSAM7SSlGGiIp
 uHuYuPC5f+S9+2QMBImuDY7RMyUKKw1xKkBM+t1Qka2NgguFO+4ZHpg24zR64U5JQw6hXpoHdT
 DM6Kj14Hdx9ozpS3E92Hn9rv+GMn/mdwyzmzXKys789CX/qb9EiYyZxM8jKWUDziEbkimAAAA
X-Change-ID: 20260703-a9-thermal-f62cef6ea91f
To: Guillaume La Roque <glaroque@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786437467; l=1143;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=GzrpcxMA0ZCgLTnY5svAVFOUAwdgmcNMnZmmZrgpe7E=;
 b=J8mpk+MyWgRnVu3Wfj1WokXKKyuzGuMqSa4ghIlfh3ClXhwwciNTisQqE31NKizW0NljKgqEo
 L1EWHuusJUvDMD1lwTeZDX60pILsjqMn6jzib0tg9w3RNeX1iq+NoTT
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Document the thermal controller compatibles for the Amlogic A9 SoC
And add driver support for the Amlogic A9 thermal controller.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v2:
- Fix the spelling mistakes (clock-names) and reset-temp properties is visible to old chips.
- Adjust the clock enable sequence in resume func and remove the clock disable in remove func.
- Add the judgment on the divisor zero.
- Add description of support for over-temperature reset for old chips in commit message.
- Link to v1: https://lore.kernel.org/r/20260730-a9-thermal-v1-0-d786d37cba58@amlogic.com

---
Xianwei Zhao (2):
      dt-bindings: thermal: amlogic: Add A9 thermal bindings
      thermal: amlogic: Add support for A9 thermal controller

 .../bindings/thermal/amlogic,thermal.yaml          |  28 +++++-
 drivers/thermal/amlogic_thermal.c                  | 108 ++++++++++++++++++++-
 2 files changed, 132 insertions(+), 4 deletions(-)
---
base-commit: 78bc8af4affb9a732504eb22eeac7d1e50883853
change-id: 20260703-a9-thermal-f62cef6ea91f

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>


