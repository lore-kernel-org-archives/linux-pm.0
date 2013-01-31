From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH] cpufreq: exynos: Broadcast frequency change notifications
 for all cores
Date: Thu, 31 Jan 2013 17:07:06 +0100
Message-ID: <1604688.EafV1ohaV9@amdc1227>
References: <1887364.fvxYYNb7Mm@amdc1227> <1520678.Zm627xxIN3@amdc1227>
 <CAKohpomEcrPa7UnZmtTouxN6JXxcaa7dBstMGUWjXGL0n1+=Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:42572 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775Ab3AaQHW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Jan 2013 11:07:22 -0500
In-reply-to: <CAKohpomEcrPa7UnZmtTouxN6JXxcaa7dBstMGUWjXGL0n1+=Ng@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Thursday 31 of January 2013 20:46:10 Viresh Kumar wrote:
> On 31 January 2013 20:34, Tomasz Figa <t.figa@samsung.com> wrote:
> > Well, the fact that it isn't used at the moment doesn't mean that it
> > shouldn't be set correctly. The field is present in the structure and
> > has a set of defined values - one of which should be selected. For
> > example, I can imagine some governor taking this information into
> > account.
> Governors already take this information but from a different variable:
> policy->cpus.
> 
> Look at the patch which added it:
> 
> commit 3b2d99429e3386b6e2ac949fc72486509c8bbe36
> Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> Date:   Wed Dec 14 15:05:00 2005 -0500
> 
>     P-state software coordination for ACPI core
> 
>     http://bugzilla.kernel.org/show_bug.cgi?id=5737
> 
>     Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/acpi/processor_perflib.c | 228
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> +++++++++++++++++++++++++++++++++++++ include/acpi/processor.h         |
>  27 ++++++++++++-
>  include/linux/cpufreq.h          |   4 ++
>  3 files changed, 258 insertions(+), 1 deletion(-)
> 
> 
> It was clearly for ACPI, but was probably named badly and we people
> got confused that it is for our use.

Hmm. Now as I think of it, there might be another confusing aspect:

Could you explain what "sw coordination" and "any coordination" mean?
I mean specifically cpufreq_policy.cpus and cpufreq_policy.related_cpus 
masks.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Linux Platform

