From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 4/4] cpu_cooling: Drop static-power related stuff
Date: Wed, 15 Nov 2017 07:43:13 -0800
Message-ID: <20171115154311.GA3005@localhost.localdomain>
References: <cover.1510735482.git.viresh.kumar@linaro.org>
 <fcca009e0e10840ff5ee31c88b618a212ab69201.1510735482.git.viresh.kumar@linaro.org>
 <761f7963-8b6d-b002-5404-a9ad0acf84d6@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:54749 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932252AbdKOPnR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 10:43:17 -0500
Content-Disposition: inline
In-Reply-To: <761f7963-8b6d-b002-5404-a9ad0acf84d6@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, lukasz.luba@arm.com, linux-kernel@vger.kernel.org, Javi Merino <javi.merino@arm.com>, Punit Agrawal <punit.agrawal@arm.com>

On Wed, Nov 15, 2017 at 11:18:03AM +0100, Daniel Lezcano wrote:
> On 15/11/2017 10:19, Viresh Kumar wrote:
> > No one has used it for the last two and half years (since it was
> > introduced by commit c36cf0717631 ("thermal: cpu_cooling: implement the
> > power cooling device API")), get rid of it.
> > 
> > Cc: Javi Merino <javi.merino@arm.com>
> > Cc: Punit Agrawal <punit.agrawal@arm.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> 
> Even if I agree that is not used to in the mainstream kernel, it is part
> of the EAS which is currently merged in Android.
> 

Even though we really should care about stuff that is in mainline, this
specific case is about a piece of code that never made mainline, or got
lost on translation from one version to another. So, I am currently
nacking this patch and asking ARM/linaro folks to upstream the juno
implementation that uses static power.

> -- 
>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
