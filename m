From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4/4] cpu_cooling: Drop static-power related stuff
Date: Fri, 17 Nov 2017 08:55:42 +0100
Message-ID: <d474a8cf-159c-8325-d27d-01a921666ecc@linaro.org>
References: <cover.1510735482.git.viresh.kumar@linaro.org>
 <fcca009e0e10840ff5ee31c88b618a212ab69201.1510735482.git.viresh.kumar@linaro.org>
 <761f7963-8b6d-b002-5404-a9ad0acf84d6@linaro.org>
 <20171115154311.GA3005@localhost.localdomain>
 <CAJZ5v0j6Hk8D29h+MdMeU-PgSAFkNG-41_a7d+goVuSve0=CYw@mail.gmail.com>
 <20171116024704.GQ3257@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35397 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964944AbdKQHzq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Nov 2017 02:55:46 -0500
Received: by mail-wm0-f54.google.com with SMTP id y80so4616472wmd.0
        for <linux-pm@vger.kernel.org>; Thu, 16 Nov 2017 23:55:45 -0800 (PST)
In-Reply-To: <20171116024704.GQ3257@vireshk-i7>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, lukasz.luba@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Javi Merino <javi.merino@arm.com>, Punit Agrawal <punit.agrawal@arm.com>

On 16/11/2017 03:47, Viresh Kumar wrote:
> On 15-11-17, 19:17, Rafael J. Wysocki wrote:
>> However, I would like to see a clear declaration from whoever is
>> maintaining that code today that there is a plan in place to upstream
>> it and that this plan will actually be acted on.  And, better yet,
>> *when* that can be expected to happen.
> 
> Exactly what I have been advocating.
> 
> And there is bunch of other places where such examples can be seen.
> For example multiple regulator support in the OPP framework, which I
> added an year ago hasn't seen a user yet. And I am pushing the TI guys
> (who wanted it badly) to upstream their code before we remove that as
> well :)
> 
> Again, someone has to come up and take responsibility of getting
> static power platform support upstream in a definite amount of time.

Instead of removing entirely the code, why not convert this to a DT
based info and put the Juno values back ?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
