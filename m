From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 2/7] power: bq27x00_battery: Renaming for consistency
Date: Tue, 22 Sep 2015 18:10:36 +0200
Message-ID: <20150922161036.GD4235@earth>
References: <1442265973-32261-1-git-send-email-afd@ti.com>
 <1442265973-32261-3-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442265973-32261-3-git-send-email-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Sep 14, 2015 at 04:26:08PM -0500, Andrew F. Davis wrote:
> Rename functions that are used by multiple devices. New devices
> have been added and the function names and driver name are no longer
> general enough for the functionality they provide.

This patch does not apply to my next tree, please rebase the next
patchset version against this tree:

git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git (branch "next")

-- Sebastian

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWAX18AAoJENju1/PIO/qayy8P/in0vL6RC6xfIr3GrOXhPAHY
Z9l4ZIahbOUB+LpOTJqEJpsbxoT8U9MUsd6zSvee0xFywh8C7WmkpTF3BPz3FVCh
iN5MnxWOWij29VtP39cBuBsAPlK+jpSyvSTHl5DWVzCJwBrt6bAM5VsATisKsHhR
mWuSw0Ks6ZrJQOaMjMayCN+ZL36CZoSiGsaMJljNf8VsTAnQnCpG/X1fZOUl8Kwm
fTgDM5x1CAQpMnRF25AsHhsIxQB3q9/rupNioYQHFweQJhL4W9lJyAu6ExVzfGTr
pj9ZD+hpJwI6Ri+NKqid/iuBF3JORu+wfZStJLXBSX8SmUIiNJRFB/vJLPQxGTUG
KnR2oGYHxZWgPY9NyaY3Uk3mdXPNQks/oSrChm3Xq/AioJB+sO8XTdIsUegm1FFi
wRdR92OH4gwAteVriLQKDrTirrXJLO3LLZYIyoqL53yad4iZelmHKmQfle9Vx0C/
+4x2Da8MsFHTxyB21y0LZZCoF5f5wn5ZG9Xp0Eoag/3917WujZSbO1WEQX4D7pJV
AI0cXGnGvVO8oBh0dLTuki4bYRLG94HxUWJNN/VhQ4GQhUyKrs0vc3VRMgutp8aQ
XVSGDDQ1ZmCp4crvUmtWp38V+AsAJu/mKgQ/kG0DvY5jHVhCoWGb63K/0xL0czS+
pIFaQnzkN+vdC2jQdUPA
=P4LV
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
