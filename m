From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 1/5] Documentation: add DT bindings for ARM SCPI
 sensors
Date: Mon, 14 Sep 2015 14:49:49 +0100
Message-ID: <20150914134949.GE7002@leverpostej>
References: <1442235619-4029-1-git-send-email-punit.agrawal@arm.com>
 <1442235619-4029-2-git-send-email-punit.agrawal@arm.com>
 <20150914131448.GC7002@leverpostej>
 <9hhh9mxf7lg.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9hhh9mxf7lg.fsf@e105922-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Liviu Dudau <Liviu.Dudau@arm.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>
List-Id: linux-pm@vger.kernel.org

> >> +Sensor bindings for the sensors based on SCPI Message Protocol
> >> +--------------------------------------------------------------
> >> +SCPI provides an API to access the various sensors on the SoC.
> >> +
> >> +Required properties:
> >> +- compatible : should be "arm,scpi-sensors".
> >> +- #thermal-sensor-cells: should be set to 1. This property follows the
> >> +			 thermal device tree bindings[2].
> >
> > You need to specify what the valid values for this cell are.
> 
> The enumeration depends on the number of sensors exported by SCP
> firmware - which is platform dependent. I could add add something like
> if you think that is helpful -
> 
> "Valid cell value is a number between 0..n-1, where n is the number
> of sensors exported by SCP firmware."

Can the FW identifer space have holes? Or are they always contiguous?

If this is the same as the raw FW identifer value, specify that.
Otherwise, you need to specify the mapping.

There needs to be enough information for a dts author to figure out
which values to place in the DT.

Thanks,
Mark.
