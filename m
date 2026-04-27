Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A688429B79B;
	Mon, 27 Apr 2026 07:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777274158; cv=none; b=O9DL6gigwtda5sxPIA8/fjjK/OquD0lHBNfX2//qrP3er8kU91uvQvn2PnWVcnIll3UXKJsVIv2WeIybpA2P32RJTjtU8kd6lTqF/OQcPXmBkVwJAGx2E7C5NmxpmQH2IQql5K7kJJIWrbNwojN0Bm8GJ6eIVix2UFkXc88/DVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777274158; c=relaxed/simple;
	bh=P/tTQuPHG8NvZa6CrH2gIUjX+SxZnduY6Mz93+yekh8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lJUE0/YzSS4JG7NIkgup0e3koPRVS+AWAspX175n79j8VO+1+b55yXKQjdku11+odOobVHcOpDbzn9buRo0y2phx3fTrTYazWlVHG502oqVt+wqObFyICecDBFcRW1XjloCjw1aCZiKgrm8jzXSQQQjWGayBcdShlXb1JtiZ72c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=l6PHItTP; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=U8+R79XG; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="l6PHItTP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="U8+R79XG"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4g3vx11431z9vDh;
	Mon, 27 Apr 2026 09:15:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777274149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Le2XwzWiqwhfCfphPB8qaGdrWgXHDh5RoYZDWvPLXgs=;
	b=l6PHItTPk+9hhxYukbnDaHbFDgiNXfcCNGYQDkX1MwzDbCdzZowTsqz9HcFemhxyHjTvaV
	DMBksUY90gV9orfYZly4eyILlwUb5TMFOa3iknpLfY0CvaRELDMZ7Xe63+ULln4JZA287J
	wMRGAwcFGpS6dnc4Ucl3psK/c22H9yypcgL6EkEI/mnLfTOj/Ea56agJgE/pJzDcvE4NUL
	YChd8W7em23H5j4Mj0GhSFKzuRPtLyNVQ3jLqQxKN3OIehdGqThUVQqHg0SsUjXAhP5pLU
	peM+XHxynrnaaAOmwJjyY7CtdyKNsEsETFLL8iDbK2hoS6lAtofIiPUQzEKVYw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=U8+R79XG;
	spf=pass (outgoing_mbo_mout: domain of shuwei.wu@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=shuwei.wu@mailbox.org
From: Shuwei Wu <shuwei.wu@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777274146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Le2XwzWiqwhfCfphPB8qaGdrWgXHDh5RoYZDWvPLXgs=;
	b=U8+R79XGmUd2FFR6qIVVYLep+NgyvN8lndXNXXEEeg72ttOamPpBiHEO44ImL0NkVAVa7p
	W1qYohfgy470oc5xeDUMT1OcPJTDhvQV2QGSqZyT8LFFSw1vzinT1JJjtEGbPCND08Kdqe
	DTnP9mvpmLMd26xmvAGWRsZ4VkgonFR9Oo4GsC///Rjw0npMTxX7lYo23FDpOsDto/iDt8
	SsomAfuQfEc5s6TPGI6WWQsT0qg5s/nkdEJChaVejmFcPfND0wRS78dycSsNAC1E7WuRnC
	FzzoM2m4FCZzwZVNG3zh0yXwGcAARTkO73nW1jgUODkmSj7F7ac2gTUcv7+rpw==
Subject: [PATCH v5 0/3] thermal: spacemit: Add support for SpacemiT K1 SoC
 thermal sensor
Date: Mon, 27 Apr 2026 15:15:14 +0800
Message-Id: <20260427-k1-thermal-v5-0-df39187480ed@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAIN72kC/03MQQ6CMBCF4auQWVvTFqnIynsYFm0ZYCJQMyUEQ
 7i7lbhw+b/kfRtEZMIIVbYB40KRwpSiOGXgezt1KKhJDVpqIy/yJp5KzD3yaAfRWmWN86UzBUI
 6vBhbWg/sUafuKc6B34e9qO/6Y5T8ZxYlpFDal9emkSb3+X20NLiwngN3UO/7/gEQDkZ7pgAAA
 A==
X-Change-ID: 20260409-k1-thermal-fa1a6bc8b65e
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Shuwei Wu <shuwei.wu@mailbox.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Anand Moon <linux.amoon@gmail.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, Yao Zi <me@ziyao.cc>, 
 Vincent Legoll <legoll@online.fr>, Gong Shuai <gsh517025@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777274126; l=2057;
 i=shuwei.wu@mailbox.org; s=20251125; h=from:subject:message-id;
 bh=P/tTQuPHG8NvZa6CrH2gIUjX+SxZnduY6Mz93+yekh8=;
 b=YgNHdzLvJyPejzh7MYVe41x9bBzX5q1DIhB3k5HQw7m+23/YeAnOCYlTVI0bo1z517P3Kh0FR
 dm/b7uN448EA+zP3Khd6xeA9spphgZXO96E+oG37i9d+frYpjnnEP63
X-Developer-Key: i=shuwei.wu@mailbox.org; a=ed25519;
 pk=qZs6i2UZnXkmjUrwO5HJxcfpCvgSNrR4dcU5cjtfTSk=
X-MBO-RS-META: wtwznt6tf6zqny1hyqtetawm48ryqccy
X-MBO-RS-ID: 481a13714f42994e906
X-Rspamd-Queue-Id: 4g3vx11431z9vDh

Introduce support for the on-die thermal sensor found
on the SpacemiT K1 SoC.

Include the device tree binding documentation in YAML format, the
thermal sensor driver implementation, and the device tree changes to
enable the sensor on K1 SoC.

---
Changes in v5:
- Register threaded IRQ handler before enabling interrupts
- Clamp trip points with clamp_val in set_trips
- Link to v4: https://lore.kernel.org/r/20260410-k1-thermal-v1-0-12c87dd063c3@mailbox.org

Changes in v4:
- Add 'depends on THERMAL_OF' in Kconfig to ensure functional dependency
- Link to v3: https://lore.kernel.org/spacemit/20260119-patchv2-k1-thermal-v3-0-3d82c9ebe8a4@163.com/

Changes in v3:
- Fix indentation and variable types
- Simplify clock management and redundant assignments
- Link to v2: https://lore.kernel.org/r/20251216-patchv2-k1-thermal-v1-0-d4b31fe9c904@163.com

Changes in v2:
- Move driver to drivers/thermal/spacemit/ and update Kconfig/Makefile
- Address reviewer feedback on style and structure
- Improve variable naming and comments
- Link to v1: https://lore.kernel.org/r/20251127-b4-k1-thermal-v1-0-f32ce47b1aba@163.com

Signed-off-by: Shuwei Wu <shuwei.wu@mailbox.org>

---
Shuwei Wu (3):
      dt-bindings: thermal: Add SpacemiT K1 thermal sensor
      thermal: spacemit: k1: Add thermal sensor support
      riscv: dts: spacemit: Add thermal sensor for K1 SoC

 .../bindings/thermal/spacemit,k1-tsensor.yaml      |  76 ++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi               | 101 ++++++++
 drivers/thermal/Kconfig                            |   2 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/spacemit/Kconfig                   |  19 ++
 drivers/thermal/spacemit/Makefile                  |   3 +
 drivers/thermal/spacemit/k1_tsensor.c              | 280 +++++++++++++++++++++
 7 files changed, 482 insertions(+)
---
base-commit: 5a11253b34fde37ab9f899728bb1f7b19af5ee37
change-id: 20260409-k1-thermal-fa1a6bc8b65e

Best regards,
-- 
Shuwei Wu <shuwei.wu@mailbox.org>

