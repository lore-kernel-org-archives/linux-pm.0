From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 8/8] mfd: Add support for Intel Sunrisepoint LPSS
 devices
Date: Wed, 27 May 2015 13:41:02 +0300
Message-ID: <20150527104102.GF1747@lahna.fi.intel.com>
References: <1432570172-86963-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1432570172-86963-9-git-send-email-andriy.shevchenko@linux.intel.com>
 <20150527102241.GC11677@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150527102241.GC11677@x1>
Sender: linux-acpi-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, May 27, 2015 at 11:22:41AM +0100, Lee Jones wrote:
> > +static int resume_lpss_device(struct device *dev, void *data)
> > +{
> > +	pm_runtime_resume(dev);
> > +	return 0;
> > +}
> > +
> > +int intel_lpss_prepare(struct device *dev)
> > +{
> > +	/*
> > +	 * Resume both child devices before entering system sleep. This
> > +	 * ensures that they are in proper state before they get suspended.
> > +	 */
> > +	device_for_each_child_reverse(dev, NULL, resume_lpss_device);
> 
> Why can't you do this in intel_lpss_suspend()?
> 
> Then you can get rid of all the hand-rolled nonsense you have in the
> header file and use SET_SYSTEM_SLEEP_PM_OPS instead.
> 
> Does something happen after .prepare() and before .suspend() that
> prevents this from working?

At that time all children are already suspended (to system sleep) so we
cannot bring them out of runtime suspend anymore.

.prepare() is executed for all devices before suspend callbacks for
each device.
