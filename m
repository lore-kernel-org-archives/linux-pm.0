From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH] cpufreq: Don't destroy/realloc policy/sysfs on hotplug/suspend
Date: Wed, 23 Jul 2014 20:02:15 -0700
Message-ID: <53D07737.70904@codeaurora.org>
References: <1404959850-11617-1-git-send-email-skannan@codeaurora.org> <16164926.ZsJxe6UV3e@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <16164926.ZsJxe6UV3e@vostro.rjw.lan>
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Todd Poynor <toddpoynor@google.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

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
>

Ok, I think I've figured this out. But one question. Is it possible to 
physically remove one CPU in a bunch of "related cpus" without also 
unplugging the rest? Put another way, can you unplug one core from a 
cluster?

It's not too hard to support that too, but if it's not a realistic case, 
I would rather not write code for that.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
