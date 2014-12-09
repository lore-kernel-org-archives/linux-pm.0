From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] sound / PM: Replace CONFIG_PM_RUNTIME with
	CONFIG_PM
Date: Tue, 9 Dec 2014 16:15:20 +0000
Message-ID: <20141209161520.GK1934@sirena.org.uk>
References: <2064254.7lXiTpmK64@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4223912251545695587=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <2064254.7lXiTpmK64@vostro.rjw.lan>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>, Timur Tabi <timur@tabi.org>, Linux PM list <linux-pm@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, Ben Dooks <ben-linux@fluff.org>
List-Id: linux-pm@vger.kernel.org


--===============4223912251545695587==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vk/v8fjDPiDepTtA"
Content-Disposition: inline


--vk/v8fjDPiDepTtA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 06, 2014 at 03:46:27AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
> selected) PM_RUNTIME is always set if PM is set, so #ifdef blocks
> depending on CONFIG_PM_RUNTIME may now be changed to depend on
> CONFIG_PM.

Acked-by: Mark Brown <broonie@kernel.org>

--vk/v8fjDPiDepTtA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUhyAXAAoJECTWi3JdVIfQ+gAH/RtO167WNmJph1mXUpYcElXu
I4EZb20uXYY4zTHiKzXAYlq/9zJM+IkpW7+3MSe00lA8hQxD03VzeiocmVamMaJX
PWXGu6ifGJU0sMv+Zvxejxjd2dlhhr9Rd8z85luIKi/70a+3i6cJIUtit0DxSWD/
ZSPoPJU/qrsFNVLzUy7iXt0ryYBdEUsnTQCCmekRWPQzkTcfQA1OpCH6dpaS2Pic
yXhZ4fJwl4oQSOVP/XoRPp7SyBgCskwk/dJnz2WRcHqq2tPQkjsE3XSzIBo957NO
DCXIvFBfM/YvSJQQHGkU6DGhr7tVJYxFxfea0lmtHxk8wfyA3q7agqUxNyu6WaU=
=wspE
-----END PGP SIGNATURE-----

--vk/v8fjDPiDepTtA--

--===============4223912251545695587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4223912251545695587==--
