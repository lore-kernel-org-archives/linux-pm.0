From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/12] cpufreq: governor: Close dbs_data update race
 condition
Date: Fri, 19 Feb 2016 07:57:21 +0530
Message-ID: <20160219022721.GA16983@vireshk-i7>
References: <2938006.67J0esUvOA@vostro.rjw.lan>
 <1592265.QLnTJA45ZD@vostro.rjw.lan>
 <20160218052409.GG2610@vireshk-i7>
 <CAJZ5v0jFP5hdcomAw1GcMgVAhw1mnwpZ3vdM7vN59SFkiug_YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jFP5hdcomAw1GcMgVAhw1mnwpZ3vdM7vN59SFkiug_YA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 18-02-16, 17:20, Rafael J. Wysocki wrote:
> On Thu, Feb 18, 2016 at 6:24 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 18-02-16, 02:19, Rafael J. Wysocki wrote:

> >> @@ -112,7 +112,7 @@ static ssize_t governor_store(struct kob
> >>
> >>       mutex_lock(&dbs_data->mutex);
> >>
> >> -     if (gattr->store)
> >> +     if (dbs_data->usage_count && gattr->store)
> >
> > That's not gonna be enough. The above lock doesn't guarantee
> > protection with any such races.

Oops, I completely misread it. Really sorry about that.

But now that I have read the code again, I wonder why we need this protection at
all. The first thing we do after decrementing the usage_count counter, is we put
the kobject. Which will ensure that the sysfs files are all gone. So, what is
the race we are trying to fix then?

> Yeah, they are quite useless.  But not in this patch.

Sure.

-- 
viresh
