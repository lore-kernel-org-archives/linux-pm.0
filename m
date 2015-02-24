From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v1 4/7] thermal: introduce the Power Allocator governor
Date: Tue, 24 Feb 2015 14:21:26 -0400
Message-ID: <20150224182124.GB3448@developer.amazonguestwifi.org>
References: <1422464438-16761-1-git-send-email-javi.merino@arm.com>
 <1422464438-16761-5-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:42926 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563AbbBXSUy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Feb 2015 13:20:54 -0500
Content-Disposition: inline
In-Reply-To: <1422464438-16761-5-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, punit.agrawal@arm.com, broonie@kernel.org, Zhang Rui <rui.zhang@intel.com>


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Javi,

One minor clarification as follows:

On Wed, Jan 28, 2015 at 05:00:35PM +0000, Javi Merino wrote:

<big cut>

> +
> +k_d
> +---
> +
> +`k_d` configures the PID loop's derivative term constant.  It's
> +recommended to leave it as the default: 0.
> +

I know we are considering K_d = 0. However, ...

<yet another big cut>

> +	/*
> +	 * Calculate the derivative term
> +	 *
> +	 * We do err - prev_err, so with a positive k_d, a decreasing
> +	 * error (i.e. driving closer to the line) results in less
> +	 * power being applied, slowing down the controller)
> +	 */
> +	d = mul_frac(tz->tzp->k_d, err - params->prev_err);


... Shouldn't the above d component consider the rate of changes over time of the error?

I would expect you should do:
d = k_d * (dE / dt)

or

d = K_d * ((err - params->prev_err) / sampling_period)

in plain C:

+	d = mul_frac(tz->tzp->k_d, err - params->prev_err);
+	d /= tz->passive_polling; /* might require fixed point division */

---
Eduardo Valentin

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU7MEcAAoJEMLUO4d9pOJWxKwIAIGPXQ7RJebANvZ3swQ4Q5Ws
xXCaB3kdou0oOAOccRokSTbW4eLgIpS3ipUle0eaK7hLSfDAi9z2fAVvR4u0qdPk
PzNk2qz2ugY9Mg0HmkwDjeSzXEczC1aeckwrjAKXZWe5xisgwEkib6PzCI8FAd4p
Ep5ZNhQ8RKnpH1ry49RRSsksKxbkthghPTgHNiOw/KAnxM+kSWOv2IRW8x2aTNBJ
6RIax7FJVCDg1jYEFoVjUVZRKiyb7t9UPVOfhk/R9C1vzQfwRP7SdmE/WF8BWyZE
haKyeDp3laCi/OucxOWwdmixyVawR0f9G/+8JcqiXxczxB94rhii28LZAEUXERo=
=v6Xd
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
