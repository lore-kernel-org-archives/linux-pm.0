From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 2/3] PM / mfd: intel-lpss: Push system sleep callbacks
 to late/early stages
Date: Thu, 5 Oct 2017 13:00:48 +0200
Message-ID: <20171005110048.dtonwwlvceslif6i@ninjato>
References: <3023226.l5IfJK6GIc@aspire.rjw.lan>
 <3958866.l2qnKDbinI@aspire.rjw.lan>
 <65494652.vEfz4tCBDb@aspire.rjw.lan>
 <4332008.kXBLY0K23i@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="di6u3ftofhd3ttp2"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4332008.kXBLY0K23i@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, Ulf Hansson <ulf.hansson@linaro.org>, Rajat Jain <rajatja@google.com>
List-Id: linux-pm@vger.kernel.org


--di6u3ftofhd3ttp2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2017 at 01:20:35AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> Push the system suspend/resume callbacks of intel-lpss to the late
> suspend/early resume stages to allow child device callbacks to be
> pushed to the late/early stages of suspend/resume too, so as to
> make it possible to avoid resuming the children if they are runtime-
> suspended during system suspend going forward.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Tested-by: Johannes Stezenbach <js@sig21.net>
> Tested-by: Rajat Jain <rajatja@google.com>

Applied to for-next, thanks!


--di6u3ftofhd3ttp2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnWEOAACgkQFA3kzBSg
KbYedw/+KDWraQ/vwJtD8aMwGETVA9f+9Ei3f5rCg+NOROpy/PTvhdbzvQJMduzN
xEVk4Y75mDjn3o5NsiqdVudcyv1thRn2WaG6zW+L6NtXggN1HgosH/YQeDOydUYk
SHC53un7z6MzQ72/ZsHjngGTM5cn6BE5+hvr3NS0GP+BA6k2UT5WXHbmBjmc1rmr
l9ICkQy7Eg1zhfnTOhSpyK3F3GHzi1CH6gjH6rvul47QY+dYGt5JJxHcEOMRzCc1
WmKMK6wj0/oXttCq6rciw8+6gOxOQxVQq8TPPGfQQxgOjN7bq4gtAPXhK1EEGHTP
U1TCGjLzWbk44iuYxtnDkhRI+yTylEQ1tYBVX24v0RGOlKfekyW31pWCuqwVrSUS
d2I21Gai14aeJ71UjH4OKK92nLGVdA8lSiLMJ3PWYdrZIdv7lC1vht3Q1tSsx9CR
o3Jh/scv02ApXyFkhf+IsenpXo1Ns19SvS5mC8iR9S3BY/xVJUjtWbtINMvVrTIr
6qPoD/Gg5UdqJIiT5mzcpxk2lwwPIjEGMDyPjB6DLoa2GUyLFmy0zPr/NOlRNGDX
QK3/KdEipGX0VdpUnn3J+dl50LY949wdzD1PmcugujZkX5s9gQZ5tgObchEBtA/i
7ttU46jWg75ZJ96v/vnCUc4yNmFJhkKWMPMBMfaRpTI+8Z7hN1E=
=/xmG
-----END PGP SIGNATURE-----

--di6u3ftofhd3ttp2--
