From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH -next] ipaq_micro_battery: fix sparse non static symbol
 warning
Date: Mon, 28 Jul 2014 15:39:23 +0200
Message-ID: <20140728133923.GA15557@earth.universe>
References: <1406553261-29495-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:54369 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751423AbaG1Nj2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 28 Jul 2014 09:39:28 -0400
Content-Disposition: inline
In-Reply-To: <1406553261-29495-1-git-send-email-weiyj_lk@163.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: weiyj_lk@163.com
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-pm@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 28, 2014 at 09:14:21PM +0800, weiyj_lk@163.com wrote:
> Fixes the following sparse warnings:
>=20
> drivers/power/ipaq_micro_battery.c:278:24: warning:
>  symbol 'micro_batt_device_driver' was not declared. Should it be static?

thanks, pulled into battery-2.6.git:

http://git.infradead.org/battery-2.6.git/commit/5e37195f30cc31e6a1052cbc282=
254e127c1b8c7

-- Sebastian

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJT1lKLAAoJENju1/PIO/qaeqoP/2dZXghDHxFuDlfIdKFAKo1D
Bd1lreDeHCrulTSkBBoNj9nDeNOq4aH/OXSAHdFVQK8urEQhVLBStuQIAHvDx3VS
Ek0vL8kbjkz4iFSWjr+4+o/C3X/j3KvrL3OqVUUU+lCKoODoDiYNJIZcN813MgX4
+WGakfqn3X3vTVqWs+mOF4h83cSZLotkGjHHTnwZkbIXwtEIaVFzJLTBeVmdwKjj
O9wQCHHo1eVRRheI81HazTHxDKx5Ovz90FccmDt3km4bHCr0I5TNIviXd3m0eR3G
PoLxH+w7c4Zoc5TMljzPxO4JavlKeNxtzE6SGNxIwH05CQNdiTSPg1Zz17Mdgogi
rO6lR2v9gEjWAxcJcGwwuDWidCteFYwG1zCGiiNYr3oeFL+PLo4CVkJMvBG2fi4Z
EBirS8U9P5Zh42ziHge7pZN4ecF8kTaDarLvcJIWd9jH/IHLNL24I3ILiRZg+9mv
JcSJ2/zgqWzFmNY/fczje8clCjh82h6wLhnaVOHlUxsa3Ghdlcu5Rlql6m3YfFpd
BXo4T9fz6c15ZX6EpS8GdUNK3HOwfdfdjtq/PLbJOM8xtKZG+JerT5Aqhs5Ee17N
XSm5lhGS4ZNXZnXltlUnHLxHl84zzua2tnKPou8YXt6h3KpdN4Xjyd/SRtH+e7ff
cw6BYr4XHcGd1zYJJQfx
=OmQm
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
