From: Mason <slash.tmp@free.fr>
Subject: Re: [PATCH v3] thermal: tango: add resume support
Date: Mon, 25 Jul 2016 10:18:22 +0200
Message-ID: <5795CB4E.4000909@free.fr>
References: <57726196.5060909@free.fr> <578CC9C9.3050806@free.fr>
 <m2wpkd1gfg.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:48437 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752403AbcGYISp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 25 Jul 2016 04:18:45 -0400
In-Reply-To: <m2wpkd1gfg.fsf@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Sebastian Frias <sf84@laposte.net>, Thierry Reding <thierry.reding@gmail.com>, Arnd Bergmann <arnd@arndb.de>

On 23/07/2016 00:00, Kevin Hilman wrote:

> Mason wrote:
> 
>> +#ifdef CONFIG_PM_SLEEP
>> +static int tango_thermal_resume(struct device *dev)
>> +{
>> +	tango_thermal_init(dev_get_drvdata(dev));
>> +	return 0;
>> +}
>> +
>> +static SIMPLE_DEV_PM_OPS(tango_thermal_pm, NULL, tango_thermal_resume);
>> +#endif
> 
> #else
> #define tango_thermal_resume NULL
> #endif
> 
> And then move the SIMPLE_DEV_PM_OPS here...

Moving the SIMPLE_DEV_PM_OPS macro outside the CONFIG_PM_SLEEP guard
would unconditionally define a struct dev_pm_ops, which just wastes
space when CONFIG_PM_SLEEP is undefined (if I'm not mistaken).

That's why I put SIMPLE_DEV_PM_OPS inside the CONFIG_PM_SLEEP guard.

>> +
>>  static const struct of_device_id tango_sensor_ids[] = {
>>  	{
>>  		.compatible = "sigma,smp8758-thermal",
>> @@ -99,6 +115,9 @@ static struct platform_driver tango_thermal_driver = {
>>  	.driver	= {
>>  		.name		= "tango-thermal",
>>  		.of_match_table	= tango_sensor_ids,
>> +#ifdef CONFIG_PM_SLEEP
>> +		.pm		= &tango_thermal_pm,
>> +#endif
> 
> ... which allows you to get rid of the ugly ifdef here.
> (c.f. CodingStyle, Chapter 20,)

The previous solution (v2) avoided duplicating the ifdef block,
but Arnd and Thierry objected to the code. Later, they agreed
that it should work; but if they didn't catch the code's intent
at a glance, maybe there is a problem with it anyway.

What do you think?

I copied the DEV_PM_OPS "trick" from drivers/thermal/ti-soc-thermal/ti-bandgap.c
(which was done by Eduardo, a thermal maintainer, so maybe he
prefers that solution after all? commit 8feaf0ce1a043)

Regards.

