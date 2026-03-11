Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656942F4A05;
	Wed, 11 Mar 2026 02:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773197919; cv=none; b=G9qJZjxuXlYiL1z62yyyzBoQxBmVHtr3mUPROvAo6SLcK/zgvSmCvt4k4PYZAgKv4nkahO64/dCYVLgJwcNS5ZSntUt/nQuKolP+NRxEunoXccjAhCAUj7TdEZ/p7wuCi0gSOTGvkYT+LXxrg6c9+CZBZ11J+xLSiWqAuYHyGjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773197919; c=relaxed/simple;
	bh=6Rf0uh4RhMJgJFGyR4JqDEKL5ZSyP65SwK4gjPx8Txw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=dcG91Hi/cpjZm2oFprbixt1a9Olimz5eBFlvPUAZNW/qbNrHvTlO6rNYMge6a3/JjkpukjfX424V+zI/kCz+Ln090biO0WXW71KWrv02J4Db4wZBVQMNlQqM9Yz2FkjYuip+FqHOiciBsSyKHEchNocNZpq9gPE6Ouw7cDvqPqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=LSRChtqn; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="LSRChtqn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1773197898;
	bh=cdYAA+g/5AwgfFzsh2zrBrYJPymEr6G4WcYfRqa8g2A=;
	h=Mime-Version:Date:Message-Id:To:Subject:From;
	b=LSRChtqnKPeZxggn3LpUvHHohFsMj6mq0FODQYJr7ROt8aSa614pbptPTeNcYG17P
	 19BuP/CKfSRlhV39wvqOiAU3GFzBXixewOGBjPA4cZWTYh/oTaYIbnJAafzwBeW2N3
	 OfkFasBS1u8HZ39l5P8Xd3ehe4Vjz/NUUJFhdsoU=
X-QQ-mid: zesmtpsz6t1773197891tb6bc5c9c
X-QQ-Originating-IP: JjQFje59Pj2+UWzI0DdnSaJjGPej3hv3InT1nK7o+PE=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Mar 2026 10:58:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11627406965186864480
EX-QQ-RecipientCnt: 14
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Mar 2026 10:58:09 +0800
Message-Id: <DGZM6WUAVPPS.20Y0NIZYI4572@linux.spacemit.com>
To: "Aurelien Jarno" <aurelien@aurel32.net>, "Yanko Kaneti"
 <yaneti@declera.com>
Cc: <linux-kernel@vger.kernel.org>, "Lee Jones" <lee@kernel.org>, "Sebastian
 Reichel" <sre@kernel.org>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>, "Yixun Lan" <dlan@gentoo.org>, "Paul
 Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, "open
 list:RISC-V ARCHITECTURE:Keyword:riscv" <linux-riscv@lists.infradead.org>,
 "open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit"
 <spacemit@lists.linux.dev>, "open list:SYSTEM RESET/SHUTDOWN DRIVERS"
 <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] mfd: simple-mfd-i2c: add a reboot cell for the
 SpacemiT P1 chip
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251102230352.914421-1-aurelien@aurel32.net>
 <20251102230352.914421-3-aurelien@aurel32.net>
 <b51a62513daa9d2390031ec350e0b33bdb7e54aa.camel@declera.com>
 <aaC78FTN31QYaVg0@aurel32.net>
 <990bc03ed2baa05e619f0aa9cc6a23acadd66ea6.camel@declera.com>
 <aaS6xeKFZz06fb1_@aurel32.net> <aaXuWwyA5NzBZzlW@aurel32.net>
 <36f8df695463e5ff3eaaffbac357fc73026f7373.camel@declera.com>
 <aadGw1fIlJyNNoum@aurel32.net>
In-Reply-To: <aadGw1fIlJyNNoum@aurel32.net>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MgQY1K25Ph0m1e8G99xNUvvP+0z9ll90/jaNnJ17KFdkkwl1AjLndYkE
	iS9jlWMNKobXn5oEvQjfRrivp6aiz1GhpVtSUfl/Vdouf+sNr4XEUsOADhQBn9x4RtG1MSe
	ANpfgHD6mvrD5qmV33nV4tX5q03//NTcnqDYfRqmp+eKFntCzcJELJRs+A5Ye7J7A5odbeB
	fpSE3FRRgRBuC6tgF8yjbD/y186IaoRBjEEw6QDfiioz55MqP1rDfH7CgdRg9DbUuWeswk3
	ruDHBvmZrZfbr5BwIMYcSO0E10oo+dIgOzbZ2XAuDfhf4Vc9os3Nj0vI6Yrq6YNzvHGkcgP
	VDGlbjMa8rg5Ftciwi6DnpSbhPqZqeGFlnaZ9Cc2h5fh0ikAzb+4YNddOFl5XShD9GiiT7W
	1TWM3QbA/ia9n4rHMgQmdgLu9LAuBTRhBhbeSShR01CRejUNd+XDmg6uyuptn9aaYcQwW/0
	IBC8iLwvMZ8H3q7h7Qe2lWcaQhBAFq+m+jS8NzRLGJNSikmG5fe5MrJW89yZCjZLJ5bckPc
	DVcBZAIwPe5Yg0y+iWGLiHOr0KAhbWwm5CyKhEC5uNlYR9n0Pl+q2XAKL1DMa5sCyaEa+Rt
	y2ql4ijpJBjUyVUJVElJJqlSzrVZKAqhBVX3Xp6cP4S9gpPOakZxDo1YR/1SukinblSS9PI
	Y5ms3hGGSiqak+OwzgCGn6qKKCY+AL7s2nknP8rf5w75FfrAF0TgDhy51Vj1q8mtyBexHZf
	DyuRauolateszoa5jKMX0ijXrslKrxkOP8AblxztdZqDU2nMJfJw5QNpIFKEuTVa5XI4ae8
	dp5UGgX1/v1fKV0OgLIcKnWNxxdumc47XcdcQuA4+MNfbCZql/JJG6NZU7Tk7T7Z9p272tY
	oXU7SRbFlLnMPBptybCqNSmPEIIyO4CMb4zb3epRptRYNIngjmyLwY3qRJIsifhZqs1QXtb
	bOit9dElGBTQcz0lyMaBPGBTJ+6HA0ILHXx8SF8BTAH66PxAWp5gAUxyRliivBTL4pD5i01
	0K5RM2wSfj9jrH2RkcrmSPeA1M22vpjBfL9XI7EaueUCdJkSCd99O/quiTDoqDUQdZR3Ow9
	YzLnjutmQQ9smrM2QsEKd0=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

On Wed Mar 4, 2026 at 4:38 AM CST, Aurelien Jarno wrote:
 Hi, Aurelien and Yanko,
> Hi,
>
> On 2026-03-02 22:34, Yanko Kaneti wrote:
>> Hello,
>>=20
>> On Mon, 2026-03-02 at 21:08 +0100, Aurelien Jarno wrote:
>> > On 2026-03-01 23:16, Aurelien Jarno wrote:
>> > > On 2026-02-27 13:29, Yanko Kaneti wrote:
>> > > > On Thu, 2026-02-26 at 22:32 +0100, Aurelien Jarno wrote:
>> > > > > Hi,
>> > > > >=20
>> > > > > On 2026-02-26 16:32, Yanko Kaneti wrote:
>> > > > > > Hello,
>> > > > > >=20
>> > > > > > On Mon, 2025-11-03 at 00:02 +0100, Aurelien Jarno wrote:
>> > > > > > > Add a "spacemit-p1-reboot" cell for the SpacemiT P1 chip.
>> > > > > > >=20
>> > > > > > > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
>> > > > > > > ---
>> > > > > > > v5: no changes
>> > > > > > >=20
>> > > > > > >  drivers/mfd/simple-mfd-i2c.c | 1 +
>> > > > > > >  1 file changed, 1 insertion(+)
>> > > > > > >=20
>> > > > > > > diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simp=
le-mfd-i2c.c
>> > > > > > > index 0a607a1e3ca1d..542d378cdcd1f 100644
>> > > > > > > --- a/drivers/mfd/simple-mfd-i2c.c
>> > > > > > > +++ b/drivers/mfd/simple-mfd-i2c.c
>> > > > > > > @@ -99,6 +99,7 @@ static const struct regmap_config spacemit=
_p1_regmap_config =3D {
>> > > > > > >  };
>> > > > > > > =20
>> > > > > > >  static const struct mfd_cell spacemit_p1_cells[] =3D {
>> > > > > > > +	{ .name =3D "spacemit-p1-reboot", },
>> > > > > > >  	{ .name =3D "spacemit-p1-regulator", },
>> > > > > > >  	{ .name =3D "spacemit-p1-rtc", },
>> > > > > > >  };
>> > > > > >=20
>> > > > > > Perhaps its safe to merge this one now that everything P1 and =
I2C is
>> > > > > > already in linus tip ?
>> > > > >=20
>> > > > > Unfortunately, this patchset is still missing:
>> > > > > https://lore.kernel.org/all/20260207-b4-k3-i2c-pio-v7-0-626942d9=
4d91@linux.spacemit.com/
>> > > > >=20
>> > > > > This means the reboots work most of the time, but are not 100% r=
eliable,=20
>> > > > > and that's the reason why this patch got blocked from merging.
>> > > >=20
>> > > > I see. Thanks. Sounds to me like sometimes working compared to nev=
er
>> > > > working is better , but anyway..
>> > >=20
>> > > I agree with that, but the decision was to hold on this patch until =
the=20
>> > > I2C PIO part got merged.
>> > >=20
>> > > > FWIW  with this patch and the pio patcheset I get this rcu splat o=
n
>> > > > reboot (which is still working). Similar splat is there without th=
e pio
>> > > > patcheset.
>> > >=20
>> > > I haven't been able to reproduce the issue here after 10+ reboots on=
 a=20
>> > > BPI-F3 board, but I tried the patch on top of 6.19. I'll try to buil=
d a=20
>> > > 7.0.0-rc2 kernel and report back.
>> >=20
>> > I have tried that, and I am still unable to reproduce the issue with a=
=20
>> > 7.0.0-rc2 kernel and a BPI-F3 board.
>>=20
>> I can still see it on every reboot (with the patches that allow reboot
>> to work). Do you have CONFIG_PREEMPT_RCU in your config ? its default on
>> when anything PREEMPT is selected. In Fedora its CONFIG_PREEMPT_DYNAMIC
>> that flips it.
>
> Thanks for the hint, that option was not activated here, it's not the=20
> riscv64 defconfig. With it I am also able to reproduce the issue. I'll=20
> try to debug that and report back.
I have sent a patch to address this issue here[1].

Could you please test it on your hardware when you have a chance?

                        - Troy

Link:
https://lore.kernel.org/all/20260311-v7-0-rc1-rv-dis-int-before-restart-v1-=
1-bc46b4351cac@linux.dev/ [1]

>
> Regards
> Aurelien

