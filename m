From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 09/10] timer/migration: Add tracepoints
Date: Mon, 17 Apr 2017 15:09:32 -0400
Message-ID: <20170417150932.7e149f5d@gandalf.local.home>
References: <20170417183241.244217993@linutronix.de>
        <20170417184356.697789890@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753418AbdDQTJl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Apr 2017 15:09:41 -0400
In-Reply-To: <20170417184356.697789890@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>

On Mon, 17 Apr 2017 20:32:50 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> The timer pull logic needs proper debuging aids. Add tracepoints so the
> hierarchical idle machinery can be diagnosed.
> 
> Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/trace/events/timer_migration.h |  173 +++++++++++++++++++++++++++++++++
>  kernel/time/timer_migration.c          |   17 +++
>  2 files changed, 190 insertions(+)
> 
> --- /dev/null
> +++ b/include/trace/events/timer_migration.h
> @@ -0,0 +1,173 @@
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM timer_migration
> +
> +#if !defined(_TRACE_TIMER_MIGRATION_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_TIMER_MIGRATION_H
> +
> +#include <linux/tracepoint.h>
> +
> +/* Group events */
> +DECLARE_EVENT_CLASS(tmigr_group,
> +
> +	TP_PROTO(struct tmigr_group *group),
> +
> +	TP_ARGS(group),
> +
> +	TP_STRUCT__entry(
> +		__field( void *,	group	)
> +		__field( unsigned int,	lvl	)
> +		__field( unsigned int,	numa_node )
> +		__field( unsigned int,	active )
> +		__field( unsigned int,	migrator )
> +		__field( unsigned int,	num_childs )
> +		__field( void *,	parent	)
> +		__field( u64,		nextevt	)
> +		__field( unsigned int,	evtcpu	)

On 64 bit boxes, with long and pointers as 8 bytes and int is only 4
bytes, the above can be laid out better, as the above structure will
most likely create holes. Like a 4 byte one after num_childs. Perhaps
move num_childs down to above evtcpu. In other words, please pair ints
together when possible, between pointers and longs.

The order of the struct does not need to be the same as the order of
the output.

Thanks,

-- Steve

> +	),
> +
> +	TP_fast_assign(
> +		__entry->group		= group;
> +		__entry->lvl		= group->level;
> +		__entry->numa_node	= group->numa_node;
> +		__entry->active		= group->active;
> +		__entry->migrator	= group->migrator;
> +		__entry->num_childs	= group->num_childs;
> +		__entry->parent		= group->parent;
> +		__entry->nextevt	= group->groupevt.nextevt.expires;
> +		__entry->evtcpu		= group->groupevt.cpu;
> +	),
> +
> +	TP_printk("group=%p lvl=%d numa=%d active=%d migrator=%d num_childs=%d "
> +		  "parent=%p nextevt=%llu evtcpu=%d",
> +		  __entry->group, __entry->lvl, __entry->numa_node,
> +		  __entry->active, __entry->migrator, __entry->num_childs,
> +		  __entry->parent, __entry->nextevt, __entry->evtcpu)
> +);
> +
