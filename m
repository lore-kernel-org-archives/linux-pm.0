From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/2] cpufreq: governor: Fix race in
 dbs_update_util_handler()
Date: Mon, 22 Feb 2016 19:15:07 +0530
Message-ID: <20160222134507.GQ28226@vireshk-i7>
References: <2410542.x6e5Rli2VY@vostro.rjw.lan>
 <2648721.JQxjFin8bu@vostro.rjw.lan>
 <5317526.c8CQkS0X5t@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35433 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754695AbcBVNp1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2016 08:45:27 -0500
Received: by mail-pf0-f175.google.com with SMTP id c10so96160283pfc.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Feb 2016 05:45:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5317526.c8CQkS0X5t@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 22-02-16, 14:14, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There is a scenario that may lead to undesired results in
> dbs_update_util_handler().  Namely, if two CPUs sharing a policy
> enter the funtion at the same time, pass the sample delay check
> and then one of them is stalled until dbs_work_handler() (queued
> up by the other CPU) clears the work counter, it may update the
> work counter and queue up another work item prematurely.
> 
> To prevent that from happening, use the observation that the CPU
> queuing up a work item in dbs_update_util_handler() updates the
> last sample time.  This means that if another CPU was stalling after
> passing the sample delay check and now successfully updated the work
> counter as a result of the race described above, it will see the new
> value of the last sample time which is different from what it used in
> the sample delay check before.  If that happens, the sample delay
> check passed previously is not valid any more, so the CPU should not
> continue.
> 
> Fixes: f17cbb53783c (cpufreq: governor: Avoid atomic operations in hot paths)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Changes from v1:
> - Typo in the changelog fixed.
> - READ_ONCE() used instead of ACCESS_ONCE().
> - If the race is detected, return instead of looping.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
