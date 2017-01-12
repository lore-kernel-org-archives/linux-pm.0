From: Alex Shi <alex.shi@linaro.org>
Subject: Re: [PATCH 2/3] cpu: expose pm_qos_resume_latency for each cpu
Date: Thu, 12 Jan 2017 21:04:49 +0800
Message-ID: <07da6cd8-9973-568d-c22c-01cfd51e3761@linaro.org>
References: <1483630187-29622-1-git-send-email-alex.shi@linaro.org>
 <1483630187-29622-3-git-send-email-alex.shi@linaro.org>
 <20170111080927.GA6689@kroah.com>
 <3344ad77-62db-830f-94db-f4bdd7257478@linaro.org>
 <CAJZ5v0hG6UgKDObTaOWy08EhY9uZh9o4=pRW_zjSAbY4c_u5Vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hG6UgKDObTaOWy08EhY9uZh9o4=pRW_zjSAbY4c_u5Vw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, open list <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org



On 01/12/2017 02:40 AM, Rafael J. Wysocki wrote:
>> >
>> > Hi Greg,
>> >
>> > Thanks for comments!
>> >
>> > The function dev_pm_qos_expose_latency_limit() is null if no CONFIG_PM.
>> > So when CONFIG_PM enabled, may we could consider the cpu idle is also
>> > wanted. In this assumption the #ifdef could be removed. If user want to
>> > use this feature, she/he should understand the feature only work on menu
>> > gov only currently. So consider this, I guess we could remove this
>> > #ifdef. :)
> But instead of putting the #ifdef into the function body, you can use
> a wrapper function defined to be empty for CONFIG_PM unset.

Thanks Rafael!

The function dev_pm_qos_expose_latency_limit() is empty now when
CONFIG_PM disabled. :)
I will resend the patch without the #ifdef.

Thanks!
Alex
