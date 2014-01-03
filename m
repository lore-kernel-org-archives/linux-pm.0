From: Jane Li <jiel@marvell.com>
Subject: Re: [PATCH v2] cpufreq: Fix timer/workqueue corruption by protecting
 reading governor_enabled
Date: Fri, 3 Jan 2014 14:44:31 +0800
Message-ID: <52C65C4F.1060804@marvell.com>
References: <1388632482-16921-1-git-send-email-jiel@marvell.com> <20140102232638.GA21548@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140102232638.GA21548@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


On 01/03/2014 07:26 AM, Dmitry Torokhov wrote
> Unlocking in different branches is not the best practice IMO, I'd
> recommend doing:
>
> 	mutex_lock(&cpufreq_governor_lock);
>
> 	if (!policy->governor_enabled)
> 		goto out_unlock;
>
> 	...
>
> out_unlock:
> 	mutex_unlock(&cpufreq_governor_lock);
>
> Thanks!
>
OK. I have pushed PATCH v3. Please review again.

Besides, I use checkpatch.pl to check this patch, and find there is warning. PATCH v3 also move cpufreq_governor_lock declaration to cpufreq.h.

WARNING: externs should be avoided in .c files
#106: FILE: drivers/cpufreq/cpufreq_governor.c:25:
+extern struct mutex cpufreq_governor_lock;

Thanks!
