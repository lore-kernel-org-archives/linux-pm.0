From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Fri, 13 Apr 2007 23:18:05 +0200
Message-ID: <1176499086.7052.124.camel@johannes.berg>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704131347.30001.rjw@sisk.pl>
	<1176470819.7052.108.camel@johannes.berg>
	<200704132243.59618.rjw@sisk.pl> <20070413205837.GG28264@elf.ucw.cz>
	<1176498368.7052.117.camel@johannes.berg>
	<20070413211232.GJ28264@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0090621921=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070413211232.GJ28264@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============0090621921==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-B0CUdbgbIhAvnJ9WN7gC"


--=-B0CUdbgbIhAvnJ9WN7gC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-13 at 23:12 +0200, Pavel Machek wrote:


> > Whoops, I had that in an earlier version, it's not supposed to be calle=
d
> > for (u)swsusp because pm_ops involvement there is a hack anyway. I'll
> > fix the description.
>=20
> But (u)swsusp needs to shut down the devices, and it does both suspend
> and powerdown, too...?

Yes, but the special S4 state is just hacked onto pm_ops, nothing but
ACPI S4 will ever sanely use pm_ops. If I'd invented pm_ops I'd made
pm_ops solely for suspend to ram/standby/... and added a *separate* hook
for pm_disk_mode and S4 because logically that really doesn't belong to
pm_ops which does almost exclusively things for suspend to ram/standby.

johannes

--=-B0CUdbgbIhAvnJ9WN7gC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGH/ON/ETPhpq3jKURAkWlAJ9U3XtcdXmdMuDpIQ1H5XXMg1eijwCdE+Nm
rqYyqsVZQ5Qbv9ifaSwDIKo=
=m0gx
-----END PGP SIGNATURE-----

--=-B0CUdbgbIhAvnJ9WN7gC--


--===============0090621921==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0090621921==--
