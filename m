From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 2/2] cpufreq: dt: Implement online/offline() callbacks
Date: Tue, 12 Feb 2019 15:19:09 +0530
Message-ID: <20190212094909.5eivfzfnc62lay7x@vireshk-i7>
References: <cover.1549955027.git.viresh.kumar@linaro.org>
 <8030961ef762018fc286e4d3d3a010638e900e53.1549955027.git.viresh.kumar@linaro.org>
 <CAJZ5v0hLOD-5XDp7jAwt4EqWYGAU9VZzumNchW9_+bt7F1MdQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hLOD-5XDp7jAwt4EqWYGAU9VZzumNchW9_+bt7F1MdQw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12-02-19, 10:43, Rafael J. Wysocki wrote:
> On Tue, Feb 12, 2019 at 8:07 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Implement the light-weight tear down and bring up helpers to reduce the
> > amount of work to do on CPU offline/online operation.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq-dt.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> > index 7ba392911cd0..1aefaa1b0ca2 100644
> > --- a/drivers/cpufreq/cpufreq-dt.c
> > +++ b/drivers/cpufreq/cpufreq-dt.c
> > @@ -295,6 +295,21 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> >         return ret;
> >  }
> >
> > +static int cpufreq_online(struct cpufreq_policy *policy)
> > +{
> > +       /* We did light-weight tear down earlier, nothing to do here */
> > +       return 0;
> > +}
> 
> I think you could avoid having to add this empty stub if the core
> checked for both online and offline, that is
> 
> if (driver->offline || driver->online) {

This doesn't look great as all we should care about here is ->online()
and checking for offline as well looks a bit hacky.

>     ret = driver->online ? driver->online(policy) : 0;
> } else {
>     ret = driver->init(policy);
> }
> 
> or similar.

I also thought of a new flag like: CPUFREQ_LIGHT_WEIGHT_OFFLINE and
then we can get rid of both online/offline dummies but then thought of
starting with the dummy routines to begin with :)

-- 
viresh
