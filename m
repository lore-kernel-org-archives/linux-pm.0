From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH v2 0/22] On-demand device probing
Date: Wed, 29 Jul 2015 02:36:33 +0200
Message-ID: <2554489.GlTphZsHuX@vostro.rjw.lan>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438089593-7696-1-git-send-email-tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Terje =?ISO-8859-1?Q?Bergstr=F6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Sebastian
List-Id: linux-pm@vger.kernel.org

On Tuesday, July 28, 2015 03:19:31 PM Tomeu Vizoso wrote:
> Hello,
>=20
> I have a problem with the panel on my Tegra Chromebook taking longer
> than expected to be ready during boot (St=C3=A9phane Marchesin report=
ed what
> is basically the same issue in [0]), and have looked into ordered
> probing as a better way of solving this than moving nodes around in t=
he
> DT or playing with initcall levels and linking order.
>=20
> While reading the thread [1] that Alexander Holler started with his
> series to make probing order deterministic, it occurred to me that it
> should be possible to achieve the same by probing devices as they are
> referenced by other devices.
>=20
> This basically reuses the information that is already implicit in the
> probe() implementations, saving us from refactoring existing drivers =
or
> adding information to DTBs.
>=20
> During review of v1 of this series Linus Walleij suggested that it
> should be the device driver core to make sure that dependencies are
> ready before probing a device. I gave this idea a try [2] but Mark Br=
own
> pointed out to the logic duplication between the resource acquisition
> and dependency discovery code paths (though I think it's fairly minor=
).
>=20
> To address that code duplication I experimented with Arnd's devm_prob=
e
> [3] concept of having drivers declare their dependencies instead of
> acquiring them during probe, and while it worked [4], I don't think w=
e
> end up winning anything when compared to just probing devices on-dema=
nd
> from resource getters.
>=20
> One remaining objection is to the "sprinkling" of calls to
> fwnode_ensure_device() in the resource getters of each subsystem, but=
 I
> think it's the right thing to do given that the storage of resources =
is
> currently subsystem-specific.
>=20
> We could avoid the above by moving resource storage into the core, bu=
t I
> don't think there's a compelling case for that.
>=20
> I have tested this on boards with Tegra, iMX.6, Exynos and OMAP SoCs,
> and these patches were enough to eliminate all the deferred probes
> (except one in PandaBoard because omap_dma_system doesn't have a
> firmware node as of yet).
>=20
> With this series I get the kernel to output to the panel in 0.5s,
> instead of 2.8s.

Can you trim your CC list somewhat, please?

I'm definitely going to look at this, but not before then next week.
Sorry about that.

Thanks,
Rafael
