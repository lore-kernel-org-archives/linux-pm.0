From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 3/3] power: bq27xxx_battery: fix defined but not used
 warnings
Date: Fri, 16 Oct 2015 10:01:33 -0500
Message-ID: <5621114D.7010002@ti.com>
References: <1445003052-31373-1-git-send-email-sre@kernel.org>
 <1445003052-31373-4-git-send-email-sre@kernel.org>
 <20151016144705.GG28216@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45161 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932123AbbJPPBg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 16 Oct 2015 11:01:36 -0400
In-Reply-To: <20151016144705.GG28216@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/16/2015 09:47 AM, Pali Roh=C3=A1r wrote:
> On Friday 16 October 2015 15:44:12 Sebastian Reichel wrote:
>> If BQ27XXX is enabled, but neither I2C based initialization, nor
>> platform based initialization are activated, bq27xxx_powersupply_ini=
t
>> and bq27xxx_powersupply_unregister are defined but not used.
>>
>> This configuration doesn't make sense, but there is no easy way
>> to make it unavailable in the build system, so just mark the
>> functions as __maybe_unused instead.
>>
>
> What about?
>
> #if defined(CONFIG_1) || defined(CONFIG_2)
> #define NEED_POWER_SUPPLY
> #endif
>
> And then wrap power supply code into #ifdef NEED_POWER_SUPPLY?
>

We would need to wrap everything in that then, so without I2C or
platform enabled we end up compiling an empty file. I think the
better fix would be to modify the Kconfig, something like:

config BATTERY_BQ27XXX
	tristate
	depends on (BATTERY_BQ27XXX_I2C || BATTERY_BQ27XXX_PLATFORM)
	default y

config BATTERY_BQ27XXX_I2C
	bool "BQ27200/BQ27500 support"
	depends on I2C
	help
	  Say Y here to enable support for batteries with BQ27x00 (I2C) chips.

config BATTERY_BQ27XXX_PLATFORM
	bool "BQ27000 support"
	help
	  Say Y here to enable support for batteries with BQ27000 (HDQ) chips.

This would be more in line with how other multi-bus devices handle
this issue when nether bus is selected.

--=20
Andrew F. Davis
