From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH][v2] timekeeping: Fix memory overwrite of sleep_time_bin
 array
Date: Fri, 29 Jul 2016 14:59:09 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1607291458090.19896@nanos>
References: <1468903861-12487-1-git-send-email-yu.c.chen@intel.com> <alpine.DEB.2.11.1607191031260.3596@nanos> <578DEDBB.9030602@intel.com> <alpine.DEB.2.11.1607191234200.3596@nanos> <20160729095015.GB8076@sharon>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:51526 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981AbcG2NB3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 Jul 2016 09:01:29 -0400
In-Reply-To: <20160729095015.GB8076@sharon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, John Stultz <john.stultz@linaro.org>, Xunlei Pang <xpang@redhat.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mail List <linux-kernel@vger.kernel.org>

On Fri, 29 Jul 2016, Chen Yu wrote:
> On Tue, Jul 19, 2016 at 12:40:14PM +0200, Thomas Gleixner wrote:
> 1st is to bypass the sleep time if pm_trace is involved(a little complicated
>     because it needs to deal with historical pm_trace), or
> 
> 2nd version is to introduce a sysfs interface to allow the
>     users to specify the threshold of sleep time, any delta
>     of tsc bigger than the threshold would be regarded as invalid.

That one is really overkill. We provide a proper sanity measure for this and
be done with it.

Thanks,

	tglx
