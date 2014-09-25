From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 00/11] PM / Domains: Generic OF-based support
Date: Thu, 25 Sep 2014 18:56:26 +0200
Message-ID: <20140925165625.GC30382@ulmo>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
 <20140925112122.GA22753@ulmo>
 <CAPDyKFp8oK6KAujU44NEwT2vL2_BBPSMuGPkyppHdonPfOmUrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yVhtmJPUSI46BTXb"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFp8oK6KAujU44NEwT2vL2_BBPSMuGPkyppHdonPfOmUrQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>Mark Brown <br>
List-Id: linux-pm@vger.kernel.org


--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 05:29:10PM +0200, Ulf Hansson wrote:
> On 25 September 2014 13:21, Thierry Reding <thierry.reding@gmail.com> wro=
te:
> > I just noticed these patches because they conflicted with some of the
> > local patches I had to add a very similar framework. One of the reasons
> > why I hadn't posted these publicly yet is because the platform where I
> > want to use this (Tegra) is somewhat quirky when it comes to power
> > domains.
>=20
> It's great that more things goes on in this area. :-)
>=20
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
>=20
> I am not sure I fully understand how the power gating actually
> happens. How is it triggered?

Drivers explicitly call the custom API. So all drivers that need to turn
on power partitions have a call to tegra_powergate_sequence_power_up()
in .probe() and tegra_powergate_power_off() in .remove().

> > One solution to this would be to make the needed clocks and resets
> > available to the power domain driver via DT, but then we have the
> > problem that two drivers would be controlling the same resources. For
> > example drivers could still want to disable the clock for more fine-
> > grained power management.
>=20
> Sorry, but I think I need a better understanding to be able to comment.
>=20
> But maybe, drivers could implement runtime PM support and define
> runtime PM callbacks. From the callbacks those will handle clocks and
> resets, is not that enough? What more is needed from a PM domain point
> of view?

Let me quote the actual power up sequence code:

	int tegra_powergate_sequence_power_up(int id, struct clk *clk,
					      struct reset_control *rst)
	{
		int ret;

		reset_control_assert(rst);

		ret =3D tegra_powergate_power_on(id);
		if (ret)
			goto err_power;

		ret =3D clk_prepare_enable(clk);
		if (ret)
			goto err_clk;

		usleep_range(10, 20);

		ret =3D tegra_powergate_remove_clamping(id);
		if (ret)
			goto err_clamp;

		usleep_range(10, 20);
		reset_control_deassert(rst);

		return 0;

	err_clamp:
		clk_disable_unprepare(clk);
	err_clk:
		tegra_powergate_power_off(id);
	err_power:
		return ret;
	}
	EXPORT_SYMBOL(tegra_powergate_sequence_power_up);

The critical part is that we need to enable the clock after the
partition has been powered, but before the clamps are removed.
Implementing this with runtime PM support in drivers won't work
because the power domain driver has to do both the powering up
and removing the clamps, so there's no place to inject the call
to enable the clock.

> > Furthermore for some devices it may turn out
> > that turning the domain off and on introduces too much latency to be
> > useful.
>=20
> This should be handled by the generic PM domain governor. Through the
> per device QOS, you are able to set latencies constraints which could
> prevent a PM domain from being gated.

Okay, that sounds good.

> > Does anyone have any better ideas on how to make that work with this
> > generic PM domain framework? Or is Tegra just too special to be a good
> > fit?
>=20
> I certainly think it's worth a try, I would be surprised if we
> shouldn't be able to address requirements from Tegra.
>=20
> As you might have figured out, I am dedicated to improve the generic
> power domain such it could fit more SOCs than today, thus I am also
> hoping for more SOC to start to convert to it.

I do have code that seems to work in most cases without following the
above sequence, but there are no guarantees, so I'm reluctant to make
that change.

Thierry

--yVhtmJPUSI46BTXb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUJEk5AAoJEN0jrNd/PrOhIa8P/A+ly9JKUyQQrd3zOes5xayn
OHRfLIe+chrrqUnf58cWVqNgfTlH38jqSnE7BlHBPrWPfJeTm9MG5gLbF9BlMx88
D385iKUbR35GzHiXBwWog7TEUU8dVIilmULIlGMXXZ0IUexGdLVU7pjXvir/42OS
eAWYuDanpK4FOh9eQFHRrtE1Mwd38CbzjBNsGFGeKJiGNqHMi8PlbGTlXS48JG64
3lOeZyWdPUTi38EJjaWMInO+UL16mz5Joz81VOiPEXp/dHUrRbIFqM3gerBqfBej
fyUKoxWuxRLPV7yf30NnLqmC3wdk0bvDlU4X4qih9imqRcEP+K6YnVOtjNtDnyhM
xsljZcpu4CYqPj7r5BIC2UUmrkgiVooX8DvaOVU7o7UK0MR1fBSN0ILzNYDXFvxl
fFStHyYvGmTg8gDR68Q20Xxh9kI1/9Oe36btTH1r3LjbGn2dRigD9ZavwLP16Jvo
c/HsAVoaUAlCi1g3Y2xP9lUVG7bSoG/jf2sL3e+kmo25RqZR/tj9hfNu6gopeMe5
glkESwbX8BhX2R3KJhD+CVDk7yVCim7ytB3CZRayijHAGD9J1L/1Z1pAp28YOszv
tGFfGs3Y3+I4s/IXZG6zjHhxFdxQHOHe9GMhCz6wO51RUEKbnJJ5rs7v+dHTlH31
6O2idJ/sM6J0QPFbV/89
=8tId
-----END PGP SIGNATURE-----

--yVhtmJPUSI46BTXb--
