From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: Add msm tsens thermal sensor driver
Date: Sat, 31 Jan 2015 14:23:03 -0400
Message-ID: <20150131182302.GB17425@developer.hsd1.ca.comcast.net>
References: <1422331786-19620-1-git-send-email-nrajan@codeaurora.org>
 <20150129224923.GE29837@developer.amazonguestwifi.org>
 <001801d03c2e$11271300$33753900$@codeaurora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:38551 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395AbbAaSXP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 31 Jan 2015 13:23:15 -0500
Content-Disposition: inline
In-Reply-To: <001801d03c2e$11271300$33753900$@codeaurora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Narendran Rajan <nrajan@codeaurora.com>
Cc: 'Narendran Rajan' <nrajan@codeaurora.org>, 'Zhang Rui' <rui.zhang@intel.com>, 'Linux ARM MSM' <linux-arm-msm@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Siddartha Mohanadoss' <smohanad@codeaurora.org>, 'Stephen Boyd' <sboyd@codeaurora.org>


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2015 at 05:42:53PM -0800, Narendran Rajan wrote:

<cut>

> >=20
> >=20
>=20
> Is not used when compiled with upstream kernel. =20
> Wanted to keep a common code base with a downstream kernel which has this
> support.=20

Please, keep in mind that vanilla kernels at kernel.org never maintains
compatibility to code outside the tree. You either remove the unused
code, or port the full feature, if that makes sense.

> But in my tests, yet to observe any noticeable advantage for this driver
> with HW trips.

I see. That seams to be the final common conclusion of developers that
write code for chips with such feature, once they port to the linux
kernel thermal framework. We may need a good use case to get that
ported.

> May be I need to run more tests, collect data points.=20
>=20

OK. Let me know your results or if you have any insights regarding HW
trip points.

> Let me revise my patch with this code removed completely.
>=20


sounds good.

BR,

Eduardo Valentin

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUzR1TAAoJEMLUO4d9pOJWD5IH/jAWvlX1m4MCDx+mTq1aCqg2
Ov2lkhvtxsFGeZvom/cTjajfSBJWMMDzfgFQurFOmqyJJwzFH28u0kudn0j8LTpb
4EYpKi9EjRsu3PHvxbkKZi90mv3xyk6ZiBul9sW4ZCcGpt9dRDejq7pQhqj8RLCR
rMHOk/WoccX2JxGnD9LaR9HobpuUo6PMiFO8ynPLkURVfMCWUZwbIWA5rrnHYGi0
Kn8pbsrsIC1M/rS6D5rG+JCg50Pa7SEQ8Pe1bZi1kHpcfsEkyDHxRcHa6YVEL9Cv
v+cVC3cAzzWTb4gHOg/4wMqQYFfL+uwLhFFRsjI/nT3/IC94hEqZtCBdcn/IajE=
=jZUT
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
