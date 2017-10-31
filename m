From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] PM / QoS: Fix default runtime_pm device resume latency
Date: Tue, 31 Oct 2017 09:13:20 +0200
Message-ID: <0bb15d6d-3353-90d7-8335-200dd9790632@ti.com>
References: <1509347446-26105-1-git-send-email-t-kristo@ti.com>
 <CAJZ5v0i8HMDfV907QDTD54YPaFpoBLVt+R4oeQ704+9_C8APoA@mail.gmail.com>
 <3227682.nATp9NGxKU@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:36087 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752417AbdJaHNc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Oct 2017 03:13:32 -0400
In-Reply-To: <3227682.nATp9NGxKU@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 31/10/17 01:27, Rafael J. Wysocki wrote:
> On Monday, October 30, 2017 11:19:08 AM CET Rafael J. Wysocki wrote:
>> On Mon, Oct 30, 2017 at 8:10 AM, Tero Kristo <t-kristo@ti.com> wrote:
>>> The recent change to the PM QoS framework to introduce a proper
>>> no constraint value overlooked to handle the devices which don't
>>> implement PM QoS OPS. Runtime PM is one of the more severely
>>> impacted subsystems, failing every attempt to runtime suspend
>>> a device. This leads into some nasty second level issues like
>>> probe failures and increased power consumption among other things.
>>
>> Oh, that's bad.
>>
>> Sorry about breaking it and thanks for the fix!
>>
>>> Fix this by adding a proper return value for devices that don't
>>> implement PM QoS implicitly.
>>>
>>> Fixes: 0cc2b4e5a020 ("PM / QoS: Fix device resume latency PM QoS")
>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Applied.
> 
> And pushed to Linus.
> 
> That said, probe shouldn't ever fail if PM QoS is set to the
> "never suspend" value.
> 
> User space can set it that way, after all, so the drivers that fail to probe
> in that case aren't correct I'm afraid.

Ok interesting. The probe failure we had was a second order issue. A 
driver (omap_nmailbox) was attempting to pm_runtime_get_sync() 
...put_sync() during probe, and checked the return value of 
pm_runtime_put_sync() which was -EPERM and bailed out. Most of the time, 
drivers don't check the return value of this and will just succeed. I 
did a grep on kernel and there are few other drivers that check the 
return value also, didn't check if they do this during probe though but 
it can potentially cause various issues elsewhere also.

So, you are saying we should not check the return value of 
pm_runtime_put_x() ever, or should check if it is -EPERM and just pass 
in that case? Is there any point returning -EPERM from the runtime core 
at all then? This should probably be filtered out within runtime core as 
a valid situation and just return 0.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
