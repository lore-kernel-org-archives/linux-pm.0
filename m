From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [RFC/RFT][PATCH v2 0/7] Functional dependencies between devices
Date: Sun, 18 Sep 2016 14:39:18 +0200
Message-ID: <20160918123918.GB2169@wunner.de>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <CAJZ5v0hS1FtqmsaqT03sMyGW8==UxTo-uFZkzueF=pFPHWjOdA@mail.gmail.com>
 <20160913175731.GA1393@wunner.de>
 <4860126.rVrMyhOcY1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4860126.rVrMyhOcY1@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 14, 2016 at 01:18:16AM +0200, Rafael J. Wysocki wrote:
> On Tuesday, September 13, 2016 07:57:31 PM Lukas Wunner wrote:
> > To name a different use case: On hybrid graphics laptops, the discrete
> > GPU usually includes an HDA controller for external HDMI displays.
> > The GPU and the HDA controllers are siblings (functions 0 and 1 of a
> > PCI slot), yet in many laptops power is cut to both devices when _PS3
> > is executed for the GPU function. Currently we have a kludge where
> > the HDA controller is suspended before the GPU is powered down
> > (see vga_switcheroo_init_domain_pm_optimus_hdmi_audio()).
> > 
> > I envision the HDA controller to be a consumer of the GPU in those
> > cases, thus ensuring that it's suspended before power is cut.
> 
> So this example isn't a good one IMO.  That clearly is a case when two
> (or more) devices share power resources controlled by a single on/off
> switch.  Which is a clear use case for a PM domain.

TBH, I've never understood how a PM domain is supposed to solve this.
When power is cut at runtime for a struct dev_pm_domain, all devices
that were assigned this PM domain with dev_pm_domain_set() need to be
runtime suspended.  This requires that a list of devices is maintained
which were assigned the same PM domain, and that the PM domain's
->runtime_suspend hook isn't executed before all of these devices have
runtime_suspended.  Maybe I'm missing something but I don't see any code
to guarantee that in drivers/base/power/.  Rather, the PM domain's
->runtime_suspend hook is executed as soon as one of the devices in the
PM domain runtime suspends, *without* taking into consideration the
other devices in the PM domain.  They'll just be hanging in the air
with their device powered down.

>From what I've seen, people simply use struct dev_pm_domain as a way to
override the bus callbacks.  At least that's what Dave Airlie does in
vga_switcheroo.  But fundamentally that has nothing to do with shared
power resources, it only has to do with enforcing a different behaviour
than the bus.

Thus I don't understand what you mean if you say this is a use case for
a PM domain.


> > I'm sure there are situations where a driver presence dependency
> > is needed between parent/child and you should fully expect that
> > developers will try to employ device links for these use cases.
> > Which means that the code for suspend/resume device ordering is
> > executed twice.
> 
> Creating a link between a parent and child would be a bug.  I guess
> device_link_add() should just return NULL on an attempt to do that.

To be clear, while linking a parent (as consumer) to a child
(as supplier) needs to be prevented since it introduces a dependency
loop, the converse should IMO be allowed.

That would be the case when someone needs a driver presence dependency,
but doesn't need a suspend/resume ordering dependency (because it's
already guaranteed by the PM core for parent/child).  In that case the
child will simultaneously be a consumer, which means e.g. that dpm_wait()
will be executed twice for the same device, but that overhead is probably
negligible.

Thanks,

Lukas
