From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpuidle: sysfs: Export target residency information
Date: Tue, 08 Apr 2014 13:03:57 +0200
Message-ID: <9839403.J56jNEsGD1@vostro.rjw.lan>
References: <1395055050-27729-1-git-send-email-daniel.lezcano@linaro.org> <5343BDAC.70603@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5343BDAC.70603@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lenb@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, April 08, 2014 11:13:16 AM Daniel Lezcano wrote:
> On 03/17/2014 12:17 PM, Daniel Lezcano wrote:
> >  From userspace, there is no way to know the target residency for each idle
> > state. If we want to write tools to measure the accuracy of the idle state
> > selection from the governor, we need this info.
> >
> > As the exit latency is exported through sysfs, exporting the target residency
> > in the same place makes sense.
> >
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> 
> Hi Rafael,
> 
> are you willing to take this patch ?

Yes, I'm going to take it.

Thanks!

> >   drivers/cpuidle/sysfs.c |    3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> > index e918b6d..efe2f17 100644
> > --- a/drivers/cpuidle/sysfs.c
> > +++ b/drivers/cpuidle/sysfs.c
> > @@ -293,6 +293,7 @@ static ssize_t show_state_##_name(struct cpuidle_state *state, \
> >   }
> >
> >   define_show_state_function(exit_latency)
> > +define_show_state_function(target_residency)
> >   define_show_state_function(power_usage)
> >   define_show_state_ull_function(usage)
> >   define_show_state_ull_function(time)
> > @@ -304,6 +305,7 @@ define_store_state_ull_function(disable)
> >   define_one_state_ro(name, show_state_name);
> >   define_one_state_ro(desc, show_state_desc);
> >   define_one_state_ro(latency, show_state_exit_latency);
> > +define_one_state_ro(residency, show_state_target_residency);
> >   define_one_state_ro(power, show_state_power_usage);
> >   define_one_state_ro(usage, show_state_usage);
> >   define_one_state_ro(time, show_state_time);
> > @@ -313,6 +315,7 @@ static struct attribute *cpuidle_state_default_attrs[] = {
> >   	&attr_name.attr,
> >   	&attr_desc.attr,
> >   	&attr_latency.attr,
> > +	&attr_residency.attr,
> >   	&attr_power.attr,
> >   	&attr_usage.attr,
> >   	&attr_time.attr,
> >
> 
> 
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
