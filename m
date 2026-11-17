Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.154.119.183
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794893654;
	b=gAY2UyMj2/h9hNnA+UW7gDtLcUeukjzu5Ua+9260d8VgYTBDyoZj2qE4O1QcUWfI8bpI
	 1uo7inzYZMFMyuZd1CbHMrQXNSm4lq8on6d65OFrW3B8gpULBHjoXuBZhg3Z4iFqptQPS
	 Ts/J3AyU/5vawsXLadkzk18Jj09umbWn8YyMgggQej4gjSD4PQczZP6OmxZ1RVQsFxx8F
	 H0KwkSvSYCWPxseK7Urtm9Shm1HpP2PEgT86qk7fpk68kyacBRNMfajgl7HI/R45JAwU/
	 TRTEMMfCsInUb+ZzYQUqqsfF3gHIXVVyJxZBqd9wc8kxDnnLHwiH8JGy1dzMtyFvs2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794893654;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=uv0Ajg/ZOj9nmloBlqc5KvujqzinojKoKdNon67mJq8=;
	b=LHEKA6DKGHA7dW1OB/6AYUD0evtu/3jy0UhVbBsUQ8P39gOVjddi5Z7g8b2mnRt2vSuL
	 dCPQaj3NR973IWpORY37MAXsH9mPkdYfuy2whxZ5ivv4gAG8jJilD1klYZQRcHDFDwvaF
	 iBDQUc3wJirvn4qLWJNbEzx/NFAptMX1a45AQdgDZdMnxfgqE9m6RVrgJxa5AIL6MekzC
	 yTtJL3g3uaGXTyG0itmRrM3J5lu4Ov5VFja1FuJ9qWQeBROAQ9gsyy/OnRqi2QkLdw7IV
	 SX2mHStYEnPeGNdRj+JByL/YSlLGnguzyMuQ9apwQH+5tQC9/LMlEmBSFNMr25FbwJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aurel32.net;
	spf=pass smtp.mailfrom=aurel32.net;
	dkim=pass header.d=aurel32.net header.i=@aurel32.net header.a=rsa-sha256 header.s=202004.hall header.b="t4oNpCg/";
	arc=none smtp.remote-ip=195.154.119.183
Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D9A606A32A;
	Tue, 17 Nov 2026 05:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90D9A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aurel32.net header.i=@aurel32.net header.a=rsa-sha256 header.s=202004.hall header.b=t4oNpCg/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=uv0Ajg/ZOj9nmloBlqc5KvujqzinojKoKdNon67mJq8=; b=t4oNpCg/JzIcewr8iMyCEB9uvi
	XGHUBmQTtxLRh//FgdVeDyVTrvME8RoKx9VfvZF+mAhD6XaxooBF5HYvQfPSxTHzECKUCnrprzbS4
	diWHSaaPoU8mBzBUhKznCEIM1j5j2HPOvK+PfkEBn33c4JNmrVP070WSHpo72X3hFNa5dzkrOOC3h
	eq6uXsEXc+UIi0AuBn9QvpSmy4v0G80+EJoU1XSVwxkDqIAv9vYIxT9JhvTV6mNQl4ZYKylDXlyxH
	jdBKYTH4meTdq1WYPQTCMI8TDIc34WB9ctzotxxawmtORvDzVgAIZ09P5Y/wYkto6FVYNVAa73iT1
	87qYJCkg==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1xTBpP-0000000Fa7M-0bSc;
	Tue, 17 Nov 2026 06:33:59 +0100
Date: Tue, 17 Nov 2026 06:33:58 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Andi Shyti <andi.shyti@kernel.org>, Yixun Lan <dlan@kernel.org>,
	"open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>,
	"open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
Subject: Re: [PATCH v1 2/2] power: reset: spacemit-p1: Use atomic I2C
 transfers for power-off and restart
Message-ID: <avvnRkK9agPSdzac@aurel32.net>
Mail-Followup-To: Anand Moon <linux.amoon@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Andi Shyti <andi.shyti@kernel.org>, Yixun Lan <dlan@kernel.org>,
	"open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>,
	"open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
References: <20261110061429.2036-1-linux.amoon@gmail.com>
 <20261110061429.2036-2-linux.amoon@gmail.com>
 <avpN-gFOvTBAMY6G@venus>
 <CANAwSgT_k35_waHL-+iU93f=k3fjFAPXhk=exRz-XHMm2MqREA@mail.gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANAwSgT_k35_waHL-+iU93f=k3fjFAPXhk=exRz-XHMm2MqREA@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

Hi Anand,

On 2026-11-16 13:06, Anand Moon wrote:
> Hi All,
> 
> On Mon, 16 Nov 2026 at 11:33, Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> >
> > Hi,
> >
> > On Tue, Nov 10, 2026 at 11:44:27AM +0530, Anand Moon wrote:
> > > The SpacemiT P1 power-off and restart handlers use regmap_set_bits()
> > > to access the PMIC. However, these handlers run in an atomic notifier
> > > context (specifically within an rcu_read_lock() critical section), while
> > > the I2C-backed regmap uses a sleepable mutex.
> > >
> > > This triggers a "WARNING: suspicious RCU usage" warning due to an illegal
> > > context switch in the RCU read-side critical section during shutdown on the
> > > Banana Pi BPI-F3:
> > >
> > > [  563.803475] WARNING: suspicious RCU usage
> > > [  563.807813] 7.3.1-ARCH-RISC-V #1 Not tainted
> > > [  563.816614] ./include/linux/rcupdate.h:387 Illegal context switch in RCU read-side critical section!
> > > ...
> > > [  563.841445] locks held by shutdown/1: 2, last CPU#0:
> > > [  563.846694]  #0: ffffffff8404fb20 (system_transition_mutex){+.+.}-{4:4}, at: __do_sys_reboot+0x230/0x29e
> > > [  563.856806]  #1: ffffffff84167860 (rcu_read_lock){....}-{1:3}, at: atomic_notifier_call_chain+0x4a/0x1c2
> > >
> > > Replace the regmap operations with atomic I2C transfers to avoid sleeping
> > > in an atomic context. Preserve unrelated register bits through
> > > read-modify-write operations and check for atomic I2C support before
> > > registering the handlers.
> > >
> > > Obtain the I2C client from the parent device and verify that the adapter
> > > supports atomic transfers before registering the handlers.
> > >
> > > Tested on the Banana Pi BPI-F3 (SpacemiT K1).
> > >
> > > Assisted-by: LLM
> > > Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > > Cc: Aurelien Jarno <aurelien@aurel32.net>
> > > Fixes: 28124cc0fb8c ("driver: reset: spacemit-p1: add driver for poweroff/reboot")
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > ---
> >
> > regmap runs i2c_transfer itself and thus also uses the atomic I2C
> > transfers. The problem here is regmap itself. But instead of moving
> > away from regmap, the atomic use case should be supported properly
> > in regmap.
> >
> 
> On  RISC-V platform, poweroff and reboot are already handled by OpenSBI
> through the SBI System Reset (SRST) extension. Linux delegates these
> operations to firmware using SBI_SRST_RESET_TYPE_SHUTDOWN for poweroff
> and SBI_SRST_RESET_TYPE_COLD_REBOOT or SBI_SRST_RESET_TYPE_WARM_REBOOT
> for reboot, depending on the supported reset type.
> 
> Therefore, there is no need for an additional Linux PMIC poweroff/reboot handler
> on this platform, as it duplicates functionality already provided by firmware.
> 
> While supporting atomic operations in regmap may be useful more generally,
> it is not necessary to address this platform's shutdown and reboot requirements.
> 
> I tested this on the SpacemiT K1 Banana Pi BPI-F3 after removing this PMIC
> poweroff/reboot driver.
> 
> OpenSBI commit which handles this extension
> 
> d9637d00bf47 ("lib: utils/reset: add SpacemiT P1 PMIC support")
> b10e18ec854a ("lib: utils/i2c: add minimal SpacemiT I2C driver")
> 
> Similarly, on the StarFive VisionFive 2, poweroff is handled by
> OpenSBI through the
> AXP15060 PMIC, so there is no need to register an additional poweroff
> handler using
> devm_register_power_off_handler().
> 
> OpenSBI commit which handles this extension
> 
> 568ea49490d9 ("platform: starfive: add PMIC power ops in JH7110
> visionfive2 board")
> 
> -----8<----------8<----------8<------
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 50df66de24e06..069259f7d7c15 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -1458,8 +1458,14 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
>                 return ret;
>         }
> 
> -       if (axp20x->variant != AXP288_ID)
> -               devm_register_power_off_handler(axp20x->dev,
> axp20x_power_off, axp20x);
> +       /*
> +        * The VisionFive 2 handles AXP15060 poweroff through OpenSBI.
> +        * Avoid accessing the I2C PMIC from the atomic poweroff path.
> +        */
> +       if (axp20x->variant != AXP288_ID && !(axp20x->variant == AXP15060_ID &&
> +                               of_machine_is_compatible("starfive,jh7110")))
> +               devm_register_power_off_handler(axp20x->dev,
> +                               axp20x_power_off, axp20x);
> 
>         dev_info(axp20x->dev, "AXP20X driver loaded\n");
> 
> Please let me know if this works on your board?

Yes, that works, but I don't think this is the correct solution to 
disable here. Also this won't scale for future boards which might use a 
different existing PMIC driver with poweroff support and that will also 
need to be patched.

As pointed out by Troy in an earlier mail, the real problem is the 
priority at which the handler is registers, 192 for the reset and -256 
for the poweroff one. I wonder if the SBI SRST extension should also 
register the poweroff one at 192. It seems it's about replacing the call 
to register_platform_power_off() by register_sys_off_handler(), which 
supports using a priority value. And maybe SYS_OFF_PRIO_FIRMWARE = 224 
should be used there instead of 192.

Regards
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
