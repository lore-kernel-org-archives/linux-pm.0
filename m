From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/5 v2][RFC] Encryption and authentication for hibernate
 snapshot image
Date: Sun, 6 Jan 2019 19:10:27 +0100
Message-ID: <20190106181026.GA15256@amd>
References: <20190103143227.9138-1-jlee@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190103143227.9138-1-jlee@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patchset is the implementation of encryption and authentication
> for hibernate snapshot image. The image will be encrypted by AES and
> authenticated by HMAC.

Ok, so you encrypt.=20

> The hibernate function can be used to snapshot memory pages to an image,
> then kernel restores the image to memory space in a appropriate time.
> There have secrets in snapshot image and cracker may modifies it for
> hacking system. Encryption and authentication of snapshot image can prote=
ct
> the system.
>=20
> Hibernate function requests the master key through key retention service.
> The snapshot master key can be a trusted key or a user defined key. The
> name of snapshot master key is fixed to "swsusp-kmk". User should loads
> swsusp-kmk to kernel by keyctl tool before the hibernation resume.
> e.g. The swsusp-kmk must be loaded before systemd-hibernate-resume

But if userspace has a key, encryption is useless against root.

> The TPM trusted key type is preferred to be the master key. But user
> defined key can also be used for testing or when the platform doesn't
> have TPM. User must be aware that the security of user key relies on
> user space. If the root account be compromised, then the user key will
> easy to be grabbed.

In the TPM case, does userland have access to the key?=20

Please explain your security goals.

								Pavel


> Lee, Chun-Yi (5):
>   PM / hibernate: Create snapshot keys handler
>   PM / hibernate: Generate and verify signature for snapshot image
>   PM / hibernate: Encrypt snapshot image
>   PM / hibernate: Erase the snapshot master key in snapshot pages
>   PM / hibernate: An option to request that snapshot image must be
>     authenticated
>=20
>  Documentation/admin-guide/kernel-parameters.txt |   6 +
>  include/linux/kernel.h                          |   3 +-
>  kernel/panic.c                                  |   1 +
>  kernel/power/Kconfig                            |  25 +
>  kernel/power/Makefile                           |   1 +
>  kernel/power/hibernate.c                        |  59 ++-
>  kernel/power/power.h                            |  59 +++
>  kernel/power/snapshot.c                         | 576 ++++++++++++++++++=
+++++-
>  kernel/power/snapshot_key.c                     | 312 +++++++++++++
>  kernel/power/swap.c                             |   6 +
>  kernel/power/user.c                             |  12 +
>  11 files changed, 1042 insertions(+), 18 deletions(-)
>  create mode 100644 kernel/power/snapshot_key.c
>=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwyRJIACgkQMOfwapXb+vKbGwCgqdFS+SAxvg8NHhZw8KSTwtEn
xgMAn1tZyKl+ZiX2ewpAPAipm+wK6brO
=lr4D
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
