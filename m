From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: create sysfs symlink for cpus onlined after boot
Date: Mon, 27 Mar 2017 19:29:50 +0200
Message-ID: <7178193.VD2MsPrHSl@aspire.rjw.lan>
References: <1490304286-18311-1-git-send-email-pprakash@codeaurora.org> <2246294.s9H9y0mptv@aspire.rjw.lan> <276b4adc-3525-d736-795e-09ccb2be1c7c@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53128 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751288AbdC0RhM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Mar 2017 13:37:12 -0400
In-Reply-To: <276b4adc-3525-d736-795e-09ccb2be1c7c@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

On Monday, March 27, 2017 10:55:39 AM Prakash, Prashanth wrote:
> Hi Rafael,
> 
> On 3/25/2017 7:19 PM, Rafael J. Wysocki wrote:
> > On Sunday, March 26, 2017 03:05:56 AM Rafael J. Wysocki wrote:
> >> On Saturday, March 25, 2017 06:15:07 PM Rafael J. Wysocki wrote:
> >>> On Saturday, March 25, 2017 02:30:52 PM Rafael J. Wysocki wrote:
> >>>> On Friday, March 24, 2017 10:31:51 AM Prakash, Prashanth wrote:
> >>>>> On 3/23/2017 5:30 PM, Rafael J. Wysocki wrote:
> >>>>>> On Thu, Mar 23, 2017 at 10:24 PM, Prashanth Prakash
> >>>>>> <pprakash@codeaurora.org> wrote:
> >>>>>>> Adds an additional code path within cpufreq_online to create sysfs
> >>>>>>> symlinks for cpus that are bought onilne for the first time after
> >>>>>>> completion of boot.
> >>>>>>>
> >>>>>>> With maxcpus=N kernel parameter, it is possible to bring additional
> >>>>>>> cpus online after boot. In these cases per-cpu "cpufreq" symlinks
> >>>>>>> are not being created during registration as policy may not exist
> >>>>>>> for the cpus that were offline during boot.
> >>>>>>>
> >>>>>>> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
> >>>>>> This looks way overly complicated to me.  Let me look at it in the
> >>>>>> next couple of days.
> >>>>> Sure. Thanks!
> >>>> So the patch below works for me.  Please test.
> >>>>
> >>>> The problem is that we only try to create links once, when CPUs are registered
> >>>> or when the cpufreq driver is registered (depending on which happens first),
> >>>> but if all CPUs that would share a policy are offline at that time, the policy is not
> >>>> there and we don't create the links at all.
> >>>>
> >>>> This means we also need to try to create the links when creating a new policy
> >>>> (because the CPUs may have been added without the links at this point already).
> >>>>
> >>>> A slight side effect of this is that failures to create links are not regarded
> >>>> as hard errors now and only cause messages to be printed, but I don't see
> >>>> how that could be a big issue.
> >>> Actually, the rwlock around the for_each_cpu() loop in cpufreq_online() doesn't
> >>> matter AFAICS, so the code can be slightly simplified by dropping it.
> >> And I forgot about the cleanup on errors in cpufreq_online(), so one more
> >> update follows (with a changelog and all).
> > One more update, sorry.
> >
> > remove_cpu_dev_symlink() needs a device pointer, not a CPU number.  Also the
> > links cleanup need not be done under policy->rwsem.
> >
> > ---
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: [PATCH] cpufreq: Fix creation of symbolic links to policy directories
> >
> > The cpufreq core only tries to create symbolic links from CPU
> > directories in sysfs to policy directories in cpufreq_add_dev(),
> > either when a given CPU is registered or when the cpufreq driver
> > is registered, whichever happens first.  That is not sufficient,
> > however, because cpufreq_add_dev() may be called for an offline CPU
> > whose policy object has not been created yet and, quite obviously,
> > the symbolic cannot be added in that case.
> >
> > Fix that by making cpufreq_online() attempt to add symbolic links to
> > policy objects for the CPUs in the related_cpus mask of every new
> > policy object created by it.
> >
> > The cpufreq_driver_lock locking around the for_each_cpu() loop
> > in cpufreq_online() is dropped, because it is not necessary and the
> > code is somewhat simpler without it.  Moreover, failures to create
> > a symbolic link will not be regarded as hard errors any more and
> > the CPUs without those links will not be taken offline automatically,
> > but that should not be problematic in practice.
> >
> > Reported-by: Prashanth Prakash <pprakash@codeaurora.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Tested on a Qualcomm Centriq board and it works as expected. Thanks!

OK, queued up, thanks!

I'll push it for merging by the end of the week unless someone (Viresh in
particular) finds any problems with it.

Thanks,
Rafael
