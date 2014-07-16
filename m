From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH] cpufreq: Don't destroy/realloc policy/sysfs on hotplug/suspend
Date: Wed, 16 Jul 2014 15:35:27 -0700
Message-ID: <53C6FE2F.8080408@codeaurora.org>
References: <1404959850-11617-1-git-send-email-skannan@codeaurora.org> <16164926.ZsJxe6UV3e@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:47450 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbaGPWf2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jul 2014 18:35:28 -0400
In-Reply-To: <16164926.ZsJxe6UV3e@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Todd Poynor <toddpoynor@google.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 07/16/2014 03:02 PM, Rafael J. Wysocki wrote:
> On Wednesday, July 09, 2014 07:37:30 PM Saravana Kannan wrote:
>> Preliminary patch. Not tested. Just sending out to give an idea of what I'm
>> looking to do. Expect a lot more simplification when it's done.
>>
>> Benefits:
>> * A lot more simpler code.
>> * Less stability issues.
>> * Suspend/resume time would improve.
>> * Hotplug time would improve.
>> * Sysfs file permissions would be maintained.
>> * More policy settings would be maintained across suspend/resume.
>> * cpufreq stats would be maintained across hotplug for all CPUs.
>
> One problem.  The real hotplug (when the CPU actually goes away) depends on
> offline removing all that stuff for it.  How are you going to address that?

policy, sysfs and kobj are just SW state inside cpufreq core. So, that 
shouldn't really affect what happens in HW when the CPU really is 
hotplugged. Can you please elaborate what you mean?

The only thing that this code assumes is that in real hotplug case too, 
that the /sys/system/devices/cpuX directory doesn't go away. I don't 
think it does. Does it?

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
