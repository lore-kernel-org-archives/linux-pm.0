From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/4] cpu_cooling: Drop static-power related stuff
Date: Thu, 16 Nov 2017 08:17:04 +0530
Message-ID: <20171116024704.GQ3257@vireshk-i7>
References: <cover.1510735482.git.viresh.kumar@linaro.org>
 <fcca009e0e10840ff5ee31c88b618a212ab69201.1510735482.git.viresh.kumar@linaro.org>
 <761f7963-8b6d-b002-5404-a9ad0acf84d6@linaro.org>
 <20171115154311.GA3005@localhost.localdomain>
 <CAJZ5v0j6Hk8D29h+MdMeU-PgSAFkNG-41_a7d+goVuSve0=CYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:52630 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754551AbdKPCrH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 21:47:07 -0500
Received: by mail-pg0-f41.google.com with SMTP id j16so13979565pgn.9
        for <linux-pm@vger.kernel.org>; Wed, 15 Nov 2017 18:47:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j6Hk8D29h+MdMeU-PgSAFkNG-41_a7d+goVuSve0=CYw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, lukasz.luba@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Javi Merino <javi.merino@arm.com>, Punit Agrawal <punit.agrawal@arm.com>

On 15-11-17, 19:17, Rafael J. Wysocki wrote:
> However, I would like to see a clear declaration from whoever is
> maintaining that code today that there is a plan in place to upstream
> it and that this plan will actually be acted on.  And, better yet,
> *when* that can be expected to happen.

Exactly what I have been advocating.

And there is bunch of other places where such examples can be seen.
For example multiple regulator support in the OPP framework, which I
added an year ago hasn't seen a user yet. And I am pushing the TI guys
(who wanted it badly) to upstream their code before we remove that as
well :)

Again, someone has to come up and take responsibility of getting
static power platform support upstream in a definite amount of time.

-- 
viresh
