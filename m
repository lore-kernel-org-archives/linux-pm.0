From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: RFC: WMI Enhancements
Date: Wed, 19 Apr 2017 18:54:51 +0200
Message-ID: <201704191854.51783@pali>
References: <20170412230854.GA11963@fury> <20170419075248.GD18887@pali> <f3684c95b91349d3b4e512370ac1faf4@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5263741.Zo3SffanVJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <f3684c95b91349d3b4e512370ac1faf4@ausx13mpc120.AMER.DELL.COM>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: dvhart@infradead.org, rjw@rjwysocki.net, luto@amacapital.net, len.brown@intel.com, corentin.chary@gmail.com, luto@kernel.org, andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--nextPart5263741.Zo3SffanVJ
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 19 April 2017 18:29:53 Mario.Limonciello@dell.com wrote:
> > As wrote above, I'm fine with explicit whitelist of WMI GUIDs which
> > will be exported to userspace after communication with vendor.
>=20
> What about GUID's not yet used by kernel drivers?  Would those
> default to whitelist default to blacklist?  My preference would be
> to default to whitelist. This allows new GUID's to be added later
> without needing to modify kernel for something that kernel won't
> need to do anything immediately.

I understood it as there would be explicit whitelist in kernel and new=20
GUIDs would be needed to add into whitelist, even those which do not=20
have kernel wmi driver.

Exporting all GUIDs (to userspace) which are not bind to kernel driver=20
has one big problem. If kernel introduce new wmi driver for such GUID=20
then it block userspace to access it or at least would need to provide=20
audit filter and something would be probably filtered. It means that=20
some userspace applications which would use that GUIDs stops working=20
after upgrading to new kernel. And we can be in situation where *user*=20
need to decide: either use 3rd party userspace application from vendor=20
which provide some special settings for your laptop, or use kernel=20
module which provides standard rfkill/led/input class driver.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart5263741.Zo3SffanVJ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEUEABECAAYFAlj3llsACgkQi/DJPQPkQ1LmHgCgzDdTV6PM+RPMEIG7Bwlvvk6s
IZIAljfiV353bldcMi21g04PlsuHF70=
=ZpEx
-----END PGP SIGNATURE-----

--nextPart5263741.Zo3SffanVJ--
