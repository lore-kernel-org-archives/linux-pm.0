From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq-dt: support cluster level clock
Date: Tue, 3 Mar 2015 22:03:31 +0800
Message-ID: <20150303140331.GA11325@leoy-linaro>
References: <1425387817-11382-1-git-send-email-leo.yan@linaro.org>
 <1425387817-11382-2-git-send-email-leo.yan@linaro.org>
 <CAKohpoksXwMRWYzSBmbV1nN5_LvUiB1Y2wfgOcCJPx+oipaXZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35909 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754262AbbCCODj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2015 09:03:39 -0500
Received: by pdbnh10 with SMTP id nh10so25045654pdb.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2015 06:03:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAKohpoksXwMRWYzSBmbV1nN5_LvUiB1Y2wfgOcCJPx+oipaXZw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Mar 03, 2015 at 06:40:23PM +0530, Viresh Kumar wrote:
> On 3 March 2015 at 18:33, Leo Yan <leo.yan@linaro.org> wrote:
> > In the previous code, cpufreq-dt driver support single clock shared by
> > all CPUs or every CPU has dedicated clock; but it cannot support cluster
> > level clock domain, which is very common implementation for ARM SoCs.
> >
> > So this patch add the support for cluster level clock; which use the
> > platform parameter "clk_domain_boundary" to indicate whether the clock
> > domain is bound to system level, cluster level or CPU level.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> No. We aren't going to do it this way. You just test your current SoC where
> all CPUs share clock line. The other SoC that might come later, where
> clocks are per cluster, can be handled later.
> 
> So, for now you don't need any changes in the driver I believe.

Correct, current SoC shares one clock line.

I'm just thinking to finish things in one time. From my previous
experience, clocks per cluster are common cases for ARM's
multi-clusters, so i think it's reasonable to add related support.

Regarding of testing this patch, i created two virtual clocks for
every cluster and passed the test. Do u think this is acceptable?

Thanks,
Leo Yan
