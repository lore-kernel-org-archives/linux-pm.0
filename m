Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEF62727F3;
	Fri, 10 Apr 2026 01:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775785777; cv=none; b=WItwG452M+RBks4EMJvECdEZRf+lcWxD2aGI2awMoR5jFygjKZoHRC/mSJP5mXG/oNZrrXtL3pr41QuHvpgnT9d3VaM49wPdvlO/V4tXYfKfgCnXkuTVZnKNoMHQrdsuWzZfAeTZBv+3d8Yqb9Sgaerqb06b4dyTjKSZ8VOOiJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775785777; c=relaxed/simple;
	bh=cjNQH1qJbLdjrSUM8AhX5PvNVhb/eXwwHoPvpF7jJvs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GWc36yaVEqrsr2bnz77trU3EfmXgkzHLXC9ffEpBQcgrHLCHpCtPI3Kflae3pmh00IPUxg+gG9spnn4Nr8KZu6cbhV8TyeCAvWLhW9Ge2j0NVDTPvndKFJhXGqq+YIdWU/ak2XkeBD7MIghmFe9+Dyq92uXOEEYtxNm6Y5pTT18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=LWiDhGX4; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="LWiDhGX4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1775785757;
	bh=SZbYS0Qb7WvP36b6C+O8auN3UbA6aoly84MdaQv+5nc=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=LWiDhGX4DM3WIISkc2qqFcK3Gv/PbRYwKGS1iCQzuqgDfq4Rs554GFdGcDvSdi0Ad
	 R2qu/CBfRvwHiUkn12f8+XXh7PUKUE3Csb0vYwdhLi/iH8onvhIIJ/hORppS9/XGjj
	 5PAACNSAEnw8F6W+I6CIGK354+KDi2/kBGthsPzA=
X-QQ-mid: zesmtpgz9t1775785752t0ec45321
X-QQ-Originating-IP: jf/yfmslXbOw835KrUa4sX1NzoM1+TMW786OM3q7AQI=
Received: from = ( [183.48.247.238])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 Apr 2026 09:49:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12731809444292626106
EX-QQ-RecipientCnt: 14
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Apr 2026 09:49:10 +0800
Message-Id: <DHP3IFPL45T4.FI2WYSYGN8KX@linux.spacemit.com>
Cc: "Sebastian Reichel" <sebastian.reichel@collabora.com>,
 <linux-kernel@vger.kernel.org>, "Sebastian Reichel" <sre@kernel.org>,
 "Yixun Lan" <dlan@gentoo.org>, "Paul Walmsley" <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, "Aurelien Jarno" <aurelien@aurel32.net>,
 <linux-pm@vger.kernel.org>
Subject: Re: (subset) [PATCH v5 0/2] driver: reset: spacemit-p1: add driver
 for poweroff/reboot
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>, "Lee Jones"
 <lee@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251102230352.914421-1-aurelien@aurel32.net>
 <176213091347.301408.11587695003687450479.b4-ty@collabora.com>
 <FA447DF1D2398A79+aQlVuEbrLMCiGMpc@kernel.org>
 <20251105093347.GD8064@google.com>
 <E205F88FB1EE06C5+aQscI0Uy7pgiMzEt@kernel.org>
 <20251105100856.GG8064@google.com> <20251105101149.GH8064@google.com>
 <FA1DBD9E7CCB8027+aQtMvb5Br7MgMW4K@troy-wujie14pro-arch>
In-Reply-To: <FA1DBD9E7CCB8027+aQtMvb5Br7MgMW4K@troy-wujie14pro-arch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NGXMM7FVunQ9DKaBzPNi7590jvJDR2dOmiiH2iyIBcoAK6tZsVHzEVuR
	cgXHoBxvv6ZizjOCtq3h1RmCR0AqZtB+zbV3g1qBlM3yDtSUrfitNUOYFTO8diCOoaPoPAZ
	AIIzDH9kNFO/mvA2VoPgpBH50aLKlA7s04GfqvIQC3MXji7nYRkml6sHG5rqC8KzdUnDImf
	xl2xth0KZWIwD8ZIm/4+Isxk2HGCMZDUAXR71Snq/4at6AVx7WHS2njxfZ5IUQyq9qUexyV
	U4WQKHZG57CuI14tWnnFx5D+v+rxu7Zwjx9K0E3eOduMCYmnEBKjeQkOgf5sDQVL6O5dg5o
	h92JZjbBeUHxIsEVhsG0PYnnRUz8LHRs41m7UhG+VLvs9YWOkcGnHKGbiIdvBSYw+f7ODzm
	nr7YlEaIHXCE9WrtsPixwlh9s2lsBawVsNvmGVJteSMbPdf9IeH/ET+6X9DeyKDMjbJe1yh
	G1v12QxFXQyK/l79L1C18O1Y/H55srWde9b4eJFUZ9a1jwmVJiePUOBvnE1kU1Y22y+C2Cp
	0Aol0SpAPeQL7/y1WnVJMOEcg65G67h55U8sEWm15A9FR6Jv+p+dg0rZud7Q6Q2QmCVj105
	JzpA4XglZJ4HUF/viGiEfz6p2SYsIkv0E0akuQYkO/vQ6tNdiR9pQi2EmbA+OOH2j+29H7F
	NJ+hYIHT16LW+WstgBQ7+mjm5BRDyi0mgQPTGgHNE4VRtsIzUYYct2wdoMuTwy/iFDFautt
	osuBNa7bt004VqQl+1Hm2MUxJdc0K9xrZgCCKJFDZmsNGDswmQQAblA5Lui5k4FBQpuxu51
	7YAe+bjiM+F3Xvh1E4oPLkn304dbqqrUNZXqVu6/tskIjZ9XyzPwlvJPJHDPoc3Gl+7OWT2
	Vh8BlEYYniEA9VI3FHR8VTNfujvtGlUImbOH7s9HoF/FK3Yte6XZaHJW6peedcWw7PQeM8z
	7H5fbp5/kzZzOMH6hwuxYP4f0/Eqz3te9piaG35aI1yo5O0Sk1L7GvyAa3BZbZEBPLu0y+F
	eA/UH9guiMDWzlMDSrhI2hCgu8OZvFkfXr4qwL1qfvwxmrGJvtqgQDKMlbM3rILnor7KNI5
	mZsPN+QRJDQ
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

Hi Lee and Aurelien,

On Wed Nov 5, 2025 at 9:10 PM CST, Troy Mitchell wrote:
> On Wed, Nov 05, 2025 at 10:11:49AM +0000, Lee Jones wrote:
>> On Wed, 05 Nov 2025, Lee Jones wrote:
>>=20
>> > On Wed, 05 Nov 2025, Troy Mitchell wrote:
>> >=20
>> > > On Wed, Nov 05, 2025 at 09:34:21AM +0000, Lee Jones wrote:
>> > > > On Tue, 04 Nov 2025, Troy Mitchell wrote:
>> > > >=20
>> > > > > On Mon, Nov 03, 2025 at 01:48:33AM +0100, Sebastian Reichel wrot=
e:
>> > > > > >=20
>> > > > > > On Mon, 03 Nov 2025 00:01:58 +0100, Aurelien Jarno wrote:
>> > > > > > > This adds poweroff/reboot support for the SpacemiT P1 PMIC c=
hip, which is
>> > > > > > > commonly paired with the SpacemiT K1 SoC.
>> > > > > > >=20
>> > > > > > > Note: For reliable operation, this driver depends on a this =
patch that adds
>> > > > > > > atomic transfer support to the SpacemiT I2C controller drive=
r:
>> > > > > > >   https://lore.kernel.org/spacemit/20251009-k1-i2c-atomic-v4=
-1-a89367870286@linux.spacemit.com/
>> > > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> > > dependency is here.
>> > > > > > >=20
>> > > > > > > [...]
>> > > > > >=20
>> > > > > > Applied, thanks!
>> > > > > >=20
>> > > > > > [1/2] driver: reset: spacemit-p1: add driver for poweroff/rebo=
ot
>> > > > > >       commit: 28124cc0fb8c7dc01a6834d227351e25d9a92c58
>> > > > > Should we apply it now? The dependency patch hasn=E2=80=99t been=
 merged yet...
>> > > >=20
>> > > > What is the dependency?
>> > > I point it out above.
>> > > Without this patch, reboot and shutdown would end up calling the non=
-atomic i2c_transfer.
>> >=20
>> > Okay, thanks.  I was mostly checking that you weren't referring to the
>> > MFD patch, which doesn't represent a true dependency.
>>=20
>> To save Sebastian some trouble, let's keep the reboot patch applied.
>>=20
>> I'll hold off on the MFD one, which will ensure that reboot isn't probed=
.
>>=20
>> Let me know when the dep is merged and I'll hoover up the rest of the se=
t.
> Okay. I'll reply this thread when the dependency is merged.
Ths I2C PIO patchset has been merged here [1].

Link: https://lore.kernel.org/all/adfVk82OC1c3Zn8a@zenone.zhora.eu/

                              - Troy
