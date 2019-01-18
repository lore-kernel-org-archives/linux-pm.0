From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] drivers: base: Add frequency constraint
 infrastructure
Date: Fri, 18 Jan 2019 15:32:34 +0530
Message-ID: <20190118100234.kq37hc4ldujqvvrb@vireshk-i7>
References: <cover.1547197612.git.viresh.kumar@linaro.org>
 <f3980beb6f2c02427d892a4bc4a04989544a3952.1547197612.git.viresh.kumar@linaro.org>
 <20190118010305.GX261387@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190118010305.GX261387@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 17-01-19, 17:03, Matthias Kaehlcke wrote:
> On Fri, Jan 11, 2019 at 02:48:34PM +0530, Viresh Kumar wrote:
> > +static void fcs_update(struct freq_constraints *fcs, struct freq_pair *freq,
> > +		       enum fc_event event)
> > +{
> > +	mutex_lock(&fcs->lock);
> > +
> > +	if (_fcs_update(fcs, freq, event)) {
> > +		if (fcs->callback)
> > +			schedule_work(&fcs->work);
> 
> IIUC the constraints aren't applied until the callback is executed. I
> wonder if a dedicated workqueue should be used instead of the system
> one, to avoid longer delays from other kernel entities that might
> 'misbehave'. Especially for thermal constraints we want a quick
> response.

I thought the system workqueue should be fast enough, it contains
multiple threads which can all run in parallel and service this work.

> > +
> > +	/* Find a CPU for which fcs already exists */
> > +	for_each_cpu(cpu, cpumask) {
> > +		cpu_dev = get_cpu_device(cpu);
> > +		if (unlikely(!cpu_dev))
> > +			continue;
> > +
> > +		if (unlikely(!first_cpu_dev))
> > +			first_cpu_dev = cpu_dev;
> 
> I'd expect setting the callback to be a one time/rare operation. Is
> there really any gain from cluttering this code with 'unlikely's?
> 
> There are other functions where it could be removed if the outcome is
> that it isn't needed/desirable in code that only runs sporadically.

I was looking to make the code as fast as possible and the use of
unlikely doesn't look that bad to me. Lets see what others have to say
on such a policy.

> > +	if (ret)
> > +		remove_cpumask_fcs(fcs, cpumask, cpu);
> 
> I think it would be clearer to pass -1 instead of 'cpu', as in
> freq_constraint_remove_cpumask_callback(), no need to backtrack and
> 'confirm' that the above for loop always stops at the last CPU in the
> cpumask (unless the function returns due to an error).

Okay.

-- 
viresh
