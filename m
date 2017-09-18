From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: cpufreq_stats: make last_index signed int
Date: Sun, 17 Sep 2017 18:50:17 -0700
Message-ID: <20170918015017.GC17030@ubuntu>
References: <1505506402-11497-1-git-send-email-byan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:45786 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbdIRBuT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Sep 2017 21:50:19 -0400
Received: by mail-pf0-f175.google.com with SMTP id q76so4036954pfq.2
        for <linux-pm@vger.kernel.org>; Sun, 17 Sep 2017 18:50:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1505506402-11497-1-git-send-email-byan@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bo Yan <byan@nvidia.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 15-09-17, 13:13, Bo Yan wrote:
> It is possible for last_index to get a -1 if current frequency
> is not found in the freq table when stats is created. If the
> function "cpufreq_stats_update" is called before last_index is
> updated with a valid value, the "-1" will be used as index to
> update stats->time_in_state, triggering an exception.

No, that's not how it works AFAIK and if it did, then can you explain how your
solution fixes it?

AFAIK, what happens right now is that stats->last_index eventually stores
2147483647 (uint max) and the exception comes while accessing that value.

While with your change, it will become -1 and accessing array[-1] is fine by C
standards, though it is still the wrong thing to do as you are accessing
something outside of the array.

We should just check last_index == -1 before calling cpufreq_stats_update(),
which is already done by one of the callers.

-- 
viresh
