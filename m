Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161EC59573A;
	Thu, 17 Sep 2026 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653862; cv=none; b=pW9pFxuE6Tq6nQ8XZvwCAUoaD1TvOTvWocJ4BXpyz8vPzHqPIoUABcHk63wWmoR8ux31YAyezJRHRu4nLSypO6DBk32qrzdsyj8a0NHRRh2vffNLjHybe+B8KC5Ga1A9YlKNEQYCyPimG2MS/73h0gHRmA0idPluNYIayDz8qmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653862; c=relaxed/simple;
	bh=XMqmUd5Y7r4JbNwH0fPb42wgk+lVAsI+SdPtkCnCQGw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AxSba1bYbJtQ43AFOKvx32zPdBc06NyTPmTSHR/vxnmkVqka1phl5TcqdIcZtz/TMXTg9nUwukae/Dvoi7QMeZjyycEYvdPZJH7ETFgMtKHWeV68qKqNXldChcaQ7p9wHdM9HqCIPaUW0/kUAYFXcOcjcPDG/3DFnw7x11nePNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Wjav66K6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Wjav66K6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789653858;
	bh=XMqmUd5Y7r4JbNwH0fPb42wgk+lVAsI+SdPtkCnCQGw=;
	h=From:Subject:Date:To:Cc:From;
	b=Wjav66K6i6HBjkhGwoSY6tBCvvsz0v55HZsN5vRsjt6dGFPdnrsjL6FUVa7u/77VM
	 OYITsrexZaqu9oScrv+BfBl3UaNY8HR898sIZG/lHq/NlUo/O9+E9ceOKqVeWvuKrV
	 HVEKgfXVJgDC4Qro5fXme0u2EYxyl1M/dXUBj6Y3d2lWlezSp4mWZPwlPIxpHk0Pcy
	 avfX41se9QrRWVclilcuThtsvG6d9AP8HiG+f/oP+E2d9Z5L2aJBXaeyQxxSmD5QUV
	 +JZ1bQ8MIB5OK/k+pVQSQLykfjQNKuYifdpwvXW6UXRFM4DdLcXmchqdnl8b07H2Je
	 DhRs7KR+Xiy+w==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2BB5B17E01C5;
	Thu, 17 Sep 2026 16:04:18 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id E2C9D48002B; Thu, 17 Sep 2026 16:04:17 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 0/7] PM / devfreq: rockchip-dfi: RK3576 support
Date: Thu, 17 Sep 2026 16:04:06 +0200
Message-Id: <20260917-b4-rockchip-dfi-rk3576-support-v1-0-a5752a29f7bd@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNSw6CMBQAr0K69hn+lV7FsCiPV6korS0QE8LdL
 WI0LieZzCzMk9PkmYgW5mjWXpshQHKIGHZyuBDoNjBL47SMq4RDk4Mz2GOnLbRKg+uzgpfgJ2u
 NGyFXaXkqUKqWKxYi1pHSz/fgXO/sp+ZKOG7Vj+HoMYXzuGu/sYi+278n3kgOkwVFkkoiJalCM
 SdbrZGeAM39rkcRzfyYgcOE1ev6AtRw1w7qAAAA
X-Change-ID: 20260917-b4-rockchip-dfi-rk3576-support-4f2685cafd7f
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2120;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=XMqmUd5Y7r4JbNwH0fPb42wgk+lVAsI+SdPtkCnCQGw=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqr82ECbuCO31GVnL23XxB8v35D97QVmgeQm
 bK8epTHzTxvsYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqq/NhAAoJENju1/PI
 O/qaP18P/Asagdp74HEz0e4SooV8lGiCaCtUnbXh/QrhvKb531Li7nKtQt2fx1C8akMKA+1GdOQ
 WqD9ebqwxy85MdAHXd1OiR/lmdElmFLq2FVWgRY1BwfMbqzpjwb4hyq0Ya2FiMTMTiIl6NULwWo
 avZ/KlgEqYCy1RSFa9jk2bOScRydxQaTiNQB2ZSsa7hSgRY77H8cIGLM1EWBHHb8How4F/cYBnG
 PcvLxV6he9tuafhUmvJVGIkCCtUtz368qoYFXwdhKO6EROXz731gejemJSCWi43YGVIBNfVsiLa
 ry9Sdutta53FAQpX7ROELJ+N1QD7LbSnY6EcPvlFn0YkVg4ZRGjj2Mo8svP6xr88r4hCUCR7isV
 fEduTH87yBAlrGHqw+67POQpaUgnxw6aS5gH5Jds60M/W0XAN7msD9VfZ/SDswCIrkkOviKo+jY
 jHWti4F10Os29dGDN3KDmCQi9VIvi1pxgPNgkm6avoPbyeDeVsVPfxIWN8WGfVcAOLu2WTaLSrn
 S30dyLOqye7muMTGzEBlCFhi1ddStSSfMXkVMlZuq6/yautbj80cNMDuePhPjAv47peQZoVSRzY
 2/2NDutEWMgvOWjzhjPv54b+YzAeGekr2fePUhfl5UcK7/7F9H+kcr/UL8ta2Q6JI8Wr241sIAn
 WSzbis8ui4Z/qnk62RNQvAg==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

This adds RK3576 DDR perf monitoring support to the existing DFI driver.

This series depends on the cleanup series adding RK3588 clocks together
with some general DFI driver cleanups:

https://lore.kernel.org/linux-rockchip/20260917-rockchip-dfi-cleanup-v1-0-4f00a97a69a6@collabora.com/

As RK3576 did not yet have upstream DFI support, the clocks are
considered mandatory for RK3576.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Nicolas Frattaroli (4):
      dt-bindings: clock: rk3576: add more DFI clocks
      clk: rockchip: rk3576: add missing DFI clock branch
      dt-bindings: devfreq: event: rockchip,dfi: add rk3576
      arm64: dts: rockchip: add DFI node to RK3576

Sebastian Reichel (3):
      PM / devfreq: rockchip-dfi: move register offsets to variant struct
      PM / devfreq: rockchip-dfi: prepare support for v4 DDRMON
      PM / devfreq: rockchip-dfi: add RK3576 support

 .../bindings/devfreq/event/rockchip,dfi.yaml       |  23 ++++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi           |  11 ++
 drivers/clk/rockchip/clk-rk3576.c                  |   4 +-
 drivers/devfreq/event/rockchip-dfi.c               | 136 ++++++++++++++++-----
 include/dt-bindings/clock/rockchip,rk3576-cru.h    |   6 +
 5 files changed, 146 insertions(+), 34 deletions(-)
---
base-commit: e5e04726cdd043e309677071ab1b65a4b18f422b
change-id: 20260917-b4-rockchip-dfi-rk3576-support-4f2685cafd7f
prerequisite-change-id: 20260917-rockchip-dfi-cleanup-feae6eefae9c:v1
prerequisite-patch-id: 9b56fea3de6c3cf86c5bba33be03da8fabe4ab11
prerequisite-patch-id: 93d4cfa6b59cb5dd07ad8ad5d123bd2cac61e7ff
prerequisite-patch-id: 85ff85240fb912a93e1a306cdd6e75416b156a2f
prerequisite-patch-id: 0551828c703b115f8e240ee69ebc0065f5a53536
prerequisite-patch-id: ad55ffe5e8ff53fb7088aa3ecfcd00bb1d67b80b
prerequisite-patch-id: 2af929c305fc289aaf52d437c7ecd5a471a00465
prerequisite-patch-id: b7f769793ec072640d6672d0b9297ad940af3b9a
prerequisite-patch-id: 2c12b9645664ad5a5822a2a858652363e01067cb

Best regards,
--  
Sebastian Reichel <sebastian.reichel@collabora.com>

