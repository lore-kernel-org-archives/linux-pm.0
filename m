From: Jane Li <jiel@marvell.com>
Subject: Re: [PATCH] cpufreq: Fix timer/workqueue corruption by protecting
 reading governor_enabled
Date: Thu, 2 Jan 2014 11:15:44 +0800
Message-ID: <52C4D9E0.5070501@marvell.com>
References: <1388136651-21883-1-git-send-email-jiel@marvell.com>	<CAKohpokWMgXotgKWFmqOPzdoZME=frBQOjeU1uFJwQ778DHAKg@mail.gmail.com>	<52C112CC.4040306@marvell.com> <CAKohpomwA0PHBvFiK+-i6LDHX8J_s2hfm4-ciKFB9DSS8q0Wdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpomwA0PHBvFiK+-i6LDHX8J_s2hfm4-ciKFB9DSS8q0Wdw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

>> Yes, I test it. After adding cpufreq_governor_lock in gov_queue_work() and
>> running same test, there is no debugobjects warning.
> But it really can't work at all.. There should be a separate copy of lock
> in every file that includes cpufreq.h.. And so this shouldn't have worked.
>
Oh.. I understand what you mean now. My patch is not right and cannot fix this issue.

By default, the debugobjects warning sometimes occurs after five minutes, and sometimes occurs after twenty hours. With this patch, I test more than fifty hours, and warning did not occurs. It shows that my test time is not long enough and miss the right one.


I have updated PATCH v2, please review again. Thanks.

