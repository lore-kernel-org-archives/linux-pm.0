From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC][PATCH 0/3] swsusp: Do not use page flags (was:
	Re:	Remove page flags for software suspend)
Date: Thu, 08 Mar 2007 23:43:35 +0100
Message-ID: <1173393815.3831.29.camel@johannes.berg>
References: <Pine.LNX.4.64.0702160212150.21862@schroedinger.engr.sgi.com>
	<200703082305.43513.rjw@sisk.pl>
	<1173391817.3831.4.camel@johannes.berg>
	<200703082333.06679.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1025075356=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200703082333.06679.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Pavel Machek <pavel@ucw.cz>, linux-mm@kvack.org, Christoph Lameter <clameter@engr.sgi.com>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============1025075356==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/8cnBTtR+08Bw6Pvdksj"


--=-/8cnBTtR+08Bw6Pvdksj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-03-08 at 23:33 +0100, Rafael J. Wysocki wrote:

> > Unfortunately I won't be able to actually try this on hardware until th=
e
> > 20th or so.
>=20
> OK, it's not an urgent thing. ;-)

True :)

> Well, I don't think so.  If I understand the definition of system_state
> correctly, it is initially equal to SYSTEM_BOOTING.  Then, it's changed t=
o
> SYSTEM_RUNNING in init/main.c after the bootmem has been freed.

No, I think you're confusing bootmem with initmem right now. If you
actually look at the code then free_all_bootmem is called as part of
mem_init() on powerpc, which is called from start_kernel() a long time
before initcalls are done and system state is set.

Put it this way. By the time initcalls are done, I can no longer use
bootmem. I tested this and it panics. But if you look at the code in
init/main.c, system_state is only changed after initcalls are done.

> Anyway, the patch works on x86_64. :-)

Yeah but it worked before too ;)

johannes

--=-/8cnBTtR+08Bw6Pvdksj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF8JGX/ETPhpq3jKURAi7yAJ9zCFwxPEmvfscfLOVWko04opELlQCgtXvf
d716NRvfAIvgdaSUMRlqFIU=
=Ozyl
-----END PGP SIGNATURE-----

--=-/8cnBTtR+08Bw6Pvdksj--


--===============1025075356==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1025075356==--
