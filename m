From: kernel@martin.sperl.org
Subject: Re: [PATCH V9] thermal: bcm2835: add thermal driver for bcm2835 soc
Date: Tue, 24 Jan 2017 10:52:43 +0100
Message-ID: <0452720A-5914-469B-9EF7-0581CF1B5478@martin.sperl.org>
References: <1483808145-6206-1-git-send-email-kernel@martin.sperl.org> <20170120041400.GA24617@localhost.localdomain> <060918B6-A773-46A5-8D10-C9F6BBA6D3F1@martin.sperl.org> <20170124093127.GB3651@localhost.localdomain>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:51748
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbdAXJwr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jan 2017 04:52:47 -0500
In-Reply-To: <20170124093127.GB3651@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, linux-pm@vger.kernel.org, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, linux-arm-kernel@lists.infradead.org


> On 24.01.2017, at 10:31, Eduardo Valentin <edubezval@gmail.com> wrote:
> 
> Hello Martin,
> 
> On Fri, Jan 20, 2017 at 08:54:07AM +0100, kernel@martin.sperl.org wrote:
>> 
>>> On 20.01.2017, at 05:14, Eduardo Valentin <edubezval@gmail.com> wrote:
>>> 
>>> Hello Martin,
>>> 
>>> On Sat, Jan 07, 2017 at 04:55:45PM +0000, kernel@martin.sperl.org wrote:
>>>> From: Martin Sperl <kernel@martin.sperl.org>
>>>> 
>>>> Add basic thermal driver for bcm2835 SOC.
>>>> 
>>>> This driver currently relies on the firmware setting up the
>>>> tsense HW block and does not set it up itself.
>>>> 
>>>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>>>> Acked-by: Eric Anholt <eric@anholt.net>
>>>> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
>>>> 
>>> 
>>> <cut>
>>> 
>>>> +
>>>> +static const struct of_device_id bcm2835_thermal_of_match_table[] = {
>>>> +	{
>>>> +		.compatible = "brcm,bcm2835-thermal",
>>>> +		.data = &(struct bcm2835_thermal_info) {
>>>> +			.offset = 407000,
>>>> +			.slope = -538,
>>>> +			.trip_temp = 80000
>>>> +		}
>>>> +	},
>>>> +	{
>>>> +		.compatible = "brcm,bcm2836-thermal",
>>>> +		.data = &(struct bcm2835_thermal_info) {
>>>> +			.offset = 407000,
>>>> +			.slope = -538,
>>>> +			.trip_temp = 80000
>>>> +		}
>>>> +	},
>>>> +	{
>>>> +		.compatible = "brcm,bcm2837-thermal",
>>>> +		.data = &(struct bcm2835_thermal_info) {
>>>> +			/* the bcm2837 needs adjustment of +5C */
>>>> +			.offset = 407000 + 5000,
>>>> +			.slope = -538,
>>>> +			.trip_temp = 80000
>>>> +		}
>>>> +	},
>>>> +	{},
>>> 
>>> Just for the same of clarification, is there anything preventing this
>>> driver of using of-thermal API? the above data (slope, offset, and
>>> trip_temps) would be in DT the place where they are supposed to be,
>>> instead of code.
>>> 
>> 
>> As the DT changes, that only define compatible strings, have already gone
>> in without any such properties set, we need to define defaults for the 
>> slope/offset and trip_temp values.
>> 
> 
> These properties won't go into the same node you are referring to. They
> go into the thermal-zone node you would create, which would then refer
> to the node you referred (already merged). Therefore, I do not see
> anything blocking a proper of-thermal usage to cover for the above data.
> 
>> I guess (for newer SOC) you still can use the values in the DT,
>> as (I guess) these are parsed and set in thermal_zone_device_register
>> after the defaults are set in thermal_zone_params.
> 
> Not sure what you meant here, but these values, when correctly used in
> DT, they would come as part of the thermal_zone_params and in the
> thermal trips of the thermal zones, as the of-thermal code with already
> deal with those for you.
> 
> Please have a look at:
> a. Documentation/devicetree/bindings/thermal/thermal.txt
> b. drivers/thermal/of-thermal.c
> 
> And let me know if you see anything that would prevent this driver of
> using the correct API to describe hardware data with DT.


I guess you miss my point:
The argument is that we have DT in the 4.10.0-rc2 kernel right now that
look like this:
                thermal@7e212000 {
                        compatible = "brcm,bcm2835-thermal";
                        clocks = <0x6 0x1b>;
                        status = "okay";
                        reg = <0x7e212000 0x8>;
                }
so we still need to be compatible with those without any extra defines.

Hence we need to define those slopes and offsets in the driver itself
to stay compatible with those older device-trees.

As for if it works with the framework - I have to admit I do not
have the slightest clue - it looks way to complicated for the soc right
now.

As a note: afaiu the trip_temp register is the temperature at which the
soc will reboot on its own - similar to a watchdog, but for temperatures.
(main reason for the assumption is because there is no interrupt that
can get assigned a handler to catch this situation).

Martin


