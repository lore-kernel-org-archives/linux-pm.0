From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3] ARM: tegra: cpuidle: implement
 cpuidle_state.enter_freeze()
Date: Thu, 13 Aug 2015 16:54:47 +0200
Message-ID: <20150813145446.GD26559@ulmo>
References: <1432046953-12945-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Km1U/tdNT/EmXiR1"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34709 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbbHMOzn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2015 10:55:43 -0400
Content-Disposition: inline
In-Reply-To: <1432046953-12945-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Russell King <linux@arm.linux.org.uk>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Ingo Molnar <mingo@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org


--Km1U/tdNT/EmXiR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2015 at 04:49:12PM +0200, Tomeu Vizoso wrote:
> This callback is expected to do the same as enter() but it has to
> guarantee that interrupts aren't enabled at any point in its execution,
> as the tick is frozen.
>=20
> It will be called when the system goes to suspend-to-idle and will
> reduce power usage because CPUs won't be awaken for unnecessary IRQs.
>=20
> By setting the CPUIDLE_FLAG_TIMER_STOP flag, we can reuse the same code
> for both the enter() and enter_freeze() callbacks.
>=20
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> ---
>=20
> v3:	* Set CPUIDLE_FLAG_TIMER_STOP to simplify things as suggested by
> 	Lorenzo Pieralisi
> v2:	* Disable FIQs also when suspending-to-idle
> ---
>  arch/arm/mach-tegra/cpuidle-tegra114.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Applied, thanks.

Thierry

--Km1U/tdNT/EmXiR1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVzK+0AAoJEN0jrNd/PrOhoEkQAJxNOTx0h7bJDHRPXXM7wOIl
6Ib2CGCYLFzN4FNzK0NTgvP5r1XFVbD9xARd4PnumQnQF3Dkjer/AuoYYi1Z++oz
5QJYeCqBfOqJK4NyM1HQZ/SdgIGZyX52GtlXj34pzCLZWTeC0iGYSA7cSFF5Kz85
j14UtJIAjV3t7CPB8+I3ICBYxkhdDP90Tm7PDgTrEDTVRMB/9n7NDBL2Ctgaqxg/
Kve0J/xuQVItcQbi7h9eugZ99hQ9k1kbEoHNnjd5qCLoyieUzO99tYO8Tcak/wLR
u6LPdfTb0sc6Zk8vZrfuvo2PYkwlNq1diy74s7mcIrNtDnddMN45NSIaRxoi7ZG5
q42y+1uHB3A17KQDKzhffBYgGqQhH1cZluvvKuBIkop/jGkQW/Qt/Jf9LiJEWuMI
Jc2sHz/BRJW0mAmR8TrXToC9h5T2vk6Of3xS1GI3CSbLIC/OeaAjJqrmIFMBVLQk
ykIGIvFfLzhLS1xcp6IGHuMyf310DA9CcNyA+o7KTp6PMffBhDlR2dxSb4yXrHwf
WE10TPi+RRxxp1NzJF1E2b1jGzhFolAdtIIi9FW3WSBULz4yWfbwd4xfCq+VzGP9
g/RJG8ZEJ0KH2Bgj52cLLCrpc0fW4Hc9+oQGXG0KWDzIGVSLW4DFgX1ACiIMmf3F
sa4NZj091ojSrWsnfZ/g
=O1PM
-----END PGP SIGNATURE-----

--Km1U/tdNT/EmXiR1--
