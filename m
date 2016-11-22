From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] power: supply: sbs-battery: use fixed device name
Date: Tue, 22 Nov 2016 17:17:19 +0100
Message-ID: <20161122161719.mcrcgsc2ec6jqjv2@earth>
References: <1479751491-8849-1-git-send-email-nicolas.saenz@prodys.net>
 <1479751491-8849-2-git-send-email-nicolas.saenz@prodys.net>
 <20161122152348.ip3gz3mea4fgrejl@earth>
 <271e2a75-4676-b9ac-296b-282effc73d47@prodys.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m3q625l7bt5ecrtf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <271e2a75-4676-b9ac-296b-282effc73d47@prodys.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Saenz Julienne <nicolas.saenz@prodys.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--m3q625l7bt5ecrtf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Nov 22, 2016 at 04:31:51PM +0100, Nicolas Saenz Julienne wrote:
> > NAK. This is not ok for systems using multiple sbs-batteries.
> > Also please read:
>
> sorry I wasn't aware of that feature, I'll have a look at the
> whole thing and rework the patch.

no problem. I also reviewed the driver. Please include that in your
rework.

P.S.: https://web.archive.org/web/20080722025748/http://www.zip.com.au/~akpm/linux/patches/stuff/top-posting.txt

-- Sebastian

--m3q625l7bt5ecrtf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlg0b44ACgkQ2O7X88g7
+pqvtg/7BrfwqYRYA/iuJ/tIt+qRrAqHMHAa6SLB1sxbdqccnfBix/CqnBfP36nJ
PFUZrHuex+VeLGD3yd8+bNVLjNy/WkbxZTxzB90q0rrinsd9BXsxqLstTE9AiMgV
H5B42BZEJOh1nPHZZTFt17fzHj4lysw+NypKFpIljQNqKu+Nw3i9khBKXNcfOy4J
xBISEs7PY8mKrfLsWCMiH11cZHHzvI0MKp3+fpCs4vATYTuGFUduHCkd+7ISFAjZ
UVJzmNf7v9yH/C3Fkxtq0Bvf+qCdX2H38m0AdxzRlz3AR1vxph79XByw5S9I07tm
+FbakgF2s241KrGErQldTflRCNKpqLHTLgcwqlIZUSTfXbNKt/SSfO9scVQXNu2O
TPmg4FgXs5AudpMFgh62YC67oez/4M3AZBVa8WaIAqpVOSET/Ne7bbQ0RjvIAdN3
ePHbgTEGQs3qtULLJ6VY422D2tAepnlT9vuVBQhlGvW6/EYqZYdRJ/HnXiFucYg6
o31WQ9Wim0dnnwgwU9Ell5f7lXM9+INH8ks2ap51nPV1qCuOH27sELuqnV+TA0hE
CvwID9yytORDtFkjibSf1csjnjFjzvHU40hD21LKjKNjuitJ90NvEnodI0M9Y5DY
Rpjp7A5xC6mg/FQI1XdkTnQnxnsY1vmL47hVBAdPByXiSIbEzuU=
=QOER
-----END PGP SIGNATURE-----

--m3q625l7bt5ecrtf--
