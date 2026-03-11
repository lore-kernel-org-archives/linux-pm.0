Received: from mail.bix.bg (mail.bix.bg [193.105.196.21])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 8649A38656D
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 07:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.105.196.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773212950; cv=none; b=nw44xwE0J9e9Vqv4D6/aR6reRUHi9DGoqlwsvQO6pgD98G/a5AoL/NV7LJXTpOfDLkezdr2r+zAW/+1kjAXuNipYJXimi+wAWSg404ZkT0Iz9CsybasiFKbZ5BctJ83WalgmyUDQrviQSEpsyvnheKdw7XZ1/9N3oDrn87ZKBPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773212950; c=relaxed/simple;
	bh=VcLpa26hYcS9UGElZjB9GZ4pCB6wExx3iF5Cdw2AeTo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I0BI67tmYnlRjx0oIcJuPxtMkvW07r533Q1wQ1zduIcP2WMn0QaZbzV2RiSKzMo+qT0pFCm4erIcKqNcsq4O6Fag2rn8NlWcbgNMfFfKP020wk51jfA/u9JYzEbqmPJnjMDReKjGn4Qcx0smh1btG30syOv49Va+D+xsRucvqlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=declera.com; spf=pass smtp.mailfrom=declera.com; arc=none smtp.client-ip=193.105.196.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=declera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=declera.com
Received: (qmail 8542 invoked from network); 11 Mar 2026 07:08:54 -0000
Received: from d2.declera.com (HELO ?212.116.131.122?) (212.116.131.122)
  by indigo.declera.com with SMTP; 11 Mar 2026 07:08:54 -0000
Message-ID: <4ab8430161252ec778fabf7e9b68acf3645ed4c7.camel@declera.com>
Subject: Re: [PATCH v5 2/2] mfd: simple-mfd-i2c: add a reboot cell for the
 SpacemiT P1 chip
From: Yanko Kaneti <yaneti@declera.com>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>, Aurelien Jarno
	 <aurelien@aurel32.net>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>, Sebastian
 Reichel	 <sre@kernel.org>, Yixun Lan <dlan@gentoo.org>, Paul Walmsley
 <pjw@kernel.org>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, "open list:RISC-V
 ARCHITECTURE:Keyword:riscv"	 <linux-riscv@lists.infradead.org>, "open
 list:RISC-V SPACEMIT SoC Support:Keyword:spacemit"	
 <spacemit@lists.linux.dev>, "open list:SYSTEM RESET/SHUTDOWN DRIVERS"	
 <linux-pm@vger.kernel.org>
Date: Wed, 11 Mar 2026 09:08:54 +0200
In-Reply-To: <DGZM6WUAVPPS.20Y0NIZYI4572@linux.spacemit.com>
References: <20251102230352.914421-1-aurelien@aurel32.net>
	 <20251102230352.914421-3-aurelien@aurel32.net>
	 <b51a62513daa9d2390031ec350e0b33bdb7e54aa.camel@declera.com>
	 <aaC78FTN31QYaVg0@aurel32.net>
	 <990bc03ed2baa05e619f0aa9cc6a23acadd66ea6.camel@declera.com>
	 <aaS6xeKFZz06fb1_@aurel32.net> <aaXuWwyA5NzBZzlW@aurel32.net>
	 <36f8df695463e5ff3eaaffbac357fc73026f7373.camel@declera.com>
	 <aadGw1fIlJyNNoum@aurel32.net>
	 <DGZM6WUAVPPS.20Y0NIZYI4572@linux.spacemit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.59.3 (3.59.3-1.fc45) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-03-11 at 10:58 +0800, Troy Mitchell wrote:
> On Wed Mar 4, 2026 at 4:38 AM CST, Aurelien Jarno wrote:
>  Hi, Aurelien and Yanko,
> > Hi,
> >=20
> > On 2026-03-02 22:34, Yanko Kaneti wrote:
> > > Hello,
> > >=20
> > > On Mon, 2026-03-02 at 21:08 +0100, Aurelien Jarno wrote:
> > > > On 2026-03-01 23:16, Aurelien Jarno wrote:
> > > > > On 2026-02-27 13:29, Yanko Kaneti wrote:
> > > > > > On Thu, 2026-02-26 at 22:32 +0100, Aurelien Jarno wrote:
> > > > > > > Hi,
> > > > > > >=20
> > > > > > > On 2026-02-26 16:32, Yanko Kaneti wrote:
> > > > > > > > Hello,
> > > > > > > >=20
> > > > > > > > On Mon, 2025-11-03 at 00:02 +0100, Aurelien Jarno wrote:
> > > > > > > > > Add a "spacemit-p1-reboot" cell for the SpacemiT P1 chip.
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > > > > > > > > ---
> > > > > > > > > v5: no changes
> > > > > > > > >=20
> > > > > > > > >  drivers/mfd/simple-mfd-i2c.c | 1 +
> > > > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > > >=20
> > > > > > > > > diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/s=
imple-mfd-i2c.c
> > > > > > > > > index 0a607a1e3ca1d..542d378cdcd1f 100644
> > > > > > > > > --- a/drivers/mfd/simple-mfd-i2c.c
> > > > > > > > > +++ b/drivers/mfd/simple-mfd-i2c.c
> > > > > > > > > @@ -99,6 +99,7 @@ static const struct regmap_config space=
mit_p1_regmap_config =3D {
> > > > > > > > >  };
> > > > > > > > > =20
> > > > > > > > >  static const struct mfd_cell spacemit_p1_cells[] =3D {
> > > > > > > > > +	{ .name =3D "spacemit-p1-reboot", },
> > > > > > > > >  	{ .name =3D "spacemit-p1-regulator", },
> > > > > > > > >  	{ .name =3D "spacemit-p1-rtc", },
> > > > > > > > >  };
> > > > > > > >=20
> > > > > > > > Perhaps its safe to merge this one now that everything P1 a=
nd I2C is
> > > > > > > > already in linus tip ?
> > > > > > >=20
> > > > > > > Unfortunately, this patchset is still missing:
> > > > > > > https://lore.kernel.org/all/20260207-b4-k3-i2c-pio-v7-0-62694=
2d94d91@linux.spacemit.com/
> > > > > > >=20
> > > > > > > This means the reboots work most of the time, but are not 100=
% reliable,=20
> > > > > > > and that's the reason why this patch got blocked from merging=
.
> > > > > >=20
> > > > > > I see. Thanks. Sounds to me like sometimes working compared to =
never
> > > > > > working is better , but anyway..
> > > > >=20
> > > > > I agree with that, but the decision was to hold on this patch unt=
il the=20
> > > > > I2C PIO part got merged.
> > > > >=20
> > > > > > FWIW  with this patch and the pio patcheset I get this rcu spla=
t on
> > > > > > reboot (which is still working). Similar splat is there without=
 the pio
> > > > > > patcheset.
> > > > >=20
> > > > > I haven't been able to reproduce the issue here after 10+ reboots=
 on a=20
> > > > > BPI-F3 board, but I tried the patch on top of 6.19. I'll try to b=
uild a=20
> > > > > 7.0.0-rc2 kernel and report back.
> > > >=20
> > > > I have tried that, and I am still unable to reproduce the issue wit=
h a=20
> > > > 7.0.0-rc2 kernel and a BPI-F3 board.
> > >=20
> > > I can still see it on every reboot (with the patches that allow reboo=
t
> > > to work). Do you have CONFIG_PREEMPT_RCU in your config ? its default=
 on
> > > when anything PREEMPT is selected. In Fedora its CONFIG_PREEMPT_DYNAM=
IC
> > > that flips it.
> >=20
> > Thanks for the hint, that option was not activated here, it's not the=
=20
> > riscv64 defconfig. With it I am also able to reproduce the issue. I'll=
=20
> > try to debug that and report back.
> I have sent a patch to address this issue here[1].
>=20
> Could you please test it on your hardware when you have a chance?
>=20
>                         - Troy
>=20
> Link:
> https://lore.kernel.org/all/20260311-v7-0-rc1-rv-dis-int-before-restart-v=
1-1-bc46b4351cac@linux.dev/ [1]

Thanks Troy.=C2=A0Seem to fix the issue here.
No splat and reboot still works OK on the R2S

- Yanko
