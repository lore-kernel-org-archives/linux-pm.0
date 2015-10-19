From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 3/3] power: bq27xxx_battery: fix defined but not used
 warnings
Date: Mon, 19 Oct 2015 11:33:40 -0500
Message-ID: <56251B64.7080104@ti.com>
References: <1445003052-31373-1-git-send-email-sre@kernel.org>
 <1445003052-31373-4-git-send-email-sre@kernel.org>
 <20151016144705.GG28216@pali> <5621114D.7010002@ti.com>
 <20151019093721.GA11028@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151019093721.GA11028@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/19/2015 04:37 AM, Sebastian Reichel wrote:
> On Fri, Oct 16, 2015 at 10:01:33AM -0500, Andrew F. Davis wrote:
>> On 10/16/2015 09:47 AM, Pali Roh=E1r wrote:
>>> On Friday 16 October 2015 15:44:12 Sebastian Reichel wrote:
>>>> If BQ27XXX is enabled, but neither I2C based initialization, nor
>>>> platform based initialization are activated, bq27xxx_powersupply_i=
nit
>>>> and bq27xxx_powersupply_unregister are defined but not used.
>>>>
>>>> This configuration doesn't make sense, but there is no easy way
>>>> to make it unavailable in the build system, so just mark the
>>>> functions as __maybe_unused instead.
>>>>
>>>
>>> What about?
>>>
>>> #if defined(CONFIG_1) || defined(CONFIG_2)
>>> #define NEED_POWER_SUPPLY
>>> #endif
>>>
>>> And then wrap power supply code into #ifdef NEED_POWER_SUPPLY?
>
> I thought about wrapping the whole code in an ifdef, but I don't
> think compiling an empty file is any better than adding the
> __maybe_unused flag.
>
>> We would need to wrap everything in that then, so without I2C or
>> platform enabled we end up compiling an empty file. I think the
>> better fix would be to modify the Kconfig, something like:
>
> Handling this in Kconfig is preferred of course.
>
>> config BATTERY_BQ27XXX
>> 	tristate
>> 	depends on (BATTERY_BQ27XXX_I2C || BATTERY_BQ27XXX_PLATFORM)
>> 	default y
>>
>> config BATTERY_BQ27XXX_I2C
>> 	bool "BQ27200/BQ27500 support"
>> 	depends on I2C
>> 	help
>> 	  Say Y here to enable support for batteries with BQ27x00 (I2C) chi=
ps.
>>
>> config BATTERY_BQ27XXX_PLATFORM
>> 	bool "BQ27000 support"
>> 	help
>> 	  Say Y here to enable support for batteries with BQ27000 (HDQ) chi=
ps.
>>
>> This would be more in line with how other multi-bus devices handle
>> this issue when nether bus is selected.
>
> If I'm not mistaken, this way it's impossible to build the code as
> module. You need to move the tristate to the individual bus options.
> This would require to split the code, so that two separate modules
> are built. I checked the tree and found a few examples:
>
>   * building one modules for each bus, core support is autoselected, =
but always built-in
>    - BMP085
>
>   * building a core modules + one module for each bus
>    - AD525X_DPOT
>    - ADE7854
>    - ADT7316
>    - INPUT_AD714X
>    - INPUT_ADXL34X
>    - TOUCHSCREEN_AD7879
>    - TOUCHSCREEN_CYTTSP_CORE
>    - TOUCHSCREEN_CYTTSP4_CORE
>
> Instead of restructuring the whole driver, we could also just built
> the platform code unconditionally. The platform specific code is
> just a probe + remove function and bq27xxx_battery_platform_read().
> The last one could be dropped, if the pdata->read function is
> modified (effectively moving the code into the w1 driver).
>
> -- Sebastian
>

A quick test shows the following Kconfig to work as desired, selecting =
one
or both buses as modules builds the driver as a module, if ether are
selected as built-in the whole driver is built-in.

config BATTERY_BQ27XXX
	tristate
	depends on (BATTERY_BQ27XXX_I2C || BATTERY_BQ27XXX_PLATFORM)
	default y

config BATTERY_BQ27XXX_I2C
	tristate "BQ27xxx I2C support"
	depends on I2C
	help
	  Say Y here to enable support for batteries with BQ27xxx (I2C) chips.

config BATTERY_BQ27XXX_PLATFORM
	tristate "BQ27xxx HDQ support"
	help
	  Say Y here to enable support for batteries with BQ27xxx (HDQ) chips.

We would then have to change:
#ifdef CONFIG_BATTERY_BQ27XXX_I2C

to

#if defined(CONFIG_BATTERY_BQ27XXX_I2C) || defined(CONFIG_BATTERY_BQ27X=
XX_I2C_MODULE)

(same for CONFIG_BATTERY_BQ27XXX_PLATFORM)

--=20
Andrew F. Davis
