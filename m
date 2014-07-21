From: Matthew Longnecker <mlongnecker@nvidia.com>
Subject: Re: [PATCH 1/6] thermal: of: Add support for hardware-tracked trip
 points
Date: Mon, 21 Jul 2014 16:53:04 -0700
Message-ID: <53CDA7E0.2060207@nvidia.com>
References: <1403856699-2140-1-git-send-email-mperttunen@nvidia.com> <1403856699-2140-2-git-send-email-mperttunen@nvidia.com> <53B1D1C8.5010907@wwwdotorg.org> <53B262EA.9030806@nvidia.com> <53B2FADC.8060708@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46613 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062AbaGUXxU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 21 Jul 2014 19:53:20 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gll-linux-pm2@m.gmane.org>)
	id 1X9NOQ-0001u6-VB
	for linux-pm@vger.kernel.org; Tue, 22 Jul 2014 01:53:18 +0200
Received: from searspoint.nvidia.com ([216.228.112.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Tue, 22 Jul 2014 01:53:18 +0200
Received: from mlongnecker by searspoint.nvidia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Tue, 22 Jul 2014 01:53:18 +0200
In-Reply-To: <53B2FADC.8060708@wwwdotorg.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 7/1/2014 11:15 AM, Stephen Warren wrote:
> On 07/01/2014 01:27 AM, Mikko Perttunen wrote:
>> >Inline.
>> >
>> >On 01/07/14 00:08, Stephen Warren wrote:
>>> >>On 06/27/2014 02:11 AM, Mikko Perttunen wrote:
>>>> >>>This adds support for hardware-tracked trip points to the device tree
>>>> >>>thermal sensor framework.
>>>> >>>
>>>> >>>The framework supports an arbitrary number of trip points. Whenever
>>>> >>>the current temperature is updated, the trip points immediately
>>>> >>>below and above the current temperature are found. A sensor driver
>>>> >>>callback `set_trips' is then called with the temperatures.
>>>> >>>If there is no trip point above or below the current temperature,
>>>> >>>the passed trip temperature will be LONG_MAX or LONG_MIN respectively.
>>>> >>>In this callback, the driver should program the hardware such that
>>>> >>>it is notified when either of these trip points are triggered.
>>>> >>>When a trip point is triggered, the driver should call
>>>> >>>`thermal_zone_device_update' for the respective thermal zone. This
>>>> >>>will cause the trip points to be updated again.
>>>> >>>
>>>> >>>If the `set_trips' callback is not implemented (is NULL), the framework
>>>> >>>behaves as before.
>>> >>
>>> >>Is there no "core thermal" code? I would have expected this new feature
>>> >>to be implemented in "core" code rather than of/dt "support" code.
>>> >>Perhaps there would also be some additions to the of/dt code, but I'd
>>> >>still expect the bulk of the feature to be complete independant of
>>> >>of/dt. Systems still using board files or ACPI or ... would surely
>>> >>benefit from this too?

Stephen, the "core thermal code" defined two major object types:
  * a thermal zone
  * a cooling device

Each thermal zone corresponds to a physical region in space within a 
device. A sane person might expect there to be one physical temperature 
sensor associated with each zone. But, that's not always the case.

Because the thermal core did not expose the concept of a "sensor" 
separately from a "zone", many drivers which register thermal zones are 
messy -- they include a mix of device driver code (i.e. poking at 
register for a thermal sensor IP block) and device-agnostic code for 
implementing behaviors required of a thermal zone.

of-thermal does more than just parse device tree. It registers thermal 
zones using its own implementation of that device-agnostic code. Having 
that centralized implementation of the thermal zone code allows thermal 
sensor device drivers which talk to of-thermal to be simpler than 
drivers which try to talk directly to the thermal core.

The fact that you need to use DT to make use of the simpler sensor 
driver interface doesn't seem like a good reason to push back on Mikko's 
change.

-Matt

