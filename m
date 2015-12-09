From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 0/4]  cpufreq governors and Intel P state driver
 compatibility
Date: Wed, 09 Dec 2015 08:18:34 -0800
Message-ID: <1449677914.4180.15.camel@linux.intel.com>
References: <1449613890-10403-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <56676BAD.4030707@redhat.com>
	 <1449619021.3240.209.camel@spandruv-desk3.jf.intel.com>
	 <566828C5.3010605@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:26925 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365AbbLIQVA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 9 Dec 2015 11:21:00 -0500
In-Reply-To: <566828C5.3010605@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, trenn@suse.de

On Wed, 2015-12-09 at 08:12 -0500, Prarit Bhargava wrote:
> 
> On 12/08/2015 06:57 PM, Srinivas Pandruvada wrote:
> > On Tue, 2015-12-08 at 18:45 -0500, Prarit Bhargava wrote:
> > > 
> > > On 12/08/2015 05:31 PM, Srinivas Pandruvada wrote:
> > > > Intel P State driver implements two policies, performance and
> > > > powersave.
> > > > The powersave policy is similar to ondemand cpufreq governor
> > > > when using
> > > > acpi-cpufreq. This causes lots of confusion among users. This
> > > > results
> > > > in invalid comparison of performance when acpi-cpufreq and
> > > > Intel P state
> > > > performance is compared.
> > > > 
> > > > The reason Intel P state called powersave when it actually
> > > > implemented
> > > > ondemand style P State selection, because the cpufreq core only
> > > > allows
> > > > two generic policies "performance and powersave" for drivers
> > > > which has
> > > > setpolicy() interface. All drivers using this interface are
> > > > forced to
> > > > support these two policies.
> > > > 
> > > > This patchset adds feature to have configurable generic
> > > > policies and
> > > > allows ondemand as one of the policy. With this approach, Intel
> > > > P state
> > > > now adds support for ondemand policy and power save policy both
> > > > in
> > > > addition to performance.
> > > 
> > Prarit,
> > > Srinivas, if I read the patchset correctly then this means that
> > > ondemand ==
> > > powersave ?
> > Yes. Will it cause problem to you?
> 
> Nope :)  I like that option.  I was just asking to make sure I
> understood
> the nature of the change.
> 
> > > 
> > > If so, is the intention to one day remove powersave altogether
> > > and switch to
> > > only ondemand & performance?
> > Yes. But we can add powersave, which all requests P state to max
> > efficiency ratio. But I want to check, if it will this cause more
> > confusion.
> > 
> 
> I'm thinking of end users -- we (Red Hat, but I'm pretty sure this
> applies
> to all distributions) have spent a significant amount of effort in
> educating
> users about the differences between the cpufreq and intel-pstate
> governors.
> 
> Google search yields several results detailing the difference between
> the
> powersave and userspace governors as well, so I think that making
> changes at
> this point, especially after years of use, will only lead to more
> confusion
> for users.
> 
Good point. We have customers in both camps. This is tough one.
> IOW, I agree with the technical argument, but I think that our users
> will
> really be confused.
> 
Thanks,
Srinivas
> P.
