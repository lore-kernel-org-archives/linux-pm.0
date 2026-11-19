Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795073046;
	b=omiOV0MNmkyzceEb32wyo3dvIT11ub9lB/6nAOMoM/AxCTEVKl4aoTDafxZJiu7VAe81
	 UqqayLMbb/ajrG9kSziifKXKDGy9FQDJvUmJ5OxbfIYbFqmWO/QcWPLs9jaHxHEO09tYO
	 M2x3N/67gAvg73KVbYf4040bzkabGmW30xhS/tjLWJD0ssEyWfEReBt+oJHhMF4cLDbOI
	 inpretFxfU6Wv+COJP8i7NP0NsrruIQQ5jxMkfx31yZsVnyt8yyn4CoLA6xU6IFIIxQB5
	 neg2hJB4iIINHbttJFPNVUjs2aM5NinUvxPD++R3JS7f2GnwDpGOgf7QXZzwOZLWVyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795073046;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+UKs5NAMHUL1PNxzeJvtVdqVZH7QVnwoIxqZhZzacDU=;
	b=AEGPTxWvkZdMQ0gf03uucdPbILsLPpbSdXksxzPhoWA6tFGdticzmc8ShKjf/RUTidG3
	 AC4lGtZRCJAtLTJAzXggy1tVsXTURqEunfjjkSMV09QPuEVxhZCvjOOZLs4V/0f3Iew+Q
	 TullUb9cRxc3XMj76fLrHID7Ogs+Ul6gjC9gMYa/KJND3Tcv22sn0pPfWQogdGK+ypYJq
	 D6yLvPQzQng2hSBNyqyrJXN2/HHzdv5jUwX7B6yRt/PBkzxXb8/736khjWnKAnff6fN5q
	 na1Vtg6HdUkrqKOEO8p4bfuTG1CX8h7s1MPCO4D6CISU8yACVQ/r/3m49YskAeSsLZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AdtSz/xl";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B9060A260F;
	Thu, 19 Nov 2026 07:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AdtSz/xl
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795073046;
	b=lmuataKnqoVUJfAqlMJDmAUek4FyWGfIxJRPzNDqx5yrEoPaT19bAIqqoOe8VzDlQxv+
	 ejJ64tMiPk21FdcLVPUEp1IdrNJv8goMO1jjMrcKHCIHu05V1ESC5dpx10ZOCQUzJppPU
	 oMn7Dcwwyi0SfmWvDk3Zf2Jk5WkaQoXzhdvVwejcCbyAWCn88VUSdqyvmGQsvN+0rjb1Y
	 CTGEWAcoP2LfpZBqEVGQEAJJW9Z6x6BzVRO2EN3xUrHk68kj+SGsROH7lXSeGBubGP40R
	 2aWpeX0LZNjxHF6NKCQDymPQ99HS6frzATcNH1nJBmlshaPoPmIz4Pa7KIfK7oc88Iw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795073046;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+UKs5NAMHUL1PNxzeJvtVdqVZH7QVnwoIxqZhZzacDU=;
	b=o2WsVsDcygVIMQKYi22w0pqCJ6vPIGOrWUCiRSHqLG1gpKIMmbC/mOOD6wq1V0rrGphx
	 28vk1YTx/s4WKfQ2kzdJno3FQsgD3CGo15N3922H6DSXe+2WedJImUbIluvzyIuCJkymX
	 vUGdV1+evo66BqKx374MO3Azw/gPXtPW1UNgpBQyzi38RkpmiYhYByQJDlagHuCiYjXEg
	 mxR4L7JU8WjlW/8hws5LkfAaVP7LDH0IFsO8l6dY6Nf4hbKXc9yudUa/iHbKO1YGooler
	 SU77+mEqtStttrRg0Nat0nsE12c9b1BqJ5BjI6HufLneZLb4pm9TOxafCrMDJ9V4v/g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 899211F000CB;
	Thu, 19 Nov 2026 07:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795073046;
	bh=+UKs5NAMHUL1PNxzeJvtVdqVZH7QVnwoIxqZhZzacDU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=AdtSz/xlJp6y2L9Mdt/rFPamt7g4B3um82fGnJU7sYwJiH+u6pzdYSitK4i8vBKRq
	 WdArI6oAbwDhUrYPTnQ0Ar2NP6d0nQ8IM6aRaW6B4qsMbfZjhbaexFoJlBRNKWfli2
	 rZswUv9hjksdtvTQJ8Fg3GvRutYpqxY4tSyPzr6HXMXBYXK617vNb6zV/pZRB8wZtb
	 mxIfVpFpGfnBJSDxPEGvzm2pWVWaZOUghOtxpcy2oEtZutmLaE95bqhOyQexHYdT16
	 MAFJGEe8USL7WNlgnNkLrho13zLxKSPLFhOvO6TdyN+gI+DO4oq2nBu8uzNORFNuUo
	 CCixDIrB9Bvww==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1A78D4B16D;
	Thu, 19 Nov 2026 07:24:04 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Thu, 19 Nov 2026 07:24:00 +0000
Subject: [PATCH net v7 4/5] net: phy: run a postponed PHY interrupt handler
 directly on resume
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
Message-Id: <20261119-b4-phylib-mac-pm-irq-v3-v7-4-d8b8f43b5a62@iav.lv>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3045; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=tJFrw+ovxezOqGpL0LoRv72fnj6/k3KLfaKIS2eufrE=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFn/lgheOZp26InOlJWbDth7snB+mqMZq/nFLK7vXO8xm
 +n+AZeWdJSyMIhxMciKKbJMOKRxK2PJ1b/+HuYPYOawMoEMYeDiFICJNC1l+O8n8Mjrbl6XUsGW
 nwxm8mE7823umj54aM+bnWC7pebsw32MDF/z763VlrhzKnnd7aszfxw53jRPWbtK3ZM15PHxFss
 pX7kB
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Transfer-Encoding: 7bit

From: Igor Velkov <iav@iav.lv>

mdio_bus_phy_resume_irq() reruns a postponed interrupt with
irq_wake_thread(). A PHY interrupt behind a nested threaded interrupt
controller, such as an I2C or SPI GPIO expander, has no interrupt
thread, so irq_wake_thread() does nothing and the postponed interrupt
is lost: the PHY keeps its status latched and its INT line asserted.

For a PHY without MAC-managed PM, mdio_bus_phy_resume() calls
phy_init_hw() before the rerun, and config_intr() there acknowledges
the latched status in drivers such as realtek. A later patch brings
PHYs with MAC-managed PM under postponing, and stmmac, for one, does
not call phy_init_hw() on resume.

Call the PHY driver's handler from mdio_bus_phy_resume_irq(), as
phy_interrupt() does, unless the PHY has freed its interrupt: on a
shared line irq_rerun outlives the free, and the handler would run on a
PHY with its interrupts disabled. Hold irq_pm_lock across the call and
around phy_disable_interrupts() in phy_free_interrupt(), so that the
free waits for the handler, as free_irq() waits for the thread.

Fixes: 1758bde2e4aa ("net: phy: Don't trigger state machine while in suspend")
Signed-off-by: Igor Velkov <iav@iav.lv>
---
 drivers/net/phy/phy.c        |  3 +--
 drivers/net/phy/phy_device.c | 13 ++++++++++---
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 92ee4651bdbc..6cc94b525e09 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1516,9 +1516,8 @@ EXPORT_SYMBOL(phy_request_interrupt);
  */
 void phy_free_interrupt(struct phy_device *phydev)
 {
-	phy_disable_interrupts(phydev);
-
 	mutex_lock(&phydev->irq_pm_lock);
+	phy_disable_interrupts(phydev);
 	free_irq(phydev->irq, phydev);
 	/* free_irq() shuts down a line left without users and the next request
 	 * resets its depth; mdio_bus_phy_resume_irq() enables a shared line.
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 2d2058c29f30..8bc394ff7d2d 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -355,12 +355,19 @@ static __maybe_unused void mdio_bus_phy_resume_irq(struct phy_device *phydev)
 	mutex_lock(&phydev->irq_pm_lock);
 	if (phy_interrupt_is_valid(phydev))
 		synchronize_irq(phydev->irq);
-	/* The PHY may have fallen back to polling since it disabled the line */
+	/* The PHY may have fallen back to polling since it disabled the line,
+	 * or freed its interrupt while another user keeps the line.
+	 */
 	if (phydev->irq_rerun) {
 		phydev->irq_rerun = false;
 		enable_irq(phydev->irq_rerun_line);
-		if (phydev->irq == phydev->irq_rerun_line)
-			irq_wake_thread(phydev->irq, phydev);
+		/* A nested threaded line has no thread; we run the handler */
+		if (phydev->irq == phydev->irq_rerun_line &&
+		    phydev->interrupts) {
+			mutex_lock(&phydev->lock);
+			phydev->drv->handle_interrupt(phydev);
+			mutex_unlock(&phydev->lock);
+		}
 	}
 	mutex_unlock(&phydev->irq_pm_lock);
 }

-- 
2.43.0


