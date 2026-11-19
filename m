Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795073045;
	b=V1T262/Bayd3fEHWnvPJ31ED95PawJqJt3yCfXTlF3K7VZOXSrcYnt5btHonAlnUceRI
	 FwFi0evDKfmOMKVypwSragD9Yzs6ODh3mR8gbFA1ypp7ljcqJ8+3mWMf/g3a9IdkG4QZj
	 RzPVmVBIET47VkpJoLDP2ptjt57OxA/SdcoJpdYA7/8UrrIoIfU8A84yotMM/VqOOQHe1
	 K4SxD0od4aegxkaBs/rPojcxzLiGgMNzPvU4yRuUrUmIIsGLomHpgkwVJgJHev3OJspqq
	 whqQqs2y590HkFOkGz0fDMam/qD+vI0r8M9qqGmBYUBh3MwpfHfq/gn1rsMt8YIIViA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795073045;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=/7jA1mdGjpdRHZ3a5Ter91k3t1QA732PAZu5RAALnms=;
	b=Ze1w9mjLfucHda4ZEM8DsGV5NboRHto7SoNtL2h4vGnZlEJ7mk/C0bifUsj4azz6bR7S
	 ADuylWxR0uSl2PkKtdPa8JKyJ/Nod1M4rQhVaRJsrf/Et2hVxw3TH3aRi/n4MS3Fx+byn
	 dcqIhaWOvl92i3CBIP5LBvpMNsdBu4yFOmxz+mFfII4bq8X655HXDp1uAJCRn27cY5OVm
	 i1tNfR7XUp28+ChXsqvebGJlx9RTZ0UcfWKfCo4SvihNMGQNkMl9o8Pwkq1eA76fafQiB
	 Ic8+nsq6/gdxgBGAp1h005YV7YSh+/tzdAq6BIwpYJMk34X1HAMZhyMX3XaWhPqyrFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljZAlWjZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD75606A334;
	Thu, 19 Nov 2026 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljZAlWjZ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795073045;
	b=oyIupMk56tF5ZC1P0iaGj8bptwKlBaUJxRjZk1MZZG+RaxALRE+CGHTwHp+CBjyFlY6w
	 m0lHJRSvpw79If0xWpxUbgjgBOdiLKmlyts1jeNczoxWTu0Exwfxp8RkIES3nR6g0bwDl
	 v7MkvMtwZcPN2eQXs5WkU3pHP8YsQTb0THa5DoVNAWa95TpG4EYl3HpD4UemXGDJ1ZvSS
	 +BWBcxWf0gQqElKcvWcNRZomSSUlapDpN0ggpZqH4EhJOJKmGDdnIj/urxhLDPini5M0K
	 Yi1r2X5mPmFdI10mnsLh9AF+pWc2O/drpmCvH8dFWkaNlElq7T1WTvLaoG4QgJ3D6Gg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795073045;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=/7jA1mdGjpdRHZ3a5Ter91k3t1QA732PAZu5RAALnms=;
	b=s2H8wwmMzUEvCL0KVBrj/UdtnEZyvYp3WiFTKr3B/X+YuOiBq+0nXvj8PaToV0ZYeO+o
	 XIlp9njo+B5VjrcDhYvmEP8aum2FiojWzEq8rK2hJioAGkzT8hOGVPwp76p0dXIJ53D2S
	 CBX7HzQb2OMvmlGkef9H6vhbySz8lzp7LNexyGoBaaY791vSKVaoaEbGJ9VleojQbiXS1
	 GBgV/c4/m1ej08BQ/UhRsKeD8WSAp17Stsxko3VwJ6tXHmMIqee+t+VDDwzdj65suZdmA
	 awn2hBtU9kjDurbvl2TnsEnVhCvGyvbnfxLLMmPSNqRVgXgnBA2pUeFwiCqSCl3ieRA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6DCC21F000C8;
	Thu, 19 Nov 2026 07:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795073045;
	bh=/7jA1mdGjpdRHZ3a5Ter91k3t1QA732PAZu5RAALnms=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ljZAlWjZaELtUmdrKMoiOcoEHH0iUq3qtxHAScLAtnUTNevsFvPnfqR3euUVT5V7W
	 MMpWGz7scyVEGWBBux5Ox50KcZi4EfWwimnoR/qciu/J/5KhfCwTg98XC6/EntPNKp
	 TJPDGJFlO53H4y56tDewE6X8Uk/BdJ4LqcXNECGE09+aFCffVcJLBbV32Tkqvg4JJO
	 6TfQf7n6a/jxLDyVGWnQ8fNIiAxOAucLH/ml/iNmYYL2rZauhGZRrK2QRj2x5sDhoQ
	 DCL0K3reAH5PvRjrbrWqQg7HQkVEGGJJETOQOHdkvWZ4iaNpZjpRQQadCyStdDPU1Y
	 FloSDxAI6bQvw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 015004B169;
	Thu, 19 Nov 2026 07:24:04 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Thu, 19 Nov 2026 07:23:59 +0000
Subject: [PATCH net v7 3/5] net: phy: stop postponing PHY interrupts when
 phy_suspend() fails
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
Message-Id: <20261119-b4-phylib-mac-pm-irq-v3-v7-3-d8b8f43b5a62@iav.lv>
References: <20261119-b4-phylib-mac-pm-irq-v3-v7-0-d8b8f43b5a62@iav.lv>
In-Reply-To: <20261119-b4-phylib-mac-pm-irq-v3-v7-0-d8b8f43b5a62@iav.lv>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Thomas Gleixner <tglx@kernel.org>, linux-pm@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Lukas Wunner <lukas@wunner.de>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Wei Fang <wei.fang@nxp.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
 Paul Barker <paul@pbarker.dev>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Doug Berger <opendmb@gmail.com>, 
 Thangaraj Samynathan <Thangaraj.S@microchip.com>, 
 Shenwei Wang <shenwei.wang@nxp.com>, 
 Haoning Cheng <Haoning.CHENG@cn.bosch.com>, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2032; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=+A2hLcXVzSFgT2M5CYC4xlPO/kE1CSINjgk6/JEhbKI=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFn/lghOjFq7xNrV8U3Y5A+Lrx4tsry8p7Gv1+g0G/9v4
 xaLui0HO0pZGMS4GGTFFFkmHNK4lbHk6l9/D/MHMHNYmUCGMHBxCsBEMj4x/C9L2niVU95cLkVn
 9p3ra3IXR6Qs0EqYpWfEs7ZD7S1X8RZGhnV7/72td/kZsHTxpC2dN1YEzwneln/k0py+7Pnnel3
 Sz/ADAA==
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Transfer-Encoding: 7bit

From: Igor Velkov <iav@iav.lv>

When phy_suspend() fails in mdio_bus_phy_suspend(), irq_suspended
stays set and the state machine stays stopped: the PM core does not
resume a device whose suspend callback failed, and the next PHY
interrupt disables the line until the next resume.

Undo the postponing and restart the state machine when phy_suspend()
fails. Set suspended_by_mdio_bus only after phy_suspend() succeeds.
Set before it, the flag outlived a failed suspend, and in a later cycle
where mdio_bus_phy_may_suspend() returns false, mdio_bus_phy_resume()
ran phy_init_hw() and phy_resume() on a PHY that the MDIO bus had not
suspended.

Fixes: 1758bde2e4aa ("net: phy: Don't trigger state machine while in suspend")
Signed-off-by: Igor Velkov <iav@iav.lv>
---
Haoning Cheng's Tested-by on v5 is not carried: this patch no longer
changes the resume error path.
---
 drivers/net/phy/phy_device.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index f2e2370b4be7..2d2058c29f30 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -368,6 +368,7 @@ static __maybe_unused void mdio_bus_phy_resume_irq(struct phy_device *phydev)
 static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
 {
 	struct phy_device *phydev = to_phy_device(dev);
+	int ret;
 
 	if (phydev->mac_managed_pm)
 		return 0;
@@ -385,9 +386,20 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
 	if (!mdio_bus_phy_may_suspend(phydev))
 		return 0;
 
+	ret = phy_suspend(phydev);
+	if (ret) {
+		/* The PM core skips the resume callback of a device whose
+		 * suspend callback failed.
+		 */
+		mdio_bus_phy_resume_irq(phydev);
+		if (phy_uses_state_machine(phydev))
+			phy_start_machine(phydev);
+		return ret;
+	}
+
 	phydev->suspended_by_mdio_bus = 1;
 
-	return phy_suspend(phydev);
+	return 0;
 }
 
 static __maybe_unused int mdio_bus_phy_resume(struct device *dev)

-- 
2.43.0


