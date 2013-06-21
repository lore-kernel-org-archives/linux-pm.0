From: Keun-O Park <keun-o.park@windriver.com>
Subject: Re: [PATCH 1/4] PM / tracing: Add pm_qos_update_target/flags tracepoints
Date: Fri, 21 Jun 2013 11:16:21 +0900
Message-ID: <51C3B775.1080401@windriver.com>
References: <1371704220-7008-1-git-send-email-kpark3469@gmail.com> <1371731715.18733.85.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:61147 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161377Ab3FUCQb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jun 2013 22:16:31 -0400
In-Reply-To: <1371731715.18733.85.camel@gandalf.local.home>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kpark3469@gmail.com, linux-pm@vger.kernel.org, len.brown@intel.com, rjw@sisk.pl

2013=EB=85=84 06=EC=9B=94 20=EC=9D=BC 21:35, Steven Rostedt =EC=93=B4 =EA=
=B8=80:
> On Thu, 2013-06-20 at 13:56 +0900, kpark3469@gmail.com wrote:
>
>> +DEFINE_EVENT_PRINT(pm_qos_update, pm_qos_update_flags,
>> +
>> +	TP_PROTO(enum pm_qos_req_action action, int prev_value, int curr_v=
alue),
>> +
>> +	TP_ARGS(action, prev_value, curr_value),
>> +
>> +	TP_printk("action=3D%s prev_value=3D0x%x curr_value=3D0x%x",
>> +		  (__entry->action =3D=3D PM_QOS_ADD_REQ) ? "ADD_REQ" :
>> +		  (__entry->action =3D=3D PM_QOS_UPDATE_REQ) ? "UPDATE_REQ" :
>> +		  (__entry->action =3D=3D PM_QOS_REMOVE_REQ) ? "REMOVE_REQ" : "??=
",
>> +		  __entry->prev_value, __entry->curr_value)
>> +);
>>   #endif /* _TRACE_POWER_H */
> Nice! I believe you are the first one to add a new event using a
> DEFINE_EVENT_PRINT(). And you did it properly (almost, see below) :-)
>
> The only other use of that was by Li Zefan who converted an existing
> event to DEFINE_EVENT_PRINT().
>
> There's a helper function to convert numbers into strings:
>
> 	TP_printk("action=3D%s prev_value=3D0x%x curr_value=3D0x%x",
> 		__print_symbolic(__entry->action,
> 			{ PM_QOS_ADD_REQ,	"ADD_REQ" },
> 			{ PM_QOS_UPDATE_REQ,	"UPDATE_REQ" },
> 			{ PM_QOS_REMOVE_REQ,	"REMOVE_REQ" }),
> 		__entry->prev_value, __entry->curr_value)
>
> The advantage of using __print_symbolic() is that it allows both perf
> and trace-cmd to read this event properly. Their parsers are not full=
 C
> parsers, and when you open code the the processing, they both will fa=
il
> to parse how to read the output, and will just default to printing th=
e
> fields via their raw numbers.
>
> Another advantage is if the __entry->action is not one of the defined
> fields, instead of outputting "??" it will output the number in hex. =
Say
> if __entry->action is 0x123, the __print_symbolic will return "0x123"=
 as
> a string and that will be shown to the user, letting you know the act=
ual
> value of the field that was unknown.
>
> -- Steve
>
>
>

Thanks Steve. I modified codes to use __print_symbolic following your=20
recommendation.

-- Sahara
