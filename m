From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Fix the driver can not be unloaded issue
Date: Thu, 25 Apr 2013 16:56:53 +0530
Message-ID: <CAKohponjJ-30omoXJM94TE2Zs=8zT1Vkgcptd6KcvdY_ztqRsw@mail.gmail.com>
References: <1366792092-10407-1-git-send-email-Yuantian.Tang@freescale.com>
	<CAKohpomcSP4HegdQfJYDe6UHa6CTuV-G9UCb8QFDxfDvcTzsYw@mail.gmail.com>
	<D07C73A334FF604B95B3CBD2A545D07B0B165120@039-SN2MPN1-011.039d.mgd.msft.net>
	<CAKohpokWAKQDsf-6LrjDnjyKFuuZTsCYCOuiEqsv0wO0i5Ny-A@mail.gmail.com>
	<D07C73A334FF604B95B3CBD2A545D07B0B165358@039-SN2MPN1-011.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <D07C73A334FF604B95B3CBD2A545D07B0B165358@039-SN2MPN1-011.039d.mgd.msft.net>
Sender: cpufreq-owner@vger.kernel.org
To: Tang Yuantian-B29983 <B29983@freescale.com>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

On 25 April 2013 16:08, Tang Yuantian-B29983 <B29983@freescale.com> wrote:
> That's wired. I will have more tests on this. Thanks.
>
> I found another bug you can try.
> It is also found on multiple cpus per cluster.
> Test step:
> 1. compile the driver as module.
> 2. hot-unplug one cpu( any one is OK)
> 3. insmod module
> 4. hot-plug the cpu ----> will cause error.
>
> Or test step also can be:
> 1. hot-unplug all the cpus in one cluster
> 2. hot-plug the cpus in this cluster. When the second cpu gets hot-pluged, error will occur.
>
> That's because the second cpu will call the cpufreq_add_dev_symlink() to
> Create the first cpu's "cpufreq link" which is already created.
> That needs more work to make a patch, hope you can fix it.

Haven't tested it now but i know why that can happen. It will happen only if
driver->init() isn't setting policy->cpus correctly. You need to set
both online &
offline cpus, but in your setup it looks you are setting only online cpus and
so cpufreq core isn't able to use the earlier policy struct for offline cpus.

And so it created a new struct cpufreq_policy for second cpu and trying to
add links for all other cpus too... (which share this policy)..
