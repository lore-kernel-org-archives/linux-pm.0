From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V6 0/7] cpufreq: suspend early/resume late: dpm_{suspend|resume}()
Date: Wed, 19 Feb 2014 00:31:33 +0100
Message-ID: <1451060.DQy33I92MO@vostro.rjw.lan>
References: <cover.1392629003.git.viresh.kumar@linaro.org> <1455643.Gytp1zkkCW@vostro.rjw.lan> <5303DDF9.3050806@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5303DDF9.3050806@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nm@ti.com, kgene.kim@samsung.com, jinchoi@broadcom.com, tianyu.lan@intel.com, sebastian.capella@linaro.org, jhbird.choi@samsung.com
List-Id: linux-pm@vger.kernel.org

On Tuesday, February 18, 2014 03:26:01 PM Stephen Warren wrote:
> On 02/18/2014 03:36 PM, Rafael J. Wysocki wrote:
> > On Tuesday, February 18, 2014 01:30:52 PM Stephen Warren wrote:
> >> On 02/17/2014 02:25 AM, Viresh Kumar wrote:
> >>> This patchset creates/calls cpufreq suspend/resume callbacks from dpm_{suspend|resume}()
> >>> for handling suspend/resume of cpufreq governors and core.
> >>>
> >>> There are multiple problems that are fixed by this patch:
> >>> - Nishanth Menon (TI) found an interesting problem on his platform, OMAP. His board
> >>>   wasn't working well with suspend/resume as calls for removing non-boot CPUs
> >>>   was turning out into a call to drivers ->target() which then tries to play
> >>>   with regulators. But regulators and their I2C bus were already suspended and
> >>>   this resulted in a failure. Many platforms have such problems, samsung, tegra,
> >>>   etc.. They solved it with driver specific PM notifiers where they used to
> >>>   disable their driver's ->target() routine.
> >>> - Lan Tianyu (Intel) & Jinhyuk Choi (Broadcom) found an issue where tunables
> >>>   configuration for clusters/sockets with non-boot CPUs was getting lost after
> >>>   suspend/resume, as we were notifying governors with CPUFREQ_GOV_POLICY_EXIT on
> >>>   removal of the last cpu for that policy and so deallocating memory for
> >>>   tunables.  This is fixed by this patch as we don't allow any operation on
> >>>   governors after device suspend and before device resume now.
> >>
> >> The series,
> >> Tested-by: Stephen Warren <swarren@nvidia.com>
> > 
> > Is this series necessary to fix bugs that you're seeing in 3.14-rc and if so,
> > the what bugs are they?
> 
> No, Viresh sent a separate patch that fixed the sysfs warning I was
> getting (I believe you've already applied that), and there's still some
> ongoing discussion about the other kernel spew.

OK, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
