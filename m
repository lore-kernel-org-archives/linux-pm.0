Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795482701;
	b=A2LhxGrABOq6ofvbx6ig6duANcmcjle7PyAzrdQYMmFZNVwX8pV8gWYLDzrgBCJfDwkG
	 iZ/fT5jpeA+LPZ8kTipqCSfy09rCYvrTlJYoWV/Tp5Pv3GYfliwPlG/Pa1rEbNbI0ckg2
	 xu6FGLWRt2UQBAQjEIxjE4wn2J7xa2RnXmO+eqr9/pOogMVBnH8lzdTHuSF8nxGQyEqWJ
	 gowb6y+0CYcMJfhzTDpIJgdLnomsiuYK7lSi7P6lG/KBvVbnwsqxgVSbP6NNY/gubJtiz
	 0A4kUU+qFCZJ67gFgAuutg9lxZtSQLWGYac+7BfY8D00MeMwl+JMiX2JCHkSkHLRdhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795482701;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=9lAmnY0HIpYmTeF/IxGyjv8+ERd8Ma5TlxCZYcsa8bU=;
	b=YzaZJeLYXmNLw1jA6bOFEXb4JWchvS2/o2W2IjYEFmyid9IVUpfDORhFv4N6QvvaSIun
	 KC89upRO0Aettlht6xlD4mr7xx7GMgBOVU6gzWemz+FloVVkylnnEZrje4gSzSV4F1yaF
	 1sqS8+d/YBay4olyJM7GlNbVD9rmkvhC+EAPOIUjuJ/CjMqSDS8Uc6Fg7WtsqLXwOi17D
	 G/JHZIJnX3BPK7yo2NLKb/8WmHXURjLFjwnYRRPCRkJuEYkn2Z7S1JJED6MWsV4JADOYq
	 CN7Myp/Sn1iyoq1Jg3cIncMIuj+/qxyFEm0ZsKYlOS/fNonbOpermvG2qKQBSoQC09Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z54v1rti;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5DF606A31E;
	Tue, 24 Nov 2026 01:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z54v1rti
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444221F000D0;
	Tue, 24 Nov 2026 01:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795482700;
	bh=9lAmnY0HIpYmTeF/IxGyjv8+ERd8Ma5TlxCZYcsa8bU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z54v1rtihvXbC2qsVKbn+KMVK4WZsIHWURL3MXomtuUzQe7sk5WyDzWEEcvXp+rfl
	 rdKrwZoeg78ImLDSqk2Xyc/RdMvCvD+uoENCQ0lm+hNXVCQ75/zr1pckOdj9l7bv0Q
	 ZXWgVYYAm0+zJ3qOTd+eHMTdw/9m5KjdGztqGPFBQ7QMkH/k/b02QtDEkutdwsjHM2
	 AbW6b0mEZxgkA0us0h9LaT4k5O0sEYwoi0Zy7tSUeyuqE2RDWUriE1ZQ4BaIUKxUEt
	 BIIlUYP8L48QSB5dKylJ2yJEwn/VQyodWN6ef9jcWTfED23GuvUpxj2/tCpIFuG14V
	 f2PwVQGgfg8hg==
Subject: Re: [PATCH net v8 2/5] net: phy: fix three paths that unbalance a
 postponed PHY interrupt line
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
Date: Tue, 24 Nov 2026 01:11:38 +0000
Message-ID: <179548269886.3135.1487195148841555901@kernel.org>
In-Reply-To: <20261123-b4-phylib-mac-pm-irq-v3-v8-2-e9f706e79614@iav.lv>
References: <20261123-b4-phylib-mac-pm-irq-v3-v8-2-e9f706e79614@iav.lv>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] phy_request_interrupt() and phy_free_interrupt() use different
  lines to decide whether this PHY's postponed disable is still counted.
- [Medium] The new gate in phy_interrupt() ('if (!phydev->irq_rerun) {
  ... disable_irq_nosync(irq); }') only disables the line when irq_rerun…
- [Medium] mdio_bus_phy_resume_irq()
  (drivers/net/phy/phy_device.c:359-361) calls…

--

net: phy: fix three paths that unbalance a postponed PHY interrupt line

This commit changes phy_interrupt() so that only the first postponed run
disables the PHY interrupt line, and it records which line was disabled.
irq_rerun is now cleared in phy_free_interrupt() and
phy_request_interrupt() when the line has no users. The commit also adds
irq_pm_lock to serialize those paths against the rerun in
mdio_bus_phy_resume_irq().

> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 9af303d60bd6b..92ee4651bdbc6 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c

[ ... ]

> @@ -1430,8 +1430,12 @@ static irqreturn_t phy_interrupt(int irq, void *phy_dat)
>  				pm_wakeup_dev_event(parent, 0, true);
>  		}
>  
> -		phydev->irq_rerun = true;
> -		disable_irq_nosync(irq);
> +		/* Disable the line only once: an edge can rerun the thread. */
> +		if (!phydev->irq_rerun) {
> +			phydev->irq_rerun_line = irq;
> +			phydev->irq_rerun = true;
> +			disable_irq_nosync(irq);
> +		}
>  		return IRQ_HANDLED;
>  	}

[Severity: Medium]
Can a stale irq_rerun here turn a stuck line into an interrupt storm?

irq_pm_lock only serializes this PHY's own request, free and resume paths.
Other drivers on a shared line call request_irq() and free_irq() without
it. phy_request_interrupt() also drops the lock before
request_threaded_irq().

The commit message lists three windows where irq_rerun stays true after
the line is back at depth 0 with this PHY's handler registered. One
example is another user requesting the line first after all users freed
it. In that state, a later postponed interrupt returns IRQ_HANDLED without
disabling the line and without reading the PHY.

On a level-triggered IRQF_ONESHOT line, irq_finalize_oneshot() then
unmasks the line. The PHY source is still asserted, so the line fires
again, and this continues until mdio_bus_phy_resume_irq() clears
irq_suspended. The handler returns IRQ_HANDLED, so note_interrupt() never
treats these as spurious.

After that, mdio_bus_phy_resume_irq() calls enable_irq() on a depth-0
line, which hits WARN("Unbalanced enable for IRQ") in __enable_irq().

One path that seems to reach this, once the later patch in the series
puts mac_managed_pm PHYs under postponing:

  shared PHY line, postponed interrupt sets irq_rerun
  MAC closes in suspend (cpsw, ravb, or stmmac_reset_subtask())
    -> phy_disconnect() -> phy_free_interrupt()
       other users remain, irq_rerun kept
  other users free the line
  another user requests the line first
  MAC resumes before the PHY and re-requests while irq_suspended is set
  PHY level interrupt asserts

Before this patch, every postponed run disabled the line again. In this
case the line could get stuck, but it could not storm.

The commit message acknowledges "a level-triggered one keeps firing". Is
that an acceptable trade-off compared with the old behaviour here?

> @@ -1480,6 +1484,12 @@ void phy_request_interrupt(struct phy_device *phydev)
>  {
>  	int err;
>  
> +	/* A line without users restarts at depth 0, so our disable is gone */
> +	mutex_lock(&phydev->irq_pm_lock);
> +	if (phydev->irq_rerun && !irq_has_action(phydev->irq_rerun_line))
> +		phydev->irq_rerun = false;
> +	mutex_unlock(&phydev->irq_pm_lock);
> +
>  	err = request_threaded_irq(phydev->irq, NULL, phy_interrupt,
>  				   IRQF_ONESHOT | IRQF_SHARED,
>  				   phydev_name(phydev), phydev);
> @@ -1507,7 +1517,15 @@ EXPORT_SYMBOL(phy_request_interrupt);
>  void phy_free_interrupt(struct phy_device *phydev)
>  {
>  	phy_disable_interrupts(phydev);
> +
> +	mutex_lock(&phydev->irq_pm_lock);
>  	free_irq(phydev->irq, phydev);
> +	/* free_irq() shuts down a line left without users and the next request
> +	 * resets its depth; mdio_bus_phy_resume_irq() enables a shared line.
> +	 */
> +	if (!irq_has_action(phydev->irq))
> +		phydev->irq_rerun = false;

[Severity: Medium]
Should this check use phydev->irq_rerun_line rather than phydev->irq?

phy_request_interrupt() tests irq_has_action(phydev->irq_rerun_line),
which is the line phy_interrupt() actually disabled. This check tests the
line that was just freed. mdio_bus_phy_resume_irq() also expects the two
to differ:

    if (phydev->irq == phydev->irq_rerun_line)

phydev->irq can change from the disabled line A to another valid line B
between the postponed interrupt and resume. phy_detach() resets it:

    phydev->irq = phydev->mdio.bus->irq[phydev->mdio.addr];

Some MAC drivers, such as mlxbf_gige, lan78xx and smsc95xx, also write
phydev->irq directly.

In that case, freeing B clears irq_rerun because B has no users. That
free could come from the phy_enable_interrupts() failure fallback in
phy_request_interrupt(), or from a later disconnect. Line A still carries
this PHY's disable_irq_nosync() depth. mdio_bus_phy_resume_irq() would
then skip enable_irq(A), and A would stay disabled for its other users.

I couldn't find an in-tree path that switches phydev->irq between two
different valid lines within one sleep transition, so this may be
theoretical. Even so, the two checks disagree.

Would testing irq_rerun_line here, or requiring phydev->irq ==
phydev->irq_rerun_line, make them consistent?

> +	mutex_unlock(&phydev->irq_pm_lock);
>  }
>  EXPORT_SYMBOL(phy_free_interrupt);
>  
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 1791d578f4dde..f2e2370b4be7c 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -332,6 +332,39 @@ static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)

[ ... ]

> +/* Rerun interrupts which were postponed by phy_interrupt()
> + * because they occurred during the system sleep transition.
> + */
> +static __maybe_unused void mdio_bus_phy_resume_irq(struct phy_device *phydev)
> +{
> +	WRITE_ONCE(phydev->irq_suspended, false);
> +
> +	mutex_lock(&phydev->irq_pm_lock);
> +	if (phy_interrupt_is_valid(phydev))
> +		synchronize_irq(phydev->irq);
> +	/* The PHY may have fallen back to polling since it disabled the line */
> +	if (phydev->irq_rerun) {
> +		phydev->irq_rerun = false;
> +		enable_irq(phydev->irq_rerun_line);

[Severity: Medium]
Is this PHY's disable still counted in the line's depth when this
enable_irq() runs?

phy_free_interrupt() keeps irq_rerun on purpose when other users still
hold the shared line. If those users then free the line, irq_shutdown()
runs. The next first request from another driver calls irq_startup(),
which resets depth to 0 and discards this PHY's disable.

The only re-check is in phy_request_interrupt(). It only helps if this
PHY re-requests before its own resume callback runs:

  phy_interrupt() postpones, disable_irq_nosync(A), irq_rerun = true
  MAC close in suspend -> phy_disconnect() -> phy_free_interrupt()
    other users remain, irq_rerun kept
  other users free A -> irq_shutdown()
  another driver requests A on resume -> irq_startup(), depth = 0
  mdio_bus_phy_resume() -> mdio_bus_phy_resume_irq()
    enable_irq(A), before this PHY calls phy_request_interrupt()

This ordering seems possible in two cases:

  - The PHY sits on an MDIO bus owned by a different MAC, and the device
    link resumes the PHY before its consumer MAC reopens.
  - The MAC's reopen fails.

At depth 0 this hits WARN("Unbalanced enable for IRQ") in __enable_irq().
If the other driver holds its own disable_irq() at that moment (depth 1),
wouldn't this enable_irq() call irq_startup() and cancel that driver's
disable?

If the line still has no users at that point, the enable is harmless,
because irq_shutdown() incremented depth.

This seems to be a gap in the second case the commit message says it
fixes, separate from the three windows it documents.

> +		if (phydev->irq == phydev->irq_rerun_line)
> +			irq_wake_thread(phydev->irq, phydev);
> +	}
> +	mutex_unlock(&phydev->irq_pm_lock);
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123-b4-phylib-mac-pm-irq-v3-v8-0-e9f706e79614%40iav.lv
