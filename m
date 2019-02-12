From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2 2/2] cpufreq: dt: Implement online/offline() callbacks
Date: Tue, 12 Feb 2019 11:26:25 +0100
Message-ID: <CAJZ5v0hABvt2w7v9bfxyzf84+a4LU4C4tczVvwFnaDaY=pKG6A@mail.gmail.com>
References: <cover.1549955027.git.viresh.kumar@linaro.org> <8030961ef762018fc286e4d3d3a010638e900e53.1549955027.git.viresh.kumar@linaro.org>
 <CAJZ5v0hLOD-5XDp7jAwt4EqWYGAU9VZzumNchW9_+bt7F1MdQw@mail.gmail.com> <20190212094909.5eivfzfnc62lay7x@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212094909.5eivfzfnc62lay7x@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 12, 2019 at 10:49 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 12-02-19, 10:43, Rafael J. Wysocki wrote:
> > On Tue, Feb 12, 2019 at 8:07 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > Implement the light-weight tear down and bring up helpers to reduce the
> > > amount of work to do on CPU offline/online operation.
> > >
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  drivers/cpufreq/cpufreq-dt.c | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > >
> > > diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> > > index 7ba392911cd0..1aefaa1b0ca2 100644
> > > --- a/drivers/cpufreq/cpufreq-dt.c
> > > +++ b/drivers/cpufreq/cpufreq-dt.c
> > > @@ -295,6 +295,21 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> > >         return ret;
> > >  }
> > >
> > > +static int cpufreq_online(struct cpufreq_policy *policy)
> > > +{
> > > +       /* We did light-weight tear down earlier, nothing to do here */
> > > +       return 0;
> > > +}
> >
> > I think you could avoid having to add this empty stub if the core
> > checked for both online and offline, that is
> >
> > if (driver->offline || driver->online) {
>
> This doesn't look great as all we should care about here is ->online()
> and checking for offline as well looks a bit hacky.

That's a matter of the driver I/F definition.

You can require online to be there if offline is set and the other way
around (but then you should check if that's the case while registering
the driver) or you can allow just one of them to be provided for the
lightweight online/offline to be done.  In the latter case the
presence of the other callback plays the role of a flag.

Both are basically fine by me, but if you go for the former, please
add the checks to cpufreq_register_driver().
