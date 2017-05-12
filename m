From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 2/2] trace: power allocator: add trace for divvyup
 algorithm
Date: Fri, 12 May 2017 10:16:38 -0400
Message-ID: <20170512101638.3ea02c03@gandalf.local.home>
References: <1494575248-4166-1-git-send-email-lukasz.luba@arm.com>
        <1494575248-4166-3-git-send-email-lukasz.luba@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756576AbdELOQm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 May 2017 10:16:42 -0400
In-Reply-To: <1494575248-4166-3-git-send-email-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, Ingo Molnar <mingo@redhat.com>

On Fri, 12 May 2017 08:47:28 +0100
Lukasz Luba <lukasz.luba@arm.com> wrote:

> This trace function helps to figure out the divvyup algorithm
> on some platforms.
> 
> CC: Steven Rostedt <rostedt@goodmis.org>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> CC: Ingo Molnar <mingo@redhat.com>
> CC: Zhang Rui <rui.zhang@intel.com>
> CC: Eduardo Valentin <edubezval@gmail.com>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/power_allocator.c              |  4 +++
>  include/trace/events/thermal_power_allocator.h | 40 ++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
> index f9e3d3c..1929e9c 100644
> --- a/drivers/thermal/power_allocator.c
> +++ b/drivers/thermal/power_allocator.c
> @@ -331,6 +331,10 @@ static void siblings_grants(struct thermal_zone_device *tz,
>  		total_avail_room += avail_room[i];
>  	}
>  
> +	trace_thermal_power_allocator_divvyup(tz, granted_power, avail_room,
> +					      spare_power, max_power,
> +					      num_actors);
> +
>  	/* Share the extra power inside the same family. */
>  	for (i = 0; i < num_actors; i++) {
>  		u64 power;
> diff --git a/include/trace/events/thermal_power_allocator.h b/include/trace/events/thermal_power_allocator.h
> index 5afae8f..03f224b 100644
> --- a/include/trace/events/thermal_power_allocator.h
> +++ b/include/trace/events/thermal_power_allocator.h
> @@ -54,6 +54,46 @@
>  		__entry->delta_temp)
>  );
>  
> +TRACE_EVENT(thermal_power_allocator_divvyup,
> +	TP_PROTO(struct thermal_zone_device *tz, u32 *granted_power,
> +		u32 *avail_room, u32 *spare_power, u32 *max_power,
> +		size_t num_actors),
> +	TP_ARGS(tz, granted_power, avail_room, spare_power, max_power,
> +		num_actors),
> +	TP_STRUCT__entry(
> +		__field(int, tz_id)
> +		__dynamic_array(u32, granted_power, num_actors)
> +		__dynamic_array(u32, avail_room, num_actors)
> +		__dynamic_array(u32, spare_power, num_actors)
> +		__dynamic_array(u32, max_power, num_actors)
> +		__field(size_t, num_actors)
> +	),
> +	TP_fast_assign(
> +		__entry->tz_id = tz->id;
> +		memcpy(__get_dynamic_array(granted_power), granted_power,
> +			num_actors * sizeof(*granted_power));
> +		memcpy(__get_dynamic_array(avail_room), avail_room,
> +			num_actors * sizeof(*avail_room));
> +		memcpy(__get_dynamic_array(spare_power), spare_power,
> +			num_actors * sizeof(*spare_power));
> +		memcpy(__get_dynamic_array(max_power), max_power,
> +			num_actors * sizeof(*max_power));
> +		__entry->num_actors = num_actors;
> +	),
> +
> +	TP_printk("thermal_zone_id=%d granted_power={%s} avail_room={%s} spare_power={%s} max_power={%s}",
> +		__entry->tz_id,
> +		__print_array(__get_dynamic_array(granted_power),
> +			      __entry->num_actors, 4),
> +		__print_array(__get_dynamic_array(avail_room),
> +			      __entry->num_actors, 4),
> +		__print_array(__get_dynamic_array(spare_power),
> +			      __entry->num_actors, 4),
> +		__print_array(__get_dynamic_array(max_power),
> +			      __entry->num_actors, 4)
> +		)
> +);
> +
>  TRACE_EVENT(thermal_power_allocator_pid,
>  	TP_PROTO(struct thermal_zone_device *tz, s32 err, s32 err_integral,
>  		 s64 p, s64 i, s64 d, s32 output),
