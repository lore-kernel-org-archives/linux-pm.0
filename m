From: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 1/5] Documentation: add DT bindings for ARM SCPI sensors
Date: Mon, 14 Sep 2015 16:01:09 +0100
Message-ID: <9hhfv2hdozu.fsf@e105922-lin.cambridge.arm.com>
References: <1442235619-4029-1-git-send-email-punit.agrawal@arm.com>
	<1442235619-4029-2-git-send-email-punit.agrawal@arm.com>
	<20150914131448.GC7002@leverpostej>
	<9hhh9mxf7lg.fsf@e105922-lin.cambridge.arm.com>
	<20150914134949.GE7002@leverpostej>
	<9hhk2rtdq1f.fsf@e105922-lin.cambridge.arm.com>
	<20150914144330.GH7002@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150914144330.GH7002@leverpostej> (Mark Rutland's message of
	"Mon, 14 Sep 2015 15:43:30 +0100")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree@vger.kernel.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>, "linux-pm@vger.kernel.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors@lm-sensors.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>, "edubezval@gmail.com" <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux@roeck-us.net" <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "linux-kernel@vger.kernel.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "robh+dt@kernel.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> writes:

> On Mon, Sep 14, 2015 at 03:38:36PM +0100, Punit Agrawal wrote:
>> Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> writes:
>> 
>> >> >> +Sensor bindings for the sensors based on SCPI Message Protocol
>> >> >> +--------------------------------------------------------------
>> >> >> +SCPI provides an API to access the various sensors on the SoC.
>> >> >> +
>> >> >> +Required properties:
>> >> >> +- compatible : should be "arm,scpi-sensors".
>> >> >> +- #thermal-sensor-cells: should be set to 1. This property follows the
>> >> >> +			 thermal device tree bindings[2].
>> >> >
>> >> > You need to specify what the valid values for this cell are.
>> >> 
>> >> The enumeration depends on the number of sensors exported by SCP
>> >> firmware - which is platform dependent. I could add add something like
>> >> if you think that is helpful -
>> >> 
>> >> "Valid cell value is a number between 0..n-1, where n is the number
>> >> of sensors exported by SCP firmware."
>> >
>> > Can the FW identifer space have holes? Or are they always contiguous?
>> 
>> The way the SCP interface is defined, the sensor identifiers are
>> contiguous, but not all are temperature sensors.
>
> Ok. So how exactly are they enumerated for this binding?

The sensor enumeration for r0 (which I've verified) and r1 can be found
at [0]. The valid cell values are identifiers for the temperature sensors.

>
>> > If this is the same as the raw FW identifer value, specify that.
>> > Otherwise, you need to specify the mapping.
>> 
>> I'll update the patch to add mappings for Juno r0 (and r1 if I can get
>> my hands on one).
>
> If there's identical logic mapping the two, we might just be able to
> describe that rather than having to add tables all the time.
>

After seeing the mapping already published, I am wondering if there is
any value in duplicating the information. If there are no objections,
I'll update this patch to add pointers instead.

>> > There needs to be enough information for a dts author to figure out
>> > which values to place in the DT.
>> 
>> I understand. Except sometimes it is hard to get the firmware to commit to not
>> modify the ordering - discoverability and all that. :)
>
> If they do that, then things are broken regardless, no? I guess that'll
> be clear if/when I see how the mapping works.

[0] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0922b/apas03s22.html

>
> Thanks,
> Mark.
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
