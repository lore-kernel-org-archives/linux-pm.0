From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] cpufreq: dt-platdev: mark RK3399 as having separate
 policies per cluster
Date: Tue, 2 Oct 2018 22:22:54 -0700
Message-ID: <CAKdAkRR1UprR6d4ObZagpHEtPXi8eotG+qd=2NM1kOvFKzOxXg@mail.gmail.com>
References: <20181001202153.GA240123@dtor-ws> <20181003044150.i46eaoyco3w47nid@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181003044150.i46eaoyco3w47nid@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Derek Basehore <dbasehore@chromium.org>, Guenter Roeck <groeck@chromium.org>, Linux PM <linux-pm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 2, 2018 at 9:41 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 01-10-18, 13:21, Dmitry Torokhov wrote:
> > RK3399 has one cluster with 4 small cores, and another one with 2 big
> > cores, with cores in different clusters having different OPPs and thus
> > different policies. Let's enable this via "have_governor_per_policy"
> > platform data.
>
> The policies are always different in such cases, with or without this flag. What
> this flag rather enables is for us to have separate set of tunables for the
> governor for individual policies.
>
> For example, without this flag there will be a single governor directory:
>
> /sys/devices/system/cpu/cpufreq/schedutil/
>
> and the value of tunables in that directory will be used for all cpufreq
> policies.
>
> With this flag you wouldn't have the governor directory there, but rather in:
>
> /sys/devices/system/cpu/cpufreq/policy*/schedutil/
>
> i.e. tunables per policy and that's why the name of the flag is:
> have_governor_per_policy.
>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >
> > Not tested, but we had a patch unconditionally enabling
> > CPUFREQ_HAVE_GOVERNOR_PER_POLICY flag in tree we used to ship devices
> > based on RK3399 platform.
>
> Sure, that sounds good. Just that you need to update the commit log a bit.

OK, I'll do that.

>
> >  drivers/cpufreq/cpufreq-dt-platdev.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> > index fe14c57de6ca..040ec0f711f9 100644
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -78,7 +78,10 @@ static const struct of_device_id whitelist[] __initconst = {
> >       { .compatible = "rockchip,rk3328", },
> >       { .compatible = "rockchip,rk3366", },
> >       { .compatible = "rockchip,rk3368", },
> > -     { .compatible = "rockchip,rk3399", },
> > +     { .compatible = "rockchip,rk3399",
> > +       .data = &(struct cpufreq_dt_platform_data)
>
> data is void *. No need to provide typecast information. This shouldn't throw
> any build warnings I believe.

We however need to tell the compiler the type of structure we are
creating. The following won't compile:

        .data = &{ .have_governor_per_policy = true, }

Thanks.

-- 
Dmitry
