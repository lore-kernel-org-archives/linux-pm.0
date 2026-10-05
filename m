Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE3941A575;
	Mon,  5 Oct 2026 22:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791239126; cv=none; b=dXjj5O+8rQf5CY5A34eK86GnQ4DV4XRHemFXaZuJSbNYA8pfED+IK9kEBwGK1/GQ4ii2OwTN2F5JyNbdPMSxWWYrxi6a5x3Y+26UdAbgCQfeypBH3oXIW3MvYKT8s8nN85QSO+i8l+s7UsSeeiai+yRJ/t6AOFPmEbRRmAzjm/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791239126; c=relaxed/simple;
	bh=WzrXr+286so0YfZSbG016gCWVzsB4SC45b59lp5A3b0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tT/CKkGopSOl69QX6Sk3XKfnqZVLlce34vnmtxIGPf6op4FkxNIEAaqy9R1knnX45m2F0GxEuWy/JBgB87wUVhDUPK79z1WyX2AG4fL8MF7CoHAlu9TFArdCQvKZWs5Yk5zIJDjeEW6TXEOcGsiol2fVgYKifRWoqLDJcYLE08w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWUFafxK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWUFafxK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDB59C2BCC7;
	Mon,  5 Oct 2026 22:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791239125;
	bh=WzrXr+286so0YfZSbG016gCWVzsB4SC45b59lp5A3b0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=nWUFafxKUzD8/ctVV82XPw3aGHVJ+nQr7FAFIVHSTNA5yLWdUGuPWPm70SSqJOw2i
	 SSSgjlxrmf7HkzIAeR79wgGi57BsFIcSkVw3I7gvdj+h3QV5N5xbh2RFYlfi54kl5J
	 gjARPfTV2d1+e4TcbI4TMdp43K+/1hBhjn7OpaI8S/IPVZYLh09tM2WhsrUWliv8fw
	 T1G58PUTgcYq7n1MfSiY/2RjJkA2RKlNzZQhzsAD4ZNltuujm22kgx8phR1yeLJGRS
	 1hTlmajw44bbw24cAPruxALOjTXyE0tm7h1fhJfrsLkfjfsHkWC6eX+q9ts3C6VCZM
	 XDIe/qmuSphiw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFE8CA5FF5;
	Mon,  5 Oct 2026 22:25:25 +0000 (UTC)
From: Serv Pol via B4 Relay <devnull+servpol.tuta.io@kernel.org>
Subject: [PATCH 0/2] power: supply: Add GL.iNet GL-E750 MCU battery driver
Date: Mon, 05 Oct 2026 22:25:23 +0000
Message-Id: <20261005-gl-e750-mcu-v1-0-499d2e31f786@tuta.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANMjxGoC/yXMwQrCMAyA4VcpOS+QFRbBVxEPLk1nRKu0ToTSd
 1+nx+/w/xWKZtMCR1ch68eKPVPHODiQ6yUtiha6wZPnkWjC5Y56mAgfsmJkYpHAHFSgF6+s0b6
 /2+n8d1nnm8p7X0BrG4WdAFhvAAAA
X-Change-ID: 20261005-gl-e750-mcu-f606ccd66dec
To: Serv Pol <servpol@tuta.io>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791239123; l=2347;
 i=servpol@tuta.io; s=20261005; h=from:subject:message-id;
 bh=WzrXr+286so0YfZSbG016gCWVzsB4SC45b59lp5A3b0=;
 b=g1cfgCZEVYxe8JiPEhW94zSLAkO7/Oz0lis/SpvzZSQKH1xfjdpzoUlyKcR0qFy0PJrJJmJ4W
 7XsfAhHUXF3A2PuZA42QMlWhZ/NkC18+UL5cymZmZwfLwODwTtD1XVa
X-Developer-Key: i=servpol@tuta.io; a=ed25519;
 pk=2HCjaqYjXxgwTYu30Nem9DOHT8mtKgjitt1vEXKpwrE=
X-Endpoint-Received: by B4 Relay for servpol@tuta.io/20261005 with
 auth_id=1120
X-Original-From: Serv Pol <servpol@tuta.io>
Reply-To: servpol@tuta.io

The GL.iNet GL-E750 (Mudi) is a battery powered LTE travel router
(QCA9531). A microcontroller on the SoC UART drives the OLED status
screen, monitors the battery and watches the power switch. The host talks
to it in text lines of JSON; on request it reports the battery state, and
when the power switch is turned off it sends a notification a few seconds
before cutting the power.

This series adds a binding and a serdev driver that exposes the battery
through the power_supply class and shuts the system down cleanly when the
switch is turned off. The screen content (SSIDs, clients, cellular state,
free-form vendor JSON) is deliberately left out.

The board itself is supported by OpenWrt (ath79), not by an in-tree DTS,
so there is no in-tree user of the binding yet. The OpenWrt side is at
https://github.com/openwrt/openwrt/pull/25649

Testing: OpenWrt main with kernel 6.18 on a GL-E750 V1. Battery
properties read back as expected (capacity, status, temperature, cycle
count), the module was unloaded and reloaded repeatedly without
warnings, and turning the power switch off logs "power switch turned off,
shutting down" and leads to a clean shutdown before the MCU removes
power. On this tree: checkpatch --strict, W=1 and sparse builds, and
dt_binding_check are clean.

Tool use: the driver, the binding and the changelogs were written with
the help of an AI coding assistant (Claude, claude-opus-5-5), based on
the vendor protocol description at
https://github.com/gl-inet/GL-E750-MCU-instruction and on traces of the
MCU traffic on the device. I reviewed the code, tested it on the
hardware as described above and am responsible for it.

---
Serv Pol (2):
      dt-bindings: power: supply: Add GL.iNet GL-E750 MCU
      power: supply: Add GL.iNet GL-E750 MCU battery driver

 .../bindings/power/supply/glinet,gl-e750-mcu.yaml  |  37 +++
 MAINTAINERS                                        |   7 +
 drivers/power/supply/Kconfig                       |  13 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/gl-e750-mcu.c                 | 352 +++++++++++++++++++++
 5 files changed, 410 insertions(+)
---
base-commit: 5c1c602463d597c5189ddc5a73dece588ba2c57a
change-id: 20261005-gl-e750-mcu-f606ccd66dec

Best regards,
--  
Serv Pol <servpol@tuta.io>


