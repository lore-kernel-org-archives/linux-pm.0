From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: Call notifier without holding opp_table->lock
Date: Wed, 20 Sep 2017 10:07:55 -0700
Message-ID: <20170920170755.GA3001@ubuntu>
References: <59C2414E.6020803@samsung.com>
 <45c7e892a69c4936993c65c9987981dbe4433148.1505920911.git.viresh.kumar@linaro.org>
 <20170920170000.GA457@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170920170000.GA457@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, cw00.choi@samsung.com, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, myungjoo.ham@samsung.com, inki.dae@samsung.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 20-09-17, 10:00, Stephen Boyd wrote:
> On 09/20, Viresh Kumar wrote:

> > diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> > index 4360b4efcd4c..668fd940d362 100644
> > --- a/drivers/base/power/opp/core.c
> > +++ b/drivers/base/power/opp/core.c
> > @@ -1627,6 +1627,9 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
> >  
> >  	opp->available = availability_req;
> >  
> > +	dev_pm_opp_get(opp);
> > +	mutex_unlock(&opp_table->lock);
> 
> Does this prevent the OPP from changing while the lock is
> released?

No, its just ref counting and will only prevent it from getting freed.

There is only one thing that can change for an OPP though after it is
created, its availability.

> That would be the only difference from before. It's
> possible that nobody cares about this situation though.

I am not sure if its worth caring for right now :)

Also the notifier chain will not start again until the previous call
chain is finished. So we are kind of synchronized here.

-- 
viresh
