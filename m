From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [RESEND] thermal: hwmon: Properly report critical temperature in sysfs
Date: Thu, 29 Dec 2016 13:45:49 +0200
Message-ID: <CAJKOXPess6_N2VyZDviS2Y8gxwsRKrG9jKuyEacE8xo2-7LaAw@mail.gmail.com>
References: <20161228173528.4419-1-krzk@kernel.org> <1483011829.2342.0.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752053AbcL2Lpx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Dec 2016 06:45:53 -0500
In-Reply-To: <1483011829.2342.0.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Thu, Dec 29, 2016 at 1:43 PM, Zhang Rui <rui.zhang@intel.com> wrote:
> On Wed, 2016-12-28 at 19:35 +0200, Krzysztof Kozlowski wrote:
>> In the critical sysfs entry the thermal hwmon was returning wrong
>> temperature to the user-space.  It was reporting the temperature of
>> the
>> first trip point instead of the temperature of critical trip point.
>>
>> For example:
>>       /sys/class/hwmon/hwmon0/temp1_crit:50000
>>       /sys/class/thermal/thermal_zone0/trip_point_0_temp:50000
>>       /sys/class/thermal/thermal_zone0/trip_point_0_type:active
>>       /sys/class/thermal/thermal_zone0/trip_point_3_temp:120000
>>       /sys/class/thermal/thermal_zone0/trip_point_3_type:critical
>>
>> Since commit e68b16abd91d ("thermal: add hwmon sysfs I/F") the driver
>> have been registering a sysfs entry if get_crit_temp() callback was
>> provided.  However when accessed, it was calling get_trip_temp()
>> instead
>> of the get_crit_temp().
>>
>> Fixes: e68b16abd91d ("thermal: add hwmon sysfs I/F")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> The patch is already in upstream kernel.
>
> thanks,
> rui

Ahh, indeed.

Thanks!
Krzysztof
