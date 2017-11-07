From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] cpufreq: schedutil: Examine the correct CPU when we
 update util
Date: Tue, 7 Nov 2017 15:29:51 +0530
Message-ID: <20171107095951.GE3297@vireshk-i7>
References: <20171103034022.GD4240@vireshk-i7>
 <20171103133642.8636-1-chris.redpath@arm.com>
 <20171103154559.GJ4240@vireshk-i7>
 <65a16c84-d25f-26ce-b4cf-5edc3f9b6d32@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:48838 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752589AbdKGJ7z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Nov 2017 04:59:55 -0500
Received: by mail-pg0-f49.google.com with SMTP id v78so10619242pgb.5
        for <linux-pm@vger.kernel.org>; Tue, 07 Nov 2017 01:59:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <65a16c84-d25f-26ce-b4cf-5edc3f9b6d32@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chris Redpath <chris.redpath@arm.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

On 07-11-17, 09:49, Chris Redpath wrote:
> Hi Viresh, Rafael,
> 
> Without this patch, schedutil is totally broken for us - is
> there any chance at all this could go in 4.14 or is it just
> too late?

I see that Rafael has already applied it, but not sure if he is planning to send
it for 4.14 (though he should IMHO, as it is a critical fix).

commit d62d813c0d71 ("cpufreq: schedutil: Examine the correct CPU when we update
util")

--
viresh
