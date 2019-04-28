From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH 2/3] power: supply: Add driver for Microchip UCS1002
Date: Sun, 28 Apr 2019 15:24:39 -0700
Message-ID: <CAHQ1cqExxTYtkmHyL7cCQMjnX+6B0jC7VmtX4w+8tZNShDGj2g@mail.gmail.com>
References: <20190417084457.28747-1-andrew.smirnov@gmail.com>
 <20190417084457.28747-3-andrew.smirnov@gmail.com> <1556289824.2584.36.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556289824.2584.36.camel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Chris Health <cphealy@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 26, 2019 at 7:43 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Hi Andrey,
>
> Am Mittwoch, den 17.04.2019, 01:44 -0700 schrieb Andrey Smirnov:
> > Add driver for Microchip UCS1002 Programmable USB Port Power
> > Controller with Charger Emulation. The driver exposed a power supply
> > device to control/monitor various parameter of the device as well as a
> > regulator to allow controlling VBUS line.
> >
> > > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > > Cc: Chris Health <cphealy@gmail.com>
> > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > Cc: Guenter Roeck <linux@roeck-us.net>
> > > Cc: Sebastian Reichel <sre@kernel.org>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > ---
> [...]
> > +     if (irq_a_det > 0) {
> > > +           ret = devm_request_threaded_irq(dev, irq_a_det, NULL,
> > > +                                           ucs1002_charger_irq,
> > > +                                           IRQF_TRIGGER_FALLING |
> > > +                                           IRQF_TRIGGER_RISING |
> > > +                                           IRQF_ONESHOT,
> > > +                                           "ucs1002-a_det", info);
> > > +           if (ret) {
> > > +                   dev_err(dev, "failed to request A_DET threaded irq\n");
> > > +                   return ret;
> > > +           }
> > > +   }
> > +
> > > +   if (irq_alert > 0) {
> > > +           ret = devm_request_threaded_irq(dev, irq_alert, NULL,
> > > +                                           ucs1002_alert_irq,
> > > +                                           IRQF_TRIGGER_FALLING |
> > > +                                           IRQF_TRIGGER_RISING |
> > > +                                           IRQF_ONESHOT,
> > > +                                           "ucs1002-alert", info);
> > > +           if (ret) {
> > > +                   dev_err(dev, "failed to request ALERT threaded irq\n");
> > > +                   return ret;
> > > +           }
> > > +   }
>
> Any reason to explicitly set the IRQ trigger type here? Normally I
> would expect this to be set via the DT interrupt specifier.
>

Don't have a particular reason. I'll move it to DT.

Thanks,
Andrey Smirnov
