From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 01/12] cpufreq: governor: Name delayed-work as dwork
Date: Mon, 15 Jun 2015 08:31:46 +0530
Message-ID: <557E401A.7040206@linux.vnet.ibm.com>
References: <cover.1434019473.git.viresh.kumar@linaro.org> <1d96358b20ff457e322cbb6cbf975c34ee5ea77a.1434019473.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e18.ny.us.ibm.com ([129.33.205.208]:60342 "EHLO
	e18.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720AbbFODB6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 14 Jun 2015 23:01:58 -0400
Received: from /spool/local
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Sun, 14 Jun 2015 23:01:57 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 9622EC90042
	for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2015 22:53:01 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5F31sCE51511456
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 03:01:54 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5F31q3A027365
	for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2015 23:01:54 -0400
In-Reply-To: <1d96358b20ff457e322cbb6cbf975c34ee5ea77a.1434019473.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 06/11/2015 04:21 PM, Viresh Kumar wrote:
> Delayed work was named as 'work' and to access work within it we do
> work.work. Not much readable. Rename delayed_work as 'dwork'.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

