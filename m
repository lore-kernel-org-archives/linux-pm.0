From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 00/15] cpufreq: initialize drivers .owner field with THIS_MODULE
Date: Sat, 3 Aug 2013 17:20:50 +0530
Message-ID: <CAKohpokUNe2Yy7FYUevN3gy0siuibZLk=c8=KYxS4EdVJCheBg@mail.gmail.com>
References: <cover.1375279948.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1375279948.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arnd.bergmann@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 31 July 2013 19:49, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> CPUFreq core does following at multiple places:
> module_{get|put}(cpufreq_driver->owner)).
>
> This is done to make sure module doesn't get unloaded if it is currently in use.
> This will work only if the .owner field of cpufreq driver is initialized with a
> valid pointer.
>
> This field wasn't initialized for many cpufreq driver, lets initialize it with
> THIS_MODULE.

You can drop this patchset now as .owner field is removed in the latest
patchset from me which is posted today:

"[PATCH 00/10] CPUFreq: Fixes & Cleanups for 3.12"
