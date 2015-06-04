From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/3] cpufreq: governor: Fix potential races
Date: Thu, 4 Jun 2015 12:12:02 +0530
Message-ID: <20150604064202.GI11325@linux>
References: <cover.1433326032.git.viresh.kumar@linaro.org>
 <556FDEA8.6090801@linux.vnet.ibm.com>
 <556FEB4B.1010601@linux.vnet.ibm.com>
 <20150604061128.GF11325@linux>
 <556FF201.8080100@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35966 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbbFDGmH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jun 2015 02:42:07 -0400
Received: by pdjm12 with SMTP id m12so24195064pdj.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2015 23:42:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <556FF201.8080100@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 04-06-15, 12:06, Preeti U Murthy wrote:
> Your fix may not be complete and here is why. The reason we see the crash
> is because we have *only* attempted to serialize calls to cpufreq_governor_dbs()
> and not attempted to serialize *entire logical sequence of operations*. Let's
> take a look at what is happening as a consequence.

You missed my logs (For the first time in my life I wrote them so well).
This is what I mentioned in 3/3:

"
These two issues need to be solved separately and the responsibility
should be properly divided between cpufreq and governor core.

The first problem is more about the governor core, as it needs to
protect its structures properly. And the second problem should be fixed
in cpufreq core instead of governor, as its all about sequence of
events.

This patch is trying to solve only the first problem.
"

I NEVER claimed that I solved all the issues.

-- 
viresh
