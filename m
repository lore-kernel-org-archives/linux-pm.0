From: Mason <slash.tmp@free.fr>
Subject: Re: [PATCH v2] thermal: add temperature sensor support for tango SoC
Date: Mon, 21 Mar 2016 11:31:15 +0100
Message-ID: <56EFCD73.2050009@free.fr>
References: <56D5C7FE.7010807@free.fr> <56D9AF4F.1010304@free.fr>
 <20160308214846.GA10950@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:51011 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754406AbcCUKb0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 21 Mar 2016 06:31:26 -0400
In-Reply-To: <20160308214846.GA10950@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Mans Rullgard <mans@mansr.com>

Hello Eduardo,

On 08/03/2016 22:48, Eduardo Valentin wrote:

> On Fri, Mar 04, 2016 at 04:52:47PM +0100, Mason wrote:
>
>>  drivers/thermal/Kconfig         |   6 +++
>>  drivers/thermal/Makefile        |   1 +
>>  drivers/thermal/tango_thermal.c | 113 ++++++++++++++++++++++++++++++++++++++++
> 
> Can you please add a device tree binding entry under
> Documentation/devicetree/bindings/thermal/

OK.

>> +config TANGO_THERMAL
>> +	tristate "Tango4 thermal management"
>> +	depends on ARCH_TANGO || COMPILE_TEST
>> +	help
>> +	  Enable SMP8758 temperature sensor driver.
> 
> checkpatch.pl --strict complains about this, could you please improve
> the description of your drivers help entry?

Is checkpatch.pl complaining that the help text is only one line long?
("please write a paragraph that describes the config symbol fully")
There is nothing more to say. TANGO_THERMAL=Y will just enable support
for the temperature sensors on the 8758... I guess I could say that I
plan to use it for passive cooling with cpufreq?

> Also, can you please add a comment on the logic here? Where the 41
> constant came from?

I've now changed the algorithm, based on a colleague's suggestion.
I'll try documenting the new algorithm (a trivial linear search).

>> +	priv->zone = thermal_zone_of_sensor_register(dev, 0, priv->base, &ops);
> 
> Why registering only for id 0 when you mentioned this device has three
> sensors?

I plan to define 3 distinct thermal zones (each containing a single sensor).

e.g. for the time being, I've only defined the CPU thermal zone:

	soc {
		cpu_temp: sensor@920100 {
			compatible = "sigma,smp8758-sensor";
			#thermal-sensor-cells = <0>;
			reg = <0x920100 12>;
		};
	};

	thermal-zones {
		cpu_thermal: cpu-thermal {
			polling-delay-passive = <2000>;	/* ms */
			polling-delay = <1000>;		/* ms */
			thermal-sensors = <&cpu_temp>;
		};
	};


Regards.

