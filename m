From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Fix the driver can not be unloaded issue
Date: Thu, 25 Apr 2013 13:16:49 +0530
Message-ID: <CAKohpokWAKQDsf-6LrjDnjyKFuuZTsCYCOuiEqsv0wO0i5Ny-A@mail.gmail.com>
References: <1366792092-10407-1-git-send-email-Yuantian.Tang@freescale.com>
	<CAKohpomcSP4HegdQfJYDe6UHa6CTuV-G9UCb8QFDxfDvcTzsYw@mail.gmail.com>
	<D07C73A334FF604B95B3CBD2A545D07B0B165120@039-SN2MPN1-011.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qe0-f52.google.com ([209.85.128.52]:41193 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755744Ab3DYHqu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Apr 2013 03:46:50 -0400
Received: by mail-qe0-f52.google.com with SMTP id q19so1841560qeb.11
        for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2013 00:46:49 -0700 (PDT)
In-Reply-To: <D07C73A334FF604B95B3CBD2A545D07B0B165120@039-SN2MPN1-011.039d.mgd.msft.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tang Yuantian-B29983 <B29983@freescale.com>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>

On 25 April 2013 08:16, Tang Yuantian-B29983 <B29983@freescale.com> wrote:
> It happened when policy->cpus contains *MORE THEN ONE CPU*.
> Taking my board T4240 for example, it has 3 cluster, 8 CPUs for each cluster.
> The log is:
> # insmod ppc-corenet-cpufreq.ko
> ppc_corenet_cpufreq: Freescale PowerPC corenet CPU frequency scaling driver
> # rmmod ppc-corenet-cpufreq.ko
> ERROR: Module ppc_corenet_cpufreq is in use
> # lsmod
> Module                  Size  Used by
> ppc_corenet_cpufreq     6542  9
> # uname -a
> Linux T4240 3.9.0-rc1-11081-g34642bb-dirty #44 SMP Thu Apr 25 08:58:26 CST 2013 ppc64 unknown
>
> I am not using the newest kernel (since new t4240 board has not included yet),
> but the issue is still there.
> The reason is just like what I said in patch.

I believed what you said is correct and went on testing this on my platform.
2 clusters with 2 and 3 cpus... And so i have multiple cpus per
cluster or policy
structure.

insmod/rmmod worked as expected without any issues.

So, for me there are no such issues. BTW, i tested this on latest rc from Linus
and also on latest code from linux-next.

I am sure the counts are very well balanced and there are no issues in the
latest code Atleast.
