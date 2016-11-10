From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 1/9] PM / OPP: Reword binding supporting multiple
 regulators per device
Date: Thu, 10 Nov 2016 16:36:59 +0000
Message-ID: <20161110163659.rk67qrmnrovq2ktf@sirena.org.uk>
References: <cover.1477463128.git.viresh.kumar@linaro.org>
 <28119b44689921f3c3cc00be49bff2bb99b32162.1477463128.git.viresh.kumar@linaro.org>
 <20161109145828.p6vvsd5bygkzjcmh@sirena.org.uk>
 <20161110040440.GA11670@vireshk-i7>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3azoxlmqmb3xu2sa"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161110040440.GA11670@vireshk-i7>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, nm-l0cyMroinI0@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, d-gerlach-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--3azoxlmqmb3xu2sa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 10, 2016 at 09:34:40AM +0530, Viresh Kumar wrote:
> On 09-11-16, 14:58, Mark Brown wrote:
> > On Wed, Oct 26, 2016 at 12:02:56PM +0530, Viresh Kumar wrote:

> > > +  Entries for multiple regulators shall be provided in the same field separated
> > > +  by angular brackets <>. The OPP binding doesn't provide any provisions to
> > > +  relate the values to their power supplies or the order in which the supplies
> > > +  need to be configured.

> > I don't understand how this works.  If we have an unordered list of
> > values to set for regulators how will we make sense of them?

> The platform driver is responsible to identify the order and pass it on to the
> OPP core. And the platform driver needs to have that hard coded.

That *really* should be in the binding.  Honestly if the binding is this
vague I'm not even clear that it's worth documenting these properties at
this level, might be better to just put the documentation in the
platform driver bindings.

> > > -			cpu-supply = <&cpu_supply0>, <&cpu_supply1>, <&cpu_supply2>;
> > > +			vcc0-supply = <&cpu_supply0>;
> > > +			vcc1-supply = <&cpu_supply1>;
> > > +			vcc2-supply = <&cpu_supply2>;

> > This change doesn't seem to correspond to the documentation change.

> This rectifies the incorrect binding previously added to the example, which I
> realized to be incorrect only while attempting to code for it. And so it brings
> the example on the same state as the documentation now.

Then that should be in a separate patch with a changelog explaining what
the change is doing.

--3azoxlmqmb3xu2sa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYJKIqAAoJECTWi3JdVIfQemQIAILA5rK1b7etybj9dj0YLuAb
Yih9n3gBSy76yFuiWTrmQ8tLjPBq2Z9Ma5+NLPng/M5c09yBj3fQ5jAw6EzEg/6k
omVxFFKKQ6ZkDGEbqOQKAiuHyh+0whJ+ZS70HQsNTm7R+clNHpO81EZJ1QcyTbCR
cF8d6ANbPPoGMziqYvtOLYaXIjvbB67/Fr7ZSTvDytJ8He9qbs+8iQRmTYZdM/EX
xgZyVOe/TS1aMlNLo0JEQ4mKbAndKn+V6YTIVpA8A/nRaFxAvJ/+YVLfzFbLYF1p
KxdR27B16WfVqV9KAMc2d6bQBUHIkeo/Gbi9r6ALwwQo/uf/ImWxQM8+IewaoPE=
=VJrz
-----END PGP SIGNATURE-----

--3azoxlmqmb3xu2sa--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
