From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Wed, 18 Apr 2012 23:10:02 +0600
Message-ID: <20120418171002.GU11484@belkar.wrar.name>
References: <20120418152455.GT11484@belkar.wrar.name>
	<Pine.LNX.4.44L0.1204181228380.1149-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9003435557226523128=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1204181228380.1149-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: jrnieder@gmail.com, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org


--===============9003435557226523128==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ptMYGWplstB9CqWP"
Content-Disposition: inline


--ptMYGWplstB9CqWP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2012 at 12:41:10PM -0400, Alan Stern wrote:
> Here's the situation.  When the script unbinds ehci-hcd,=20
> pci_device_remove() sets the current state to PCI_UNKNOWN.  The patch=20
> to hcd-pci.c does the same thing before the suspend_noirq phase begins,=
=20
> i.e., before pci_prepare_to_sleep() is called.
>=20
> In pci_raw_set_power_state(), there's a "switch" statement that depends
> on dev->current_state.  If the current state is PCI_D0 then the new
> state in pmcsr is set to PCI_D3; if the current state is PCI_UNKNOWN
> then the state in pmcsr is left unchanged.  After that, the value in
> pmcsr is written to the controller.
>=20
> This means that when ehci-hcd is unbound or the patch is installed, the
> controller stays in D0.  That's why we see those "Refused to change
> power state" messages, since D0 is not what the target state was
> supposed to be.  When ehci-hcd remains bound and the patch isn't
> installed, the controller is put into D3.
>=20
> And then finally, the computer crashes during the final stage of=20
> suspend if either controller is in D3.  Clearly this is a bug in the=20
> firmware, not in the kernel.
>=20
> Have you guys checked to see if any BIOS updates are available?
I've just updated to 219 and it still hangs.

--=20
WBR, wRAR

--ptMYGWplstB9CqWP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPjvVqAAoJEDNi9wMaSZLhnXYP/1AX/0fKYjLGZHcopQrnx9Qm
XSPikarKEuNDT4aI22ToDtN1+RG5Ydv9bxRhex62bviDFh1VDYuVQdbtoNMMuMKM
jq7q9vh4aN7HBIAG4EuGeVLZyEQ5gK5sfnKCCxWGpPtWKfADB6qfahlSOWfM9cVw
p8RWnfe92trPHFkX7FyKPgfqMP/fBoaHdSIx0GHjwWVZ3XuNiiUlk2i5ut+9YJKC
gvDuaFFSNfNoglLz4T3uazEoiemjEONX9+s+vWh7GmoZXjMrXgsrUgER6pS1JfGc
54D6Lj0VR/SmPw8vzflXJr5UnYEho2Ry4qKPyTtuvvrkaHZstLxkqEpvkmdvFDN5
dQPcSPY7c1COOCzc0cUTyQmKJCAa8gQXY9/+yeQxLphWc8/lZf7T2/P9ABjcVxYm
BkkR2IdyCmsq4jth7w6ozFcMTad6jvjj1HZ7Mg582osDsi1/3QCevtT6XES9bacs
SFGoW3iQ0MJ1VSIzY/umec7IEqVZf2syGMceRrio0sKqAE2SChZNLuQtBjYj+xo1
mUuzgJQW/QBYk7tdH3+FqUzrQWCVObZoINyZEl8VaX/eN2FCU7xo8Vz2NsjFw9YX
eJ0V65HMNPk+iBVmwQWnlHKLvYGQ8Dqj4S7iyEA9me7vWheyinjHH935oIikmD/w
m+a0fsLdagsOVr8M/JWu
=hz+K
-----END PGP SIGNATURE-----

--ptMYGWplstB9CqWP--

--===============9003435557226523128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9003435557226523128==--
