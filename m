Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9C42248A8;
	Tue,  2 Jun 2026 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392126; cv=none; b=r0zvbKI8nDxJXJ0KXIex48E04IF0GeZ342cYElSneUNDAccpO+ruYyoCH/BPy95uUTb3UMmePk+EnhiNtUEjYsnTQTT0Y9H5Hb093N0ycYYIv96buMqJ/3TtLpc/EhLjIk1kamvxYJSq5DMfX6v+dNYpk1WK7vib6ntWt6aogVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392126; c=relaxed/simple;
	bh=e1GXYkTT+pNj3iFhoK0cj3JzERHnPLixrXmlDzP0l6U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N4j3WaneHD4RGDDlndekno1QA4erhcGQX3aysOQ+pyXGGKz+nbNC9CoPwlrmADKnSWYasmrqEzChz4CntZtBWmR5op0WLdUl3Th/4aYIKTp8oMXIhhG3PFomMHk3XKCn2u3rXczgsP+w3Y8/WsSze+o/w9Wm1/KRqSU9644ASXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yoseli.org; spf=pass smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=H10NT0uq; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="H10NT0uq"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 127D53EBB2;
	Tue,  2 Jun 2026 09:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1780392116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U5SXVWru94nUnp1CxWlF/p9xFRwMGpNSwle5C6hnRNk=;
	b=H10NT0uqx8sfBkd5XcWHFX4tW7yPnSfwPF3O1cDEM9aQGruVe28BmKsmnbXF4KuYu0yLLr
	ZqWNcscyeo9lEnNYXNrW+qc7ls1FzQs50OwhP4qWJfWJ+YftrXQeknUiP9CU2o7oWZRcbq
	Gp1nuAI/B+gnaLhsZhxB954vt/BRvDZ1BZAGqYJxtZL+Ogvgb8BWxu/ANFpOR/iHzzY9mR
	4aH3LKyagd50OwHshh/bK+WzTr69+dR5crH7Fry3GLsgIUyMv6ngYyB0bDmvst1aiJaChr
	sL0ZsHJ7oWgn9y+eFPlaVd4lz32vDT98WcBZbmYJxhXOEm3PkFrnFFujT/N01Q==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Subject: [PATCH 0/3] Coldfire m5441x: add RCM power-on reason driver
Date: Tue, 02 Jun 2026 11:21:20 +0200
Message-Id: <20260602-coldfire-rcm-power-on-reason-v1-0-fbc3eab0c016@yoseli.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJGgHmoC/yXMQQrCQAyF4auUrA3UqVbxKuJizGRqRGdKYlUov
 btR3+bxb74ZjFXY4NDMoPwUk1o81qsG6BLLwCjJG0Ib+nYb9kj1lrIoo9Idx/pixVpQOZrfLoZ
 uEyknHzgxKmd5//jj6d82na9Mj68Jy/IBVLFtToAAAAA=
X-Change-ID: 20260528-coldfire-rcm-power-on-reason-7a234acfdddd
To: Geert Uytterhoeven <geert@linux-m68k.org>, 
 Sebastian Reichel <sre@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780392115; l=1785;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=e1GXYkTT+pNj3iFhoK0cj3JzERHnPLixrXmlDzP0l6U=;
 b=eJEvwhIBLJINlRUreB9w86XTeg1Y4fMFCCdupTXDcuaxZuqJsPsPoqPp7iNSU+I1UxABBR8Az
 4JNEZVPcc9SB0Sa+jeNXQRWsPd/X2UYlzqWZ3QH5FDjIoTBeWEfhGfy
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org
X-GND-Score: -100
X-GND-Cause: dmFkZTERJZFZG6+u01DQBF/5oB/s72cTyoFPjAkymOgoT3NvTUx8ajzasNraN7wtgfqvI3erxTM2Qrgx0Z1Ra3y7tSaVnMoykRU+PW6XxhrR0+TLtTyhk15VOxJ/96svHu73Dqke3IMgvs0NuwL1mp67Bpb7K1Vf0yGqLQkaGMY2XdLo9bJVjxXefIhLRwELgNzDxtTaemux2ACLL5huo72fW6Vv5KNyoHAy+uk7zS0/iPhjLPZ1nUeajnqFlPxzoMPxTf68K8gJ7Alsoa/XIyDG74WU+alICr/KO7Mrx2CHGj996iE46BB6UJuFG7bGkAuXDWswLkyD9+rwmq7dfQZ2yn+1YZ3EDWSBiiyVfldmcXG7G6sUtHJTI67zaG+SmID4vsRmKMKj/crn3sVgMbyciq8kVm387wqt/J05An6nReaMWJnidtaMtfIRFy+ECyh3VbLeJwnutttDzDp7QEnXghSCovVaOoRQ/vWNoe/baKgiAqS7+D131xLjxwDAxgRf7Frx2gBeemLbCI6KpM3+tdBRA1my+yhhfUgF1HSIQOt2ozXfo6+UrE7TbbKHvYBlwPaE9VRnrpQMJa57SpDi0yoz4R9gICNlKVJMlHAEaT618G8xYW+ePWbc7MWtpzJHfYG6G2TtS8IFHdGFoJqYHsPCgXrgeybygFQqGNWrBs4/DQ
X-GND-State: clean

This series adds a power_on_reason driver for the Freescale ColdFire
MCF5441x Reset Controller Module.

The MCF5441x has six documented sources of reset (power-on, external
pin, software, PLL loss-of-clock, PLL loss-of-lock and core watchdog
timeout). They are latched in the Reset Status Register (RSR) at
0xec090001. The new driver decodes that register once at probe time
and exposes the result through the power_on_reason sysfs ABI.

Patch 1 adds the missing RSR bit definitions. Patch 2 is the driver.
Patch 3 registers the platform device at the SoC level so every
MCF5441x board picks the driver up automatically.

The driver is scoped to MCF5441x. Other ColdFire variants document an
RSR at different addresses with different bit layouts; covering them
is left for follow-up patches by anyone with the relevant boards.

Tested on a MCF5441x board: after sysrq-b, the sysfs attribute
reports "software reset".

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
Jean-Michel Hautbois (3):
      m68k: coldfire/5441x: define RSR cause bits
      power: reset: add MCF5441x RCM power-on reason driver
      m68k: coldfire/5441x: register mcf-rcm-reset platform device

 MAINTAINERS                         |   6 ++
 arch/m68k/coldfire/m5441x.c         |  25 +++++++++
 arch/m68k/include/asm/m5441xsim.h   |   7 +++
 drivers/power/reset/Kconfig         |  12 ++++
 drivers/power/reset/Makefile        |   1 +
 drivers/power/reset/mcf-rcm-reset.c | 109 ++++++++++++++++++++++++++++++++++++
 6 files changed, 160 insertions(+)
---
base-commit: eb3f4b7426cfd2b79d65b7d37155480b32259a11
change-id: 20260528-coldfire-rcm-power-on-reason-7a234acfdddd

Best regards,
--  
Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>

