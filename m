Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1DA3AEF57;
	Wed, 11 Mar 2026 07:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215509; cv=none; b=LdQJaFo9z/ZpTKKz55F9dIMSQH3vYCzH1nn4PDhMnbW4njMDC+CCcA0dc371vH/AeuNCNu8LGxKAB6hKuXAYxlWskxtZYuP9qm3N7J6K012blyTkrymMwP0WNV1cPrK3ZuPOJYz7V105QJwnUi5QzTs2woeVJENAl/1b26oiksw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215509; c=relaxed/simple;
	bh=e36jCuwQ2QXfz9PniRclSf5MCBQDfIokoAxRq3nPoAM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=aMsXIwSJSBqG2J8pbs4wQ6a2/a0Fj0Hnp2l3j27TNVl4bp9/5a29TERHb7xhB1UhGtR2Ej8pOWwwoMbTyE0JI2VPvKj1w6PUWhSeKVi0jwse4ghzJfqtlLfbrLYyw6LbZ9m6rPnotBeduxhCBZ1xOgK2hnyflCc9kXA/QtufL6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=g64JORYz; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="g64JORYz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1773215493;
	bh=qWgwB8j/M+E4gmyyhynMGAfBcceSPDvi0TFbAOKm01s=;
	h=Mime-Version:Date:Message-Id:From:To:Subject;
	b=g64JORYz11/jmKOrVM0VEKIWELWeDPJ9eUd4VhaMkiLj1NdCTrB7vX+jxsdoF9t8d
	 VcnoWrqAfFfgaaoGaWFJ7vPucrlcU1G1JXihz6OF55XhhdJj5+XnDQB2c1vAuQSM5G
	 gftJH+HVOfYjMr2z/1aFw91Jacudn3nnVcEyjEJE=
X-QQ-mid: zesmtpsz9t1773215295tb12a1a0e
X-QQ-Originating-IP: ldkFeB95AQ/Pqp2XqD3PI0/pyB/6365kIn1OTkLhfkU=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Mar 2026 15:48:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5492583855199653968
EX-QQ-RecipientCnt: 14
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Mar 2026 15:48:13 +0800
Message-Id: <DGZSCZZTZXMI.15QP3KJ8LB61V@linux.spacemit.com>
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Yanko Kaneti" <yaneti@declera.com>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>, "Aurelien Jarno" <aurelien@aurel32.net>
Cc: <linux-kernel@vger.kernel.org>, "Lee Jones" <lee@kernel.org>, "Sebastian
 Reichel" <sre@kernel.org>, "Yixun Lan" <dlan@gentoo.org>, "Paul Walmsley"
 <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou"
 <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, "open
 list:RISC-V ARCHITECTURE:Keyword:riscv" <linux-riscv@lists.infradead.org>,
 "open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit"
 <spacemit@lists.linux.dev>, "open list:SYSTEM RESET/SHUTDOWN DRIVERS"
 <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] mfd: simple-mfd-i2c: add a reboot cell for the
 SpacemiT P1 chip
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251102230352.914421-1-aurelien@aurel32.net>
 <20251102230352.914421-3-aurelien@aurel32.net>
 <b51a62513daa9d2390031ec350e0b33bdb7e54aa.camel@declera.com>
 <aaC78FTN31QYaVg0@aurel32.net>
 <990bc03ed2baa05e619f0aa9cc6a23acadd66ea6.camel@declera.com>
 <aaS6xeKFZz06fb1_@aurel32.net> <aaXuWwyA5NzBZzlW@aurel32.net>
 <36f8df695463e5ff3eaaffbac357fc73026f7373.camel@declera.com>
 <aadGw1fIlJyNNoum@aurel32.net>
 <DGZM6WUAVPPS.20Y0NIZYI4572@linux.spacemit.com>
 <4ab8430161252ec778fabf7e9b68acf3645ed4c7.camel@declera.com>
In-Reply-To: <4ab8430161252ec778fabf7e9b68acf3645ed4c7.camel@declera.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MAX2iJCxWiMT4XKxma7qkE+1PbPsWs9IKHZP500BclgvkEiMQkDHXV9e
	4WYaniypeZ+SNsALrZg56hqlWw1JWv5Sd+9WNYMZltNF1eKyK8BA0q2nbx+15kozYTUOKRc
	V8TOez4mj5slWBA4H6FuAQWkgNqqCyMjateDnrhedJ6zhTcb6auJd9jPFSIVK+L+VVrsPng
	wI8s/qqKiRqRES2kL4ob0sSEl+cPiVsRidW7bsLnv3abBWCMAlNNW5451Fqd/ES1mr838I/
	k+Lv7SPPkzAJXaRvHMFWXLXRZqbnvcD6TIZwwYKq7Wad3MhJK2gSa/R2FQI3Bbp1seUWUU6
	W9CrYJTt23mZJ/mpK/7/nnTGdz8M3U0o3DvGfNECLoMzAC5FEOOMjwx96F/TnK6tZ5h6oXQ
	PCllTI6D/J8g+pOB+7jitoJhLKtozpnLoHyapCGQeE3WsZSVjdWSacXFr/4Eh+Rqw4MeozW
	CTrNr49C6yc8jH2FXzo2xGc9JbqzTCZ8+T+GIKrGe3FjOllFwb5UgPnKgQa2MS2dQFQFIoX
	iM5vVuNi5D1mi+pnLoEpzYjwThQa0GjO5aot2T0+Igtf/CtA5UEzkjZFBWL4g+eh21ACrKp
	XrGSX33gIeqRyDak7PoCurxKmOIbAtD2yAD9IjsRixYodx1xoBmehVbjRzOwcbyIgKfP5Ii
	+w3Xq7F2VItUAgHQ2qig4xaxkQEIQkB2bnU7CbHUX4noGXzBZG4ctMV3JeUtye93YCZ3Q7g
	nfmAsZ4WIKtQnK7CICMu9WVc2TQarObtuPUOD0Dd4HxvOb0yZGe2qxV34I7+2/3kvGWmGIo
	/UmXnOlCb5WbluaHwMKhIMRIKBC8EmEAG8+D5QJri7n8166gW8Z9iO28NqRm+QNeZiyLy9Z
	LaQ27AnkzV+ZjSfOkE1GGlM/gQo8x9LyPQBJxKo1KC/yULLOA3YRfpYChcSUxUoJHQ/Gzs2
	EcpsKqaEXBHyFwj+Bt7UD864tmJtcB8PWkxsXsqIEY6ApxckXLSkeb3sWUqpHGSaLnET8tj
	UZHeKNB7IAX2Kvey1efh7vnDBTUP+txGM/wfcVGuapq1Y90l22ut0Yz+GWmuFUDw7ILbm09
	XYWQGLYa201hKs4r4ajaR+t1teLEhEvALOkJ1DH84R0jJGPeV6V3Y1xGpAcSR411A==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

On Wed Mar 11, 2026 at 3:08 PM CST, Yanko Kaneti wrote:
> On Wed, 2026-03-11 at 10:58 +0800, Troy Mitchell wrote:
>> On Wed Mar 4, 2026 at 4:38 AM CST, Aurelien Jarno wrote:
>>  Hi, Aurelien and Yanko,
>> > Hi,
>> >=20
>> > On 2026-03-02 22:34, Yanko Kaneti wrote:
>> > > Hello,
>> > >=20
>> > > On Mon, 2026-03-02 at 21:08 +0100, Aurelien Jarno wrote:
>> > > > On 2026-03-01 23:16, Aurelien Jarno wrote:
>> > > > > On 2026-02-27 13:29, Yanko Kaneti wrote:
>> > > > > > On Thu, 2026-02-26 at 22:32 +0100, Aurelien Jarno wrote:
>> > > > > > > Hi,
>> > > > > > >=20
>> > > > > > > On 2026-02-26 16:32, Yanko Kaneti wrote:
>> > > > > > > > Hello,
>> > > > > > > >=20
>> > > > > > > > On Mon, 2025-11-03 at 00:02 +0100, Aurelien Jarno wrote:
>> > > > > > > > > Add a "spacemit-p1-reboot" cell for the SpacemiT P1 chip=
.
>> > > > > > > > >=20
>> > > > > > > > > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
>> > > > > > > > > ---
>> > > > > > > > > v5: no changes
>> > > > > > > > >=20
>> > > > > > > > >  drivers/mfd/simple-mfd-i2c.c | 1 +
>> > > > > > > > >  1 file changed, 1 insertion(+)
>> > > > > > > > >=20
>> > > > > > > > > diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/=
simple-mfd-i2c.c
>> > > > > > > > > index 0a607a1e3ca1d..542d378cdcd1f 100644
>> > > > > > > > > --- a/drivers/mfd/simple-mfd-i2c.c
>> > > > > > > > > +++ b/drivers/mfd/simple-mfd-i2c.c
>> > > > > > > > > @@ -99,6 +99,7 @@ static const struct regmap_config spac=
emit_p1_regmap_config =3D {
>> > > > > > > > >  };
>> > > > > > > > > =20
>> > > > > > > > >  static const struct mfd_cell spacemit_p1_cells[] =3D {
>> > > > > > > > > +	{ .name =3D "spacemit-p1-reboot", },
>> > > > > > > > >  	{ .name =3D "spacemit-p1-regulator", },
>> > > > > > > > >  	{ .name =3D "spacemit-p1-rtc", },
>> > > > > > > > >  };
>> > > > > > > >=20
>> > > > > > > > Perhaps its safe to merge this one now that everything P1 =
and I2C is
>> > > > > > > > already in linus tip ?
>> > > > > > >=20
>> > > > > > > Unfortunately, this patchset is still missing:
>> > > > > > > https://lore.kernel.org/all/20260207-b4-k3-i2c-pio-v7-0-6269=
42d94d91@linux.spacemit.com/
>> > > > > > >=20
>> > > > > > > This means the reboots work most of the time, but are not 10=
0% reliable,=20
>> > > > > > > and that's the reason why this patch got blocked from mergin=
g.
>> > > > > >=20
>> > > > > > I see. Thanks. Sounds to me like sometimes working compared to=
 never
>> > > > > > working is better , but anyway..
>> > > > >=20
>> > > > > I agree with that, but the decision was to hold on this patch un=
til the=20
>> > > > > I2C PIO part got merged.
>> > > > >=20
>> > > > > > FWIW  with this patch and the pio patcheset I get this rcu spl=
at on
>> > > > > > reboot (which is still working). Similar splat is there withou=
t the pio
>> > > > > > patcheset.
>> > > > >=20
>> > > > > I haven't been able to reproduce the issue here after 10+ reboot=
s on a=20
>> > > > > BPI-F3 board, but I tried the patch on top of 6.19. I'll try to =
build a=20
>> > > > > 7.0.0-rc2 kernel and report back.
>> > > >=20
>> > > > I have tried that, and I am still unable to reproduce the issue wi=
th a=20
>> > > > 7.0.0-rc2 kernel and a BPI-F3 board.
>> > >=20
>> > > I can still see it on every reboot (with the patches that allow rebo=
ot
>> > > to work). Do you have CONFIG_PREEMPT_RCU in your config ? its defaul=
t on
>> > > when anything PREEMPT is selected. In Fedora its CONFIG_PREEMPT_DYNA=
MIC
>> > > that flips it.
>> >=20
>> > Thanks for the hint, that option was not activated here, it's not the=
=20
>> > riscv64 defconfig. With it I am also able to reproduce the issue. I'll=
=20
>> > try to debug that and report back.
>> I have sent a patch to address this issue here[1].
>>=20
>> Could you please test it on your hardware when you have a chance?
>>=20
>>                         - Troy
>>=20
>> Link:
>> https://lore.kernel.org/all/20260311-v7-0-rc1-rv-dis-int-before-restart-=
v1-1-bc46b4351cac@linux.dev/ [1]
>
> Thanks Troy.=C2=A0Seem to fix the issue here.
> No splat and reboot still works OK on the R2S
Thank you and Aurelien for the test.

To be honest, I'm still not entirely sure if this is the right fix.
I=E2=80=99m curious why RISC-V doesn't disable interrupts during this task,
as ARM and PowerPC do.

I've sent this out with an RFC prefix and am looking forward to getting
some feedback from the community.

                                            - Troy
>
> - Yanko

