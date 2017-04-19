From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 08/10] timer: Implement the hierarchical pull model
Date: Wed, 19 Apr 2017 09:20:54 +0200
Message-ID: <20170419072054.3bxb7fapyj7jodnn@hirez.programming.kicks-ass.net>
References: <20170418111102.490432548@linutronix.de>
 <20170418111401.016420305@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:49670 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760249AbdDSHVA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2017 03:21:00 -0400
Content-Disposition: inline
In-Reply-To: <20170418111401.016420305@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>

On Tue, Apr 18, 2017 at 01:11:10PM +0200, Thomas Gleixner wrote:
> +++ b/kernel/time/timer.c

> @@ -185,6 +186,10 @@ EXPORT_SYMBOL(jiffies_64);
>  #define WHEEL_SIZE	(LVL_SIZE * LVL_DEPTH)
>  
>  #ifdef CONFIG_NO_HZ_COMMON
> +/*
> + * If multiple bases need to be locked, use the base ordering for lock
> + * nesting, i.e. lowest number first.
> + */
>  # define NR_BASES	3
>  # define BASE_LOCAL	0
>  # define BASE_GLOBAL	1

You already used that in previous patches, should this comment go there?
