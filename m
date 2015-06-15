From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 08/12] cpufreq: governor: synchronize work-handler with
 governor callbacks
Date: Mon, 15 Jun 2015 14:01:05 +0530
Message-ID: <20150615083105.GB27654@linux>
References: <cover.1434019473.git.viresh.kumar@linaro.org>
 <c8e5037760d45b96e059bf6fd150e2e23205ff76.1434019473.git.viresh.kumar@linaro.org>
 <557E8B69.9030901@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33673 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583AbbFOIbJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 04:31:09 -0400
Received: by padev16 with SMTP id ev16so61344912pad.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 01:31:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <557E8B69.9030901@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, ke.wang@spreadtrum.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 15-06-15, 13:53, Preeti U Murthy wrote:
> This patch is not convincing. What are the precise races between
> cpufreq_governor_dbs() and the work handlers ?

The most important problem was restarting of workqueues from the
handler, which can happen at the same time when the governor-callbacks
are in progress..

> It is true that the work handlers can get queued after a governor exit
> due to a race between different callers of cpufreq_governor_dbs() and
> they can dereference freed data structures. But that is about invalid
> interleaving of states which your next patch aims at fixing.
> 
> AFAICT, preventing invalid states from succeeding will avoid this race.
> I don't see the need for another lock here.

Another lock? I am taking exactly the same lock at all places and
actually removing the need of two separate locks.

> > 
> > So, this patch replaces 'timer_mutex' with 'cdata->mutex' so that both
> > work-handler and callback are in sync.
> > 
> > Also in update_sampling_rate() we are dropping the mutex while
> > canceling delayed-work. There is no need to do that, keep lock active
> 
> Why? What is the race that we are fixing by taking the lock here ?

This can also queue work on CPUs.

-- 
viresh
