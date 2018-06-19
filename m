From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v3 12/12] mfd: cros_ec: Add throttler sub-device
Date: Tue, 19 Jun 2018 10:43:36 -0700
Message-ID: <20180619174336.GY88063@google.com>
References: <20180614194712.102134-1-mka@chromium.org>
 <20180614194712.102134-13-mka@chromium.org>
 <20180618232109.GB154056@rodete-desktop-imager.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180618232109.GB154056@rodete-desktop-imager.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 18, 2018 at 04:21:10PM -0700, Brian Norris wrote:
> Hi,
> 
> On Thu, Jun 14, 2018 at 12:47:12PM -0700, Matthias Kaehlcke wrote:
> > Instantiate the CrOS EC throttler if it is enabled in the kernel
> > configuration.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Changes in v3:
> > - patch added to series
> > 
> >  drivers/mfd/cros_ec.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> > index 36156a41499c..5f52b6e2c21a 100644
> > --- a/drivers/mfd/cros_ec.c
> > +++ b/drivers/mfd/cros_ec.c
> > @@ -91,6 +91,10 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
> >  	return cros_ec_cmd_xfer(ec_dev, &buf.msg);
> >  }
> >  
> > +static const struct mfd_cell ec_throttler_cell = {
> > +	.name = "cros-ec-throttler",
> > +};
> > +
> >  int cros_ec_register(struct cros_ec_device *ec_dev)
> >  {
> >  	struct device *dev = ec_dev->dev;
> > @@ -153,6 +157,18 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
> >  		}
> >  	}
> >  
> > +	if (IS_ENABLED(CONFIG_CROS_EC_THROTTLER)) {
> > +		err = mfd_add_devices(ec_dev->dev, PLATFORM_DEVID_AUTO,
> > +				      &ec_throttler_cell, 1, NULL, ec_dev->irq,
> > +				      NULL);
> 
> Most of this similar sub-device registration seems to have moved to
> cros_ec_dev.c, in ec_device_probe(). Should this do the same?

Not sure about this, the only device that is registered in
ec_device_probe() are the sensors.

I cc-ed Benson and Olof, the maintainers of CrOS platform stuff,
maybe they can help to clarify what the preference is and why.

> And on a similar note: is there a way to determine EC support for this
> feature (e.g., EC_FEATURE_*)? Or do we just have to listen for
> appropriate throttling events that may never come?

To my knowledge there is no such way as of now. There is no
EC_FEATURE_* for throttling support
(https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h#1174).
though we could probably add one.

> Also, is this very useful on non-DT systems? Does this fail gracefully?

It is not useful on non-DT systems, however the throttler core has a
dependency on CONFIG_OF, so the device wouldn't be added.
