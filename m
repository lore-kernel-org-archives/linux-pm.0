From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Wed, 16 Sep 2015 16:38:32 +0300
Message-ID: <55F970D8.1090205@ti.com>
References: <Pine.LNX.4.44L0.1509151505040.1420-100000@iolanthe.rowland.org>
 <1475011.GNmxQvg88W@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57409 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752633AbbIPNim (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 16 Sep 2015 09:38:42 -0400
In-Reply-To: <1475011.GNmxQvg88W@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>
Cc: Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/16/2015 04:28 AM, Rafael J. Wysocki wrote:
> On Tuesday, September 15, 2015 03:18:19 PM Alan Stern wrote:
>> On Tue, 15 Sep 2015, Thierry Reding wrote:
>>
>>>> There are a few things to watch out for.  Since the dpm_list gets
>>>> modified during system sleep transitions, we would have to make sure
>>>> that nothing gets probed during those times.  In principle, that's what
>>>> the "prepare" stage is meant for, but there's still a race.  As long as
>>>> no other kernel thread (such as the deferred probing mechanism) tries
>>>> to probe a device once everything has been frozen, we should be okay.
>>>> But if not, there will be trouble -- after the ->prepare callback runs,
>>>> the device is no longer on the dpm_list and so we don't want this patch
>>>> to put it back on that list.
>>>
>>> Perhaps moving to the end of the list needs to be a little smarter. That
>>> is it could check whether the device has been prepared for suspension or
>>> not and only move when it hasn't?
>>
>> Maybe.  But doesn't that mean it won't solve your problem completely?
>>
>>> Then again, shouldn't the core even prohibit new probes once the suspend
>>> has been triggered? Sounds like asking for a lot of trouble if it didn't
>>> ...
>>
>> The core prohibits new devices from being registered.  It does not
>> prohibit probes of existing devices, because they currently do not
>> affect the dpm_list.

Seems I missed smth, but I can't find the place in Kernel that prohibits
creation of new devices during suspend.

Could someone point me on, please?




-- 
regards,
-grygorii
