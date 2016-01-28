From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 1/6] cpufreq: powernv: Free 'chips' on module exit
Date: Thu, 28 Jan 2016 13:30:51 +0530
Message-ID: <20160128080051.GA13654@in.ibm.com>
References: <1453965941-7363-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1453965941-7363-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:52061 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932214AbcA1IBR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2016 03:01:17 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
	Thu, 28 Jan 2016 01:01:16 -0700
Content-Disposition: inline
In-Reply-To: <1453965941-7363-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com, bsingharora@gmail.com, mpe@ellerman.id.au

On Thu, Jan 28, 2016 at 12:55:36PM +0530, Shilpasri G Bhat wrote:
> This will free the dynamically allocated memory of'chips' on
> module exit.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

--
Thanks and Regards
gautham.

