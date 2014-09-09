From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] intel_pstate: track and export frequency residency stats
 via sysfs.
Date: Tue, 9 Sep 2014 10:33:23 +0530
Message-ID: <CAKohponb199_zt11M2J39yHn45MjFMSrT+hPBp7rbqiHu4vKpQ@mail.gmail.com>
References: <1410221424-20590-1-git-send-email-anupc@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:50583 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbaIIFDY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Sep 2014 01:03:24 -0400
Received: by mail-oa0-f48.google.com with SMTP id m1so11253955oag.7
        for <linux-pm@vger.kernel.org>; Mon, 08 Sep 2014 22:03:23 -0700 (PDT)
In-Reply-To: <1410221424-20590-1-git-send-email-anupc@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anup Chenthamarakshan <anupc@chromium.org>
Cc: Dirk Brandewie <dirk.j.brandewie@intel.com>, Sameer Nanda <snanda@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 9 September 2014 05:40, Anup Chenthamarakshan <anupc@chromium.org> wrote:
> Exported stats appear in
> <sysfs>/devices/system/cpu/intel_pstate/time_in_state as follows:
>
> ## CPU 0
> 400000 3647
> 500000 24342
> 600000 144150
> 700000 202469
> ## CPU 1
> 400000 4813
> 500000 22628
> 600000 149564
> 700000 211885
> 800000 173890
>
> Signed-off-by: Anup Chenthamarakshan <anupc@chromium.org>
> ---
>  drivers/cpufreq/intel_pstate.c | 77 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 74 insertions(+), 3 deletions(-)

Why don't we reuse cpufreq_stats.c for all this?
