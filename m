Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795482698;
	b=4vCsJODJyMaBxumnMgXS6pRIWaWVIwzm6M6W2wyJ9zej7tIbhdpiWrn067wIYCWizReL
	 lzcFGGDLWJ6HVwHTbbZUAffm0YvRO3QwGvNPr4Qu86Snz+Qf6E4USXwvijmvWde+f43Cx
	 CnNyXnb7pFhBMgKNdLEoZ4OhgVGOi5ytT55280tH4Z/PYxSRUGr1UG0qeho9RMRbHPfdT
	 8WrtIFUCxGny/hcOz7XiR22xUVHLQmaSiY+H7ZW6odOeR1L/Mq96xtNf5fuhEOd18YJ5D
	 KY5ijuh0V6EfqYqJr1NRYHR7oDkDYoD73fn7sKQ1wH6ZmfTkAikhyEjNb+21N7UyucQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795482698;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wgEWWEO3qdUk7hR9XMnjX/hWMNEVu9/1SaZ+lWZNOmQ=;
	b=4J385NyHgBEt9Q7iue9vHrg0ONeENRy3C3xA4AZX23l9M4t7Q7Aev4FtHgPGOlx/ikpT
	 2Dy+tOd6BB1j2o9rhmWgitLPOm2YPoqHJO02HwaiY6mZkbUsFTp8xHu8vhswlPfTiYklE
	 RdNxx8PIiP8TEvrlwtYTM5B859G+02boLBSXbKPpjGDhQVX1kkGkew8gA5WuxLIWGVzGm
	 LhdNvgRJOJGiEIHm77GiYX7eTJgbDRwZqr78Yl2S1jtnCvhVCYHCdaV8MMax5HgO94lSj
	 P4ONhi3yUJmF7UMqOoyrwmBuz2gprfGmzHnOMgLpKztGMGfmlrsc8YsBopCYpDngJCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oeM5/T4W";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21B2606A321;
	Tue, 24 Nov 2026 01:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oeM5/T4W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC211F000C4;
	Tue, 24 Nov 2026 01:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795482698;
	bh=wgEWWEO3qdUk7hR9XMnjX/hWMNEVu9/1SaZ+lWZNOmQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oeM5/T4WRAeChpjv3sI9v50CsIdchJV2dJLzdy3D1UyfZyHPryAQwdkCExfiOhS2P
	 auMQLvY84UFxPjnTALlROLlweVqtajxuW1Mz+TA7nDN3pi9MLMiSTX+ts0TkDrqf95
	 xYUfC8QFONSxDhiRUmS3ikrjE+JuhUT8KvMRFycWXP6dTj90M4iQ/LNo76OMuedUWS
	 x2vc/7GP8azbj5Yv3OqBvzN6seFvd/C6NnqAUCLgB8fcWC6y/LcBbr+UbMTpIGQPoO
	 rlw1imgepY3c+OmUrAtE/g5f9RNcbaAQ1ARTkCIGIQUtgpjZkK6kYuFzsB8M6dBCiu
	 Fl71pzPQRuL8w==
Subject: Re: [PATCH net v8 1/5] net: phy: move irq_suspended and irq_rerun out
 of the bitfield
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
Date: Tue, 24 Nov 2026 01:11:36 +0000
Message-ID: <179548269686.3135.9876460710453451136@kernel.org>
In-Reply-To: <20261123-b4-phylib-mac-pm-irq-v3-v8-1-e9f706e79614@iav.lv>
References: <20261123-b4-phylib-mac-pm-irq-v3-v8-1-e9f706e79614@iav.lv>
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

- [Low] The patch adds this comment above the two new bools in struct
  phy_device (include/linux/phy.h): "Not bitfields: phy_interrupt() and…

--

net: phy: move irq_suspended and irq_rerun out of the bitfield

This commit turns irq_suspended and irq_rerun in struct phy_device from
1-bit bitfields into separate bools. phy_interrupt() and the PM callbacks
write them without phydev->lock, so a read-modify-write on the shared
bitfield word could lose a concurrent irq_rerun update. The call sites in
phy.c and phy_device.c are updated to use true/false.

[ ... ]

> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 21afc2082b174..59c75296d5355 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -726,8 +726,11 @@ struct phy_device {
>  
>  	/* Interrupts are enabled */
>  	unsigned interrupts:1;
> -	unsigned irq_suspended:1;
> -	unsigned irq_rerun:1;
> +	/* Not bitfields: phy_interrupt() and the PM callbacks write them
> +	 * without phydev->lock
> +	 */

[Severity: Low]
This isn't a bug, but could this comment mislead readers about the
bitfields that remain?

The reason it gives, written by the PM callbacks without phydev->lock,
also applies to interrupts:1 on the line just above it. PHY driver suspend
callbacks run from phy_suspend()->phydrv->suspend(), and phy_suspend()
does not take phydev->lock. For example, in dp83867_suspend():

drivers/net/phy/dp83867.c:dp83867_suspend() {
    ...
	if (phy_interrupt_is_valid(phydev)) {
		phydev->interrupts = PHY_INTERRUPT_DISABLED;
		dp83867_config_intr(phydev);
	}
    ...
}

marvell-88q2xxx.c and micrel.c do the same thing in their suspend paths.

phy_suspend() also sets phydev->suspended = true without the lock, and
suspended:1 is in the same bitfield word.

Both fields still share that word with link:1 and autoneg_complete:1,
which the state machine writes under phydev->lock. From this comment, a
reader could conclude that the remaining bitfields in the word are only
written under phydev->lock.

Would it be clearer to word the comment so it doesn't imply that rule?
It could, for example, just describe the irq_rerun race that this patch
fixes.

> +	bool irq_suspended;
> +	bool irq_rerun;
>  
>  	unsigned default_timestamp:1;
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123-b4-phylib-mac-pm-irq-v3-v8-0-e9f706e79614%40iav.lv
