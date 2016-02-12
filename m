From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Avoid unnecessary locking in show() and store()
Date: Fri, 12 Feb 2016 21:50:38 +0530
Message-ID: <20160212162038.GB32705@vireshk-i7>
References: <2946666.LCVBdOefy1@vostro.rjw.lan>
 <16931364.qnKxgPucoY@vostro.rjw.lan>
 <20160212155829.GA32705@vireshk-i7>
 <15659367.8so4AOBv9e@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33016 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbcBLQUm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Feb 2016 11:20:42 -0500
Received: by mail-pf0-f181.google.com with SMTP id q63so49693600pfb.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Feb 2016 08:20:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <15659367.8so4AOBv9e@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 12-02-16, 17:10, Rafael J. Wysocki wrote:
> On Friday, February 12, 2016 09:28:29 PM Viresh Kumar wrote:
> > On 12-02-16, 14:18, Rafael J. Wysocki wrote:
> > > Well, having a check that never fails is certainly unuseful.
> > > 
> > > > So, even we may want to add a WARN_ON() for that case instead.
> > > 
> > > I can add WARN_ON()s just fine.
> > 
> > What about dropping the check completely ?
> 
> Fine by me.
> 
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] cpufreq: Drop unnecessary checks from show() and store()
> 
> The show() and store() routines in the cpufreq core don't need to
> check if the struct freq_attr they want to use really provides the
> callbacks they need as expected (if that's not the case, it means
> a bug in the code anyway), so change them to avoid doing that.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
