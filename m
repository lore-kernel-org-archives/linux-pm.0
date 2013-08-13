From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/3] cpufreq: sa11x0: cleanups for 3.13
Date: Tue, 13 Aug 2013 22:01:17 +0200
Message-ID: <1437762.edDpfxPldn@vostro.rjw.lan>
References: <cover.1376392060.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1376392060.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, August 13, 2013 07:01:04 PM Viresh Kumar wrote:
> Hi Rafael/Russell,
> 
> These patches would be part of this patchset finally, sending it separately as I
> didn't wanted to send other patches in that series..
> 
> https://lkml.org/lkml/2013/8/10/48
> 
> (Above series was rebased over https://lkml.org/lkml/2013/8/8/263 and hence this
> patchset too)..
> 
> These first exposes frequency table and then uses cpufreq generic routines
> (which uses exposed table) instead of its own .verify() routine.
> 
> Later I will send another patch that would be part of this series:
> 
> http://lkml.org/lkml/2013/8/12/406
> 
> (I need to send that series again today and so not sending that patch twice,
> once here and then in that series)..
> 
> All these patches are pushed here with all dependencies:
> 
> https://git.linaro.org/gitweb?p=people/vireshk/linux.git;a=shortlog;h=refs/heads/for-v3.13

Are the three patches in this series prerequisite for the big target_index
one?  If so, I think they can go into 3.12 actually, if they are ACKed by the
appropriate platform maintainers.

> Viresh Kumar (3):
>   cpufreq: sa11x0: Expose frequency table
>   cpufreq: sa11x0: let cpufreq core initialize struct policy fields
>   cpufreq: sa11x0: Use generic cpufreq routines
> 
>  arch/arm/mach-sa1100/generic.c   | 65 +++++++++++++---------------------------
>  arch/arm/mach-sa1100/generic.h   |  2 +-
>  drivers/cpufreq/sa1100-cpufreq.c |  9 +++---
>  drivers/cpufreq/sa1110-cpufreq.c |  9 +++---
>  4 files changed, 30 insertions(+), 55 deletions(-)

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
