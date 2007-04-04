From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Power Mangement Interfaces
Date: Wed, 04 Apr 2007 18:15:59 +0200
Message-ID: <1175703359.7388.10.camel@johannes.berg>
References: <20070330235759.GC4252@cosmic.amd.com>
	<1175300283.23438.38.camel@johannes.berg>
	<200703310957.49409.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0999208237=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703310957.49409.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============0999208237==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-uolrEom9rmKqv2v3S9hY"


--=-uolrEom9rmKqv2v3S9hY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-03-31 at 09:57 -0700, David Brownell wrote:

> To the contrary, it seems enough to just expose a boolean flag saying
> whether a given device should try to be a wakeup event source.  If
> the hardware won't allow that in the target system state, so be it;
> there's no way software can change that.

Right. So that's the "wakeup" file for a given device.

How would I go about representing the lid as a device?  It's an honest
question, I'd actually like to do and replace the /proc/pmu/options file
it but don't know where I should put it etc.

johannes

--=-uolrEom9rmKqv2v3S9hY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGE889/ETPhpq3jKURAordAJ4piQxz1PWgXbhaT+uA3njGltIV+gCfY27U
8dyflAalKX/giyks4qvKn5Q=
=nEeN
-----END PGP SIGNATURE-----

--=-uolrEom9rmKqv2v3S9hY--


--===============0999208237==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0999208237==--
