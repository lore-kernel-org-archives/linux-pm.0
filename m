From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 1/3] idle: add support for tasks that inject idle
Date: Mon, 14 Nov 2016 08:29:45 -0800
Message-ID: <20161114082945.4d8c7eff@jacob-builder>
References: <1478718312-12847-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1478718312-12847-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <20161114150119.GG3142@twins.programming.kicks-ass.net>
        <20161114082028.6c0ce338@jacob-builder>
        <20161114162211.GI3142@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:6917 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752781AbcKNQ1v (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Nov 2016 11:27:51 -0500
In-Reply-To: <20161114162211.GI3142@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Zhang Rui <rui.zhang@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Petr Mladek <pmladek@suse.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Arjan van de Ven <arjan@linux.intel.com>, jacob.jun.pan@linux.intel.com

On Mon, 14 Nov 2016 17:22:11 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> hrtimer_init_on_stack() exists.

I missed it. let me move the timeout inside play_idle().

Thanks,

Jacob
