From: Mason <slash.tmp@free.fr>
Subject: Re: [PATCH v7] thermal: add temperature sensor support for tango SoC
Date: Wed, 13 Apr 2016 22:28:18 +0200
Message-ID: <570EABE2.7010609@free.fr>
References: <20160308214846.GA10950@localhost.localdomain>
 <56F84427.1000507@free.fr> <56F91A47.9060901@free.fr>
 <20160329020050.GA15721@localhost.localdomain> <56FACE0B.9060606@free.fr>
 <20160330000503.GA2625@localhost.localdomain> <56FBEE4F.3060106@free.fr>
 <56FD8582.80002@free.fr> <20160401015240.GB19409@localhost.localdomain>
 <570254D8.3090406@free.fr> <20160406155155.GB326@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:51623 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbcDMU2p (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 13 Apr 2016 16:28:45 -0400
In-Reply-To: <20160406155155.GB326@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, arm-soc <arm@kernel.org>

On 06/04/2016 17:51, Eduardo Valentin wrote:

> On Mon, Apr 04, 2016 at 01:49:44PM +0200, Mason wrote:
> 
>> +	priv->zone = thermal_zone_of_sensor_register(&pdev->dev, 0, priv, &ops);
> 
> I would still prefer you use the devm_ version.

In the .remove callback, I call thermal_zone_of_sensor_unregister()
and then the sensor is powered down.

I don't know when the devm garbage collector kicks in.
Is it before or after calling .remove?
(I suspect it is *after*, when the driver is detached.)

I can't power the sensor down until it has been "unregistered".
If .get_temp is called with the sensor powered down, the HW
will return garbage, which might have weird consequences.

The documentation states
https://www.kernel.org/doc/Documentation/thermal/sysfs-api.txt

devm_thermal_zone_of_sensor_register()
"The benefit of using this interface to register sensor is that it
is not require to explicitly call thermal_zone_of_sensor_unregister()"

So I can still explicitly call thermal_zone_of_sensor_unregister?

What is the point of devm_thermal_zone_of_sensor_unregister?

Regards.

