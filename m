From: Mason <slash.tmp@free.fr>
Subject: Re: [PATCH v3] thermal: tango: add resume support
Date: Mon, 25 Jul 2016 11:48:47 +0200
Message-ID: <5795E07F.6010506@free.fr>
References: <57726196.5060909@free.fr> <m2wpkd1gfg.fsf@baylibre.com>
 <5795CB4E.4000909@free.fr> <4062048.3qHsMMf8fO@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:4259 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127AbcGYJtK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 25 Jul 2016 05:49:10 -0400
In-Reply-To: <4062048.3qHsMMf8fO@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Kevin Hilman <khilman@baylibre.com>, linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Sebastian Frias <sf84@laposte.net>, Thierry Reding <thierry.reding@gmail.com>

On 25/07/2016 10:52, Arnd Bergmann wrote:

> On Monday, July 25, 2016 10:18:22 AM CEST Mason wrote:
> 
>> Moving the SIMPLE_DEV_PM_OPS macro outside the CONFIG_PM_SLEEP guard
>> would unconditionally define a struct dev_pm_ops, which just wastes
>> space when CONFIG_PM_SLEEP is undefined (if I'm not mistaken).
>>
>> That's why I put SIMPLE_DEV_PM_OPS inside the CONFIG_PM_SLEEP guard.
> 
> If you want to avoid the extra few bytes, just use the trick I
> suggested:
> 
> 	.pm = IS_ENABLED(CONFIG_PM_SLEEP) ? &tango_thermal_pm : NULL,

This would achieve the same result as the solution I proposed
in my v2 patch, right?

So you're saying you prefer the IS_ENABLED macro over using
#ifdef ... #else define stuff as NULL #endif

Did I get that right?

Eduardo, Zhang, what do thermal maintainers prefer?

> You should basically never have that #ifdef inside of the
> platform_driver definition.

Except when the fields don't exist, like the bug I introduced
in struct smp_operations (which you fixed).

Regards.

