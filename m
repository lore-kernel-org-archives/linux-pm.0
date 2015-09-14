From: "Jon Medhurst (Tixy)" <tixy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/5] Documentation: add DT bindings for ARM SCPI
 sensors
Date: Mon, 14 Sep 2015 18:18:12 +0100
Message-ID: <1442251092.2850.53.camel@linaro.org>
References: <1442235619-4029-1-git-send-email-punit.agrawal@arm.com>
	 <1442235619-4029-2-git-send-email-punit.agrawal@arm.com>
	 <20150914131448.GC7002@leverpostej>
	 <9hhh9mxf7lg.fsf@e105922-lin.cambridge.arm.com>
	 <20150914134949.GE7002@leverpostej>
	 <9hhk2rtdq1f.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9hhk2rtdq1f.fsf-Z9gB6HwUD+TZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org" <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2015-09-14 at 15:38 +0100, Punit Agrawal wrote:
> Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> writes:
> 
> >> >> +Sensor bindings for the sensors based on SCPI Message Protocol
> >> >> +--------------------------------------------------------------
> >> >> +SCPI provides an API to access the various sensors on the SoC.
> >> >> +
> >> >> +Required properties:
> >> >> +- compatible : should be "arm,scpi-sensors".
> >> >> +- #thermal-sensor-cells: should be set to 1. This property follows the
> >> >> +			 thermal device tree bindings[2].
> >> >
> >> > You need to specify what the valid values for this cell are.
> >> 
> >> The enumeration depends on the number of sensors exported by SCP
> >> firmware - which is platform dependent. I could add add something like
> >> if you think that is helpful -
> >> 
> >> "Valid cell value is a number between 0..n-1, where n is the number
> >> of sensors exported by SCP firmware."
> >
> > Can the FW identifer space have holes? Or are they always contiguous?
> 
> The way the SCP interface is defined, the sensor identifiers are
> contiguous,

Is there any documentation other than DUI0922A? [1] From what I can seen
that just says it's a 16-bit value and doesn't put any particular
constraints on its value.

[1] http://community.arm.com/servlet/JiveServlet/download/8401-40-18262/DUI0922A_scp_message_interface.pdf

-- 
Tixy

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
