From: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 6/6] Documentation: Add device tree bindings document for
 max77843
Date: Fri, 23 Jan 2015 16:40:35 +0900
Message-ID: <54C1FAF3.9090701@samsung.com>
References: <1421989367-32721-1-git-send-email-jaewon02.kim@samsung.com>
 <1421989367-32721-7-git-send-email-jaewon02.kim@samsung.com>
 <54C1E943.2020800@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <54C1E943.2020800-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 01/23/2015 03:25 PM, Chanwoo Choi wrote:
> Hi Jaewon,
> 
> On 01/23/2015 02:02 PM, Jaewon Kim wrote:
>> Add document describing device tree bindings for max77843 MFD.
>> Drivers: MFD core, regulator, extcon, charger and fuelgauge.
>>
>> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
>> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
>> Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
>> Cc: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Cc: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Signed-off-by: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/mfd/max77843.txt |   87 ++++++++++++++++++++
>>  1 file changed, 87 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/max77843.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/max77843.txt b/Documentation/devicetree/bindings/mfd/max77843.txt
>> new file mode 100644
>> index 0000000..6895604
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/max77843.txt
>> @@ -0,0 +1,87 @@
>> +Maxim MAX77843 multi-function device
>> +
>> +MAX77843 is a Multi-Function Device with the following submodules:
>> +- PMIC	  : 2 SAFEOUT LDOs for USB device
>> +- CHARGER : Li+ battery charger with Fuel Gauge
>> +- MUIC	  : Micro USB Interface Circuit
>> +- HAPTIC  : motor control driver for haptics
> 
> HAPTIC ?
> 
>> +- LED	  : 4 channel RGBW LED
> 
> LED ?
> 
> This patchset don't include andy haptic/led drivers.
> I think it is un-necessary information.
> 
> When you implement the haptic/led driver, you will add the information
> for haptic/led driver.
> 

OK. I will remove them.

>> +
>> +It is interfaced to host controller using I2C.
>> +
>> +Required properties:
>> +- compatible : Must be "maxim,max77843".
>> +- reg : I2C slave address of PMIC block.
>> +- interrupts : I2C line for main SoCs.
>> +- interrupt-parent : The parent of interrupt controller.
>> +
>> +Optional properties:
>> +- regulators : The regulators of max77843 have to be instantiated under subnode
>> +	named "regulators" using the following format.
>> +
>> +	[*]refer : Documentation/devicetree/bindings/regulator/regulator.txt
>> +
>> +	regulators {
>> +		SAFEOUT {
>> +			regulator-name = "SAFEOUT";
>> +		};
>> +	}
>> +
>> +	List of valid regulator names:
>> +	- SAFEOUT1, SAFEOUT2, CHARGER.
>> +
>> +- max77843-muic : This properties used by extcon consumers.
>> +	Required properties:
>> +		- compatible : Must be "maxim,max77842-muic".
>> +
>> +- max77843-charger : There battery charger of MAX77843 have to be instantiated
>> +	under sub-node named "max77843-charger" using the following format.
>> +	Required properties:
>> +		- compatible : Must be "maxim,max77842-charger".
>> +		- maxim,fast-charge-uamp : Fast charge current levels are
>> +			100 mA to 3150 mA programmed by I2C per 100 mA.
>> +		- maxim,top-off-uamp : Top off current threshold levels are
>> +			125 mA to 650 mA programmed by I2C per 75 mA.
>> +		- maxim,input-uamp-limit : Input current limit levels are
>> +			100 mA to 3533 mA programmed by I2C per 33 mA.
>> +- max77843-fuelgauge : There fuelgauge of MAX77843 have to be instantiated
>> +	under sub-node named "max77843-fuelgauge" using the following format.
>> +	Required properties:
>> +		- compatible : Must be "maxim,max77842-fuelgauge".
>> +
>> +Example:
>> +	max77843@66 {
>> +		compatible = "samsung,max77843";
>> +		reg = <0x66>;
>> +		interrupt-parent = <&gpa1>;
>> +		interrupts = <5 2>;
>> +
>> +		regulators {
>> +			SAFEOUT1 {
>> +				regulator-name = "SAFEOUT1";
>> +				regulator-min-microvolt = <3300000>;
>> +				regulator-max-microvolt = <4950000>;
>> +			};
>> +			SAFEOUT2 {
>> +				regulator-name = "SAFEOUT2";
>> +				regulator-min-microvolt = <3300000>;
>> +				regulator-max-microvolt = <4950000>;
>> +			};
> 
> As I knew, max77843 regulator driver supprot 'CHARGER' regulator.
> I think you have to add the 'CHARGER' dt node for regulators.
> 
> 

Right, I will include charger regulator.

>> +		};
>> +
>> +		max77843-muic {
>> +			compatible = "maxim,max77843-muic";
>> +		};
>> +
>> +		max77843-charger {
>> +			compatible = "maxim,max77843-charger";
>> +			maxim,fast-charge-uamp = <450000>;
>> +			maxim,top-off-uamp = <125000>;
>> +			maxim,input-uamp-limit = <500000>;
>> +		};
>> +
>> +		max77843-fuelgauge {
>> +			compatible = "maxim,max77843-fuelgauge";
>> +		};
>> +
>> +	};
>>
> 
> Thanks,
> Chanwoo Choi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
