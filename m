From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v3 12/12] mfd: cros_ec: Add throttler sub-device
Date: Tue, 19 Jun 2018 10:55:24 -0700
Message-ID: <20180619175524.GZ88063@google.com>
References: <20180614194712.102134-1-mka@chromium.org>
 <20180614194712.102134-13-mka@chromium.org>
 <20180618232109.GB154056@rodete-desktop-imager.corp.google.com>
 <CAFqH_520Z4nAkXsnKeO9ZGqSSfPg_7f7pjJs=t=ryQTBExfwoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFqH_520Z4nAkXsnKeO9ZGqSSfPg_7f7pjJs=t=ryQTBExfwoA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Brian Norris <briannorris@chromium.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, viresh.kumar@linaro.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Enric,

On Tue, Jun 19, 2018 at 10:41:01AM +0200, Enric Balletbo Serra wrote:
> Hi Matthias,
> 
> I am also interested on the answer of Brian comments :). One small comment.
> 
> Missatge de Brian Norris <briannorris@chromium.org> del dia dt., 19 de
> juny 2018 a les 1:22:
> >
> > Hi,
> >
> > On Thu, Jun 14, 2018 at 12:47:12PM -0700, Matthias Kaehlcke wrote:
> > > Instantiate the CrOS EC throttler if it is enabled in the kernel
> > > configuration.
> > >
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > > Changes in v3:
> > > - patch added to series
> > >
> > >  drivers/mfd/cros_ec.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> > > index 36156a41499c..5f52b6e2c21a 100644
> > > --- a/drivers/mfd/cros_ec.c
> > > +++ b/drivers/mfd/cros_ec.c
> > > @@ -91,6 +91,10 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
> > >       return cros_ec_cmd_xfer(ec_dev, &buf.msg);
> > >  }
> > >
> > > +static const struct mfd_cell ec_throttler_cell = {
> > > +     { .name = "cros-ec-throttler" }
> > > +};
> > > +
> 
> As Brian said I think that this should go in cros_ec_dev?

Not sure about this, see my reply to Brian.

> Even when only there is one cell we tend to use the array format (see
> i.e the cros-ec-rtc and the others in cros_ec_dev).
> 
> +static const struct mfd_cell ec_throttler_cells[] = {
> +     { .name = "cros-ec-throttler" }
> +};

Ok, will change.

> > >  int cros_ec_register(struct cros_ec_device *ec_dev)
> > >  {
> > >       struct device *dev = ec_dev->dev;
> > > @@ -153,6 +157,18 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
> > >               }
> > >       }
> > >
> > > +     if (IS_ENABLED(CONFIG_CROS_EC_THROTTLER)) {
> > > +             err = mfd_add_devices(ec_dev->dev, PLATFORM_DEVID_AUTO,
> > > +                                   &ec_throttler_cell, 1, NULL, ec_dev->irq,
> 
> ARRAY_SIZE(ec_throttler_cells)

Ack

Thanks

Matthias
