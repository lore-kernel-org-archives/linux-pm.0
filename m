From: Mark Brown <broonie@kernel.org>
Subject: Re: Alternative approach to solve the deferred probe (was: [GIT
 PULL] On-demand device probing)
Date: Thu, 22 Oct 2015 14:20:21 +0100
Message-ID: <20151022132021.GO8232@sirena.org.uk>
References: <20151018193757.GA9147@kroah.com>
 <20151018195330.GB14956@sirena.org.uk>
 <CAAObsKB2BUZ-smid45wOdAQw6h2yNqCydk+azAFNk69ewHJtZQ@mail.gmail.com>
 <20151019131821.GA32532@n2100.arm.linux.org.uk>
 <CAAObsKDS_+AZ26P_fHc6pvAYrQotsuoO0DEGQUWC514t3DD_jQ@mail.gmail.com>
 <20151019143045.GE32532@n2100.arm.linux.org.uk>
 <CAAObsKDWM6A98tdKHqi4fe5DBf0BmB0JeghcZDWan_PYbyshag@mail.gmail.com>
 <20151019153548.GM32532@n2100.arm.linux.org.uk>
 <CAMuHMdVv=ieYM-Nehp0qV8CEggHEeJ22j-6i_N09rRA_U=2ePw@mail.gmail.com>
 <20151020154656.GY32532@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MmQIYbZiCoQ2kDro"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151020154656.GY32532@n2100.arm.linux.org.uk>
Sender: linux-i2c-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>Liam Girdwood <l>
List-Id: linux-pm@vger.kernel.org


--MmQIYbZiCoQ2kDro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 20, 2015 at 04:46:56PM +0100, Russell King - ARM Linux wrote:

> Something like this.  I haven't put a lot of effort into it to change all
> the places which return an -EPROBE_DEFER, and it also looks like we need
> some helpers to report when we have only an device_node (or should that
> be fwnode?)  See the commented out of_warn_deferred() in
> drivers/gpio/gpiolib-of.c.  Adding this stuff in the subsystems searching
> for resources should make debugging why things are getting deferred easier.

Yeah, plus I'd expect it to also result in better error reporting
overall if the subsystems are able to report when they fail to get
something rather than just returning an error to the driver.

> +/**
> + * dev_warn_deferred() - report why a probe has been deferred
> + */
> +void dev_warn_deferred(struct device *dev, const char *fmt, ...)
> +{
> +	if (driver_deferred_probe_report) {
> +		struct va_format vaf;
> +		va_list ap;
> +
> +		va_start(ap, fmt);
> +		vaf.fmt = fmt;
> +		vaf.va = &ap;
> +
> +		dev_warn(dev, "deferring probe: %pV", &vaf);
> +		va_end(ap);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(dev_warn_deferred);

I'm not currently able to think of a nice way of writing this but I think
what I'd really like to see from a driver point of view is something
which decays into dev_err() if it's a non-deferral error.  That way
drivers can have minimal log and return error handling code and we will
still get the output sensibly.  The best I can think of is something
like

   void dev_warn_deferred(struct device *dev, int err, const char *fmt, ...)

which requires the caller to pass in err twice to get it logged.  That's
not a thing of beauty but it gets the job done...  but perhaps your
original interface is better, it's a bit cleaner.

--MmQIYbZiCoQ2kDro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKOKUAAoJECTWi3JdVIfQFcwH/2Bsw1x5Qw+VgkL/0LyC6iV4
8QUyxsL3BhSrQ1Oy5EVszY51yxiqW1bWOKCZKGe8uMuLcHdfpkSypeMNtqeEUKvp
qfqnzd1DRT2mIy3wIDab7BFEWW+yRDXc+B9cbfkLUX3R3ysMSMNtb8ilZJUk+TLK
KHxIGcjk7tFpWEtSAlJ+v9im8+HWMsdAioAOKc+lUgWlm9wftuARlM3MacsGfjuA
33SGbUwuvKMyqsSbflUlZGZQUoGFhxUFSzTqfqBeV3jIWgSyEJCEYxeBTIAlHpTQ
k9bgJeCmEQlpd8bkv2L85XtQ9D4dMFHhG7KIO+i8gTzPfiLLDl/bo96X9dEK/tE=
=wdzj
-----END PGP SIGNATURE-----

--MmQIYbZiCoQ2kDro--
