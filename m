From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v5 2/5] driver core: Functional dependencies tracking
 support
Date: Fri, 28 Oct 2016 11:57:05 +0200
Message-ID: <20161028095705.GA7959@wunner.de>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <13957403.ZrB4mMbICz@vostro.rjw.lan>
 <2715729.9U1nlcpFb3@vostro.rjw.lan>
 <20161026111902.GA6447@wunner.de>
 <20161027152551.GA15718@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161027152551.GA15718@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 27, 2016 at 05:25:51PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 26, 2016 at 01:19:02PM +0200, Lukas Wunner wrote:
> > On Mon, Oct 10, 2016 at 02:51:04PM +0200, Rafael J. Wysocki wrote:
> > > - Modify device_links_check_suppliers(), device_links_driver_bound(),
> > >   device_links_no_driver(), device_links_driver_cleanup(), device_links_busy(),
> > >   and device_links_unbind_consumers() to walk link lists under device_links_lock
> > >   (to make the new "driver presence tracking" mechanism work reliably).
> > 
> > This change might increase boot time if drivers return -EPROBE_DEFER.
> 
> "might"?  Please verify this before guessing....

I can't, my machine only uses device links for Thunderbolt hotplug ports,
and their driver (portdrv) doesn't use deferred probing.  I'm only aware
of a single device in my system whose driver causes others to defer
probing (apple-gmux), but they don't use device links, so the mutex is
only acquired very briefly because the supplier/consumer lists are empty,
hence the performance impact can't be measured on my system.  But the
situation may be different for Marek's or Hanjun's use cases. I'm not
familiar with their systems, hence the "might".


> And don't make this more complex than needed before actually determining
> a real issue.

As pointed out it currently *is* more complex than needed because the
device_link_state is dispensable.  The whole issue is moot with the
changes I suggested because the mutex would only have to be taken for
addition/deletion of device links, not when probing.

Thanks,

Lukas
