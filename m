From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH v4 3/5] cpufreq: Don't destroy/realloc policy/sysfs on
 hotplug/suspend
Date: Thu, 31 Jul 2014 15:15:47 -0700
Message-ID: <53DAC013.1070708@codeaurora.org>
References: <1406250448-470-1-git-send-email-skannan@codeaurora.org> <1406250448-470-4-git-send-email-skannan@codeaurora.org> <3141717.0s1tLjazMZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <3141717.0s1tLjazMZ@vostro.rjw.lan>
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Todd Poynor <toddpoynor@google.com>, "Srivatsa S . Bhat" <srivatsa@mit.edu>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 07/31/2014 02:56 PM, Rafael J. Wysocki wrote:
> On Thursday, July 24, 2014 06:07:26 PM Saravana Kannan wrote:
>> This patch simplifies a lot of the hotplug/suspend code by not
>> adding/removing/moving the policy/sysfs/kobj during hotplug and just leaves
>> the cpufreq directory and policy in place irrespective of whether the CPUs
>> are ONLINE/OFFLINE.
>
> I'm still quite unsure how this is going to work with the real CPU hot-remove
> that makes the entire sysfs cpu directories go away.  Can you please explain
> that?

With this patch it won't work correctly. 4/5 fixes it to work correctly. 
Just keeping them separate to make it easy to review.

We can squash 3/5 and 4/5 later if people prefer it that way.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
