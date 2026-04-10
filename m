Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08BEEACD;
	Fri, 10 Apr 2026 03:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775791941; cv=none; b=IusslEPcoQ+Tv0pG7gv1n/sn+3aNU3ZELk3wDDyqpmkllrnWlYQ0ZoYAqIg7F2BDLf1934Pc7EEywawgtvFgsWC8zaJoqM/w6TZL5WoHMXmQprZIAzqmc45QVCVR7OeeZ18J76lKjKwTk8RzTKZGZfnLTUKymugtB4IWj7eNShc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775791941; c=relaxed/simple;
	bh=KNfrqSd7dBMSbu5friLkuT95VHDRb1Fo0ZCUFYgfUJ0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KWVw7QvT54eLiqd+IVeWbkJOkHykIkinXki+ZGTrrgDd88SjdOgpTFHXQOYSuCD6dCgLaih7AXx+SiCHhrXDW1uia63/n3LSilV5vBFjaWIzgvjFypTV18MfmrRqDuWWNTzC9iCNpEXcab6pjL+Z91Rv7/mq0tr/xrpsV65F0YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=e+k1Sd64; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=fRLQy6gu; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="e+k1Sd64";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fRLQy6gu"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fsMmp54Kvz9v09;
	Fri, 10 Apr 2026 05:32:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775791930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yhFceqNdq/8kDhJjs9Qm5Qij1KFElsM4S/RwXmu33Wc=;
	b=e+k1Sd64CLaCmc5hQ58tsFif6Rxh3o3oqvCISDa96MgCKX6VZ9z8tPbKnJaMxOSpFSIM1v
	5JZ7RDSIf7pI17TSzDdkf+yMWSUbKm0u+dmjRBjcxm4GipHswLhgNgn8bU8d70/R78iuSZ
	RwF2qTb4qY6djHHMrTHEQu263g0bSxSEmwkoocplIq6P/AXSiBNZXLJ0H0tleMwhcPTmY+
	pbEDMC/HIMZoJ9lhRURRbLwHNNOIMEKuDrMnBAeMRNaCTDAffZeNmsucqyHQrFTz4Im+no
	rByYMui0d67tZlQCdGj+DMMXh3VuEWLA2sKQzO8DZNmDyMx3YqYmFyDYy5FrmQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=fRLQy6gu;
	spf=pass (outgoing_mbo_mout: domain of shuwei.wu@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=shuwei.wu@mailbox.org
From: Shuwei Wu <shuwei.wu@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775791929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yhFceqNdq/8kDhJjs9Qm5Qij1KFElsM4S/RwXmu33Wc=;
	b=fRLQy6gu1kspa0tVFsQ7HCQfW9By6hiNVWnMVFrAvDMuyx+Nt5QnobFJhnVFq2EIrneodD
	Jh3aNGhslyyoYDeRUlh2CIn7njEaOPtDOiB/F7oLZ64khEkHAl0/tTC60qz1nes66juAz0
	Simn+T0qNMyAsDpZp2RGTHjIN1oA0RZRrdZB4MaA1UPHvInr/5lOH0BRQ458LNUHGIYrx6
	e+O9oC5vxQ3rRGWVdxA/8nXm/DDHR2NtqxmNkVv/H1EJI49WVqOS2g4bPubH0NrjIvzOYd
	OjtQYa4yHA6E7wz2xAEZabZqD9o/DipCfToOCpk2IzNCeZHSQ6dC91OBAaO6dQ==
Subject: [PATCH v4 0/3] thermal: spacemit: Add support for SpacemiT K1 SoC
 thermal sensor
Date: Fri, 10 Apr 2026 11:31:35 +0800
Message-Id: <20260410-k1-thermal-v1-0-12c87dd063c3@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABdv2GkC/x3MTQqAIBBA4avErBM0TKqrRAu1MYd+0ZAgvHvS8
 lu890LEQBhhqF4ImCjSeRSIugLr9bEgo7kYGt4oLnnPVsFuj2HXG3NaaGVsZ1SLUIIroKPnn42
 QJEw5f8kgthtgAAAA
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
 Vincent Legoll <legoll@online.fr>, Gong Shuai <gsh517025@gmail.com>, 
 Anand Moon <linux.amoon@gmail.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, Yao Zi <me@ziyao.cc>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775791914; l=1839;
 i=shuwei.wu@mailbox.org; s=20251125; h=from:subject:message-id;
 bh=KNfrqSd7dBMSbu5friLkuT95VHDRb1Fo0ZCUFYgfUJ0=;
 b=DdLNQwFKrJo/1nUc07PwhAdhZ8yW6crJnA1EhiVMlJwu3xivpeEhFhm5+EZYm1FP079E14QbB
 PMGx8sXQm9ZALdz+l6oKFSFrS02IoLc5miGfz7/71gmVY55WU5KxOWk
X-Developer-Key: i=shuwei.wu@mailbox.org; a=ed25519;
 pk=qZs6i2UZnXkmjUrwO5HJxcfpCvgSNrR4dcU5cjtfTSk=
X-MBO-RS-META: hgou37jqyiq4irhipwwpebemm556juc5
X-MBO-RS-ID: 791dd05c49e7fda785d
X-Rspamd-Queue-Id: 4fsMmp54Kvz9v09

Introduce support for the on-die thermal sensor found
on the SpacemiT K1 SoC.

Include the device tree binding documentation in YAML format, the
thermal sensor driver implementation, and the device tree changes to
enable the sensor on K1 SoC.

---
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
 drivers/thermal/spacemit/k1_tsensor.c              | 281 +++++++++++++++++++++
 7 files changed, 483 insertions(+)
---
base-commit: a55f7f5f29b32c2c53cc291899cf9b0c25a07f7c
change-id: 20260409-k1-thermal-fa1a6bc8b65e

Best regards,
-- 
Shuwei Wu <shuwei.wu@mailbox.org>

