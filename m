Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A5247D442
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328448; cv=none; b=uCLPEdeB1MYPXVcfp48qaj6H9xkNsqg4MI5kvDydgkEUF6jirfnLC8UNkrTjq5LAqHaYQMKh82RH2XifVzia+AjBdUWnj+EHOaCUulw/0z/GLij+tVjkI+b877yZE3QD/9A7APxoaIphBIzDZCS8QwiW3qfBBSQUibTyTUET4qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328448; c=relaxed/simple;
	bh=HeAEDpOyWDfK0HywfMKKJR7m/lfHHAOTVtMyX32Yin4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrVwvPtL1dnpc3QYtnfAqTAPY9WpBSzSi0t7BivXrWAuY+U7bVFTI6PXweNQ3lRFgE3UGDAYVsb3bcYduvf0QMvAOlcUHWtU/S0SU8CjvpvCqN1GRcPb1hpFUobqKx7rY2NBRS2SKRSyVnpoChimBePo8Qsr2IU05DjMdOpqD5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=JyLSAyA7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="JyLSAyA7"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49553515a8bso11534145e9.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 05:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785328442; x=1785933242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hj7jv6pRB6x5AF5ocoOAZbiwUraKrz6rxk84/RgEz0M=;
        b=JyLSAyA7JLsBjzsv5sIAMPO8UgSES5gspaHVhSgXArmDW4bnZ3K4YkR+4qtU1fywnQ
         Irjg6ff/Nvjc9ubPdR9GnYaiSVWJ6Da7YS4a2hnizuFlf9PDpqpYTwK03dtfX8cAxayz
         3UIZ5GdqQYnTu1hiva6mTgO8/7DP+6yIaC7oIU6+J9wmD2Rn8dcoVWOezjHdTsbyn5Mk
         wpC1l0wxXWdOpnXu+GBVY3mIhqePwqtPbHJTgwmpDO+x1laQYOe+JfuOWdoTQefrmkOK
         MowjE8U9DfsaCnyRNE5JCeZysqJapQ45v5K48JDGha168J44FXT5NQUi73Yy62IRY1vI
         IhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785328442; x=1785933242;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hj7jv6pRB6x5AF5ocoOAZbiwUraKrz6rxk84/RgEz0M=;
        b=V0hirmoW0K18TS21k+KJyL9u5xt3xl/smVFwZ1f5wV4lpIe57rRYJW1WVMb5gX/Mcg
         5t5+HNY5qxmgS0jpk9B+qb5YIIObeDShrdePqWkp6Wg8c5XqhNnkE37a9RxtY4AjHh8+
         8BdAVco74mnqo/hy3yY/Qo5UpsPkpNbZCTYJmOUVQ8yuM9qn2HKJNeLeWTE1mzO9BnvN
         trD6WUsRMYM8ospbtYv9cP2W7G+oRynefc5t0dH2Gzx2yP+vu0TN31ORKrPzrVf2OKBj
         1+5m3hkJOFUO1DeS8rRq3bDr6cWAlKxFInTgDxoDR2HY5mD4yHtwKmo3fYumWbOfnJRY
         HDjQ==
X-Forwarded-Encrypted: i=1; AHgh+RqXtjOBHAK4ffpVYvq8Wrga6WEp/ld4uFSrwwR2E4C9U8rUtbSbZiEePR2vWwwmrfCkxbTaDZ29YQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqNB87r0zZyN7lNcWtkjF98oyRtT8JdTW1dXALVOodJvMM9P0T
	hh32gajsjHKJkkEBprlXx4TLxZxFgU+e3m5hN3DymtNfrJe3REWZS00kR4NImGJT1B0=
X-Gm-Gg: AR+sD107IIGGWzKC8tNBBNkUYaayQeIXRTUZ3+9b6VEuqBoKLZg4ofarm4mdcMBIJOp
	Dfkx9XJ99aWWfYw7VQyHfDvCTR5zRSPis+WuoK5g5udn6JWIE1d6CvVkmBwcj+LZwyHiiIeKdrL
	r0iSys2/TDO28W5mKB4V4dQS3QoV3eJuKs4MaaARnJdExHeuvEBHd4KsNPRelBjdeR9Du4gS9Rh
	RZQ05LtUWbXnqKcE17gYXMLV5qbzSFzAz6QEZSQQu8qSwwqyiYpfY9aM/+JL8fOA5sI2tblTrBj
	yv3n6HMpaszZCLR9vW/yeb8DIr7FG5zWxCSYcFSwE/P85io97cM/M/0BYLFoKR1345jmkAvhcqR
	cpQG3Yybpt/gOS/lHgn5cCy+U7JDlnUzGwICD/mGhP3HjFCS+F7iqDgQPz/UzsbjGcPk+r76vpP
	YP2F7wnKULywg2AbiOzFW7/NMmHuujwSbVOLqRRhp//tLO/HFvcgVzrHpwmGtNM5DCbzaiWAwH2
	4Mw7i3g4J7pa88SSVbcH+0hFyT71sVAzS8P2jqedUFoaAEUeYUAHCQLZrup9A==
X-Received: by 2002:a05:600c:1f95:b0:490:c6c2:52 with SMTP id 5b1f17b1804b1-496c64261d4mr74271315e9.3.1785328441446;
        Wed, 29 Jul 2026 05:34:01 -0700 (PDT)
Received: from localhost (p200300f65f47db0401da7fd03a16a046.dip0.t-ipconnect.de. [2003:f6:5f47:db04:1da:7fd0:3a16:a046])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49764d6d0f8sm50701985e9.2.2026.07.29.05.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:34:00 -0700 (PDT)
Date: Wed, 29 Jul 2026 14:33:59 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v10 2/7] mfd: Add driver for ASUS Transformer embedded
 controller
Message-ID: <amnxliqWscD4Mjdz@monoceros>
References: <20260721095233.420823-1-clamor95@gmail.com>
 <20260721095233.420823-3-clamor95@gmail.com>
 <amGx2fJCUB4_XW1M@monoceros>
 <CAPVz0n2yWtTOgruRc+MAYTZ9=rd6qf6sEnX9v8THvJkN_opvbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6dqlofrf2szwmrad"
Content-Disposition: inline
In-Reply-To: <CAPVz0n2yWtTOgruRc+MAYTZ9=rd6qf6sEnX9v8THvJkN_opvbA@mail.gmail.com>


--6dqlofrf2szwmrad
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 2/7] mfd: Add driver for ASUS Transformer embedded
 controller
MIME-Version: 1.0

On Sat, Jul 25, 2026 at 04:23:13PM +0300, Svyatoslav Ryhel wrote:
> =D1=87=D1=82, 23 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 09:25 Uw=
e Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > Hello,
> >
> > On Tue, Jul 21, 2026 at 12:52:28PM +0300, Svyatoslav Ryhel wrote:
> > > From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> > >
> > > Support Nuvoton NPCE795-based ECs as used in Asus Transformer TF201,
> > > TF300T, TF300TG, TF300TL and TF700T pad and dock, as well as TF101 do=
ck
> > > and TF600T, P1801-T and TF701T pad. This is a glue driver handling
> > > detection and common operations for EC's functions.
> > >
> > > Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> >
> > Documentation/process/submitting-patches.rst has:
> >
> >         [...] the ordering of Signed-off-by: tags should reflect the
> >         chronological history of the patch insofar as possible [...]
> >
> > So your S-o-b should be last when you submit a patch.
> >
> > > +#include <linux/i2c.h>
> > > [...]
> > > +#include <linux/mod_devicetable.h>
> >
> > <linux/mod_devicetable.h> will go away soon. Please rely on
> > <linux/i2c.h> to provide a definition of struct of_device_id and drop
> > the #include of mod_devicetable.h.
> >
> > > +static const struct of_device_id asus_ec_match[] =3D {
> > > +     {
> > > +             .compatible =3D "asus,sl101-ec-dock",
> > > +             .data =3D &asus_ec_sl101_dock_data
> > > +     }, {
> > > +             .compatible =3D "asus,tf101-ec-dock",
> > > +             .data =3D &asus_ec_tf101_dock_data
> > > +     }, {
> > > +             .compatible =3D "asus,tf201-ec-pad",
> > > +             .data =3D &asus_ec_tf201_pad_data
> > > +     }, {
> > > +             .compatible =3D "asus,tf600t-ec-pad",
> > > +             .data =3D &asus_ec_tf600t_pad_data
> > > +     },
> > > +     { /* sentinel */ }
> > > +};
> >
> > Trailing comma after the assignments to .data please.
> >
>=20
> Sure, but out of curiosity, why in this case you ask for trailing
> comma and if entries are in one line, you don't.

Because this is the most used style. The rationale for the trailing
comma is that if you want to add a new assignment to a multiline
initializer you have to touch the line without comma:

 	}, {
 		.compatible =3D "asus,tf600t-ec-pad",
-		.data =3D &asus_ec_tf600t_pad_data
+		.data =3D &asus_ec_tf600t_pad_data,
+		.something_else =3D &foobar,
 	},

so if the comma is already there, the patch reduces to:

 	}, {
 		.compatible =3D "asus,tf600t-ec-pad",
 		.data =3D &asus_ec_tf600t_pad_data,
+		.something_else =3D &foobar,
 	},

=2E For adding a new assignment to:

 	{ .compatible =3D "..." }

you have to touch the line anyhow, so there is no advantage to already
have the comma. And then it seems parsimony prevails.

Best regards
Uwe

--6dqlofrf2szwmrad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpp8zUACgkQj4D7WH0S
/k6ZNAf8DhR7uBfXuQZzNcJ2dR9KB5Mucc4l5ZRolBWJcq6FHN8KK2BbDb+bkrcE
pUhYeNPt0LnZBA6JHWhJAM1zlHnLaQ2PlBWxeR4EIwAhM8nyXcfHgmgMJxBHSeEQ
qHWXZKtQd90uCGYg4BnQO8LmgAQR610/ujayOjnD0EgB2Wy19ZkENuG5Nu+Irzef
8DWW0WMWbrTCP49l4fgVWsLE8/yOaBE1jBeyaZ17yXLwz5vbs6OfeCkqaK11AOnH
KXbRlcea/K7YZX7wPKZLhHMSvmzSk+NEQgQpg7+qgg7NYMLDgJFCfvFTWhNj5lqb
GcHcRJv6c3GBFhS3t9oSrHiBeXrX0A==
=JxD4
-----END PGP SIGNATURE-----

--6dqlofrf2szwmrad--
