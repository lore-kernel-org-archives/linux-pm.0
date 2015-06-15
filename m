From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 04/12] cpufreq: governor: name pointer to cpu_dbs_info
 as 'cdbs'
Date: Mon, 15 Jun 2015 09:52:46 +0530
Message-ID: <557E5316.3040309@linux.vnet.ibm.com>
References: <cover.1434019473.git.viresh.kumar@linaro.org> <20b096728a41a719bf8e45f99a0aadf142f60a03.1434019473.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e19.ny.us.ibm.com ([129.33.205.209]:36167 "EHLO
	e19.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbbFOEWz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 00:22:55 -0400
Received: from /spool/local
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Mon, 15 Jun 2015 00:22:54 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 83C7AC90043
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 00:13:58 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5F4MpbQ58458264
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 04:22:51 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5F4Moo0024778
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 00:22:51 -0400
In-Reply-To: <20b096728a41a719bf8e45f99a0aadf142f60a03.1434019473.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 06/11/2015 04:21 PM, Viresh Kumar wrote:
> It is called as 'cdbs' at most of the places and 'cpu_dbs' at others.
> Lets use 'cdbs' consistently for better readability.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

