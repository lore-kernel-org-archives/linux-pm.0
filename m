From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] cpufreq: powernv: Export frequency throttle state of
 the chip through sysfs
Date: Thu, 27 Aug 2015 19:31:30 +1000
Message-ID: <1440667890.18333.1.camel@ellerman.id.au>
References: <1440666806-11760-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:46171 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbbH0Jbd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 27 Aug 2015 05:31:33 -0400
In-Reply-To: <1440666806-11760-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, stewart@linux.vnet.ibm.com, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org

On Thu, 2015-08-27 at 14:43 +0530, Shilpasri G Bhat wrote:
> Create a sysfs 'throttle' attribute per-chip(per-numa-node) to reflect
> the throttle state of the chip. The usersapce programs can poll on
> this attribute to keep an eye on the throttle state. Currently we
> print a log message to notify the user of throttling event. The
> performance-sensitive applications can monitor the throttle state
> using this attribute.

Performance sensitive applications can *poll* on a sysfs file, which does a
loop over all chips and potentially spams the console with pr_crit() messages ?

That does not sound like a recipe for success.

What problem are we actually trying to solve here?

cheers



