From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC/PATCH] PM / Sleep: Timer quiesce in freeze state
Date: Tue, 28 Oct 2014 09:25:47 +0100
Message-ID: <20141028082547.GO3337@twins.programming.kicks-ass.net>
References: <5446787E.60202@linux.intel.com>
 <20141024153656.GM12706@worktop.programming.kicks-ass.net>
 <544F1E19.5030606@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:56611 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756564AbaJ1IZw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Oct 2014 04:25:52 -0400
Content-Disposition: inline
In-Reply-To: <544F1E19.5030606@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "alan@linux.intel.com" <alan@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, "linux-pm@vger.kernel.org >> Linux PM list" <linux-pm@vger.kernel.org>

On Tue, Oct 28, 2014 at 12:39:53PM +0800, Li, Aubrey wrote:

> > Now I suppose the problem is with cpu_pause() which needs IPIs to
> > complete? 
> 
> Yes, cpu_pause() will invoke smp IPI functions which need interrupt is
> enabled. So I changed irq ops like above. Actually, I have an early
> version to move cpuidle_pause()/cpuidle_resume() out of stop_machine(),
> that might be a better solution?

I think you can simply remove them altogether, they're nonsense.
