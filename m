Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795073047;
	b=NeX8PNzbZxRuGaCS+Fvxvwpb9/81KlmWN3kWQOz9LGK7L5XRSHTDWbesUSUwmoLspqCD
	 tvgEh6dP3cIRB+pof5bmD716G3KGk4bdyVgSFmYrgKElACvPfFMSkt1+6mmPCsF2pp7nV
	 DTiTvQxMALJzShfVBeedsm1sf1VbZHUEUBcaO+O1T0mz/ictuPgBSpMxpp7rgWq1Tp6R2
	 hLKNsGRvn+eRXqI3ApWSSX3BHY1lWz/CkY5UriuTx/MoKotkhQG0WME1UI7E2wIfJPGgG
	 OfaE0cdtWg16XF+v+aMb91a3Y8yRbbS3a7ffa+bdOXJRNoyffcYe4EgByTVrQpmCLvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795073047;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XeDIsmmv1QfPXIxo2GcgGRX8m8YXaZctC5QaxEPO/6s=;
	b=kcAYyckL4BUmH5bkHBvOneLnaHBfMgXEg8ES1UZ4G827bi0Ttzch3N2eiOX2FubK+xGY
	 My/hlSvys+uq9BHETzawx9zl9Hxsb0fozvPN2d0K9hUe0FZ6KniA8NgmcmyYBqZVuxIHG
	 vuxqFn5qWBDC3v4fcHHeNlIasaP29ZPJINW9u/zOk51e6NtzTvhCGe4DJWAzy4mCRCprG
	 P8wOZbM1daNRhrF7jYXEoPdPHBCMhZIhTaMg7oWxEAlYBz9TxYa69NRWST2tkHsgcEMDs
	 M3r4spZPWBFLNzNyAKodl7S2Jg58t+cYfxvOG8YwqA9ygYL+1WxC1oAMRUbIDxKvN9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Nxrm/8aE";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570C660A2630;
	Thu, 19 Nov 2026 07:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nxrm/8aE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795073047;
	b=CiE3Gi6gqIOpl5aDV20VB/a4lCacHnlizfyP1XeM8h1KigJUJSA06AZfdz3r0kLjAopa
	 RLouSFoavIv9VajAr6naSvUonzAOdy490CYRqnGmq20DgzW8qAHcberJWN71ZQEIFtS/9
	 XBbgdapO9roJRX1dDiQ1Hp3y2gkWraj0km3BI8crKSqf7yTtpDb0vEdFrjmiAHoprVieS
	 uD1z5isUbiJl4nvzBqoGwOQMR4vxNDXIiHH+j2EVLqS77tT3KlEjbQ9iK+mJCXgYatTjb
	 bIZIXa1K5sqEl2YUWaROG6+e8gupAME8mvQV/HXgFXhYh5R8brvGyKBuN7wr7KW/pQg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795073047;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XeDIsmmv1QfPXIxo2GcgGRX8m8YXaZctC5QaxEPO/6s=;
	b=vnCSrUMbce3X6PwvbPdUaLr2a2tkrJtyzCSVIhNAVo8iya7DiOSnwAW/9GWekU/Bdch3
	 dY/wlwOULbZSVpjylVxVWn+94MfkWkBwGADo6vmV0J4WmNwUmGObxYGSLtDqavPNy83AR
	 DXcCwDA1sVcWhZoHiQHtOPRPegmbtEiCkD2y5HrBgWfoA5jKTNPQ/MlduJVETn/guKfje
	 Fm83dPtBlbdHJvW06Myhk/9VCNzfEAUdNI2qp3sqavmvnAxpuS2sVlGslOb7j/Rmo0ido
	 q8AeVn2sEIyGVivxPRTk6/tnYHCNSMYPzlMJxlZOGwvzeF54iX3Edu5HoAlymLGzuXA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 68FB21F000CD;
	Thu, 19 Nov 2026 07:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795073047;
	bh=XeDIsmmv1QfPXIxo2GcgGRX8m8YXaZctC5QaxEPO/6s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Nxrm/8aEdQv7kQLzIjh9KpKmSWgvEurnzf92VFmRozJKzxpljoiRAcJv0y1wflT2i
	 ETJvx3xYCt88TWwAMH2EVhes3Kus3VJRwOhsxaVFOGzJ/XV73sXWdJt4CKpNOG0Y5u
	 x3SX0cU5+7wll70wsWZx7B2XENUW1cmgvTgwO9ok7SGMTsHSK+ayqZgRNHVZX7vYwO
	 FN5Qyz8oFkImeCBGfS0FQnR8aLBswVAlC4D3Bc68DI+GhMgjdwWu2XAKFXyeM1Z5dF
	 7n267ysuo89cYjnA3ruPyVoavG0OAKdv+T0MvKM80DBLg+UK8b6FwpjuZ4DPVFHYbH
	 hm9zfol4Ah9VQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 32ED64B171;
	Thu, 19 Nov 2026 07:24:04 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Thu, 19 Nov 2026 07:24:01 +0000
Subject: [PATCH net v7 5/5] net: phy: postpone PHY interrupts during sleep
 with MAC-managed PM
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
Message-Id: <20261119-b4-phylib-mac-pm-irq-v3-v7-5-d8b8f43b5a62@iav.lv>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10701; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=BYqkLelIj0GKD5GRd5jre2P8EBEqvvGdLu7U85SLWvg=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFn/lghV/LV4FyTz+6XEfK3FyoJLj+aklLy8fc7S8+KRy
 udaK7ptOkpZGMS4GGTFFFkmHNK4lbHk6l9/D/MHMHNYmUCGMHBxCsBEYqYw/GK6c67m016xH1vO
 /jfZFfpzWtK6B702l84teGzV5GXG62vE8N/jivxDPuEUNufQuNx9sx/smTnX1KVUrmr+n5XBHBX
 xcdwA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Transfer-Encoding: 7bit

From: Igor Velkov <iav@iav.lv>

mdio_bus_phy_suspend() and mdio_bus_phy_resume() return early when the
MAC driver manages PHY PM, so the PHY never gets irq_suspended and
phy_interrupt() runs the PHY driver's handler at any point of the sleep
transition. If the MAC driver powers the MDIO bus down, the MDIO access
in that handler can stall the CPU. This happens on both sides:

- suspend: the MAC's suspend callback stops the PHY, the link goes
  down, and the handler runs while the MAC powers down;
- resume: resume_device_irqs() re-enables a pending interrupt before
  the MAC resumes.

On Helios64 (dwmac-rk, RTL8211F with its interrupt line described in DT)
both hang the board: the handler reads INSR while the GMAC clocks are
off, after rk_gmac_suspend() or before rk_gmac_resume(). The commit in
the Fixes tag added the postponing after the early return for
MAC-managed PHY PM, and stmmac has set mac_managed_pm since commit
f151c147b3af ("net: stmmac: Enable mac_managed_pm phylink config").

Set irq_suspended for these PHYs too. The PHY device is a child of its
MDIO bus, so mdio_bus_phy_resume() runs after the resume callbacks of
the bus and its parents (with stmmac, the MAC) and replays the postponed
interrupt then. The PM core resumes children of a device whose resume
callback failed, and phylib cannot tell: if the MAC fails to power the
bus up, the replay still reaches the bus. When the PHY sits on an MDIO
bus the MAC does not own, phy_attach_direct() links the MAC as a
consumer of the PHY, so the MAC suspends before and resumes after the
PHY; there the replay still runs before the MAC resumes, as the handler did
from resume_device_irqs() before this change, and until the PHY
suspends, an interrupt still runs the handler after the MAC has
suspended. ODROID-HC4 (stmmac, RTL8211F behind mdio-mux-meson-g12a)
takes this path. phy_suspend(), phy_resume() and the state machine stay
with the MAC driver, and no MAC driver needs a change. Doing this in
phylink_suspend() instead would miss macb, which sets mac_managed_pm but
suspends with phylink_stop().

A postponed interrupt cannot read the PHY, so it cannot tell Wake-on-LAN
from a link change. A PHY without MAC-managed PM reports what
phy_interrupt() reports today. A PHY with MAC-managed PM reports no
wakeup from the postponed interrupt: the MAC can change the link in its
suspend callback, as stmmac lowers the link speed through
phylink_suspend() when the PHY may wake the system.

A postponed interrupt leaves its line disabled. suspend_device_irqs()
runs before the noirq callbacks: it arms a wakeup line and leaves a
disabled one masked unless the irqchip has
IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND, so a PHY whose interrupt line is also
its wake IRQ would sleep through a wakeup. Enable the line a postponed
interrupt disabled in the noirq suspend callback while it is still
disabled and armed for wakeup, and disable it again in the noirq resume
callback, before resume_device_irqs(). The irq core turns an interrupt
on an armed line into a wakeup without running the handler, and clears
the armed state before it disables the line, so a line that already
woke the system is left alone, and so is a line that is no longer
disabled. An edge the postponed interrupt consumed does not repeat, so
on an edge-triggered line a magic packet that arrives during the
transition does not abort it; the next one wakes the system. On a
level-triggered line, a PHY that keeps a link interrupt asserted, such
as the one from the speed change above, aborts every suspend with
Wake-on-LAN enabled: its driver has to restrict the interrupt to
Wake-on-LAN in its suspend callback, as rtl8211f_suspend() does.

Tested on Helios64 with 7.3.5 and this series, s2idle with the link up:
- no Wake-on-LAN, GMAC clocks off in suspend: 10 of 10 cycles suspended
  and resumed; on 7.3 without this series the same test hung or reset
  the board after the link went down 10 of 10 times;
- MAC power/wakeup enabled, no Wake-on-LAN: 3 of 3 slept;
- Wake-on-LAN in the PHY, so phylink_suspend() also drops the link
  speed: a magic packet woke the board 7 of 8 times, no suspend
  aborted; in the eighth the PHY raised no interrupt, cause not found;
- the same under a flood of magic packets: a packet after
  rtl8211f_suspend() was postponed and disabled the line, the noirq
  callback enabled it, and the wakeup aborted the suspend 5 of 5 times
  (traced); a single magic packet then woke the board.

Fixes: 1758bde2e4aa ("net: phy: Don't trigger state machine while in suspend")
Signed-off-by: Igor Velkov <iav@iav.lv>
---
Haoning Cheng's Tested-by on v5 is not carried: MAC-managed PHYs no
longer report a wakeup.
---
 drivers/net/phy/phy.c        | 13 ++++++++---
 drivers/net/phy/phy_device.c | 54 ++++++++++++++++++++++++++++++++++++++++----
 include/linux/phy.h          |  7 ++++--
 3 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 6cc94b525e09..45891570a56e 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1419,7 +1419,10 @@ static irqreturn_t phy_interrupt(int irq, void *phy_dat)
 	if (IS_ENABLED(CONFIG_PM_SLEEP) && READ_ONCE(phydev->irq_suspended)) {
 		struct net_device *netdev = phydev->attached_dev;
 
-		if (netdev) {
+		/* With MAC-managed PM, a postponed interrupt cannot tell
+		 * Wake-on-LAN from a link change the MAC causes.
+		 */
+		if (netdev && !phydev->mac_managed_pm) {
 			struct device *parent = netdev->dev.parent;
 
 			if (netdev->ethtool->wol_enabled)
@@ -1486,8 +1489,10 @@ void phy_request_interrupt(struct phy_device *phydev)
 
 	/* A line without users restarts at depth 0, so our disable is gone */
 	mutex_lock(&phydev->irq_pm_lock);
-	if (phydev->irq_rerun && !irq_has_action(phydev->irq_rerun_line))
+	if (phydev->irq_rerun && !irq_has_action(phydev->irq_rerun_line)) {
 		phydev->irq_rerun = false;
+		phydev->irq_wake_enabled = false;
+	}
 	mutex_unlock(&phydev->irq_pm_lock);
 
 	err = request_threaded_irq(phydev->irq, NULL, phy_interrupt,
@@ -1522,8 +1527,10 @@ void phy_free_interrupt(struct phy_device *phydev)
 	/* free_irq() shuts down a line left without users and the next request
 	 * resets its depth; mdio_bus_phy_resume_irq() enables a shared line.
 	 */
-	if (!irq_has_action(phydev->irq))
+	if (!irq_has_action(phydev->irq)) {
 		phydev->irq_rerun = false;
+		phydev->irq_wake_enabled = false;
+	}
 	mutex_unlock(&phydev->irq_pm_lock);
 }
 EXPORT_SYMBOL(phy_free_interrupt);
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 8bc394ff7d2d..c700b34e40a2 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/mdio.h>
@@ -377,11 +378,14 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
 	struct phy_device *phydev = to_phy_device(dev);
 	int ret;
 
+	/* An interrupt can fire while the MAC has the MDIO bus powered
+	 * down, whether or not the MAC manages PHY PM.
+	 */
+	mdio_bus_phy_suspend_irq(phydev);
+
 	if (phydev->mac_managed_pm)
 		return 0;
 
-	mdio_bus_phy_suspend_irq(phydev);
-
 	/* We must stop the state machine manually, otherwise it stops out of
 	 * control, possibly with the phydev->lock held. Upon resume, netdev
 	 * may call phy routines that try to grab the same lock, and that may
@@ -414,8 +418,10 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
 	struct phy_device *phydev = to_phy_device(dev);
 	int ret;
 
-	if (phydev->mac_managed_pm)
+	if (phydev->mac_managed_pm) {
+		mdio_bus_phy_resume_irq(phydev);
 		return 0;
+	}
 
 	if (!phydev->suspended_by_mdio_bus)
 		goto no_resume;
@@ -446,8 +452,46 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(mdio_bus_phy_pm_ops, mdio_bus_phy_suspend,
-			 mdio_bus_phy_resume);
+static __maybe_unused int mdio_bus_phy_suspend_noirq(struct device *dev)
+{
+	struct phy_device *phydev = to_phy_device(dev);
+	struct irq_data *d;
+
+	mutex_lock(&phydev->irq_pm_lock);
+	/* We enable the line a postponed interrupt disabled if the irq core
+	 * armed it for wakeup, so that it wakes the system.
+	 */
+	if (phydev->irq_rerun) {
+		d = irq_get_irq_data(phydev->irq_rerun_line);
+		if (d && irqd_irq_disabled(d) && irqd_is_wakeup_armed(d)) {
+			enable_irq(phydev->irq_rerun_line);
+			phydev->irq_wake_enabled = true;
+		}
+	}
+	mutex_unlock(&phydev->irq_pm_lock);
+
+	return 0;
+}
+
+static __maybe_unused int mdio_bus_phy_resume_noirq(struct device *dev)
+{
+	struct phy_device *phydev = to_phy_device(dev);
+
+	mutex_lock(&phydev->irq_pm_lock);
+	if (phydev->irq_wake_enabled) {
+		phydev->irq_wake_enabled = false;
+		disable_irq_nosync(phydev->irq_rerun_line);
+	}
+	mutex_unlock(&phydev->irq_pm_lock);
+
+	return 0;
+}
+
+static const struct dev_pm_ops mdio_bus_phy_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(mdio_bus_phy_suspend, mdio_bus_phy_resume)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mdio_bus_phy_suspend_noirq,
+				      mdio_bus_phy_resume_noirq)
+};
 
 /**
  * genphy_match_phy_device - match a PHY device with a PHY driver
diff --git a/include/linux/phy.h b/include/linux/phy.h
index f370690d62a7..74acbb15ef7b 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -649,10 +649,12 @@ struct phy_oatc14_sqi_capability {
  * @mdix_ctrl: User setting of crossover
  * @pma_extable: Cached value of PMA/PMD Extended Abilities Register
  * @interrupts: Flag interrupts have been enabled
- * @irq_suspended: Flag indicating PHY is suspended and therefore interrupt
- *                 handling shall be postponed until PHY has resumed
+ * @irq_suspended: Flag indicating a system sleep transition, so interrupt
+ *                 handling shall be postponed until the PHY has resumed
  * @irq_rerun: Set by the postponed interrupt that disabled the line
  * @irq_rerun_line: The line the postponed interrupt disabled
+ * @irq_wake_enabled: Set while @irq_rerun_line is enabled for the noirq
+ *                    phase, as it wakes the system
  * @default_timestamp: Flag indicating whether we are using the phy
  *		       timestamp as the default one
  * @interface: enum phy_interface_t value
@@ -734,6 +736,7 @@ struct phy_device {
 	bool irq_suspended;
 	bool irq_rerun;
 	int irq_rerun_line;
+	bool irq_wake_enabled;
 
 	unsigned default_timestamp:1;
 

-- 
2.43.0


