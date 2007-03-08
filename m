From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC][PATCH 0/3] swsusp: Do not use page flags (was:
	Re:	Remove page flags for software suspend)
Date: Fri, 09 Mar 2007 00:21:34 +0100
Message-ID: <1173396094.3831.42.camel@johannes.berg>
References: <Pine.LNX.4.64.0702160212150.21862@schroedinger.engr.sgi.com>
	<200703041450.02178.rjw@sisk.pl>
	<1173315625.3546.32.camel@johannes.berg>
	<200703082305.43513.rjw@sisk.pl>  <20070308231512.GB1977@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0389141529=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070308231512.GB1977@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org, Christoph Lameter <clameter@engr.sgi.com>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============0389141529==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-0+7od6/IuhrtZwpZSSog"


--=-0+7od6/IuhrtZwpZSSog
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-03-09 at 00:15 +0100, Pavel Machek wrote:

> That's a no-no. ATOMIC alocations can fail, and no, WARN_ON is not
> enough. It is not a bug, they just fail.

But like I said in my post, there's no way we can disable suspend to
disk when they do, right now anyway. Also, this can't be called any
later than a late initcall or such since it's __init, and thus there
shouldn't be memory pressure yet that would cause this to fail.

In any case, I'd be much happier with having a "disable suspend"
variable so we could print a big warning and set that flag.

johannes

--=-0+7od6/IuhrtZwpZSSog
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF8Jp+/ETPhpq3jKURAqVJAJ4qbLd+yOSv8ZeEegAJXIzydjCNdwCgrTpL
f5df6oWJNCS9ClQeJ5R+Zm4=
=hmli
-----END PGP SIGNATURE-----

--=-0+7od6/IuhrtZwpZSSog--


--===============0389141529==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0389141529==--
