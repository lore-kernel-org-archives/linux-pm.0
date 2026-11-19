Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795073045;
	b=dETw77yQhPUDLD3fuERFPQW6nAXjJdpt1LK2dz0D5szsON+JMsA+pjjscrBhkwn7F9Ya
	 sowapX/ikfk23NlZNwXZHWBd7tkpOrhOm3xTZKV3I30hhybqbG1etBldrSCCjxg7RVwXT
	 eVqHpjITbRGPXKZiIaZhUVEG70EzKazEZVpe6USjO6KCktEEqWxQKjjBw2A+OiTf7acuU
	 haq1Ykbi8fc5f6ADF5n5b8YHx6Ukbgz9sjWCf+HiU9ynrKasS6MxtKPPikhoimi9W6C4b
	 0tUcTx4RB/mzbBndzp4OosnBudmXH8Mki+BBVk+W7CWXmaHV4upFRdW7VGE527IhyRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795073045;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=cwtYdg7Ff/aGghpLaQ6sVil8yrw30S9ZwzKbTVNyIbs=;
	b=atYGYSnwFPDfaew3aUP2k2jcKgypF+rqXdEE+T7PipHaWKEoKDu2gDxBLePBmeudtmKK
	 haXX4fevrEiedliFLuu8xEvkoWNBBWjIjJU1WCG/G/Zz7AOHEoexjXlMJJRQkpbRtdLnh
	 OGJJlI2CEi68WeonMhRyN+KAOjr5k84ZB4naI1vHWvMYUMsYAwgN6P6SznTRbN2HEreR7
	 AmAallEfmSTFrukMRjki5Zm2mU1tjCKhhi4JBJVn6C5zYALMuazYL7yL4GlzdYomJfzkH
	 tskPJUaw6naajxaVybpIeGHSa0iJOLlzeSzqbGGocLoeqz9MajJqI2HgJAeQVoeBJig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NB3NJ9HV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A77606A324;
	Thu, 19 Nov 2026 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NB3NJ9HV
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795073044;
	b=TirZHVKHe4H6F8gzhloFU0tF4WrdPdyMvrfYjGttnMO61cjBVcAEXxru8k1l+dbYynZr
	 BMyuuQR/g0sAlitjckvYFr33XdbST+DBp6QtsyTTQHQ/UkPqiFIfVfm8QiIOAmvNHK1el
	 Yb9hI1BEBbfq5JYplAOHVYpHQJ+GaZFk4zG7qMbSCJWrA3OXuiWlqmz9b5K+YmY2QzhMA
	 JJitCgGII4wYflVlV30mklbkRxXXEDuS06/nb32kaIx3epLJczvjDGfR4tO2vu67eUZHl
	 2W7VDLTGp9/vIO+u1ZhTPGcI5ykIDts5TA5qoB+zj96IwaKSdYJjGljf2XQizpSr8nw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795073044;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=cwtYdg7Ff/aGghpLaQ6sVil8yrw30S9ZwzKbTVNyIbs=;
	b=UQE8Drv5dKfTU7L7e/K/+vah97nGKB21439L/aTcSqWvS0OqV1r1rdk36gq3BnPGfLsl
	 mP/N2Y/Vqste9N0d3dFtx8epGal/uvNAk91ShoVz4bh1e4imT1KyR2KcR+SHHfg2wK+6x
	 5bJGIE8YspWCKM//IDMRO1eZ43hvtw/SUtFItKmJlSjUPWr3Z/WP/hebRJzw50He71Q3B
	 wysEAnNuPlnvZsGMFbV6ckgT2Wj/ONs2MNCQAPwh7z9fhCzL6I4AeOPGv/I3B0aGjDK+h
	 mZvA8VtvyHmiDvSk2aF4zgyxoqwdrAbZ2S8hq3yt024UIr1X/ynD10u3XM/RP9rQg/w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3A2401F000C5;
	Thu, 19 Nov 2026 07:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795073044;
	bh=cwtYdg7Ff/aGghpLaQ6sVil8yrw30S9ZwzKbTVNyIbs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=NB3NJ9HVEa9bixAUZ65xqA+LbU0YI/OlsyGuKR7VwKpO1/v0hmA70/cQCVtdjISl4
	 ZmSLWouLmzN2JtIfElmNBvQ7TiyQ+jI0jUTzPXHviA470xqUjzzAl9JPr1NfXVJ0VW
	 BCStyCMr9UyyMeFoxk5Du51aJH9n5+Jsp45dFH9Zjq86crWnkpl55ihjF9HHOemboj
	 LS215XBTW1PEsWWHSZQVYWqF5ZdB/9hIkAkTJIcbj4TroY/wQwy1gKoERgnN+e0AFQ
	 7PsZVtppEb1lQTHRHGv6noBlKI1nTFyf1bj0B8Hl3cOMXdaeXYQ6D+3K6vcJ7qInW3
	 BMnt3yVMYtx7Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C4EB94B160;
	Thu, 19 Nov 2026 07:24:03 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Thu, 19 Nov 2026 07:23:57 +0000
Subject: [PATCH net v7 1/5] net: phy: move irq_suspended and irq_rerun out
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
Message-Id: <20261119-b4-phylib-mac-pm-irq-v3-v7-1-d8b8f43b5a62@iav.lv>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3375; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=Qlv4+bRQfcVjpy/H1IULOONZkAOElJ21mxexa2OAmIQ=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFn/lgjUCk+6bG5wcFd7fYP0pI9qKw59uL763uJjcrVhR
 3Y3lk0W7ShlYRDjYpAVU2SZcEjjVsaSq3/9PcwfwMxhZQIZwsDFKQAT8XNm+Ctku+TaE4W5K9tS
 eE0XbGm5dWnG3abk3tnHhFj+TT0e+2ghI8O/xhX7UjtKZBeenOIsqT9tq6W9ZGFIyzbB868sL+c
 9z2ECAA==
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


