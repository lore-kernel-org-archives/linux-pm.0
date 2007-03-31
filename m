From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Power Mangement Interfaces
Date: Sat, 31 Mar 2007 02:18:03 +0200
Message-ID: <1175300283.23438.38.camel@johannes.berg>
References: <20070330235759.GC4252@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1190542818=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070330235759.GC4252@cosmic.amd.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.osdl.org, devel@laptop.org
List-Id: linux-pm@vger.kernel.org


--===============1190542818==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Cgnjn1SY5pCPpk9OwP10"


--=-Cgnjn1SY5pCPpk9OwP10
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-03-30 at 17:57 -0600, Jordan Crouse wrote:

> I am now turning my attention to handling wakeup events - in particular,
> events that we can set at run-time.  My thoughts on the matter are=20
> detailed here:
>=20
> http://wiki.laptop.org/go/Power_Management_Interface

Interesting. I thought about something like that a few days ago and it
was pretty much identical to what you're saying there. Except I didn't
write it down ;)

A few comments:

I think the sources file isn't really useful, a
  grep -l 1 /sys/power/wakeup/*
should do.

About different possible states: I think each of those can have
different possible wakeup sources, ACPI can afaik go to S4 and still be
able to configure the wakeup sources. So I suppose this really needs to
be something like /sys/power/wakeup/<state>/<event> then where <state>
is one of (currently) "mem", "disk" and "standby". And then change the
interface of pm_register_wakeup_source to include the state.

Also, I'm not sure I like the interface with the name of the wakeup
event set by the platform driver. That will probably lead to
inconsistencies, a centrally maintained file with items could be nicer.

About test mode: there is such a thing for suspend to disk. In fact, if
you just want to test driver suspend you could use that. See
the /sys/power/disk file.

johannes

--=-Cgnjn1SY5pCPpk9OwP10
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGDai7/ETPhpq3jKURAotlAJ9QvDuTUQI9DspU990/2+AssEu+wQCfURes
tcxxFUFlFiCRWtDPCg7rxy4=
=iiZJ
-----END PGP SIGNATURE-----

--=-Cgnjn1SY5pCPpk9OwP10--


--===============1190542818==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1190542818==--
