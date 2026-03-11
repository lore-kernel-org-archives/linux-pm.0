Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A758E346760;
	Wed, 11 Mar 2026 07:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.119.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773213635; cv=none; b=pt/Gz9tq91KwkY0mia6LYgWu6dl/duQccrAuBWwuQnAhaFKu3zuMySsWyP9gLvNmJINzCOfRyz4TPK+98CffSR94xG6YWIyJmbk758udx4crBaSWRSdVD2X2kVJ9ET27mjVoYkCaJyVlU8UbCdXNXYbUkqNveZNkwrZaExceQTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773213635; c=relaxed/simple;
	bh=sjTLoFSzoxavBPvZXmlaXgf/l5O6aCdgT9F58NXmKNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFm1TlrUFUO6kr1GdwIsPdi/Qnqw97ZNXNzYt3WRMczDgBfg8sqLwD3KmaYb4LohggPWlXxnMbZ6N1k6c601eHlILOc3ZpfdC28L71RADTaamgENdX8A5bS3d+2BfcR3GOGxzvNka71dbfx0aVoWCcY4rig1ZaR+6xot44A4nDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=ETuMtQDJ; arc=none smtp.client-ip=195.154.119.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="ETuMtQDJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=zMDCp80wXcZlLIgcMelPeXG51rHfM/JmcuxJr30FfrI=; b=ETuMtQDJY2vKLj6uIgdJBYJEYM
	IEPDBl9cBc/VI5eOShAEWs+TcADvt/4WIraBsH+PplPd/frmUrUNPQpKyJA/GKeMEfHL2ogFBCxSO
	nweLqxHjG5mwOhp+FPQdFy5lRhAkWzhWJfiqQUaLNUScVTI4QvpGsfHSOPapX2sxKkIg0TUNWS+2Z
	ZIHgP1CwEhEM29wN780LxlJWL+F5cp4dfd6zXwC2Y//7r0WqdL0ocAIVfA4nKeYVdt6BAF/Bxqylz
	j+/CpCFYpo+p/oswbdaCP9YJbXknwXvy14AYjtO6hjXaVmO03F/25exOwnpqjxVzS9KqxAuVTOZ/3
	4AphON0w==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1w0DKx-0000000709L-3xln;
	Wed, 11 Mar 2026 07:46:31 +0100
Date: Wed, 11 Mar 2026 07:46:31 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Yanko Kaneti <yaneti@declera.com>, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Yixun Lan <dlan@gentoo.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:RISC-V ARCHITECTURE:Keyword:riscv" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit" <spacemit@lists.linux.dev>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] mfd: simple-mfd-i2c: add a reboot cell for the
 SpacemiT P1 chip
Message-ID: <abEPxzhpQSzkfbaI@aurel32.net>
Mail-Followup-To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Yanko Kaneti <yaneti@declera.com>, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Yixun Lan <dlan@gentoo.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:RISC-V ARCHITECTURE:Keyword:riscv" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit" <spacemit@lists.linux.dev>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>
References: <20251102230352.914421-1-aurelien@aurel32.net>
 <20251102230352.914421-3-aurelien@aurel32.net>
 <b51a62513daa9d2390031ec350e0b33bdb7e54aa.camel@declera.com>
 <aaC78FTN31QYaVg0@aurel32.net>
 <990bc03ed2baa05e619f0aa9cc6a23acadd66ea6.camel@declera.com>
 <aaS6xeKFZz06fb1_@aurel32.net>
 <aaXuWwyA5NzBZzlW@aurel32.net>
 <36f8df695463e5ff3eaaffbac357fc73026f7373.camel@declera.com>
 <aadGw1fIlJyNNoum@aurel32.net>
 <DGZM6WUAVPPS.20Y0NIZYI4572@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DGZM6WUAVPPS.20Y0NIZYI4572@linux.spacemit.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

Hi,

On 2026-03-11 10:58, Troy Mitchell wrote:
> On Wed Mar 4, 2026 at 4:38 AM CST, Aurelien Jarno wrote:
>  Hi, Aurelien and Yanko,
> > Hi,
> >
> > On 2026-03-02 22:34, Yanko Kaneti wrote:
> >> Hello,
> >> 
> >> On Mon, 2026-03-02 at 21:08 +0100, Aurelien Jarno wrote:
> >> > On 2026-03-01 23:16, Aurelien Jarno wrote:
> >> > > On 2026-02-27 13:29, Yanko Kaneti wrote:
> >> > > > On Thu, 2026-02-26 at 22:32 +0100, Aurelien Jarno wrote:
> >> > > > > Hi,
> >> > > > > 
> >> > > > > On 2026-02-26 16:32, Yanko Kaneti wrote:
> >> > > > > > Hello,
> >> > > > > > 
> >> > > > > > On Mon, 2025-11-03 at 00:02 +0100, Aurelien Jarno wrote:
> >> > > > > > > Add a "spacemit-p1-reboot" cell for the SpacemiT P1 chip.
> >> > > > > > > 
> >> > > > > > > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> >> > > > > > > ---
> >> > > > > > > v5: no changes
> >> > > > > > > 
> >> > > > > > >  drivers/mfd/simple-mfd-i2c.c | 1 +
> >> > > > > > >  1 file changed, 1 insertion(+)
> >> > > > > > > 
> >> > > > > > > diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> >> > > > > > > index 0a607a1e3ca1d..542d378cdcd1f 100644
> >> > > > > > > --- a/drivers/mfd/simple-mfd-i2c.c
> >> > > > > > > +++ b/drivers/mfd/simple-mfd-i2c.c
> >> > > > > > > @@ -99,6 +99,7 @@ static const struct regmap_config spacemit_p1_regmap_config = {
> >> > > > > > >  };
> >> > > > > > >  
> >> > > > > > >  static const struct mfd_cell spacemit_p1_cells[] = {
> >> > > > > > > +	{ .name = "spacemit-p1-reboot", },
> >> > > > > > >  	{ .name = "spacemit-p1-regulator", },
> >> > > > > > >  	{ .name = "spacemit-p1-rtc", },
> >> > > > > > >  };
> >> > > > > > 
> >> > > > > > Perhaps its safe to merge this one now that everything P1 and I2C is
> >> > > > > > already in linus tip ?
> >> > > > > 
> >> > > > > Unfortunately, this patchset is still missing:
> >> > > > > https://lore.kernel.org/all/20260207-b4-k3-i2c-pio-v7-0-626942d94d91@linux.spacemit.com/
> >> > > > > 
> >> > > > > This means the reboots work most of the time, but are not 100% reliable, 
> >> > > > > and that's the reason why this patch got blocked from merging.
> >> > > > 
> >> > > > I see. Thanks. Sounds to me like sometimes working compared to never
> >> > > > working is better , but anyway..
> >> > > 
> >> > > I agree with that, but the decision was to hold on this patch until the 
> >> > > I2C PIO part got merged.
> >> > > 
> >> > > > FWIW  with this patch and the pio patcheset I get this rcu splat on
> >> > > > reboot (which is still working). Similar splat is there without the pio
> >> > > > patcheset.
> >> > > 
> >> > > I haven't been able to reproduce the issue here after 10+ reboots on a 
> >> > > BPI-F3 board, but I tried the patch on top of 6.19. I'll try to build a 
> >> > > 7.0.0-rc2 kernel and report back.
> >> > 
> >> > I have tried that, and I am still unable to reproduce the issue with a 
> >> > 7.0.0-rc2 kernel and a BPI-F3 board.
> >> 
> >> I can still see it on every reboot (with the patches that allow reboot
> >> to work). Do you have CONFIG_PREEMPT_RCU in your config ? its default on
> >> when anything PREEMPT is selected. In Fedora its CONFIG_PREEMPT_DYNAMIC
> >> that flips it.
> >
> > Thanks for the hint, that option was not activated here, it's not the 
> > riscv64 defconfig. With it I am also able to reproduce the issue. I'll 
> > try to debug that and report back.
> I have sent a patch to address this issue here[1].
> 
> Could you please test it on your hardware when you have a chance?
> 
>                         - Troy
> 
> Link:
> https://lore.kernel.org/all/20260311-v7-0-rc1-rv-dis-int-before-restart-v1-1-bc46b4351cac@linux.dev/ [1]

Thanks, I confirm it fixes the issue \o/.

Regards
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
