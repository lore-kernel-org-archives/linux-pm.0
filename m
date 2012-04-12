From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 12 Apr 2012 22:58:27 +0600
Message-ID: <20120412165827.GC12852@belkar.wrar.name>
References: <20120412153750.GA12852@belkar.wrar.name>
	<Pine.LNX.4.44L0.1204121203530.1496-100000@iolanthe.rowland.org>
	<20120412164903.GB12852@belkar.wrar.name>
	<1334249541.23924.338.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7538955035263826840=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1334249541.23924.338.camel@gandalf.stny.rr.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: jrnieder@gmail.com, Greg KH <greg@kroah.com>, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--===============7538955035263826840==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2012 at 12:52:21PM -0400, Steven Rostedt wrote:
> > > > > Here's a diagnostic patch that will give us a little more informa=
tion. =20
> > > > > Keep the previous change (so that pci_prepare_to_sleep gets calle=
d=20
> > > > > whether ehci-hcd is bound or not) and let's see what it says.  Tr=
y=20
> > > > > doing it both with and without ehci-hcd bound.  Running this with=
 "echo=20
> > > > > devices >/sys/power/pm_test" ought to be good enough.
> > > > I don't see that line with ehci_hcd both bound and unbound and both=
 in
> > > > 'devices' test and in a real S3.
> > >=20
> > > You mean the new dev_info message did not appear at all?  Is
> > > pci_prepare_to_sleep getting called properly?  Or does the routine ex=
it
> > > early because target_state is equal to PCI_POWER_ERROR?
> > Either dev_info is silenced on my system or pci_pm_suspend_noirq is not
> > called during the 'devices' pm test.
>=20
> Did you undo the original change that removed the call to
> pci_prepare_to_sleep()?
pci_pm_suspend_noirq itself isn't called.

--=20
WBR, wRAR

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPhwmzAAoJEDNi9wMaSZLh35cP/1ClUB//jlq0B85765OmKTMY
fZdgGc2rKnOx5MnBl9X4rD1Ow3bAF+42rfQE94eaCiRNQoNAyiX6iWJ4kOBGwfP9
AEhfrn95ziMFTwvF7uCkPB5EJ5DatCRmY0Am5VtiK2+qysrS9lux1MuP1bcxDGen
aSnTT4NcvdvR6Hrnlp/fQqPwIlS9x7kaNaLtMbxrfsNPXbXJ7JKNQNzp5hVnxzLo
1qsS8vOAvETGxTehmdPsngonm0Sq4VskOuTvhz3U7U3wzYjKfBk9XdTJx/ztmeNt
07tkuElwOI6w/Gmx4FFgEwXcCPfhMJGTM0Xa/L6KMqvm86Y9tv7voicvVY5EOxr1
H5yINRD708IimbnVsY2G8A1NXQLyLlIKcGS3n/vZRYN6kKQ3Vu4RlNjr490W5z+s
1Yy1Og1dhloH46C4OGfK4D1YEHL7+TQ6rjQPxvL6Up8RWq5eQDfNRwEO0usXwMSm
Ff5SMMgCkd+SFLjKz20+CMx7YHb2E/QPibzO/gte8cBxEOmMDqZ+ejn/u6q+WEw+
R1QeZIPThsdK+AzMslOSSihi0YpFa2JUM/65Of8Prw0b8YOKAiQsEQH7I2YS6Lya
fWUsjT/iFQJmdEX0CPo68or4Hn71asYr2PTM41xR7QikDHGW5WGY5K3KU7wx4Imp
YZXWY9u/s1d83oYCYr/4
=7z9F
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--

--===============7538955035263826840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7538955035263826840==--
