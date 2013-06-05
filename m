From: Michael Wang <wangyun@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: prevent 'policy->cpus' become offline in __gov_queue_work()
Date: Wed, 05 Jun 2013 16:58:44 +0800
Message-ID: <51AEFDC4.8070801@linux.vnet.ibm.com>
References: <51AEFBA1.302@linux.vnet.ibm.com> <CAKohpom571kXwLVPzmAb1n16EuHwyOaiM3khXkjQZQixGCpX8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpom571kXwLVPzmAb1n16EuHwyOaiM3khXkjQZQixGCpX8Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, rjw@sisk.pl, Jiri Kosina <jkosina@suse.cz>, Borislav Petkov <bp@alien8.de>, Frederic Weisbecker <fweisbec@gmail.com>, "tony.luck@intel.com" <tony.luck@intel.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

Hi, Viresh

On 06/05/2013 04:53 PM, Viresh Kumar wrote:
[snip]
>> It was caused by the policy->cpus changed during the process of
>> __gov_queue_work(), in other word, cpu offline happened.
>>
>> This patch will use get/put_online_cpus() to prevent the offline
>> happen inside __gov_queue_work(), after applied the patch, the
>> warning is gone as Jiri tested:
>>
>>         Link: https://lkml.org/lkml/2013/6/5/88
>>
>> CC: "Rafael J. Wysocki" <rjw@sisk.pl>
>> CC: Viresh Kumar <viresh.kumar@linaro.org>
>> Reported-by: Borislav Petkov <bp@alien8.de>
>> Reported-by: Jiri Kosina <jkosina@suse.cz>
>> Tested-by: Jiri Kosina <jkosina@suse.cz>
>> Signed-off-by: Michael Wang <wangyun@linux.vnet.ibm.com>
>> ---
>>  drivers/cpufreq/cpufreq_governor.c |    3 +++
>>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks for your ack :)

Regards,
Michael Wang

> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
