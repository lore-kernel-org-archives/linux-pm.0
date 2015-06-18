From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 03/12] cpufreq: governor: Rename 'cpu_dbs_common_info'
 to 'cpu_dbs_info'
Date: Thu, 18 Jun 2015 12:22:52 +0530
Message-ID: <55826AC4.4060207@linux.vnet.ibm.com>
References: <cover.1434019473.git.viresh.kumar@linaro.org> <09b68d7545c05abf8f1fb485ddb0f4b2cd5a821f.1434019473.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e17.ny.us.ibm.com ([129.33.205.207]:48977 "EHLO
	e17.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734AbbFRGxE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2015 02:53:04 -0400
Received: from /spool/local
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Thu, 18 Jun 2015 02:53:03 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 9188D6E803F
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2015 02:44:45 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5I6qw6Z62914814
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2015 06:52:58 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5I6qvAM006245
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2015 02:52:58 -0400
In-Reply-To: <09b68d7545c05abf8f1fb485ddb0f4b2cd5a821f.1434019473.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 06/11/2015 04:21 PM, Viresh Kumar wrote:
> Its not common info to all CPUs, but a structure representing common
> type of cpu info to both governor types. Lets drop 'common_' from its
> name.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

