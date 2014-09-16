From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH RESEND] thermal: Add QPNP PMIC temperature alarm driver
Date: Tue, 16 Sep 2014 10:46:29 +0300
Message-ID: <1410853589.30351.12.camel@iivanov-dev>
References: <1410793383-30097-1-git-send-email-iivanov@mm-sol.com>
	 <20140915153052.GB27076@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140915153052.GB27076@developer>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, David Collins <collinsd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org


Hi, 

On Mon, 2014-09-15 at 11:30 -0400, Eduardo Valentin wrote:
> Hey Ivan,
> 
> Please give us at least a two weeks time frame before resending your
> patches.
> 

Sure, I just wanted to add MSM mail list, sorry.

> > +
> > +Optional properties:
> > +- label:           A string used as a descriptive name for this thermal
> > +                   device. This name should be 19 characters or less.
> 
> This is a driver specific property and must be properly named as such.
> Please read the the DT documentation.

I believe that it is standard property. Section 6.1.2.3 label. I could
drop this property. Node name should be enough descriptive, already.

> 
> More specifically, we already have standardized and discussed way of
> describing thermal zones in DT, including their names. Please read
> Documentation/devicetree/bindings/thermal/thermal.txt 
> 
> > +- io-channels:     Should contain IIO channel specifier
> > +- io-channel-names: "thermal". The ADC channel for temperature reading.
> > +
> > +Example:
> > +
> > +	thermal-alarm@2400 {
> > +		compatible = "qcom,qpnp-temp-alarm";
> > +		reg = <0x2400>;
> > +		interrupts = <0 0x24 0 IRQ_TYPE_EDGE_RISING>;
> > +		label = "pm8941_tz";
> > +		io-channels = <&pm8941_vadc VADC_DIE_TEMP>;
> > +		io-channel-names = "thermal";
> > +	};

<snip>

> > +++ b/drivers/thermal/qpnp-temp-alarm.c
> > @@ -0,0 +1,519 @@
> > +/*
> > + * Copyright (c) 2011-2014, The Linux Foundation. All rights reserved.
> > + *
> 
> Is it really the Linux Foundation? Or would it be QC/Codeaurora copyrights here?

Yes, it is Linux Foundation. Downstream driver on this which driver is
based is also Linux Foundation copyrighted.

<snip>

> > +
> > +	rc = devm_request_irq(chip->dev, chip->irq, qpnp_tm_isr,
> > +			      IRQF_TRIGGER_RISING, chip->tm_name, chip);
> > +	if (rc < 0)
> > +		thermal_zone_device_unregister(chip->tz_dev);
> > +
> 
> This thermal driver does not bind to any cooling device?

This driver monitor temperature of the external PMIC chip, accessed over
SPMI bus. I am not aware of way how to cool this chip.

> 
> > +	return rc;
> > +}
> > +

Regards,
Ivan
