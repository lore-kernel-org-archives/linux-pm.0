From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 19 Apr 2012 03:23:01 +0600
Message-ID: <20120418212301.GW11484@belkar.wrar.name>
References: <1334769632.28106.46.camel@gandalf.stny.rr.com>
	<Pine.LNX.4.44L0.1204181616430.1149-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4687507814904410924=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1204181616430.1149-100000@iolanthe.rowland.org>
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


--===============4687507814904410924==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0k4Rxg87Lb8yV0u3"
Content-Disposition: inline


--0k4Rxg87Lb8yV0u3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2012 at 04:23:20PM -0400, Alan Stern wrote:
> In the meantime, just to be certain of the diagnosis, here's a
> different patch for you guys to try.  This will test the ehci-hcd
> unbound path (i.e., use it with the script).  The patch removes the
> line that sets the dev->current_state to PCI_UNKNOWN when the driver is
> unbound.  Thus current_state will remain equal to PCI_D0, so
> pci_prepare_to_sleep should put the controllers into D3, which we
> expect will cause a crash.
>=20
> Please try this both with and without pm_test set to "platform", and=20
> post the debugging dmesg output from whichever cases the computer=20
> survives.
With "platform":

ehci_hcd 0000:00:1d.0: wake-up capability enabled by ACPI
ehci_hcd 0000:00:1d.0: cur 0 target 3 error 0
ehci_hcd 0000:00:1a.0: wake-up capability enabled by ACPI
ehci_hcd 0000:00:1a.0: cur 0 target 3 error 0

With "none" it locks up.

--=20
WBR, wRAR

--0k4Rxg87Lb8yV0u3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPjzC0AAoJEDNi9wMaSZLh7yEP/0TpicDHDfYLsgd17zRkdOfg
wxtIzcs7K2niogf9IX9kVP1oscERE/g9C8Dli3vfuAbYFfMHlrbsuSRGtF7jTKFS
101c7zcrgqzJVeKtL/nbbx+/pIS+o68qqlh7hONfVXt5VSLGsGLD3b1D2XCqLWTH
SYS4zU0odoQtJRCMrgZNI2pO8o9HpSMrmfV6CADQjNBnARVNnIRVnAMtnTrptBqm
fJyqqcs5YOD4n/tXJDM771KPllfwyU/bFnkGRvo7OVu49XFpefzrdvBiq9qoPZXo
aLeZiFb+8nlLacxtQtNOFdUmzn2Qw3WMsmi/BUyf69y0IMKyOOw+PHgnfdiiiAbi
DHU75ZZbGD9TpruZgCh1wPury1kj+45z+47DJs/cK37+meCnz0uiHc/PaTdka0sT
mvm3a1sGs3YLlpHsg3MQTgOkfP1Unauz9Z97MmMSUoOj1Tox5wj/uCdhv4lT2uWZ
fNn91ArsK65aCCk1S6bfqePTSqDtFgdSm37am/NAkNle/HeJ4Yt6L85ua2YvEIqZ
RcT3Oqja5gs1U7dqaTsC0xF/PD6+sGTUI1O5oztTcU8JjFdlcyZS7A5UEz1kSUpd
wHZ+tOicDPryYSkFHWJviakW7zz9No6c+CWs3k2RBObydZxz42Q2IJiXwvQ9m98R
p0b8bdjqpO/Yav1c9gnn
=EqVJ
-----END PGP SIGNATURE-----

--0k4Rxg87Lb8yV0u3--

--===============4687507814904410924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4687507814904410924==--
