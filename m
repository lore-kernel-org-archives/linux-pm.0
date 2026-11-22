Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795384990;
	b=c3OLZ2TcxgkIJUzriTV92ZqCRCW5qdnMD8CFq+FLHhB0w3+4V1vbaXr6GRmCZ9VSbN3g
	 nzvJ2OZD2qYZTrlCQMTAQJ7ld2/1+S3LbJCM3mH9JkwURmN9mcXFoRAT6/51QT2fHDqvJ
	 6dvqbmyDUkfTeaCSGB0S1u0RR6k/M+1k9UaE9vnPK4UVqhDmvKKLqc0EiFaXjQKcqXdMg
	 ReO7Hor+ErX21HBSkGx7GlTbR8NUwFx2gIzLst73BrYPCNpXdVALeHBZSjXCpP4ZbhnbB
	 1sgr5eFMh4KmNKuSO3CsoMScqb3Uo3aVT8NWr8Rx2qFUuISN64UuyKKzJ//GRsero5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795384990;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JXcFHflK0e4wRmdk/kevbkxf3N1Rrm6teC1Baw2ZrKs=;
	b=oo5n2AHOR6k4KBf4hVVtSfKZ7IcZsKcT5SB7cLgolMva6iNpNfJcq6HEcKxqJxRFWcPe
	 L8GJTj45LcarSDJtIvaVoLRVMeubW0Vqr0ebYEHXnGr/HQ3scXcY5StgYWtEraL6lif3l
	 v2GMfUoXp8QQ7uwwSChuArrB+nZ1YKfF/mZaMZ0B0p2XzthbEBlkWIKoLpMPsFKGbAQ7D
	 MwD7o3j5UhBxLsfUz1VyNAmX4voiSCFk5k8kn/My5kIvFR7rLPceh0GhL+kVrSxEh+HQK
	 7IRN56ef+70pVAsgxYoU9iX8qit4ZhGDHfRo1tZMK4MQLBVlvf+GUXpCGxuZnrofg5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xvp1bFJP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A66606A680;
	Sun, 22 Nov 2026 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xvp1bFJP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135B61F000D0;
	Sun, 22 Nov 2026 22:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795384990;
	bh=JXcFHflK0e4wRmdk/kevbkxf3N1Rrm6teC1Baw2ZrKs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Xvp1bFJPOAJko1gTYkkHi2xliN+e/SJiZolJ42UqB3t+AJeXOGSOQ5M3gp0cCrTVu
	 WlElUWX8cjccqnKCXUFtDIAOk0UnEjRmvnKjHkuN//tBxB46wH7JtSt4NcYSZdLwHK
	 pabOJlkT5LsHkk8Sz0RrnF48e4UvYvDwd6sfU1Xqxg/ZnQrCm82u32LY4lXfIdKuU4
	 cghezifPWoqfei365GGZxdBoUHa6PoIz9SZSDhoQBd5invBxbyGW6oJlUo16aHhzLc
	 FMIHGF7nKSqNWoMk3DX2e9lrABETD7T1IU3em0tiIs6EzvqHvG/YL7C/l4E+FAg2tZ
	 pZBTp7cixDXjg==
Subject: Re: [PATCH net v7 5/5] net: phy: postpone PHY interrupts during sleep
 with MAC-managed PM
From: netdev-bot+sashiko@kernel.org
To: iav@iav.lv
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 tglx@kernel.org, linux-pm@vger.kernel.org, maxime.chevallier@bootlin.com,
 lukas@wunner.de, rafael.j.wysocki@intel.com, wei.fang@nxp.com,
 niklas.soderlund@ragnatech.se, paul@pbarker.dev,
 florian.fainelli@broadcom.com, opendmb@gmail.com, Thangaraj.S@microchip.com,
 shenwei.wang@nxp.com, Haoning.CHENG@cn.bosch.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Sun, 22 Nov 2026 22:03:08 +0000
Message-ID: <179538498865.3135.16577116981763828111@kernel.org>
In-Reply-To: <20261119-b4-phylib-mac-pm-irq-v3-v7-5-d8b8f43b5a62@iav.lv>
References: <20261119-b4-phylib-mac-pm-irq-v3-v7-5-d8b8f43b5a62@iav.lv>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Two phylib changes interact badly.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  mdio_bus_phy_resume() (drivers/net/phy/phy_device.c:439-445) returns…

--

net: phy: postpone PHY interrupts during sleep with MAC-managed PM

With this commit, mdio_bus_phy_suspend() also sets irq_suspended for PHYs
with MAC-managed PM, so their interrupts are postponed across system
sleep, and phy_interrupt() no longer reports a wakeup for them. It also
adds noirq callbacks. The suspend one re-enables a line that a postponed
interrupt disabled if the line is armed for wakeup. The resume one
disables it again before resume_device_irqs().

> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 6cc94b525e093..45891570a56ee 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -1419,7 +1419,10 @@ static irqreturn_t phy_interrupt(int irq, void *phy_dat)
>  	if (IS_ENABLED(CONFIG_PM_SLEEP) && READ_ONCE(phydev->irq_suspended)) {
>  		struct net_device *netdev = phydev->attached_dev;
>  
> -		if (netdev) {
> +		/* With MAC-managed PM, a postponed interrupt cannot tell
> +		 * Wake-on-LAN from a link change the MAC causes.
> +		 */
> +		if (netdev && !phydev->mac_managed_pm) {
>  			struct device *parent = netdev->dev.parent;
>  
>  			if (netdev->ethtool->wol_enabled)

[ ... ]

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 8bc394ff7d2d2..c700b34e40a2c 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

[ ... ]

> @@ -377,11 +378,14 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
>  	struct phy_device *phydev = to_phy_device(dev);
>  	int ret;
>  
> +	/* An interrupt can fire while the MAC has the MDIO bus powered
> +	 * down, whether or not the MAC manages PHY PM.
> +	 */
> +	mdio_bus_phy_suspend_irq(phydev);
> +
>  	if (phydev->mac_managed_pm)
>  		return 0;
>  
> -	mdio_bus_phy_suspend_irq(phydev);
> -
>  	/* We must stop the state machine manually, otherwise it stops out of
>  	 * control, possibly with the phydev->lock held. Upon resume, netdev
>  	 * may call phy routines that try to grab the same lock, and that may
> @@ -414,8 +418,10 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
>  	struct phy_device *phydev = to_phy_device(dev);
>  	int ret;
>  
> -	if (phydev->mac_managed_pm)
> +	if (phydev->mac_managed_pm) {
> +		mdio_bus_phy_resume_irq(phydev);
>  		return 0;
> +	}
>  
>  	if (!phydev->suspended_by_mdio_bus)
>  		goto no_resume;

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch. Further
down in mdio_bus_phy_resume(), the error returns skip
mdio_bus_phy_resume_irq():

drivers/net/phy/phy_device.c:mdio_bus_phy_resume() {
    ...
	ret = phy_init_hw(phydev);
	if (ret < 0)
		return ret;

	ret = phy_resume(phydev);
	if (ret < 0)
		return ret;
no_resume:
	mdio_bus_phy_resume_irq(phydev);
    ...
}

On a PHY without MAC-managed PM, what happens if phy_init_hw() or
phy_resume() fails? irq_suspended would stay true, so every later PHY
interrupt is postponed. If a postponed interrupt had set irq_rerun, its
disable_irq_nosync() would never be undone, which leaves the PHY line
disabled after resume, along with any other users of a shared line. The
state machine is not restarted either.

This lasts until a later suspend/resume cycle completes cleanly. The new
noirq enable/disable pair runs before mdio_bus_phy_resume(), so it stays
balanced and does not make this worse. Should these error paths still go
through mdio_bus_phy_resume_irq()?

> @@ -446,8 +452,46 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
>  	return 0;
>  }
>  
> -static SIMPLE_DEV_PM_OPS(mdio_bus_phy_pm_ops, mdio_bus_phy_suspend,
> -			 mdio_bus_phy_resume);
> +static __maybe_unused int mdio_bus_phy_suspend_noirq(struct device *dev)
> +{
> +	struct phy_device *phydev = to_phy_device(dev);
> +	struct irq_data *d;
> +
> +	mutex_lock(&phydev->irq_pm_lock);
> +	/* We enable the line a postponed interrupt disabled if the irq core
> +	 * armed it for wakeup, so that it wakes the system.
> +	 */
> +	if (phydev->irq_rerun) {
> +		d = irq_get_irq_data(phydev->irq_rerun_line);
> +		if (d && irqd_irq_disabled(d) && irqd_is_wakeup_armed(d)) {
> +			enable_irq(phydev->irq_rerun_line);
> +			phydev->irq_wake_enabled = true;
> +		}
> +	}

[Severity: Medium]
Can this enable_irq() unmask a line whose PHY interrupt source was never
acked?

The postponed branch of phy_interrupt() does no MDIO access. The PHY's
latched status (BCM54xx ISR, RTL8211F INSR) stays set, and the PHY keeps
INT asserted. With the new !phydev->mac_managed_pm check, no wakeup is
reported either.

Before this patch, MAC-managed PHYs were not postponed. Their
handle_interrupt() ran and acked the status.

On a level-triggered line, would enable_irq() here go straight to
irq_pm_check_wakeup() -> pm_system_irq_wakeup() and abort the suspend?

With stmmac this could happen on every attempt. stmmac sets
wol_phy_speed_ctrl, and phylink_suspend() renegotiates the link after
phylink_stop(). The PHY is a child of the MAC's MDIO bus, so it is
already postponing by then:

drivers/net/phy/phylink.c:phylink_suspend() {
    ...
	} else {
		phylink_stop(pl);
	}

	if (phylink_phy_pm_speed_ctrl(pl))
		phylink_speed_down(pl, false);
}

rtl8211f_suspend() masks link interrupts and reads INSR before this
point, but bcm54xx_suspend() does not when WoL is enabled:

drivers/net/phy/broadcom.c:bcm54xx_suspend() {
    ...
	ret = bcm_phy_read_exp(phydev, BCM54XX_WOL_INT_STATUS);
	if (ret < 0)
		return ret;

	if (phydev->wol_enabled)
		return bcm54xx_set_wakeup_irq(phydev, true);
    ...
}

Meanwhile bcm_phy_set_wol() wake-arms the shared link/WoL line:

	if (phy_interrupt_is_valid(phydev))
		enable_irq_wake(phydev->irq);

On bcmgenet, bcmasp and bcmsysport, which set mac_managed_pm and use
these PHYs, a remote link change inside this window would now abort the
suspend once. Previously the interrupt was simply acked. The commit
message says PHY drivers have to restrict the interrupt to Wake-on-LAN in
their suspend callback. Should the drivers that don't do this be updated
in the series?

On an edge-triggered line, the commit message says:

    An edge the postponed interrupt consumed does not repeat, so
    on an edge-triggered line a magic packet that arrives during the
    transition does not abort it; the next one wakes the system.

Does this hold for PHYs that keep INT asserted until the status register
is read, such as RTL8211F INTB/INSR? The postponed interrupt never reads
the status. After enable_irq() there would be no new edge and nothing
pending to resend, and no wakeup was reported for a MAC-managed PHY. Could
Wake-on-LAN then stay lost for the whole sleep?

These callbacks are also installed as freeze_noirq/thaw_noirq through
SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(), so hibernation image creation looks
exposed to the same aborts.

> +	mutex_unlock(&phydev->irq_pm_lock);
> +
> +	return 0;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119-b4-phylib-mac-pm-irq-v3-v7-0-d8b8f43b5a62%40iav.lv
