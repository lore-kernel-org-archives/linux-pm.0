From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] i2c: Prevent runtime suspend of parent during adapter
 registration
Date: Tue, 15 Dec 2015 10:21:06 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1512151016130.1891-100000@iolanthe.rowland.org>
References: <1450181576-878-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1450181576-878-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 15 Dec 2015, Jarkko Nikula wrote:

> If runtime PM of parent device is enabled before it registers the I2C
> adapter there can be unnecessary runtime suspend during adapter device
> registration. This can happen when adapter is registered from parent's
> probe and if parent device is initially active platform device.
> 
> In that case power.usage_count of parent device is zero and
> pm_runtime_get()/pm_runtime_put() cycle during probe could put the
> parent into runtime suspend. This happens when the i2c_register_adapter()
> calls the device_register():
> 
> i2c_register_adapter
>   device_register
>     device_add
>       bus_probe_device
>         device_initial_probe
>           __device_attach
>             if (dev->parent) pm_runtime_get_sync(dev->parent)
>             ...
>             if (dev->parent) pm_runtime_put(dev->parent)
> 
> After that i2c_register_adapter() continues registering I2C slave
> devices. In case slave device probe does I2C transfers the parent will
> resume again and thus get a needless runtime suspend/resume cycle during
> adapter registration.
> 
> Prevent this while retaining the runtime PM status of parent by only
> incrementing/decrementing parent device power usage count during I2C
> adapter registration. That makes sure there won't be spurious runtime PM
> status changes for parent's probe and lets the driver core to idle the
> device after probe finishes.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> I noticed this with i2c-designware-platdrv.c which started to do so
> after commit 36d48fb5766a ("i2c: designware-platdrv: enable RuntimePM
> before registering to the core"). I guess the same could happen also
> with a few other I2C drivers that enable runtime PM similar way. For
> instance i2c-at91.c, i2c-cadence.c, i2c-hix5hd2.c and i2c-qup.c.
> That made me thinking if issue might be best to handle in i2c-core.c.
> 
> Device core drivers/base/dd.c: driver_probe_device() or
> drivers/base/platform.c: platform_drv_probe() could be other
> alternatives but that would cause a regression to a driver that
> purposively tries to suspend the device in its probe().

This isn't how the problem is handled in other places.  In all the 
cases I know about, the parent's subsystem or driver makes sure that 
the parent will not go into runtime suspend while it is being probed.  
At the very least, it should insure that the parent will not go into 
runtime suspend while it is registering a child device (which 
typically happens within a probe routine).

In general, it's bad form to do pm_runtime_get/put calls on your parent 
-- you should make changes only to the device you're responsible for.

Alan Stern
