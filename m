From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v2 09/11] misc: throttler: Add core support for
 non-thermal throttling
Date: Tue, 12 Jun 2018 18:48:08 -0700
Message-ID: <20180613014808.GJ88063@google.com>
References: <20180607181214.30338-1-mka@chromium.org>
 <20180607181214.30338-10-mka@chromium.org>
 <20180612014911.GA35749@rodete-desktop-imager.corp.google.com>
 <20180612171140.GH88063@google.com>
 <20180612200012.GA99983@rodete-desktop-imager.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180612200012.GA99983@rodete-desktop-imager.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 12, 2018 at 01:00:14PM -0700, Brian Norris wrote:
> Hi,
> 
> On Tue, Jun 12, 2018 at 10:11:40AM -0700, Matthias Kaehlcke wrote:
> > On Mon, Jun 11, 2018 at 06:49:13PM -0700, Brian Norris wrote:
> > > On Thu, Jun 07, 2018 at 11:12:12AM -0700, Matthias Kaehlcke wrote:
> > > > The purpose of the throttler is to provide support for non-thermal
> > > > throttling. Throttling is triggered by external event, e.g. the
> > > > detection of a high battery discharge current, close to the OCP limit
> > > > of the battery. The throttler is only in charge of the throttling, not
> > > > the monitoring, which is done by another (possibly platform specific)
> > > > driver.
> > > > 
> > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > ---
> > > > Changes in v2:
> > > > - completely reworked the driver to support configuration through OPPs, which
> > > >   requires a more dynamic handling
> > > > - added sysfs attribute to set the level for debugging and testing
> > > > - Makefile: depend on Kconfig option to traverse throttler directory
> > > > - Kconfig: removed 'default n'
> > > > - added SPDX line instead of license boiler-plate
> > > > - added entry to MAINTAINERS file
> > > > 
> > > > 
> > > >  MAINTAINERS                     |   7 +
> > > >  drivers/misc/Kconfig            |   1 +
> > > >  drivers/misc/Makefile           |   1 +
> > > >  drivers/misc/throttler/Kconfig  |  14 +
> > > >  drivers/misc/throttler/Makefile |   1 +
> > > >  drivers/misc/throttler/core.c   | 642 ++++++++++++++++++++++++++++++++
> > > >  include/linux/throttler.h       |  11 +
> > > >  7 files changed, 677 insertions(+)
> > > >  create mode 100644 drivers/misc/throttler/Kconfig
> > > >  create mode 100644 drivers/misc/throttler/Makefile
> > > >  create mode 100644 drivers/misc/throttler/core.c
> > > >  create mode 100644 include/linux/throttler.h
> > > > 
> 
> ...
> 
> > > > diff --git a/drivers/misc/throttler/Kconfig b/drivers/misc/throttler/Kconfig
> > > > new file mode 100644
> > > > index 000000000000..e561f1df5085
> > > > --- /dev/null
> > > > +++ b/drivers/misc/throttler/Kconfig
> > > > @@ -0,0 +1,14 @@
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +menuconfig THROTTLER
> > > > +	bool "Throttler support"
> > > > +	depends on OF
> > > > +	select CPU_FREQ
> > > > +	select PM_DEVFREQ
> > > 
> > > I'm curious whether we're actually truly compile-time dependent on
> > > {CPU,DEV}FREQ? It seems like those subsystems mostly stub out stuff so
> > > they fall back to no-ops if not built in.
> > >
> > > I know that's not very useful for your existing throttler, since it
> > > wouldn't be very effective if one or both were disabled.
> > 
> > The idea is not to depend on both options being enabled, since
> > throttling of one type might be all that is needed.
> 
> OK, then if you fix the build errors...don't do these 'select's here?

Ok, I'll remove them

> > As the build bot pointed out cpufreq doesn't stub out all functions.
> > Probably the cleanest way to work around this is to define a stub for
> > cpufreq_update_policy() in the throttler when CONFIG_CPU_FREQ is not
> > defined.
> 
> Might make sense.
> 
> Also, how is it that CONFIG_CPU_FREQ managed to not be defined, even
> though you 'select'ed it? Was the kbuild error on some oddball
> architecture that doesn't support CPU_FREQ?

The build error occured with 'openrisc', from a quick grep in
drivers/cpufreq it seems indeed that there is no driver for this
architecture.

> > > > diff --git a/drivers/misc/throttler/core.c b/drivers/misc/throttler/core.c
> > > > new file mode 100644
> > > > index 000000000000..15b50c111032
> > > > --- /dev/null
> > > > +++ b/drivers/misc/throttler/core.c
> > > > ...
> > > > +// #define DEBUG_THROTTLER
> > > 
> > > Did you mean to leave your debug code in? Seems like you have some
> > > related dead code under #ifdefs.
> > 
> > Yes, I left it in intentionally.
> > 
> > > (If you do want this, maybe it'd be better under debugfs, until somebody
> > > really wants to formalize and document it.)
> > 
> > Since it is code that is never enabled in an official kernel build I
> > found it simpler to use sysfs with a direct association with the
> > device, instead of having <debugfs>/throttler/<throttler_name>/level.
> > 
> > If folks have strong opinions about using debugfs or not having the
> > debug code at all I'm fine with changing/dropping it.
> 
> If you ever expect this to actually get merged, I'd think we should go
> with one way or the other. Dead code is not appreciated in mainline, so
> either make it something people can actually have a chance of using
> (e.g., a CONFIG_* option or debugfs), or else drop it.

Ok, will change to debugfs with CONFIG_* option.

> > > > +static int thr_init_freq_table(struct throttler *thr, struct device *opp_dev,
> > > > +			       struct thr_freq_table *ft)
> > > > +{
> > > > +	struct device_node *np_opp_desc, *np_opp;
> > > > +	int nchilds;
> > > > +	uint32_t *freqs;
> > > > +	int nfreqs = 0;
> > > > +	int err = 0;
> > > > +
> > > > +	np_opp_desc = dev_pm_opp_of_get_opp_desc_node(opp_dev);
> > > > +	if (!np_opp_desc)
> > > > +		return -EINVAL;
> > > > +
> > > > +	nchilds = of_get_child_count(np_opp_desc);
> > > > +	if (!nchilds) {
> > > > +		err = -EINVAL;
> > > > +		goto out_node_put;
> > > > +	}
> > > > +
> > > > +	freqs = kzalloc(nchilds * sizeof(uint32_t), GFP_KERNEL);
> > > > +	if (!freqs) {
> > > > +		err = -ENOMEM;
> > > > +		goto out_node_put;
> > > > +	}
> > > > +
> > > > +	/* determine which OPPs are used by this throttler (if any) */
> > > > +	for_each_child_of_node(np_opp_desc, np_opp) {
> > > > +		int num_thr;
> > > > +		int i;
> > > > +
> > > > +		num_thr = of_property_count_u32_elems(np_opp, "opp-throttlers");
> > > > +		if (num_thr < 0)
> > > > +			continue;
> > > > +
> > > > +		for (i = 0; i < num_thr; i++) {
> > > > +			struct device_node *np_thr;
> > > > +			struct platform_device *pdev;
> > > > +
> > > > +			np_thr = of_parse_phandle(np_opp, "opp-throttlers", i);
> > > > +			if (!np_thr) {
> > > > +				dev_err(thr->dev,
> > > > +					"failed to parse phandle %d: %s\n", i,
> > > > +					np_opp->full_name);
> > > > +				continue;
> > > > +			}
> > > > +
> > > > +			pdev = of_find_device_by_node(np_thr);
> > > > +			if (!pdev) {
> > > > +				dev_err(thr->dev,
> > > > +					"could not find throttler dev: %s\n",
> > > > +					 np_thr->full_name);
> > > > +				of_node_put(np_thr);
> > > > +				continue;
> > > > +			}
> > > > +
> > > > +			/* OPP is used by this throttler */
> > > > +			if (&pdev->dev == thr->dev) {
> > > 
> > > So you're assuming that all throttlers are platform devices? Seems
> > > slightly shaky; I could easily imagine a similar device that's a SPI or
> > > I2C device.
> > 
> > As of now that's the only existing throttler. Adding handling for
> > throttlers on other buses that might never be implemented seems
> > premature. If throttlers with other bus types are added the core
> > code can be extended to support this using
> > of_find_i2c_device_by_node(), of_find_spi_device_by_node(), etc
> 
> I suppose...but it feels like there should be a better way to do this
> that isn't specific to a particular bus.

There is actually a better option, I was so focussed on the
of_find_device_by_node() way that I didn't see the obvious solution
right away:

We can just check if 'np_thr == thr->dev->of_node' ...

Thanks for pushing me to give it another look!
