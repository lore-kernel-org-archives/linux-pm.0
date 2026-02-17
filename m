Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF856328273;
	Tue, 17 Feb 2026 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771325264; cv=none; b=C7oskcEHLx2WIl7XiLEJWh5LJRZlVPKcSo5sqFACbCT8czUeeIvLvLjtBD77z3UHN3m47pqULzNDDLNKlmcH8YxJ/1JYMn8gH0lQZA6ibH4oSU+Hdb64R53LKIZj9WCPHGB+TYutowDtCm3KD5hLq9xfB5Zsy/Zk9771P1vUtw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771325264; c=relaxed/simple;
	bh=c6GRKyp+ub8bww9RLohGzR3byu56kw5PGCaK0azhERs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FrVJiW1IOXhmBWIIgaJaQ/4v9gRnvwfJt/j1HZ8eio/9EKjAAz/eR0Tq2YdJRpnn7uH00HB4TYUrqJJ1t/3lNepxJURdI8xv0V79ulfdTSpjg+JgrFwp8QjUy1UDltiJHZ+VL2KEwEuNlyugn+/aPIYKKvZBxYoIV7PpSdRpeg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIq6ay21; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIq6ay21"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C695C19424;
	Tue, 17 Feb 2026 10:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771325264;
	bh=c6GRKyp+ub8bww9RLohGzR3byu56kw5PGCaK0azhERs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=QIq6ay2130TVF3AdaegSvCdbaxbIVwngwbk1gDyDoWm+Iw8qWIT0hMTVUyWQUDr5n
	 ugVj16i+8kF0XXQjIFr0xAJTSSiZtu13Tsz9KU0tAW/zQevyH/HJr7DLw6LjGPOYNL
	 OEe9jSDRMCVbFcpuaOGZBl+YHddaFFflEDxTYWMnjdeN2GiMlZNOXfIdbRtauxrm//
	 xrmPaH/aKx9BmU/COylkAl7M7+izipDGChAsnyc3at7IWx3DtIUyoQY/9iZ65jxb2B
	 m1YGsapuT3MzOyYE0TSGJUa5JxsRCaQz72v1+yUMGbZgbNdVF5471i6IUB5Wi3Wlbs
	 nDtv3ZzCRO4Dg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7476AE68169;
	Tue, 17 Feb 2026 10:47:44 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Subject: [PATCH RESEND v7 0/2] Add Apple Silicon SMC power driver
Date: Tue, 17 Feb 2026 21:47:24 +1100
Message-Id: <20260217-b4-macsmc-power-v7-0-4a4d63664362@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Sebastian Reichel <sre@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Michael Reeves <michael.reeves077@gmail.com>, 
 Hector Martin <marcan@marcan.st>, Joey Gouly <joey.gouly@arm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771325263; l=3764;
 i=michael.reeves077@gmail.com; s=20260105; h=from:subject:message-id;
 bh=c6GRKyp+ub8bww9RLohGzR3byu56kw5PGCaK0azhERs=;
 b=+EKy2InD/QKU0nAyC++hiJNp5qQ1ruDm8oX7fvWp694R1Fa/WEYQrPW8YDVwPVgHloCf46eNm
 IIGwOWA3X27BrR5txas6JdNB6lyOMg9quuFgFbp1WN/96Y8r6P+5Tm1
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=QIrgWBGCm3LG0YYc6MLCDkwuVXLTGGooVBdWX/KhSiU=
X-Endpoint-Received: by B4 Relay for michael.reeves077@gmail.com/20260105
 with auth_id=591
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com

This series adds a power supply driver for the Apple SMC found on
Apple Silicon devices. This allows the kernel to report AC status,
battery charging status, and power metrics, and modify the charging
behaviour.

The first patch adds the driver itself, and the second patch wires it
up to the MFD core.

The driver is based on an original out-of-tree implementation by
Hector Martin. It has been refactored by myself for upstream inclusion,
including support for newer SMC firmwares, devices without batteries,
dynamic property detection and improved state management, among other
things.

This series is based ontop of the current linux-next at time of writing,
the exact commit hash is listed below.

Tested on: Apple M3 (MacBook Air, J613)

Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
---
Changes in v7:
- Replace emergency_sync() with hw_protection_trigger() to enable use as a module
- Link to v6: https://lore.kernel.org/r/20260126-b4-macsmc-power-v6-0-9861d4070f92@gmail.com

Changes in v6:
- Add FS header include for emergency_sync()
- Link to v5: https://lore.kernel.org/r/20260126-b4-macsmc-power-v5-0-302462673b18@gmail.com

Changes in v5:
- Readd cover subject that mistakenly got dropped, apologies.
- Link to v4: https://lore.kernel.org/r/20260126-b4-macsmc-power-v4-0-aa2a682ca650@gmail.com

Changes in v4:
- Restore Hector Martin as primary author for the series.
- Restore downstream Co-developed-by and Signed-off-by tags.
- Add Reviewed-by: Sven Peter <sven@kernel.org>.
- Simplify MFD patch authorship and remove redundant tags.
- Fix probe return value being overwritten by devm_work_autocancel.
- Return -ENODEV in probe if neither battery nor AC adapter are found.
- Add bounds check for nprops against MACSMC_MAX_BATT_PROPS.
- Refactor macsmc_battery_set_charge_behaviour to remove unnecessary resets.
- Improve critical_work shutdown flags and remove return.
- Add comments explaining SMC key firmware history and flag meanings.
- Clarify event ID descriptions and restore BSFC flag comments.
- Remove redundant dev_dbg logs for missing battery or AC.
- Link to v3: https://lore.kernel.org/r/20260115-b4-macsmc-power-v3-0-c236e09874be@gmail.com

Changes in v3:
- Rebase on top of latest linux-next
- Drop charge control threshold properties.
- Switch to devm_work_autocancel() for critical work.
- Add platform ID table and remove MODULE_ALIAS.
- Simplify property array management in struct macsmc_power.
- Improve probe error handling and device pointer usage.
- Minor style and indentation fixes.
- Link to v2: https://lore.kernel.org/r/20260109-b4-macsmc-power-v2-0-93818f1e7d62@gmail.com

Changes in v2:
- Added Reviewed-by: Neal Gompa <neal@gompa.dev> to all patches.
- Fixed Makefile alignment by using tabs for the macsmc-power entry.
- Upgraded physical battery exhaustion log level to EMERG.
- Downgraded software-triggered orderly poweroff log level to CRIT.
- Added check for CHIS key to skip AC registration on desktop models.
- Link to v1: https://lore.kernel.org/r/20260105-b4-macsmc-power-v1-0-62954c42a555@gmail.com

---
Hector Martin (2):
      power: supply: Add macsmc-power driver for Apple Silicon
      mfd: macsmc: Wire up Apple SMC power driver

 MAINTAINERS                         |   1 +
 drivers/mfd/macsmc.c                |   1 +
 drivers/power/supply/Kconfig        |  11 +
 drivers/power/supply/Makefile       |   1 +
 drivers/power/supply/macsmc-power.c | 855 ++++++++++++++++++++++++++++++++++++
 5 files changed, 869 insertions(+)
---
base-commit: ca3a02fda4da8e2c1cb6baee5d72352e9e2cfaea
change-id: 20260125-b4-macsmc-power-bb30389e05f1

Best regards,
-- 
Michael Reeves <michael.reeves077@gmail.com>


