From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/4] cpu_cooling: Drop static-power related stuff
Date: Thu, 16 Nov 2017 20:50:58 +0530
Message-ID: <20171116152058.GR3257@vireshk-i7>
References: <cover.1510735482.git.viresh.kumar@linaro.org>
 <fcca009e0e10840ff5ee31c88b618a212ab69201.1510735482.git.viresh.kumar@linaro.org>
 <761f7963-8b6d-b002-5404-a9ad0acf84d6@linaro.org>
 <20171115154311.GA3005@localhost.localdomain>
 <CAJZ5v0j6Hk8D29h+MdMeU-PgSAFkNG-41_a7d+goVuSve0=CYw@mail.gmail.com>
 <20171115182047.GA4831@localhost.localdomain>
 <65fef2a1-d23f-3de2-bd91-021296c3e2f7@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:52350 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759681AbdKPPVC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Nov 2017 10:21:02 -0500
Received: by mail-pf0-f194.google.com with SMTP id m88so12585933pfi.9
        for <linux-pm@vger.kernel.org>; Thu, 16 Nov 2017 07:21:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <65fef2a1-d23f-3de2-bd91-021296c3e2f7@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, lukasz.luba@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Javi Merino <javi.merino@arm.com>, Punit Agrawal <punit.agrawal@arm.com>

On 16-11-17, 15:02, Ionela Voinescu wrote:
> When it was added in lsk 3.18 in what was then a thermal driver for Juno
> it was believed to have an effect in thermal mitigation, but that was
> not proven later as to justify posting it upstream, and that is why the
> code never made it in mainline.
> The code added there can be found at:
> https://git.linaro.org/landing-teams/working/arm/kernel-release.git/tree/drivers/thermal/scpi-thermal.c?h=lsk-3.18-armlt#n247
> 
> As for removing this code now, I would not want to make that decision without
> spending more time to check if it impacts other customer codelines.
> I'll come back with a reply to this in the next couple of days.

Sure, we can wait for few days definitely :)

-- 
viresh
