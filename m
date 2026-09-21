Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D036650B8C6;
	Mon, 21 Sep 2026 21:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790025310; cv=none; b=vEI+ykdRPnhl+HAiKVSfnnsDXp8R8Ka02sXXlfVGj8/NnMx8vxnGC9nQWr6Ciy2QQr+Dk2roZRp7fjBKVy5U/Yy1f8EDnigQkxht6GlNOc5AkA1FyyXgsb/lsJUXX9bDoIY2QebVnLcRBMM5H2XQNVqjUPN5HlwYN9sxtJkgiDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790025310; c=relaxed/simple;
	bh=uz+1Ip6QENWsADg1pboQHCC4AQH2T4g6L75Y7bdCPX4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P610FiH1Kcqk3k+bAducfR48ZeAMfamIK0u3+TRiTEwAtIuGV2R3DHXLFdEQn+GoY/DE6T1PAKTDw+qb1n82Xjm3Y6GluY1+54NhkRCk+j1Thctv09wHcxpiCDNP5GbXgheIKNN8Abipg4FZ78dFli8r177x8RiFo2GAuUlTqeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Juol2uSR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Juol2uSR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790025306;
	bh=uz+1Ip6QENWsADg1pboQHCC4AQH2T4g6L75Y7bdCPX4=;
	h=From:Subject:Date:To:Cc:From;
	b=Juol2uSR+lCANzQWFWAxlzqnzHMccXwuCD/YC5BXarLbIehH5s8EZu6KpRFt4rNWb
	 3m63oXcQqVQ2Xg/SLX27EF5aDr33uLCGDEWqZ7ptzZ9sBPSfoov0WevNIrWoFfkOWx
	 W/Fql1S2zWbKJKCsaq51EFDuDY9jR1Oiu/M3zwZfY6m6JuPqW2LilBw273ji21RZZd
	 LF+nmLVlF69juOfhP6BKkVaWxT0sPzrjOOuUKXWypZqgymHLNDukJpzA0+0e9wMbst
	 /q3fVVT3OAJbzimkY+MTesc1azSOMJ0t3br7+ttafOnL6KtNc148rL87T9xWeeCvTZ
	 YC5yWzbly04OA==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 996ED17E0C7E;
	Mon, 21 Sep 2026 23:15:06 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 50FF848002B; Mon, 21 Sep 2026 23:15:06 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2 0/7] PM / devfreq: rockchip-dfi: RK3576 support
Date: Mon, 21 Sep 2026 23:15:02 +0200
Message-Id: <20260921-b4-rockchip-dfi-rk3576-support-v2-0-04f847016321@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43PQW6DMBAF0KsgrzsROAEXVrlHlcVgxsUNwe7YW
 K0i7l5DWlXddfmlr/9m7iIQWwqiK+6CKdlg3ZyDfCqEHnF+JbBDzkKWsinbSkF/Anb6qkfrYTA
 W+HqsVQNh8d5xhJORzXOt0QzKiDzimYz92IGXyyOHpX8jHbfV7wbT+5Ll+Kj9wvmOH/aPqSfCe
 fFgCKkhMkit7pLc1noMBNrdbjZ2RVKHI7CuxCaPNkTHn/unqdqh/z6VKigBa1VLlK1R/XDWbpq
 wd4yHbInLuq5fPi4Ol0oBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2303;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=uz+1Ip6QENWsADg1pboQHCC4AQH2T4g6L75Y7bdCPX4=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqxnln2X8WMLZpbX/WOMENzlWYo6LZ2SXsiC
 jnf9ocGVQUoMIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqsZ5ZAAoJENju1/PI
 O/qaMN4P/R+I8W7SmUX+3xT7r8TMVydE2oRThJbk7gB2kYwBdrZj/4aKc4gJDvPti4f0kBrKBXm
 xB7NWy6gKf+GPuGSvQRVlyB4/C/Wx3gUmz7mtn0lbO0y/pPF72oYhiviHezGseELVUoOPUKSf+5
 e6yQjlSjX4q+wJ2eUs9uqENVjAYv1R71fkzKU4A4MR2Q8QtEDrjXZUO48PF9UjI19iRKyQynEtz
 IVGL1x/je+hZqdNlJZHdblShsiPdYpCGtNxeyuS/LQD8FvEa/+ZvmXimsI8/ec/VdnYdF2es8qM
 hQbhszEowRrRW+22Q4+qJp2NYv/iVmAXSxPvVFs0LUZne5d8wxICzNka8v6AwvsFxUxLsgh42Vr
 uexcaXN1Ly67lSyHGIPz/Sr/bMCkZdyNakLdq6HY3oIWISubi6eaCJ/QAMNIZziz0teKZhUGhvc
 9y5PH4/ukbyT+2YXn2e/ZM3oCs7kYds2Ax3ma0+8VAew5gWZaI6I+RDYxtqT/4JEzrq2A3+l0ZW
 CbevW620GKnQzn9XAXOLKK/gDUY7UrLa6c3BDCljgQPIsECOQhQ4L4riuRVr/l4/mx5Nlq6ZY9q
 0E4Ay0jxtvJbEnJqDxvvqvdPMMGgGCojgsIDZTOyDBN/zIkVz6ZFMiYvM4++BzKAQY+553ItCDn
 svbMdd3buxZJsXih+2yAyRQ==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

This adds RK3576 DDR perf monitoring support to the existing DFI driver.

This series depends on the cleanup series adding RK3588 clocks together
with some general DFI driver cleanups:

https://lore.kernel.org/linux-rockchip/20260917-rockchip-dfi-cleanup-v1-0-4f00a97a69a6@collabora.com/

As RK3576 did not yet have upstream DFI support, the clocks are
considered mandatory for RK3576.

Changes in v2:
- Link to v1: https://patch.msgid.link/20260917-b4-rockchip-dfi-rk3576-support-v1-0-a5752a29f7bd@collabora.com
- Update DT binding to just define minItems/maxItems

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

 .../bindings/devfreq/event/rockchip,dfi.yaml       |  19 +++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi           |  11 ++
 drivers/clk/rockchip/clk-rk3576.c                  |   4 +-
 drivers/devfreq/event/rockchip-dfi.c               | 136 ++++++++++++++++-----
 include/dt-bindings/clock/rockchip,rk3576-cru.h    |   6 +
 5 files changed, 142 insertions(+), 34 deletions(-)
---
base-commit: e5e04726cdd043e309677071ab1b65a4b18f422b
change-id: 20260917-b4-rockchip-dfi-rk3576-support-4f2685cafd7f
prerequisite-change-id: 20260917-rockchip-dfi-cleanup-feae6eefae9c:v2
prerequisite-patch-id: 9b56fea3de6c3cf86c5bba33be03da8fabe4ab11
prerequisite-patch-id: 6c0231d124501b5a5e09e32243e4878a606f8b8d
prerequisite-patch-id: 85ff85240fb912a93e1a306cdd6e75416b156a2f
prerequisite-patch-id: 0551828c703b115f8e240ee69ebc0065f5a53536
prerequisite-patch-id: ad55ffe5e8ff53fb7088aa3ecfcd00bb1d67b80b
prerequisite-patch-id: 2af929c305fc289aaf52d437c7ecd5a471a00465
prerequisite-patch-id: b7f769793ec072640d6672d0b9297ad940af3b9a
prerequisite-patch-id: 2c12b9645664ad5a5822a2a858652363e01067cb

Best regards,
--  
Sebastian Reichel <sebastian.reichel@collabora.com>

