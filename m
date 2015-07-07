From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH 4/4] devfreq_cooling: add trace information
Date: Tue, 7 Jul 2015 08:56:51 +0100
Message-ID: <20150707075651.GB2817@e104805>
References: <1435928310-15938-1-git-send-email-javi.merino@arm.com>
 <1435928310-15938-5-git-send-email-javi.merino@arm.com>
 <20150706145843.7f475472@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:43760 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754218AbbGGH5D (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2015 03:57:03 -0400
Content-Disposition: inline
In-Reply-To: <20150706145843.7f475472@gandalf.local.home>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Ingo Molnar <mingo@redhat.com>

On Mon, Jul 06, 2015 at 07:58:43PM +0100, Steven Rostedt wrote:
> On Fri,  3 Jul 2015 13:58:30 +0100
> Javi Merino <javi.merino@arm.com> wrote:
> 
> 
> > @@ -142,6 +144,10 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
> >  	/* Get static power */
> >  	static_power = get_static_power(dfc, freq);
> >  
> > +	load = (100 * status->busy_time) / status->total_time;
> 
> When tracing is disabled, this division will still be done.
> 
> Why not just pass in status, and have the load calculated in the
> tracepoint TP_fast_assign() ?

Yes, no point doing it here.  I'll move it to the tracepoint's code.

Thanks for the review,
Javi

> > +	trace_thermal_power_devfreq_get_power(cdev, freq, load, dyn_power,
> > +					      static_power);
> > +
> >  	*power = dyn_power + static_power;
> >  
> >  	return 0;
> > @@ -195,6 +201,7 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
> >  			break;
> >  
> >  	*state = i;
> > +	trace_thermal_power_devfreq_limit(cdev, freq, *state, power);
> >  	return 0;
> >  }
> >  
> > diff --git a/include/trace/events/thermal.h b/include/trace/events/thermal.h
> > index 8b1f80682b80..ffa870c0d2d2 100644
> > --- a/include/trace/events/thermal.h
> > +++ b/include/trace/events/thermal.h
> > @@ -135,6 +135,57 @@ TRACE_EVENT(thermal_power_cpu_limit,
> >  		__entry->power)
> >  );
> >  
> > +TRACE_EVENT(thermal_power_devfreq_get_power,
> > +	TP_PROTO(struct thermal_cooling_device *cdev, unsigned long freq,
> > +		u32 load, u32 dynamic_power, u32 static_power),
> > +
> > +	TP_ARGS(cdev, freq, load, dynamic_power, static_power),
> > +
> > +	TP_STRUCT__entry(
> > +		__string(type,         cdev->type    )
> > +		__field(unsigned long, freq          )
> > +		__field(u32,           load          )
> > +		__field(u32,           dynamic_power )
> > +		__field(u32,           static_power  )
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__assign_str(type, cdev->type);
> > +		__entry->freq = freq;
> > +		__entry->load = load;
> 
>  __entry->load = (100 * status->busy_time) / status->total_time;
> 
> -- Steve
> 
> > +		__entry->dynamic_power = dynamic_power;
> > +		__entry->static_power = static_power;
> > +	),
> > +
> > +	TP_printk("type=%s freq=%lu load=%u dynamic_power=%u static_power=%u",
> > +		__get_str(type), __entry->freq,
> > +		__entry->load, __entry->dynamic_power, __entry->static_power)
> > +);
> > +
> > +TRACE_EVENT(thermal_power_devfreq_limit,
> > +	TP_PROTO(struct thermal_cooling_device *cdev, unsigned long freq,
> > +		unsigned long cdev_state, u32 power),
> > +
> > +	TP_ARGS(cdev, freq, cdev_state, power),
> > +
> > +	TP_STRUCT__entry(
> > +		__string(type,         cdev->type)
> > +		__field(unsigned int,  freq      )
> > +		__field(unsigned long, cdev_state)
> > +		__field(u32,           power     )
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__assign_str(type, cdev->type);
> > +		__entry->freq = freq;
> > +		__entry->cdev_state = cdev_state;
> > +		__entry->power = power;
> > +	),
> > +
> > +	TP_printk("type=%s freq=%u cdev_state=%lu power=%u",
> > +		__get_str(type), __entry->freq, __entry->cdev_state,
> > +		__entry->power)
> > +);
> >  #endif /* _TRACE_THERMAL_H */
> >  
> >  /* This part must be outside protection */
> 
