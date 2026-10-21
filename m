Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792611225;
	b=oLXOX6bcV2X/8RF6NvqD1Yy4QDNhekS7UcUOeH7kJVXoLWVWKKMqRKo6AMG0vDl6oamP
	 F1U3mKPCDNAExOJdi9GfCd5KBNLHmx+M6emZYkMNmw4l2gdKTrVOlvtU4FXday+Hq5t3U
	 Zws5fDTy3t/Ig58VCRehiDeYogruB1RdxBu2ZD4Nw8vBROAZ2lAyv0pmoOiFO8BO+ZVht
	 ZX9dTwM3rckSmYbqpd2gYxGNHPK4q4GfssPdb+javB4Qfu+PLqLJUy6uQpOPCoV+TaM3i
	 vDCdopGTdSi8DjWSBo55vEeXOJU6t3awcQ4t388Ea58PoHW6zSjWWNuOwziU9ySfjAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792611225;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=NV58PQIipTGy/bSccCY0OAhOuJk1+nLO11h0vylqVl8=;
	b=C/L9hP6/unNFMAxhjy4xPgwt+GcDatvrw7du7uZ9voBjdIe+FZ57oSEbw+fcxfLk95Hy
	 QTDP1h+s2RGOtyzt0+WBxVdecX/JZCCXvUIPoV/3bvbyCvl6LnFqNyjVQ3fNIxjK5pKFG
	 IO8wNObI41zp+S32/PhrPprHyPF8mKbzGFh6Yr1XaMKxfWXORnZ8e12vJoI0w/kCOj7aj
	 6q0/zoYPc0TRvqt0YFdHIAFEdFJdx7d8TtLl2WlEI5tTq0+Egaionfb/0ME17PZfn7Bjd
	 pIOV7cbdOSadKzu6PXMNKnfjpLGZr5QjFl14v1SVfA/DeZ2m4IOESm3Uz+n7B9dZdDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a5Jb6++5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87249606A31E;
	Wed, 21 Oct 2026 19:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a5Jb6++5
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792611225;
	b=W2CiBowUjsu4qgZxmAxlYd2nwHQZ6ea3hn0/OReiWrlJgj+jqO18RG4lGkvzvsvo3qlZ
	 eruzU63dg4SAKcFXdgND1fP6GtYsR2UxQPcErpOoNIYLuo3LRxHXdgrbquekAbtlZMMjC
	 YmpiHo6Hnyn+bzPL3UVh+vp4mNpj+eWUnQ3U1wmKtUsp4LYL5DcjjS98jOMtirv1tZsRh
	 QhFg7bzFm30qX2fugJnIwFZJ3ENdJ8fwxUm6yQu2LPGmp8oTkD6cj47Y5R/Zmg08636yW
	 B9IbIvbEC9Tog53GFIQd1MdtTt5t1qK3YVbF6EUtffF7VuV5LUuMrtIvxphR2Khab6g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792611225;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=NV58PQIipTGy/bSccCY0OAhOuJk1+nLO11h0vylqVl8=;
	b=DXr+4FysssF4S7YLcoXA2aSnIWd3KhKRDaY67vSg780p5Az6/+n6U7cAqlm5ECFplWRN
	 fJQOmvAMPSS4WHj+rTtL6MoFCmUx7JSUKcEnstgz/Eemr2YBGplNzHZWrV4omM2hgADZE
	 nKIRzJkCntI3/s4f5gYOsCShoejrJUxPdt9J3pNPMluf6JX5NjVrMtn/55lpKQz6uTaAh
	 jCu0Tor8ubVOjpT33lnJXWbRgy+oclMojsmemnspRqJVDfugHl9KQ8p31yE9K2l6H+VPB
	 jaiKOrrEK/xqE34jiYAnPZen5W9fMS8WVTZFR4fhf4LtA05iIyhaC7e64PJzHC+f+aA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 401821F000C1;
	Wed, 21 Oct 2026 19:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792611225;
	bh=NV58PQIipTGy/bSccCY0OAhOuJk1+nLO11h0vylqVl8=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=a5Jb6++5cExrVwFOyH6m+d4VHHGQgAi1cEGtOJZv86qjSSCZW6FUcHf5ZEtzqFmVz
	 gyYYQCrFJNn2cA1PF4qpllRWM90Q9zxK+7SqeiihPMhS5YrPSIOJw2XDm5GfuotA3N
	 2QwMvpuECErCbfo6N7SqgK9MsvYMm5W0tYMSRl+Ugxe0JwsmMXcMmGulwCwRk6qzvh
	 Ij/PaisTgKSK5BhJ5aZGGW9OFMl5EF96jd8DXTetS/OTnp7cQSvknOALtIgWBY3+xt
	 UsmdqhBycHHgIOHequDQEiFKsBaeLSLSU3Q8nJsyST5Ei0gQeai9CgTIC6D2xDdfjn
	 QU9np9D/RJ/Gg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 941B943422;
	Wed, 21 Oct 2026 19:33:43 +0000 (UTC)
From: Serv Pol via B4 Relay <devnull+servpol.tuta.io@kernel.org>
Subject: [PATCH v2 0/2] power: supply: Add GL.iNet GL-E750 MCU battery
 driver
Date: Wed, 21 Oct 2026 19:33:42 +0000
Message-Id: <20261021-gl-e750-mcu-v2-0-9bd7e7c2e0e1@tuta.io>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJYT2WoC/22NQQ6CMBBFr0Jm7Zi2ShFX3sOwwHaAMUpNW4iGc
 Hdb3Lp8yfvvLxDIMwU4Fwt4mjmwGxOoXQFmaMeekG1iUEJpKUSJ/QOpKgU+zYSdFtoYq7UlA2n
 x8tTxe6tdmx+H6XYnE3MiGwOH6Pxnu5tl9v6XZ4kCj3VtFR1kV530JU6x3bODZl3XL7snm3y2A
 AAA
X-Change-ID: 20261005-gl-e750-mcu-f606ccd66dec
To: Serv Pol <servpol@tuta.io>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792611222; l=3137;
 i=servpol@tuta.io; s=20261005; h=from:subject:message-id;
 bh=UTjoj589VJYwISLkJrhvgw9JTnsKO/syLAvRB7fBWoQ=;
 b=WYNQ9ZC1fBbLGfWA0V/dav1NktTsJSRnfvwcBMrIny4+mPibtkF+GsSpAOKDoP1PBROTacwf9
 /Dd5ZHnFaoFAham753+6e+0W7abwOU9/a9v91oNd35QFFe8Kuq5pq33
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

Testing: OpenWrt main with kernel 6.18, v1 of this series on a GL-E750
V1 and this version on a GL-E750 V2. Battery properties read back as
expected (capacity, status, temperature, cycle count), the module was
unloaded and reloaded repeatedly without warnings, and turning the power
switch off logs "power switch turned off, shutting down" and leads to a
clean shutdown before the MCU removes power. The receive path was also
run in a userspace harness with ASan and UBSan, feeding replies and
events with and without line endings, glued together and split across
poll boundaries. On this tree: checkpatch --strict, W=1 and sparse
builds, and dt_binding_check are clean.

Tool use: the driver, the binding and the changelogs were written with
the help of an AI coding assistant (Claude, claude-opus-5-5), based on
the vendor protocol description at
https://github.com/gl-inet/GL-E750-MCU-instruction and on traces of the
MCU traffic on the device. I reviewed the code, tested it on the
hardware as described above and am responsible for it.

---
Changes in v2:
- Do not drop messages from the MCU when a status reply comes without a
  line ending: a new message (they all start with '{') now ends the
  previous one, and the poll work only consumes a pending status reply
  instead of clearing the receive buffer, so a power switch event that
  is being received is no longer lost (Sashiko AI review).
- Drop <linux/mod_devicetable.h>, <linux/serdev.h> provides of_device_id
  (Uwe Kleine-König).
- Link to v1: https://patch.msgid.link/20261005-gl-e750-mcu-v1-0-499d2e31f786@tuta.io

---
Serv Pol (2):
      dt-bindings: power: supply: Add GL.iNet GL-E750 MCU
      power: supply: Add GL.iNet GL-E750 MCU battery driver

 .../bindings/power/supply/glinet,gl-e750-mcu.yaml  |  37 +++
 MAINTAINERS                                        |   7 +
 drivers/power/supply/Kconfig                       |  13 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/gl-e750-mcu.c                 | 369 +++++++++++++++++++++
 5 files changed, 427 insertions(+)
---
base-commit: 5c1c602463d597c5189ddc5a73dece588ba2c57a
change-id: 20261005-gl-e750-mcu-f606ccd66dec

Best regards,
--  
Serv Pol <servpol@tuta.io>


