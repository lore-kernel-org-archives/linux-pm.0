From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [RFC v3 2/3] interconnect: Add basic event tracing
Date: Fri, 8 Sep 2017 23:16:44 +0300
Message-ID: <e45d096f-1e7a-89cd-f334-266d4b3466bc@linaro.org>
References: <20170908171830.13813-1-georgi.djakov@linaro.org>
 <20170908171830.13813-3-georgi.djakov@linaro.org>
 <20170908141321.02f51e92@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20170908141321.02f51e92@gandalf.local.home>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, khilman@baylibre.com, mturquette@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, sboyd@codeaurora.org, andy.gross@linaro.org, seansw@qti.qualcomm.com, davidai@quicinc.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

On 8.09.17 г. 21:13, Steven Rostedt wrote:
> On Fri,  8 Sep 2017 20:18:29 +0300
> Georgi Djakov <georgi.djakov@linaro.org> wrote:
> 
>> diff --git a/include/trace/events/interconnect.h b/include/trace/events/interconnect.h
>> new file mode 100644
>> index 000000000000..c4a72163873c
>> --- /dev/null
>> +++ b/include/trace/events/interconnect.h
>> @@ -0,0 +1,45 @@
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM interconnect
>> +
>> +#if !defined(_TRACE_INTERCONNECT_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_INTERCONNECT_H
>> +
>> +#include <linux/tracepoint.h>
>> +
>> +struct interconnect_path;
>> +
>> +DECLARE_EVENT_CLASS(interconnect_path,
>> +
>> +	TP_PROTO(struct interconnect_path *path),
>> +
>> +	TP_ARGS(path),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(struct interconnect_path *, path)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->path = path;
>> +	),
>> +
>> +	TP_printk("INTERCONNECT: %p", __entry->path)
> 
> You're passing in an interconnect_path and only recording the pointer
> to it? Wouldn't it be useful to record other aspects? Like the number
> of nodes, the avg and peak bw of each node?
> 

My goal was to get just the path with some timestamps, but your suggestion
sounds good. Will do it. Thanks!
