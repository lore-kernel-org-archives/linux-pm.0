From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [linux-pm] [RFC 1/3] support powermac G5 CPU hotplug
Date: Tue, 12 Dec 2006 14:47:17 +0100
Message-ID: <1165931237.22338.36.camel@johannes.berg>
References: <20061211230208.526233000@sipsolutions.net> >
	<20061211230754.380263000@sipsolutions.net>
	<20061212130916.GB5190@ucw.cz>
	<1165929483.22338.18.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2067593737=="
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <1165929483.22338.18.camel@johannes.berg>
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


--===============2067593737==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gEB/kjIQ7n0vufvkDn/1"


--=-gEB/kjIQ7n0vufvkDn/1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-12-12 at 14:18 +0100, Johannes Berg wrote:

> > ?? Context for downing cpu should better be well-defined. Just do this
> > in cpu_die if it is really required.
>=20
> It is actually required but I'm not exactly sure why. When I don't do
> this, I end up with preempt_count() 0x100000 (IIRC, notes not here at
                                      ^^^^^^^^ typo, should be 0x10000
> the moment).
>=20
> I think this is because the suspend code has interrupts disabled already
> when downing the CPUs.

Also, the /sys/devices/system/cpu/cpuN/online thing doesn't disable
interrupts before downing the CPU thus that works without this.

johannes

--=-gEB/kjIQ7n0vufvkDn/1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFfrLl/ETPhpq3jKURArY8AJ9ToMdMFNbR6aBy7lI47PgXWdcs3gCfWTKw
HiknoG4K/YKcTL8PHMvrHvg=
=hrRV
-----END PGP SIGNATURE-----

--=-gEB/kjIQ7n0vufvkDn/1--


--===============2067593737==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
--===============2067593737==--
