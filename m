Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795494510;
	b=2LmzOd0BjiKnputpmytEV4t5mpeye0Ync9WhzEWR4Rh54ZiXFdtQSKuA6jBNZXZANo2X
	 MF+Rz8biIH7Azyli6+YLnWMcN+H1h4NnHX3VVPXK/dBfuOJdtRt/uwlr0vFi62xTx4Hj4
	 eoE43lR3W1LBVfLzEh0GAgJTTrFoxiS069Dk4BKUBWlDfO1p6VeDweqj4Rt3FVeGIeusL
	 LHeyAJu+IXsuBaiusTzxAjF8kZtRF1Sc9RTGyg3FH66dvhDUWVF/TDsWItRMWpaL5xMU8
	 qKx+jMwGDzbE+mExmyAIXP2fZEqwBJVNT1ypijhy5KSopzf1GtcSJ1JnHzp4Aw0l/0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795494510;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AVBjQGBWsRhbqtXGph3xAHQAvMR6+/rx3lfHXKGz6Zg=;
	b=pnN1kuYeuAnB+UvbFUjn6nCuk7EDTPBzPpUNwh7hbH46N6iPmy9A1kV8CFelVxr3tyjv
	 mfJffXm9yT+tDFfIHYD/bqseBFEuWTcIarMtiYszj8lR8il0dD4kLxvF4PH0AO1oQs5P3
	 xOEecWgL+oPKlH5c0Grnzj5Ozr5HQUaGel10qeHdGvCWNQlZbFAlYHGgtu9fSjvnVUKm/
	 II3Yq3qzTEFOBlADRW3gUziHUR/SmI+39BwtWQD12SAENlgTW8j8UL2KnFyJkiHPMpbjz
	 Hzs1UuTqi2kOztt0dcQVXqaG6lbM6Nn/HudBTuWaOe7wKb8gTjOCXYcLu80GBQ0tFNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=WRxd5AtB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC9E606A32D;
	Tue, 24 Nov 2026 04:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FC9E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=WRxd5AtB
ARC-Seal: i=1; a=rsa-sha256; t=1795494470; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Mmyzwk889ELTgYQyLnf7ie8jjy9zwLTbLgJUa00RTIdusRvaHZj1ccqBPasAkbiyjUa9VIrpbuFklkJ9G1KEb1jeRkMrJ1gWmcJaZtYJ8j35N6XevM9UOYKc8ekSYa1Erue/sC2eb6pZaFf9BKPK+9rWICR4M2eQUgQ3kWUqeHc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1795494470; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AVBjQGBWsRhbqtXGph3xAHQAvMR6+/rx3lfHXKGz6Zg=; 
	b=OU5/CiF5ZMGIYB2eLtEyBzkaWMWoftJ4jOayra0YFQDBAchPdhcFEPfxm7uI28dMW2Lavt0SmsD6oYFipSajAc0xvySgBflekGUI9A6xYhi+QwjI72thT58RwzW6f1YlcbWOIGxmj+1cJSJDdb7/EaQ7dnq9IHIql1dJxYAegTo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=WRxd5AtB7K/QZ5HA6TcTMeRxMrm9lkOu0AXdJVXxL5ufL41Or+X2EvopnuyJUto0wHFJKv3eHDqp2s6Bk26W2sbMaXCwtff+iP04gp2YV4sSi1DDWeJHJjB2xCEyzNAGbFEQ4VSdGxXrEFnZeQnUCR5J1RUx0Rn6mbVp+7fuxfs=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=AVBjQGBWsRhbqtXGph3xAHQAvMR6+/rx3lfHXKGz6Zg=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1795494469281732.244746746565;
	Tue, 24 Nov 2026 05:27:49 +0100 (CET)
Date: Tue, 24 Nov 2026 06:27:47 +0200
From: Igor Velkov <iav@iav.lv>
To: netdev-bot+sashiko@kernel.org
Cc: iav@iav.lv, andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, tglx@kernel.org, linux-pm@vger.kernel.org, maxime.chevallier@bootlin.com, lukas@wunner.de, rafael.j.wysocki@intel.com, wei.fang@nxp.com, niklas.soderlund@ragnatech.se, paul@pbarker.dev, florian.fainelli@broadcom.com, opendmb@gmail.com, Thangaraj.S@microchip.com, shenwei.wang@nxp.com, Haoning.CHENG@cn.bosch.com, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v8 5/5] net: phy: postpone PHY interrupts during sleep with MAC-managed PM
Message-ID: <179549408717.90858.144565102470528@iav.lv>
In-Reply-To: <179548270352.3135.4334710117066284426@kernel.org>
References: <20261123-b4-phylib-mac-pm-irq-v3-v8-5-e9f706e79614@iav.lv> <179548270352.3135.4334710117066284426@kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

> in some topologies the replay here can still reach the MDIO bus before
> the MAC has resumed.

Yes, the commit message describes it; the patch moves this access
later, not earlier.

> Can this abort every suspend for a Broadcom BCM54210E behind stmmac with
> PHY Wake-on-LAN on a level-triggered line?

That is the level-triggered case the commit message describes: the PHY
driver has to restrict its interrupt to Wake-on-LAN in its suspend
callback. I have no such hardware; bcm54xx_suspend() is for a separate
patch.

> Could the check fall back to irqd_is_wakeup_set() for nested-thread
> lines?

The cover letter lists these lines as not covered. Enabling one in the
noirq phase is not safe: enable_irq() goes through chip_bus_sync_unlock(),
which on regmap-irq writes the mask over I2C or SPI while the bus
controller may already be suspended.
