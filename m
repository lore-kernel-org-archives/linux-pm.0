From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/4] acpi: battery: Add acpi_battery_unregister() function
Date: Mon, 20 Mar 2017 14:11:52 +0100
Message-ID: <e83a53c6-4fca-00ba-3b92-c723ae1570e7@redhat.com>
References: <20170316161601.32267-1-hdegoede@redhat.com>
 <20170316161601.32267-2-hdegoede@redhat.com>
 <1489681793.19767.21.camel@linux.intel.com>
 <84d31794-d5c5-6f09-bbdb-9f5612ddbbbe@redhat.com>
 <1490015400.19767.109.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753314AbdCTNMm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Mar 2017 09:12:42 -0400
In-Reply-To: <1490015400.19767.109.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

Hi,

On 20-03-17 14:10, Andy Shevchenko wrote:
> On Mon, 2017-03-20 at 14:03 +0100, Hans de Goede wrote:
>> Hi,
>>
>> Thank you for the reviews!
>>
>> On 16-03-17 17:29, Andy Shevchenko wrote:
>>> On Thu, 2017-03-16 at 17:15 +0100, Hans de Goede wrote:
>
>>>> @@ -31,6 +31,7 @@
>>>>  #include <linux/delay.h>
>>>>  #include <linux/slab.h>
>>>>  #include <linux/suspend.h>
>>>> +#include <linux/mutex.h>
>>>
>>> Keep in alphabetical order ?
>>
>> I'm a fan of having headers in alphabetical order myself,
>> but if you look at the actual file, rather then the diff
>> context, you will see that this file uses random order.
>
> Okay, but can you squeeze it in most ordered part?
>
>>>> +++ b/include/linux/power/acpi.h
>>>
>>> E.g. for GPIO we keep such things directly in linux/acpi.h. Does it
>>> make
>>> sense to have separate one in this case?
>>
>> I've taken include/acpi/video.h as example here. TBH I do not think
>> shoving everything acpi related into linux/acpi.h is a good idea.
>
> So, let Rafael judge then. I have no strong opinion, just recall that
> case.

Ack to both remarks.

Regards,

Hans
