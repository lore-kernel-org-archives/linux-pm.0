From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 4/4] cpu_cooling: Drop static-power related stuff
Date: Wed, 15 Nov 2017 10:20:49 -0800
Message-ID: <20171115182047.GA4831@localhost.localdomain>
References: <cover.1510735482.git.viresh.kumar@linaro.org>
 <fcca009e0e10840ff5ee31c88b618a212ab69201.1510735482.git.viresh.kumar@linaro.org>
 <761f7963-8b6d-b002-5404-a9ad0acf84d6@linaro.org>
 <20171115154311.GA3005@localhost.localdomain>
 <CAJZ5v0j6Hk8D29h+MdMeU-PgSAFkNG-41_a7d+goVuSve0=CYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46569 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757707AbdKOSUw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 13:20:52 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j6Hk8D29h+MdMeU-PgSAFkNG-41_a7d+goVuSve0=CYw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, lukasz.luba@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Javi Merino <javi.merino@arm.com>, Punit Agrawal <punit.agrawal@arm.com>

On Wed, Nov 15, 2017 at 07:17:49PM +0100, Rafael J. Wysocki wrote:
> On Wed, Nov 15, 2017 at 4:43 PM, Eduardo Valentin <edubezval@gmail.com> wrote:
> > On Wed, Nov 15, 2017 at 11:18:03AM +0100, Daniel Lezcano wrote:
> >> On 15/11/2017 10:19, Viresh Kumar wrote:
> >> > No one has used it for the last two and half years (since it was
> >> > introduced by commit c36cf0717631 ("thermal: cpu_cooling: implement the
> >> > power cooling device API")), get rid of it.
> >> >
> >> > Cc: Javi Merino <javi.merino@arm.com>
> >> > Cc: Punit Agrawal <punit.agrawal@arm.com>
> >> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >> > ---
> >>
> >> Even if I agree that is not used to in the mainstream kernel, it is part
> >> of the EAS which is currently merged in Android.
> >>
> >
> > Even though we really should care about stuff that is in mainline, this
> > specific case is about a piece of code that never made mainline, or got
> > lost on translation from one version to another. So, I am currently
> > nacking this patch and asking ARM/linaro folks to upstream the juno
> > implementation that uses static power.
> 
> However, I would like to see a clear declaration from whoever is
> maintaining that code today that there is a plan in place to upstream
> it and that this plan will actually be acted on.  And, better yet,
> *when* that can be expected to happen.
> 
> Without such a declaration I'm afraid there is no point for the
> mainline to carry the unused code.  Which apparently gets in the way
> somehow, or Viresh wouldn't have taken the time to attempt to remove
> it I suppose?


I agree here. This is mostly a code maintained by the linaro folks at
this moment (daniel, please chime in if I am wrong). If no effort is
done to get the code into mainline, there is no point in keeping the
static component as a dead code in our tree.

> 
> Thanks,
> Rafael
