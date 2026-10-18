Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6BF4D4889;
	Sun, 18 Oct 2026 21:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792358155; cv=none; b=qkHu8RmA+D2WQZIzfcgjnzsoQjiDoFD5C1Xa5kd1+71CXc8ojb9L3b1Iij2MrpG4v3KV7s02ly+Ri07nSGfFd0T1ZlerqjCK8ir5ZbKpZukespBIhZl9fnBgc2rP+NlylS7B83e/0EBP1fcSYNVnP0EOrkr3yQUK95iMBwqM/pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792358155; c=relaxed/simple;
	bh=SHrvdvbxCKtRIdlifie6qEUHDb0k2UQIfxEZWKPC62g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cgiZNO5q/O+6mKi0aRywMm8Ss59bwWk7mMJiky7pBzCmA6Wfpg8gRJfSF/eciIDJffYJE9d6B6tv/Vwh+EdyQV/udfJrfXRoRMSdJaGx7+rIWGVq/6ZVcBKEDLGeS/61qY9JtBFEbrBZ9XeNVUppy0lh6iGzORbu4ZEU2dyXUoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uxg9HCWU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uxg9HCWU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9099BC2BCC7;
	Sun, 18 Oct 2026 21:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792358154;
	bh=SHrvdvbxCKtRIdlifie6qEUHDb0k2UQIfxEZWKPC62g=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Uxg9HCWUUJYrOdLo6pVwOAESu5vgvo3q9LHnsZqqOurDxIspXloh9em6YwYxS5nSt
	 lhyPgG134cDR1tJNtCAKXVGMn2isPf+Jf/qPZTkNpZuj6H6W9/3rHwG6TJuV+z0Kzd
	 f99GdNTKsupq1ifLbjurzKbYXBaYlGAGpddX6C9EVd6oZ/hG6/TguFCXaSqcVhVH5Q
	 EsGV6POdmnAv3jTvK9+TmuDAGl5RfiLaSrL/ROIMqhMdPI5JrR2I0FyGhyzIH3Onqn
	 FuPAqjeWzLtG7fu4dwGYbcSIYpLKckGw7ZTr82/Fynuic8u03gwR/r6OTABbPpnDOJ
	 hCfgbLpAPz3sA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDA9CCA490;
	Sun, 18 Oct 2026 21:15:54 +0000 (UTC)
From: Rinat Muhamedgaliev via B4 Relay <devnull+rinat.muhamedgaliev.gmail.com@kernel.org>
Subject: [PATCH v6] bq27xxx: support interchangeable OnePlus 6/6T fuel
 gauges
Date: Mon, 19 Oct 2026 00:15:53 +0300
Message-Id: <20261019-master-v6-0-c4b36129721e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02OzQ6CMBCEX8X0bLXFUsST72E89GeBNVJMi42G8
 O5SCOpxduebmYEE8AiBnDYD8RAxYOcmIbcbYhrlaqBoJ00ylklWZgVtVejBU22ZqmwpSwkVmcw
 PDxW+5qDLddHhqW9g+kQnh1YBqPbKmSadOo81uv0Sl/4Nhr7z73lJFClnLT2upVFQTlmemeIAh
 heyONetwvvOdC1JpTH/YpzxH5ZTRpkGLoXgxlr+j43j+AFKnswsBQEAAA==
X-Change-ID: 20260927-master-bd0afd9696ef
To: linux-pm@vger.kernel.org
Cc: pali@kernel.org, sre@kernel.org, afd@ti.com, 
 konrad.dybcio@oss.qualcomm.com, david@ixit.cz, krzk@kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792358153; l=1717;
 i=rinat.muhamedgaliev@gmail.com; s=default; h=from:subject:message-id;
 bh=SHrvdvbxCKtRIdlifie6qEUHDb0k2UQIfxEZWKPC62g=;
 b=iBOg7Z4TxpAdOSuJt3HRuvXtiybtz8yJk/g8EgW9pH067j+70MW//oHEMpOPbET61hTGpcari
 fupeyxW2YSBDXaSd2NhcrcOHELpDkXKTUhgjVPUNG7ihFQDA1DvrXhp
X-Developer-Key: i=rinat.muhamedgaliev@gmail.com; a=ed25519;
 pk=qkYQO8LRlRErWiLzlpK8jHbRIxv8+7v06+ytcxX8mec=
X-Endpoint-Received: by B4 Relay for rinat.muhamedgaliev@gmail.com/default
 with auth_id=1072
X-Original-From: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
Reply-To: rinat.muhamedgaliev@gmail.com

OnePlus 6 and 6T replacement battery packs can contain either a bq27411 or a
bq27541 fuel gauge. The latter requires a different register map and produces
invalid battery readings when interpreted as a bq27411.

The I2C driver reads DeviceType while probing either of those compatible
devices and selects the matching profile.

The bq27541 path was tested on a OnePlus 6T with DeviceType 0x0541. It
reported 4.338 V, 100% capacity, 27.8 C, and Full/Good battery status.
Testing on an OnePlus 6 or 6T whose fuel gauge reports DeviceType 0x0421
(bq27411) would be appreciated.

Changes in v6:
- Compare the detected model with the compatible-selected model.
- Support both BQ27411-to-BQ27541 and BQ27541-to-BQ27411 detection.
- Document the pair of models checked at probe time.
- Link to v5: https://patch.msgid.link/20261018-master-v5-0-0be16441cdd1@gmail.com

Changes in v5:
- Report detected and expected DeviceType values instead of hard-coding chip names.
- Describe an unknown DeviceType as unrecognized.
- Link to v4: https://patch.msgid.link/20260928-master-v4-1-052c73ec1767@gmail.com

Changes in v4:
- Drop the generic compatible and binding update.
- Keep the established OnePlus DTS unchanged.
- Detect bq27541 from DeviceType in the bq27411 probe path.
- Send as a new thread.

---
Rinat Muhamedgaliev (1):
      power: supply: bq27xxx: detect bq27541 behind bq27411 compatible

 drivers/power/supply/bq27xxx_battery_i2c.c | 57 ++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
---
base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
change-id: 20260927-master-bd0afd9696ef

Best regards,
--  
Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>


