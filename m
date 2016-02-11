From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Prevent runtime suspend during adapter
 registration
Date: Thu, 11 Feb 2016 16:47:05 +0200
Message-ID: <20160211144705.GW16826@lahna.fi.intel.com>
References: <1455201363-3278-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455201363-3278-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 11, 2016 at 04:36:03PM +0200, Jarkko Nikula wrote:
> There can be unnecessary runtime suspend-resume cycle during
> i2c-designware-platdrv probe when it registers the I2C adapter device. This
> happens because i2c-designware-platdrv is set to initially active platform
> device in its probe function and is a parent of I2C adapter.
> 
> In that case power.usage_count of i2c-designware device is zero and
> pm_runtime_get()/pm_runtime_put() cycle during probe could put it into
> runtime suspend. This happens when the i2c_register_adapter() calls the
> device_register():
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
> After that the i2c_register_adapter() continues registering I2C slave
> devices. In case slave device probe does I2C transfers the parent will
> resume again and thus get a needless runtime suspend/resume cycle during
> adapter registration.
> 
> Prevent this while retaining the runtime PM status of i2c-designware by
> only incrementing/decrementing device power usage count during I2C
> adapter registration. That makes sure there won't be spurious runtime PM
> status changes and lets the driver core to idle the device after probe
> finishes.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

I don't know any better way to fix this,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
