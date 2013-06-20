From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/4] PM / tracing: Add pm_qos_update_target/flags
 tracepoints
Date: Thu, 20 Jun 2013 08:35:15 -0400
Message-ID: <1371731715.18733.85.camel@gandalf.local.home>
References: <1371704220-7008-1-git-send-email-kpark3469@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:18427 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965039Ab3FTMfQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jun 2013 08:35:16 -0400
In-Reply-To: <1371704220-7008-1-git-send-email-kpark3469@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kpark3469@gmail.com
Cc: linux-pm@vger.kernel.org, keun-o.park@windriver.com, len.brown@intel.com, rjw@sisk.pl

On Thu, 2013-06-20 at 13:56 +0900, kpark3469@gmail.com wrote:

> +DEFINE_EVENT_PRINT(pm_qos_update, pm_qos_update_flags,
> +
> +	TP_PROTO(enum pm_qos_req_action action, int prev_value, int curr_value),
> +
> +	TP_ARGS(action, prev_value, curr_value),
> +
> +	TP_printk("action=%s prev_value=0x%x curr_value=0x%x",
> +		  (__entry->action == PM_QOS_ADD_REQ) ? "ADD_REQ" :
> +		  (__entry->action == PM_QOS_UPDATE_REQ) ? "UPDATE_REQ" :
> +		  (__entry->action == PM_QOS_REMOVE_REQ) ? "REMOVE_REQ" : "??",
> +		  __entry->prev_value, __entry->curr_value)
> +);
>  #endif /* _TRACE_POWER_H */

Nice! I believe you are the first one to add a new event using a
DEFINE_EVENT_PRINT(). And you did it properly (almost, see below) :-)

The only other use of that was by Li Zefan who converted an existing
event to DEFINE_EVENT_PRINT().

There's a helper function to convert numbers into strings:

	TP_printk("action=%s prev_value=0x%x curr_value=0x%x",
		__print_symbolic(__entry->action,
			{ PM_QOS_ADD_REQ,	"ADD_REQ" },
			{ PM_QOS_UPDATE_REQ,	"UPDATE_REQ" },
			{ PM_QOS_REMOVE_REQ,	"REMOVE_REQ" }),
		__entry->prev_value, __entry->curr_value)

The advantage of using __print_symbolic() is that it allows both perf
and trace-cmd to read this event properly. Their parsers are not full C
parsers, and when you open code the the processing, they both will fail
to parse how to read the output, and will just default to printing the
fields via their raw numbers.

Another advantage is if the __entry->action is not one of the defined
fields, instead of outputting "??" it will output the number in hex. Say
if __entry->action is 0x123, the __print_symbolic will return "0x123" as
a string and that will be shown to the user, letting you know the actual
value of the field that was unknown.

-- Steve



