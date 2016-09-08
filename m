From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] soc: ti: Add ti_sci_pm_domains driver
Date: Thu, 8 Sep 2016 11:27:52 +0200
Message-ID: <CAPDyKFo0Cb90BbY7ra6VDjb5frC5=VtmE3V6tDK=VosfPmod7Q@mail.gmail.com>
References: <20160819235653.26355-1-nm@ti.com> <20160819235653.26355-4-nm@ti.com>
 <CAPDyKFooDUOPT9dP8HaW3YBO9PsX-1+96PPE7CRMyjEkra7cBQ@mail.gmail.com>
 <57C0D2C9.1030801@ti.com> <57C5E1DA.2040405@ti.com> <CAPDyKFqszM48nXnnA9D8iCp34k-ZmNvOkHPCc=Fya4nJA7PvBQ@mail.gmail.com>
 <57CF26DB.4020807@ti.com> <7h4m5rv9kz.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7h4m5rv9kz.fsf@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Keerthy <j-keerthy@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tero Kristo <t-kristo@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Santosh Shilimkar <ssantosh@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

[...]

>
> One more idea...
>
> Since you don't really have a domain (a group of devices), what you
> really have is each device having an independent power switch, so as Ulf
> suggested, what you really need is for all the devices to share the same
> set of runtime PM callbacks that call SCI.  The only difference is the
> unique ID.
>
> Rather than using all of genpd, you could also just use a pm_domain
> which is what genpd is built on top of (and also omap_device, which
> you're probably familiar with also.)

Even if this would work as well, the downside would be that you need
to re-invent the parts related to the DT parsing, the probing/removal
and attaching/detaching of the device to the PM domain.

You probably don't want to go there... :-)

>
> That would allow you to keep the drivers completely generic, yet share
> all the SCI specific "domain" code inside a pm_domain.
>
> Kevin

Kind regards
Uffe
