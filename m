Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9415F51476B;
	Mon,  7 Sep 2026 16:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788798213; cv=none; b=vAU10QxliVGW0rVKCSSDSELfnCPlpDSXPpQpmYDYZ9MDmeLWpk0HcaOqbsrBQeHjmzd2Irz0I3mRJ+x/uV0MPQcevhurBRztVxLoSjvf1qu+FKZ1HR1DoZiTQ9gMK0LS9ZfKsLGr9gLRL7VBudxd+C133ckeU6c33QEpHuoEb+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788798213; c=relaxed/simple;
	bh=Rws+UrFceK9gpVGfyg83ZQyFaujHhXr9nzhqYD2jPks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8yTmWlN7mRp/m7WrQ3UPJht5w3XSwenkHXFnTrF7t8NlHBJqGQPQCg1y7w9zZ18uoFVlwpmelbvunRH9qYgm2H3MXQLoBd/vx0xjIGGEbPNYrVEvpzmoIP/FiHZGQMDtQMSPiOnUfjc1QIe3EXXDLPrw9tVTOvf5WQTjqURGQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Grw3BlGd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Grw3BlGd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0901F00A3A;
	Mon,  7 Sep 2026 16:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788798208;
	bh=Rws+UrFceK9gpVGfyg83ZQyFaujHhXr9nzhqYD2jPks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Grw3BlGdU/vfZz1lj52hBMJcA7gNlp/oki7QykQUKKB+gwse6IdfAIRWN6TgXh8tj
	 HjU8jERpcm2TUDy+mM0AE/wmyyWYnvDiK6RWX8pifslSATJzLD/FpcW3hlWEYsKXU5
	 59rv+jMFa3bgDws9dsEiNqCovoTI4e47MMhzXN8mErksTgsgK8w1Wod8thg92WJbTK
	 182qZhl74sGgMzaSSPAktO1qPcn0+V09bIemcbCJV5Fa9smlaituCHg0DbSo0NIzYy
	 CRBPtK7lO0B5IjTLHmFbtGwtx7cc1OTtVtcQm45ne0l0OEgOeZZY8c2ofkxQu9KLyM
	 SK/WqaaVIOKIg==
Date: Mon, 7 Sep 2026 17:23:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Alexey Charkov <alchark@flipper.net>
Cc: Chris Morgan <macromorgan@hotmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v8 0/2] Add support for the TI BQ25792 battery charger
 (regulator part)
Message-ID: <2c60b540-fed7-4763-abae-759393730f15@sirena.org.uk>
References: <20260727-bq25792-v8-0-c1c70473bbe7@flipper.net>
 <CAKTNdwF5yW4YFFmsvDFVY+Q+89Uo=YS79nb4qYrT4WyKOszyvw@mail.gmail.com>
 <CAKTNdwGC=AZ9jmD71tz6JqCWk-00QLWCYb9wiG6RRQ0bO=mC4Q@mail.gmail.com>
 <7c9d0cfb-361c-424c-9e12-0fb35930576e@sirena.org.uk>
 <CAKTNdwE-m7_=EE1cp+B6dF0D5VXbrfnkYrJx48=78p04mccSVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lCuhZz4/u/Qc2Duh"
Content-Disposition: inline
In-Reply-To: <CAKTNdwE-m7_=EE1cp+B6dF0D5VXbrfnkYrJx48=78p04mccSVQ@mail.gmail.com>
X-Cookie: Who's on first?


--lCuhZz4/u/Qc2Duh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2026 at 07:16:58PM +0400, Alexey Charkov wrote:
> On Mon, Sep 7, 2026 at 7:10=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:

> > Sending content free pings adds to the mail volume (if they are seen at
> > all) which is often the problem and since they can't be reviewed
> > directly if something has gone wrong you'll have to resend the patches
> > anyway, so sending again is generally a better approach though there are
> > some other maintainers who like them - if in doubt look at how patches
> > for the subsystem are normally handled.

> Sure, but it has been over a month since the last ping, and several
> months since the patches in question were last changed and reviewed.
> At least two merge windows have passed since they received your
> Reviewed-by, and no additional feedback has surfaced. If it got lost
> (as it appeared in this case), I'd rather ping than live with it
> falling between the cracks. I didn't mean to get on your nerves.

Please note the bit above about how content free pings are not directly
actionable and if things have been lost you will need to send them again
anyway so spamming out the ping is just noise.

--lCuhZz4/u/Qc2Duh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqe5PsACgkQJNaLcl1U
h9ABgAf/VzJGhxJWELnHb4gIMd4d9UfubKF2qkLLV7eIvV3J1/KQcFXu6vYBAIYU
jXCAPa95Se07RiYnssBJUZNrv6rZU65o45DFl7Js3qbHRyPl5Q90HsLsM+iGCKzF
qZwQQM9OrCXA49v8dDGv01gCZr5esYTKqIkifUjWyQv4hvpMBg7E73fIovZKz/xZ
3mNh/BID8kND12Ro/ExFuXEhYgwa8S2MzflVpF02foFz+unC7f71stiXz8YiseGk
vvO14kSt7licWcZAbSxnQISv/L9tzKIEuaNiQJqpbkzouyuyDoVNdimLf0o7WHuF
BIrL6pu6oJEyhP1GmwZrwBbzJkS/Og==
=Ip5K
-----END PGP SIGNATURE-----

--lCuhZz4/u/Qc2Duh--
