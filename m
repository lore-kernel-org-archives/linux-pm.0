From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: Fix possible memory leak during CPU removal
Date: Thu, 23 Jul 2015 11:52:19 +0530
Message-ID: <20150723062219.GE5322@linux>
References: <3005422.83Yq8KhGHU@vostro.rjw.lan>
 <1975585.UxCn1xIBB2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35711 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbbGWGWY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 02:22:24 -0400
Received: by pabkd10 with SMTP id kd10so80025798pab.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2015 23:22:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1975585.UxCn1xIBB2@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On 23-07-15, 00:27, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After commit 9b07109f06a1 (cpufreq: Fix double addition of sysfs
> links) the second sif argument of __cpufreq_remove_dev_prepare()
> and __cpufreq_remove_dev_finish() is not used by them any more.
> 
> However, there also is a problem in cpufreq_remove_dev() that
> if any of the above functions returns an error, we'll fail to
> clean up after a CPU that is going away (and it is going away
> no matter what).  Moreover, error codes returned by them are
> ignored by cpufreq_cpu_callback(), so even if any of them is
> aborted and returns an error code, the caller of the notifier
> callback will not know about that.
> 
> For this reason, make __cpufreq_remove_dev_prepare() and
> __cpufreq_remove_dev_finish() never fail, change them to void
> functions and drop the sif argument from them.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> On top of:
> http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=9b07109f06a1edd6e636b1e7397157eae0e6baa4
> 
> Note: The commit mentioned above is on a testing branch only
> at the moment.
> 
> Well, I seem to be blind.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
