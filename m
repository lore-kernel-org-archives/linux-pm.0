From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/4] cpu_cooling: Drop static-power related stuff
Date: Wed, 15 Nov 2017 16:55:32 +0530
Message-ID: <20171115112532.GL3257@vireshk-i7>
References: <cover.1510735482.git.viresh.kumar@linaro.org>
 <fcca009e0e10840ff5ee31c88b618a212ab69201.1510735482.git.viresh.kumar@linaro.org>
 <761f7963-8b6d-b002-5404-a9ad0acf84d6@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46295 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756780AbdKOLZf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 06:25:35 -0500
Received: by mail-pf0-f195.google.com with SMTP id i15so6492982pfa.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Nov 2017 03:25:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <761f7963-8b6d-b002-5404-a9ad0acf84d6@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, edubezval@gmail.com, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, lukasz.luba@arm.com, linux-kernel@vger.kernel.org, Javi Merino <javi.merino@arm.com>, Punit Agrawal <punit.agrawal@arm.com>

On 15-11-17, 11:18, Daniel Lezcano wrote:
> Even if I agree that is not used to in the mainstream kernel, it is part
> of the EAS which is currently merged in Android.

Okay, I had chat with Daniel offline after looking at Android sources
and here are the key-points:
- No one is using this feature currently in Mainline or Android kernel
  tree.
- There may be some SoC vendors who are using it on their local repos,
  but we don't have much details on that.
- For EAS (Energy aware scheduling), we want to take static power of
  the CPUs into account and that is a TODO thing right now.

What worries me is that this code got merged almost 2.5 years back and
no one used it. Yeah, it looks interesting stuff but what's the
guarantee that anyone is going to use it in near future ?

@Javi, @Puneet, @Lukasz: As it was added by Javi (from ARM), can
someone from ARM write a patch for the arm big LITTLE cpufreq driver
(Juno?) and use this thing?

Else I am not sure how long we want to keep code in kernel that no one
touches.

And of course, we can revert this commit later on if required without
much trouble hopefully.

-- 
viresh
