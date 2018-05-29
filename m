From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: reinitialize new policy min/max when writing scaling_(max|min)_freq
Date: Tue, 29 May 2018 10:45:57 +0200
Message-ID: <3949526.VSbr9bPLlU@aspire.rjw.lan>
References: <1527144234-96396-1-git-send-email-kevin.wangtao@hisilicon.com> <CAJZ5v0ih6s9WviSpg9D+kSt2h8T5Vnx-MziOmYuk1H4yZOYLNg@mail.gmail.com> <7700fad7-211d-d8b2-e4ee-975c1cf1f9dc@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7700fad7-211d-d8b2-e4ee-975c1cf1f9dc@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Wangtao (Kevin, Kirin)" <kevin.wangtao@hisilicon.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, gengyanping@hisilicon.com, sunzhaosheng@hisilicon.com
List-Id: linux-pm@vger.kernel.org

On Friday, May 25, 2018 4:54:04 AM CEST Wangtao (Kevin, Kirin) wrote:
> 
> 在 2018/5/24 15:45, Rafael J. Wysocki 写道:
> > On Thu, May 24, 2018 at 8:43 AM, Kevin Wangtao
> > <kevin.wangtao@hisilicon.com> wrote:
> >> consider such situation, current user_policy.min is 1000000,
> >> current user_policy.max is 1200000, in cpufreq_set_policy,
> >> other driver may update policy.min to 1200000, policy.max to
> >> 1300000. After that, If we input "echo 1300000 > scaling_min_freq",
> >> then user_policy.min will be 1300000, and user_policy.max is
> >> still 1200000, because the input value is checked with policy.max
> >> not user_policy.max. if we get all related cpus offline and
> >> online again, it will cause cpufreq_init_policy fail because
> >> user_policy.min is higher than user_policy.max.
> > 
> > How do you reproduce this, exactly?
>
> I write a driver register CPUFREQ_POLICY_NOTIFIER, and when event is CPUFREQ_ADJUST,
> it will modify policy's min/max according to some conditions, I test it with writing
> scaling_(max|min)_freq to traverse all frequencies repeatly, and also repeat hotplug
> as background.

You are expected to use cpufreq_update_policy() to update the limits in policy
notifiers.  Do you use it in your driver?
