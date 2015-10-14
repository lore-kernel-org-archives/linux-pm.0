From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v6 4/5] devfreq_cooling: add trace information
Date: Wed, 14 Oct 2015 12:53:30 +0100
Message-ID: <20151014115329.GA2998@e104805>
References: <1441904972-5809-1-git-send-email-javi.merino@arm.com>
 <1441904972-5809-5-git-send-email-javi.merino@arm.com>
 <20150910131928.3c88fe28@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150910131928.3c88fe28@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cw00.choi@samsung.com" <cw00.choi@samsung.com>, "edubezval@gmail.com" <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

Hi Steve,

On Thu, Sep 10, 2015 at 06:19:28PM +0100, Steven Rostedt wrote:
> On Thu, 10 Sep 2015 18:09:31 +0100
> Javi Merino <javi.merino@arm.com> wrote:
> 
> > Tracing is useful for debugging and performance tuning.  Add similar
> > traces to what's present in the cpu cooling device.
> > 
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Signed-off-by: Javi Merino <javi.merino@arm.com>
> > ---
> >  drivers/thermal/devfreq_cooling.c |  6 +++++
> >  include/trace/events/thermal.h    | 53 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 59 insertions(+)
> > 
> > diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> > index a032c5d5c374..a27206815066 100644
> > --- a/drivers/thermal/devfreq_cooling.c
> > +++ b/drivers/thermal/devfreq_cooling.c
> > @@ -25,6 +25,8 @@
> >  #include <linux/pm_opp.h>
> >  #include <linux/thermal.h>
> >  
> > +#include <trace/events/thermal.h>
> > +
> >  static DEFINE_MUTEX(devfreq_lock);
> >  static DEFINE_IDR(devfreq_idr);
> >  
> > @@ -293,6 +295,9 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
> >  	/* Get static power */
> >  	static_power = get_static_power(dfc, freq);
> >  
> > +	trace_thermal_power_devfreq_get_power(cdev, status, freq, dyn_power,
> > +					      static_power);
> > +
> >  	*power = dyn_power + static_power;
> >  
> >  	return 0;
> > @@ -348,6 +353,7 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
> >  			break;
> >  
> >  	*state = i;
> > +	trace_thermal_power_devfreq_limit(cdev, freq, *state, power);
> 
> I'm curious, does changing the above to:
> 
> 	trace_thermal_power_devfreq_limit(cdev, freq, i, power);
> 
> make the compiled code better?
> 
> A tracepoint does some whacky things, and gcc may not optimize this.
> 
> The rest looks fine to me.

Can I treat that last statement as an Acked-by?
