From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC] Add the "icebox"
Date: Wed, 07 Nov 2007 17:53:46 +0100
Message-ID: <1194454426.4470.70.camel@johannes.berg>
References: <Pine.LNX.4.44L0.0711071146550.4444-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7233047774412791165=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0711071146550.4444-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


--===============7233047774412791165==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-0XqFX83AJB6cEUGNyFkz"


--=-0XqFX83AJB6cEUGNyFkz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> > Right, ok. I wish I could change powerpc, I've been maintaining a patch
> > for months now, but Paul seems to be dead set against it. Not only does
> > that fix these things, but also we get to use the /sys/power/state
> > API...
>=20
> This is just the start.  Nothing will _really_ get fixed until lots of=20
> drivers actually begin to use the icebox.

No, I mean the patch that makes powerpc use the generic API fixes things
because it makes it use the freezer.

johannes

--=-0XqFX83AJB6cEUGNyFkz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARzHtmaVg1VMiehFYAQLDsQ//SmewQJj+6xPOR1kmOxeDhgRmfZPe2yJN
AgbcZPU0I3SerMNIloigTP4S0EdfjoMUeH5rPtd9U41VEJc8FGBg/rfM3f7TATQn
2ZmII9YepUuepU68Ix7Kj/++bRYdABZsRbVnP3fw/45ViSk9IOyIv9n/3dnFIk/4
+pY35FEhnVsHjEovdQNdaDdDpskRxAvAFRMzU+CSWtZtAMSUfFXDuibv9MIMQL6l
A1vSIanTl8+HNNPPzi5nsD/YhJ5iQUcGbYdW+T/UwMicJ6bTyTFCJUCSLjqmLy/3
LCFJJOuVYqRjVPIgWQGD0mmuvFuhZ/xQe7UvdlFKLR8Kuag8ZYcuacpN7TFAAeBo
dj3KAeDb0lULSOWCeX8Pa/NyM+0dUs5cTRr31HfirHwvMQm1uBppXOoYs1Qo1ohN
IhDE/y+6jw11H10lvSDa6gSq1Q/n2B5cM0o3XS57j7V/Z7I5WQft1KUE1UiJp3Cd
MlNZGKdKP+dy/026UH2dkHPHNFdxzgRaiMG655zPCEAsdXUYBH3oDVtNug0rH+Z2
b3WSDWAR/NFFKh4U/+lUxpgH9LbpEECrWTrT0dPaDSc/WV8qgfI04++VitLuRNvk
wTJwPBgaw1eKNVTrxEAiF4t9rAhCgVl8uOPwGyYoAYDmzTZ6CW89wRshFoEykrwY
0d4YVj2gfj4=
=XFGj
-----END PGP SIGNATURE-----

--=-0XqFX83AJB6cEUGNyFkz--


--===============7233047774412791165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7233047774412791165==--
