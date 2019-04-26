From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 2/3] power: supply: Add driver for Microchip UCS1002
Date: Fri, 26 Apr 2019 16:43:44 +0200
Message-ID: <1556289824.2584.36.camel@pengutronix.de>
References: <20190417084457.28747-1-andrew.smirnov@gmail.com>
         <20190417084457.28747-3-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190417084457.28747-3-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc: Chris Health <cphealy@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Andrey,

Am Mittwoch, den 17.04.2019, 01:44 -0700 schrieb Andrey Smirnov:
> Add driver for Microchip UCS1002 Programmable USB Port Power
> Controller with Charger Emulation. The driver exposed a power supply
> device to control/monitor various parameter of the device as well as a
> regulator to allow controlling VBUS line.
> 
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Chris Health <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> ---
[...]
> +	if (irq_a_det > 0) {
> > +		ret = devm_request_threaded_irq(dev, irq_a_det, NULL,
> > +						ucs1002_charger_irq,
> > +						IRQF_TRIGGER_FALLING |
> > +						IRQF_TRIGGER_RISING |
> > +						IRQF_ONESHOT,
> > +						"ucs1002-a_det", info);
> > +		if (ret) {
> > +			dev_err(dev, "failed to request A_DET threaded irq\n");
> > +			return ret;
> > +		}
> > +	}
> +
> > +	if (irq_alert > 0) {
> > +		ret = devm_request_threaded_irq(dev, irq_alert, NULL,
> > +						ucs1002_alert_irq,
> > +						IRQF_TRIGGER_FALLING |
> > +						IRQF_TRIGGER_RISING |
> > +						IRQF_ONESHOT,
> > +						"ucs1002-alert", info);
> > +		if (ret) {
> > +			dev_err(dev, "failed to request ALERT threaded irq\n");
> > +			return ret;
> > +		}
> > +	}

Any reason to explicitly set the IRQ trigger type here? Normally I
would expect this to be set via the DT interrupt specifier.

Regards,
Lucas
