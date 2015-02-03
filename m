From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH v4] thermal: Add QPNP PMIC temperature alarm driver
Date: Tue, 03 Feb 2015 10:31:15 +0200
Message-ID: <1422952275.2177.29.camel@mm-sol.com>
References: <1422890370-6914-1-git-send-email-iivanov@mm-sol.com>
	 <54CF99E9.10305@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54CF99E9.10305@mm-sol.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, David Collins <collinsd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org


On Mon, 2015-02-02 at 17:38 +0200, Stanimir Varbanov wrote:
> 
> > +
> > +       chip->tz_dev = thermal_zone_of_sensor_register(&pdev->dev, 0, chip,
> > +                                                       &qpnp_tm_sensor_ops);
> > +       if (IS_ERR(chip->tz_dev)) {
> > +               dev_err(&pdev->dev, "failed to register sensor\n");
> > +               ret = PTR_ERR(chip->tz_dev);
> > +               goto fail;
> > +       }
> > +
> > +       ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, qpnp_tm_isr,
> > +                                       IRQF_ONESHOT, node->name, chip);
> > +       if (ret < 0)
> > +               goto unreg;
> > +
> > +       return 0;
> > +
> > +unreg:
> > +       thermal_zone_of_sensor_unregister(&pdev->dev, chip->tz_dev);
> 
> Any problem to request_irq before thermal_zone_of_sensor_register? It
> will avoid having thermal sensor unregister call.

Right, will reorder the calls. 

Ivan

> 
> > +fail:
> > +       if (!IS_ERR(chip->adc))
> > +               iio_channel_release(chip->adc);
> > +
> > +       return ret;
> > +}
> 
> <snip>
> 
> 
