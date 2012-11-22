From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: Re: [PATCH v3] cpufreq: ondemand: handle SW coordinated CPUs
Date: Thu, 22 Nov 2012 18:02:37 +0100
Message-ID: <20121122170237.GA16948@gmail.com>
References: <1353413176-21723-1-git-send-email-fabio.baltieri@linaro.org>
 <1353413176-21723-2-git-send-email-fabio.baltieri@linaro.org>
 <1708590.LLn32jdgxe@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1708590.LLn32jdgxe@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Rickard Andersson <rickard.andersson@stericsson.com>, Vincent Guittot <vincent.guittot@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello Rafael,

thanks for the review!  I only have one concern before sending a v4:

On Thu, Nov 22, 2012 at 01:10:15AM +0100, Rafael J. Wysocki wrote:
> > @@ -627,32 +659,41 @@ static void do_dbs_timer(struct work_struct *work)
> >  				delay -= jiffies % delay;
> >  		}
> >  	} else {
> > -		__cpufreq_driver_target(dbs_info->cur_policy,
> > -			dbs_info->freq_lo, CPUFREQ_RELATION_H);
> > +		if (sample)
> > +			__cpufreq_driver_target(dbs_info->cur_policy,
> > +						dbs_info->freq_lo,
> > +						CPUFREQ_RELATION_H);
> >  		delay = dbs_info->freq_lo_jiffies;
> >  	}
> > -	schedule_delayed_work_on(cpu, &dbs_info->work, delay);
> > +	schedule_delayed_work_on(smp_processor_id(), dw, delay);
> 
> We're not supposed to be using smp_processor_id() any more.
> get_cpu()/put_cpu() should be used instead.

That's going to add preemption protection, do I need that?  The function
is called from a kworker with the affinity set on a specific CPU, so it
should not migrate to a different one during execution.

I agree with you for all the other comments.

Thanks,
Fabio

-- 
Fabio Baltieri
