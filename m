From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v2] rework pm_ops pm_disk_modes foo
Date: Tue, 20 Mar 2007 10:46:42 +0100
Message-ID: <1174384002.3770.12.camel@johannes.berg>
References: <20070320015846.636692000@sipsolutions.net>
	<20070320084744.984025000@sipsolutions.net>
	<20070320093105.GD3922@elf.ucw.cz>
	<1174383407.3770.3.camel@johannes.berg>
	<20070320094352.GF3922@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1076379621=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070320094352.GF3922@elf.ucw.cz>
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
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Cliff Brake <cbrake@accelent.com>, Dirk Behme <dirk.behme@de.bosch.com>, linux-pm@lists.osdl.org, Nicolas Pitre <nico@cam.org>, Ben Dooks <ben@simtec.co.uk>, Patrick Mochel <mochelp@infinity.powertie.org>
List-Id: linux-pm@vger.kernel.org


--===============1076379621==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-wCFW7V5LxZpau4kLtsxa"


--=-wCFW7V5LxZpau4kLtsxa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

> I guess we'll have more such users in future.

Right, but then the question remains whether multiple disk-shutdown
modes make sense. I doubt it.

> i did not look _that_ closely. As long as platform is still default on
> acpi systems, we are okay.

It is. And there are no other users of pm_ops that can do this.

johannes

--=-wCFW7V5LxZpau4kLtsxa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF/62C/ETPhpq3jKURAnj5AKCwAaNIr9SYZxvBue5Bj0yHotkXsQCfVMkq
GjyoZc0wwELQAFsT2s7XeBQ=
=wQIy
-----END PGP SIGNATURE-----

--=-wCFW7V5LxZpau4kLtsxa--


--===============1076379621==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1076379621==--
