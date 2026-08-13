Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6292E06D2;
	Thu, 13 Aug 2026 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786617978; cv=none; b=iinQIoaZYalQMimAcpyxyPl6MDxniMYG9yuZuM2zhTp5YT6YrY8Hd/RqQulQPVtV8sqMK8zL9esifGWBB7BfoYHd3BtxNsAV/Hi3M5b73SDXpFYBBe7ENTTabUHb94GpgaX8J8NArpmPcIxxxnESi7GFit1YjbhHRek0DbW3azQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786617978; c=relaxed/simple;
	bh=bZJrmEZb6liar96FiaNWKIqjcCpMMnt2beImueyvzt8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oiMfrkpzFSdJe0KHxzdMg8r+AqbJANunAHCLV9lJQJPeByTlTWd+D/HiF9zDyDYsRfwOdnhsk8ILh2KVLAaTPOOLoLeqbEqtHTdyIPS1HDJVpWlKbcc2lwHxrrVP/9r1hn69sdI9CEbajEUl1IUZqflYogWhcUbg5aZrEsnOHGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fzym8odo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fzym8odo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9171DC19425;
	Thu, 13 Aug 2026 10:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786617977;
	bh=bZJrmEZb6liar96FiaNWKIqjcCpMMnt2beImueyvzt8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Fzym8odoZYZ+Ex2m+MWVf4cglX1NuCAfFFUJttoYm+1+xgVpsI6p4SMFJMkgpFxky
	 sSgl5ODpI8MAxqM+xQsUD54CqRAYnLg11E9Hqic3oaARhrPLFxy3RfBCdeXOpJu/vg
	 78WgryX6aIKb3Qgw8HWvnB1n6mMnACCv5JSMkViwSQJtfbJD4vbfqOHxogkWCYPfMg
	 kmpVaXQAc/NLCwC7cOT19bvXYNIRmogwWDBZiTzj188ur4jtpMPHfg0XH9lW4qJCkY
	 pZ8K+QamzUMmU7PkuHBfvKsCXg/IWbLSYs1D4uLXbasNOz2fpvPDeBKrcwTwlpij6K
	 umHEjY6bSRYDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6838DC5B572;
	Thu, 13 Aug 2026 10:46:17 +0000 (UTC)
From: Robin Snyders via B4 Relay <devnull+robin.snyders.xyz@kernel.org>
Subject: [PATCH v3 0/2] power: supply: qcom_smbx: add SMB5 support
Date: Thu, 13 Aug 2026 12:45:40 +0200
Message-Id: <20260813-submit-qcom-smbx-send-v1-v3-0-27be0091d7c7@snyders.xyz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42QS24bMRBEr2LMOmOQ7OYvq9wjyKLZH2sWkuyhL
 EgxfPdwZMCIsjACcFME6nVVvU1d10X79P3hbVr1vPTleBgCvj1MvKPDk86LDD0FF5Ir3s/9te2
 X0/zCx/3c9+0ydz3IfPZzqsRqlHzNeRr251VtudzQP38NvVv66bheb5fOfvv9D+h4bjZVTmzkA
 9CPfriKrv3xcv09bdhz+BsVvkCFDRUdtmK1Gck96v0j8qovr2OE00fu6ZlOvBsTjEWkUGVDaFG
 jEiek5Ggki1q5ulJcY8s13Kp/ukRBoWFFqwkx1q0GMhlDCkyuYQmlMMZ/XFFDIGeaWWKEjJacZ
 A7cPKqA2GiA6tq9qyoNuEcXtGZJBBoh1aaMSQy1SgMJZOneFROUVp1n8S5nMKpYYnLRCrYQyYu
 UkKjg5mrUdR7DjoHHudqgsBAYMpZRrDE6Ay4q6rODOCJW8zCmff8Dk5i6fWcCAAA=
X-Change-ID: 20260811-submit-qcom-smbx-send-v1-69acefa61977
To: Casey Connolly <casey.connolly@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Robin Snyders <robin@snyders.xyz>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Joel Selvaraj <foss@joelselvaraj.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786617973; l=5892;
 i=robin@snyders.xyz; s=default; h=from:subject:message-id;
 bh=bZJrmEZb6liar96FiaNWKIqjcCpMMnt2beImueyvzt8=;
 b=XJ8GrM1rlpOQL/IS6GUvw13On72SUeLdqRBylwQ8dKEVO85KtAAWC59iSZP7ZspgpQ8tlAI2w
 PH6JE6v+ugACxyYQL79mgFy5TXFkgWsWc3QW8mX8FFHdyXhMFUizGLs
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
PM7250B as PM8150B-compatible in the binding and let the compatible
fallback select the shared charge-parameter block, including the +0x08
effective input-current status register. Convert the SMB5 0.2 V/A USB
current-sense voltage measurement to microamps while leaving the SMB2
current reading unchanged.

SMB5 setup suspends USB input and disables charging before configuration.
The power-supply registration init callback programs battery limits and
completes final input and charging setup before device_add publishes the
properties, so public callbacks cannot observe partially initialized
hardware. Managed rollback restores the charging state before the USB input
state; if charging cannot be restored, USB input remains suspended. Managed
teardown cancels status work before unregistering the power supply.

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

The v3 implementation was tested on a OnePlus 7T Pro (HD1913) with
PM8150B. Register reads confirmed 4.40 V, 1.50 A and 500 mA limits. A
180-second guarded charging trace and a subsequent 600-second runtime
trace completed with health Good and the input current below its 500 mA
limit. After a physical USB-C disconnect and reconnect, USB networking and
the charger recovered automatically; a further 60-second trace remained
Good and below the input-current limit. The final kernel log had no SMB5
warning, error, oops or lockdep report.

The driver builds with LLVM W=1 and passes Sparse. The binding passes
dt_binding_check, and both patches pass checkpatch --strict. A full LLVM
Image, modules and DTBs integration build completed and booted on the test
device.

Signed-off-by: Robin Snyders <robin@snyders.xyz>
---
Changes in v3:
- Complete SMB5 input and charging setup in the pre-device_add power-supply
  registration init callback instead of gating setters on a driver-specific
  probe flag.
- Register the power supply and initialize managed status work before
  requesting IRQs so handlers cannot observe an unassigned power supply.
- Let PM7250B match the required PM8150B compatible fallback and remove its
  duplicate match-data entry.
- Collect the binding Reviewed-by tag.
- Link to v2: https://lore.kernel.org/r/20260812-submit-qcom-smbx-send-v1-v2-0-f504b8f9bfad@snyders.xyz

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
 drivers/power/supply/qcom_smbx.c                   | 744 ++++++++++++++++-----
 3 files changed, 601 insertions(+), 168 deletions(-)
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


