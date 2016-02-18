From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/12] cpufreq: ondemand: Drop one more callback from
 struct od_ops
Date: Thu, 18 Feb 2016 11:08:11 +0530
Message-ID: <20160218053811.GK2610@vireshk-i7>
References: <2938006.67J0esUvOA@vostro.rjw.lan>
 <4653996.VftfsaIoaX@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34649 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425053AbcBRFiX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 00:38:23 -0500
Received: by mail-pf0-f181.google.com with SMTP id x65so24849861pfb.1
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2016 21:38:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4653996.VftfsaIoaX@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 18-02-16, 02:24, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The ->powersave_bias_init_cpu callback in struct od_ops is only used
> in one place and that invocation may be replaced with a direct call
> to the function pointed to by that callback, so change the code
> accordingly and drop the callback.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_governor.h |    1 -
>  drivers/cpufreq/cpufreq_ondemand.c |    3 +--
>  2 files changed, 1 insertion(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
