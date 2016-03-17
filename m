From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Do not schedule policy update work in
 cpufreq_resume()
Date: Thu, 17 Mar 2016 13:30:00 +0700
Message-ID: <20160317063000.GC14898@vireshk-mac-ubuntu>
References: <5379622.iJjZa2C2Nq@vostro.rjw.lan>
 <20160315061059.GB13831@vireshk-mac-ubuntu>
 <CAJZ5v0iW7mkKTdgLm953nPAWVu4Cbx_P-E9bDg9WXwQtjDwb5A@mail.gmail.com>
 <20160316044757.GB16250@vireshk-mac-ubuntu>
 <CAJZ5v0gdnaw_BwW6ugT102YA+-Pb8O578Anf1b2vetEXsvCgzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gdnaw_BwW6ugT102YA+-Pb8O578Anf1b2vetEXsvCgzw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On 16-03-16, 14:12, Rafael J. Wysocki wrote:
> No, it won't.  This might be applicable to other governors, but not to
> "performance" (look at what it does on _START instead of just
> guessing).
> 
> > So, your patch break things for sure.
> 
> I'm not actually sure it breaks anything.
> 
> Theoretically, it may, but practically?  Is there any system out there
> where it makes any difference?

AFAIU, this patch will break currently working governors.

-> cpufreq_resume()
  -> cpufreq_governor_performance(START)
    -> __cpufreq_driver_target(target_freq = policy->max)
    //policy->cur is already set to policy->max before suspend.
        if (target_freq == policy->cur)
                return 0;

And so, the real frequency stays to 500 MHz and policy->cur contains 1 GHz.

-- 
viresh
