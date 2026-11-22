Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795384986;
	b=tzLPMQUaCn1y2bZzA5KPqnWRarNYZgP55qeSFlUAf3zbtFyK6ArLbn5QuEIwlnSw960l
	 tCpVtAG0h9M81kPK5bAFyJs9y3q8PCot8cEyfwiiVhOpeydzJ8MRgQqu0vbPZVz4u3lQI
	 8+9tXmgkcOoO5MfRP2c0v3tqS5tZaZm1UVOraf+YAxNzW3ToEKXwD0skIklk3NmVHur4Q
	 eo/8o7ZsK6lD1Ora+hxpmnPgg+NfvH7C+owkkr3wkpIr9AAXqtbLT9Oq/dSHJaRUSwljx
	 i+fbIj4PU0WZ41znCDrdmlJ3WHUKMA0wvpM8fvwE1r1ypL9uAGZg1d/HO5r4wAN+qLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795384986;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=VG+Q57/4+q0IcXBdN4djtbssvG0TBzutYRMG5A6OpS8=;
	b=SKYu3ufNN7nnzc/MXZuMV087uTcGVI8Gml/FTu8cuZKs+CvC3VIfXlxO2DJXklAf8PsE
	 uIkO5v0JIC3s5PPvf3deoIYzi5ITj5uHTQFj0hYRJoM1H3ob8TMzcAnKTwLy6dmV7BP3H
	 La/peCfnUeze+crtB0kdkvEohxG5nIewnm9Qh7+eNrcE+Ht9pVc/w9xa2Fw8pUqNbBxq7
	 BskeQJxroiWvEV+4zam9qyTpBiulNKRpyv2fHhyxmgJVgKFqDOhfekocFO5/A4VrSQ+1S
	 tdzWRPEs1j6MTX4PXseGt8w7q+5qqrz6OT60ad7N3tkgofzjGRhJy4kqvMsC4oUk7aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mDO2vohK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60DD606A31E;
	Sun, 22 Nov 2026 22:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mDO2vohK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5781F000C4;
	Sun, 22 Nov 2026 22:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795384986;
	bh=VG+Q57/4+q0IcXBdN4djtbssvG0TBzutYRMG5A6OpS8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mDO2vohKsSAMBeEhek/GwWQFBuSkTXzqbUQSX0KZUUWfh0WAsfMgOnjGjRxwwyyxW
	 4oJXw3mQCnzdVnVygsFsafDAFzlosWrUT3NZvJTaO0tFv10o0wz6y4wKjTznddFOoW
	 Vbtf8h/FVpGYhrg5j5i0UVNM1GwKy5vPzHTa2ufOvncCgwY9EM3Tj1wPnTToLRfTpg
	 yEYzt7D78vV9sdoWa8ozreggqgkflGS0mviMFKPYm4fxpp0SmC5BNSKqU1qfbZDDBL
	 I94D1VbDOznow8bxg6FC7f0sRbPQIM4W6k0I1aw+fEumPlHvYgC7Q0sp2x3vLNuMEV
	 UkbeGHDTdLGCw==
Subject: Re: [PATCH net v7 2/5] net: phy: fix three paths that unbalance a
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
Date: Sun, 22 Nov 2026 22:03:04 +0000
Message-ID: <179538498448.3135.18241540181099733767@kernel.org>
In-Reply-To: <20261119-b4-phylib-mac-pm-irq-v3-v7-2-d8b8f43b5a62@iav.lv>
References: <20261119-b4-phylib-mac-pm-irq-v3-v7-2-d8b8f43b5a62@iav.lv>
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

- [Medium] mdio_bus_phy_resume() (drivers/net/phy/phy_device.c) can still
  leave a postponed PHY interrupt line disabled for good.
- [Medium] Whether irq_rerun is still valid depends on whether the shared
  line was shut down and started again since this PHY disabled it.
- [Low] The new kernel-doc for irq_pm_lock (include/linux/phy.h:678) and
  the in-struct comment (include/linux/phy.h:814) say it 'Serializes…

--

net: phy: fix three paths that unbalance a postponed PHY interrupt line

With this patch, phy_interrupt() disables a postponed PHY interrupt line
only once and records which line it disabled. phy_request_interrupt() and
phy_free_interrupt() now clear irq_rerun when the line has no users. The
postpone and rerun logic moves into mdio_bus_phy_suspend_irq() and
mdio_bus_phy_resume_irq(), and a new per-PHY irq_pm_lock mutex guards it.

> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 9af303d60bd6b..92ee4651bdbc6 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c

[ ... ]

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

[Severity: Medium]
Can irq_rerun go stale on a shared line in ways the commit message does
not list?

irq_pm_lock belongs to one phydev. It does not order this check against
free_irq() or request_threaded_irq() from the other users of the line,
and a second PHY on the line has its own irq_pm_lock.

First window: PHY A postpones on line L, so irq_rerun is set and the
depth is at least 1. A then frees L while user B still holds it, so A
keeps irq_rerun. Later:

PHY A                                  user B
phy_request_interrupt()
  irq_has_action(L) == true
  mutex_unlock(&irq_pm_lock)
                                       free_irq(L)  /* last action */
                                         irq_shutdown()  /* depth++ */
  request_threaded_irq(L)
    __setup_irq()
      irq_startup()  /* depth = 0 */

A's disable is gone, but A's irq_rerun is still true.

Second window: A frees L while B is present, so A keeps irq_rerun. Then
B's phy_free_interrupt() empties the line, but it clears only B's own
flag:

	if (!irq_has_action(phydev->irq))
		phydev->irq_rerun = false;

If B requests the line again first, or A does not request it again
before resume, nothing clears A's flag.

In both cases, mdio_bus_phy_resume_irq() for A calls
enable_irq(irq_rerun_line) based on the stale flag.

If the depth is 0, this triggers the "Unbalanced enable for IRQ"
warning.

If B was postponed in the meantime, A's enable cancels B's disable and
unmasks L while B is still postponed. B's thread sees its irq_rerun is
already set and does not disable the line again. On a level-triggered
line the IRQF_ONESHOT thread then keeps rerunning until B resumes, and
B's own enable_irq() then triggers the same warning.

If nobody has requested L again, the enable starts a line that has no
action.

The commit message names two cases that stay unbalanced. It also says
irq_rerun is cleared:

    in phy_free_interrupt() when free_irq() leaves the line without
    users

Does that hold for the dra72-evm-revc two-PHY setup if the other PHY is
the one whose free empties the line?

[ ... ]

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 1791d578f4dde..f2e2370b4be7c 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

[ ... ]

> @@ -393,19 +419,7 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
>  	if (ret < 0)
>  		return ret;
>  no_resume:
> -	if (phy_interrupt_is_valid(phydev)) {
> -		phydev->irq_suspended = false;
> -		synchronize_irq(phydev->irq);
> -
> -		/* Rerun interrupts which were postponed by phy_interrupt()
> -		 * because they occurred during the system sleep transition.
> -		 */
> -		if (phydev->irq_rerun) {
> -			phydev->irq_rerun = false;
> -			enable_irq(phydev->irq);
> -			irq_wake_thread(phydev->irq, phydev);
> -		}
> -	}
> +	mdio_bus_phy_resume_irq(phydev);

[Severity: Medium]
What happens to a postponed line if phy_init_hw() or phy_resume() fails
just above this label?

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

Both early returns skip mdio_bus_phy_resume_irq(), so irq_suspended
stays true. If a postponed interrupt already called disable_irq_nosync(),
the line stays disabled. If not, the next phy_interrupt() takes the
postpone branch and disables it.

Nothing calls enable_irq(irq_rerun_line) until a later sleep cycle
resumes successfully. Until then, this PHY loses its interrupts, and so
does every other user of a shared line, such as the second PHY on
dra72-evm-revc.

The early returns themselves are not new. The result, though, matches
the third bullet of the commit message, reached through a different
return:

    mdio_bus_phy_resume() returns before enable_irq(), and the other
    users of a shared line stay disabled.

The new comment in phy_free_interrupt() ("mdio_bus_phy_resume_irq()
enables a shared line") also assumes the helper always runs.

A later patch in the series, "net: phy: stop postponing PHY interrupts
when phy_suspend() fails", fixes the suspend-side version by calling
mdio_bus_phy_resume_irq() on that error path. The resume-side error
returns are still unchanged at the end of the series.

Should these error paths also call mdio_bus_phy_resume_irq()?

[ ... ]

> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 59c75296d5355..f370690d62a73 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h

[ ... ]

> @@ -675,6 +675,8 @@ struct phy_oatc14_sqi_capability {
>   * @n_ports: Number of ports currently attached to the PHY
>   * @max_n_ports: Max number of ports this PHY can expose
>   * @lock:  Mutex for serialization access to PHY
> + * @irq_pm_lock: Serializes requesting and freeing the interrupt against the
> + *               PM callbacks; phy_interrupt() never takes it

[Severity: Low]
Is this description accurate for phy_request_interrupt()?

The mutex is held only around the irq_rerun and irq_has_action() check.
request_threaded_irq(), phy_enable_interrupts() and the two
"phydev->irq = PHY_POLL" fallbacks all run after mutex_unlock().

mdio_bus_phy_resume_irq() reads phydev->irq under the lock, both for
phy_interrupt_is_valid() and for the irq_rerun_line comparison. Those
reads are not serialized against the request.

The commit message states the narrower guarantee: request and free do
not change irq_rerun between the check and the enable_irq() after
resume.

Could this kernel-doc, and the matching comment above the irq_pm_lock
field in struct phy_device, describe that narrower guarantee instead?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119-b4-phylib-mac-pm-irq-v3-v7-0-d8b8f43b5a62%40iav.lv
