From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/3] lm90: initialize parameters from devicetree
Date: Fri, 22 Jan 2016 18:53:50 -0800
Message-ID: <56A2EB3E.4080002@roeck-us.net>
References: <1453404877-17897-1-git-send-email-stephan@kochen.nl>
 <1453404877-17897-3-git-send-email-stephan@kochen.nl>
 <56A24278.8050909@roeck-us.net> <20160122223238.GB21534@Stephans-iMac.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44666 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318AbcAWCx5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2016 21:53:57 -0500
In-Reply-To: <20160122223238.GB21534@Stephans-iMac.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?St=c3=a9phan_Kochen?= <stephan@kochen.nl>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, lm-sensors@lm-sensors.org, devicetree@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

On 01/22/2016 02:32 PM, St=E9phan Kochen wrote:
> On Fri, Jan 22, 2016 at 06:53:44AM -0800, Guenter Roeck wrote:
>> On 01/21/2016 11:34 AM, St=E9phan Kochen wrote:
>>> Allow a device tree to set initial temperature sensor parameters.
>>
>> This very much smells like configuration, not hardware description.
>>
>> Having said that, the thermal subsystem does something similar. This=
 raises even more
>> questions, though. Since patch 3 of the series introduces registrati=
on with the thermal
>> subsystem, it seems to me that the thermal subsystem should provide =
any limits used
>> to program the chips, and that there should be a mechanism for the t=
hermal subsystem
>> to interact with the driver to both set the limits and to be informe=
d if a limit
>> is exceeded.
>>
>> Also, _if_ such a set of properties is introduced and accepted by th=
e devicetree
>> reviewers, it should probably be a set of properties which applies t=
o _all_ hardware
>> monitoring drivers, not just to one. Even if support is not implemen=
ted immediately
>> in the hwmon core, the properties should be usable in a generic way,=
 and not
>> reflect sysfs attribute names used by the hwmon subsystem.
>
> The original kernel for Ouya is a 3.1 kernel from nVidia's old
> Linux4Tegra branches. This kernel had its own Tegra-specific thermal
> zone support which seems to do more or less that: the thermal zone
> system actually uses the sensor alert interrupts to detect when it ne=
eds
> to act, and reconfigures alert bounds as the temperature slides to
> another range it wants to monitor.
>
> Thermal zones in current master only have the ability to check sensor
> values at an interval.
>
> I'd agree that update-interval and the low/high bounds could be
> controlled by the thermal zone system. I'm less certain what to do wi=
th
> the critical/emergency bounds, and the remote-offset.
>
> Thing about Ouya is that, even with the thermal zone currently workin=
g,
> the alert bounds set when the system comes up seem to be crippling th=
e
> system with interrupts shortly after the sensor is activated. So they
> have to be set to something sane. Hence why I added both.
>
> I'm not sure if you're expecting me to do the work of extending therm=
al
> zones. I guess I'd need to figure out how a sensor would notify a
> thermal zone of an alert, and implement that functionality while stay=
ing
> backwards compatible.
>
The thermal subsystem supports setting trip points, which I would think
is what you are looking for here. Question is if an how you can use the
information from the thermal subsystem (and thus the thermal zone confi=
guration)
to set the various limits in the lm90 driver. This should hopefully be =
sufficient
to fix your immediate problem. For handling alerts, I guess we'll have =
to wait for
thermal subsystem improvements (unless of course you volunteer to do th=
at work.

Copying the the linux-pm mailing list and thermal maintainers for addit=
ional advise.

Thanks,
Guenter

