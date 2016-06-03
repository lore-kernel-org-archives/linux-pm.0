From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 2/2] cpufreq: Optimize cpufreq_frequency_table_target()
Date: Fri, 3 Jun 2016 08:46:01 +0530
Message-ID: <20160603031601.GB23467@vireshk-i7>
References: <cover.1464777376.git.viresh.kumar@linaro.org>
 <120ed8a873b6df2ccc9406eeec8f8f74e5f9b0d5.1464777376.git.viresh.kumar@linaro.org>
 <20160601194615.GQ9864@graphite.smuckle.net>
 <20160602012904.GV3725@vireshk-i7>
 <20160602182835.GC14579@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36107 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbcFCDQF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2016 23:16:05 -0400
Received: by mail-pf0-f181.google.com with SMTP id f144so38680373pfa.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Jun 2016 20:16:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160602182835.GC14579@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>

On 02-06-16, 11:28, Steve Muckle wrote:
> Shouldn't we be able to avoid extra function calls through the use of
> macros/inlines? Otherwise this is making things slower for schedutil
> than it is today. 
> 
> Actually cpufreq_driver_resolve_freq() shouldn't require any calls from
> schedutil when a freq_table is available - the whole thing could be run
> inline.

I will see what I can do on that. Thanks.

-- 
viresh
