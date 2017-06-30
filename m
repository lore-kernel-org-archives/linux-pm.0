From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 0/4] sched: cpufreq: Allow remote callbacks
Date: Fri, 30 Jun 2017 08:54:04 +0530
Message-ID: <20170630032404.GS29665@vireshk-i7>
References: <cover.1498712046.git.viresh.kumar@linaro.org>
 <CAJZ5v0g0Lo2mJzjs_WcHuCFRNMcLpU5GUhDKghFeMtxTTzbKYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34475 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbdF3DYH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2017 23:24:07 -0400
Received: by mail-pg0-f42.google.com with SMTP id t186so57275133pgb.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Jun 2017 20:24:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g0Lo2mJzjs_WcHuCFRNMcLpU5GUhDKghFeMtxTTzbKYA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steve Muckle <smuckle.linux@gmail.com>, Juri Lelli <juri.lelli@arm.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, eas-dev@lists.linaro.org

On 29-06-17, 22:30, Rafael J. Wysocki wrote:
> There is no way I could consider this for inclusion into 4.13, so I'm
> not sure why you chose this specific timing.

Sure, I don't aim at getting it merged for 4.13. I sent it now to get
some early feedback, so that it is ready for inclusion for the 4.14
merge window.

Isn't it fine to send such patches anytime? Should I avoid sending
such changes around merge window ?

-- 
viresh
