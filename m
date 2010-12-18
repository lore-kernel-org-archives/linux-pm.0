From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: platform/i2c busses: pm runtime and system sleep
Date: Sat, 18 Dec 2010 01:04:54 +0000
Message-ID: <20101218010454.GA2430__40566.0216034905$1292634346$gmane$org@opensource.wolfsonmicro.com>
References: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx@mail.gmail.com>
	<201012171449.26082.rjw@sisk.pl>
	<20101217142402.GA19391@rakim.wolfsonmicro.main>
	<201012180001.25263.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201012180001.25263.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Dec 18, 2010 at 12:01:25AM +0100, Rafael J. Wysocki wrote:
> On Friday, December 17, 2010, Mark Brown wrote:

> > 	if (pm) {
> > 		if (pm_runtime_suspended(dev))
> > 			return 0;
> > 		else
> > 			return pm->suspend ? pm->suspend(dev) : 0;
> > 	}

> > 	return i2c_legacy_suspend(dev, PMSG_SUSPEND);
> > }

> > Ideally the if (pm) block could just be factored out into the pm core as
> > there's nothing I2C-specific about that at all.  Possibly even the whole
> > logic surrounding fall back to legacy, though that smells a bit.

> No, the legacy is i2c-specific.

SPI and platform (the first two buses I looked at) both seem to have
legacy suspend operations too?  Clearly the bus would need to provide an
op to invoke the legacy call but the logic which prioritises the pm_ops
over the legacy operation is generic.

> > The generic suspend operation doesn't fit here:

> > int pm_generic_suspend(struct device *dev)
> > {
> > 	return __pm_generic_call(dev, PM_EVENT_SUSPEND);
> > }
> > EXPORT_SYMBOL_GPL(pm_generic_suspend);

> Well, looking at __pm_generic_call(), I think it does.

> It appears to do exactly what the pm block above does, so it should be possible
> to have something like this:

Oh, so it does.

> static int i2c_device_pm_suspend(struct device *dev)
> {
> 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> 	return pm ? pm_generic_suspend(dev) : i2c_legacy_suspend(dev, PMSG_SUSPEND);
> }

> if I'm not missing anything.

Yes, I think that should work - thanks.  A similar thing would work for
the default platform bus implementation, too, and bring it into line
with I2C here.  I'll have a play.  Similarly for SPI.
