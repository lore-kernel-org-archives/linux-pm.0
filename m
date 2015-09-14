From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH v3 1/5] Documentation: add DT bindings for ARM SCPI sensors
Date: Mon, 14 Sep 2015 14:34:03 +0100
Message-ID: <9hhh9mxf7lg.fsf@e105922-lin.cambridge.arm.com>
References: <1442235619-4029-1-git-send-email-punit.agrawal@arm.com>
	<1442235619-4029-2-git-send-email-punit.agrawal@arm.com>
	<20150914131448.GC7002@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:56351 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751304AbbINNer (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2015 09:34:47 -0400
In-Reply-To: <20150914131448.GC7002@leverpostej> (Mark Rutland's message of
	"Mon, 14 Sep 2015 14:14:48 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Liviu Dudau <Liviu.Dudau@arm.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>

Hi Mark,

Thanks for taking a look.

Mark Rutland <mark.rutland@arm.com> writes:

> On Mon, Sep 14, 2015 at 02:00:14PM +0100, Punit Agrawal wrote:
>> The System Control Processor (SCP) provides access to SoC sensors via
>> the System Control and Power Interface (SCPI) Message Protocol. Add
>> bindings to allow probing of these sensors. Also support referencing
>> of the sensors for setting up thermal zones via the thermal DT
>> bindings.
>> 
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  Documentation/devicetree/bindings/arm/arm,scpi.txt | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/arm/arm,scpi.txt b/Documentation/devicetree/bindings/arm/arm,scpi.txt
>> index f002460..af66f7f 100644
>> --- a/Documentation/devicetree/bindings/arm/arm,scpi.txt
>> +++ b/Documentation/devicetree/bindings/arm/arm,scpi.txt
>> @@ -72,8 +72,18 @@ Required sub-node properties:
>>  - compatible : should be "arm,juno-scp-shmem" for Non-secure SRAM based
>>  	       shared memory on Juno platforms
>>  
>> +Sensor bindings for the sensors based on SCPI Message Protocol
>> +--------------------------------------------------------------
>> +SCPI provides an API to access the various sensors on the SoC.
>> +
>> +Required properties:
>> +- compatible : should be "arm,scpi-sensors".
>> +- #thermal-sensor-cells: should be set to 1. This property follows the
>> +			 thermal device tree bindings[2].
>
> You need to specify what the valid values for this cell are.

The enumeration depends on the number of sensors exported by SCP
firmware - which is platform dependent. I could add add something like
if you think that is helpful -

"Valid cell value is a number between 0..n-1, where n is the number
of sensors exported by SCP firmware."

Thanks,

Punit

>
> Mark.
>
>> +
>>  [0] http://infocenter.arm.com/help/topic/com.arm.doc.dui0922b/index.html
>>  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +[2] Documentation/devicetree/bindings/thermal/thermal.txt
>>  
>>  Example:
>>  
>> @@ -122,6 +132,11 @@ scpi_protocol: scpi@2e000000 {
>>  			clock-output-names = "pxlclk0", "pxlclk1";
>>  		};
>>  	};
>> +
>> +	scpi_sensors0: sensors {
>> +		compatible = "arm,scpi-sensors";
>> +		#thermal-sensor-cells = <1>;
>> +	};
>>  };
>>  
>>  cpu@0 {
>> -- 
>> 2.5.0
>> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
