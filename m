Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E029325706;
	Wed, 17 Jun 2026 19:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781723868; cv=none; b=ObZeADAFvV9g3OjQLb6/5ddNqUSgNDmgLeE+26FRG1JMra1IMPci1jwSENUrDjfEVQ9PKXTI2c4LYDtlHAOBuUFnIWWlktXbs4bAhMqWxPsE3AqUl9jsz03+AXRmXH5+ipeeSjDRS6Ucm4NKO3Sc4MGZVMcUDbyuCx3GQixQp08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781723868; c=relaxed/simple;
	bh=Of4R770ajDIBLQ5dbRsMHxJ1bjyShpkj+PhbrJGtpfk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ofN+pm9KRTSK1vRPT9EiNK2zprDc6UuyLMoCyQ4V6kGR72z0oyxxfH1WgvQ7kAKJQs//1VIm7xjuKuQ5mI5DREY/w2D5oLZgJscQUqVfGkydwKKqTfyDfU/+UXBtQEyGBfWqlMnIAb1HOZsINRWXgBlsuEG/GvSxmy32pzFFQjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yoseli.org; spf=pass smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=GV4DwLiq; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="GV4DwLiq"
Received: by mail.gandi.net (Postfix) with ESMTPSA id B3D9A1F75E;
	Wed, 17 Jun 2026 19:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1781723857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=43fD8iKDBSjlAZ9YGTAyJDWElv6tw1Gvg/cf0TqoPWo=;
	b=GV4DwLiqw11C3ZrqzK3KN/3u5gMhZ5Yy2a2vIv2+Klkkh9zuT+f/0Z98TwztUqm0usSO81
	GEfQ4Y3bfem0JcdFoXf9xf6I9aOBohQT77OJeblcTdEFHpbz01kRVMExmd15oKkBkqrrTr
	wqF07cScJYfoFUsq1tx2pJXrUxwfYjxglGjshis41Hg3yeKRKAcOx5rBn9xcgfLhRDjSaf
	iiXqNMOIvd1Oxh22mDlMbocs/IEDC3E7P32gNF/JOKZHrlAwNzRh8S8ZvvBTLayv6wJaqC
	DH4DvcbAgFvL8UUjuE1k3raxLMZXxS6q26ZZDhuPNEz8GSKm1trstSHga1+4Nw==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Subject: [PATCH v3 0/2] Coldfire m5441x: add RCM power-on reason driver
Date: Wed, 17 Jun 2026 21:17:14 +0200
Message-Id: <20260617-coldfire-rcm-power-on-reason-v3-0-1a7c7b6b14e7@yoseli.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALryMmoC/4WNzQ6CMBAGX4X0bE1plR9PvofxUNoFapCSLVYJ4
 d1t4aIX3ctmki8zM3GABhw5JTNB8MYZ2wcQu4SoVvYNUKMDE854xo68oMp2ujYIFNWdDvYJSG1
 PEaQLL5dcHKSqdTgSFANCbV6r/nLd2D2qG6gxOuOiNW60OK19n8bdlsoY/53yKWW0rpQAWTHF0
 uw8WQed2VtsSGx5/mnL/9h4sGnGRKkLWaZQfNmWZXkDA9fO3CkBAAA=
X-Change-ID: 20260528-coldfire-rcm-power-on-reason-7a234acfdddd
To: Geert Uytterhoeven <geert@linux-m68k.org>, 
 Sebastian Reichel <sre@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781723856; l=2448;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=Of4R770ajDIBLQ5dbRsMHxJ1bjyShpkj+PhbrJGtpfk=;
 b=u4ELC+Wuo0d1wP0LajiiaQ4zNClB/SSQOTyXFpkOtJu9IhA53wiWjAAf5+Qt34PaQjETrE8BH
 9dz6JORPwBkASuNCSuGcfM3JhOFvFn6QAI8YGJo+aW8zerx/4o/+WQS
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGOR8stWSSPcaGHwEkRQwaJF7rDC6TQ90tr6zawngVo8UQseClUNHpQ3ZNvChjbDJTRly3gXQSf7X6daENlvWpFkX5jXl8RS+bKN/ng70JGPBjkL4b5Kq2ZqCiKqafMSesfK+PvHwbW8lOmjK2weuND/L1soYrTn293SB+llRdvxswX3cLujzZWu1Z4KDQf24y1GwOOF0iQuz8epk84R2jBOWu7YHNQkgptQjd9dSzhbTKv41Zthlw+t6cmbaHhskSfJ0vPNCjRSw5hRRjo9P/bQMbSPsOFU7JV4+f60IftAo9nISVCbxj3o8j3YkY8n1RD3iZs6kBkRq6w+NLVMOzJHwKQugbgw5Baqh023XnaOHJaVSKUcrmqhYbDTy4fhTYW9YUWMpnXuYq4fUaMHl+fshlKAE+DhEZqjRq7Eqv8XtE/l+ENZRmDA/Qk3d5ZvoBovNty67ZMghf4JKtn83B8LxZviGGFEsePbhi/fvdn0Lz26r/Rkf6COmE2Eow7ZV6pocvj/Le4/XJqvekPFsZSgzB/SC2lW/x+lu4sqFlMnydMDIySdVaxzB0VNbJDVof9o/T4IoBAy29HKyEOO7BpwgVf8XaV44zllyXXMFgb6Q4/i8qPdZazJOl1DDi4tG/6zBhy1eJNFr1CYYL+tCPysoPqo9vbSwJtoPyu+pOnTg

This series adds a power_on_reason driver for the Freescale ColdFire
MCF5441x Reset Controller Module.

The MCF5441x has six documented sources of reset (power-on, external
pin, software, PLL loss-of-clock, PLL loss-of-lock and core watchdog
timeout). They are latched in the Reset Status Register (RSR) at
0xec090001. The new driver decodes that register once at probe time
and exposes the result through the power_on_reason sysfs ABI.

Patch 1 is the driver. Patch 2 registers the platform device at the
SoC level so every MCF5441x board picks the driver up automatically.

The driver is scoped to MCF5441x. Other ColdFire variants document an
RSR at different addresses with different bit layouts; covering them
is left for follow-up patches by anyone with the relevant boards.

Tested on a MCF5441x board: after sysrq-b, the sysfs attribute
reports "software reset".

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
Changes in v3:
- power: reset: drop the redundant driver_data initialiser in the
  platform_device_id table (Uwe Kleine-König).
- Link to v2: https://patch.msgid.link/20260607-coldfire-rcm-power-on-reason-v2-0-d0039d8a91e8@yoseli.org

Changes in v2:
- Describe the RSR layout in the driver instead of a separate m68k
  header patch, so the driver can be built with COMPILE_TEST.
- Allow building under COMPILE_TEST (depends on M5441x || COMPILE_TEST).
- Add a platform_device_id table and drop the now-redundant
  MODULE_ALIAS (Sebastian Reichel).
- Drop the standalone "define RSR cause bits" patch; the layout now
  lives in the driver. The series is two patches instead of three.
- Link to v1: https://patch.msgid.link/20260602-coldfire-rcm-power-on-reason-v1-0-fbc3eab0c016@yoseli.org

---
Jean-Michel Hautbois (2):
      power: reset: add MCF5441x RCM power-on reason driver
      m68k: coldfire/5441x: register mcf-rcm-reset platform device

 MAINTAINERS                         |   6 ++
 arch/m68k/coldfire/m5441x.c         |  25 +++++++
 drivers/power/reset/Kconfig         |  12 ++++
 drivers/power/reset/Makefile        |   1 +
 drivers/power/reset/mcf-rcm-reset.c | 126 ++++++++++++++++++++++++++++++++++++
 5 files changed, 170 insertions(+)
---
base-commit: 979c294509f9248fe1e7c358d582fb37dd5ca12d
change-id: 20260528-coldfire-rcm-power-on-reason-7a234acfdddd

Best regards,
--  
Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>

