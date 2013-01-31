From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: exynos: Broadcast frequency change notifications
 for all cores
Date: Thu, 31 Jan 2013 20:46:10 +0530
Message-ID: <CAKohpomEcrPa7UnZmtTouxN6JXxcaa7dBstMGUWjXGL0n1+=Ng@mail.gmail.com>
References: <1887364.fvxYYNb7Mm@amdc1227>
	<1520677.WES295RohH@amdc1227>
	<CAKohpombSKY-HMXovBAyZd5Ce8ZAEo2+yiwYL1G4=OEUJM1u5g@mail.gmail.com>
	<1520678.Zm627xxIN3@amdc1227>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:37894 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab3AaPQL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Jan 2013 10:16:11 -0500
Received: by mail-oa0-f49.google.com with SMTP id j6so3031065oag.8
        for <linux-pm@vger.kernel.org>; Thu, 31 Jan 2013 07:16:11 -0800 (PST)
In-Reply-To: <1520678.Zm627xxIN3@amdc1227>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

On 31 January 2013 20:34, Tomasz Figa <t.figa@samsung.com> wrote:
> Well, the fact that it isn't used at the moment doesn't mean that it
> shouldn't be set correctly. The field is present in the structure and has
> a set of defined values - one of which should be selected. For example,
> I can imagine some governor taking this information into account.

Governors already take this information but from a different variable:
policy->cpus.

Look at the patch which added it:

commit 3b2d99429e3386b6e2ac949fc72486509c8bbe36
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Wed Dec 14 15:05:00 2005 -0500

    P-state software coordination for ACPI core

    http://bugzilla.kernel.org/show_bug.cgi?id=5737

    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_perflib.c | 228
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/acpi/processor.h         |  27 ++++++++++++-
 include/linux/cpufreq.h          |   4 ++
 3 files changed, 258 insertions(+), 1 deletion(-)


It was clearly for ACPI, but was probably named badly and we people
got confused that it is for our use.

--
viresh
