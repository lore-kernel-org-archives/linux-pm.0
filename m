Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795384989;
	b=TZMgXM0BK5iK6dObeulHzC0Dlr6g0ZWVqkKpCg7/D047C2je5wLSnZe3ccE+vC2vN35z
	 W7aWObxXr2vBqZomFv/YX/QgG1p1HK0YoAdKRXRhInoPL4hShOn1ys20rZdx0hq/fgUcv
	 SmkFPaMLZDouIUJPkUEsxzG/utiNiS/SKb3teEwgaKnS1BDNJn0UU2Gt+cdrs9ksucmKt
	 xBjwH/utJwYuTXqnwf/vcKg8Wp+XckCYNn8M/0NB8kQXUuKlkUdTzq3Q/qwgvg0+JRDOc
	 52Qss4ENRDnIj5HYQlOpK/bEzZRiP661Po/2RJc3d4rmC/eWWF+U45H5B+m7zKNTpwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795384989;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=itJ6rSlWifvB0iE/5fGeHTiq+kZl0RGJWOk9qcBDNYw=;
	b=MgZWd26zmYRAhPxO4cJVa7p41edlf3wBJ0/J3TZNVCPot28DyfILj+BkBgC7L496q9U7
	 pOZ/UAen5RVjSQG4/zV9NoS1jclQfMlDIk98R524Ei8n6uuGV8xJPGVG93u3ZDFB2IAa3
	 VjdxhlVGO4ix2yCYykoDdd4pfa4LfNWojOkjjJhU+X/112vTRorkRE/Ftzx/HR26stwE8
	 7sUCXwj1tqC9OJNTPGy0Vjnhk9WzSTs/TlLJPwG1/DnOneLgB4QtStsweTISRGJI/p9iD
	 EFvn2DpqG3xmOJQylglwDSQvHIlERL5H+q4pbUeSf/QdldBIlYIhfNeiwRLWa9qsOwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWd2waAh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE3E606A337;
	Sun, 22 Nov 2026 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWd2waAh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0131F000D3;
	Sun, 22 Nov 2026 22:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795384988;
	bh=itJ6rSlWifvB0iE/5fGeHTiq+kZl0RGJWOk9qcBDNYw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UWd2waAhQh/gfTwZ7joJlFujdoczrMRiYiHJbd0yu9yUeS9jqAK5QO7RDFFjRZGI+
	 fxk/Gj4u/2OF67Hm/ncuoCL8Lkp1B3jiUS2sz6AiP7Vrrw+QgOUhdw5eQ4YKQGkGwE
	 IfF3n6vQcOiwy0XbDwL4c1p3fNF5/6OWhKSvpnN2DTxuMsjN7YVCt4kWnE4v2o7azx
	 NLg8CEZL4RDKD9DigBFT+v99na/+X4ZHdvzYYEoWCPtcFAAuZHX0LOqUvDqjriGBar
	 SEWKSFRP+2J6ScRSfxC39Iv4fiyfj38cxQevm1Tsx+FZHNF1BR3qTSmEfxb2YzJdag
	 scjT99ArYD2ag==
Subject: Re: [PATCH net v7 4/5] net: phy: run a postponed PHY interrupt
 handler directly on resume
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
Date: Sun, 22 Nov 2026 22:03:06 +0000
Message-ID: <179538498682.3135.2758040683110452863@kernel.org>
In-Reply-To: <20261119-b4-phylib-mac-pm-irq-v3-v7-4-d8b8f43b5a62@iav.lv>
References: <20261119-b4-phylib-mac-pm-irq-v3-v7-4-d8b8f43b5a62@iav.lv>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message claims that for a PHY without MAC-managed PM,
  mdio_bus_phy_resume() calls phy_init_hw() before the rerun, so…
- [Low] In mdio_bus_phy_resume_irq()
  (drivers/net/phy/phy_device.c:365-366), the new check `phydev->irq ==…
- [Low] The kernel-doc for @irq_pm_lock (include/linux/phy.h:678-679) and
  the comment on the member (line 814-817) say the lock 'Serializes…

--

net: phy: run a postponed PHY interrupt handler directly on resume

This commit replaces irq_wake_thread() in mdio_bus_phy_resume_irq() with
a direct call to the PHY driver's handle_interrupt() under phydev->lock.
This keeps a postponed interrupt on a nested threaded line from being
lost. The call is skipped when the PHY has freed its interrupt, and
phy_free_interrupt() now calls phy_disable_interrupts() under
irq_pm_lock.

> For a PHY without MAC-managed PM, mdio_bus_phy_resume() calls
> phy_init_hw() before the rerun, and config_intr() there acknowledges
> the latched status in drivers such as realtek. A later patch brings
> PHYs with MAC-managed PM under postponing, and stmmac, for one, does
> not call phy_init_hw() on resume.

[Severity: Low]
Is this true for every PHY without MAC-managed PM?

When mdio_bus_phy_may_suspend() returns false, mdio_bus_phy_suspend()
returns early. That happens with WoL enabled, device_may_wakeup() set on
the netdev or its parent, a PHY that is already suspended, or a driver
with no .suspend. In that case suspended_by_mdio_bus is never set:

drivers/net/phy/phy_device.c:mdio_bus_phy_suspend() {
    ...
	if (!mdio_bus_phy_may_suspend(phydev))
		return 0;

	ret = phy_suspend(phydev);
    ...
	phydev->suspended_by_mdio_bus = 1;
    ...
}

mdio_bus_phy_resume() then skips phy_init_hw() completely:

drivers/net/phy/phy_device.c:mdio_bus_phy_resume() {
    ...
	if (!phydev->suspended_by_mdio_bus)
		goto no_resume;
    ...
	ret = phy_init_hw(phydev);
    ...
no_resume:
	mdio_bus_phy_resume_irq(phydev);
    ...
}

So in the current tree, without the later MAC-managed PM patch, a
WoL-enabled PHY on a nested threaded line already loses its postponed
interrupt to irq_wake_thread(). The code change fixes this case too.

Could the commit message say that the problem exists even without the
later patch?

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 2d2058c29f300..8bc394ff7d2d2 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -355,12 +355,19 @@ static __maybe_unused void mdio_bus_phy_resume_irq(struct phy_device *phydev)
>  	mutex_lock(&phydev->irq_pm_lock);
>  	if (phy_interrupt_is_valid(phydev))
>  		synchronize_irq(phydev->irq);
> -	/* The PHY may have fallen back to polling since it disabled the line */
> +	/* The PHY may have fallen back to polling since it disabled the line,
> +	 * or freed its interrupt while another user keeps the line.
> +	 */
>  	if (phydev->irq_rerun) {
>  		phydev->irq_rerun = false;
>  		enable_irq(phydev->irq_rerun_line);
> -		if (phydev->irq == phydev->irq_rerun_line)
> -			irq_wake_thread(phydev->irq, phydev);
> +		/* A nested threaded line has no thread; we run the handler */
> +		if (phydev->irq == phydev->irq_rerun_line &&
> +		    phydev->interrupts) {

[Severity: Low]
This check treats phydev->interrupts as meaning that the PHY has not
freed its interrupt. Can a driver's .resume callback set that bit again
after phy_free_interrupt()?

mdio_bus_phy_resume() calls phy_init_hw() and phy_resume() ->
drv->resume() before mdio_bus_phy_resume_irq(). Several resume
callbacks set the bit again based only on the IRQ number:

drivers/net/phy/micrel.c:kszphy_resume() {
    ...
	/* Enable PHY Interrupts */
	if (phy_interrupt_is_valid(phydev)) {
		phydev->interrupts = PHY_INTERRUPT_ENABLED;
		if (phydev->drv->config_intr)
			phydev->drv->config_intr(phydev);
	}
    ...
}

ksz9477_resume(), ksz8061_resume(), dp83867_resume() and
mv88q2xxx_resume() do the same.

phy_free_interrupt() clears phydev->interrupts through
phy_disable_interrupts(), but it leaves phydev->irq valid. On a shared
line that still has another action, it also leaves irq_rerun set.

Consider this sequence:

  PHY suspended by the MDIO bus, postponed interrupt sets irq_rerun
  phy_disconnect() -> phy_free_interrupt(), another user keeps the line
  mdio_bus_phy_resume()
    phy_resume() -> kszphy_resume()     /* interrupts set again */
    mdio_bus_phy_resume_irq()
      phydev->drv->handle_interrupt(phydev)

Wouldn't this run the handler on a detached PHY that has no irqaction,
which is the case the new check is meant to exclude? Before this patch,
irq_wake_thread() found no action with this dev_id after free_irq() and
did nothing.

The visible effect looks small. These handlers read the status register
and call phy_trigger_machine() on a PHY in PHY_HALTED, and these
drivers' resume callbacks have just re-enabled the PHY's interrupts.

> +			mutex_lock(&phydev->lock);
> +			phydev->drv->handle_interrupt(phydev);
> +			mutex_unlock(&phydev->lock);

[Severity: Low]
Does the irq_pm_lock documentation still match the code? The kernel-doc
in include/linux/phy.h says:

 * @irq_pm_lock: Serializes requesting and freeing the interrupt against the
 *               PM callbacks; phy_interrupt() never takes it

After this patch, the free side runs entirely under irq_pm_lock, and
this new call reads phydev->interrupts under it. The request side holds
the lock only around the irq_rerun check:

drivers/net/phy/phy.c:phy_request_interrupt() {
	mutex_lock(&phydev->irq_pm_lock);
	if (phydev->irq_rerun && !irq_has_action(phydev->irq_rerun_line))
		phydev->irq_rerun = false;
	mutex_unlock(&phydev->irq_pm_lock);

	err = request_threaded_irq(phydev->irq, NULL, phy_interrupt,
    ...
		if (phy_enable_interrupts(phydev)) {
    ...
}

So request_threaded_irq() and phy_enable_interrupts() run outside the
lock, and phy_enable_interrupts() is what sets phydev->interrupts and
calls config_intr().

I could not find a concrete failure from this. A race with dev_open()
from an unfrozen workqueue either skips the handler or overlaps with
config_intr(), and phy_interrupt() can already overlap with it the same
way.

Could the comment be updated to say that only freeing is serialized?
Could it also mention the new irq_pm_lock -> phydev->lock nesting
introduced here?

>  		}
>  	}
>  	mutex_unlock(&phydev->irq_pm_lock);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119-b4-phylib-mac-pm-irq-v3-v7-0-d8b8f43b5a62%40iav.lv
