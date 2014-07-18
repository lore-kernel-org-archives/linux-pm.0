From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH v3 1/2] cpufreq: Don't destroy/realloc policy/sysfs on
 hotplug/suspend
Date: Thu, 17 Jul 2014 20:25:03 -0700
Message-ID: <53C8938F.1070706@codeaurora.org>
References: <1405464473-3916-1-git-send-email-skannan@codeaurora.org> <1405464473-3916-2-git-send-email-skannan@codeaurora.org> <CAKohpok2hzwDLy77CZJ+7pHV-Nj4XTviJxVeXQYJRYtKXME00w@mail.gmail.com> <53C65F03.1050609@mit.edu> <53C6D8EC.1030609@codeaurora.org> <CAKohpongsNtEVbHL=w1fbw5tEXK=WaMcp1N03ar9Sx_CU=1O-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAKohpongsNtEVbHL=w1fbw5tEXK=WaMcp1N03ar9Sx_CU=1O-w@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Srivatsa S. Bhat" <srivatsa@mit.edu>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Todd Poynor <toddpoynor@google.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 07/16/2014 10:35 PM, Viresh Kumar wrote:
> On 17 July 2014 01:26, Saravana Kannan <skannan@codeaurora.org> wrote:
>> On 07/16/2014 04:16 AM, Srivatsa S. Bhat wrote:
>
>>> That is, we wanted
>>> to do the kobject cleanup after releasing the hotplug lock, and POST_DEAD
>>> stage was well-suited for that.
>
> I think, this has changed in Saravana's patch, we do it in the PREPARE stage
> now.

Not really. We much never do it during hotplug. We only do it when the 
cpufreq driver unregisters.

This should be easier to see in v4, where I'm breaking up the patches 
into easier diffs.

>>> Commit 1aee40ac9c8 (cpufreq: Invoke __cpufreq_remove_dev_finish() after
>>> releasing cpu_hotplug.lock) explains this in detail. Saravana, please take
>>> a
>>> look at that reasoning and ensure that your patch doesn't re-introduce
>>> those
>>> deadlock possibilities!
>>
>>
>> But all of that was needed _because_ we were creating and destroying
>> policies and kobjs all the time. We don't do that anymore. So, I don't think
>> any of that applies. We only destroy when the cpufreq driver is
>> unregistered. That's kinda of the point of this patchset.
>>
>> Thoughts?
>
> See above.
>

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
