From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 2/5] cpufreq: powernv: Remove cpu_to_chip_id() from
 hot-path
Date: Mon, 25 Jan 2016 11:08:05 +0530
Message-ID: <20160125053804.GA5599@in.ibm.com>
References: <1453447145-17722-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1453447145-17722-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20160123195920.552990ed@cotter.ozlabs.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:48854 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbcAYFiP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jan 2016 00:38:15 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
	Sun, 24 Jan 2016 22:38:14 -0700
Content-Disposition: inline
In-Reply-To: <20160123195920.552990ed@cotter.ozlabs.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Balbir Singh <bsingharora@gmail.com>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com

Hello Balbir,

On Sat, Jan 23, 2016 at 07:59:20PM +1100, Balbir Singh wrote:
> On Fri, 22 Jan 2016 12:49:02 +0530
> Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> wrote:
> 
> > cpu_to_chip_id() does a DT walk through to find out the chip id by
> > taking a contended device tree lock. This adds an unnecessary overhead
> > in a hot path. So instead of calling cpu_to_chip_id() everytime cache
> > the chip ids for all cores in the array 'core_to_chip_map' and use it
> > in the hotpath.
> > 
> > Reported-by: Anton Blanchard <anton@samba.org>
> > Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> > Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> 
> snip
> 
> Does the core_to_chip_map need to be updated/refreshed on/after/ a
> cpu (core) hotplug? I presume id's don't change

No, the id's don't change on cpu/core hotplug. The core_to_chip_map is
initialized in init_chip_info() where we use for_each_possible_cpu().

Thanks for the review!
> 
> Balbir
> 
--
Thanks and Regards
gautham.

