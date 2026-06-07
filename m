Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF8A2777FC;
	Sun,  7 Jun 2026 08:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780822223; cv=none; b=mczClyObV/iXXRo5Wp6L497wZ+f4YKUeyQs5LShK7bzoZEwmdod9JWNzOHegYASQYOz6EPW69deFqJfx8kiI8D++osqijV2Mo3cy/Yj7Vog479/xfTlj0zHVVCv/JdtdwtmiG/x0J2xezn+klr98SLC//j4qXIwSD/7oh5WnvdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780822223; c=relaxed/simple;
	bh=7igOXwPnpOWHMqoDc6U+K4SmuPSgX7Hm0Oe1g8JwWCw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lcVN3cJPf2UAfmYYVkEwd+i047isahP4lanB9g3cF7+7BfdgdEL5VwFyhycW5/Ust21SWL7cue0bsM3KmIdSJskgN19QdhlUt6MEqHy0eZwF8zPqzkmOX7vvDYh3icuwkFU4m9PURTvw99LHyF/Qdlk/ddVj3x7j3Y7cFsk2GnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yoseli.org; spf=pass smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=B1vpY+UJ; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="B1vpY+UJ"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6BF563EBD0;
	Sun,  7 Jun 2026 08:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1780822213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lt0lnx3w5K83zsPENHH5wJBJzrlA+3l2roeV/d1OdbM=;
	b=B1vpY+UJPikZA5Nhedf8ayGxc/NZX3PU2MesP0NoX5CjUD5mX/TwujgHQgNzVPkXLNE4va
	eSX6oDzsfdxKw+d3f3lDwm9GuG06fmHBk54c3k6RFtYZNqPuvHMhzIWvhvaCes12eqVdxF
	avQpuscvsksmHuz71voSx25BD5iSP2SR4dp1swP4UCqe3Yh1m41UwsFr/ruRuBw+Vw1PZ2
	8UpdEGa9ZB/YltWQ1RLcTOH7vFJ5SP9O+EcVEQ1hFSWJ5ucxol3O2havgS1dIpbP9Hb329
	E4Hi+TCgekCr9D9qY7Sc6t0IeFhWBpSgCXHmQc04Dl7/ZrkGuOhYOyC0WBiw6A==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Subject: [PATCH v2 0/2] Coldfire m5441x: add RCM power-on reason driver
Date: Sun, 07 Jun 2026 10:49:52 +0200
Message-Id: <20260607-coldfire-rcm-power-on-reason-v2-0-d0039d8a91e8@yoseli.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALAwJWoC/32NQQ6CMBBFr0K6dkwpisaV9zAsSpnCGGTIFFFCu
 LsF9s5m8pKf92YVUAiDuiWzEhwpEHcRzCFRrrFdjUBVZGW0yfXZXMFxW3kSBHEv6PmDAtyBoA3
 xXazJTtb5Kp6Kil7Q03fTP4qdw7t8ohtW57poKAws09Yf03W3p3Jt/qfGFDT40mVoS+10mt8nD
 tjSkaVWxbIsP8SL6HXbAAAA
X-Change-ID: 20260528-coldfire-rcm-power-on-reason-7a234acfdddd
To: Geert Uytterhoeven <geert@linux-m68k.org>, 
 Sebastian Reichel <sre@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780822212; l=2207;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=7igOXwPnpOWHMqoDc6U+K4SmuPSgX7Hm0Oe1g8JwWCw=;
 b=Yr1l3gToWtPealJl6KFHCErLwB/NZJqKV1Cz9b8d9jjY3wCveCPOFAV//YVWg+MiefQ2OX2Wl
 I2q/1s9z+muAiQiQ3kPLERz6kSV6PxHZqlWVcL4xs+xBjVI1rOrNZeN
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org
X-GND-Cause: dmFkZTExTqZXNkV4RRmC7uFTkEyWgDrz8tBqxlnDCUcINRyGmeWvHH99VE61o2HkM4u76lz5azF1mXFu6unBgTGdvLGsT97wYZVN/2mWp4EvVnsVxfQSFmlE/PZ4U4Oi7T9/5BuzlRVZlypq9bHHJg6mLdV7uQwHvFtWhEWQ83reJYPnePyckgJxY8qQUsLL1jWwmMjRRC8uD/D64/dQMVVryXdUCorHWQLMVs/QV/xYYR27NCgy908JzCYVVCsWlVrbnS/nfbi10yq1PNuBSUKpUmnfdbXZSFFrGbNOjIUZEZcfavE0daV/b5/HJHHHwXbS9VfvwjoGBhjIIxMErK0xOqj5oNJEKvecyJJyhCC7Sc8BLu3IPG7s+dtmCTGiR8Yllpy8VfOtZbLBIpSREXR7A+panGeKNJFJbeV3w/DsBAcJ+vlKY96eSyrWYWeDgsr2AKVVOdJUt2v08XK9O4BILKoDwo6UzRouPUumzdYgiHA1G1SwBtTp9XVek0eTepdibi1dwB328j/gB4AzlF/kdGmkuia5O/llhLA9T89Zfcl5EuQnCKckfCw0Z8lLJ8tjj0mEtjKjXuu5i6ddyBQmhQrozhRhv22WKZaLGkfBPDOLSbAVZ5JKtOOfBo95m8jeamGvpY3AjH+iYL6cmVjJ2acBtG5MWIAhVKzy9IucmUx0XQ
X-GND-State: clean
X-GND-Score: -100

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

