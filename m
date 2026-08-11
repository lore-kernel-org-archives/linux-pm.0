Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9397260D;
	Tue, 11 Aug 2026 23:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786492658; cv=none; b=kNxDDzeGwc6wkMIRsstKevZQZ0caO+POYAqwwnZf5wpo7Rpi/OTLMYVf5aAjSfeJD9aI+tWt4AYwworxn1LjmN0j/NSK50EYdrrWtrM6OM9CWf7dBAyV9i42bcG/m7n6gohZLPo9eQmkd+EFxL8KZgQtdnUsVHmkb5UWfljsZQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786492658; c=relaxed/simple;
	bh=bu1PUwMeBi9XaK13bMemyTHDpDt7G/P1twcRWXJMLGw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=R3J4edUt1rl40rw9K5nC+Ze4fmIH/RxXaHK+ouNZd0TpTgAFYh8jMZYVIC/7/5pBPcZNGfc63CVzqFY3gAcr8dDAXEe3+tbg7qAEBbqfXyyrbws2LT4gxjdEOSr2IHZXSUK1bNlBk60AAED3MiUhHA0QUcouvNEIBxIjpg7YvkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKBfel2t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKBfel2t"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3AE6DC2BCC7;
	Tue, 11 Aug 2026 23:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786492658;
	bh=bu1PUwMeBi9XaK13bMemyTHDpDt7G/P1twcRWXJMLGw=;
	h=From:Subject:Date:In-Reply-To:References:To:Cc:Reply-To:From;
	b=kKBfel2tViDjqinDYI2D3ofOcnndb8jiW5W4L4JxxdABjgzis8Be4o1yUfQuh+PKg
	 ParAjfTMFbRy3F+b9bMrr8VfJQhw9USPRILUDljemit1y0tx1QfH7SnkOr+iNSVIHI
	 2tmyAAls1Il7Po+bEYG232zyJeOwyPznRoiiVlxi37zoEU7t4duciq2MFUdtRhpMt3
	 0wBhFZOwjaEp7xbgsA9VnjzPvdE9pctDtzr5ukpgkfmipvnNg+skFLAR2AabTW3+ds
	 SMfgmrYb++K3rBUXfmts3tejCC43cloe6VjiD4cfFvSkL4u5SIbZ/+yVDlqu2a2XtK
	 uTeyOi+uMCtsQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E26C5CFC1;
	Tue, 11 Aug 2026 23:57:38 +0000 (UTC)
From: Robin Snyders via B4 Relay <devnull+robin.snyders.xyz@kernel.org>
Subject: [PATCH v2 0/2] power: supply: qcom_smbx: add SMB5 support
Date: Wed, 12 Aug 2026 01:56:58 +0200
Message-Id: <20260812-submit-qcom-smbx-send-v1-v2-0-f504b8f9bfad@snyders.xyz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42QS24bMRBEryLMOgxIdvPnVe4ReNHsTzQLSfZQF
 qQYvnsoGQjgrAJwUwReVXW9L0O3VcfytHtfNr2sYz0dp4jfdgvv6fhL3SpTL9HH7GsIbrz1w3p
 2r3w6uHHoVzf0KO4SXG7EapRDK2WZ+Mumtl4f1j+fp96v43zabo+kS7j//ofpfN6ZKmc2ChHox
 zjeRLfx/Xr7vTx/fOZs+vo2m58/w5YXOvN+9n7agVRqbAg9aVLijJQ9TbukjZuv1Xe20uKj719
 KFBQ6NrSWEVO7ZyOTMeTI5DvWWCtj+odKGiN508KSEhS07KVw5B5QBcSqNVTfv1JNaZoH9FFbk
 UygCXLrypjFUJt0kEiWv1IpQ+3NB5bgSwGjhjVln6xij4mCSI2ZKt6pTkPdHHYOPONah8pCYMh
 Y52Gd0RtwVdFQPKRZsVmAOe3HHw8jCpccAgAA
X-Change-ID: 20260811-submit-qcom-smbx-send-v1-69acefa61977
In-Reply-To: <20260811-submit-qcom-smbx-send-v1-v1-0-feec6cfa123a@snyders.xyz>
References: <20260811-submit-qcom-smbx-send-v1-v1-0-feec6cfa123a@snyders.xyz>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Robin Snyders <robin@snyders.xyz>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joel Selvaraj <foss@joelselvaraj.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786492653; l=4979;
 i=robin@snyders.xyz; s=default; h=from:subject:message-id;
 bh=bu1PUwMeBi9XaK13bMemyTHDpDt7G/P1twcRWXJMLGw=;
 b=xJAPUooDQdvam6Vu0H1q02GZhKm5TsvqrMg5nvUQxYmOniJ+pGLzB3quIpGLcFtJqWJL5Blmu
 xMnIs97br4RB1PDtrSuNU8ighdSUnYOgAPwq/xMjLZsKoaedhj67IPx
X-Developer-Key: i=robin@snyders.xyz; a=ed25519;
 pk=Mdk5dNn+Tkcy7BWexDxBLR/s1BNz8WdqDPnr3qtYBIU=
X-Endpoint-Received: by B4 Relay for robin@snyders.xyz/default with
 auth_id=938
X-Original-From: Robin Snyders <robin@snyders.xyz>
Reply-To: robin@snyders.xyz

Add support for the SMB5 charger generation found in PM7250B and
PM8150B to the existing qcom_smbx driver.

The series extends the binding and selects register layouts, charger
status encodings and electrical limits from per-PMIC match data. Encode
PM7250B as PM8150B-compatible in the binding and use the shared charge-
parameter block, including the +0x08 effective input-current status
register. Convert the SMB5 0.2 V/A USB current-sense voltage measurement
to microamps while leaving the SMB2 current reading unchanged.

SMB5 setup suspends USB input and disables charging before configuration.
The power-supply registration init callback programs battery limits before
device_add publishes properties, and writable properties remain gated
until IRQ, wake and final-enable setup finishes. Managed rollback restores
the charging state before the USB input state; if charging cannot be
restored, USB input remains suspended. Managed teardown cancels status
work before unregistering the power supply.

Enable periodic hardware AICL with the downstream twelve-second rerun
interval while leaving ADC-based AICL disabled by default. Clear the
unsupported HVDCP modes so firmware state cannot raise VBUS, and do not
override the firmware recharge policy without a binding input. The
dedicated TCPM and VBUS regulator drivers retain ownership of Type-C
power-role and VBUS control.

Apply the five-patch qcom_smbx Fixes series before this one. This series is
based on power-supply for-next (99b38cda3f4c). The b4 dependency metadata
records all five prerequisite patch IDs. This ordering preserves the SMB2
watchdog, health, overvoltage and float-voltage fixes across the SMB5
driver refactoring. The prerequisite series is public at:
https://lore.kernel.org/r/20260812-qcom-smbx-fixes-v1-0-eb48246be599@snyders.xyz/

The initial implementation was tested on a OnePlus 7T Pro (HD1913) with
PM8150B. Register reads confirmed 4.40 V, 1.50 A and 500 mA limits. A
180-second guarded charging trace and a subsequent 600-second runtime
trace completed without crossing the voltage guard. The v2 corrections
were validated offline and have not been re-tested on hardware.

The driver builds with LLVM W=1 and passes sparse without driver warnings.
The binding passes dt_binding_check, and both patches pass checkpatch
--strict.

Signed-off-by: Robin Snyders <robin@snyders.xyz>
---
Changes in v2:
- Rebase onto power-supply for-next 99b38cda3f4c.
- Encode PM7250B with the required PM8150B compatible fallback.
- Leave SMB5 Type-C power-role and VBUS control to the TCPM and regulator
  drivers.
- Preserve the SMB2 3-second AICL interval and use the SMB5 downstream
  12-second interval; leave ADC-based AICL disabled by default.
- Disable unsupported HVDCP negotiation deterministically.
- Do not override the firmware recharge policy without a binding input.
- Model PM7250B with PM8150B electrical limits and the +0x08 AICL ICL
  status register.
- Convert the SMB5 0.2 V/A USB current-sense reading to microamps while
  leaving the SMB2 current reading unscaled.
- Program battery limits in the pre-device_add registration init callback
  and gate setters until probe completes.
- Order managed teardown so status work is cancelled before the power
  supply is unregistered.
- Restore charging before USB input on probe failure, and leave input
  suspended if charging restoration fails.
- Correct the SMB5 overvoltage register and charger-state decoding.
- Avoid repeated error logs when polling a persistent overvoltage state.
- Use battery-info property presence when selecting charge targets.
- Remove duplicate scaling from the already-prescaled USB voltage reading
  and clarify the binding IIO channel descriptions.
- Update the binding title, Kconfig prompt and module description for both
  charger generations.
- Move the five pre-existing SMB2 fixes to a prerequisite Fixes series.
- Link to v1: https://lore.kernel.org/r/20260811-submit-qcom-smbx-send-v1-v1-0-feec6cfa123a@snyders.xyz

---
Casey Connolly (2):
      dt-bindings: power: supply: qcom,pmi8998-charger: add SMB5 PMICs
      power: supply: qcom_smbx: add SMB5 support

 .../power/supply/qcom,pmi8998-charger.yaml         |  17 +-
 drivers/power/supply/Kconfig                       |   8 +-
 drivers/power/supply/qcom_smbx.c                   | 766 ++++++++++++++++-----
 3 files changed, 623 insertions(+), 168 deletions(-)
---
base-commit: 99b38cda3f4c486cfbc40f3c8ede1703594e9f13
change-id: 20260811-submit-qcom-smbx-send-v1-69acefa61977
prerequisite-patch-id: 3d8a9cf43b5e5eac64a60aeec5e9c90880bcf792
prerequisite-patch-id: de3e3b494f9644596cfa4cafc362ca0b48288c45
prerequisite-patch-id: d5e22a0fe7cd55374f60d7c2cb14ed3df8f94e0b
prerequisite-patch-id: 9eafa41402e97d6a3e5369bec46df4e9db3d2af6
prerequisite-patch-id: 5638b901cd10773fa9485605f84b25a1dd826a84

Best regards,
-- 
Robin Snyders <robin@snyders.xyz>


