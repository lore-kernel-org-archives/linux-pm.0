From: Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH 3/4] drivers: qcom: rpmh-rsc: log RPMH requests in FTRACE
Date: Fri, 19 Jan 2018 07:35:01 +0000
Message-ID: <20180119073501.GA26362@codeaurora.org>
References: <20180119000157.7380-1-ilina@codeaurora.org>
 <20180119000157.7380-4-ilina@codeaurora.org>
 <20180118202607.3f40c238@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180118202607.3f40c238@gandalf.local.home>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org, sboyd@codeaurora.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Steven,

On Thu, Jan 18 2018 at 01:26 +0000, Steven Rostedt wrote:
>
>I wasn't Cc'd on the rest of the patches and this wasn't Cc'd to LKML,
>and I'm not on any of the mailing lists that were Cc'd, I gotta just
>look at what I have here in this patch.
>
I am so sorry. Will add LKML in the future.


>On Thu, 18 Jan 2018 17:01:56 -0700
>Lina Iyer <ilina@codeaurora.org> wrote:
>

>> @@ -325,6 +328,8 @@ static irqreturn_t tcs_irq_handler(int irq, void *p)
>>  			}
>>  		}
>>
>> +		trace_rpmh_notify_irq(drv->name, m, resp->msg->payload[0].addr,
>> +						resp->err);
>
>Below, m came from resp->m, is it the same here?
>
Yes, they will be the same.

>>  		write_tcs_reg(base, RSC_DRV_CMD_ENABLE, m, 0, 0);
>>  		write_tcs_reg(base, RSC_DRV_IRQ_CLEAR, 0, 0, BIT(m));
>>  		atomic_set(&drv->tcs_in_use[m], 0);
>> @@ -351,7 +356,8 @@ static void tcs_notify_tx_done(unsigned long data)
>>  	struct rsc_drv *drv = (struct rsc_drv *)data;
>>  	struct tcs_response *resp;
>>  	unsigned long flags;
>> -	int err;
>> +	int err, m;
>> +	struct tcs_mbox_msg *msg;
>>
>>  	do {
>>  		spin_lock_irqsave(&drv->drv_lock, flags);
>> @@ -364,7 +370,10 @@ static void tcs_notify_tx_done(unsigned long data)
>>  		list_del(&resp->list);
>>  		spin_unlock_irqrestore(&drv->drv_lock, flags);
>>  		err = resp->err;
>> +		m = resp->m;
>> +		msg = resp->msg;
>>  		free_response(resp);
>> +		trace_rpmh_notify(drv->name, m, msg->payload[0].addr, err);
>
>The reason I ask, is that this is causing more code to be executed
>even when tracing is off. What about passing in resp and assigning it
>within the tracepoint.
>
>	trace_rpmh_notify(drv->name, resp);
>
The free_response(resp) will free the resp object and accessing resp->m
is invalid after that.

>That would keep extra code from being used within the normal code path
>and only executed in the tracepoint. Get rid of the m = resp->m,
>msg = resp->msg.
>
>Even if m is something different above, you can still just pass in:
>
>	trace_rpmh_notify(drv->name, m, resp);
>
>
>>  	} while (1);
>>  }
May be I can just move the free_response() afer the
trace_rpmh_notify().

>>
>> @@ -393,6 +402,8 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int m, int n,
>>  		write_tcs_reg(base, RSC_DRV_CMD_MSGID, m, n + i, msgid);
>>  		write_tcs_reg(base, RSC_DRV_CMD_ADDR, m, n + i, cmd->addr);
>>  		write_tcs_reg(base, RSC_DRV_CMD_DATA, m, n + i, cmd->data);
>> +		trace_rpmh_send_msg(drv->name, m, n + i, msgid, cmd->addr,
>> +						cmd->data, cmd->complete);
>
>Here just pass in cmd. The less the parameters of a tracepoints, the
>more likely gcc wont leak code that would be executed when tracing is
>off.
>
OK.

>> +#include <linux/tracepoint.h>
>> +
>> +DECLARE_EVENT_CLASS(rpmh_ack_recvd,
>> +
>> +	TP_PROTO(const char *s, int m, u32 addr, int errno),
>> +
>> +	TP_ARGS(s, m, addr, errno),
>
>Then we could just do:
>
>	TP_PROTO(const char *s, struct tcs_response *resp),
>
>	TP_ARGS(s, resp),
>
Nice. Will use this.

>> +
>> +	TP_STRUCT__entry(
>> +		__field(const char *, name)
>> +		__field(int, m)
>> +		__field(u32, addr)
>> +		__field(int, errno)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->name = s;
>> +		__entry->m = m;
>> +		__entry->addr = addr;
>> +		__entry->errno = errno;
>
>	__entry->m = resp->m;
>	__entry->addr = resp->msg->payload[0].addr;
>	__entry->errno = resp->err;
>
>-- Steve
>
Thanks for the review.

-- Lina
