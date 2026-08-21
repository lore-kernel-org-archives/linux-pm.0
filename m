Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13EA46EC60
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787308187; cv=none; b=XBAHAvVBOdI5lP9/ybRuYr8LlW3kDAxJC7PUwdDdg+fSd42XjyXXP9TXO7qGX5FlKskJIBs62whasWYT7bPSbCEIfoI7WtGyRUJYBEo/eMflREFN7kSmAHHSM6eSNQwK8+KC7IKDkehAThmS+mroamJhVUs+f2jnwbBlkE3b/TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787308187; c=relaxed/simple;
	bh=z9EQoVgNbg2axkWkbAyKd8/CEnXWbyzyw2LD4bW39oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHv44gw2LMwFbGKUNYE6Y54aMYXyQ+9THAKcKn9HV3uNAjDbwl6q2XVO1rvSxDlSZnd2V3mw9lbf+AHhl7LxooKZlfCH5E5ccVQZ9Zc0K5sW6qjI6KrVS3wJV+Ww4al9qdvrbCHUBv/QYmZORmUlKOO65y6UuMPUxjAyav3mpdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Z0gY53W6; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Z0gY53W6"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so1521499a12.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 03:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787308177; x=1787912977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3q2kAFvuoxQvl05k3dFsUQHbA2yys0YHAMJwMetTSBg=;
        b=Z0gY53W67ggpiCJYVuceEnvhCIA5Yp81w5jpwpQ7pd+9AkMk1j13pm/O/MOBTHCpvN
         FtDdFyVNz/dxRKCHW1WkjHCutSIybUq8P5QQHGNU4hEqXCbz2DICOhNM9BO54OBt5x+O
         SSgXd1ckQIfoZx2kDAtsjLgnvTCygdY/WHt4wM488Qje2B9SVtAXGrH1XEQcRVcddIdP
         S4hNmtXZberYFmfF5Q8CeycUkmDCgmHPzcv0pHGqFhzGR0QcPH1irFsjK5CiwHGYwao+
         2bx3Hnan6LIO+ocHShyolGarUXJ2pDtnYmHcsr979U2eRYLXRos2UH2LdWyUimGp4bwY
         TVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787308177; x=1787912977;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3q2kAFvuoxQvl05k3dFsUQHbA2yys0YHAMJwMetTSBg=;
        b=ECS85kwgMXEiH0AGfxsxQ33iTCsgMiNXLnpomSCTw88QkvJCaS4jv864UNGIy09+Uc
         wj3hOZprjT3Ia3Z5y8MZaKTnzFSmibRQPOCXEjwu9VmwjLkc738+zZ3N/1YClNohdfKn
         5keeWta2GicNqFNfdjiApiWrlq5Sgv5XZW7UG+k66OVYdsTX7D0PdcT99Dsp5u2M/J+v
         TQa61GIjh487IE/1FXSjvY1/KDEX9+Gt0av/Uf1av0tIpFKSHVDRjHgpnA49yVZhVnjh
         RFLNPK1Wi9v868Nc0p0WiIDTu2gJ7Hctd/wrxxr5j9jXZwLLedD03ArBOL7CnU9J+4zD
         oEmA==
X-Forwarded-Encrypted: i=1; AHgh+Ro6odLy0y1u5/P3gG0MDVOHBETvr7JZTuRTHbf/HRKJZy+4FGpdiODOzaGv3J10JO2423MzYCgpfg==@vger.kernel.org
X-Gm-Message-State: AFuF++myI7jkFtJfNxnVO3USLN5eKu/nRMiOsUlQLYsfI2dGGB66h1oi
	3w1zeCyKsgk5/ZrRgXvZay0Z6l3PYr5X0eM0H75btybYKDKWJx767UmGnqYUQUONaCc=
X-Gm-Gg: AR+sD11qlnmgeko787/en50VK0/KgYfF0ubJbuqeyo/2gT86ECYrrXL0uHx4aUImT5y
	ZOHAu6SralNdxpgseH3D8TcWRNSJX9d7uogxdGkhXcTD5YjRbSfCV8IygfHSt0NxNikAYJS6OEN
	3P7H7ziRXBw9xeqB0vcAqke+SrqyxoLkkZmRCAXLcH8n0T3/FmkxPdtok3ulvAqfeMttoUgZqG4
	SUUmkd2D2ODGsw4+qkuWVFh5tzc/94qG0NMzT8R6epzQDM/eyeaJUpbXAiISR80a9Vcjb9dY7IQ
	t7GP+6vZDFlwvn5ZbsMdo8b0SEu1o2cLbPz+kjEeTkf8z+PQyKi2/VQLgB44+Ue2uFOmIbDAVnU
	s1mBGXEhhnhKXktvIfsPVb8+FKWYUAkfUleUKiD/6crJrHKFczaACzPRlEzM1VEJ42c6GmYq3sL
	emJbSn04OjM6rz0sZDjI2lGlIjI7Ulcug9szs+Lo9nTAOepxD7bT8xflXP7kI3RjFoBO6FYQtBt
	pD3zXuVIaIT25TfLZzC/isepWlxXQSug/iNqyTOLoCFOWwFMMr1UfZdR4bEG3E=
X-Received: by 2002:a05:6402:190b:b0:6a3:fdb6:9db2 with SMTP id 4fb4d7f45d1cf-6a42f14dee5mr5384496a12.3.1787308176450;
        Fri, 21 Aug 2026 03:29:36 -0700 (PDT)
Received: from localhost (p200300f65f19a904ef0464a68b5fdde4.dip0.t-ipconnect.de. [2003:f6:5f19:a904:ef04:64a6:8b5f:dde4])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6a3ff0c3491sm5884995a12.10.2026.08.21.03.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 03:29:35 -0700 (PDT)
Date: Fri, 21 Aug 2026 12:29:33 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Daniel Lezcano <daniel.lezcano@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Mark Brown <broonie@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-iio@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, 
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH linux-next] thermal/drivers/qcom-spmi-mbg-tm: Add module
 namespace import for IIO_CONSUMER
Message-ID: <aogl2JvYUnxwr_cE@monoceros>
References: <20260812-qcom-spmi-mbg-tm-ns-modpost-error-v1-1-d849390d2714@kernel.org>
 <20260813023543.6936b188@jic23-huawei>
 <20260814000505.GA3919970@ax162>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gftjfe4gnzfoeoa5"
Content-Disposition: inline
In-Reply-To: <20260814000505.GA3919970@ax162>


--gftjfe4gnzfoeoa5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH linux-next] thermal/drivers/qcom-spmi-mbg-tm: Add module
 namespace import for IIO_CONSUMER
MIME-Version: 1.0

Hello,

On Thu, Aug 13, 2026 at 05:05:05PM -0700, Nathan Chancellor wrote:
> On Thu, Aug 13, 2026 at 02:35:43AM +0100, Jonathan Cameron wrote:
> > I did plan for this being a possible issue:
> >=20
> > Ideal is merge=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git #iio-inke=
rn-namespace-ib
> > to the thermal tree.  If I'd called that out originally (or a thermal
> > rebase is a possibility) it would be cleaner to do this before the
> > qcom patch adds another user then squash what you have here in the appr=
opriate
> > patch.  Alternative is do it as a merge conflict resolution whilst merg=
ing
> > in that tree.  If the second, I'd also mention that in the thermal pull=
 request to
> > Linus given it's a little unusual.
>=20
> Ah, I did not realize that you had a stable branch with the module
> namespace patch. Merging that in then applying this to the thermal tree
> seems like the best course of action. If rebasing is possible, I do not
> mind this patch being squashed into the original.

FTR, this issue is still present as of next-20260820. Assuming that
c3dce117333c ("thermal/drivers/qcom: Add support for Qualcomm MBG
thermal monitoring") is supposed to go into v7.3-rc1, it would be
awesome to address this before the commit hits Linus' tree.

Best regards
Uwe

--gftjfe4gnzfoeoa5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqIKIkACgkQj4D7WH0S
/k5oNwf+P7ShIOzZtMVykns2ARO4q7wy2ilILuhF81COzO9YwBFJpU55RFz+5SYw
T/3c3PNN8PRp8toJEGod5jjBwNG5nu9Z/lml5aiUQqQn3bg6gbpGMAqVf/OjzQ9G
I1sxcXY3r4keqqNS9lwwVulyV821skH0PCL60ahASvPE553sZKfFXybw40F5+CS1
5nWVgswzlAsz6fCbVqq9BXIvfvHYJLUowM4brWEsSrc61cU1W6T+1OKV2+u7ZV2t
AXgJrJgJiLSbxk8OhDXZfSHhY0zzWnoNHzFYCr3mJ2PP8GDJTWi8vH6RABcTZTeb
aQQWEWJuDyNN5Y95QB2JyfIcZuogYw==
=F3e/
-----END PGP SIGNATURE-----

--gftjfe4gnzfoeoa5--
