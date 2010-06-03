From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: Re: [regression] Please add bug 15788 and 15969,
	usb sound / radeon kms broken after snapshot cycle
Date: Thu, 3 Jun 2010 12:42:46 +0200
Message-ID: <201006031243.16703.Martin__11240.9293106341$1275561873$gmane$org@lichtvoll.de>
References: <201005312215.17793.Martin@lichtvoll.de>
	<201006011002.59191.oneukum@suse.de>
	(sfid-20100601_212614_090179_B3E275A8)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0792858558477337751=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006011002.59191.oneukum@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============0792858558477337751==
Content-Type: multipart/signed;
  boundary="nextPart3450944.LDfSZctE7r";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3450944.LDfSZctE7r
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Am Dienstag 01 Juni 2010 schrieb Oliver Neukum:
> Am Montag, 31. Mai 2010 22:15:04 schrieb Martin Steigerwald:
> > Hi Rafael,
> >=20
> > please add
> >=20
> > Bug 15788 -  external usb sound card doesn't work after resume
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D15788
>=20
> Does it show up in /proc/asound/cards ?

Currently I have 2.6.33.1 installed again, since even the work-around to=20
unload and reload the usb audio sound module did not work. And on the=20
other machine, my ThinkPad T42, I had two hard freezes, but these might or=
=20
might not be related to Radeon KMS stuff. Not yet reported, as I did not=20
yet take time for it and I do not have many details or any idea on what=20
circumstances these freezes happened.

It was all too much for me and I decided to go back to a kernel that works=
=20
for me.

I had it in lsusb at least.

I hope to have time and energy for further testing soon, but right now=20
other things are more important to me.

I did one thing tough: I asked your question in the bug report, since=20
there are other reporters that might easy take time for this. When you are=
=20
interested in the outcome, please add your Cc to the bug report.

=2D-=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7

--nextPart3450944.LDfSZctE7r
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkwHhycACgkQmRvqrKWZhMcQawCgpJsNTwsZgty5WDsXC8/OnDZl
TRsAn0Jbo7iZk5w5sdnOaO9Cv/NI5nYD
=6Xlk
-----END PGP SIGNATURE-----

--nextPart3450944.LDfSZctE7r--

--===============0792858558477337751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0792858558477337751==--
