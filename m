From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2 4/7] thermal: introduce the Power Allocator governor
Date: Thu, 26 Feb 2015 16:36:16 -0400
Message-ID: <20150226203615.GB25495@developer.amazonguestwifi.org>
References: <1424977233-15965-1-git-send-email-javi.merino@arm.com>
 <1424977233-15965-5-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34169 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754213AbbBZVpH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Feb 2015 16:45:07 -0500
Content-Disposition: inline
In-Reply-To: <1424977233-15965-5-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, punit.agrawal@arm.com, broonie@kernel.org, tixy@linaro.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Javi,

Replying in v2.

On Thu, Feb 26, 2015 at 07:00:30PM +0000, Javi Merino wrote:

<big cut>

> +
> +/**
> + * divvy_up_power() - divvy the allocated power between the actors
> + * @req_power:	each actor's requested power
> + * @max_power:	each actor's maximum available power
> + * @num_actors:	size of the @req_power, @max_power and @granted_power's array
> + * @total_req_power: sum of @req_power
> + * @power_range:	total allocated power
> + * @granted_power:	output array: each actor's granted power
> + *
> + * This function divides the total allocated power (@power_range)
> + * fairly between the actors.  It first tries to give each actor a
> + * share of the @power_range according to how much power it requested
> + * compared to the rest of the actors.  For example, if only one actor
> + * requests power, then it receives all the @power_range.  If
> + * three actors each requests 1mW, each receives a third of the
> + * @power_range.
> + *
> + * If any actor received more than their maximum power, then that
> + * surplus is re-divvied among the actors based on how far they are
> + * from their respective maximums.
> + *
> + * Granted power for each actor is written to @granted_power, which
> + * should've been allocated by the calling function.
> + */
> +static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
> +			   u32 total_req_power, u32 power_range,
> +			   u32 *granted_power)
> +{
> +	u32 extra_power, capped_extra_power, extra_actor_power[num_actors];

Just now I noticed this variable-size array. I know the number of actors
are constant, and in average it should be less than 10 in magnitude, but
I don't believe variable-sized arrays are a good practice in kernel.

Even though I don't see this one as a treat, can we avoid it?
Sparse error:

drivers/thermal/power_allocator.c:172:64: error: bad constant expression


BR,

Eduardo Valentin

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU74O1AAoJEMLUO4d9pOJWu/IH/2VW7ooICHyVbPq02hu5WB8O
if220Qm+A0wAsnvhZiDfp+qoVYtXH0cT/R7nth6PAJtlOPr8KKCoN9WlYMBSvBh2
QznzJc/c/iDohsrwCj/sQOWqI+/prSzbR3vh4ZYFTBFZESYb02V1JHVDp45t3coU
4E4qSvxQlodjJ6SZgyzr6c6edhf00uLz4JKFB9UJkUTKA1G5JDGbHoTDgaI5a4qv
tZIbhEhj6geIjQePr85qscF9FJ4/stRx4UsvQUROFGlIfnxn9JzwtvXz1JF50wnX
lW89LZ2KaeGyLiJxXBstAoFIrl2/KDiVWHFth33A4GD0MbhHoQZAjldxsF7Ktxo=
=m0K/
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
