From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: conservative: fix requested_freq reduction issue
Date: Fri, 8 Nov 2013 10:25:09 +0530
Message-ID: <CAKohpon6DhiWMuszuznK4ZNCBTpy0_r3gGvTXCDMcktXpN3HEw@mail.gmail.com>
References: <1383791330-8289-1-git-send-email-chenxg@marvell.com>
	<CAKohpo=2xjR=nr5hyMg9bve5_uVbV79R2FTxks0bLmL7kNV9Mg@mail.gmail.com>
	<CADmjqpNWYVxrXuo106rBuZeZ2BrkGFkmbMJ8jxi39c8kLiQ+iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADmjqpNWYVxrXuo106rBuZeZ2BrkGFkmbMJ8jxi39c8kLiQ+iw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stratos Karafotis <skarafotis@gmail.com>
Cc: Xiaoguang Chen <chenxg@marvell.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Xiaoguang Chen <chenxg.marvell@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 8 November 2013 00:36, Stratos Karafotis <skarafotis@gmail.com> wrote:
> I think the existing code already checks if the requested_freq is greater
> than policy->max in __cpufreq_driver_target.

Yes it does. But the problem is:
- cs_check_cpu() sets requested_freq above policy->max
- We execute following code because (requested_freq != policy->max)

    dbs_info->requested_freq += get_freq_target(cs_tuners, policy);
    __cpufreq_driver_target(policy, dbs_info->requested_freq,
CPUFREQ_RELATION_H);
- In __cpufreq_driver_target(), we don't do anything and return early..
- Above will keep on repeating all the time..

If we change the code as I have suggested it to be:
- After first loop where requested_freq went over policy->max, we will
return early from cs_check_cpu(), but we have already set freq to max..

> If we put this check earlier, cpufreq will never reach policy->max.

Can you please explain why do you see that happening?
