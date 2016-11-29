From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 1/2] idle: add support for tasks that inject idle
Date: Mon, 28 Nov 2016 16:33:07 -0800
Message-ID: <20161128163307.7b5b7d68@icelake>
References: <1480368809-23685-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1480368809-23685-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <CAJZ5v0g9WZe0suZwsv2+ezeGd4SWfT1oN=QkEgh5ahYfi882Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:25617 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751726AbcK2Ae4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Nov 2016 19:34:56 -0500
In-Reply-To: <CAJZ5v0g9WZe0suZwsv2+ezeGd4SWfT1oN=QkEgh5ahYfi882Cw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Petr Mladek <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, jacob.jun.pan@linux.intel.com

On Tue, 29 Nov 2016 00:22:23 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> > +       while (!READ_ONCE(it.done))
> > +               do_idle();
> > +
> > +       cpuidle_use_deepest_state(false);  
> 
> This actually depends on your [2/2], doesn't it?

right, I shall put that after 2/2.
