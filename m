From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: unlock when failing cpufreq_update_policy()
Date: Wed, 18 Jun 2014 20:11:48 +0530
Message-ID: <CAKohpo=bGz97TJeY51M7k9VSHww=pk5TULEAROHRkp5x9-L-8w@mail.gmail.com>
References: <1403050362-20809-1-git-send-email-aplattner@nvidia.com>
	<CAKohpo=2fpi7GivgNGE+DgD3xPdku3WzKKD8+Ziz4gQ4P6pMxQ@mail.gmail.com>
	<53A1A4A9.4060301@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53A1A4A9.4060301@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Plattner <aplattner@nvidia.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On 18 June 2014 20:09, Aaron Plattner <aplattner@nvidia.com> wrote:
> I assume you meant "return -ENODEV"?

Yeah, sorry :)

>>          down_write(&policy->rwsem);
>>
>> @@ -2279,10 +2277,10 @@ int cpufreq_update_policy(unsigned int cpu)
>>
>>          ret = cpufreq_set_policy(policy, &new_policy);
>>
>> +no_policy:
>
>
> 'no_policy' implied to me that policy was NULL, so this label should still
> be renamed to 'unlock'.  I'll send out a v2 that does this.

Yeah.
