From: Sravan <asravan@codeaurora.org>
Subject: Re: avoid adding devices without pm_ops to dpm list
Date: Sun, 04 May 2014 11:27:29 +0530
Message-ID: <5365D6C9.10901@codeaurora.org>
References: <Pine.LNX.4.44L0.1404211005230.1201-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:54603 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbaEDF5a (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 4 May 2014 01:57:30 -0400
In-Reply-To: <Pine.LNX.4.44L0.1404211005230.1201-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@vger.kernel.org

On 4/21/2014 7:39 PM, Alan Stern wrote:
> On Mon, 21 Apr 2014, Sravan wrote:
>
>> Hello,
>>
>> I have come across below code which looks can be optimized to reduce
>> suspend/resume latencies.
>>
>> During device registration at boot up, device_add() is called.
>> In this device_add() function, device_pm_add() is called without
>> checking if the device has pm_ops or not.
>> Thus dpm_list is generated with all devices even if some devices don't
>> have pm_ops.
>>
>> device_add() ->  device_pm_add()->  generate dpm_list
>>
>> During suspend/resume process, suspend/resume APIs are called for
>> devices present in dpm_list.
>> due to this, suspend/resume APIs for devices without pm_ops also called
>> and just return with NULL.
> What are you talking about?  _No_ device has a pm_ops structure; there
> is no such member inside struct device.
>
>> Can we optimize this code by adding *ONLY* devices with pm_ops to
>> dpm_list and ignore remaining?
>> It will help reduce suspend/resume latencies. I observed 10mS savings
>> with my debug code. It may change based on number of devices without pm_ops.
>>
>> Let me know your opinion/suggestions on this.
> The suspend and resume routines look at pm_ops structures in the
> device's power domain, device type, bus type, class, and driver.  Even
> though most of those remain constant throughout the device's lifetime,
> the driver can change at any time.  Therefore it is not possible to
> leave devices off the dpm_list.
>
> Alan Stern
>
Hi Alan,
If i follow below steps, won't it resolve the issue?

1. Add pm_ops check for driver during driver registration
2. If driver has pm_ops, i will add device to dpm_list.
3. error handling to remove device from dpm_list if driver is unregistered

driver attach to device code flow is as below:
driver_register->bus_add_driver->driver_attach->__driver_attach->driver_probe_device->really_probe

Thus dpm_list is becoming dynamic and unnecessary devices are removed 
from dpm_list.

I observed few hundreds of devices without pm_ops (no pm_ops for any of 
pm_domain, type, class, driver)
on my device. So i am looking for better solution to optimize this 
Suspend/Resume path and latencies.

Let me know if you think of any side effects with above approach and 
better alternative solutions.

Sravan
---
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation


