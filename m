From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v5 7/7] iommu/exynos: Use device dependency links to
 control runtime pm
Date: Wed, 16 Nov 2016 10:30:55 +0100
Message-ID: <20161116093055.GA11230@wunner.de>
References: <1476948173-21093-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161020072336eucas1p24a2b020f69b6ae1f55e1760e6e0e94f9@eucas1p2.samsung.com>
 <1476948173-21093-8-git-send-email-m.szyprowski@samsung.com>
 <20161107214747.GJ1764@wotan.suse.de>
 <4bc652ce-6cf9-f4df-4793-e126cf81079d@samsung.com>
 <20161108153044.GA6983@wunner.de>
 <CAJZ5v0i3_8AE_o7vx=5kyuc8+P0jFOvjTC3YB9gcJVyQ+pTSkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i3_8AE_o7vx=5kyuc8+P0jFOvjTC3YB9gcJVyQ+pTSkA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Kevin Hilman <khilman@kernel.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Tomasz Figa <tomasz.figa@gma>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 10, 2016 at 12:56:14AM +0100, Rafael J. Wysocki wrote:
> The idea, roughly, is that if there is a single on/off switch acting
> on multiple devices, you can (a) set up a PM domain tracking all of
> those device's runtime PM invocations and (b) maintaining a reference
> counter of devices still not suspended.  This way it would only turn
> the switch off when all of the devices in question had been suspended.
> Analogously, it would turn the switch on before resuming the first
> device in the domain.  Of course, that code isn't available as a
> library, you would need to implement it (or use genpd, but chances are
> it is too heavy weight for the job).

My understanding is that the hierarchy of struct generic_pm_domain
is created by the platform on boot.  For an embedded platform, this
is encoded in the device tree, but what about ACPI which doesn't
know anything about struct generic_pm_domain?  I would have to lump
devices into generic_pm_domains after the fact, after the platform
has scanned the buses, but this seems to be forbidden according to
this slide deck, which calls that a "layering violation":

https://events.linuxfoundation.org/images/stories/pdf/lcjp2012_wysocki.pdf

(Quote: "Adding and Removing Devices [...] Supposed to be called by
the platform (calling one of them from a device driver is a layering
violation).")

So it seems that using struct generic_pm_domain is never an option
on ACPI, is that correct?

Thanks,

Lukas
