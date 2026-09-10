Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240323D3499;
	Thu, 10 Sep 2026 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022337; cv=none; b=D+EiTC83jVANwemd2vZtc+31XVJy6DB7qIaBSHBA9UU1bli8pejnMiFdoilAIrss/wTArbxAwseMrYSDVGDUR9fefHF0dWl7MgNAA5dCTLQkmDCx5U1Qyj/sTehOW4TbPPMSMjaXir3hunUVG3o1Hj1wDxNF6IKmoFNQA5G9vbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022337; c=relaxed/simple;
	bh=6rWt1xIppEggcuvcPQEJmOPBQ4LH6RI7xBI39Qw2D18=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BEPmjPv/O7IXAvYtdEXBZIQypyTMsmzfYtJuAUdw5YrKFeQwEgPeSOpPBWWR0wr0TUYEy8UA6jjYCElHlUIgMYcB46LmrpfDiOKcon0S9G4bjXmnsSchV9HjnXroZILf0sjyXXhTlkWF3gIJtMgPq+D1T8Q2xEG4gUxs+BOIsQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asQKg2js; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asQKg2js"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80AB1C2BCF5;
	Thu, 10 Sep 2026 06:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789022336;
	bh=6rWt1xIppEggcuvcPQEJmOPBQ4LH6RI7xBI39Qw2D18=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=asQKg2jsOnk/gn+/y2WbW3SVRO/fQiIT04LV6QcFqSc3zmiYwvEhivMyjrzr6B1SJ
	 3TZnVgdJDs567coBRI42tEG3iy+8zSqu2eCiA7roiGGFyN1/RuOWhsulwguA+mfLyw
	 LbLz1sarc7oGRsWkv4dFDtJjaINUqtlxWzShMW+fiK2yNKvgsjOz7GiMbv3WqYh3N+
	 YNjsRJFA3pT4fIQo3SDEQ2EmnU9z4RNYEeTcSB18Z3qrnKsRUv1qXZkaCexzKqzv2J
	 784p9aRJMYySZ9tOhFRtNgRi1xTimzZkHcK5KyGLQNjVuj8rgz76tHKq8kmpGklf7B
	 n5pheqd3MJMMQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B05FC79F9F;
	Thu, 10 Sep 2026 06:38:56 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v5 0/2] thermal: Add support A9
Date: Thu, 10 Sep 2026 06:38:51 +0000
Message-Id: <20260910-a9-thermal-v5-0-892d798723e1@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHtQomoC/2XOTQqDMBCG4atI1k1JMmqSrnqP0kVMJhrwp8QiL
 cW7N0qhistv4HmZDxkxBhzJJfuQiFMYw9CnUZwyYhvT10iDS5sIJkomGVCj6bPB2JmW+lJY9CU
 azT1J4BHRh9cau93TbsL4HOJ7bU98uf4ywLaZiVNGnVSlA2krU6ir6dqhDvZsh44soUn8seJ8h
 0XC0jkLUHFeaXPEsMFijyFhhtJUHnTOEY443+Jih/PlbeWtVoW2Xog9nuf5CxtsCDJdAQAA
X-Change-ID: 20260703-a9-thermal-f62cef6ea91f
To: Guillaume La Roque <glaroque@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789022333; l=1789;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=6rWt1xIppEggcuvcPQEJmOPBQ4LH6RI7xBI39Qw2D18=;
 b=cPYPTk9cHc7HxrfdgYtSEMBIWA3bvYx2u8Gqm2NebjiOtJSvooIwvr3BHhQvQynVf4p9soQ1L
 QG9+0pEnqncD0Vi9pzyPkh982X6XnFK7ujY1u23mRAlKoMOTqhklOnI
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
Changes in v5:
- Check enable clock func returns and set the restart time of register separately.
- Link to v4: https://lore.kernel.org/r/20260825-a9-thermal-v4-0-d8fc9859cf22@amlogic.com

Changes in v4:
- Fix type error in comit mesage, and set factor valid value. 
- Link to v3: https://lore.kernel.org/r/20260821-a9-thermal-v3-0-0e7abf3941e3@amlogic.com

Changes in v3:
- Binding: add restrictive conditions for clock, and remove remove "amlogic,hw-reset-temp" property.
- Driver: add private data reset_temp instead of get value from DTS.
- Link to v2: https://lore.kernel.org/r/20260811-a9-thermal-v2-0-7ddc33b11b9a@amlogic.com

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

 .../bindings/thermal/amlogic,thermal.yaml          |  27 ++++-
 drivers/thermal/amlogic_thermal.c                  | 121 ++++++++++++++++++++-
 2 files changed, 144 insertions(+), 4 deletions(-)
---
base-commit: 78bc8af4affb9a732504eb22eeac7d1e50883853
change-id: 20260703-a9-thermal-f62cef6ea91f

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>


