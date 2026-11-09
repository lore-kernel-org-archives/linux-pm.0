Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231289;
	b=ngCs+5BZ6xIv09N7alwdUZoITTWKPOBVLtEyhXs9zCvORnkvB2HcVDwgNr1H8hgJIywh
	 tUSHCdx/hTL+xSMw9IIyEz2w2BYJKNC1S66YQ2TeZL69skA/djH1WqWUmcEeYPgAb5277
	 85KKE49RMZ9cEBR8AU9Sb/ztQO77cbvjRan6KONrvn6kg6QGn8ir+ntTt9lfA1C2UOcf4
	 QbKLnkOJgyun1+jbl7B9wtmX/rovM5siWmJ3Pc7dcEuXEKCFut6Vbswrv9KkX7mRGD47f
	 t+bt6xpFdFSrONTl5IkJioB8007r1m4kaZanQjLJtbKxOeHARjOubZzgpyucw4HQ7yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231289;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=bLTVLaYmd+3brYW+1go1QiKdfAq35h2s2sX2J3m0kOY=;
	b=ts1S+eNpkcHujp7RP5GvGbFkHIwbWQGcVT7RwNG30dBVAg6V6QorXt7EajKL4n8KiUiL
	 dQmjqgkAy8G5DUFZVWY0nVb8bi8K5G464veljiHtBna8wjeSWxqQ2Aicor1AuQ0Hp1qOG
	 KIZGAVb7PpTAXCV7MyBQfiiMXQwe6nFdOH20MVsa58qHmG9MZyx37SuQ8hALhFflcWPiF
	 vgMyMota0D1x/Io3Zr1CGReiO4BOqCzLVT4uLlHVAlj1u+jASusxRzE504inFb4v/WvLc
	 d17TqySaRU2fmeoVktLvWMYL5o43kGfWwkxqpUyWKYEg4MICOh3WLZ5lneUfm4Jthjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=KC6Q9lY3;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D9A606A31C;
	Mon,  9 Nov 2026 13:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27D9A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=KC6Q9lY3
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:7074:f4f4:e983:bf17])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DE696219;
	Mon,  9 Nov 2026 14:32:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794231143;
	bh=nzNUvDtlwuyAeWl2LUby0DpZ2kLSZ59ael5h29PSm1s=;
	h=From:Subject:Date:To:Cc:From;
	b=KC6Q9lY3fFxF0kOIkEbVz747sEPZJKrpgizQl9ua5iZ7tasZO1yOLZFAEhM8/kJWT
	 6bDWMryyg+CK8veXph3PFM9ZyuH9pEyjo7nFzEQRRbbNhrm7wtwdzysa1Owv6d4FYa
	 aKwZYmdVtdAFpoqPQWYp+hsumsANHrPsZcaVRKZ0=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Subject: [PATCH v4 00/13] media: rcar-fcp, vsp1: Enable on R-Car X5H
Date: Mon, 09 Nov 2026 22:34:21 +0900
Message-Id: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-0-1b2072e8c37e@ideasonboard.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN3L8WoC/43NQW7CMBCF4asgr5nKHidxwop7IBaOZ0wsQRzZr
 UWFcvcaFlUXBbH83+J7N5E5Bc5it7mJxCXkEOcazXYj3GTnE0Og2gIldnJQBnixX2coBjQkp+D
 aTlDyAt4t0FtPPKJppDeiAktiH64P/HCsPYX8GdP346uo+/oWWxRIaJxBalj2HdE+ENsc5zHaR
 B8uXsRdL/hXHF6KWEUaeUDdjZ4Qn4j6V1RStS9FXUWWLQ5SW93r/8R1XX8AkvXJQm8BAAA=
X-Change-ID: 20260917-epaul-v7-3-rc1-x5h-vsp-fcp-8afdeb2740f7
To: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
 Ulf Hansson <ulfh@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-media@vger.kernel.org, 
 Paul Elder <paul.elder+renesas@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Phong Hoang <phong.hoang.wz@renesas.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2

This series is based on Geert's
"topic/rcar-x5h-ironhide-scmi-cpg-mdlc-remapping-v4-rebased" branch [0].
A branch including this series is available here [1].

This series enables the FCPV{B,I,D} and the VSP{B,I,D} blocks on the Renesas
R-Car X5H SoC.

This has been tested on an Ironhide with the vsp-tests test suite [2].

Full summary:
/dev/media0 (VSP2-D (a)): 114 tests: 99 passed, 0 failed, 15 skipped
/dev/media1 (VSP2-D (a)): 114 tests: 99 passed, 0 failed, 15 skipped
/dev/media10 (VSP2-I): 157 tests: 150 passed, 0 failed, 7 skipped
/dev/media11 (VSP2-I): 157 tests: 150 passed, 0 failed, 7 skipped
/dev/media12 (VSP2-I): 157 tests: 150 passed, 0 failed, 7 skipped
/dev/media13 (VSP2-I): 157 tests: 150 passed, 0 failed, 7 skipped
/dev/media14 (VSP2-B): 127 tests: 116 passed, 0 failed, 11 skipped
/dev/media15 (VSP2-B): 127 tests: 116 passed, 0 failed, 11 skipped
/dev/media16 (VSP2-B): 127 tests: 116 passed, 0 failed, 11 skipped
/dev/media17 (VSP2-B): 127 tests: 116 passed, 0 failed, 11 skipped
/dev/media18 (VSP2-B): 127 tests: 116 passed, 0 failed, 11 skipped
/dev/media2 (VSP2-D (a)): 114 tests: 99 passed, 0 failed, 15 skipped
/dev/media3 (VSP2-D (a)): 114 tests: 99 passed, 0 failed, 15 skipped
/dev/media4 (VSP2-D (a)): 114 tests: 99 passed, 0 failed, 15 skipped
/dev/media5 (VSP2-D (b)): 114 tests: 99 passed, 0 failed, 15 skipped
/dev/media6 (VSP2-D (b)): 114 tests: 99 passed, 0 failed, 15 skipped
/dev/media7 (VSP2-D (b)): 114 tests: 99 passed, 0 failed, 15 skipped
/dev/media8 (VSP2-D (b)): 114 tests: 99 passed, 0 failed, 15 skipped
/dev/media9 (VSP2-D (b)): 114 tests: 99 passed, 0 failed, 15 skipped

The last patch checks the device revision and prints it, which is useful
for debugging but is unnecessary processing for driver operation so it
is marked as DNI as well.

In v3, most of the patches have become DNI because they depend on wip
cpg and mdlc driver work. The non-DNI patches are targets for immediate
upstreaming though.

In v4, thanks to Geert's new rebased branch, all the clocks and power
domains that were in DNI limbo have now graduated from DNI status.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/rcar-x5h-ironhide-scmi-cpg-mdlc-remapping-v4-rebased
[1] https://git.ideasonboard.com/epaul/linux/src/branch/epaul/v7.4-rc1/x5h/vsp/fcp
[2] https://git.ideasonboard.com/renesas/vsp-tests/src/branch/epaul/fix

Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
---
Changes in v4:
- Change the clocks in the dt nodes to use SGD1 instead of SGD4. (see
  patch 1 for details)
- Removed "clk: renesas: r8a78000: Add clock for FCPV and VSP for SCP FW SDKv4.36"
- Removed "media: vsp1: Fix setting control register by display list"
- Link to v3: https://lore.kernel.org/r/20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com

Changes in v3:
- Added a couple bsp patches for upstreaming
- Marked dt patches as DNI
- Fix some VSPD instances hanging
- Update dt-bindings documentation for the expanded module identifier
  bit width
- Link to v2: https://lore.kernel.org/r/20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-0-dbe9236bfd22@ideasonboard.com

Changes in v2:
- Add FCPVD and VSPD
- Fixed author (I mistakenly overwrote a few when I renamed my email)
- Link to v1: https://lore.kernel.org/r/20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-0-4c72d4e086dd@ideasonboard.com

---
Laurent Pinchart (3):
      arm64: renesas: r8a78000: Add VSP[BI] nodes
      media: vsp1: Support full VSPB on R-Car M3-W, M3-N and E3
      [DNI] media: rcar-fcp: Check device revision at probe time

Paul Elder (8):
      dt-bindings: clock: renesas,r8a78000-cpg: Add CPG_SGDn_VIO_DP_{TX,OTHER}
      pmdomain: renesas: r8a78000: Add SCMI maps for VIO
      arm64: renesas: r8a78000: Add FCPV[BI] nodes
      arm64: renesas: r8a78000: Add FCPVD and VSPD nodes
      media: vsp1: Add device info entries for VSPD on X5H
      media: rcar-fcp: Handle resets
      dt-bindings: Increase Renesas X5H MDLC PD specifier bit width
      media: vsp1: Complete buffers as queued in start_streaming error path

Phong Hoang (2):
      media: vsp1: Fix access to reserved registers
      media: vsp1: Fix du_complete race condition issue

 .../bindings/power/renesas,r8a78000-mdlc.yaml      |   7 +-
 arch/arm64/boot/dts/renesas/r8a78000.dtsi          | 361 +++++++++++++++++++++
 drivers/media/platform/renesas/rcar-fcp.c          | 156 ++++++++-
 drivers/media/platform/renesas/vsp1/vsp1_drm.c     |  10 +-
 drivers/media/platform/renesas/vsp1/vsp1_drv.c     |  74 ++++-
 drivers/media/platform/renesas/vsp1/vsp1_regs.h    |   4 +-
 drivers/media/platform/renesas/vsp1/vsp1_video.c   |   9 +-
 drivers/pmdomain/renesas/r8a78000-mdlc.c           |  55 ++++
 include/dt-bindings/clock/renesas,r8a78000-cpg.h   |  10 +
 9 files changed, 655 insertions(+), 31 deletions(-)
---
base-commit: 6bc45699f7eb59faccc1b0d4b40fa25177e2a371
change-id: 20260917-epaul-v7-3-rc1-x5h-vsp-fcp-8afdeb2740f7

Best regards,
-- 
Paul Elder <paul.elder+renesas@ideasonboard.com>

