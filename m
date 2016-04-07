From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Skip all governor-related actions for
 cpufreq_suspended set
Date: Thu, 7 Apr 2016 17:35:03 +0530
Message-ID: <20160407120503.GG3201@vireshk-i7>
References: <2044559.GVlD7a2JcO@vostro.rjw.lan>
 <20160407042820.GA14903@vireshk-i7>
 <CAJZ5v0gfadfuSdkoitFJAZfYXLJhed+1w2wiq1O3VnVK+fGYzA@mail.gmail.com>
 <20160407113226.GE3201@vireshk-i7>
 <CAJZ5v0g6zHT8yq-s+FkSb+ZE9K5vw_y0GX1nHaSLjOQXfsUquw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g6zHT8yq-s+FkSb+ZE9K5vw_y0GX1nHaSLjOQXfsUquw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On 07-04-16, 13:44, Rafael J. Wysocki wrote:
> I'm not sure I'm following.
> 
> Without this patch fast switch is disabled when we offline the nonboot
> CPUs during suspend, because cpufreq_exit_governor() runs then, but
> the cpufreq_governor() called by it does nothing.  Also
> cpufreq_governor() during nonboot CPUs online does nothing.
> 
> That has to be made consistent somehow.  This patch is one way.
> Another way would be to disable fast switch from the governor ->exit
> callback, but the net result would be the same.

Actually things are working fine today by chance IMO, because we don't
free the policy structures anymore while we offline CPUs.

Otherwise, policy->governor_data would have been lost together with
the policy, and governor wouldn't have worked properly after resume.

What we are doing today is something like this:

Suspend
-------

-> cpufreq_suspend()
 -> STOP governor
 -> cpufreq_suspended = true

-> Offline non-boot CPUs
  -> cpufreq_offline()
    -> SKIP calling EXIT governor (governor had allocated few
    resources earlier)

Resume
------

-> Bring back non-boot CPUs
  -> cpufreq_online()
    -> SKIP calling INIT governor (policy->governor_data doesn't get
    reset, luckily)

-> cpufreq_resume()
 -> cpufreq_suspended = false
 -> START governor


That's *ugly* and it works by chance, unless I am misreading it
completely.

One of the solutions to get this cleaned is to stop checking for
cpufreq_suspended flag in cpufreq_governor() and put that *only* in
places where we are trying to interact with the hardware. And that
essentially is the callbacks provided by the cpufreq drivers. So,
ignore calling cpufreq-driver callbacks if cpufreq_suspended is true.

-- 
viresh
