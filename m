From: Johannes Berg <johannes@sipsolutions.net>
Subject: RE: Power event notification patch
Date: Fri, 06 Jul 2007 12:46:54 +0200
Message-ID: <1183718814.3818.101.camel@johannes.berg>
References: <67670A5CEA5C374B8E7B16D7DC55F95301247460@bgsmsx413.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1049966611739116706=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <67670A5CEA5C374B8E7B16D7DC55F95301247460@bgsmsx413.gar.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "V, Sankara Narayanan" <sankara.narayanan.v@intel.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============1049966611739116706==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-H7RDK5we4g+8sby0shbp"


--=-H7RDK5we4g+8sby0shbp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-07-05 at 19:03 +0530, V, Sankara Narayanan wrote:
> Yeah! If it is a pseudo-embedded device, it can take care of because the
> application ecosystem is already established there. It won't be a
> generic thing for all embedded devices. Of course, every application
> receives the event and it can act on the way it wants (I did not
> understand step 1/2/3...).=20

By "steps 1/2/3" I was just trying to say that each application probably
has multiple steps that should be guaranteed to run before it can
rightfully say it has saved all state for the event that the system
never wakes up or whatever else it needs. But if you have more
applications the chances of it running successfully diminish quickly.

johannes

--=-H7RDK5we4g+8sby0shbp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGjh2e/ETPhpq3jKURAknpAKCUzpIpjreb9O1bASd2ULv7Q5IMBQCgi2AI
HPPnXrOhkFn0vRhs2sS2D24=
=sdm4
-----END PGP SIGNATURE-----

--=-H7RDK5we4g+8sby0shbp--


--===============1049966611739116706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1049966611739116706==--
