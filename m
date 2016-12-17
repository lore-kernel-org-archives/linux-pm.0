From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: max8997_charger: Using device managed API and
 remove OOM print
Date: Sat, 17 Dec 2016 17:09:38 +0100
Message-ID: <20161217160937.sbki4hs6ba7erbuf@earth>
References: <1481188357-11889-1-git-send-email-s.ritolia@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qwwonzeaycroa22e"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752821AbcLQQJn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 17 Dec 2016 11:09:43 -0500
Content-Disposition: inline
In-Reply-To: <1481188357-11889-1-git-send-email-s.ritolia@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srikant Ritolia <s.ritolia@samsung.com>
Cc: linux-pm@vger.kernel.org, vidushi.koul@samsung.com, srikant.ritolia@gmail.com


--qwwonzeaycroa22e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 08, 2016 at 02:42:37PM +0530, Srikant Ritolia wrote:
> Use managed resource function devm_power_supply_register instead of
> power_supply_register to simplify the error path by allowing unregistering
> to happen automatically on error and remove.
> Removing max8997_battery_remove function also as it is now redundant.
>=20
> Also removing out of memory printk message after kzalloc as there is
> already enough information on failure.
>=20
> Signed-off-by: Srikant Ritolia <s.ritolia@samsung.com>

Thanks for your patch. We are currently in the merge
window and your patch will appear in linux-next once
4.10-rc1 has been tagged by Linus Torvalds.

Until then I queued it into this branch:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/log=
/?h=3Dfor-next-next

-- Sebastian

--qwwonzeaycroa22e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhVY0EACgkQ2O7X88g7
+ppO+Q/+K17qLabxZp0yI1tJUZj9misFHAr0iznFM39avoQsdaHtsn2teKVQrKr9
bsaeWq8vspJeVzpr/DTai+DNU3JkmARbLOB8NVEJ+m1G0X4xurzcq7KJHFnf0kMJ
TawXNeZNND2hPqIBIr9XN2DpG60JmZSlQ0ZsFovX7VS5PvBVrGyInN1h2Fw9F0Hj
L/Z5nSiGnL2fGP4Oy4oaSVCDLVSOgVpneBLB9Fwaau/AfU6kGFq3sdm3x/wEHln+
oQU1X+RCo5B6nYE8owe/ver4KUUJVDvXhuks1Mw5MjjPrrtaXWCurYMj7Y4tSpQK
0GUNADfdAMbSO9wnNGONW1WBG6WUou7Tt+3x5HCggGT+YubX+IdOEXn/pDl4EEBJ
1olad1o6EwmkH5tNDOsDU60KCxWWL4YxMPlvAGcV5LG1oQqljaj9Db59FHlOAYst
HO2zxmAsaQ3ymyExz6RDgV7ioM3mHkGspnvW6PKg/yiPGwXtZGDsGo74J3SCHpYf
coGE+Dc2LIe9ZTPQRV2JnAxJMV8vXi/kbikuTDS4+li2v2KBHqxRa/mB6ONvBFxO
ywNm06ULHIiUb1FEHVMDMTQl9LoeaT75rCbt69YWSVSCzcEaY5tIhsfurU7tqssg
fu37Wn8+zOyxBfGxUUBgoIOd+BDAI+itjvrGW4H8KCk1YScAs+s=
=VhPe
-----END PGP SIGNATURE-----

--qwwonzeaycroa22e--
