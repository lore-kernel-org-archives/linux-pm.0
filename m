From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/4] Avoid duplicate registering of ACPI and native
 power-supplies
Date: Mon, 20 Mar 2017 02:33:05 +0100
Message-ID: <20170320013305.v4mof5qoie3w7xdb@earth>
References: <20170316161601.32267-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nyqdhz3bosnczvpg"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170316161601.32267-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--nyqdhz3bosnczvpg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 16, 2017 at 05:15:57PM +0100, Hans de Goede wrote:
> The last 2 patches of this series depend on the first 2, as such it might
> be better to merge all 4 through the acpi tree if Sebastius is ok with
> that.
>=20
> Otherwise these patches are pretty self-explanatory.

I'm fine with this going through acpi. I wonder if acpi has a method
to avoid loading the generic drivers in the first place, though. This
solution is not very nice.

-- Sebastian

--nyqdhz3bosnczvpg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljPMVEACgkQ2O7X88g7
+pp4Yg//Z17EhrjKV6FJIWDA0v6lyz46L8+IE0xWidA3FXGHtAuxz0npT+0O8KxD
Jqi1VEipZrwp5aJaDwwxCJGA5kb+ubLsmjaeKjMHmyVn8+kKaEbd02nJpkGCEKJw
w/3j+ce4nRysOtWjPM1oQBYWMI357XEbOyAxQjLA91R//FZF05PV2mw+KWr8145F
iN7PYW9o7lh4RhPNTeV7wA8csqThGNZ1MSRd4lQ6WEckE0VRO116lg+uwjmr5uvh
0V8iu7jndrgC1V6xv0ueqzfYxxoGJD0Fh/jgaJhycHiMueTDPMmIPLJW4oNMrXZG
8CLjHwPfWel311lzxLo9zeQ8nuo/jKNk5Nrsr1rmXqzvOJgyH0l+461RgIpeovvY
VrZPewslZPF5hGRAQ+kHbGEb37SfQSATFlTZJlsNVdGBakniIfo7+hQTIGV+VeSG
SkUZjMrtg8pdccSwRTGIvyZ0rRzpdz9yfpDQro6rggA4l/WBxvzf6jXLR2bI1WZG
FqMsX27LqSEifvkFZDY2hAq07lF9zOhvvlhRg7PGDBYWdo33/FYNyHjXbhHmZnr8
cIxDjDuStczeEz6kAoSzbjKtEmt6gKCVkgzJx/5FIGDoQiQ0hgnc2k+TwExMnDgN
UBPP0AiEboaRgnl3kgpQ7Wj5Rlxnnj+v8mkqerUFvKcTJ8NSkPA=
=HJKj
-----END PGP SIGNATURE-----

--nyqdhz3bosnczvpg--
