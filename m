From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 20/48] mfd: rn5t618: Register power-off handler with
 kernel power-off handler
Date: Fri, 07 Nov 2014 20:19:06 -0800
Message-ID: <545D99BA.5020707@roeck-us.net>
References: <1415292213-28652-1-git-send-email-linux@roeck-us.net> <1415292213-28652-21-git-send-email-linux@roeck-us.net> <20141107210006.GA22111@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58468 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265AbaKHETP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Nov 2014 23:19:15 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XmxUZ-002uHU-3d
	for linux-pm@vger.kernel.org; Sat, 08 Nov 2014 04:19:15 +0000
In-Reply-To: <20141107210006.GA22111@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Beniamino Galvani <b.galvani@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>

On 11/07/2014 01:00 PM, Beniamino Galvani wrote:
> On Thu, Nov 06, 2014 at 08:43:04AM -0800, Guenter Roeck wrote:
>> Register with kernel power-off handler instead of setting pm_power_off
>> directly. Register with low priority to reflect that the original code
>> only sets pm_power_off if it was not already set.
>>
>> Cc: Beniamino Galvani <b.galvani@gmail.com>
>> Acked-by: Lee Jones <lee.jones@linaro.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v5:
>> - Rebase to v3.18-rc3
>> v4:
>> - Do not use notifiers but internal functions and data structures to manage
>>    the list of power-off handlers. Drop unused parameters from callbacks, and
>>    make the power-off function type void
>> v3:
>> - Replace poweroff in all newly introduced variables and in text
>>    with power_off or power-off as appropriate
>> - Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
>> v2:
>> - New patch
>>
>>   drivers/mfd/rn5t618.c       | 28 ++++++++++++----------------
>>   include/linux/mfd/rn5t618.h |  2 ++
>>   2 files changed, 14 insertions(+), 16 deletions(-)
>
> Tested-by: Beniamino Galvani <b.galvani@gmail.com>
>
Thanks!

Guenter

