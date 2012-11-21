From: Alex Courbot <acourbot@nvidia.com>
Subject: Re: [PATCHv9 1/3] Runtime Interpreted Power Sequences
Date: Wed, 21 Nov 2012 19:00:32 +0900
Message-ID: <4275468.QAmZy3xUK6@percival>
References: <1353149747-31871-1-git-send-email-acourbot@nvidia.com> <1699753.ZQsWMHINxd@percival> <50AC956D.7020303@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50AC956D.7020303@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, Stephen Warren <swarren@nvidia.com>, Thierry Reding <thierry.reding@avionic-design.de>, Mark Zhang <markz@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, David Woodhouse <dwmw2@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 21 November 2012 16:48:45 Tomi Valkeinen wrote:
> If the power-off sequence disables a regulator that was supposed to be
> enabled by the power-on sequence (but wasn't enabled because of an
> error), the regulator_disable is still called when the driver runs the
> power-off sequence, isn't it? Regulator enables and disables are ref
> counted, and the enables should match the disables.

And there collapses my theory.

> > Failures might be better handled if sequences have some "recovery policy"
> > about what to do when they fail, as mentioned in the link above. As you
> > pointed out, the driver might not always know enough about the resources
> > involved to do the right thing.
> 
> Yes, I think such recovery policy would be needed.

Indeed, from your last paragraph this makes even more sense now.

Oh, and I noticed I forgot to reply to this:

> This I didn't understand. Doesn't "<&pwm 2 xyz>" point to a single
> device, no matter where and how many times it's used?

That's true - however when dereferencing the phandle, the underlying framework 
will try to acquire the PWM, which will result in failure if the same resource 
is referenced several times.

One could compare the phandles to avoid this, but in your example you must 
know that for PWMs the "xyz" part is not relevant for comparison.

This makes referencing of resources by name much easier to implement and more 
elegant with respect to frameworks leveraging.

Alex.
