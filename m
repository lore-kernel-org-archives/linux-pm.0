From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 07/12] cpufreq: governor: split out common part of {cs|od}_dbs_timer()
Date: Mon, 15 Jun 2015 12:33:08 +0530
Message-ID: <557E78AC.3070507@linux.vnet.ibm.com>
References: <cover.1434019473.git.viresh.kumar@linaro.org> <d3b9ae6a7645e39fa5883e7843278ddbd88c2653.1434019473.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:41429 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524AbbFOHDS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 03:03:18 -0400
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Mon, 15 Jun 2015 01:03:17 -0600
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 1B8F6C90043
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 02:54:22 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5F73FXA53411904
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 07:03:15 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5F73DOT001056
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 03:03:14 -0400
In-Reply-To: <d3b9ae6a7645e39fa5883e7843278ddbd88c2653.1434019473.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 06/11/2015 04:21 PM, Viresh Kumar wrote:
> Some part of cs_dbs_timer() and od_dbs_timer() is exactly same and is
> unnecessarily duplicated.
> 
> Create the real work-handler in cpufreq_governor.c and put the common
> code in this routine (dbs_timer()).
> 
> Shouldn't make any functional change.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

