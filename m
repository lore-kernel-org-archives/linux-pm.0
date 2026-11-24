Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795482705;
	b=3YJy51jj9Rul3gHY77UUZk7Qp9N89vlXG95twJLx56fXovXMNnl6gP7lYO2wIi5kBITe
	 NI07gNyCDdhVAV2hGcpFlTZ8Axsn1IfDMnvLT+KTQbOgSfutbngr2CtgAZjiJixBZWZhg
	 YQvCq3pjJhnNz/9wS6EOvn8lS02YYodJFq3Z0DnMMvTxTuGjCgMO3dBnNNba2DMZ3W5o4
	 N9cl7LXyTBHYKOBePAc0JDcYwlh3YS/J54Dm2YD0M9oELB3sr8iwyVACD29yMon+tFueA
	 rcJLYBdslYON0nAILAHYF9GQkM+8PfqJayy0+tF4GR47YNdJQ+U0grxZGZ9xeDTxulQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795482705;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fG+e0SZ/Vty3N1wlRogfG9N5LAKYiGKy+6hsfHYsEwA=;
	b=nt5XaD8aaLGHC+OXPAjumMMLJWGW/KySwpbSqTAPBlDa+VTMBvrqSjdD0aTcpd3u6rZj
	 mNtUbJXo9EshlENYe2me3auA770kzoPH3eJ0rXuxxJD0uDNCUM6vOtyOmdfEKFzwm2iQH
	 rjxWL+fjJ8Hxg3NAm5fiNlZPJXnWSag9ivcF8683r21TRJxE/lPFDfFst/A49CyVBawts
	 arGhakiQnCTlZkraNk0ZhhJLmVdTTNdjQgWuN4aO1GRpMdZuDe+tGKRuSfYPeEHSBWOXP
	 2XHtEvLE2aasJ570RiF5PUScQvIDSYHstfeHdoSsrtrD/cB3mUx+UmmBS4Hzz/NjiRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pj2A6hsd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B070606A326;
	Tue, 24 Nov 2026 01:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pj2A6hsd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC571F0093E;
	Tue, 24 Nov 2026 01:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795482705;
	bh=fG+e0SZ/Vty3N1wlRogfG9N5LAKYiGKy+6hsfHYsEwA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Pj2A6hsd0UwcWn/oOSM3C3MY/DOVVSg6fe3zv3wK8kmwf+L3rqFNlYrbdkbsHnkS1
	 xapy/UlUhOv6OpJvlAfJHrPWxjFwl3C7Us/VFEuaRSt/LoxnBvJioml+1567EyQ92B
	 dInlyRtW+j+Tg/gY1o8ctCcsQK13iXTo8OAKDz/cWbRaQHqt7eWqnm4VSFjQ9j6YZU
	 JWPLUQSBZhVpeIp0Vh9DblXtYsf+qkPBPlhZqkMftYwdd1RpTi0hSW/yS36HcDO2Kg
	 nvxHRIfZXOmgVF5VGL7jonRbXuYo/v0JVNozbbb2raRX/hxUvM4nppenPXMfE5IBlj
	 qOsf9V5TtuiwQ==
Subject: Re: [PATCH net v8 5/5] net: phy: postpone PHY interrupts during sleep
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
Date: Tue, 24 Nov 2026 01:11:43 +0000
Message-ID: <179548270352.3135.4334710117066284426@kernel.org>
In-Reply-To: <20261123-b4-phylib-mac-pm-irq-v3-v8-5-e9f706e79614@iav.lv>
References: <20261123-b4-phylib-mac-pm-irq-v3-v8-5-e9f706e79614@iav.lv>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On a level-triggered wake line, a Broadcom BCM54210E PHY under
  stmmac with PHY Wake-on-LAN now aborts every suspend.
- [Medium] The noirq wake fix does not work for nested-threaded PHY
  interrupt lines, which the series explicitly supports (commit "net:…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the new
  replay still does MDIO access before the MAC has resumed in some…

--

net: phy: postpone PHY interrupts during sleep with MAC-managed PM

For PHYs with MAC-managed PM, this patch postpones PHY interrupts from the
prepare callback and replays them from mdio_bus_phy_resume(). If a
transition aborts, the complete callback stops the postponing. New noirq
callbacks re-enable a line that a postponed interrupt disabled, when the
irq core has armed it for wakeup, and disable it again on noirq resume.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 8bc394ff7d2d2..082ae31c22341 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

[ ... ]

> @@ -414,8 +445,10 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
>  	struct phy_device *phydev = to_phy_device(dev);
>  	int ret;
>  
> -	if (phydev->mac_managed_pm)
> +	if (phydev->mac_managed_pm) {
> +		mdio_bus_phy_resume_irq(phydev);
>  		return 0;
> +	}

[Severity: Medium]
This is a pre-existing issue, not one this patch introduces, but in some
topologies the replay here can still reach the MDIO bus before the MAC has
resumed.

phy_attach_direct() can add a device link between the MAC and the PHY:

	if (dev && phydev->mdio.bus->parent && dev->dev.parent != phydev->mdio.bus->parent)
		phydev->devlink = device_link_add(dev->dev.parent, &phydev->mdio.dev,
						  DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);

The PHY is then the supplier, so it resumes before the MAC, and this path
runs first:

mdio_bus_phy_resume()
  mdio_bus_phy_resume_irq()
    phydev->drv->handle_interrupt()   /* MDIO read */

The MAC's resume callback has not restored its MDIO controller at that
point. The same thing happens in the parent-child topology when the MAC's
resume callback fails, because the PM core still resumes the children.

Could a MAC that gates its MDIO clocks in its regular suspend callback,
and whose MDIO accessors are not guarded by runtime PM, stall on this
access?

The commit message already describes this limitation. Before this patch
the handler ran even earlier, from resume_device_irqs(). Now it runs after
device_resume_early() has re-enabled runtime PM, and stmmac's MDIO
accessors call pm_runtime_resume_and_get(). So the patch moves the access
later and does not widen exposure.

I could not find an in-tree board that pairs this topology with such a
MAC. I am listing it for completeness only.

[ ... ]

> @@ -446,8 +479,48 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
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
Can this abort every suspend for a Broadcom BCM54210E behind stmmac with
PHY Wake-on-LAN on a level-triggered line?

bcm_phy_set_wol() selects INTR on LED4 and makes the main PHY interrupt
the wake IRQ:

drivers/net/phy/bcm-phy-lib.c:bcm_phy_set_wol() {
    ...
	if (phy_interrupt_is_valid(phydev))
		enable_irq_wake(phydev->irq);
    ...
}

When Wake-on-LAN is enabled, bcm54xx_suspend() does not restrict
MII_BCM54XX_IMR, so link, speed and duplex interrupts stay on INTR:

drivers/net/phy/broadcom.c:bcm54xx_suspend() {
    ...
	if (phydev->wol_enabled)
		return bcm54xx_set_wakeup_irq(phydev, true);
    ...
}

stmmac sets mac_managed_pm and wol_phy_speed_ctrl, so the sequence looks
like this:

stmmac_suspend()
  phylink_suspend()
    phylink_stop()->phy_stop()->phy_suspend()->bcm54xx_suspend()
    phylink_speed_down()   /* restarts autoneg, raises a link interrupt */

phy_interrupt()
  irq_suspended already set by mdio_bus_phy_prepare()
  MII_BCM54XX_ISR is not read, disable_irq_nosync()

suspend_device_irqs()
  sets IRQD_WAKEUP_ARMED on the line

mdio_bus_phy_suspend_noirq()
  line is disabled and armed, so enable_irq()
  the level interrupt is still asserted
    irq_pm_handle_wakeup()->pm_system_irq_wakeup()
    suspend aborts

The next attempt repeats the speed down. Would the system ever stay
suspended in this configuration?

The commit message says "its driver has to restrict the interrupt to
Wake-on-LAN in its suspend callback, as rtl8211f_suspend() does". The
Broadcom driver sets PHY_ALWAYS_CALL_SUSPEND, so bcm54xx_suspend() does
run, but it does not restrict the interrupt this way.

I could not find an in-tree board with this exact combination. Before this
patch, the link-up interrupt after renegotiation may already have caused a
spurious wakeup once the system was asleep. So this may mostly change how
the configuration fails, but the noirq re-enable here makes the abort
newly reachable.

Should bcm54xx_suspend() mask the non-WoL interrupt sources as well?

[Severity: Medium]
Can the irqd_is_wakeup_armed() check ever pass for a nested-threaded PHY
line, such as one behind an I2C or SPI expander? Other patches in this
series explicitly support such lines.

suspend_device_irqs() skips nested-thread descriptors:

kernel/irq/pm.c:suspend_device_irqs() {
    ...
		if (irq_settings_is_nested_thread(desc))
			continue;
    ...
}

So IRQD_WAKEUP_ARMED is never set on them, even after irq_set_irq_wake()
has set IRQD_WAKEUP_STATE.

With this patch a MAC-managed PHY is postponed from mdio_bus_phy_prepare(),
so any PHY interrupt during the transition calls disable_irq_nosync() on
the nested line.

Some parent chips implement .irq_disable, such as regmap-irq with
regmap_irq_disable(). On those, the disable masks the PHY's source in the
parent's hardware.

mdio_bus_phy_suspend_noirq() then skips enable_irq(), and the source stays
masked through sleep. A later Wake-on-LAN event from the PHY never asserts
the parent's wake-armed line, and the system keeps sleeping.

Isn't this the "would sleep through a wakeup" case the noirq callbacks are
meant to close? Could the check fall back to irqd_is_wakeup_set() for
nested-thread lines?

Lazy-disable parents that implement only irq_mask, such as pca953x, are
not affected, because the pin stays unmasked. I could not confirm an
in-tree board that combines a MAC-managed PHY with such a parent irqchip
and Wake-on-LAN.

> +	mutex_unlock(&phydev->irq_pm_lock);
> +
> +	return 0;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123-b4-phylib-mac-pm-irq-v3-v8-0-e9f706e79614%40iav.lv
