Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795394786;
	b=bZrN6POMy+CPmssUs6tv1GBAxTMESHPVTtgh6Gm+N3BlHGVMI4bgMfX0q+J6e4PzezUS
	 OWSAFh6AnkShQlGuXufa8E3//ZAHhOMz9Y4yjG6Q1b2xullWxMaOX/QZ5LNghSHwc0j/l
	 b2y2AxupWclqfxCoeKOA45T9/39PEBPmjez8qkhBExZWyHMWDrtHySQTw8YKosjeJw8pF
	 29OqJeDKyt3K7aFrzMLZ+XDvMKhO7pvrcYHOB3JJFcqdo+m5udcTKPc+nqjf9VnUCSi39
	 uxB9SpJzLabPqOTFaz/UEGBXevE1egZyhTg6bGH8LpOoBWOXLjRx1D5kUHdISiSkdMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795394786;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=30Qu+ur/6/c1t3EoSrJtgPyjUR8t9B2zrfD9U5zhs40=;
	b=D8IJwalrQycV+eEFWju0l+R5fxWQ1ZkLIWCBpL/RlnJJvJrg799H5KxCdUlK0XICI8vO
	 ynK9f6xT4G0CqSBs2p2s+6UOBYFC1d4ySBQg6LtM5ZMg5pnIBvX5/6B/WQQJGC2TMeVCL
	 RovXruNqfnbPsCX8gpqOgQhkUCgE4qLLUEgHkHmcW2qQba03EXyOfVeANVgSEDG8DQ9HY
	 pDAMG7hyBYTyxZd9cINDRXW55VLGbcYhI0gaTNxldKZyt12/ouc/rMb4vRU6BRJuIEnEd
	 hHJ+O5OV9PDmiQ523ncXK1j7uhqILUYoMvdLCL8m5jspmXPRq2wAcH4i/gbzS/NBDbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TSiZUDA7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC92606A320;
	Mon, 23 Nov 2026 00:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TSiZUDA7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795394786;
	b=pYuCjOFFEG37yigxNJlTuxs/BsWPXvlcsc/A69ulkZpB5fZW1BNHahQ/eIaGcXRUTFxm
	 scUAHULEm/gG9fqAOu7nXvr0Ik/XMy1xdayHqkMkGKE5l3ml6E0VhqEGtPVs7J/Nz+XUI
	 UweiWLFQ3u+HmRVvD0mHQv6E6fziOtAp7VPD3Lr9LQiLfRQyj+wNqwMPqpUaxQtGCZ+/g
	 RbA0gRwzSJqPAkc3P84kPC5SFLgc6DiPOHKVWp5Nty4UHwhfRBs0HUKowi05+L7yB9pIt
	 B3w8CYfnBrWvUgx85CIRWeS57EEStqztiE3ykEowURHMrKFK9+1FvzTEoP2C+UESJuQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795394786;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=30Qu+ur/6/c1t3EoSrJtgPyjUR8t9B2zrfD9U5zhs40=;
	b=Yn99m87b/pH+wnFK3mZfeJTVa6cy28azrX0RbLAD+wDUM/IZSVW2B+EcQlUZ4oUajO8W
	 /6wa0dd+NKuQTO2+zFD/yc8y0IoZSg5Su/qvFvxl8cnfo0s9ifpD9+S4k/OgyIRPhqUm0
	 3uPEWhZrKwCaQ5vNdCSryo7Pe6TGxw17z+zV2OEOmdvCwjYvXYwF/8dU4W6YQ9pjLF3oN
	 ++iTymJxdYJQ0ZJVBpQQEADtvc/8eZ3InRqrNHWGkVVOpckKX+zYV00wlbNo3DdjbqhdA
	 FRyGv7yYoskMhul+QOVnRBuEN/EE0hbG43HN7KbVhfJ0BR8FzYFK5nHGFr+qRtpY4Kg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2EFA81F000D4;
	Mon, 23 Nov 2026 00:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795394785;
	bh=30Qu+ur/6/c1t3EoSrJtgPyjUR8t9B2zrfD9U5zhs40=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=TSiZUDA7nhQGKLHC/2/yKYZWqq9CqTzeQU8ph13qkI4iqkJfdl2nlO0EHYu39Kgpk
	 kezVVXpNITlgpWAmP++H0MSgwO4WKU9SMSw+P99h9rrzuEIUuNllFOncylZI7BGMuc
	 4UHKUxK9vHmlvgY+vGBaOFVgukcTFReOIsUytysrFAM5/eVaIEv72Bo5B2/b+G7Sji
	 jBAwvhn2kp+qdozXp6g6cQT2FsmO9WYzwXvWVtwsQgmaYBgPjb5+A80PQr86wxEnLa
	 s9k65B86rS8qn3aGo4I074p8aM3VuY9/Sycskd9VOn4+ohoD3xLMh6EKBd99lVtnXJ
	 OnmDiCTgpN4Aw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B2E944C28A;
	Mon, 23 Nov 2026 00:46:19 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Mon, 23 Nov 2026 00:46:16 +0000
Subject: [PATCH net v8 4/5] net: phy: run a postponed PHY interrupt handler
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
Message-Id: <20261123-b4-phylib-mac-pm-irq-v3-v8-4-e9f706e79614@iav.lv>
References: <20261123-b4-phylib-mac-pm-irq-v3-v8-0-e9f706e79614@iav.lv>
In-Reply-To: <20261123-b4-phylib-mac-pm-irq-v3-v8-0-e9f706e79614@iav.lv>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3946; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=4J/4xMe32fdh9YgOph9KgzVmf4XWY5UGbdamA1eJyLE=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDNnMPTf/OdhNSeT4xMyypuQtj8LJnPTHPI1Wxec1la5xR
 ofYLpHtKGVhEONikBVTZJlwSONWxpKrf/09zB/AzGFlAhnCwMUpABPxWsXI8Pj8p53GuTZlMlKh
 Ezncl7D/5otT/bDKIbeqhLtB7bj3bIb/TjPN/2fFtC+XvP1PZjXbz4j6WUwOPxQTjRMP3A3SYFb
 jBwA=
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

For a PHY that the MDIO bus suspended, mdio_bus_phy_resume() calls
phy_init_hw() before the rerun, and config_intr() there acknowledges
the latched status in drivers such as realtek. A PHY that the bus did
not suspend, as with Wake-on-LAN enabled, gets no phy_init_hw() and
loses the interrupt today. A later patch brings PHYs with MAC-managed
PM under postponing, and stmmac, for one, does not call phy_init_hw()
on resume.

Call the PHY driver's handler from mdio_bus_phy_resume_irq(), as
phy_interrupt() does, unless the PHY has its interrupts disabled, as
after phy_free_interrupt(): on a shared line irq_rerun outlives the
free, and the handler would run on a PHY that no longer uses the line.
Hold irq_pm_lock across the call and
around phy_disable_interrupts() in phy_free_interrupt(), so that the
free waits for the handler, as free_irq() waits for the thread.

Fixes: 1758bde2e4aa ("net: phy: Don't trigger state machine while in suspend")
Signed-off-by: Igor Velkov <iav@iav.lv>
---
 drivers/net/phy/phy.c        |  3 +--
 drivers/net/phy/phy_device.c | 13 ++++++++++---
 include/linux/phy.h          |  2 +-
 3 files changed, 12 insertions(+), 6 deletions(-)

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
diff --git a/include/linux/phy.h b/include/linux/phy.h
index d84f7d8bc9df..9253a07e84be 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -677,7 +677,7 @@ struct phy_oatc14_sqi_capability {
  * @lock:  Mutex for serialization access to PHY
  * @irq_pm_lock: Held by the PM callbacks, and by the requesting and freeing
  *               of the interrupt where they test and clear @irq_rerun;
- *               phy_interrupt() never takes it
+ *               taken before @lock; phy_interrupt() never takes it
  * @state_queue: Work queue for state machine
  * @link_down_events: Number of times link was lost
  * @shared: Pointer to private data shared by phys in one package

-- 
2.43.0


