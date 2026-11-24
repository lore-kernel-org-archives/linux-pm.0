Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795482703;
	b=FKu9xEdAc9u83H4ceZxolPhDSZpTKUTDq1ZwPUGYqUVraSXgXYyN4b0V5dqaMvjGujOF
	 dqZwlWP/qlGQmhsLXCgi7xUFwRvLqgAIPpc9jTjRVsOa1VEgVPjUPWuq23wdOywFWDgye
	 D8aCxdk6cEes4X7xJsE8H9N7MuIMkSbQQPL7X62mFQglt4591F1N7za3pRFeQJxo7Pj7U
	 pz9mke4N4p4b5PzB8PFi7os62q+TW0knBjz7HKF9yXbqRSm8JxjDErg46KvQPWUZSt69T
	 D7PCBwkXqvC+Ne0dDvZezuwpgYVqGhRbs3daUMG01BS/18LQY1U73/tHAb0oV0V2OAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795482703;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=WkI4I6NJriXzVJrvHS2kwO/ef4qsDiCv3Sr47ck9xgg=;
	b=iwW+aiCGNC0Fk65usCRVF5Bp3K60hYeegrPRcrCYJwYLUCTmKrpVv9XSsUufYmaHI3nY
	 MeM2ah3OSetAy94tXgfdRpbqzQmmGL4wgQz6Mp1h3ZsMP4hYWnXHVBAQGy6SYfxXG2X2R
	 lM9uf1vpNlEgotY1Fbhqml84uCodC1nEHd7XyGW/64Dv9tbl57OI7qMwVm2AaeHqqnVdu
	 gCgCtF/l0vqQFYxxw68cs2tPX94wSzHGXRWXYgrwY+OhyoDLrtFnTB/gP1V144AkMz0n5
	 PUxJ2JdoCgbv7WGu+iv9+PWCxBs/UpIGrKVnSOVMV/z6YuM35jYaD/JTbvvsgNlxBBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oy7Fgvla;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF1C606A33D;
	Tue, 24 Nov 2026 01:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oy7Fgvla
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B83A1F000C4;
	Tue, 24 Nov 2026 01:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795482703;
	bh=WkI4I6NJriXzVJrvHS2kwO/ef4qsDiCv3Sr47ck9xgg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oy7Fgvla55Qb++UTk3QCQqqPV9lD59VpG+D0mqz1PcWI2C74mmCCriiAgDNJKukto
	 I5TK70+AGzGxXDX1hT+pc2aYHwLqtmtLfJ/mSGy/enRdYopodGE5C/u0eeLHjq0Bao
	 +k5hRA0Qdp5rNDGbXhJ5XcERTUCtIMGjmC0PtJFte66Qro3b1YHz2LtGn53hYhlpUq
	 5DgHIIwbN+p4J59Zn4DEWNrhbUFSqCSuuksmk8fmk1bGRxkkhTf7PYjeGVziyYL9HO
	 EC42GZrSn0DCWU1XlNaCudsjaWt3FUaIVNtmMunH8VRfkkjnM0yJSqYT4plRjY76/0
	 A5i8SBnp61E8g==
Subject: Re: [PATCH net v8 4/5] net: phy: run a postponed PHY interrupt
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
Date: Tue, 24 Nov 2026 01:11:41 +0000
Message-ID: <179548270110.3135.13757603939004535921@kernel.org>
In-Reply-To: <20261123-b4-phylib-mac-pm-irq-v3-v8-4-e9f706e79614@iav.lv>
References: <20261123-b4-phylib-mac-pm-irq-v3-v8-4-e9f706e79614@iav.lv>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch's only protection against running the handler on a
  PHY that has freed its interrupt is the phydev->interrupts bit, and…
- [Medium] The new check in mdio_bus_phy_resume_irq() reads
  phydev->interrupts under irq_pm_lock, and phy_free_interrupt() writes…
- [Low] irq_pm_lock now does more than its documentation says, and its
  two descriptions disagree.

--

net: phy: run a postponed PHY interrupt handler directly on resume

This commit replaces irq_wake_thread() in mdio_bus_phy_resume_irq() with
a direct call to the PHY driver's handle_interrupt(), so that a postponed
interrupt on a nested threaded line is not lost. The handler is skipped
when phydev->interrupts is clear, as after phy_free_interrupt(). The
handler call and phy_disable_interrupts() in phy_free_interrupt() both
run under irq_pm_lock.

> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 92ee4651bdbc6..6cc94b525e093 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -1516,9 +1516,8 @@ EXPORT_SYMBOL(phy_request_interrupt);
>   */
>  void phy_free_interrupt(struct phy_device *phydev)
>  {
> -	phy_disable_interrupts(phydev);
> -
>  	mutex_lock(&phydev->irq_pm_lock);
> +	phy_disable_interrupts(phydev);
>  	free_irq(phydev->irq, phydev);
>  	/* free_irq() shuts down a line left without users and the next request
>  	 * resets its depth; mdio_bus_phy_resume_irq() enables a shared line.
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
> +			mutex_lock(&phydev->lock);
> +			phydev->drv->handle_interrupt(phydev);
> +			mutex_unlock(&phydev->lock);
> +		}

[Severity: Medium]
Can phydev->interrupts reliably tell us that the PHY still has its
interrupt requested at this point?

The commit message says the handler is skipped "unless the PHY has its
interrupts disabled, as after phy_free_interrupt()". Some PHY driver
resume callbacks set the bit again based only on the irq number. For
example, kszphy_resume() in drivers/net/phy/micrel.c:

	/* Enable PHY Interrupts */
	if (phy_interrupt_is_valid(phydev)) {
		phydev->interrupts = PHY_INTERRUPT_ENABLED;
		if (phydev->drv->config_intr)
			phydev->drv->config_intr(phydev);
	}

dp83867_resume() and the mv88q2xxx resume callback do the same thing.
phy_disconnect()->phy_free_interrupt() leaves phydev->irq valid, so
phy_interrupt_is_valid() still passes after the free.

mdio_bus_phy_resume() runs these callbacks before the rerun:

mdio_bus_phy_resume()
    phy_init_hw()
    phy_resume()
        __phy_resume()
            drv->resume()          /* interrupts = 1 */
no_resume:
    mdio_bus_phy_resume_irq()

Take a PHY that the MDIO bus suspended, on a shared line:

1. A postponed interrupt sets irq_rerun.
2. phy_free_interrupt() sets interrupts = 0. Another user still holds
   the line, so irq_has_action() is true and irq_rerun stays set.
3. On resume, the driver's resume callback sets interrupts back to 1.
4. mdio_bus_phy_resume_irq() sees irq_rerun set, irq equal to
   irq_rerun_line and interrupts == 1, so it calls handle_interrupt().

Another patch in this series, "net: phy: fix three paths that unbalance
a postponed PHY interrupt line", says that phy_free_interrupt() can run
between the postponed interrupt and mdio_bus_phy_resume().

Before this patch, irq_wake_thread() on a freed action did nothing.
Could the handler now do MDIO reads and acks, and call
phy_trigger_machine() or phy_error(), on a PHY that is detached and no
longer uses the line?

Would it be safer to gate on a state that only phy_request_interrupt()
and phy_free_interrupt() write, rather than on a field that drivers set
directly?

[Severity: Medium]
Is this read of phydev->interrupts really serialized against the write in
phy_free_interrupt()? interrupts is still a 1-bit bitfield in struct
phy_device:

	/* Interrupts are enabled */
	unsigned interrupts:1;
	/* Not bitfields: phy_interrupt() and the PM callbacks write them
	 * without phydev->lock
	 */

It shares a word with suspended, suspended_by_mdio_bus, wol_enabled,
autoneg, link, autoneg_complete, pause and asym_pause. Several of those
are written under other locks, or under no lock:

- mdio_bus_phy_resume() writes suspended_by_mdio_bus = 0 with no lock
- phy_init_hw() writes suspended = 0 with no lock
- __phy_resume() writes suspended under phydev->lock only
- phy_attach_direct() and phy_request_interrupt()->phy_enable_interrupts()
  write interrupts outside irq_pm_lock

A bitfield store is a read-modify-write of the whole word. Can a
concurrent store to a neighbouring bit undo the interrupts = 0 written by
phy_free_interrupt()?

resume path                          phy_free_interrupt()
  load word (interrupts == 1)
                                       interrupts = 0
                                       free_irq() (shared, irq_rerun kept)
  store word (stale interrupts == 1)
mdio_bus_phy_resume_irq()
  handle_interrupt() on the freed PHY

The series gives one way for phy_free_interrupt() to run in that window:
dev_close() from stmmac_reset_subtask() on a workqueue that does not
freeze.

The earlier patch "net: phy: move irq_suspended and irq_rerun out of the
bitfield" moved fields out of this word for the same reason: "one
read-modify-write can undo another". The end of the series still leaves
interrupts as a bitfield.

If this bit is now the gate checked under irq_pm_lock, should it get the
same treatment? Alternatively, could the gate use a separate field that
is not a bitfield?

>  	}
>  	mutex_unlock(&phydev->irq_pm_lock);
>  }
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index d84f7d8bc9df8..9253a07e84be2 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -677,7 +677,7 @@ struct phy_oatc14_sqi_capability {
>   * @lock:  Mutex for serialization access to PHY
>   * @irq_pm_lock: Held by the PM callbacks, and by the requesting and freeing
>   *               of the interrupt where they test and clear @irq_rerun;
> - *               phy_interrupt() never takes it
> + *               taken before @lock; phy_interrupt() never takes it

[Severity: Low]
This isn't a bug, but the two descriptions of irq_pm_lock no longer
match. The kernel-doc gains "taken before @lock", but the inline comment
on the field is unchanged:

	struct mutex lock;
	/* Held where the PM callbacks and the requesting and freeing of the
	 * interrupt test and clear irq_rerun
	 */
	struct mutex irq_pm_lock;

Neither comment says that the lock now serializes drv->handle_interrupt()
in mdio_bus_phy_resume_irq() against phy_disable_interrupts() in
phy_free_interrupt(). Neither says that it covers the phydev->interrupts
check either. Later in the series both comments gain irq_wake_enabled.
They still don't describe this serialization, and the inline comment
still lacks the lock ordering rule.

Could both comments be updated, so that a later change doesn't move
phy_disable_interrupts() back out of the critical section?

>   * @state_queue: Work queue for state machine
>   * @link_down_events: Number of times link was lost
>   * @shared: Pointer to private data shared by phys in one package

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123-b4-phylib-mac-pm-irq-v3-v8-0-e9f706e79614%40iav.lv
