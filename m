From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/4] PM / tracing: Add pm_qos_update_target/flags
 tracepoints
Date: Thu, 20 Jun 2013 08:36:11 -0400
Message-ID: <1371731771.18733.86.camel@gandalf.local.home>
References: <1371704220-7008-1-git-send-email-kpark3469@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:5814 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757535Ab3FTMgN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jun 2013 08:36:13 -0400
In-Reply-To: <1371704220-7008-1-git-send-email-kpark3469@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kpark3469@gmail.com
Cc: linux-pm@vger.kernel.org, keun-o.park@windriver.com, len.brown@intel.com, rjw@sisk.pl

On Thu, 2013-06-20 at 13:56 +0900, kpark3469@gmail.com wrote:
> /*
> + * The pm qos events are used for pm qos update
> + */
> +DECLARE_EVENT_CLASS(pm_qos_update,
> +
> +	TP_PROTO(enum pm_qos_req_action action, int prev_value, int curr_value),
> +
> +	TP_ARGS(action, prev_value, curr_value),
> +
> +	TP_STRUCT__entry(
> +		__field( enum pm_qos_req_action, action         )
> +		__field( int,                    prev_value     )
> +		__field( int,                    curr_value     )
> +	),
> +
> +	TP_fast_assign(
> +		__entry->action = action;
> +		__entry->prev_value = prev_value;
> +		__entry->curr_value = curr_value;
> +	),
> +
> +	TP_printk("action=%s prev_value=%d curr_value=%d",
> +		  (__entry->action == PM_QOS_ADD_REQ) ? "ADD_REQ" :
> +		  (__entry->action == PM_QOS_UPDATE_REQ) ? "UPDATE_REQ" :
> +		  (__entry->action == PM_QOS_REMOVE_REQ) ? "REMOVE_REQ" : "??",
> +		  __entry->prev_value, __entry->curr_value)
> +);
> +

This should be converted to use __print_symbolic() as well.

-- Steve


