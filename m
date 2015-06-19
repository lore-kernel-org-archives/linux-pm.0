From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 10/10] cpufreq: propagate errors returned from __cpufreq_governor()
Date: Fri, 19 Jun 2015 23:39:52 +0530
Message-ID: <55845AF0.1070706@linux.vnet.ibm.com>
References: <cover.1434713657.git.viresh.kumar@linaro.org> <46b51eea20399c927fb1f16839773f618133ae09.1434713657.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e18.ny.us.ibm.com ([129.33.205.208]:43186 "EHLO
	e18.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330AbbFSSK0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2015 14:10:26 -0400
Received: from /spool/local
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Fri, 19 Jun 2015 14:10:25 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id A5BC06E804D
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2015 14:02:06 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5JIAJrO58523692
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2015 18:10:20 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5JIAHm4023186
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2015 14:10:19 -0400
In-Reply-To: <46b51eea20399c927fb1f16839773f618133ae09.1434713657.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 06/19/2015 05:18 PM, Viresh Kumar wrote:
> Return codes aren't honored properly in cpufreq_set_policy(). This can
> lead to two problems:
> - wrong errors propagated to sysfs
> - we try to do next state-change even if the previous one failed
> 
> cpufreq_governor_dbs() now returns proper errors on all invalid
> state-transition requests and this code should honor that.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Incorporating the nit in my previous reply to this patch would mean,

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
