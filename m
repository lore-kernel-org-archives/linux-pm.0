From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: Drop unnecessary arguments from two functions
Date: Wed, 22 Jul 2015 22:15:35 +0200
Message-ID: <3864575.4XDpB652OU@vostro.rjw.lan>
References: <1710735.NHMxY7dJsV@vostro.rjw.lan> <1661535.WGIelkkBTd@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:42753 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751154AbbGVTst (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2015 15:48:49 -0400
In-Reply-To: <1661535.WGIelkkBTd@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wednesday, July 22, 2015 07:48:38 PM Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: cpufreq: Drop unnecessary arguments from two functions
> 
> After commit 9b07109f06a1 (cpufreq: Fix double addition of sysfs
> links) The second sif argument of __cpufreq_remove_dev_prepare()
> and __cpufreq_remove_dev_finish() is not used by them any more,
> so drop it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Rebased on top of:
> http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=9b07109f06a1edd6e636b1e7397157eae0e6baa4
> 
> Note: The above commit is on a testing branch only at the moment.

Actually, scratch this one.  We can address the removal issue mentioned in the
other thread along with this.

I'll send a replacement patch to do that shortly.

Thanks,
Rafael

