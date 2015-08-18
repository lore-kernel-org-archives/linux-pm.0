From: Petr Cvek <petr.cvek@tul.cz>
Subject: Re: [PATCH v2 03/21] ARM: pxa: magician: Fix comments, debug
 functions and print strings
Date: Wed, 19 Aug 2015 01:09:44 +0200
Message-ID: <55D3BB38.8030701@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D258CD.40101@tul.cz>
 <87r3n08mqo.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <87r3n08mqo.fsf@belgarion.home>
Sender: linux-leds-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>, philipp.zabel@gmail.com
Cc: daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Dne 18.8.2015 v 20:39 Robert Jarzmik napsal(a):
> Petr Cvek <petr.cvek@tul.cz> writes:
> 
>> Fix comments, debug functions and print strings. Rename backlight
>> structures to be more specific.
>>
>> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
>> ---
>>  arch/arm/mach-pxa/magician.c | 121 +++++++++++++++++++++++++++++++------------
>>  1 file changed, 89 insertions(+), 32 deletions(-)
>>
>> diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
>> index 9e8698a..57da133 100644
>> --- a/arch/arm/mach-pxa/magician.c
>> +++ b/arch/arm/mach-pxa/magician.c
>> @@ -11,6 +11,46 @@
>>   * it under the terms of the GNU General Public License version 2 as
>>   * published by the Free Software Foundation.
>>   *
>> + *
>> + * NOTICE MDA Compact (T-mobile XDA) facts:
>> + *   On "LCD type = 1, system_rev = 2" (0x3a in CPLD)
>> + * Samsung LTP280QV - valid LCD init sequence sequence:
>> + *   powerup: Vdigital->Vanalog->gate Voff->gate Von->data enable
>> + *   powerdown: data disable->gate Von->gate Voff->Vanalog->Vdigital
>> + * Measured on PCB:
>> + *   GPIO106
>> + *     Affects VOFF, VON and other voltages
>> + *     Probably main reset pin for DC-DC converter
>> + *   GPIO75
>> + *     Must be AF0+OUT (WM leaves it to AF2+OUT), not LCD signal
>> + *     GPIO106 works only when GPIO75 is high (DC-DC power enable?)
>> + *     After LCD powerup, value is irrelevant
>> + *   GPIO104
>> + *     LCD VOFF (gate off voltage)
>> + *   GPIO105
>> + *     LCD VON (gate on voltage)
>> + * FFUART (/dev/ttyS0) WM: 38400,8,n,1,crtscts (GSM data?)
>> + * BTUART (/dev/ttyS1) WM: 115200,8,n,1,crtscts (GSM AT commands)
>> + *   Use a HTC line discipline: 0x02 channel(==0x16) data 0x02
>> + * EGPIO(CPLD) should be always present (controls "all" supply power)
>> + *   For rootfs on MMC/SD: EGPIO module controls card power (in kernel)
>> + * cpu-freq often freeze platform (errata?, use userspace gov)
>> + * Do not use YUV420, (erratum E24) causes LCD hang (forever)
>> + * Many GSM related pins are unknown
>> + * gpio-rc-recv probably require lowpass filter (sw is OK)
>> + * TODO EGPIO_MAGICIAN_IR_RECEIVE_SHUTDOWN
>> + * FIXME AC charging blocks IrDA
>> + * Unimplemented blocking of camera+power+reset, reset and door open reset
>> + *   Registers: htc-pasic3.h (but blocks charging too)
>> + * Other PXA machines have wait_for_sync for ADS7846 (during LCD refresh)
>> + * pda-power has not optimal charging (accu can be bloated)
>> + * TODO Current switching works? Is gpio-regulator/bq24022 required?
> I think you can ask Philip, he's the maintainer after all ...

Ok. Philipp? 

Current switching can be done in pda-power function .set_charge(). But setting the charging current based on AC vs USB cable only is irrelevant as both can deliver 500mA (and Magician is not one of the most power efficient machine, 100mA is barely enough to power). Better thing would be to base the switching on accu level of charge (trickle charging).

> 
>> + * pdata supports alternative drivers (mutually exclusive modules)
>> + *   i2c-pxa vs i2c-gpio (SCCB)
>> + *   pwm_bl vs gpio_backlight
>> + *   pxa27x_udc vs phy-gpio-vbus-usb
>> + *   physmap-flash vs pxa2xx-flash
> 
> Okay, this chunk is nice documentation, but not code ...
> I'd rather have it in : Documentation/arm/pxa/magician.txt or something like
> that.
OK I can move these comments there.

> 
>> @@ -120,11 +160,12 @@ static unsigned long magician_pin_config[] __initdata = {
>>  };
>>  
>>  /*
>> - * IRDA
>> + * IrDA
>>   */
>>  
>>  static struct pxaficp_platform_data magician_ficp_info = {
>>  	.gpio_pwdown		= GPIO83_MAGICIAN_nIR_EN,
>> +	/* TODO test with FIR dongle */
> I don't like this comment. I was not there before, so let it be. You know there
> remains a TODO, I know ... but you can cunningly slip it in the commit message.
Actually I have bought a dongle during last week, but it turned out, it can do only SIR (and poorly :-D). I can try to enable a second magician PCB, but it will takes some time (as I have only one accupack - second burned down). So do I have to remove only comment or FIR flag altogether? (I can find with second magician that it can work like a charm or it is not working - for example due to incompatible IrDA transceiver).
