From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: governors: Remove duplicate check of target freq
 in supported range
Date: Tue, 27 Aug 2013 11:27:54 +0530
Message-ID: <CAKohpo=xBmpEv=oN1qEnq9RKhfjtc4wZayVYyVzjWOU8BnwVJQ@mail.gmail.com>
References: <521BA068.8030003@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <521BA068.8030003@semaphore.gr>
Sender: cpufreq-owner@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 27 August 2013 00:07, Stratos Karafotis <stratosk@semaphore.gr> wrote:
>  drivers/cpufreq/cpufreq_conservative.c | 4 ----

Get rid of few more checks..

/* if we are already at full speed then break out early */
if (dbs_info->requested_freq == policy->max)
return;


/*
* if we cannot reduce the frequency anymore, break out early
*/
if (policy->cur == policy->min)
return;
