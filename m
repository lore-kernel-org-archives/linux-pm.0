From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 08/12] cpufreq: governor: synchronize work-handler with
 governor callbacks
Date: Mon, 15 Jun 2015 13:53:05 +0530
Message-ID: <557E8B69.9030901@linux.vnet.ibm.com>
References: <cover.1434019473.git.viresh.kumar@linaro.org> <c8e5037760d45b96e059bf6fd150e2e23205ff76.1434019473.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e18.ny.us.ibm.com ([129.33.205.208]:52005 "EHLO
	e18.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753467AbbFOIXP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 04:23:15 -0400
Received: from /spool/local
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Mon, 15 Jun 2015 04:23:14 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id E821A6E803F
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 04:14:57 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5F8NARu62062830
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 08:23:10 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5F8N9w3010813
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 04:23:10 -0400
In-Reply-To: <c8e5037760d45b96e059bf6fd150e2e23205ff76.1434019473.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 06/11/2015 04:21 PM, Viresh Kumar wrote:
> Currently the work-handler's for all the CPUs are synchronized with one
> another but not with cpufreq_governor_dbs(). Both work-handlers and
> cpufreq_governor_dbs() enqueue work. And these not being in sync is an
> open invitation to all kind of races to come in.

This patch is not convincing. What are the precise races between
cpufreq_governor_dbs() and the work handlers ?

It is true that the work handlers can get queued after a governor exit
due to a race between different callers of cpufreq_governor_dbs() and
they can dereference freed data structures. But that is about invalid
interleaving of states which your next patch aims at fixing.

AFAICT, preventing invalid states from succeeding will avoid this race.
I don't see the need for another lock here.

> 
> So, this patch replaces 'timer_mutex' with 'cdata->mutex' so that both
> work-handler and callback are in sync.
> 
> Also in update_sampling_rate() we are dropping the mutex while
> canceling delayed-work. There is no need to do that, keep lock active

Why? What is the race that we are fixing by taking the lock here ?

> for the entire length of routine as that also enqueues works.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Regards
Preeti U Murthy

