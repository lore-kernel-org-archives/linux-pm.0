Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29853A48C5
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 03:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786074891; cv=none; b=GamBO20Rk5YUVv4ScbF+hR2rIeZ4beH1Vz7cWajMVxU5dDw6J8Dyt9pKE2QSF881ho5Z8vlsU+KT95EOLjuB3OFS8v/OWggRXsmlmsJCCQzzNKjT/+C4Fo/HTsqsl+hMoE9Bx36mEGVk7T2b/1kd7Rwbh15/cl+acQYL2k3BKPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786074891; c=relaxed/simple;
	bh=0+TjxDD3Jy9In/dYW3swTJjk2WwZ3m7x7rp80MwetQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L/VxvhteMSIM7ATKZ/ciHn4AIGsaTwOQlrH/5u75rlgixsO8sLqKQiHxEn/KgqSXwm9cAiY4zuVGHnDyTqpFedtrhNnwHnnt/Qsz7IVWAasFzWWGOkpippGreE2OtIsGPGhVIpLGuIeuUDYhUl4Y0LzwAX4H6ZQ92n5qU0UcA+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpEX/7BI; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpEX/7BI"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6ae4aff94c2so1797687eaf.3
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 20:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786074883; x=1786679683; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oG17fuSe5U2XTSseOTKToMBz/2cRmkeSjfgTvQP48IM=;
        b=lpEX/7BI85Fi/0G5+0D2xup9DX4yz60TfCAwoHRQUZ8vNfDwj0b1q5H7nz2xeO59b0
         fyBTIsSZr3zl7i0m8aH+JmxbrgAFJUphZe+HHFvRWEtoU2ApRPKQF2levV6kdjtJifv4
         2OIk1cbOGyT37h0z83/WywXHs50v06NqWDN8McDAyOawzI2B2XKsVWgXArqEmb0ca7oz
         zsMgAwWJW4EWWpI4nlB5IrCkANpuRtO2N6ztmMx9n9zZ9txMW/CvU9VcjxQ20kktyqaz
         Z8FQlF8MfAIDnfA8RPbjHGMLrBHX0GG1H20LsCCgVqKj2bOquVlTm0Uah6SICXjpHNA1
         PvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786074883; x=1786679683;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oG17fuSe5U2XTSseOTKToMBz/2cRmkeSjfgTvQP48IM=;
        b=fzV3E0mGWnf3hDJXH/2Cocy8D/FPJwc0CZHR7trOSFQtkafL4hIsJnG2tNAxBeT8+k
         XlG+98aPXZlPP6we/YA1iQTgowk5jXVyatNv5dusC0tYQBiuvJkDj2strxTGJaHA4Bfg
         i7Zs6PCL+UqP/zBGc3l73oV/tcXJVd+WghPGSRvd/meYn9/gQ3Ai0LsGobsQKdLu1nfn
         spLFt2OmrkgEf4D3HtNUOuJz6Q/q/pMw014NGVcHAaQC73wZRHVe7chrPwexNkeGeaAC
         CoC9aQYpJ0dMfoQM47Qhga+B4LPSnbyhgSXU0YNo2AMx9Vk9Q8vTmjjcvgadHoe+k8wn
         af8w==
X-Forwarded-Encrypted: i=1; AHgh+Rr8KWDlFhuOrIpSW2sqz+/BPxx8TI1n1E4zdCTwVUAbRiAxFyeDY8bZDH+Lozjltx6PsEcpZBYsqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMr67Pj/ask73mkgFfDLULw9o8pFic4Lznao1MGRiS+zWAxw4p
	YK/5hRueCUGD4f7nXRQ8X7OkVnqjwNTqivDmT6WP/7pcD5VksqiqtX6r
X-Gm-Gg: AR+sD11l9MR4oatzTcNyOt2G7sG9ufV9HvnjCBEWAfNIHlazVT5vWauiYYqoBbGNqFQ
	y5gl45bT0vFfXI0wcyG3z6BNDbcwA5pz61e+SJ5fZcw6f+hMvUMmovmHWJOkP/tWT9wtgulOv6x
	g07s9GQwHn4xg5Tovt3gAHfml2i7Usrlnhl3OeFdsaS1ZhM3MmHxA6sSeL9dnpMYmZrx6dxm9yz
	LQRoaYSrfxnzTmlnXtywAAzWvROTEG2wbuHivoNXPnh21yF9SIXnhBlD8/68X3ntX7OZaY5PSoA
	c8LIQ0OjLjX2kjsm4XsLP52ndZZJfBOvKBwCOeG9rqMy9bBtEk0OKeDF+rEVw1UGVVhATouRbjB
	mk7e0aMqhQzJpG2+su0CeXwiRNAehmuHapeXVMQCECOZSR3J0UXUcVQh+MLeC8MogPJS5fAee5d
	T5KySa4RyD4ILN+PDpZN234U9qTH9P9cJKzHUZwe/CRvlKxmaJXXwZ734MuO4J4W2D6712gQd7s
	Wn7Mv0s7pu0vjCYo7PFhxqGveKv2M7g+eke2jVqZzOiqOKR3jG3M+reJkVnFoPFR3OunwpK13q1
	lJ7C/V9TnREUvgczlH6DSkDUbQf5AC1+h8Z91XF7F1m6dDjLrS6Mty6JKqtUytoariIbBa2KDlA
	B492Hrlvd3JjxMn0e8w==
X-Received: by 2002:a05:6820:987:b0:6aa:e573:9ce0 with SMTP id 006d021491bc7-6ae96d0b246mr11060312eaf.16.1786074883485;
        Thu, 06 Aug 2026 20:54:43 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b02bbc41bbsm1329339eaf.3.2026.08.06.20.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 20:54:43 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 06 Aug 2026 21:54:20 -0600
Subject: [PATCH net-next v4 1/4] net: phy: cache MDIO bus owner before
 dropping PHY reference
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-submit-mdio-of-dynamic-v2-v4-1-4beb0c50d5ba@gmail.com>
References: <20260806-submit-mdio-of-dynamic-v2-v4-0-4beb0c50d5ba@gmail.com>
In-Reply-To: <20260806-submit-mdio-of-dynamic-v2-v4-0-4beb0c50d5ba@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Jonas Gorski <jonas.gorski@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
 Ciprian Regus <ciprian.regus@analog.com>, 
 Andreas Larsson <andreas@gaisler.com>, Mark Einon <mark.einon@gmail.com>, 
 Iyappan Subramanian <iyappan@os.amperecomputing.com>, 
 Keyur Chudgar <keyur@os.amperecomputing.com>, 
 Michael Chan <michael.chan@broadcom.com>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Doug Berger <opendmb@gmail.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Wei Fang <wei.fang@nxp.com>, 
 Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Jijie Shao <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, 
 Bryan Whitehead <bryan.whitehead@microchip.com>, 
 UNGLinuxDriver@microchip.com, Vladimir Zapolskiy <vz@mleia.com>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Timur Tabi <timur@kernel.org>, nic_swsd@realtek.com, 
 Byungho An <bh74.an@samsung.com>, 
 Steve Glendinning <steve.glendinning@shawell.net>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Jiawen Wu <jiawenwu@trustnetic.com>, 
 Mengyuan Lou <mengyuanlou@net-swift.com>, 
 Thangaraj Samynathan <Thangaraj.S@microchip.com>, 
 Sebastian Reichel <sre@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.15.2

phy_attach_direct() and phy_detach() cache the MDIO bus pointer, drop their
PHY device reference, and then read bus->owner. If the put releases the PHY
during concurrent teardown, the cached pointer does not itself keep the
parent bus alive.

Cache the module pointer before dropping the PHY reference. The existing
module reference protects the cached pointer whenever the MDIO bus and
network device have different owners.

Fixes: ec988ad78ed6 ("phy: Don't increment MDIO bus refcount unless it's a different owner")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/phy/phy_device.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 94b2e85e00a3..34d00f1ee483 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1752,7 +1752,7 @@ static bool phy_drv_supports_irq(const struct phy_driver *phydrv)
 int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 		      u32 flags, phy_interface_t interface)
 {
-	struct mii_bus *bus = phydev->mdio.bus;
+	struct module *bus_owner = phydev->mdio.bus->owner;
 	struct device *d = &phydev->mdio.dev;
 	struct module *ndev_owner = NULL;
 	int err;
@@ -1764,7 +1764,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	 */
 	if (dev)
 		ndev_owner = dev->dev.parent->driver->owner;
-	if (ndev_owner != bus->owner && !try_module_get(bus->owner)) {
+	if (ndev_owner != bus_owner && !try_module_get(bus_owner)) {
 		phydev_err(phydev, "failed to get the bus module\n");
 		return -EIO;
 	}
@@ -1900,8 +1900,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	d->driver = NULL;
 error_put_device:
 	put_device(d);
-	if (ndev_owner != bus->owner)
-		module_put(bus->owner);
+	if (ndev_owner != bus_owner)
+		module_put(bus_owner);
 	return err;
 }
 EXPORT_SYMBOL(phy_attach_direct);
@@ -1917,7 +1917,7 @@ void phy_detach(struct phy_device *phydev)
 {
 	struct net_device *dev = phydev->attached_dev;
 	struct module *ndev_owner = NULL;
-	struct mii_bus *bus;
+	struct module *bus_owner;
 
 	if (phydev->devlink) {
 		device_link_del(phydev->devlink);
@@ -1972,17 +1972,14 @@ void phy_detach(struct phy_device *phydev)
 	/* Assert the reset signal */
 	phy_device_reset(phydev, 1);
 
-	/*
-	 * The phydev might go away on the put_device() below, so avoid
-	 * a use-after-free bug by reading the underlying bus first.
-	 */
-	bus = phydev->mdio.bus;
+	/* The PHY and its parent bus may be released by put_device() below. */
+	bus_owner = phydev->mdio.bus->owner;
 
 	put_device(&phydev->mdio.dev);
 	if (dev)
 		ndev_owner = dev->dev.parent->driver->owner;
-	if (ndev_owner != bus->owner)
-		module_put(bus->owner);
+	if (ndev_owner != bus_owner)
+		module_put(bus_owner);
 }
 EXPORT_SYMBOL(phy_detach);
 

-- 
2.53.0

