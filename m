From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/7] cpufreq: Rework two functions related to CPU offline
Date: Mon, 27 Jul 2015 20:12:50 +0530
Message-ID: <20150727144250.GC18535@linux>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan>
 <3874727.Jpay9zgokc@vostro.rjw.lan>
 <31290788.SNH4WFh3YK@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34683 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbbG0Omz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 10:42:55 -0400
Received: by pdbbh15 with SMTP id bh15so53201760pdb.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2015 07:42:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <31290788.SNH4WFh3YK@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On 27-07-15, 16:03, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since __cpufreq_remove_dev_prepare() and __cpufreq_remove_dev_finish()
> are about CPU offline rather than about CPU removal, rename them to
> cpufreq_offline_prepare() and cpufreq_offline_finish(), respectively.
> 
> Also change their argument from a struct device pointer to a CPU
> number, because they use the CPU number only internally anyway
> and make them void as their return values are ignored.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   32 ++++++++++++--------------------
>  1 file changed, 12 insertions(+), 20 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
