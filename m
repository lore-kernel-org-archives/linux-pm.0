From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 1/5] Documentation: add DT bindings for ARM SCPI
 sensors
Date: Mon, 14 Sep 2015 16:15:40 +0100
Message-ID: <20150914151540.GI7002@leverpostej>
References: <1442235619-4029-1-git-send-email-punit.agrawal@arm.com>
 <1442235619-4029-2-git-send-email-punit.agrawal@arm.com>
 <20150914131448.GC7002@leverpostej>
 <9hhh9mxf7lg.fsf@e105922-lin.cambridge.arm.com>
 <20150914134949.GE7002@leverpostej>
 <9hhk2rtdq1f.fsf@e105922-lin.cambridge.arm.com>
 <20150914144330.GH7002@leverpostej>
 <9hhfv2hdozu.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9hhfv2hdozu.fsf@e105922-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Liviu Dudau <Liviu.Dudau@arm.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 14, 2015 at 04:01:09PM +0100, Punit Agrawal wrote:
> Mark Rutland <mark.rutland@arm.com> writes:
> 
> > On Mon, Sep 14, 2015 at 03:38:36PM +0100, Punit Agrawal wrote:
> >> Mark Rutland <mark.rutland@arm.com> writes:
> >> 
> >> >> >> +Sensor bindings for the sensors based on SCPI Message Protocol
> >> >> >> +--------------------------------------------------------------
> >> >> >> +SCPI provides an API to access the various sensors on the SoC.
> >> >> >> +
> >> >> >> +Required properties:
> >> >> >> +- compatible : should be "arm,scpi-sensors".
> >> >> >> +- #thermal-sensor-cells: should be set to 1. This property follows the
> >> >> >> +			 thermal device tree bindings[2].
> >> >> >
> >> >> > You need to specify what the valid values for this cell are.
> >> >> 
> >> >> The enumeration depends on the number of sensors exported by SCP
> >> >> firmware - which is platform dependent. I could add add something like
> >> >> if you think that is helpful -
> >> >> 
> >> >> "Valid cell value is a number between 0..n-1, where n is the number
> >> >> of sensors exported by SCP firmware."
> >> >
> >> > Can the FW identifer space have holes? Or are they always contiguous?
> >> 
> >> The way the SCP interface is defined, the sensor identifiers are
> >> contiguous, but not all are temperature sensors.
> >
> > Ok. So how exactly are they enumerated for this binding?
> 
> The sensor enumeration for r0 (which I've verified) and r1 can be found
> at [0]. The valid cell values are identifiers for the temperature sensors.

Ok. That's fine by me; I was confused and thought that there was some
internal mapping.

> >> > If this is the same as the raw FW identifer value, specify that.
> >> > Otherwise, you need to specify the mapping.
> >> 
> >> I'll update the patch to add mappings for Juno r0 (and r1 if I can get
> >> my hands on one).
> >
> > If there's identical logic mapping the two, we might just be able to
> > describe that rather than having to add tables all the time.
> >
> 
> After seeing the mapping already published, I am wondering if there is
> any value in duplicating the information. If there are no objections,
> I'll update this patch to add pointers instead.

That's fine by me. The important part is that the value is a raw Sensor
ID as the FW uses. So long as we state that, the IDs themselves can come
from whatever documentation is valid for a particular instance.

Thanks for the info!

Thanks,
Mark.
