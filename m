From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4/4] cpu_cooling: Drop static-power related stuff
Date: Tue, 21 Nov 2017 18:49:04 +0100
Message-ID: <d99e0e43-ce75-78d8-3b3b-c6f4dfbf7e0c@linaro.org>
References: <cover.1510735482.git.viresh.kumar@linaro.org>
 <65fef2a1-d23f-3de2-bd91-021296c3e2f7@arm.com>
 <20171116152058.GR3257@vireshk-i7> <2810372.fJ2vMN0cWO@aspire.rjw.lan>
 <20171116234422.GA6141@localhost.localdomain>
 <878tf5tbfj.fsf@e105922-lin.cambridge.arm.com>
 <35d3751d-f28d-38c2-02b2-c9980f11c52e@arm.com>
 <20171121170917.GB2499@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:44422 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbdKURtI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Nov 2017 12:49:08 -0500
Received: by mail-wm0-f47.google.com with SMTP id r68so5217802wmr.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Nov 2017 09:49:08 -0800 (PST)
In-Reply-To: <20171121170917.GB2499@localhost.localdomain>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Punit Agrawal <punit.agrawal@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, lukasz.luba@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Javi Merino <javi.merino@arm.com>

On 21/11/2017 18:09, Eduardo Valentin wrote:

[ ... ]

> Well, I really do not see the point of a ask to extend the current API
> if have no single user of it. What are the current users problems with
> the API? What needs to be improved? What are the problems? We cannot
> tell, guess why? We have no users of it!
> 
> Once again, do we have a reference platform? Oh, yes, that is Juno, and
> not even that is in mainline code.
> 
> Folks, this can be a very nice discussion on how we can over engineer
> this API, but being pragmatic and avoiding wasting our time here, we all
> know what needs to be done. Dead code in mainline is hard to maintain.
> API to support out of the tree code is even harder. I am surprised to
> see this code was able to sustain itself in mainline with none
> challenging it for 2.5 y. So, we either get you guys to upstream at
> least one user of it or we just move on and remove the API, and keep
> mainline with only dynamic power, with periodic undershoots and
> overshoots. It is a simple decision: you either mainline it or keep IPA
> MORE inaccurate and take the burden to keep vendor own implementation
> of APIs for static power model on each product cycle, you choose.

+1 to remove it.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
