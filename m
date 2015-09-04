From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v2 7/7] ARM: smp: Add runtime PM support for CPU hotplug
Date: Sat, 5 Sep 2015 00:46:37 +0300
Message-ID: <55EA113D.9000806@ti.com>
References: <Pine.LNX.4.44L0.1509041443360.29995-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38519 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933638AbbIDVrm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Sep 2015 17:47:42 -0400
In-Reply-To: <Pine.LNX.4.44L0.1509041443360.29995-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Lina Iyer <lina.iyer@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Mark Rutland <mark.rutland@arm.com>, ulf.hansson@linaro.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, rjw@rjwysocki.net, k.kozlowski@samsung.com, msivasub@codeaurora.org, khilman@linaro.org, geert@linux-m68k.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org

On 09/04/2015 09:45 PM, Alan Stern wrote:
> On Fri, 4 Sep 2015, Grygorii Strashko wrote:
> 
>> There is one "small" problem with such approach :(
>>
>> - It's incompatible with -RT kernel, because PM runtime can't be used
>> in atomic context on -RT.
> 
> Can you explain this more fully?  Why can't runtime PM be used in
> atomic context in the -rt kernels?
>  

See:
 http://lwn.net/Articles/146861/
 https://rt.wiki.kernel.org/index.php/Frequently_Asked_Questions#How_does_the_CONFIG_PREEMPT_RT_patch_work.3F

spinlock_t
    Critical sections are preemptible. The _irq operations (e.g., spin_lock_irqsave())
 do -not- disable hardware interrupts. Priority inheritance is used to prevent priority
 inversion. An underlying rt_mutex is used to implement spinlock_t in PREEMPT_RT. 

As result, have to do things like:
https://lkml.org/lkml/2015/8/18/161
https://lkml.org/lkml/2015/8/18/162

Sorry for brief reply - Friday/Sat night :)

-- 
regards,
-grygorii
