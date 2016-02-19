From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 2/2] powercap/rapl: reduce ipi calls
Date: Fri, 19 Feb 2016 14:23:00 -0800
Message-ID: <20160219142300.22e98084@icelake>
References: <1455914253-18138-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1455914253-18138-3-git-send-email-jacob.jun.pan@linux.intel.com>
	<alpine.DEB.2.11.1602192246070.2477@nanos>
	<alpine.DEB.2.11.1602192301250.2477@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:24502 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946149AbcBSWYO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 19 Feb 2016 17:24:14 -0500
In-Reply-To: <alpine.DEB.2.11.1602192301250.2477@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, jacob.jun.pan@linux.intel.com

On Fri, 19 Feb 2016 23:01:59 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> > > +			if (lead_cpu < nr_cpu_ids)
> > > +				new_package->lead_cpu =
> > > lead_cpu;  
> > 
> > So the above is identical to 
> > 
> > 			new_package->lead_cpu = lead_cpu;  
> 
> 			new_package->lead_cpu = i;
you are absolutely right. i is already the answer here.

Thanks,

Jacob
