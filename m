From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: cpufreq_stats in the absence of frequency table
Date: Wed, 03 Aug 2016 01:49:12 +0200
Message-ID: <4103198.vv1olU1ZFT@vostro.rjw.lan>
References: <1470179937-14698-1-git-send-email-pprakash@codeaurora.org> <1547887.jMFZtBx5tV@vostro.rjw.lan> <5a559b20-28f5-5b51-6b8e-11d7884709ab@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:41731 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754391AbcHBXoP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Aug 2016 19:44:15 -0400
In-Reply-To: <5a559b20-28f5-5b51-6b8e-11d7884709ab@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>
Cc: linux-pm@vger.kernel.org, viresh.kumar@linaro.org, alexey.klimov@arm.com, hotran@apm.com, cov@codeaurora.org

On Tuesday, August 02, 2016 05:41:24 PM Prakash, Prashanth wrote:
> Hi Rafael,
> 
> On 8/2/2016 5:27 PM, Rafael J. Wysocki wrote:
> > On Tuesday, August 02, 2016 05:18:57 PM Prashanth Prakash wrote:
> >> cpufreq drivers such as CPPC works on contigious scale and does
> >> not have a static frequency table. This commit adds cpufreq_stats
> >> support for such drivers by creating a pseudo frequency table by
> >> discretizing the contigious scale.
> > No.
> >
> > And why?
> The motivation is to be able to collect the frequency distribution data via
> time_in_state sysfs entry as we can collect for other cpufreq drivers that
> uses a frequency table.

Which can be done by using the cpu_frequency trace point just fine, can't it?

Plus, cpufreq_stats don't work with the schedutil governor and fast frequency
switching anyway.

Thanks,
Rafael

