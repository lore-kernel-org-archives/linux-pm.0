From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 2/3] cpufreq: governor: split cpufreq_governor_dbs()
Date: Fri, 05 Jun 2015 08:21:45 +0530
Message-ID: <55710EC1.2000001@linux.vnet.ibm.com>
References: <875e7e0f1b1f1f9d60f307fb55211df80294d766.1433416191.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e17.ny.us.ibm.com ([129.33.205.207]:59997 "EHLO
	e17.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbbFECvy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jun 2015 22:51:54 -0400
Received: from /spool/local
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Thu, 4 Jun 2015 22:51:54 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 325B338C8052
	for <linux-pm@vger.kernel.org>; Thu,  4 Jun 2015 22:51:52 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t552pqrB54526158
	for <linux-pm@vger.kernel.org>; Fri, 5 Jun 2015 02:51:52 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t552poMw002789
	for <linux-pm@vger.kernel.org>; Thu, 4 Jun 2015 22:51:51 -0400
In-Reply-To: <875e7e0f1b1f1f9d60f307fb55211df80294d766.1433416191.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 06/04/2015 04:43 PM, Viresh Kumar wrote:
> cpufreq_governor_dbs() is hardly readable, it is just too big and
> complicated. Lets make it more readable by splitting out event specific
> routines.
> 
> Order of statements is changed at few places, but that shouldn't bring
> any functional change.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V1->V2: Return errors after hitting WARN_ON. (Preeti)

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

Regards
Preeti U Murthy

