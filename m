From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 3/3] trace: thermal: add another parameter *power to
 the tracing function
Date: Tue, 14 Mar 2017 09:44:32 -0400
Message-ID: <20170314094432.0cafedb3@gandalf.local.home>
References: <20170314130616.7711-1-lukasz.luba@arm.com>
        <20170314130616.7711-4-lukasz.luba@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751474AbdCNNoh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Mar 2017 09:44:37 -0400
In-Reply-To: <20170314130616.7711-4-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, chris.diamand@arm.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, Ingo Molnar <mingo@redhat.com>

On Tue, 14 Mar 2017 13:06:16 +0000
Lukasz Luba <lukasz.luba@arm.com> wrote:

> This patch adds another parameter to the trace function:
> trace_thermal_power_devfreq_get_power().
> 
> In case when we call directly driver's code for the real power,
> we do not have static/dynamic_power values. Instead we get total
> power in the '*power' value. The 'static_power' and
> 'dynamic_power' are set to 0.
> 
> Therefore, we have to trace that '*power' value in this scenario.
> 
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Zhang Rui <rui.zhang@intel.com>
> CC: Eduardo Valentin <edubezval@gmail.com>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/devfreq_cooling.c |  2 +-
>  include/trace/events/thermal.h    | 11 +++++++----
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> index 4411ab8..ca3ebe3 100644
> --- a/drivers/thermal/devfreq_cooling.c
> +++ b/drivers/thermal/devfreq_cooling.c
> @@ -304,7 +304,7 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
>  	}
>  
>  	trace_thermal_power_devfreq_get_power(cdev, status, freq, dyn_power,
> -					      static_power);
> +					      static_power, *power);

I'm curious. Can you disassemble the above, and take a look at how it
handles that dereference?

I may make sense to pass in the pointer and do the dereference in the
TP_fast_assign():

	__entry->power = *power;

I like to make the call site as light as possible and do as much work
in the tracepoint code that is feasible. This helps keep tracepoints
light weight when tracing is off.

-- Steve


>  
>  	return 0;
