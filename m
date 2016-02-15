From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 8/9] cpufreq: ondemand: Simplify conditionals in
 od_dbs_timer()
Date: Mon, 15 Feb 2016 14:27:28 +0530
Message-ID: <20160215085728.GP6334@vireshk-i7>
References: <3329748.lhJgppdTt9@vostro.rjw.lan>
 <19952608.TanrAGEnqx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33536 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbcBOI5g (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 03:57:36 -0500
Received: by mail-pa0-f43.google.com with SMTP id fl4so70912221pad.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Feb 2016 00:57:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <19952608.TanrAGEnqx@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>

On 15-02-16, 02:21, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Reduce the indentation level in the conditionals in od_dbs_timer()
> and drop the delay variable from it.
> 
> No functional changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_ondemand.c |   24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
