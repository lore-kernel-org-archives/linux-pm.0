Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.154.119.183
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794954390;
	b=QKY7GjY2fqwuA+gqJ2guohR2dY1M0TzgoKx6Bg4Ndrg/FyqzuQQ3LAn0E4Xd/ZBmC+us
	 NtgDcYlsXJY9AnrR9IZwkUF0UPmaXv4aTiw6oyAkexC7SZyg3KD2BeKXsLx7tUaoxIxfn
	 TBv35BsBISx3TKNZkU01TDJJ9hWj+AAfQVDvtEyrJWfIPrmBGOalIHqylNo97dLjs5dCU
	 kKmt7otb1hHA9Ca7cxBt5f58GHJN5xglsTIjbLH2PWCV4UOHxI9lbV2V++psRJVdetkJr
	 t2FFIasMbgQDVSH+poVyzs1xs612wwE5dCNrbp/xJ3J/vex8H9ei+gXUYuPMhJXgFyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794954390;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=r2D5y0TucYSUwiHZr4B77hB+E7SQhof22iJyDH7secY=;
	b=4ydamyLrwWqYyWQo9Fg8yiXQyfG0LzV9db0sEE6BO60b4wYFLKuDEC2mv3T58C2JeRMT
	 pr8I2IP4FRbhw1mUYShVrpDO4XwZJbKTZ71yQOgD6i9KX8y4aLsMKgDIlqJpQYfxOv/Fa
	 xlGeEDynV2uWb8aBMNGboYiZOZ6MPPa0pSfRvy85i3dHDL6n6tz1172bhCBIkc84CwX8D
	 nXHZR6pAl/OX7hmS6nCQrfqPtUL1d/uFBk9tXB2w8JYuXS/d1rE+Bdf5PJx9efcZvice6
	 VP/nH93NHt9oXD1ccGBHSXusywG/Sb79D0t68cMUwZULo94Wf/hPFZ9St6CKVm8BKKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aurel32.net;
	spf=pass smtp.mailfrom=aurel32.net;
	dkim=pass header.d=aurel32.net header.i=@aurel32.net header.a=rsa-sha256 header.s=202004.hall header.b=iq9RgePl;
	arc=none smtp.remote-ip=195.154.119.183
Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4060C606A31C;
	Tue, 17 Nov 2026 22:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4060C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aurel32.net header.i=@aurel32.net header.a=rsa-sha256 header.s=202004.hall header.b=iq9RgePl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=r2D5y0TucYSUwiHZr4B77hB+E7SQhof22iJyDH7secY=; b=iq9RgePlfoRm2/Rn/figPr5cci
	0M9Cel/iQ1ZPTKWizBnjAgnX9MT83uto5w979hbcwm/ohp4AuL/KY0Ow76i6g1svUCE3SGrcJkJBn
	asLiX9l81U4OL9wbkiykhO57N0CSkOYItcWh9U2tqkHyNmFTahFvusQP7R4l0xivd6eCOnSp9BF9O
	hC4x72cLSOYYs0WSv2zDqL36XqB2mGSoG1FmtEvJciqbVZuEaeWuGRWlLutMLBzyxsKJOzlczsMlB
	2BAtE1fBoWTEU6CgcAgolkhSsFPdmaivlJxEe67JIQS91M3MNanGk1BTwj34JzqTt/38znLb8s9/Q
	NdNc1Urg==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1xTRd9-0000000GdbW-2P8h;
	Tue, 17 Nov 2026 23:26:23 +0100
Date: Tue, 17 Nov 2026 23:26:22 +0100
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
Message-ID: <avzUjsZzhky4krEV@aurel32.net>
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
 <avvnRkK9agPSdzac@aurel32.net>
 <CANAwSgSXP1bZVVrX71jfgi1iR9AY4TpM0pk07ke+oeLvcX1fEQ@mail.gmail.com>
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
In-Reply-To: <CANAwSgSXP1bZVVrX71jfgi1iR9AY4TpM0pk07ke+oeLvcX1fEQ@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

Hi Anand,

On 2026-11-17 18:04, Anand Moon wrote:
> Hi Aurelien,
> 
> On Tue, 17 Nov 2026 at 11:04, Aurelien Jarno <aurelien@aurel32.net> wrote:
> >
> > Hi Anand,
> >
> > On 2026-11-16 13:06, Anand Moon wrote:
> > > Hi All,
> > >
> > > On Mon, 16 Nov 2026 at 11:33, Sebastian Reichel
> > > <sebastian.reichel@collabora.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Tue, Nov 10, 2026 at 11:44:27AM +0530, Anand Moon wrote:
> > > > > The SpacemiT P1 power-off and restart handlers use regmap_set_bits()
> > > > > to access the PMIC. However, these handlers run in an atomic notifier
> > > > > context (specifically within an rcu_read_lock() critical section), while
> > > > > the I2C-backed regmap uses a sleepable mutex.
> > > > >
> > > > > This triggers a "WARNING: suspicious RCU usage" warning due to an illegal
> > > > > context switch in the RCU read-side critical section during shutdown on the
> > > > > Banana Pi BPI-F3:
> > > > >
> > > > > [  563.803475] WARNING: suspicious RCU usage
> > > > > [  563.807813] 7.3.1-ARCH-RISC-V #1 Not tainted
> > > > > [  563.816614] ./include/linux/rcupdate.h:387 Illegal context switch in RCU read-side critical section!
> > > > > ...
> > > > > [  563.841445] locks held by shutdown/1: 2, last CPU#0:
> > > > > [  563.846694]  #0: ffffffff8404fb20 (system_transition_mutex){+.+.}-{4:4}, at: __do_sys_reboot+0x230/0x29e
> > > > > [  563.856806]  #1: ffffffff84167860 (rcu_read_lock){....}-{1:3}, at: atomic_notifier_call_chain+0x4a/0x1c2
> > > > >
> > > > > Replace the regmap operations with atomic I2C transfers to avoid sleeping
> > > > > in an atomic context. Preserve unrelated register bits through
> > > > > read-modify-write operations and check for atomic I2C support before
> > > > > registering the handlers.
> > > > >
> > > > > Obtain the I2C client from the parent device and verify that the adapter
> > > > > supports atomic transfers before registering the handlers.
> > > > >
> > > > > Tested on the Banana Pi BPI-F3 (SpacemiT K1).
> > > > >
> > > > > Assisted-by: LLM
> > > > > Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > > > > Cc: Aurelien Jarno <aurelien@aurel32.net>
> > > > > Fixes: 28124cc0fb8c ("driver: reset: spacemit-p1: add driver for poweroff/reboot")
> > > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > > ---
> > > >
> > > > regmap runs i2c_transfer itself and thus also uses the atomic I2C
> > > > transfers. The problem here is regmap itself. But instead of moving
> > > > away from regmap, the atomic use case should be supported properly
> > > > in regmap.
> > > >
> > >
> > > On  RISC-V platform, poweroff and reboot are already handled by OpenSBI
> > > through the SBI System Reset (SRST) extension. Linux delegates these
> > > operations to firmware using SBI_SRST_RESET_TYPE_SHUTDOWN for poweroff
> > > and SBI_SRST_RESET_TYPE_COLD_REBOOT or SBI_SRST_RESET_TYPE_WARM_REBOOT
> > > for reboot, depending on the supported reset type.
> > >
> > > Therefore, there is no need for an additional Linux PMIC poweroff/reboot handler
> > > on this platform, as it duplicates functionality already provided by firmware.
> > >
> > > While supporting atomic operations in regmap may be useful more generally,
> > > it is not necessary to address this platform's shutdown and reboot requirements.
> > >
> > > I tested this on the SpacemiT K1 Banana Pi BPI-F3 after removing this PMIC
> > > poweroff/reboot driver.
> > >
> > > OpenSBI commit which handles this extension
> > >
> > > d9637d00bf47 ("lib: utils/reset: add SpacemiT P1 PMIC support")
> > > b10e18ec854a ("lib: utils/i2c: add minimal SpacemiT I2C driver")
> > >
> > > Similarly, on the StarFive VisionFive 2, poweroff is handled by
> > > OpenSBI through the
> > > AXP15060 PMIC, so there is no need to register an additional poweroff
> > > handler using
> > > devm_register_power_off_handler().
> > >
> > > OpenSBI commit which handles this extension
> > >
> > > 568ea49490d9 ("platform: starfive: add PMIC power ops in JH7110
> > > visionfive2 board")
> > >
> > > -----8<----------8<----------8<------
> > > diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> > > index 50df66de24e06..069259f7d7c15 100644
> > > --- a/drivers/mfd/axp20x.c
> > > +++ b/drivers/mfd/axp20x.c
> > > @@ -1458,8 +1458,14 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
> > >                 return ret;
> > >         }
> > >
> > > -       if (axp20x->variant != AXP288_ID)
> > > -               devm_register_power_off_handler(axp20x->dev,
> > > axp20x_power_off, axp20x);
> > > +       /*
> > > +        * The VisionFive 2 handles AXP15060 poweroff through OpenSBI.
> > > +        * Avoid accessing the I2C PMIC from the atomic poweroff path.
> > > +        */
> > > +       if (axp20x->variant != AXP288_ID && !(axp20x->variant == AXP15060_ID &&
> > > +                               of_machine_is_compatible("starfive,jh7110")))
> > > +               devm_register_power_off_handler(axp20x->dev,
> > > +                               axp20x_power_off, axp20x);
> > >
> > >         dev_info(axp20x->dev, "AXP20X driver loaded\n");
> > >
> > > Please let me know if this works on your board?
> >
> > Yes, that works, but I don't think this is the correct solution to
> > disable here. Also this won't scale for future boards which might use a
> > different existing PMIC driver with poweroff support and that will also
> > need to be patched.
> >
> No changes needed over here, reboot and power-off priority will
> work fine.
> > As pointed out by Troy in an earlier mail, the real problem is the
> > priority at which the handler is registers, 192 for the reset and -256
> > for the poweroff one. I wonder if the SBI SRST extension should also
> > register the poweroff one at 192. It seems it's about replacing the call
> > to register_platform_power_off() by register_sys_off_handler(), which
> > supports using a priority value. And maybe SYS_OFF_PRIO_FIRMWARE = 224
> > should be used there instead of 192.
> >
> Thanks for your input; with the changes below.
> It works fine on Spacemit k1 and Starfive Vision 2 for reboot and power-off.
> 
>  arch/riscv/kernel/sbi.c | 51 +++++++++++++++++++++++++++++++----------
>  1 file changed, 39 insertions(+), 12 deletions(-)

Thanks for this patch. It sounds good overall, and it's always good to 
switch to the newest API.

I have been able to test it successfully on VisionFive 2 and Banana-Pi 
F3. Please find a few comments below.

> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index af1ccea222f1..32a3d2df9032 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -512,23 +512,55 @@ static void sbi_srst_reset(unsigned long type,
> unsigned long reason)
>                 __func__, type, reason);
>  }
> 
> -static int sbi_srst_reboot(struct notifier_block *this,
> -                          unsigned long mode, void *cmd)
> +static int sbi_srst_reboot(struct sys_off_data *data)
>  {
> -       sbi_srst_reset((mode == REBOOT_WARM || mode == REBOOT_SOFT) ?
> +       sbi_srst_reset((reboot_mode == REBOOT_WARM ||
> +                       reboot_mode == REBOOT_SOFT) ?
>                        SBI_SRST_RESET_TYPE_WARM_REBOOT :
>                        SBI_SRST_RESET_TYPE_COLD_REBOOT,
>                        SBI_SRST_RESET_REASON_NONE);
> +
>         return NOTIFY_DONE;
>  }
> 
> -static struct notifier_block sbi_srst_reboot_nb;
> -
> -static void sbi_srst_power_off(void)
> +static int sbi_srst_power_off(struct sys_off_data *data)
>  {
>         sbi_srst_reset(SBI_SRST_RESET_TYPE_SHUTDOWN,
>                        SBI_SRST_RESET_REASON_NONE);
> +
> +       return NOTIFY_DONE;
> +}
> +
> +static bool srst_power_off;
> +static bool sbi_srst_available;

Not sure we want global variables for this, as they are not used anymore 
once the initialisation is done.
> +
> +static int __init sbi_srst_sys_off_init(void)
> +{
> +       struct sys_off_handler *handler;
> +
> +       if (!sbi_srst_available)
> +               return 0;
> +
> +       handler = register_sys_off_handler(SYS_OFF_MODE_RESTART,
> +                                          SYS_OFF_PRIO_HIGH,

I think you should use SYS_OFF_PRIO_FIRMWARE for both entry. It 
corresponds to the reboot provider.

> +                                          sbi_srst_reboot, NULL);
> +       if (IS_ERR(handler))
> +               pr_warn("Failed to register SBI SRST restart handler: %ld\n",
> +                       PTR_ERR(handler));
> +
> +       handler = register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
> +                                          SYS_OFF_PRIO_FIRMWARE,
> +                                          sbi_srst_power_off, NULL);
> +       if (IS_ERR(handler)) {
> +               pr_warn("Failed to register SBI SRST poweroff handler: %ld\n",
> +                       PTR_ERR(handler));
> +       } else {
> +               srst_power_off = true;
> +       }
> +
> +       return 0;
>  }
> +device_initcall(sbi_srst_sys_off_init);

Any reason to use a device_initcall as opposed to just calling the 
fuunction from the sbi_init function below? If so, please provide the 
reason in the commit message when submitting the final patch.

>  /**
>   * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
> @@ -643,7 +675,6 @@ int sbi_debug_console_read(char *bytes, unsigned
> int num_bytes)
> 
>  void __init sbi_init(void)
>  {
> -       bool srst_power_off = false;
>         int ret;
> 
>         ret = sbi_get_spec_version();
> @@ -677,11 +708,7 @@ void __init sbi_init(void)
>                 if (sbi_spec_version >= sbi_mk_version(0, 3) &&
>                     sbi_probe_extension(SBI_EXT_SRST)) {
>                         pr_info("SBI SRST extension detected\n");
> -                       register_platform_power_off(sbi_srst_power_off);
> -                       srst_power_off = true;
> -                       sbi_srst_reboot_nb.notifier_call = sbi_srst_reboot;
> -                       sbi_srst_reboot_nb.priority = 192;
> -                       register_restart_handler(&sbi_srst_reboot_nb);
> +                       sbi_srst_available = true;
>                 }
>                 if (sbi_spec_version >= sbi_mk_version(2, 0) &&
>                     sbi_probe_extension(SBI_EXT_DBCN) > 0) {

Regards
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
