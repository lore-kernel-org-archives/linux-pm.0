Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BC7485924;
	Wed, 23 Sep 2026 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790164366; cv=none; b=MSaoUFWzwu7IsYDq/xocoAV/ui6ycHBTJS6EKVLueW9jOnBabqSkMSqxbrv5JhvP1+u/V2yHNdFcAh9vh4bi2BNalxF6KhXaQ3k/zDfsFzw8ncjtVazFOAt4Irlvk8Bb5vtesmbT1rdA3qw3K0x5ctVuCwsqDEJkZnwMgov32OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790164366; c=relaxed/simple;
	bh=mNVNZhOFGrZFEhWuUYugPaoxFl6qri6EXLAgumV6vFE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a0+kQ3hvgA9TRVBattTG0ly/DxXGXOxnTKra8YFewLByf1HxcpP0I7sO51kD4cP7+VFTNlIf81vu2V3obDbSRKsdDhlvgRqllo1gdqvYFEeOsqW8fS4WPjm6Bp/Ocx8UM7fBvW8cDP3UU+aZO9oE7hpNG4WORt6VkoFtOiJBH9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSZIDe0H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSZIDe0H"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA7DAC2BCC7;
	Wed, 23 Sep 2026 11:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790164365;
	bh=mNVNZhOFGrZFEhWuUYugPaoxFl6qri6EXLAgumV6vFE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=VSZIDe0HAE9QN8v+7cJQczstQQoQDrTsyLDhhvGoaK+1JEGl//aHAwdqTwmPI2Z0R
	 +hd46AuMa0PQLRW4v5u7e7B20hMeje8wyCN7OB6KQnMd6/mgYO4V9Hy378X1hARELU
	 cc8glrLb3lkDV0cwHMoTgEaspwCDYOzahad9axw74AlpIuDqx/wjqsFb5cVqHY5OyJ
	 JutYjihQ703/jPNkV3RuiYW9Pxaq0GKggGE1BVYvfbVI+fx/A+9lQPQBbBv91/4gzN
	 rU8DGaEa5wpf3kea3XNA0Cyz8+RztbeaRwO/FS3w0uEu+41scaEY1idnKXO6BXvgGG
	 SSdKWrJXqOkOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85733C98309;
	Wed, 23 Sep 2026 11:52:45 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Subject: [PATCH 0/2] Add bus clock for t7-thermal sensor
Date: Wed, 23 Sep 2026 13:51:01 +0200
Message-Id: <20260923-fix-t7-thermal-clock-v1-0-7d4c4682f182@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7bkGlkvpKdDDbcsksNCKI/p50H
 JiZBxJFpgRd8UCkixPvIYMsC7DOhIWQp8yghGpEqxTOfOOp8XQUN+PR+t2uKGtpxDhXumoIcnp
 Eyt6/7Yf3/QBuLdd2ZgAAAA==
X-Change-ID: 20260922-fix-t7-thermal-clock-151a0bf4746e
To: Guillaume La Roque <glaroque@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, linux-pm@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1539;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=mNVNZhOFGrZFEhWuUYugPaoxFl6qri6EXLAgumV6vFE=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ9bmvWUcTfONOQ+JLFLVT/w7Z84cqUi9afNTTVhWX1p8s
 9flSqtDRykLgxgXg6yYIkv/XMsT7y4fPfN1j3oKzBxWJpAhDFycAjCRtVkM/yu4g61POIqx7ja/
 4fWg3maegO/iK2s3VS2XWB1nPUdnaybDX4Euvuq/806cm/jlLltPcmHG1HZzu8JeQw63i2FdhbP
 m8gIA
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

The t7 thermal sensor requires a bus clock, gating register access to
the sensor, in addition to the functional clock that is already
described and shared between sensors on other Amlogic SoCs.

This series first extends the devicetree binding to describe this
second clock, making it mandatory only for the t7-thermal compatible
so other SoCs are unaffected, then updates the driver to use the
clk_bulk API instead of a single struct clk, so it can transparently
handle however many clocks a given compatible declares.

`dt_binding_check DT_SCHEMA_FILES=amlogic,thermal.yaml` is ok

  CHKDT   ./Documentation/devicetree/bindings
warning: python package 'yamllint' not installed, skipping
  STYLE   ./Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/thermal/amlogic,thermal.example.dts
  DTC [C] Documentation/devicetree/bindings/thermal/amlogic,thermal.example.dtb

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
Ronald Claveau (2):
      dt-bindings: thermal: amlogic: describe bus clock for t7-thermal
      thermal/drivers/amlogic: switch to clk_bulk API to support multiple clocks

 .../bindings/thermal/amlogic,thermal.yaml          | 29 ++++++++++++++++++++--
 drivers/thermal/amlogic_thermal.c                  | 14 ++++++-----
 2 files changed, 35 insertions(+), 8 deletions(-)
---
base-commit: a8c591ed6b672915e0be57843f943a2a723aff40
change-id: 20260922-fix-t7-thermal-clock-151a0bf4746e

Best regards,
-- 
Ronald Claveau <linux-kernel-dev@aliel.fr>


