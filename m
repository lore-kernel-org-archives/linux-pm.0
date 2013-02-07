From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/4] CPUFreq Fixes for 3.9
Date: Thu, 07 Feb 2013 14:05:34 +0100
Message-ID: <2158181.aoVXdpLJe2@vostro.rjw.lan>
References: <cover.1360232293.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1360232293.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: valdis.kletnieks@vt.edu, artem.savkov@gmail.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, dirk.brandewie@gmail.com
List-Id: linux-pm@vger.kernel.org

On Thursday, February 07, 2013 03:57:42 PM Viresh Kumar wrote:
> Hi Rafael,
> 
> This is another unplanned patchset for all the platforms that i broke. :)
> 
> Okay, there are two important fixes (1 & 4) and two general cleanups (2 & 3). I
> hope most of the issues would be resolved by these and we would be able to push
> clean cpufreq core into 3.9.
> 
> I have pushed them in my for-rafael branch at:
> 
> http://git.linaro.org/gitweb?p=people/vireshk/linux.git;a=shortlog;h=refs/heads/for-rafael
> 
> @Artem & Valdis: Please test them and reply with your Tested-by's (in case they
> work :) ).
> 
> Viresh Kumar (4):
>   cpufreq: governors: Fix WARN_ON() for multi-policy platforms
>   cpufreq: Remove unused HOTPLUG_CPU code
>   cpufreq: Create a macro for unlock_policy_rwsem{read,write}
>   cpufreq: Fix locking issues
> 
>  drivers/cpufreq/cpufreq.c          | 126 ++++++++++++++++++-------------------
>  drivers/cpufreq/cpufreq_governor.c |  32 ++++++----
>  2 files changed, 79 insertions(+), 79 deletions(-)

I think they all make sense, so applied to linux-next.

I would prefer not to make any more changes to cpufreq before v3.9 from now on,
except for fixes and maybe the Drik's patchset that I kind of scheduled for
merging into bleeding-edge later today.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
