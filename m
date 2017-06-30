From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/6] cpufreq: governor: Drop min_sampling_rate
Date: Fri, 30 Jun 2017 09:04:25 +0530
Message-ID: <20170630033425.GU29665@vireshk-i7>
References: <cover.1498733506.git.viresh.kumar@linaro.org>
 <713af1a417a9a77f0c41976b25874687ac235e8e.1498733506.git.viresh.kumar@linaro.org>
 <20170629180123.GA2443@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33467 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751817AbdF3De2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2017 23:34:28 -0400
Received: by mail-pf0-f169.google.com with SMTP id e7so60161616pfk.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Jun 2017 20:34:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170629180123.GA2443@light.dominikbrodowski.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

On 29-06-17, 20:01, Dominik Brodowski wrote:
> On Thu, Jun 29, 2017 at 04:29:06PM +0530, Viresh Kumar wrote:
> > The cpufreq core and governors aren't supposed to set a limit on how
> > fast we want to try changing the frequency. This is currently done for
> > the legacy governors with help of min_sampling_rate.
> > 
> > At worst, we may end up setting the sampling rate to a value lower than
> > the rate at which frequency can be changed and then one of the CPUs in
> > the policy will be only changing frequency for ever.
> 
> Is it safe to issue requests to change the CPU frequency so frequently,

Well, I assumed so. I am not sure the hardware would break though.
Overheating ?

> even
> on historic hardware such as speedstep-{ich,smi,centrino}? In the past,
> these checks more or less disallowed the running of dynamic frequency
> scaling at least on speedstep-smi[*],

We must by doing dynamic freq scaling even without this patch. I don't
see why you say the above then.

All we do here is that we get rid of the limit on how soon we can
change the freq again.

> but maybe on a few other platforms as
> well. That's why I am curious on whether this may break systems potentially
> on a hardware level if the hardware was not designed to do dynamic frequency
> scaling (and not just frequency switches on battery/AC).

Honestly I am not sure if any hardware can break or not, just because
of this commit.

-- 
viresh
