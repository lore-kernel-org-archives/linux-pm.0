From: Yuyang Du <yuyang.du@intel.com>
Subject: Re: [RFC PATCH 00/12 v2] A new CPU load metric for power-efficient
 scheduler: CPU ConCurrency
Date: Mon, 12 May 2014 09:28:57 +0800
Message-ID: <20140512012856.GA9351@intel.com>
References: <1399832221-8314-1-git-send-email-yuyang.du@intel.com>
 <20140512064533.GH30445@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23778 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755014AbaELJdq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 12 May 2014 05:33:46 -0400
Content-Disposition: inline
In-Reply-To: <20140512064533.GH30445@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, arjan.van.de.ven@intel.com, len.brown@intel.com, alan.cox@intel.com, mark.gross@intel.com, morten.rasmussen@arm.com, vincent.guittot@linaro.org, rajeev.d.muralidhar@intel.com, vishwesh.m.rudramuni@intel.com, nicole.chalhoub@intel.com, ajaya.durg@intel.com, harinarayanan.seshadri@intel.com, jacob.jun.pan@linux.intel.com, fengguang.wu@intel.com

On Mon, May 12, 2014 at 08:45:33AM +0200, Peter Zijlstra wrote:
> On Mon, May 12, 2014 at 02:16:49AM +0800, Yuyang Du wrote:
> 
> Yes, just what we need, more patches while we haven't had the time to
> look at the old set yet :-(

No essential change, added commit messages (after smashing our heads to
figure out what general code structure is). Can we get over immediate no go to
maybe slow no go?

Thanks,
Yuyang
