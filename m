Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F26426D26;
	Tue, 31 Mar 2026 22:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.119.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774995633; cv=none; b=na+LFHlF4jj3P20sBu1UpYGHlbGRBYsD28qPfBJSZt8773Nf9ehfqaocm5MRYDM+9iqAr+t0FQBRZgfX4D3Ej4oAkM5wqYcSa2rL4hP8kEq6M0R6MRDiw73wj7rhtYrXV9ftyP1fWIUfrE0fCmk8HCzHEIkpa4xPHFjOw0jo2oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774995633; c=relaxed/simple;
	bh=djBmP9Nro7XmQ9K/Sg1Ln48TcB3O+Me93DLr6qxtC4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8jyR1ksxA13gYsaxkV6QbkHmSfdXK3BHp8oNCmelbOuAWdq3BEMKotXQuycnJxehAE7e4lrONKkS7tnRt/FuPalQiqqa6XsQ5haRrnihQ9Hqz6XeaqaZejkWsQQYECWOZ3f39L1rKBk1KdRoCYuNbsmbVD0L1yjZ7XhYM55dB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=o4pE/6bt; arc=none smtp.client-ip=195.154.119.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="o4pE/6bt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=8QrORnPZaSGq5GzeR6qKATdKLTvS76Qgu9+YPtMIjC8=; b=o4pE/6btLzmop8vRahnPZ56JUj
	g7qOZUw0bka/N9w+c19mYpJANyH6R3uZ3+xlgS1ViFpgwyPwSA/cf/D609vGluyL1pQiticJYQtS3
	Oa4c+Ucr8yNN4lrLvZbsYHD2oy3eQE7PV09D/EEdf/TGEWgoUwXCut/gpqUn7w0EmTSF/2r/OxzCm
	Rr9mqtU7yahwvDtLim/9FhG5nDIaQGceB5Z7+Jms1k4nvWLSxS57xZELhiS9Y52kKnhvNj09dDxeF
	9aKfuepw71XHJsriFvnBRdDo1M6BETlu7TW5qb1Rl/9P6yepiwuJbXbqKIdx3q6B1i3uAs+CVOFbr
	L4SX8f/g==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1w7hRV-00000005Pud-1BAP;
	Wed, 01 Apr 2026 00:20:13 +0200
Date: Wed, 1 Apr 2026 00:20:12 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Lee Jones <lee@kernel.org>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	Yixun Lan <dlan@gentoo.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH v5 0/2] driver: reset: spacemit-p1: add driver
 for poweroff/reboot
Message-ID: <acxInP3_rU9H8Q5V@aurel32.net>
Mail-Followup-To: Lee Jones <lee@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	Yixun Lan <dlan@gentoo.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-pm@vger.kernel.org
References: <20251102230352.914421-1-aurelien@aurel32.net>
 <176213091347.301408.11587695003687450479.b4-ty@collabora.com>
 <FA447DF1D2398A79+aQlVuEbrLMCiGMpc@kernel.org>
 <20251105093347.GD8064@google.com>
 <E205F88FB1EE06C5+aQscI0Uy7pgiMzEt@kernel.org>
 <20251105100856.GG8064@google.com>
 <20251105101149.GH8064@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251105101149.GH8064@google.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

Hi Lee,

On 2025-11-05 10:11, Lee Jones wrote:
> On Wed, 05 Nov 2025, Lee Jones wrote:
>=20
> > On Wed, 05 Nov 2025, Troy Mitchell wrote:
> >=20
> > > On Wed, Nov 05, 2025 at 09:34:21AM +0000, Lee Jones wrote:
> > > > On Tue, 04 Nov 2025, Troy Mitchell wrote:
> > > >=20
> > > > > On Mon, Nov 03, 2025 at 01:48:33AM +0100, Sebastian Reichel wrote:
> > > > > >=20
> > > > > > On Mon, 03 Nov 2025 00:01:58 +0100, Aurelien Jarno wrote:
> > > > > > > This adds poweroff/reboot support for the SpacemiT P1 PMIC ch=
ip, which is
> > > > > > > commonly paired with the SpacemiT K1 SoC.
> > > > > > >=20
> > > > > > > Note: For reliable operation, this driver depends on a this p=
atch that adds
> > > > > > > atomic transfer support to the SpacemiT I2C controller driver:
> > > > > > >   https://lore.kernel.org/spacemit/20251009-k1-i2c-atomic-v4-=
1-a89367870286@linux.spacemit.com/
> > > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > dependency is here.
> > > > > > >=20
> > > > > > > [...]
> > > > > >=20
> > > > > > Applied, thanks!
> > > > > >=20
> > > > > > [1/2] driver: reset: spacemit-p1: add driver for poweroff/reboot
> > > > > >       commit: 28124cc0fb8c7dc01a6834d227351e25d9a92c58
> > > > > Should we apply it now? The dependency patch hasn=E2=80=99t been =
merged yet...
> > > >=20
> > > > What is the dependency?
> > > I point it out above.
> > > Without this patch, reboot and shutdown would end up calling the non-=
atomic i2c_transfer.
> >=20
> > Okay, thanks.  I was mostly checking that you weren't referring to the
> > MFD patch, which doesn't represent a true dependency.
>=20
> To save Sebastian some trouble, let's keep the reboot patch applied.
>=20
> I'll hold off on the MFD one, which will ensure that reboot isn't probed.
>=20
> Let me know when the dep is merged and I'll hoover up the rest of the set.

The dependency is still not yet merged, although it has been ready for=20
weeks, and I am just crossing fingers that it will get picked-up for
for 7.1.

That said it's not a hard dependency, in most cases reboot will work,=20
which is an improvement over no reboot driver. The missing I2C PIO=20
patches are just there to make it reliable.

Therefore given the 7.1 merge window approaching, I believe it's better=20
to merge this simple MFD patch and to not wait more.

Thanks
Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
