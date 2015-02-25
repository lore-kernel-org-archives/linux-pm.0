From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] ltc2941-battery-gauge: Fix typo in conversion formula
  (58 instead of 85)
Date: Wed, 25 Feb 2015 22:55:22 +0100
Message-ID: <20150225215522.GO13695@earth>
References: <1423654611-10906-1-git-send-email-mike.looijmans@topic.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ck22u5fw4m2k6hx2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423654611-10906-1-git-send-email-mike.looijmans@topic.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
List-Id: linux-pm@vger.kernel.org


--Ck22u5fw4m2k6hx2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Feb 11, 2015 at 12:36:51PM +0100, Mike Looijmans wrote:
> The driver reported 30% less than actually measured. This turned out to
> be caused by a simple typo in the formula to calculate the LSB quantity.

This is in my for-next queue since some time already and will be
send to Torvalds in my 4.0-rc pull request.

-- Sebastian

--Ck22u5fw4m2k6hx2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU7kTJAAoJENju1/PIO/qaEdIP/1vnnoMvN+RRwNsj+s7RndlX
DVqv63RJSq7DYjVzfCkURM31wl4gQ/DXjjrNMF5/pGWF3apyxjZd0ZGZoWA7zwTz
Gxyui9Vp82IbLeBY1tgauejPNXVVmTgmri8Eurmt7kSi5Qa5z1WZ9b65nRhNvK8s
ItDGj9zYIFKinmjbYTgn7I8uQJ/eHUWH8Fb9Q3ryyPKwZ/wNVDNwLjDKf9JlDaAF
vo+S3eaGfv3QG8REnZmQbN2QcNEjtc1pYp32y8JTzeb7jl9U3RiKI6YJf+oct4Jd
nEfLV9TawoQ/BSdtifPGKb7rBi2CLPOlMHX3avvFrgwyaL/1aSQ1+ev/qqauWquJ
CICN4KUFCchF/3gr4+YvGJSKuxSd/+wsw1oksiXYOCCoUAKS8TJJx06blt1AEc73
pkiul8mCzPwF5jE/GBvIGXgScvA635u4aXw/KlxoeKWvonZKq9qUdm6sBPm7nJmt
PgLWSGEMa/rrMSu0vqLufRYRSOOfRaILQHKZWTxLiOg9sZfD1TCzJ6QUtZ+361z/
Hu/nHG4SQ5ikQLsJfm+xtMOdw6fjV/A5B5nEKsq64/wyAnf1vkv1rrzGWUj8FWAf
MO2H5NSFu1cZhY71SLs2xosW1RRc+UF2i7S5hINFKeTNjq+JQ1nzrQcI/X5swvwa
EUFqKgac96rxSCnVL0o6
=PCFo
-----END PGP SIGNATURE-----

--Ck22u5fw4m2k6hx2--
