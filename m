From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 1/3] drivers: base: Add frequency constraint
 infrastructure
Date: Tue, 22 Jan 2019 09:50:42 -0800
Message-ID: <20190122175042.GE261387@google.com>
References: <cover.1547197612.git.viresh.kumar@linaro.org>
 <f3980beb6f2c02427d892a4bc4a04989544a3952.1547197612.git.viresh.kumar@linaro.org>
 <20190118010305.GX261387@google.com>
 <20190118100234.kq37hc4ldujqvvrb@vireshk-i7>
 <20190118224534.GC261387@google.com>
 <20190122070936.jsjvivzplfpdweck@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190122070936.jsjvivzplfpdweck@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 22, 2019 at 12:39:36PM +0530, Viresh Kumar wrote:
> On 18-01-19, 14:45, Matthias Kaehlcke wrote:
> > On Fri, Jan 18, 2019 at 03:32:34PM +0530, Viresh Kumar wrote:
> > > On 17-01-19, 17:03, Matthias Kaehlcke wrote:
> > > > On Fri, Jan 11, 2019 at 02:48:34PM +0530, Viresh Kumar wrote:
> > > > > +static void fcs_update(struct freq_constraints *fcs, struct freq_pair *freq,
> > > > > +		       enum fc_event event)
> > > > > +{
> > > > > +	mutex_lock(&fcs->lock);
> > > > > +
> > > > > +	if (_fcs_update(fcs, freq, event)) {
> > > > > +		if (fcs->callback)
> > > > > +			schedule_work(&fcs->work);
> > > > 
> > > > IIUC the constraints aren't applied until the callback is executed. I
> > > > wonder if a dedicated workqueue should be used instead of the system
> > > > one, to avoid longer delays from other kernel entities that might
> > > > 'misbehave'. Especially for thermal constraints we want a quick
> > > > response.
> > > 
> > > I thought the system workqueue should be fast enough, it contains
> > > multiple threads which can all run in parallel and service this work.
> > 
> > Ok, I was still stuck at the old one thread per CPU model, where a
> > slow work would block other items in the same workqueue until it
> > finishes execution. After reading a bit through
> > Documentation/core-api/workqueue.rst I agree that a system workqueue
> > is probably fast enough. It might be warranted though to use
> > system_highpri_wq here.
> 
> Is this really that high priority stuff ? I am not sure.

In terms of thermal it could be. But then again, thermal throttling is
driven by input from thermal sensors, which often are polled with
periods >= 100 ms rather than being interrupt driven, so the type of
workqueue wouldn't make a major difference here. I now think it should
be fine to use the normal workqueue unless problems are reported.
