From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v3 2/3] interconnect: Add basic event tracing
Date: Fri, 8 Sep 2017 14:13:21 -0400
Message-ID: <20170908141321.02f51e92@gandalf.local.home>
References: <20170908171830.13813-1-georgi.djakov@linaro.org>
        <20170908171830.13813-3-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170908171830.13813-3-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, khilman@baylibre.com, mturquette@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, sboyd@codeaurora.org, andy.gross@linaro.org, seansw@qti.qualcomm.com, davidai@quicinc.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Fri,  8 Sep 2017 20:18:29 +0300
Georgi Djakov <georgi.djakov@linaro.org> wrote:

> diff --git a/include/trace/events/interconnect.h b/include/trace/events/interconnect.h
> new file mode 100644
> index 000000000000..c4a72163873c
> --- /dev/null
> +++ b/include/trace/events/interconnect.h
> @@ -0,0 +1,45 @@
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM interconnect
> +
> +#if !defined(_TRACE_INTERCONNECT_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_INTERCONNECT_H
> +
> +#include <linux/tracepoint.h>
> +
> +struct interconnect_path;
> +
> +DECLARE_EVENT_CLASS(interconnect_path,
> +
> +	TP_PROTO(struct interconnect_path *path),
> +
> +	TP_ARGS(path),
> +
> +	TP_STRUCT__entry(
> +		__field(struct interconnect_path *, path)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->path = path;
> +	),
> +
> +	TP_printk("INTERCONNECT: %p", __entry->path)

You're passing in an interconnect_path and only recording the pointer
to it? Wouldn't it be useful to record other aspects? Like the number
of nodes, the avg and peak bw of each node?

-- Steve

> +);
> +
> +DEFINE_EVENT(interconnect_path, interconnect_set,
> +
> +	TP_PROTO(struct interconnect_path *path),
> +
> +	TP_ARGS(path)
> +);
> +
> +DEFINE_EVENT(interconnect_path, interconnect_set_complete,
> +
> +	TP_PROTO(struct interconnect_path *path),
> +
> +	TP_ARGS(path)
> +);
> +
> +#endif /* _TRACE_INTERCONNECT_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
