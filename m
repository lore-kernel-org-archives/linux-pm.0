Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794195313;
	b=4nz4JE4cYY4Bfjr9GeXo/IwMAJO/yHlWj613MXLzQ5Mh5EMPOByoPxz+xLLPorMS+gT/
	 DL0FNu3nd79aVuaL3CTZTQZJAUCvOsNV9Nbl2rrWc0pV73+jhh8m1mPDQLLltjcgWQhq2
	 K8IxC97ZPeIPhpdLXB+vtlavVSh4gucndek0/zTdSt2WfUKGfa74T4y0dFHwQI9v001YC
	 xm1BBE5I70liz72I28QH196BLHB09lC5qQtygSD2QuA292jdwTcz68ksOxE9VIOBXgFcq
	 CNYru7zFzJlhDNUQQp5hc9C4ghXYqMvhe4wGRNFaUN6/miNJUhh4e4ji0NkOJ9eT1Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794195313;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=Qo1DPBTWqGGt6RuwHRBcU/Pe9SEhVS3YcMvno/aJs2c=;
	b=460/s2XEIUfsWd6El4kAm+ozbsHC7dm+VFlDfA4AmMb/mqx7fs+CLOb+p7oF2MXjB+k9
	 U1NIl4b38VO4Ec3Rx20dAv93//4MLLkkp/Npxu+su0xsCreyxHzXSbxXzYjIgiSelVk5C
	 4NRgsSAw9FuLOmOSYbKUvKSVZe4F3EP418L0dOigkpl8AlG4dGdPdjYo4qTnx5UQvMe4f
	 mAZITGN9MBfa7yhxFzLZ3yBx5G4m6rWsRc9Tlz8bkuHG85gCOSZ0rR8skmE6tw/hHfccV
	 eWnv8MBCtu0YuJzn+yEc8CXSwqe1kRQo6qiNtcJggyHiBS+EGue1FOF7xl578biGi2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Mmw+Ewfb;
	arc=none smtp.remote-ip=216.40.44.14
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F3E606A320;
	Mon,  9 Nov 2026 03:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02F3E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Mmw+Ewfb
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 255C114055E;
	Mon,  9 Nov 2026 03:35:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 7AC7430;
	Mon,  9 Nov 2026 03:35:01 +0000 (UTC)
Date: Sun, 8 Nov 2026 22:34:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pmdomain: core: Add tracepoints for domain state
 changes
Message-ID: <20261108223453.70b739d3@fedora>
In-Reply-To: <20261105-add-pmdomain-tracepoints-v2-1-10672995e155@oss.qualcomm.com>
References: <20261105-add-pmdomain-tracepoints-v2-1-10672995e155@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 57ok7j9ftro3ckrtfud6ipznztkuwyxb
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 7AC7430
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19jx8WGBL9yk35p0GDYuVibuPT+jE3yT8k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=Qo1DPBTWqGGt6RuwHRBcU/Pe9SEhVS3YcMvno/aJs2c=; b=Mmw+Ewfb23NzjLfdsU+IXnz4Ku+ZVr6funhELMMhTtc2MW9+ZDx7ZBm4dmLmDctLd/nxCD1yr2SJPSPxtSLycfnybbHAjeDPjky1dKGvTvzeUmoOPFMq5FzSj0Svj3ncKer9CqZ+iDoUBtvSEGaLQO6U1NoLtB0fKuQnnsdl9Co=
X-HE-Tag: 1794195301-370564
X-HE-Meta: U2FsdGVkX1/BO1dnWphxADVQ6fy3sAit9kULT/9qMtHS57xrW+ed0RZKrguMpBhO5EykdlZnOiaGUAWo0UBhN/JWk85uAgMNkNjD499SXmU+YrjxwBGdEv3P7Jnibe0itfpjlSyeMgtxx584+vIcCB5tJlnA/MYYI/bJGOoBnLOaWewycUpF1+vMPeNaaCndF6mfN4EXm2KHcLF0JfQSupHCbB1ltGQLuV969Xl39YRMqPkSsI08c8atNj9DdWCyLI0/gOs36FUw5t3JMskktQFAJO1kt25qICYpsizfzB2bkFHXrDjQ/s9GGqmQV/mlNdch5uNJ71zvghehMMcfW6lDBdFNXGj9

On Thu, 05 Nov 2026 18:18:49 +0200
Abel Vesa <abel.vesa@oss.qualcomm.com> wrote:

> diff --git a/include/trace/events/genpd.h b/include/trace/events/genpd.h
> new file mode 100644
> index 000000000000..e2970be0796a
> --- /dev/null
> +++ b/include/trace/events/genpd.h
> @@ -0,0 +1,94 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM genpd
> +
> +#if !defined(_TRACE_GENPD_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_GENPD_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(genpd_init,
> +
> +	TP_PROTO(const char *name, bool on, unsigned int performance_state),
> +
> +	TP_ARGS(name, on, performance_state),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(bool, on)
> +		__field(unsigned int, performance_state)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name);
> +		__entry->on = on;
> +		__entry->performance_state = performance_state;
> +	),
> +
> +	TP_printk("%s on=%d performance_state=%u", __get_str(name),
> +		  __entry->on, __entry->performance_state)
> +);
> +
> +/* state_idx identifies the idle state entered or exited. */
> +DECLARE_EVENT_CLASS(genpd_power,
> +
> +	TP_PROTO(const char *name, unsigned int state_idx, int ret),
> +
> +	TP_ARGS(name, state_idx, ret),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(unsigned int, state_idx)
> +		__field(int, ret)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name);
> +		__entry->state_idx = state_idx;
> +		__entry->ret = ret;
> +	),
> +
> +	TP_printk("%s state_idx=%u ret=%d", __get_str(name),
> +		  __entry->state_idx, __entry->ret)
> +);
> +
> +DEFINE_EVENT(genpd_power, genpd_power_on,
> +
> +	TP_PROTO(const char *name, unsigned int state_idx, int ret),
> +
> +	TP_ARGS(name, state_idx, ret)
> +);
> +
> +DEFINE_EVENT(genpd_power, genpd_power_off,
> +
> +	TP_PROTO(const char *name, unsigned int state_idx, int ret),
> +
> +	TP_ARGS(name, state_idx, ret)
> +);
> +
> +TRACE_EVENT(genpd_set_performance_state,
> +
> +	TP_PROTO(const char *name, unsigned int state, int ret),
> +
> +	TP_ARGS(name, state, ret),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(unsigned int, state)
> +		__field(int, ret)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name);
> +		__entry->state = state;
> +		__entry->ret = ret;
> +	),
> +
> +	TP_printk("%s state=%u ret=%d", __get_str(name),
> +		  __entry->state, __entry->ret)

This is pretty much the same as the above trace events except that it
has state instead of state_idx. If you really need this to say "state"
instead of "state_idx", you can use:

DEFINE_EVENT_PRINT(genpd_power, genpd_set_performance_state,
	TP_PROTO(const char *name, unsigned int state_idx, int ret),
	TP_ARGS(name, state_idx, ret),
	TP_printk("%s state=%u ret=%d", __get_str(name),
		  __entry->state, __entry->ret)
);

Which will make that trace event the same as the above except that it
will print "state" instead of "state_idx", and save some memory.

-- Steve



> +);
> +
> +#endif /* _TRACE_GENPD_H */
> +
> +/* This part must be outside protection. */
> +#include <trace/define_trace.h>
> 
> ---
> base-commit: 3d7783543c2646af69ad65825e810060494bea21
> change-id: 20260924-add-pmdomain-tracepoints-15254f2cd40f
> 
> Best regards,
> --  
> 
> Abel

