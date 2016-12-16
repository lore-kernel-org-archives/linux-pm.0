From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 0/2] Stop sched tick in idle injection task
Date: Fri, 16 Dec 2016 11:37:18 +0100
Message-ID: <20161216103718.GF3124@twins.programming.kicks-ass.net>
References: <1480402985-7317-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:53141 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755835AbcLPKhe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Dec 2016 05:37:34 -0500
Content-Disposition: inline
In-Reply-To: <1480402985-7317-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Ingo Molnar <mingo@redhat.com>, Zhang Rui <rui.zhang@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Petr Mladek <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>

On Mon, Nov 28, 2016 at 11:03:03PM -0800, Jacob Pan wrote:
> Jacob Pan (1):
>   cpuidle: allow setting deepest idle
> 
> Peter Zijlstra (1):
>   idle: add support for tasks that inject idle

Rafael, OK if I carry that first patch so that the combined stuff
actually compiles and such?

Jacob, I assume you'll follow up with patches converting those drivers?
