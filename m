From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: rcar: disable runtime PM correctly in slave mode
Date: Wed, 16 Dec 2015 17:06:42 +0100
Message-ID: <20151216160642.GB14817@katana>
References: <1450263756-12013-1-git-send-email-wsa@the-dreams.de>
 <Pine.LNX.4.44L0.1512161011070.1751-100000@iolanthe.rowland.org>
 <20151216154358.GA14817@katana>
 <CAMuHMdV81YwhVn_BYTaEybZhW04KFg_gERPJ88UsKSSSwWcvKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdV81YwhVn_BYTaEybZhW04KFg_gERPJ88UsKSSSwWcvKg@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 16, 2015 at 04:55:28PM +0100, Geert Uytterhoeven wrote:
> Hi Wolfram,
>=20
> On Wed, Dec 16, 2015 at 4:43 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > I have another case, may I ask your advice about this, too? When an I2C
> > bus is marked in DT as multi-master, then RuntimePM also needs to be
> > disabled, because arbitration detection needs to stay awake. I am
> > currently implementing this for the i2c-rcar driver:
> >
> > -       pm_runtime_enable(dev);
> > +       /* No RuntimePM in multi-master to keep arbitration working */
> > +       if (!of_get_property(dev->of_node, "multi-master", NULL)) {
> > +               pm_runtime_enable(dev);
> > +               priv->flags |=3D ID_P_PM;
> > +       }
> > +
> >         pm_runtime_get_sync(dev);
> >         ...
> >
> > @@ -664,7 +673,8 @@ static int rcar_i2c_remove(struct platform_device *=
pdev)
> >         struct device *dev =3D &pdev->dev;
> >
> >         i2c_del_adapter(&priv->adap);
> > -       pm_runtime_disable(dev);
> > +       if (priv->flags & ID_P_PM)
> > +               pm_runtime_disable(dev);
> >
> >         return 0;
> >  }
> >
> > Here, I'd tend to keep using enable/disable, although get/put would
> > probably also work. What is the rule of thumb using this pattern or the
> > other?
>=20
> Have you actually tried the above?

Nope, I just finished the sketching phase when Alan's mail came along.

> All our drivers rely on Runtime PM for the power/clock domain handling.
> I believe the pm_runtime_get_sync() won't do anything if you haven't enab=
led
> Runtime PM for the device, so the device's module clock won't be enabled =
at
> all.

This was another question I had: Is this a bug or a feature :) But if
you say it is policy, I will count this as "feature" and switch to
get/put here as well.

Thanks,

   Wolfram


--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWcYwSAAoJEBQN5MwUoCm2uaEP/RPMTmnPc3gM/X9++pa7diV6
SHIYoKSbotdJzBRN3f+4PUuWADX6Pc+PRCm4BxGv44uVksn1KofGFHSRelwxZ2IQ
aVJqOKN4j5eMi1hD+dijlWRBSReFa1SiB0sY4LQmt5q91nOdiWBL4aPKSLNbp9nC
CNRe/NWfRezf9RRnXDuuhbGNr91jjLx+ZfCzmgm2xi5ZC96L1Mr1UanaWXWqDk4g
sNSNUJh1EwSFeAg0397IdUkbERk6TirotxwKueU888yBcWTqKEkzryHu4BK2XtIs
ny4cZzjucnHmOzOFfkoNrGppntRMnERSAs7+Hs+tW5ptT5mzdJRLbX295bdbD2dd
WOwcULQJhD9NfrK/Q07CANrqSNR8feCGOBigOepFcMddPYI7gLDN+zkjOWMx1x5O
6p5NFN9ygUpRETI6KcRAwwN61W2J5ubYP7O0SqtTovElNNTn14/R+8T2rtGYml0R
wKp0Fnw9m+W+ilPgHeEWx1EF/ro8avp0hRzXznsUlFVBn3U8owNwkrVXVlilqWjT
CYQeZ+ZewcXsmvRkevtrhPghxyaX/tMsCvIkp3x/+fKNc8wdk1MHlzBVPtb3K8Ot
zkCHREvPbZp6aqJtdLbwVYT7rsy3QfHHF4kGECfvKAkPh2qXDHc63t7kESiQbLTf
S3XHdmdEwsdHLS3YMjz9
=KVbX
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
