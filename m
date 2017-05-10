From: Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH v3 0/3] devfreq_cooling: let the driver supply the
Date: Wed, 10 May 2017 08:47:23 +0100
Message-ID: <e02d983d-a4f9-b627-9f7b-ef71367e4ac3@arm.com>
References: <1493897673-1826-1-git-send-email-lukasz.luba@arm.com>
 <9045ed39-02eb-726a-256e-ea578e9452d6@arm.com>
 <1494378852.2129.12.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752019AbdEJHr0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 May 2017 03:47:26 -0400
In-Reply-To: <1494378852.2129.12.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, edubezval@gmail.com, javi.merino@kernel.org, chris.diamand@arm.com

Thank you Rui!

Lukasz

On 10/05/17 02:14, Zhang Rui wrote:
> On Tue, 2017-05-09 at 10:48 +0100, Lukasz Luba wrote:
>> Hi Eduardo, Rui,
>>
>> gentle ping. Any hope to merge it soon?
>>
> yes, it's in my queue, and I will send out the pull request soon.
>
> thanks,
> rui
>> Regards,
>> Lukasz
>>
>> On 04/05/17 12:34, Lukasz Luba wrote:
>>>
>>> Hi,
>>>
>>> This patchset introduces a new interface for devfreq cooling in
>>> thermal
>>> framework. The first version of the patch can be seen here [1],
>>> second [2].
>>> I have simplified the implementation and introduced resource
>>> utilization
>>> scaling factor.
>>>
>>> The current implementation in the thermal devfreq cooling subsystem
>>> uses
>>> pre-calculated power table for each device to make a decision about
>>> allowed
>>> running state. When the driver registers itself to the thermal
>>> devfreq cooling
>>> subsystem, the framework creates the power table.
>>> The power table is then used by the thermal subsystem to keep
>>> the device in the thermal envelope.
>>> In the previous implementation the pre-calculated device's power
>>> table was scaled by current 'utilization'
>>> ('busy_time' and 'total_time' taken from devfreq 'last_status').
>>>
>>> This idea meets the expectations of the devices which know better
>>> the actual
>>> power that they consume (thanks to power counters). When some
>>> parts/features of the device are not used the power value might be
>>> lower,
>>> while the frequency and utilization are the same.
>>>
>>> The proposed implementation provides possibility to register a
>>> driver to
>>> thermal devfreq cooling subsystem and use the driver's code during
>>> the
>>> calculation of the power in runtime.
>>>
>>> The device driver can still use pre-calculated power table when
>>> these new
>>> functions are not provided (the new extension can co-exist with old
>>> implementation).
>>>
>>> The first patch contains some refactoring for getting the voltage,
>>> the second implements the new feature, the third one changes trace
>>> function.
>>> Patchset is based on v4.11-rc8.
>>>
>>>
>>> Changes
>>> v3:
>>> - refactor OPP code to fit into new dev_pm_opp API
>>> v2:
>>> - removed 'flags' and power2state function,
>>> - split into a few patches,
>>> - simplified the logic of the new interface,
>>> - added resource utilization scaling factor,
>>>
>>> Regards,
>>> Lukasz Luba
>>>
>>> [1] https://marc.info/?l=linux-pm&m=147395070729989&w=2
>>> [2] http://marc.info/?l=linux-pm&m=148587920122854&w=2
>>>
>>> Lukasz Luba (3):
>>>   thermal: devfreq_cooling: refactor code and add get_voltage
>>> function
>>>   thermal: devfreq_cooling: add new interface for direct power read
>>>   trace: thermal: add another parameter 'power' to the tracing
>>> function
>>>
>>>  drivers/thermal/devfreq_cooling.c | 152
>>> ++++++++++++++++++++++++++++----------
>>>  include/linux/devfreq_cooling.h   |  19 +++++
>>>  include/trace/events/thermal.h    |  11 ++-
>>>  3 files changed, 137 insertions(+), 45 deletions(-)
>>>
