From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] of: thermal: Introduce "linux,hwmon" optional property
Date: Fri, 6 Oct 2017 10:21:18 +0100
Message-ID: <109ff63c-a469-fc33-314c-74811a54547b@arm.com>
References: <20171005084206.2914-1-kukabu@gmail.com>
 <510ceb7b-7e01-2054-008f-e018079f891f@arm.com>
 <CABrG=Zyu9AN8D4uz=xLiarxL_2cvh6m7xUyeY6P+7gjYQDZr6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752826AbdJFJVV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Oct 2017 05:21:21 -0400
In-Reply-To: <CABrG=Zyu9AN8D4uz=xLiarxL_2cvh6m7xUyeY6P+7gjYQDZr6Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Tatarinov <kukabu@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>



On 06/10/17 03:44, Michael Tatarinov wrote:
> Hello
> 
> 2017-10-05 18:57 GMT+04:00, Sudeep Holla <sudeep.holla@arm.com>:
>> Please add devicetree bindings mailing list when you are add such
>> generic and linux specific bindings. For now, I disagree on the approach
>> unless you convince that's the only way on devicetree list and get
>> ACK from DT binding maintainers.
> 
> OK, I will do it after deciding your next issue
> 
>> On 05/10/17 09:42, Michael Tatarinov wrote:
>>> Introduce an optional property called "linux,hwmon", which enable
>>> registration in hwmon subsystems.
>>>
>>
>> Both the commit and the property binding seem to conflict with the
>> comment in Documentation/thermal/sysfs-api.txt
>>
>> It states "when no_hwmon == false, a hwmon sysfs interface will be
>> created" while you seem to indicate that this is required to register
>> to hwmon subsystems.
>>
>> If it's just to enable this sysfs access, then binding seems a bit of
>> misuse.
> 
> You're right but if the property is "linux,no_hwmon" we've enabled
> this for all drivers by default.
> I do not want to change the default behavior.
> 

But you can't just create Linux specific bindings to influence the way
you want drivers to behave. In certain cases, we do need linux specific
bindings for some configurations. But I am not convinced this one falls
in that category. You can always check what DT maintainers think
especially when you creating some linux specific bindings which looks so
generic.

-- 
Regards,
Sudeep
