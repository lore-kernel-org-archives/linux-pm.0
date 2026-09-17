Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346D05505D5;
	Thu, 17 Sep 2026 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652969; cv=none; b=okNWqi42ZpxD0nqMEBk+fS2nHdNOJS+kfEhBz6HUml1/CGybQ57AinQO7Ox/BZ54t0KlWITOdXvjkTFOlE+ojIAFLZtaYu2Cmt6oq0gzj9uUa3EgSQvKFLyh2+8cODFuHQiW5EU4q+UGCA5D09CM/4lPx3yKTuAo7GgLzsZPrXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652969; c=relaxed/simple;
	bh=3W2f0MAd/j+4iELbcrQn9aunsEIzQRT+obAqYgIAROM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=njioaXcjKaU/1+uwZRlC9uJmgR/P0VtR4/0hzMPWiFKGENhTpCU5nsE2P5YHhPyxLkelPkW+BgKRL05iXsuOqEmV7Q+C9pMhbbOuYdCKdoPwc38L5uzzg3Q/dwoPnjV4j8qe6KABA4uSUiyZXbrNIUMBdCpjPqnm/3dsgAWPrxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FTb1GP4b; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FTb1GP4b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789652961;
	bh=3W2f0MAd/j+4iELbcrQn9aunsEIzQRT+obAqYgIAROM=;
	h=From:Subject:Date:To:Cc:From;
	b=FTb1GP4brkFWQbicGPdBD4UGPyDUQUtTCq7HOTdN40XE31utUs8K72+0naAGWmWQp
	 7DjM0ZlF6xKRdeLyL9jdUDtr8rDFKNhpGf7LmaigbtTHcTu7p8YUfaWeI6ddDAQBwR
	 9vnYiylZB2SYS3+2Z4RKF9BP1lyZ7VaABQQr5XO+eXoGXKqIorBHh+8PJzzYGkkFCO
	 pt5AOFndErQYi3Q7zBriaKNMJpu9Owck2p9Fg4C9sm0wn7KRs8kz03u38Pt3ZrIKWz
	 lxGLROnJqzhZ74kzx3XbVSWcWLf7PL/pRGfKS9DKHmB0NFxlkA2sPKmLzAdAlOQUJv
	 O4f/lKdIL1/0Q==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C3BF017E0074;
	Thu, 17 Sep 2026 15:49:21 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 7987148002B; Thu, 17 Sep 2026 15:49:21 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 0/8] PM / devfreq: rockchip-dfi: cleanups
Date: Thu, 17 Sep 2026 15:49:12 +0200
Message-Id: <20260917-rockchip-dfi-cleanup-v1-0-4f00a97a69a6@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBG4avIrDugLix6FXGRjn90bIkhqSIE7
 25al9/ivUQRQRGpKxIF7Bp1dRnVoyCZjZvAOmZTXdZN2VZPDqu8ZVbPo1WWD4zbPFsYNIA1aIV
 y6gOsHv9tP9yO22uBfH8vOs8Luw4py3gAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1846;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=3W2f0MAd/j+4iELbcrQn9aunsEIzQRT+obAqYgIAROM=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqr7+G/yDfpsZ794SvTCOLXgxCZftsZzOK/G
 hPSHHcl6U3/5IkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqq+/hAAoJENju1/PI
 O/qaqzMP/2g61okvGwUd0WJq6OBMB2CN3yCavL+mEw1uNG23b3iZL3ARcMyN0xmRrhGSqidt3yD
 weVkBxPCABW1lBc5bwHvwS0ewq2LdDhKa2G6IguXm1bA1KewClmitCTfmvhzjGLWTD7/RL1PEFY
 /Anww/cvsNMY9hRUxTTcQ8Yl0j1JxSDNNlkSfYzqordRFqOfjCrwvGwZxvOf7e5u698DRVIjpZL
 cYNxckC9/Ez22IeXlNJcBlkguR4SVg543D4C5pmSQIp/r+GtiGVHDC70fv+MDGBE48dneSGaFsx
 x7L4M1kVabWVC+m9q40tEybX0dBNLFOpYKEojY7vznyWdsoaOzmEg1tijH3Z4L2z21TEGdgcX2Y
 J6x6GXKJPl6XhoJIEoJowgtYYTPf8tSm0rEGXF26Ok3DISn9LykSMkVvNUSbtrKiNuhBgRERnGq
 bGyEhu71fcVT9/a4vBkOLDExLX3lkYhV+r/o4+YSyPZ3Qjz891jOaXj1bZndhCcisjl0PuFIiPI
 SHyG3K0uhKvyXHPGqPsJMhulC349cF4z2DXMCEd0WoZa/g7CN8HQNpR9zuVwDBFJ4RBOYNq1Xtt
 7W5DhCjMFnq6Av3T/tuWfuEoo/0J9D9vKJYbWHwIQ3cDtRp+RqSO3h7tmtPry+RylsL3DMZMWlN
 IhXxrtsS2OPsqjYBsMVYvjA==
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

 .../bindings/devfreq/event/rockchip,dfi.yaml       |  84 +++++++++--
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      |   4 +
 drivers/clk/rockchip/clk-rk3588.c                  |   8 ++
 drivers/devfreq/event/rockchip-dfi.c               | 160 ++++++++++++++-------
 include/dt-bindings/clock/rockchip,rk3588-cru.h    |   4 +
 5 files changed, 198 insertions(+), 62 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260917-rockchip-dfi-cleanup-feae6eefae9c

Best regards,
--  
Sebastian Reichel <sebastian.reichel@collabora.com>

