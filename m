From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH V3] cpuidle: check dev before usage in cpuidle_use_deepest_state
Date: Sat, 6 May 2017 01:21:40 +0300
Message-ID: <CAHp75VezBgYRZ-axH=GsUw58tHO84ZvFELR1ApmAxn3wfCZiXg@mail.gmail.com>
References: <BEC9F67575FA1E429CA7CF5AE9BE363432A46913@SHSMSX104.ccr.corp.intel.com>
 <3249200.sUIrOijesG@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:35095 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752437AbdEEWVm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 May 2017 18:21:42 -0400
In-Reply-To: <3249200.sUIrOijesG@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Li, Fei" <fei.li@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Shi, FengX" <fengx.shi@intel.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Koul, Vinod" <vinod.koul@intel.com>

On Sat, May 6, 2017 at 12:33 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, May 04, 2017 09:00:52 AM Li, Fei wrote:

>> Fixes: bb8313b603eb8 ("cpuidle: Allow enforcing deepest idle state selection")
>> Signed-off-by: Li, Fei <fei.li@intel.com>
>> Tested-by: Shi, Feng <fengx.shi@intel.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Reviewed-by: Koul, Vinod <vinod.koul@intel.com>

> A previous version of this has been applied and I don't see any differences
> in the code changes.

AFAIR only tags (above) had been extended in v3.

-- 
With Best Regards,
Andy Shevchenko
