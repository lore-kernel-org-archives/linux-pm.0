From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Skip all governor-related actions for
 cpufreq_suspended set
Date: Fri, 8 Apr 2016 11:14:14 +0530
Message-ID: <20160408054414.GE9674@vireshk-i7>
References: <2044559.GVlD7a2JcO@vostro.rjw.lan>
 <CAJZ5v0g6zHT8yq-s+FkSb+ZE9K5vw_y0GX1nHaSLjOQXfsUquw@mail.gmail.com>
 <20160407120503.GG3201@vireshk-i7>
 <2346918.2NTGrKGAVB@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35260 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbcDHFoa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2016 01:44:30 -0400
Received: by mail-pa0-f48.google.com with SMTP id td3so68675906pab.2
        for <linux-pm@vger.kernel.org>; Thu, 07 Apr 2016 22:44:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2346918.2NTGrKGAVB@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 08-04-16, 00:05, Rafael J. Wysocki wrote:
> On Thursday, April 07, 2016 05:35:03 PM Viresh Kumar wrote:

> > That's *ugly* and it works by chance, unless I am misreading it
> > completely.
> 
> I'm assuming that what you mean by "ugly" here is "not really straightforward",
> which I agree with,

Yeah.

> but then it is really disappointing to see comments like
> that from you about the code that you helped to write.

I was just trying to say that this isn't how I feel it should be done.
:(

> Moreover, runtime CPU offline *also* doesn't have to run the governor exit/init
> for the same reason why the policy directory doesn't have to be removed on
> CPU offline: it is just pointless to do that.  The governor has been stopped
> already and it won't do anything more.  The only problem here is to prevent
> governor tunable sysfs attributes from triggering actions in that state,
> but that shouldn't be too difficult to arrange for.  If that's done,

Isn't that already guaranteed as userspace should have been frozen by
by the time we reach cpufreq_suspend()?

> cpufreq_suspended can be dropped, modulo changing cpufreq_start_governor()
> to return immediately if the governor has been started already.
> 
> And if something else is needed to protect driver callbacks from being invoked
> outside of the suspend-resume path, a more robust mechanism has to be added
> for that.
> 
> But in the meantime, I'd like to address the fast switch problem first and
> then you're free to clean up things on top of that.  Or I will clean them up
> if I have the time.

Okay..

-- 
viresh
