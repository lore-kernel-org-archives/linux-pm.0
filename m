From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 2/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Wed, 04 Sep 2013 16:50:01 -0700
Message-ID: <5227C729.5040803@codeaurora.org>
References: <085013f4e584e3fef97187bcb349c3fa76942e19.1378012620.git.viresh.kumar@linaro.org> <80c4bd8c577e5da0aa63342671773be5cdc26a9a.1378012620.git.viresh.kumar@linaro.org> <5225E205.7080008@linux.vnet.ibm.com> <1706734.hVYFTCa5rJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1706734.hVYFTCa5rJ@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09/04/13 16:55, Rafael J. Wysocki wrote:
>
> Well, I'm not sure when Viresh is going to be back.
>
> Srivatsa, can you please resend this patch with a proper changelog?
>

I haven't had a chance to try this out yet, but I was just thinking
about this patch. How is it going to work? If one task opens the file
and another task is taking down the CPU wouldn't we deadlock in the
CPU_DOWN notifier waiting for the kobject to be released? Task 1 will
grab the kobject reference and sleep on the hotplug mutex and task 2
will put the kobject and wait for the completion, but it won't happen.
At least I think that's what would happen.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

