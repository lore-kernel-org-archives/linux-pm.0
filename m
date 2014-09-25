From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 00/11] PM / Domains: Generic OF-based support
Date: Thu, 25 Sep 2014 13:21:24 +0200
Message-ID: <20140925112122.GA22753@ulmo>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>, Dm
List-Id: linux-pm@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I just noticed these patches because they conflicted with some of the
local patches I had to add a very similar framework. One of the reasons
why I hadn't posted these publicly yet is because the platform where I
want to use this (Tegra) is somewhat quirky when it comes to power
domains.

On Tegra these domains are called power gates and they currently have
their own API. We've been looking at migrating things over to some
generic framework for some time and PM domains do seem like a good fit.
However one of the quirks regarding these domains on Tegra is that a
fixed sequence exists that needs to be respected when enabling or
disabling a power partition. The exact sequence can be found in the
drivers/soc/tegra/pmc.c driver's tegra_powergate_sequence_power_up()
function. Essentially we need to call into the clock and reset drivers
at very specific moments during the operations that the PMC does.

One solution to this would be to make the needed clocks and resets
available to the power domain driver via DT, but then we have the
problem that two drivers would be controlling the same resources. For
example drivers could still want to disable the clock for more fine-
grained power management. Furthermore for some devices it may turn out
that turning the domain off and on introduces too much latency to be
useful.

Does anyone have any better ideas on how to make that work with this
generic PM domain framework? Or is Tegra just too special to be a good
fit?

Thierry

--DocE+STaALJfprDB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUI/qyAAoJEN0jrNd/PrOhhQYQAKj4ChY1io8nNFaZnX51r2fl
qsRhAHbpjBN57qi+hDlrZ63/hyIr1OENDurHSNh2RF7pT8y50w9ldP6YEkcntzbH
ufi8IGf/NMaz7tz64TGGO7GRavXdMpq9ki523glCMBCISBdGltTpHtUFatpKBqSY
znhzXUN52RHG4FW3CCaFVhW6PDgkuuNdtFPLUHPU02+7B9nE3MSYI1xqNtxw4zJu
UV9nnnql88FZ4TRUbtEEy39D1HXNUbGKEnzC3p7y5H4jfwSNNcwKVoTt7p69o46j
9FKacQWG0MRiy8Hfgf6/8/TXdFbsCm0Grj2I6N10YHAFzWqoHWSAe1wrUKb/Y0iN
/NxCBzqnsju2uCzE6RinrAyc1zZcpiTl39DGR++IjejD2L5jGGE3DX5vK3XGJCk3
63PXCaYi+9ZFBKkchhglw1m9pl6OKZDkFJXtnCIpZuPMl+Cte4pD2xM7f3m+c+Za
IJHsgtnIZpY1kbxYMgXM7tq4g1l1UX+suMxfZAzHxeVGH/7/73lfqQ7hA3UtzxM/
3iV+cYD3gHBxBKAFfnm968y0uCFakrK3C+4sePGMfKOva5quKkkp/d+vOSBc2zdd
hXdGYJ4gxEJPQK0ifbUNu/NMRgTuaFgqADJyIvs5TsKueZqz6WICmOQjgt+KKQJB
LOFMT3PsJ2VDcQ9ijtaE
=IKvD
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
