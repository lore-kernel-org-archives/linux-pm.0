From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 0/8] power: Remove deprecated
 create_singlethread_workqueue
Date: Tue, 16 Aug 2016 12:30:20 +0200
Message-ID: <20160816103020.l4hdrimmwj7h53yx@earth>
References: <cover.1471324749.git.bhaktipriya96@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="byggkx5buypql2l4"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38800 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136AbcHPKaZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 16 Aug 2016 06:30:25 -0400
Content-Disposition: inline
In-Reply-To: <cover.1471324749.git.bhaktipriya96@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>


--byggkx5buypql2l4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Bhaktipriya,

On Tue, Aug 16, 2016 at 10:51:30AM +0530, Bhaktipriya Shridhar wrote:
> This patch set removes the instances of deprecated
> create_singlethread_workqueues in drivers/power by making the
> appropriate conversions.

Sorry, I was unclear in my mail: I already queued the last revision,
there was no need to resend it. The tip regarding the subsystem
prefix and broken thread was for any new patchsets written by you.
Actually I have one more request now: If you send new versions of a
patchset, please add a changelog. E.g. for this one:

Changes since v1:
 * add "power:" prefix to PATCH0 subject

Anyways your patches are already in linux-next.

-- Sebastian

--byggkx5buypql2l4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXsus8AAoJENju1/PIO/qa2iIP/0uRL1nxnKvO4DSCtWYSWziq
4QcOJLw+AevEw78GbU0L63lYEd5bUAktQvLYHE92m8v6o0spmROE/Axt75X6oV79
ya7r9eDFh/3TFUSxEZANO9iRGBnvKIKABVFKFETa1GuiId0FUnmcqonRXxgRBT3t
KXGcSnvX3LhqusWYoBhyReKXLpRbwo3pBnAGbPmi2F0buiq11LtgkPH8No6sLXsd
nqbRfDRjG+valDqq4QWo1gNdkIq+WBEiggNQ2yf7KaGbjztfGhFOyhVpGzjUwi29
YCsTOQ9boZfSL07DqzYlxXNBUTTK24BzUq39g5O/7fNPJ66bhblX0MSQSQgmol06
7nFRSgejGGUfXRfp0Gt9SFKXZEvXBj42KdOOgXk7WNMFTocgFsAiuNMu09AGkJuQ
pr7GRWitMbyj6W1+Al/gPqeBVPjKX801xZXOwdjxknj47RNhN3HOJerz+Sv7bIeU
/8n+L0pu4T35RGVUfAIpnmmJcETKKZyZG3+Vsvj/D80ulRJQDMl7KgnyX4pVy0p5
7uVNTf1mpFHstxzQGo9NIa0ykDg4YbIXpsAFMlkLnA+KfJl2ZMe9qhnMbeSo0Mdt
31RKH9tG38t7IHXB41AbUG3yi76kym1tYtn0cyKwLHrW7j9Htb6ayIyTY4hs5FPD
eyR1/zR0V/es5yLlWlT0
=jjka
-----END PGP SIGNATURE-----

--byggkx5buypql2l4--
