From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH][experimantal] cpufreq: governor: Use an atomic variable
 for synchronization
Date: Tue, 8 Dec 2015 19:25:18 +0530
Message-ID: <20151208135518.GE3692@ubuntu>
References: <cover.1449115453.git.viresh.kumar@linaro.org>
 <5461074.Yz9lhOaAu0@vostro.rjw.lan>
 <20151208133633.GC3692@ubuntu>
 <10138182.WjU9yqx6Gs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33306 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932665AbbLHNzW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2015 08:55:22 -0500
Received: by pfnn128 with SMTP id n128so12603593pfn.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2015 05:55:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <10138182.WjU9yqx6Gs@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, ashwin.chaugule@linaro.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>

On 08-12-15, 15:19, Rafael J. Wysocki wrote:
> We know what should be done.  We need to wait for the timer function to
> complete, then cancel the work item spawned by it (if any) and then
> cancel the timers set by that work item.

Yeah, there is no race, but it looks ugly to me. I have written it
earlier, and then the spinlock thing looked better to me. :)

-- 
viresh
