From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Synchronize sysfs limits
Date: Mon, 14 Nov 2016 14:07:37 -0800
Message-ID: <1479161257.6544.33.camel@linux.intel.com>
References: <1478909495-57026-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0j8CQk8tbxsCA_R0M2RJ4u58UexQkb7Waq4qRYQdRcw1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:7005 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932462AbcKNWH6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Nov 2016 17:07:58 -0500
In-Reply-To: <CAJZ5v0j8CQk8tbxsCA_R0M2RJ4u58UexQkb7Waq4qRYQdRcw1A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>

On Mon, 2016-11-14 at 02:04 +0100, Rafael J. Wysocki wrote:
> On Sat, Nov 12, 2016 at 1:11 AM, Srinivas Pandruvada
> 
[...]
> +       get_online_cpus();
> > +       for_each_online_cpu(cpu) {
> > +               if (all_cpu_data[cpu])
> > +                       cpufreq_update_policy(cpu);
> 
> cpufreq_update_policy() calls cpufreq_cpu_get() to get the policy
> anyway which does the requisite policy existence check (although it
> is
> a bit racy now, but that's a bug in there that we should not have to
> work around here), so it should be sufficient to do this
> for_each_possible_cpu() without additional locking.
> 
I will change in the next patch set.

> > 
[...]

> > +       cpufreq_register_notifier(&intel_pstate_cpufreq_notifier_bl
> > ock,
> > +                                 CPUFREQ_POLICY_NOTIFIER);
> > +
> 
> cpufreq_set_policy() will call our ->verify() and ->set_policy()
> things, so why do we need the notifier?
> 
I was simply replicating what is done for _PPC notifiers. But we can do
in verify() callback here. In the next patch, I will change this.

Thanks,
Srinivas

