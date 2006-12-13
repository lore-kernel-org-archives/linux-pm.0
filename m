From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [linux-pm] [RFC 1/3] support powermac G5 CPU hotplug
Date: Wed, 13 Dec 2006 14:20:08 +0100
Message-ID: <1166016008.7273.11.camel@johannes.berg>
References: <20061211230208.526233000@sipsolutions.net> >
	<20061211230754.380263000@sipsolutions.net>
	<20061212130916.GB5190@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1581166660=="
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20061212130916.GB5190@ucw.cz>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Mime-version: 1.0
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Pavel Machek <pavel@suse.cz>
Cc: linuxppc-dev@ozlabs.org, Torrance <torrance123@gmail.com>, Michael Buesch <mb@bu3sch.de>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--===============1581166660==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CQIcQyxgpP9oY12t8ik3"


--=-CQIcQyxgpP9oY12t8ik3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-12-12 at 13:09 +0000, Pavel Machek wrote:

> ?? Context for downing cpu should better be well-defined. Just do this
> in cpu_die if it is really required.

Hmm. Just tried, but that doesn't help either!

I'm confused. Really need to check where that value comes from. It looks
as though we disable the CPU inside an interrupt but I can't see how
that should happen during resume code. Or maybe preempt count is
initialised non-zero during boot or something.. Digging

johannes

--=-CQIcQyxgpP9oY12t8ik3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFf/4H/ETPhpq3jKURAlZVAKCJSYjJ8MHRKZ23U2Ekjf5JlFWEawCfXjFH
nHtIFj/qnlWOr2FzbemoDHc=
=jHnT
-----END PGP SIGNATURE-----

--=-CQIcQyxgpP9oY12t8ik3--


--===============1581166660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
--===============1581166660==--
