From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: governor: Drop gov_cancel_work()
Date: Thu, 9 Jun 2016 08:51:00 +0530
Message-ID: <20160609032100.GB9356@vireshk-i7>
References: <31871585.32WEDJA5Kj@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36066 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933992AbcFIDVF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jun 2016 23:21:05 -0400
Received: by mail-pa0-f46.google.com with SMTP id b5so8341608pas.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Jun 2016 20:21:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <31871585.32WEDJA5Kj@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 09-06-16, 01:45, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There's no reason for gov_cancel_work() to exist at all, as it only
> has one caller and the only thing done by that caller is to invoke
> gov_cancel_work().
> 
> Accordingly, drop gov_cancel_work() and move its contents to the
> caller.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c |   19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

I am wondering what happened to your other patches around the governor callbacks
and why weren't they applied yet :)

-- 
viresh
