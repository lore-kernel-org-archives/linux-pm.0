From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: conservative: Allow down_threshold to take
 values from 1 to 10
Date: Tue, 13 Jun 2017 11:32:14 +0530
Message-ID: <20170613060214.GG5297@vireshk-i7>
References: <1497169719-13613-1-git-send-email-twilczynski@naver.com>
 <20170612034035.GB5297@vireshk-i7>
 <3062414.lj8A9ADAOY@aspire.rjw.lan>
 <7fa1e0c6-8d9c-c346-f5e2-87f024ebc1bb@naver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33150 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752114AbdFMGCS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2017 02:02:18 -0400
Received: by mail-pf0-f174.google.com with SMTP id 83so62304189pfr.0
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2017 23:02:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7fa1e0c6-8d9c-c346-f5e2-87f024ebc1bb@naver.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Wilczynski <twilczynski@naver.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 13-06-17, 14:58, Tomasz Wilczynski wrote:
> This is my first patch so please bare with me...

No worries, we were just telling you about what's the right way..

> I am just a little
> confused. Does this mean that it is all right to leave the patch as it is,
> or should I still add the Fixes: tag and resubmit it?

Rafael has already applied the patch with all the required tags (look
in the PM tree):

commit b8e11f7d2791bd9320be1c6e772a60b2aa093e45
Author: Tomasz Wilczyński <twilczynski@naver.com>
Date:   Sun Jun 11 17:28:39 2017 +0900

    cpufreq: conservative: Allow down_threshold to take values from 1 to 10
    
    Commit 27ed3cd2ebf4 (cpufreq: conservative: Fix the logic in frequency
    decrease checking) removed the 10 point substraction when comparing the
    load against down_threshold but did not remove the related limit for the
    down_threshold value.  As a result, down_threshold lower than 11 is not
    allowed even though values from 1 to 10 do work correctly too. The
    comment ("cannot be lower than 11 otherwise freq will not fall") also
    does not apply after removing the substraction.
    
    For this reason, allow down_threshold to take any value from 1 to 99
    and fix the related comment.
    
    Fixes: 27ed3cd2ebf4 (cpufreq: conservative: Fix the logic in frequency decrease checking)
    Signed-off-by: Tomasz Wilczyński <twilczynski@naver.com>
    Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
    Cc: 3.10+ <stable@vger.kernel.org> # 3.10+
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_conservative.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
viresh
