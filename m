Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243D0446047;
	Mon, 21 Sep 2026 20:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022796; cv=none; b=CHyStavt9GGwTLJxo70K9tdx19VsVC2nwl1LJQX8upvqqKbGIcnO0Y9GGc0rLtZ+haPUxGH7T2+gFM110bEi1yElxzuzkxz0/Qc1zwxvNQs95Ra6BmiLR8m92RJZHWkiFKplWtSZW3arpx8xftG9+djeTuuaZ6X8kQ2NmSCA8jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022796; c=relaxed/simple;
	bh=Y2I7vCNExECwOXoayJrB0wiZpZqDSSU8P2y1UKi5Yb0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RM3lkgvmqEPfXua0r5cf6Bz0DO+7nYRFfno6J7XlhycGc1YUusRx1VZWMSE/ozWZFrnGYEwAvs0PBTJprdyb7NNhAyk0ad0+z8LOw0JEZcmD6+/2EY6nUiLdVBdIHgje7APbfTkrwoFDo2wTJSZJ1oW+eyMjUHoL7BcF2ljOJw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ma8IV8WM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ma8IV8WM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790022792;
	bh=Y2I7vCNExECwOXoayJrB0wiZpZqDSSU8P2y1UKi5Yb0=;
	h=From:Subject:Date:To:Cc:From;
	b=Ma8IV8WMKMH+ib6pPa59xr4eqDVc3GMOyx+ho/RNfk+VqFqIiIWvRv087CjXN18eB
	 TqNyGUCqZgZUBtpFRq2K50HfIkXFGkBQv4GeukaPKOVMCu4cz8xp9qXFdUO6DXlgze
	 g1xBmeVoS5+tp5lnVd69XkaXWeWlakuWxS6WBm/ub9fJUuDKOcLlm76GenU9ID8Vkj
	 Oj3+bSUqZVH5ABNs3x9Mx4T3/Fm8nKxaX6tqofRyJo1MXM5CzMPSF+Ud+F0QMxE02U
	 zcZEoHTafKqByv+hJbX5d/qQrSxXBu/O1n/q+1Cbvi4H+HBEtwvOJuZA0ck/hlTKZA
	 krwjg/zhLHunw==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3D7EE17E0104;
	Mon, 21 Sep 2026 22:33:12 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id E8F9E48002B; Mon, 21 Sep 2026 22:33:11 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2 0/8] PM / devfreq: rockchip-dfi: cleanups
Date: Mon, 21 Sep 2026 22:32:43 +0200
Message-Id: <20260921-rockchip-dfi-cleanup-v2-0-43ff34ac8599@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0Jm7ZhCTE1deQ/DYhimMoqUtEA0h
 LsLeACXL3n//RmSRJUEl2yGKJMmDd0KxSEDbqi7C2q9MhSmsMblZ4yBn9xoj7VX5FaoG3v0QmJ
 FPIljWKd9FK/vPXsrf5zG6iE8bK3NaDQNIX723ynfvD8XU44GT94YcmeyjuyVQ9tSFSIdObygX
 JblC/0TMTnOAAAA
X-Change-ID: 20260917-rockchip-dfi-cleanup-feae6eefae9c
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2112;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=Y2I7vCNExECwOXoayJrB0wiZpZqDSSU8P2y1UKi5Yb0=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqxlHfqKO/2pN/JvmX9JE5b+1S7bENphHyLk
 2q49h4tYveZLokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqsZR3AAoJENju1/PI
 O/qaMXUP/RjAjLOld60tYvyBtU98oEZLq4QKaahyomw107LJJwa0apBR84srWcmq5HRMw2CRIjX
 RzEEGZAkhjfCc8HTP3W9aMzDeCNU+ly0A2u4jkI2tuKqgdLmw/mOLJMFjs/YJcBh+tu/dHQHc0E
 csso8EQfaDTtPLYG7EW0DeYE4A5szhv8tSetdc8qlqV73LbV/ngP7K4xUteDhq9+NeHU+1FZKTA
 9OpcPx2LG40nAYlfFdP9xOxMDabm7RPXYWozvnbw4Pj7mk0S/fHOIk9pOpWhM2PI4CF37rTkZCr
 S+3WsUezMpXXJ2UlE11zfG0UmcdvT6yocmx8KD8mJu+jq8ddTNQnBhXQ/9QGSGht9HDoXUAzNHh
 dBhaBAEPgIvcrCO5/MQ9G4km6nBpWk6UsSSM47PieDDl3Pq9GStNjjBGWrud7CYtWHR1Ohf9FVc
 ONpwPKM51mX/kolV6jKcNB+xAvz5oPrJ+wKrFv5rvmkuVdD6IPRW+n5tunwxfVTlpUr6oXenLO5
 rpIzkOQo9ERYeRJ75serWVnFfei6RbbS7lkiQ+fdP6Ra2ZVr3BmGRZ8a3/ukpyjfpsJfqfZRXbM
 DklaKgLM9tAIaEfjpBZloq2N+O0ZD6//y2TnDQdlzvk4WIUqkcFOfW9I1wC7Z7nDdPN9AyN4Qsn
 TRU/b2hXUP1bMaoQQRKEwtw==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

This adds proper handling of the RK3588 clocks required for DDR memory
monitoring, which involves adding them to the clock driver and the DT
bindings first. The change is done in a backwards compatible way by
marking them as CLK_IGNORE_UNUSED and using optional clock get in the
DFI driver. The series also applies a few cleanups to the DFI driver
while at it. This is done in preparation for RK3576 support, which
will also come with some DFI specific clocks.

As everything is done backwards compatible, patches do not need to
be merged together. So Heiko can take the Rockchip specific patches
and Chanwoo Choi can take the DFI driver patches.

Changes in v2:
- Link to v1: https://patch.msgid.link/20260917-rockchip-dfi-cleanup-v1-0-4f00a97a69a6@collabora.com
- DT binding: Do not specify maxItems in the generic part as it has a list
  of items
- DT binding: Only set minItems/maxItems for specific SoCs

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Nicolas Frattaroli (8):
      dt-bindings: clock: rk3588: add PCLK_DDR_MON_CH clocks
      dt-bindings: devfreq: event: rockchip,dfi: add clocks to rk3588
      PM / devfreq: rockchip-dfi: move to per-variant const structs
      PM / devfreq: rockchip-dfi: add NO_INTERRUPT perf capability
      PM / devfreq: rockchip-dfi: use bulk clock APIs
      clk: rockchip: rk3588: add PCLK_DDR_MON_CH gate branches
      PM / devfreq: rockchip-dfi: make RK3588 use its clocks
      arm64: dts: rockchip: add dfi clocks on RK3588

 .../bindings/devfreq/event/rockchip,dfi.yaml       |  70 +++++++--
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      |   4 +
 drivers/clk/rockchip/clk-rk3588.c                  |   8 ++
 drivers/devfreq/event/rockchip-dfi.c               | 160 ++++++++++++++-------
 include/dt-bindings/clock/rockchip,rk3588-cru.h    |   4 +
 5 files changed, 184 insertions(+), 62 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260917-rockchip-dfi-cleanup-feae6eefae9c

Best regards,
--  
Sebastian Reichel <sebastian.reichel@collabora.com>

