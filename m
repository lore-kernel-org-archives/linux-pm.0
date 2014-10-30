From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
Date: Thu, 30 Oct 2014 23:56:29 +0000
Message-ID: <20141030235629.GH18557@sirena.org.uk>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
 <7hd29h8n0o.fsf@deeprootsystems.com>
 <20141024161804.GH3729@sirena.org.uk>
 <7hsii58evg.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="abN2VRGcDj5Z284b"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7hsii58evg.fsf@deeprootsystems.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron Lu <aaron.lu@intel.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: linux-pm@vger.kernel.org


--abN2VRGcDj5Z284b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 30, 2014 at 01:46:43PM -0700, Kevin Hilman wrote:
> Mark Brown <broonie@kernel.org> writes:
> > On Fri, Oct 24, 2014 at 09:12:39AM -0700, Kevin Hilman wrote:

> >> I'm confused. Why arent' pm_runtime_get*() and pm_runtime_put*() working?

> >> What's not explained here (or what I'm not understanding) is why a PM
> >> domain is powering off if it has active devices.

> > The issue AIUI is what happens during system boot - if one device in a
> > domain probes and marks itself runtime idle then that will trigger
> > domain powerdown even if there is another device in the domain that
> > hasn't yet been probed.  This can cause undesirable glitches (or worse)
> > during boot depending on what's getting powered down.

> I'm not quite seeing how this series fixes that problem.

> Looking at platform devices in PATCH 4/9, the new _get() and _put() are
> still happening around ->probe(), so if a platform device runtime suspends
> after probe, don't we still have a PM domain that can turn off?

Yeah, I haven't actually reviewed the series so I don't know if it does
the above but that was my understanding of the intention.

--abN2VRGcDj5Z284b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUUtAsAAoJECTWi3JdVIfQbpEH/jkMEMqNsbHLV9MmEhChB35l
kN2NxsyXgUKHkGXdW7eh+fAmKn5kC7WNcwEauogjCKKLC3OCzlMdgi4XuBCyQgft
W7fIa4SAqg+0CzbTjJvFT2EWMWRzSo0xKh0JELUXUCjFaC/sR5B4gUsRyplABtEo
oXjisiO6LjDPjkHWCeuy1Hpt51P3ZJYcY33zt+m9nBYcXxV8Zk1GVF/6SDtx+xeK
FUcO8YwkIPLofqwsiQt7Xtwtvl1OEMgZAt7o0jCtkkavAtWkP7CdbQG3UiHnS2xO
vAfyvLMoSB497kzRF1y/S4KYLrEmXKnx6a3WXX7ORrnHqS63qerTD6ZV10AkKPo=
=VEZl
-----END PGP SIGNATURE-----

--abN2VRGcDj5Z284b--
