From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpufreq: prevent 'policy->cpus' become offline in __gov_queue_work()
Date: Wed, 05 Jun 2013 14:37:50 +0200
Message-ID: <1862476.P5VBB45STK@vostro.rjw.lan>
References: <51AEFBA1.302@linux.vnet.ibm.com> <CAKohpom571kXwLVPzmAb1n16EuHwyOaiM3khXkjQZQixGCpX8Q@mail.gmail.com> <51AEFDC4.8070801@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51AEFDC4.8070801@linux.vnet.ibm.com>
Sender: cpufreq-owner@vger.kernel.org
To: Michael Wang <wangyun@linux.vnet.ibm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Borislav Petkov <bp@alien8.de>, Frederic Weisbecker <fweisbec@gmail.com>, "tony.luck@intel.com" <tony.luck@intel.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, June 05, 2013 04:58:44 PM Michael Wang wrote:
> Hi, Viresh
> 
> On 06/05/2013 04:53 PM, Viresh Kumar wrote:
> [snip]
> >> It was caused by the policy->cpus changed during the process of
> >> __gov_queue_work(), in other word, cpu offline happened.
> >>
> >> This patch will use get/put_online_cpus() to prevent the offline
> >> happen inside __gov_queue_work(), after applied the patch, the
> >> warning is gone as Jiri tested:
> >>
> >>         Link: https://lkml.org/lkml/2013/6/5/88
> >>
> >> CC: "Rafael J. Wysocki" <rjw@sisk.pl>
> >> CC: Viresh Kumar <viresh.kumar@linaro.org>
> >> Reported-by: Borislav Petkov <bp@alien8.de>
> >> Reported-by: Jiri Kosina <jkosina@suse.cz>
> >> Tested-by: Jiri Kosina <jkosina@suse.cz>
> >> Signed-off-by: Michael Wang <wangyun@linux.vnet.ibm.com>
> >> ---
> >>  drivers/cpufreq/cpufreq_governor.c |    3 +++
> >>  1 files changed, 3 insertions(+), 0 deletions(-)
> > 
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Thanks for your ack :)

Queued up for 3.10.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
