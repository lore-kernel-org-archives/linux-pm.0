Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795394793;
	b=B3UMaqh8zn4ixpuJXO92Q+S449jgxZx/gIEAXEZQrzomUn6tjX256GEGRu1GFULthZ4W
	 10czId4J5oNWdik7I7OSwXYU2GLqXxAfQB5lRd+1hrc1KuN02GZBiTjXvBZ3V4/VkvKDN
	 oTc2qVb4uGElFl8Wd17GUThryjUkQ/FoQJlKOI7I1dEep/UtUbRHMJ1/tBYAbDeleEUdo
	 b9EVD3fW4rPJ7OzcAMqc3rGWeautJQtzaEyDAUBTKjUxH5hf6qkflr2gspZm+pG7Fjz3x
	 t9AxzS9OK7wTMFsBM0FCK+Knn3jE6jfL3M2SMHcgCK5ntDfcEWuIMdQaBJpGrRq8ZXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795394793;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=cwtYdg7Ff/aGghpLaQ6sVil8yrw30S9ZwzKbTVNyIbs=;
	b=5hZnh74MQD+C2kLNvDzZPaRBPEuv3STENWpLzSCJXO0aTTwI36Dt2V9TvyvJAwYVGu/q
	 2T9nH8LWTez4QybRNUOV/CmTXSDeUj1b0CmakfSxpMqnmRbAui4fsPyb5fT/W7pzh4j3i
	 rMgB3TqE8j4Wj05OIM3WiC3K63ImwbdDkiVXY0X2mbg8bqL96zMGlEgiTizv5udlJlvee
	 qag2dD+gPlJmeQ89YT3KFPExQ8qp7UB1aIope62n1YBM+ZJODboQkfX7awi7J4kjbhbEm
	 AJElZcwZoJ2+rcdKpl8zpQ7yLBqbVqlgy7/pSCSH0jlgmiWr+F1F8FMVp4BRh81Unig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lEYA2aED;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12A8606A6B4;
	Mon, 23 Nov 2026 00:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lEYA2aED
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795394793;
	b=1rWInvMIkd0Cm9N8UranfPJk0O1MTRuX56zJp6lVL4VOQkyX2d1tPA6WruI0IDTHZFP3
	 t7P1DlXX4dBUV/PDnct+00o8+zURWPL8ZuT1ws640kQoh+qegPhKnXAksKMZhuOzOelZY
	 uagBKECcZ/bKEdrWDz0dC/GC26dtO6gbyddTONrCdRoXIVHvUBwQpWAqW0orRXrZ+bdsO
	 szRu3n9ROnwpjR7bKl9B3cvPrn2XzIAKLRoZAsCVShnAKR3liqgexRad8jFWFJeDqeUzZ
	 gTN0b8WhMArIlsvhjpDHkT6SjRpa5FnesqZiKVfDEsQio9Uk6hMAPABLi6XLxojdUBg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795394793;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=cwtYdg7Ff/aGghpLaQ6sVil8yrw30S9ZwzKbTVNyIbs=;
	b=cBVr0jU7sBkp5lDggSG1416hgqkdMvIhAqiljnYyZhA8hl8wcGD7P5N/jXF4wSdZB9vg
	 HOu68fyvxSB1xCFTnHZGWowAR4/TI/sFlUwPaeyv0ShfQuxS7+Kg+pb1YCKeZBXkXF0JB
	 P2HYa6rWSqifiBaOii605Su1YAmJCsHxT5LTouFJFJCi9qWEz1kxlntyvXj55k6BIK3Pa
	 Hu/Sa9ui/H/H26GP7X0wLgmbsJivMSTadbnVRxsj8pOfWZgMrR8LTROOqbRPDv5MQoG3k
	 rDw1mo78O8rk+xXJ2y17rDhiYFDWfzokrzT8CdFm24SBIgA9EWsTUtx34FHrf0RarHg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CA3111F000D1;
	Mon, 23 Nov 2026 00:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795394793;
	bh=cwtYdg7Ff/aGghpLaQ6sVil8yrw30S9ZwzKbTVNyIbs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=lEYA2aED4l+8+lLkXoVdvsmdZDeso0ZgAYlP8Z6aILUYUTWNMEjyERFRyZiTKEEaQ
	 VNioBWrGZe3O9o3IOiL9ZVQBzUI5dlyRcCdJ62thFpaORAnmbDRRCoBDk/T03r6qz+
	 AMRqnMVAt8QBeko6Ax0Mc3uqbLY6aepIX/qo/AhlYvi1omIOZbPUfXKZlieOhQr37E
	 oZFiWo+HrEPoiyjPuc5jaJMyvxqWacuiZC47FpQZqjXqG40PG9yFX6NCtOGwyoDOmH
	 /Q0ZCcI0p1I/sR0wS8Z/zJav8PERiFJpOo6DHVYr8xlHm0NV4AcAMMs5RsQDLY6LGs
	 adIapMlLBghBQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5AD434C27C;
	Mon, 23 Nov 2026 00:46:19 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Mon, 23 Nov 2026 00:46:13 +0000
Subject: [PATCH net v8 1/5] net: phy: move irq_suspended and irq_rerun out
 of the bitfield
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
Message-Id: <20261123-b4-phylib-mac-pm-irq-v3-v8-1-e9f706e79614@iav.lv>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3375; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=Qlv4+bRQfcVjpy/H1IULOONZkAOElJ21mxexa2OAmIQ=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDNnMPTdE2as3+Wz1+snBbVkw3d149aXaP6y310zd4fZb6
 8PplCMdHaUsDGJcDLJiiiwTDmncylhy9a+/h/kDmDmsTCBDGLg4BeAiXYwMPe86jaxZMwWt7kaY
 KDy6Kndg4sdes84CicKb0w6kiWWxMPwPSeXYYC8f/ik+yHjeQWcOu1fHFwetX+1hcb3IfHrIi0u
 sAA==
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Transfer-Encoding: 7bit

From: Igor Velkov <iav@iav.lv>

irq_suspended and irq_rerun share a word with link, autoneg_complete
and interrupts. phy_interrupt() sets irq_rerun from the IRQ thread
without phydev->lock, while the state machine writes link and
autoneg_complete under it and phy_request_interrupt()/
phy_free_interrupt() write interrupts, so one read-modify-write can
undo another. A lost irq_rerun leaves the PHY interrupt disabled after
resume, as phy_interrupt() has already disabled the line.

The last patch of this series sets irq_suspended for PHYs whose MAC
driver manages PHY PM; with stmmac that happens before the MAC stops
the PHY, which widens the window.

Taking phydev->lock in phy_interrupt() alone does not close it:
phy_suspend() stores suspended in the same word and cannot hold the
lock across phy_may_wakeup(), which may take it, and phy_init_hw() and
mdio_bus_phy_suspend() write the word unlocked too. Locking every
writer, MAC drivers included, is a wide audit, and one missed now or
added later reopens the race.

Make both flags bools.

Fixes: 1758bde2e4aa ("net: phy: Don't trigger state machine while in suspend")
Tested-by: Haoning Cheng <Haoning.CHENG@cn.bosch.com>
Signed-off-by: Igor Velkov <iav@iav.lv>
---
 drivers/net/phy/phy.c        | 2 +-
 drivers/net/phy/phy_device.c | 6 +++---
 include/linux/phy.h          | 7 +++++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index fce9bc7be330..9af303d60bd6 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1430,7 +1430,7 @@ static irqreturn_t phy_interrupt(int irq, void *phy_dat)
 				pm_wakeup_dev_event(parent, 0, true);
 		}
 
-		phydev->irq_rerun = 1;
+		phydev->irq_rerun = true;
 		disable_irq_nosync(irq);
 		return IRQ_HANDLED;
 	}
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index b39e945cebd7..1791d578f4dd 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -344,7 +344,7 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
 	 * has resumed. Wait for concurrent interrupt handler to complete.
 	 */
 	if (phy_interrupt_is_valid(phydev)) {
-		phydev->irq_suspended = 1;
+		phydev->irq_suspended = true;
 		synchronize_irq(phydev->irq);
 	}
 
@@ -394,14 +394,14 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
 		return ret;
 no_resume:
 	if (phy_interrupt_is_valid(phydev)) {
-		phydev->irq_suspended = 0;
+		phydev->irq_suspended = false;
 		synchronize_irq(phydev->irq);
 
 		/* Rerun interrupts which were postponed by phy_interrupt()
 		 * because they occurred during the system sleep transition.
 		 */
 		if (phydev->irq_rerun) {
-			phydev->irq_rerun = 0;
+			phydev->irq_rerun = false;
 			enable_irq(phydev->irq);
 			irq_wake_thread(phydev->irq, phydev);
 		}
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 21afc2082b17..59c75296d535 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -726,8 +726,11 @@ struct phy_device {
 
 	/* Interrupts are enabled */
 	unsigned interrupts:1;
-	unsigned irq_suspended:1;
-	unsigned irq_rerun:1;
+	/* Not bitfields: phy_interrupt() and the PM callbacks write them
+	 * without phydev->lock
+	 */
+	bool irq_suspended;
+	bool irq_rerun;
 
 	unsigned default_timestamp:1;
 

-- 
2.43.0


