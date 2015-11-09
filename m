From: Kapileshwar Singh <kapileshwar.singh@arm.com>
Subject: Re: [PATCH] thermal: power_allocator: Use temperature reading from
 tz
Date: Mon, 09 Nov 2015 11:47:59 +0000
Message-ID: <564087EF.70501@arm.com>
References: <1444735801-18267-1-git-send-email-kapileshwar.singh@arm.com> <36DF59CE26D8EE47B0655C516E9CE6402865B959@shsmsx102.ccr.corp.intel.com> <20151015105812.GB2639@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50154 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033AbbKILsE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 9 Nov 2015 06:48:04 -0500
In-Reply-To: <20151015105812.GB2639@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>, "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, "Zhang, Rui" <rui.zhang@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Andrea Arcangeli <aarcange@redhat.com>

If there are no objections to this patch, can this be picked up for the 
next RC?

Regards,
KP

On 15/10/15 11:58, Javi Merino wrote:
> On Wed, Oct 14, 2015 at 05:28:49AM +0000, Chen, Yu C wrote:
>>> -----Original Message-----
>>> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
>>> owner@vger.kernel.org] On Behalf Of Kapileshwar Singh
>>> Sent: Tuesday, October 13, 2015 7:30 PM
>>> To: linux-pm@vger.kernel.org
>>> Cc: Kapileshwar Singh; Javi Merino; Eduardo Valentin; Daniel Kurtz; Zhang, Rui;
>>> Dmitry Torokhov; Sascha Hauer; Andrea Arcangeli
>>> Subject: [PATCH] thermal: power_allocator: Use temperature reading from
>>> tz
>>>
>>> All thermal governors use the temperature value stored in struct
>>> thermal_zone_device.
>>>
>>>     thermal_zone_device->temperature
>>>
>>> power_allocator governor should not deviate from this and use the same.
>>>
>> Just my 2 cents:
>> I wonder if tz->temperature would vary during power_allocator_throttle?
>> because we don't have tz->lock to protect here.
> True, tz->temperature could vary but I don't think it's problematic.
> tz->temperature changing would mean that it doesn't pass this condition:
>
> 	if (!ret && (tz->temperature < switch_on_temp)) {
>
> and then, the temperature changes to a value below switch_on_temp
> before the call to allocate_power().  allocate_power() would still
> work and make an appropriate decision.
>
> All calls inside allocate_power() are protected by tz->lock, so the
> temperature used in pid_controller() is the same as the one reported
> to ftrace.
>
> In summary, I don't think it has any impact on functionality.  Thanks
> a lot for the review,
> Javi
>

