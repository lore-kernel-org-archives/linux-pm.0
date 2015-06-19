From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 08/10] cpufreq: governor: Avoid invalid states with
 additional checks
Date: Fri, 19 Jun 2015 23:34:01 +0530
Message-ID: <55845991.6000202@linux.vnet.ibm.com>
References: <cover.1434713657.git.viresh.kumar@linaro.org> <2c24de3653ffb3c48a5dfcfb9ea52a753456481a.1434713657.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e19.ny.us.ibm.com ([129.33.205.209]:52830 "EHLO
	e19.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755424AbbFSSER (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2015 14:04:17 -0400
Received: from /spool/local
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Fri, 19 Jun 2015 14:04:16 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id CBFD838C806D
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2015 14:04:10 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5JI49eY55574558
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2015 18:04:09 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5JI47Ul007028
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2015 14:04:09 -0400
In-Reply-To: <2c24de3653ffb3c48a5dfcfb9ea52a753456481a.1434713657.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 06/19/2015 05:18 PM, Viresh Kumar wrote:
> There can be races where the request has come to a wrong state. For
> example INIT followed by STOP (instead of START) or START followed by
> EXIT (instead of STOP).
> 
> Tackle these races by comparing making sure the state-machine never gets
> into any invalid state. And return error if an invalid state-transition
> is requested.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
