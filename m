From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/2] trace: power allocator: add trace for divvyup
 algorithm
Date: Mon, 8 May 2017 10:37:14 -0400
Message-ID: <20170508103714.1ad473b1@gandalf.local.home>
References: <1494250802-6663-1-git-send-email-lukasz.luba@arm.com>
        <1494250802-6663-3-git-send-email-lukasz.luba@arm.com>
        <20170508094432.1010ee75@gandalf.local.home>
        <cf2867c3-8a26-7b05-a209-dd82d7ca7292@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752042AbdEHOhU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 May 2017 10:37:20 -0400
In-Reply-To: <cf2867c3-8a26-7b05-a209-dd82d7ca7292@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, Ingo Molnar <mingo@redhat.com>

On Mon, 8 May 2017 15:21:53 +0100
Lukasz Luba <lukasz.luba@arm.com> wrote:

> Hi Steven,
> 
> On 08/05/17 14:44, Steven Rostedt wrote:
> > On Mon,  8 May 2017 14:40:02 +0100
> > Lukasz Luba <lukasz.luba@arm.com> wrote:
> >  
> >> This trace function helps to figure out the divvyup algorithm
> >> on some platforms.
> >>
> >> CC: Steven Rostedt <rostedt@goodmis.org>
> >> CC: Ingo Molnar <mingo@redhat.com>
> >> CC: Zhang Rui <rui.zhang@intel.com>
> >> CC: Eduardo Valentin <edubezval@gmail.com>
> >> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> >> ---
> >>  drivers/thermal/power_allocator.c              |  4 +++
> >>  include/trace/events/thermal_power_allocator.h | 40 ++++++++++++++++++++++++++
> >>  2 files changed, 44 insertions(+)
> >>
> >> diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
> >> index db74e05..b71125a 100644
> >> --- a/drivers/thermal/power_allocator.c
> >> +++ b/drivers/thermal/power_allocator.c
> >> @@ -331,6 +331,10 @@ static void siblings_grants(struct thermal_zone_device *tz,
> >>  		total_avail_room += avail_room[i];
> >>  	}
> >>
> >> +	trace_thermal_power_allocator_divvyup(tz, granted_power, avail_room,
> >> +					      spare_power, max_power,
> >> +					      num_actors);  
> >
> > I'm curious, how big can "num_actors" be?  
> That's a good question.
> Normally max is around 5 (2 CPU clusters + 3 devfreq devices).
> However, when you have per-core DVFS for CPUs
> and you have N cores (i.e. 32), then you can register N cooling
> devices for them.

Hmm, is it cores per CPU, or just cores? If I boot up a box with 240
cores, can that N = 240?

An event has a max size of PAGE_SIZE - buffer_header, where
sizeof(buffer_header) is usually 16. That means an event can be 4080
bytes at most. An event has a 8 byte header (on large events), and
ftrace adds another 8 bytes. The pay load of TRACE_EVENT is a max of
4064.

Each dynamic_array has a 4 byte header, to save the size and offset of
the array data. With two 4 byte fields, we have for this event, a
minimum of 24 bytes. This gives up 1010 bytes per array. That gives us
a max of num_actors = 252 before the event size is exhausted. The
output of events has some limits but I'm not going into that.

I'm guessing this wont be an issue anytime soon. If we do exhaust the
size, the trace event will fail to allocate, and you'll just lose
events. Nothing else will break.

Just letting you know.

-- Steve

> >  
> >> +
> >>  	/* Share the extra power inside the same family. */
> >>  	for (i = 0; i < num_actors; i++) {
> >>  		u32 power;
> >> diff --git a/include/trace/events/thermal_power_allocator.h b/include/trace/events/thermal_power_allocator.h
> >> index 5afae8f..03f224b 100644
> >> --- a/include/trace/events/thermal_power_allocator.h
> >> +++ b/include/trace/events/thermal_power_allocator.h
> >> @@ -54,6 +54,46 @@
> >>  		__entry->delta_temp)
> >>  );
> >>
> >> +TRACE_EVENT(thermal_power_allocator_divvyup,
> >> +	TP_PROTO(struct thermal_zone_device *tz, u32 *granted_power,
> >> +		u32 *avail_room, u32 *spare_power, u32 *max_power,
> >> +		size_t num_actors),
> >> +	TP_ARGS(tz, granted_power, avail_room, spare_power, max_power,
> >> +		num_actors),
> >> +	TP_STRUCT__entry(
> >> +		__field(int, tz_id)
> >> +		__dynamic_array(u32, granted_power, num_actors)
> >> +		__dynamic_array(u32, avail_room, num_actors)
> >> +		__dynamic_array(u32, spare_power, num_actors)
> >> +		__dynamic_array(u32, max_power, num_actors)
> >> +		__field(size_t, num_actors)
> >> +	),
> >> +	TP_fast_assign(
> >> +		__entry->tz_id = tz->id;
> >> +		memcpy(__get_dynamic_array(granted_power), granted_power,
> >> +			num_actors * sizeof(*granted_power));
> >> +		memcpy(__get_dynamic_array(avail_room), avail_room,
> >> +			num_actors * sizeof(*avail_room));
> >> +		memcpy(__get_dynamic_array(spare_power), spare_power,
> >> +			num_actors * sizeof(*spare_power));
> >> +		memcpy(__get_dynamic_array(max_power), max_power,
> >> +			num_actors * sizeof(*max_power));
> >> +		__entry->num_actors = num_actors;
> >> +	),
> >> +
> >> +	TP_printk("thermal_zone_id=%d granted_power={%s} avail_room={%s} spare_power={%s} max_power={%s}",
> >> +		__entry->tz_id,
> >> +		__print_array(__get_dynamic_array(granted_power),
> >> +			      __entry->num_actors, 4),
> >> +		__print_array(__get_dynamic_array(avail_room),
> >> +			      __entry->num_actors, 4),
> >> +		__print_array(__get_dynamic_array(spare_power),
> >> +			      __entry->num_actors, 4),
> >> +		__print_array(__get_dynamic_array(max_power),
> >> +			      __entry->num_actors, 4)
> >> +		)
> >> +);
> >> +
> >>  TRACE_EVENT(thermal_power_allocator_pid,
> >>  	TP_PROTO(struct thermal_zone_device *tz, s32 err, s32 err_integral,
> >>  		 s64 p, s64 i, s64 d, s32 output),  
> >  
> 
> Regards,
> Lukasz
