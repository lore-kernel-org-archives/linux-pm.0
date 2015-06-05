From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/3] cpufreq: governor: Fix potential races
Date: Fri, 5 Jun 2015 08:30:28 +0530
Message-ID: <20150605030028.GB13999@linux>
References: <cover.1433326032.git.viresh.kumar@linaro.org>
 <556FDEA8.6090801@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35227 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504AbbFEDAd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jun 2015 23:00:33 -0400
Received: by pdbnf5 with SMTP id nf5so43586673pdb.2
        for <linux-pm@vger.kernel.org>; Thu, 04 Jun 2015 20:00:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <556FDEA8.6090801@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 04-06-15, 10:44, Preeti U Murthy wrote:
> On 06/03/2015 03:57 PM, Viresh Kumar wrote:
> > Preeti recently highlighted [1] some issues in cpufreq core locking with
> > respect to governors. I wanted to solve them after we have simplified
> > the hotplug paths in cpufreq core with my latest patches, but now that
> > she has poked me, I have done some work in that area.
> > 
> > I am trying to solve only a part of the bigger problem (in a way that I
> > feel is the right way ahead). The first patches restructures code to
> > make it more readable and the last patch does all the major changes. The
> > logs in that one should be good enough to explain why and what I am
> > doing.
> > 
> > The first two shouldn't bring any functional change and so can be
> > applied early if you are confident about them.
> > 
> > @Preeti: I would like you to test these patches. These should get rid of
> > the crashes you were facing but may generate a WARN() from line 447 of
> > cpufreq_governor.c, if the sequence is wrong. That has to be fixed
> > separately.
> > 
> > Line 447: WARN_ON(!dbs_data && (event != CPUFREQ_GOV_POLICY_INIT))

Hi Preeti,

Thanks for giving your RBY tags for all the patches, would you also
like to give Tested-by's if you have done any testing on these.

That is just to confirm it hasn't broken things any further and that
we haven't seen any crashes in races between
INIT/EXIT/START/STOP/LIMITS.

-- 
viresh
