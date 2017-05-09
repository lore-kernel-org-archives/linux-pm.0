From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 2/2] trace: power allocator: add trace for divvyup
 algorithm
Date: Tue, 9 May 2017 10:46:41 -0400
Message-ID: <20170509104641.6946f4bc@gandalf.local.home>
References: <1494339236-22666-1-git-send-email-lukasz.luba@arm.com>
        <1494339236-22666-3-git-send-email-lukasz.luba@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751210AbdEIOqs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 May 2017 10:46:48 -0400
In-Reply-To: <1494339236-22666-3-git-send-email-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, Ingo Molnar <mingo@redhat.com>

On Tue,  9 May 2017 15:13:56 +0100
Lukasz Luba <lukasz.luba@arm.com> wrote:

> This trace function helps to figure out the divvyup algorithm
> on some platforms.
> 
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Zhang Rui <rui.zhang@intel.com>
> CC: Eduardo Valentin <edubezval@gmail.com>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  include/trace/events/thermal_power_allocator.h | 40 ++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
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

Hmm, isn't there suppose to be a user of this? I see the event created,
but no callers. And this is a patch 2 of 2, so either there isn't any
in this series, or it was added in patch 1 which will cause the build
to break during bisect (I'm not Cc'd on patch 1, so I don't know, and
I'm too lazy to look at LKML for it).

-- Steve
