Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF343839BE;
	Thu, 30 Jul 2026 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400501; cv=none; b=qAwqPP5prKiPqwxWjc1S1TN8Ji8UgnBpqL/vnDRZbvDBhhdUm7z0k+TKc0j1fRG8a9iQ5olJM/vIyZjU1eU4NqdG1XNMMtDi+BSq+v12sRYfLzNw37kEogR9oOxGblgW8Vn3BKNWaWTMxuez0rHN0CSfpyHDjIUcYGuRsEyGGLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400501; c=relaxed/simple;
	bh=tqNNorQu+sVU/SRTxPnEuAnWC1OAYWnTv5IKxYETbdY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WKLw4UbRtElVVtQE9aK37QL6cXI6ZlsF5miHoCLBzYH6Org1nR7Jo7YUNC31KTIdAv3OpUM0fORLpnFZtxoS3wNCbzqxcmCY2Ndul+pZ1fJRjRXQFZAa/R5rBbcZ7tcjnqgWg1ZY7lNYsYjkj8YLh67bxWV2w60BFs3u8w2wpVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLQqx7wy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLQqx7wy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5A00C19425;
	Thu, 30 Jul 2026 08:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785400500;
	bh=tqNNorQu+sVU/SRTxPnEuAnWC1OAYWnTv5IKxYETbdY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=vLQqx7wyv3WkKDeVeNCadJvh4NijkhLwKfBego7cH9yjRcP12ixBZL5m8zaOXGZl8
	 S0cPT7nvRSxNdaHDodrhdiX5Z+l1a1YxBSyRlvmhf4jturcCDSIriCFZF3iSu0GUrc
	 IxsC1Pf10cwLcLJkMA7HqPRekEvY3Hi6I/6Til6/fPBdGcBNwIGFcbaWB4kNvBEw+k
	 +ZDh5AD/FDPo8c3mZwHQ+sk9JURd9iJ2yB4mjv0Fof5hF01akkSmfTxmtTHPDTRC7q
	 WoTcmS/LvXFqUvsQ9TJA0q5SP+IaLnPDChCXejExrAdUV1Zv/H4VFsuiEH11ASRMcH
	 eylUwjCWJcGHQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B868C54FD2;
	Thu, 30 Jul 2026 08:35:00 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH 0/2] thermal: Add support A9
Date: Thu, 30 Jul 2026 08:34:36 +0000
Message-Id: <20260730-a9-thermal-v1-0-d786d37cba58@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJwMa2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwNj3URL3ZKM1KLcxBzdNDOj5NQ0s9RES8M0JaCGgqLUtMwKsGHRsbW
 1ANm31zhcAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785400497; l=708;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=tqNNorQu+sVU/SRTxPnEuAnWC1OAYWnTv5IKxYETbdY=;
 b=zfcjrasq1supGoSg8xxlaLxkPsPhAg/bR6pml9gzIrTqZuvFw1bGiE3hGpkiOHwRZuJEqkqFY
 UMM2Yhe1IteCihCIk7+PgVcD/7XLZzozJiCoS4DBbFXurW2AQk5ESr6
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
Xianwei Zhao (2):
      dt-bindings: thermal: amlogic: Add A9 thermal bindings
      thermal: amlogic: Add support for A9 thermal controller

 .../bindings/thermal/amlogic,thermal.yaml          |  29 +++++-
 drivers/thermal/amlogic_thermal.c                  | 107 ++++++++++++++++++++-
 2 files changed, 132 insertions(+), 4 deletions(-)
---
base-commit: 78bc8af4affb9a732504eb22eeac7d1e50883853
change-id: 20260703-a9-thermal-f62cef6ea91f

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>


