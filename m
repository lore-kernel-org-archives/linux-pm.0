Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E733537C7;
	Wed, 22 Jul 2026 01:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784683521; cv=none; b=TQ/mUSMwFhBHRFq5FqAdxXN3SxTsBEz9/pPdTEQU+jgHha0QN2nqpcV4wvNP3ORIgGSqFvVarAaRDOUjnZ20CMavWcITYdodP3Jd1lpEyIKQR4mUAYE1HZY8J85d/VcQ1xKl0Q2IF/aZJ7hfX90+RB/aoTqW/xpgiklIydSR5Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784683521; c=relaxed/simple;
	bh=9L+0Xwf58DDWQejOXdShJAWU/VMeCUWm6f1oiQxQ7zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8LnOsdA+qUCuKlFw96khQFupcxb/rCiM+brFHoW6X09D8a63Q83p3YVGxESX6cfyJurqEDpwBGhV+VGhO/RdxgQ9WH7M+VvA9R4qiIaBnBggiRfNysl+ZwBvx9/raxB5oJdY6wk+R81y1CtzFiBVvTER81HB/gKDi1PYX3Sb/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdde+FOb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdde+FOb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597CC1F000E9;
	Wed, 22 Jul 2026 01:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784683519;
	bh=RG9GARYZaUdJHSi00MbmujgqIy86y3ssPPU8fLAUVms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cdde+FObaxyGj0T0DyocnyvSXAzNWFEug3FBv4Uay0VX3lQD0etkWGw4jJddGiU3C
	 SfmplLqPcfqGdr5pxIALU38j+E4ZlM+ESfWUAX55Az+FsL7VX0XH39jYOZ+B78WMjU
	 M2c5NWfwejRUMRvLFgFebtO2nXC7oXNJydJL4uZued50tyrXvH0t4k+g016MA/iLXm
	 e5jNVsrTIOLZw4Sdxewh1fbi7Uvzg8SqrQW7LXos6j0SgnSkIZ9J5B/fOH9ka7MN0m
	 J39tWl4Ab7Sl6XwsrpewQedAkkbAlQZ5TWMOLXuQ0dWoLNgXqP3rOru2Y9vKAcaOuE
	 Z+FrTlwHdJwtA==
Received: by venus (Postfix, from userid 1000)
	id 1711B180765; Wed, 22 Jul 2026 03:25:17 +0200 (CEST)
Date: Wed, 22 Jul 2026 03:25:16 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: kernel@axis.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] power: supply: Add sysfs entry for system load
 control
Message-ID: <amAPPg45CD8c2JX1@venus>
References: <cover.1782746851.git.waqar.hameed@axis.com>
 <3290b7eabb9dff19d77ff50d5ff1c4db4d37bdc1.1782746851.git.waqar.hameed@axis.com>
 <pnda4sb3vyh.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kdgdlliqykyn4s7x"
Content-Disposition: inline
In-Reply-To: <pnda4sb3vyh.a.out@axis.com>


--kdgdlliqykyn4s7x
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 01/10] power: supply: Add sysfs entry for system load
 control
MIME-Version: 1.0

Hi,

On Wed, Jul 01, 2026 at 11:23:02AM +0200, Waqar Hameed wrote:
> On Mon, Jun 29, 2026 at 17:44 +0200 Waqar Hameed <waqar.hameed@axis.com> =
wrote:
>=20
> [...]
>=20
> > diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentatio=
n/ABI/testing/sysfs-class-power
> > index 32697b926cc8c..2287b207311cd 100644
> > --- a/Documentation/ABI/testing/sysfs-class-power
> > +++ b/Documentation/ABI/testing/sysfs-class-power
> > @@ -590,6 +590,30 @@ Description:
> > =20
> >  		Valid values: 0 - 100 (percent)
> > =20
> > +What:		/sys/class/power_supply/<supply_name>/load_switch
> > +Date:		June 2026
> > +Contact:	linux-pm@vger.kernel.org
> > +Description:
> > +		Devices can control the connection from power to system load.
> > +		For example, with a field-effect transistor between a battery
> > +		and the system load (BATFET). This entry controls such switch.
> > +		The obvious states are "on" and "off", i.e. there is a
> > +		connection or not, respectively. However, many devices can also
> > +		enter special modes such as "low-power", "shipping" or "deep
> > +		sleep". In these modes the switch is usually off and the
> > +		quiescent current quite low.
> > +
> > +		Access: Read, Write
> > +
> > +		Valid values:
> > +
> > +		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +		"On"      (1) Power is connected to the load.
> > +		"Off"     (2) Power is disconnected to the load.
> > +		"Standby" (3) Low-power mode.
> > +		"Ship"    (4) Ship mode.
> > +		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> `"Unknown" (0)` needs to be added here as well...

I see the issue, that userspace has no idea, which values are
supported by a specific device. I think it's better to follow
the same style, that is already used for e.g. charge_types, so
that the file reads something like this:

[On] Standby Ship

E.g. provide all supported values for the specific device and
mark the current value with square brackets.

P.S.: I've applied the unrelated cleanup patches from this series.

Greetings,

-- Sebastian

--kdgdlliqykyn4s7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpgG/cACgkQ2O7X88g7
+pr73A/+PsHJ0Etz+t3IxQ499nz8KmQnaAcNGdjp3rWYH+bCjx8beW27iwswgtUN
uzzVMRpUaK/jCqmEfReoZkUPmx+2dgo/wbWCIc2h/dhUOAB9UoW90pWndRsgrx32
u74XxS1zOKY/tFlHtuWKP9LsFvZS11z4Eeddb+xcUq2UEb6vv3uez6Hq3O3laYFH
IexF+nFzGE255pWiScRqE3ga2LpSmE9NgHVoki7PNUZ71FGi09hR4mF9EQ/fEYOV
U9enPZhiQm2Pjr47ytfe0ILxvi/5lhGiWjPpx9Fu5BvOmk8o030V254l3alKgN8b
m7TqRPVfCZfGCa2InHr4OfY6MyrrRzDRj/AdnYIx8aFYzqGJ/hKcirac5s4d6MYD
E5fmqOggROCKxqzmnOsJWqZdRLoyqXodTxbFI21XBPnbItEdVhex8vtXN9zcBMGQ
cJhZtYWuw8EiRj1swPXuCoc0J8fU9zN7EY17g9gLj5KBsp7umwBCT6j0+AN0rjgu
7mIwFwJGZWBzeIrPkpLn9/Cw5W79kabU+pakrGhWyb31s/kJMbdlPlLbaowfZNkr
RXUls9JfoZjqGCBaHRiEQVOtSkzH2H/s4AuqGCksCJt/WALprpJD8wwgLj3naZLw
w6fJzHUrPdUnmMTCtspjoSEKzSpw7B1ZjkEE102dCGuRYpK+T48=
=iii6
-----END PGP SIGNATURE-----

--kdgdlliqykyn4s7x--
