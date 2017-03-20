From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Restore policy min/max limits on CPU online
Date: Mon, 20 Mar 2017 08:51:56 +0530
Message-ID: <20170320032156.GG31040@vireshk-i7>
References: <2084010.4xkKok06Gp@aspire.rjw.lan>
 <20170317032016.GC31040@vireshk-i7>
 <CAJZ5v0jNp9t8uu0S4yRjT-TLHOcrAeMmjFzU6eBaaCp+C4j5Wg@mail.gmail.com>
 <CAKohponGNdnd0Q8rEhMAa=M8EiUiEE6H0nkJYFCFCu+Ow3zw2Q@mail.gmail.com>
 <CAJZ5v0h1C6o72boe_DJRS_U3xebaU6h=kzL8biNjGUoA1S8B8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34001 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbdCTDWp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Mar 2017 23:22:45 -0400
Received: by mail-pg0-f51.google.com with SMTP id 21so36927881pgg.1
        for <linux-pm@vger.kernel.org>; Sun, 19 Mar 2017 20:22:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h1C6o72boe_DJRS_U3xebaU6h=kzL8biNjGUoA1S8B8w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 17-03-17, 18:40, Rafael J. Wysocki wrote:
> On Fri, Mar 17, 2017 at 5:43 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 17 March 2017 at 22:01, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> >> IMO if we are not going to restore the governor, we also should not
> >> restore the limits as those things are related.  Now, the governor can
> >> be unloaded while the CPU is offline.
> >
> > I thought about it earlier but then governor and policy min/max
> > looked independent to me. Why do you think they are related?
> 
> They are parts of one set of settings.
> 
> If the governor is not restored, the policy starts with the default
> one, so why would it not start with the default limits then?

Do we reset the limits when we change governor's normally? No. Then
why should we consider suspend/resume special in that sense? These are
completely different and independent settings which user has done and
we don't really need to relate them.

> My opinion is that either we restore everything the way it was, or we
> start afresh entirely.

What about fields like: policy->user_policy.*? They aren't reset for
existing policies if the last governor isn't found. And there are
drivers which call cpufreq_update_policy(), and that would mean that
the CPU will come back to user defined policies before system
suspended. And that kind of defeats whatever you were trying to do in
this patch. Isn't it?

-- 
viresh
