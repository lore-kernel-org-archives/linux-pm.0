From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/8] Remove deprecated workqueue interface users
Date: Tue, 16 Aug 2016 00:56:47 +0200
Message-ID: <20160815225647.q2pfzm75ia5nypai@earth>
References: <cover.1471104124.git.bhaktipriya96@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zh2gtn2q4wbn6tss"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59104 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932201AbcHOW4y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 15 Aug 2016 18:56:54 -0400
Content-Disposition: inline
In-Reply-To: <cover.1471104124.git.bhaktipriya96@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>


--zh2gtn2q4wbn6tss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sat, Aug 13, 2016 at 09:41:21PM +0530, Bhaktipriya Shridhar wrote:
> This patch set removes the instances of deprecated
> create_singlethread_workqueues in drivers/power by making the appropriate
> conversions.

Thanks, all queued into power-supply's for-next branch.

-- Sebastian

--zh2gtn2q4wbn6tss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXskisAAoJENju1/PIO/qaSpUP+gMXPk/TLoC5EbOnG1/pRkWk
sH93le27pYPj8TqMx38a9oku5MhoRSMg51pyXXW5EtxJlCCjJHLvur8K3hiEr53H
4pmzfIGK+mLqrHrY7+XAydOAG4UB3ShWOIfLRv6o7ny0oY8MHexHcvL8Vrsi1s1I
UDMMfwjnfe2pYSYl+oEru2ndYAACuB+uhtGayiD1Qe4cWZA1Eog/Syt78tjU7xZk
sH+Pxd5JvyKKEPWfpSFgjiavrv4EFB5HCl2s4n/jUQUODgx6DHqIUlIez9ISxQkP
nSY3XpR2BOA+ziXy6qUUNjWnXrnOlqbTa60mCNncUTowtS2CUuxB/MKD/mdwu8bk
cJ1riFYSSCIwnLRra4iH92SWzwxdzR6w1+4+MmhNwGIXrYuuqKuljgK/nTQDcFTS
lE18terzF653VzYT+ZtijOV7YkLi+3bUMKqcupAk4kWNVNlf2mpfEPR5k0xSYA6j
N5LCTBV2t2xduyegd4hxbN5rGdoaaHZrOdjjr0ki8ljdk4+771EDP0T6ETBcsGWi
vaid/6rhLigpT0QJDfc3tTFu900evrh7htC3z6W7McGgZZl/SPkZ/2qp0oWSnWy5
FCwXaMtdt3RjInshoyN41Ql1zqkaf2c+7uzdFSz4w33FjQpryQSRWWs2euy+vq1o
DX7CBD+7Tk9wg/v7NmP9
=O4MW
-----END PGP SIGNATURE-----

--zh2gtn2q4wbn6tss--
