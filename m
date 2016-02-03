From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/5] cpufreq: governor: Create separate sysfs-ops
Date: Wed, 3 Feb 2016 18:51:40 +0530
Message-ID: <20160203132140.GE3469@vireshk>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
 <5a012e56b8404e2d07e172b6699ce02f5c5b5f26.1454410226.git.viresh.kumar@linaro.org>
 <CAJZ5v0j4sjyQJoPCE0-XHCtZRTjSZU+xpJJHU3UBci0_v1BDvw@mail.gmail.com>
 <20160203065839.GX31828@vireshk>
 <CAJZ5v0g1ebO_S9YJkZjUNZDHqspBATp3jErRP6RqXCy3zh7NDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g1ebO_S9YJkZjUNZDHqspBATp3jErRP6RqXCy3zh7NDw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 03-02-16, 13:42, Rafael J. Wysocki wrote:
> > +static ssize_t governor_show(struct kobject *kobj, struct attribute *attr,
> > +                            char *buf)
> > +{
> > +       struct dbs_data *dbs_data = to_dbs_data(kobj);
> > +       struct governor_attr *gattr = to_gov_attr(attr);
> > +       int ret = -EIO;
> > +
> > +       down_read(&dbs_data->rwsem);
> > +
> > +       if (gattr->show)
> > +               ret = gattr->show(dbs_data, buf);
> > +
> > +       up_read(&dbs_data->rwsem);
> 
> Do we need the lock here too?
> 
> show() is only going to read the value, isn't it?  And everything u32
> or smaller is read atomically anyway.

Okay, will drop it for now.

> Apart from this it looks good to me.
> 
> When you're ready, please resend the whole series without patch [5/5]
> which is premature IMO.

I have changed that patch a bit, and am dropping just the lock now and
not governor_enable thing. That should be sane enough I believe.

Anyway I will be posting 7 patches now, pick only first 4 if you
aren't confident about the rest.

-- 
viresh
