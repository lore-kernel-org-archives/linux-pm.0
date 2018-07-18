From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] cpufreq: pcc-cpufreq: Disable dynamic scaling on
 many-CPU systems
Date: Wed, 18 Jul 2018 09:44:14 +0200
Message-ID: <CAJZ5v0i-zrKEVh+KsNOgTpCCBaC7jqibyuz1QhiKWPCV-H4srA@mail.gmail.com>
References: <20180717065048.74mmgk4t5utjaa6a@suselix> <306375154.NhdH6AhdAd@aspire.rjw.lan>
 <5423012.ZZnfdYddaT@aspire.rjw.lan> <20180717201323.6rwb4yklq46cmtom@suselix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717201323.6rwb4yklq46cmtom@suselix>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Herrmann <aherrmann@suse.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 17, 2018 at 10:13 PM, Andreas Herrmann <aherrmann@suse.com> wrote:
> On Tue, Jul 17, 2018 at 06:14:58PM +0200, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> The firmware interface used by the pcc-cpufreq driver is
>> fundamentally not scalable and using it for dynamic CPU performance
>> scaling on systems with many CPUs leads to degraded performance.
>>
>> For this reason, disable dynamic CPU performance scaling on systems
>> with pcc-cpufreq where the number of CPUs present at the driver init
>> time is greater than 4.  Also make the driver print corresponding
>> complaints to the kernel log.
>>
>> Reported-by: Andreas Herrmann <aherrmann@suse.com>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>
>> -> v2: Rework the messages printed in the problematic case.
>
> I've tested this patch. Effect is as expected: driver loads but use of
> ondemand governor is not allowed. Sample output:
>
> [   40.757519] pcc-cpufreq: (v1.10.00) driver loaded with frequency limits: 1200 MHz, 2800 MHz
> [   40.831705] pcc_cpufreq_init: Too many CPUs, dynamic performance scaling disabled
> [   40.898353] pcc_cpufreq_init: Try to enable a different scaling driver through BIOS settings
> [   40.972327] pcc_cpufreq_init: and complain to the system vendor
> [   41.025620] cpufreq: Can't use ondemand governor as dynamic switching is disallowed. Fallback to performance governor
> ...
> [   41.187928] cpufreq: Can't use ondemand governor as dynamic switching is disallowed. Fallback to performance governor
>
> Last message is shown for each online CPU in the system  (ie. 120x).
>
> Looks good to me.

Thanks a lot!

Please also try https://patchwork.kernel.org/patch/10530321/

Cheers,
Rafael
