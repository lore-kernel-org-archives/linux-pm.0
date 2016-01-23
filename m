From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v6 2/5] cpufreq: powernv: Remove cpu_to_chip_id() from
 hot-path
Date: Sat, 23 Jan 2016 19:59:20 +1100
Message-ID: <20160123195920.552990ed@cotter.ozlabs.ibm.com>
References: <1453447145-17722-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
	<1453447145-17722-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33821 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395AbcAWI7e (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 23 Jan 2016 03:59:34 -0500
In-Reply-To: <1453447145-17722-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com

On Fri, 22 Jan 2016 12:49:02 +0530
Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> wrote:

> cpu_to_chip_id() does a DT walk through to find out the chip id by
> taking a contended device tree lock. This adds an unnecessary overhead
> in a hot path. So instead of calling cpu_to_chip_id() everytime cache
> the chip ids for all cores in the array 'core_to_chip_map' and use it
> in the hotpath.
> 
> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

snip

Does the core_to_chip_map need to be updated/refreshed on/after/ a
cpu (core) hotplug? I presume id's don't change

Balbir
