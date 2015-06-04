From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] cpufreq: governor: register notifier from cs_init()
Date: Thu, 04 Jun 2015 13:03:46 +0530
Message-ID: <556FFF5A.90201@linux.vnet.ibm.com>
References: <cover.1433326032.git.viresh.kumar@linaro.org> <7c79b6ede0407a940da2076f562360990ef0061a.1433326032.git.viresh.kumar@linaro.org> <556FE44A.8080806@linux.vnet.ibm.com> <20150604060231.GD11325@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:45648 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbbFDHeH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jun 2015 03:34:07 -0400
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Thu, 4 Jun 2015 01:34:07 -0600
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id D16BAC9003C
	for <linux-pm@vger.kernel.org>; Thu,  4 Jun 2015 03:25:10 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t547Y3pg32768248
	for <linux-pm@vger.kernel.org>; Thu, 4 Jun 2015 07:34:03 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t547Y2sU025173
	for <linux-pm@vger.kernel.org>; Thu, 4 Jun 2015 03:34:03 -0400
In-Reply-To: <20150604060231.GD11325@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 06/04/2015 11:32 AM, Viresh Kumar wrote:
> On 04-06-15, 11:08, Preeti U Murthy wrote:
>> I don't see why we need the check on policy->governor->initialized
>> because we call cdata->init() and cdata->exit(), *only* when the first
>> and last references to the governor are being made respectively
>> (filtered by dbs_data->usage_count), which is precisely what the
>> initialized flag checks. So passing policy->governor->initialized seems
>> to be redundant? And this is the case for both gov_per_policy and otherwise.
> 
> That's the case only for !gov_per_policy.
> 
> In case of gov_per_policy, the same governor is used by multiple
> policies but with different dbs_data objects. And in this case INIT
> will be called only once for a dbs_data and so usage count will be max
> 1 at any time. But we want to register the notifiers for a governor
> only once and so we need this extra check.
> 
> policy->governor->initialized is set to 1 when the governor is
> initialized for the first policy. For all others it is incremented to
> other values.

Ok I see. The patch looks good to me then.

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

