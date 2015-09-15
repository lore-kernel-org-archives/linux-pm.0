From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH v3 1/5] Documentation: add DT bindings for ARM SCPI sensors
Date: Tue, 15 Sep 2015 10:37:39 +0100
Message-ID: <9hhy4g89g64.fsf@e105922-lin.cambridge.arm.com>
References: <1442235619-4029-1-git-send-email-punit.agrawal@arm.com>
	<1442235619-4029-2-git-send-email-punit.agrawal@arm.com>
	<20150914131448.GC7002@leverpostej>
	<9hhh9mxf7lg.fsf@e105922-lin.cambridge.arm.com>
	<20150914134949.GE7002@leverpostej>
	<9hhk2rtdq1f.fsf@e105922-lin.cambridge.arm.com>
	<1442251092.2850.53.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442251092.2850.53.camel@linaro.org> (Jon Medhurst's message of
	"Mon, 14 Sep 2015 18:18:12 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Liviu Dudau <Liviu.Dudau@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "linux@roeck-us.net" <linux@roeck-us.net>, Sudeep Holla <Sudeep.Holla@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

"Jon Medhurst (Tixy)" <tixy@linaro.org> writes:

> On Mon, 2015-09-14 at 15:38 +0100, Punit Agrawal wrote:
>> Mark Rutland <mark.rutland@arm.com> writes:
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
>> contiguous,
>
> Is there any documentation other than DUI0922A? [1] From what I can seen
> that just says it's a 16-bit value and doesn't put any particular
> constraints on its value.

Although not explicitly stated, if you look at the Get Sensor Capability
[2] and Get Sensor Info [3] commands you can indirectly infer that the
Sensor IDs are contiguous. Not the strongest guarantee I know.

All platforms currently using SCP (Juno R0 and R1) do indeed expose
contiguous identifiers. Maybe we can convince the authors to make it
explicit.

>
> [1] http://community.arm.com/servlet/JiveServlet/download/8401-40-18262/DUI0922A_scp_message_interface.pdf
[2] http://arminfo.emea.arm.com/help/index.jsp?topic=/com.arm.doc.dui0922b/ch03s02s21.html
[3] http://arminfo.emea.arm.com/help/index.jsp?topic=/com.arm.doc.dui0922b/BABCCCJJ.html
