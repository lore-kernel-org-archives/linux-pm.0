From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Thu, 05 Sep 2013 02:26:10 +0200
Message-ID: <16630296.tCCMEKstkO@vostro.rjw.lan>
References: <085013f4e584e3fef97187bcb349c3fa76942e19.1378012620.git.viresh.kumar@linaro.org> <1706734.hVYFTCa5rJ@vostro.rjw.lan> <5227C729.5040803@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <5227C729.5040803@codeaurora.org>
Sender: cpufreq-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, September 04, 2013 04:50:01 PM Stephen Boyd wrote:
> On 09/04/13 16:55, Rafael J. Wysocki wrote:
> >
> > Well, I'm not sure when Viresh is going to be back.
> >
> > Srivatsa, can you please resend this patch with a proper changelog?
> >
> 
> I haven't had a chance to try this out yet, but I was just thinking
> about this patch. How is it going to work? If one task opens the file
> and another task is taking down the CPU wouldn't we deadlock in the
> CPU_DOWN notifier waiting for the kobject to be released? Task 1 will
> grab the kobject reference and sleep on the hotplug mutex and task 2
> will put the kobject and wait for the completion, but it won't happen.
> At least I think that's what would happen.

Do you mean the completion in sysfs_deactivate()?  Yes, we can deadlock
there.

Well, I guess the Srivatsa's patch may be salvaged by making it do a "trylock"
version of get_online_cpus(), but then I wonder if there's no better way.

Thanks,
Rafael

