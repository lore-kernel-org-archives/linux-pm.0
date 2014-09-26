From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 00/11] PM / Domains: Generic OF-based support
Date: Fri, 26 Sep 2014 09:31:27 +0200
Message-ID: <20140926073125.GB31106@ulmo>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
 <20140925112122.GA22753@ulmo>
 <7hppej8glk.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:62101 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725AbaIZHbb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Sep 2014 03:31:31 -0400
Content-Disposition: inline
In-Reply-To: <7hppej8glk.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 03:45:11PM -0700, Kevin Hilman wrote:
> Thierry Reding <thierry.reding@gmail.com> writes:
>=20
> > I just noticed these patches because they conflicted with some of the
> > local patches I had to add a very similar framework. One of the reasons
> > why I hadn't posted these publicly yet is because the platform where I
> > want to use this (Tegra) is somewhat quirky when it comes to power
> > domains.
> >
> > On Tegra these domains are called power gates and they currently have
> > their own API. We've been looking at migrating things over to some
> > generic framework for some time and PM domains do seem like a good fit.
> > However one of the quirks regarding these domains on Tegra is that a
> > fixed sequence exists that needs to be respected when enabling or
> > disabling a power partition. The exact sequence can be found in the
> > drivers/soc/tegra/pmc.c driver's tegra_powergate_sequence_power_up()
> > function. Essentially we need to call into the clock and reset drivers
> > at very specific moments during the operations that the PMC does.
> >
> > One solution to this would be to make the needed clocks and resets
> > available to the power domain driver via DT, but then we have the
> > problem that two drivers would be controlling the same resources. For
> > example drivers could still want to disable the clock for more fine-
> > grained power management.=20
>=20
> I think you're on the right path here.  You can get rid of this conflict
> by removing the direct/manual clock management from the drivers, and
> using runtime PM instead: s/clk_enable/pm_runtime_get_sync/,
> s/clk_disable/pm_runtime_put_sync/.  When using runtime PM, those calls
> trickle down through the power domain driver, which can manage the
> device clocks, as well as any additional clocks and resets needed for
> power gating.

Okay. The DT part of it is going to be pretty nasty (as usual) because
we currently have the clocks and resets within the device's device tree
node (which I think is where they really belong).

So one possibility would be to move the clocks and resets to the power
domain controller's node, like so:

	pmc@... {
		power-domains {
			...

			sata@... {
				clocks =3D <&tegra_car 124>;
				resets =3D <&tegra_car 124>;
			};
		};
	};

An alternative would be to make the power-domain controller look up the
clock within the user's device tree node. That could be problematic,
because while the module clock is always the first clock in current
device trees, there aren't ordering guarantees, so we'd have to rely on
the clock name.

> > Furthermore for some devices it may turn out that turning the domain
> > off and on introduces too much latency to be useful.
>=20
> In these cases, you should use the per-device PM QoS framework to set
> per-device latencies.  Then your power-domain can look up these
> latencies and decide whether or not to actually power gate or not.

Does this allow fine-grained control over what parts of the "power
domain" get disabled? For example some drivers may want to only turn off
the clock under some circumstances, which would keep the hardware state,
whereas in other situations or drivers it might be fine to completely
turn off the power partition and reset the hardware block (loosing all
hardware state).

Keeping a reference to the clock in the power domain will prevent that
=66rom working since the driver itself won't be able to disable the
hardware clock.

Thierry

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUJRZNAAoJEN0jrNd/PrOhV1cP/AgoqP3z/kEQZmWJyEsXN0qU
6QGSGqWVtbk5axHq4f+INc2SiU0KPakYSgaJqHwNVYFXPAYG4REoNzxopTZFBEFM
s9zipWqEFwRSxSgR0tr7LFHmkQ2++lmBObQg6QSXz3SFyi4WJZUiJFXZIfJadFVr
T4OTsC4eNnIJIZD5zd+K0IVL7tjPdEcCdgGKnXwgp1wWHc68IDPeGG5aqZ0aEuqj
bj9lVkyxiOQyNJt3NvLVC51yB67o1K0w7Ea0Q+0b1gJNh0L998ZJkO2Pbmbavvgl
evxrljN7eK9yVbNDYIFZXM6dbJND76FvbOwIHw0CHcpMR/hmBqNDnGcIOm+ai3eD
LMqQHDcuy70xYvM8GhqC7il0mAcFbcf1r1Q6wpc9qAP17f0h2ZU+XAMjyC9d9EhY
i2NzzyhdCBmQUGoDl3SYbOP+8HiX96vkTwclZu+PNeFEfhvj0HNxmWPKWiQ+jIDS
bMbPZmvCsn6JV7Q9r9ciQvJ28A8rRWYZL+qv0/rfuXUlXQzWOQRJZUbP9iEw3IVp
+ORji8peGOIpjvGsrHwFhV2Xa8XEO6vZDYaHhWU4aUMsjj5oNG5xpvgdiqhqv/qN
ynLcNLpaou65G3hzAB5PIup8UPV8rtbCtKKt0a8wqVP3l5+0vicUd+ppa7UZF5j1
lg51bYDfTg+zDr4hxPIb
=/2sV
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
