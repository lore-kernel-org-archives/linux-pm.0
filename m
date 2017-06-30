From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/6] cpufreq: governor: Drop min_sampling_rate
Date: Fri, 30 Jun 2017 11:10:33 +0530
Message-ID: <20170630054033.GZ29665@vireshk-i7>
References: <cover.1498733506.git.viresh.kumar@linaro.org>
 <713af1a417a9a77f0c41976b25874687ac235e8e.1498733506.git.viresh.kumar@linaro.org>
 <20170629180123.GA2443@light.dominikbrodowski.net>
 <20170630033425.GU29665@vireshk-i7>
 <20170630045306.GA8069@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34462 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751715AbdF3Fki (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jun 2017 01:40:38 -0400
Received: by mail-pf0-f169.google.com with SMTP id s66so61469195pfs.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Jun 2017 22:40:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170630045306.GA8069@light.dominikbrodowski.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

On 30-06-17, 06:53, Dominik Brodowski wrote:
> On Fri, Jun 30, 2017 at 09:04:25AM +0530, Viresh Kumar wrote:
> > On 29-06-17, 20:01, Dominik Brodowski wrote:
> > > On Thu, Jun 29, 2017 at 04:29:06PM +0530, Viresh Kumar wrote:
> > > > The cpufreq core and governors aren't supposed to set a limit on how
> > > > fast we want to try changing the frequency. This is currently done for
> > > > the legacy governors with help of min_sampling_rate.
> > > > 
> > > > At worst, we may end up setting the sampling rate to a value lower than
> > > > the rate at which frequency can be changed and then one of the CPUs in
> > > > the policy will be only changing frequency for ever.
> > > 
> > > Is it safe to issue requests to change the CPU frequency so frequently,
> > 
> > Well, I assumed so. I am not sure the hardware would break though.
> > Overheating ?
> > 
> > > even
> > > on historic hardware such as speedstep-{ich,smi,centrino}? In the past,

speedstep-smi is the only one which sets transition_latency to
CPUFREQ_ETERNAL and the others are putting some meaningful values. So
yes, they should be doing DVFS dynamically.

> > > these checks more or less disallowed the running of dynamic frequency
> > > scaling at least on speedstep-smi[*],
> > 
> > We must by doing dynamic freq scaling even without this patch. I don't
> > see why you say the above then.
> > 
> > All we do here is that we get rid of the limit on how soon we can
> > change the freq again.
> 
> Well, as I understand it, first generation "speedstep" was designed more or
> less to switch frequencies only when AC power was lost or restored.
> 
> The Linux implementation merely said: "no on-the-fly changes", but switch
> frequencies whenever a user explicitly requested such a change (presumably
> only every once in an unspecified while).
> 
> This same reasoning may be present in other drivers using CPUFREQ_ETERNAL.

Thanks for the explanation here and I am convinced that this series
has at least done one thing wrong. And that is removal of
max_transition_latency from governors and allowing ondemand to run on
such platforms (which may end up breaking them).

So I will actually modify that patch and set max_transition_latency to
CPUFREQ_ETERNAL for ondemand/conservative instead of 10ms. Also we
should do the same for schedutil as well, so that will also use the
max_transition_latency field.

But I hope, this patch will still be fine. Right ?

> I am not *sure* either, I am just worried of the consequences of doing
> things out-of-spec...

Thanks for your inputs Dominik.

-- 
viresh
