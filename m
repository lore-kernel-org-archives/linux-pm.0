From: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>
Subject: Re: [PATCH v7 01/16] clk: tegra: Add binding for the Tegra124 DFLL
 clocksource
Date: Fri, 13 Feb 2015 12:18:51 +0200
Message-ID: <54DDCF8B.1050903@kapsi.fi>
References: <1420723339-30735-1-git-send-email-mikko.perttunen@kapsi.fi> <1420723339-30735-2-git-send-email-mikko.perttunen@kapsi.fi> <20150212224242.GA23500@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150212224242.GA23500@mithrandir>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tuomas.tynkkynen-X3B1VOXEql0@public.gmane.org, Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 02/13/2015 12:42 AM, Thierry Reding wrote:
> On Thu, Jan 08, 2015 at 03:22:04PM +0200, Mikko Perttunen wrote:
>> From: Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>
>> The DFLL is the main clocksource for the fast CPU cluster on Tegra124
>> and also provides automatic CPU rail voltage scaling as well. The DFLL
>> is a separate IP block from the usual Tegra124 clock-and-reset
>> controller, so it gets its own node in the device tree.
>>
>> Signed-off-by: Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> Signed-off-by: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>
>> ---
>>   .../bindings/clock/nvidia,tegra124-dfll.txt        | 69 ++++++++++++++++++++++
>>   1 file changed, 69 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
>>
>> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
>> new file mode 100644
>> index 0000000..54c62ac
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
>> @@ -0,0 +1,69 @@
>> +NVIDIA Tegra124 DFLL FCPU clocksource
>> +
>> +This binding uses the common clock binding:
>> +Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +
>> +The DFLL IP block on Tegra is a root clocksource designed for clocking
>> +the fast CPU cluster. It consists of a free-running voltage controlled
>> +oscillator connected to the CPU voltage rail (VDD_CPU), and a closed loop
>> +control module that will automatically adjust the VDD_CPU voltage by
>> +communicating with an off-chip PMIC either via an I2C bus or via PWM signals.
>
> How would PWM communication work? The documentation below doesn't
> describe it, so perhaps either leave that part out until the binding is
> updated to support it, or maybe make an explicit note that this mode of
> operation isn't supported yet?

Yes, I'll edit this part.

>
>> +Required properties:
>> +- compatible : should be "nvidia,tegra124-dfll-fcpu"
>> +- reg : Defines the following set of registers, in the order listed:
>> +        - registers for the DFLL control logic.
>> +        - registers for the I2C output logic.
>> +        - registers for the integrated I2C master controller.
>> +        - look-up table RAM for voltage register values.
>
> Why do these all need to be separate sets? According to the TRM this is
> a single IP block with a single register region, why the need to split
> them apart?

I will have to check with Tuomas if he had a reason to do it this way.

>
>> +- interrupts: Should contain the DFLL block interrupt.
>> +- clocks: Must contain an entry for each entry in clock-names.
>> +  See ../clocks/clock-bindings.txt for details.
>> +- clock-names: Must include the following entries:
>> +  - soc: Clock source for the DFLL control logic.
>> +  - ref: The closed loop reference clock
>> +  - i2c: Clock source for the integrated I2C master.
>> +- #clock-cells: Must be 0.
>> +- clock-output-names: Name of the clock output.
>> +- vdd-cpu-supply: Regulator for the CPU voltage rail that the DFLL
>> +  hardware will start controlling.
>
> How does the hardware control it? How do we go from regulator phandle to
> something that the hardware will know how to access?

Looks like this property doesn't exist in the current device tree, along
with some other properties. The compatible-string noted above is wrong 
too. I'll fix these for the next version.

>
>> +Required properties for the control loop parameters:
>> +- nvidia,sample-rate: Sample rate of the DFLL control loop.
>> +- nvidia,droop-ctrl: See the register CL_DVFS_DROOP_CTRL in the TRM.
>> +- nvidia,force-mode: See the field DFLL_PARAMS_FORCE_MODE in the TRM.
>> +- nvidia,cf: Numeric value, see the field DFLL_PARAMS_CF_PARAM in the TRM.
>> +- nvidia,ci: Numeric value, see the field DFLL_PARAMS_CI_PARAM in the TRM.
>> +- nvidia,cg: Numeric value, see the field DFLL_PARAMS_CG_PARAM in the TRM.
>> +- nvidia,cg-scale: Boolean value, see the field DFLL_PARAMS_CG_SCALE in the TRM.
>> +
>> +Required properties for I2C mode:
>> +- nvidia,i2c-fs-rate: I2C transfer rate, if using FS mode.
>
> What's FS mode?

I would imagine it stands for full speed. I'll expand the abbreviation.

>
>> +
>> +Example:
>> +
>> +dfll@0,70110000 {
>
> Perhaps this should be "clock@0,70110000"?

Probably.

>
>> +        compatible = "nvidia,tegra124-dfll";
>> +        reg = <0 0x70110000 0 0x100>, /* DFLL control */
>> +              <0 0x70110000 0 0x100>, /* I2C output control */
>> +              <0 0x70110100 0 0x100>, /* Integrated I2C controller */
>> +              <0 0x70110200 0 0x100>; /* Look-up table RAM */
>> +        interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
>> +        clocks = <&tegra_car TEGRA124_CLK_DFLL_SOC>,
>> +                 <&tegra_car TEGRA124_CLK_DFLL_REF>,
>> +                 <&tegra_car TEGRA124_CLK_I2C5>;
>
> If this controls I2C5 now, should it be documented that we can't use
> this controller in software while it is in use by DFLL?

I'll add a note about this.

>
> Thierry
>

Cheers,
Mikko.
