From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/3] cpufreq: add imx6q-cpufreq driver
Date: Tue, 8 Jan 2013 23:04:00 +0800
Message-ID: <20130108150357.GD19534@S2101-09.ap.freescale.net>
References: <1357628043-19256-1-git-send-email-shawn.guo@linaro.org>
 <1357628043-19256-3-git-send-email-shawn.guo@linaro.org>
 <CAOh2x=mv9_iWt+y9cP0oA4WKs86Ne9nRP6CgKy_1COnPm57YOA@mail.gmail.com>
 <20130108143554.GC19534@S2101-09.ap.freescale.net>
 <CAKohpomQuoUgPVp6e9_UrK0sk+z26cG36DoxH91LWSmBHD36BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKohpomQuoUgPVp6e9_UrK0sk+z26cG36DoxH91LWSmBHD36BQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 08, 2013 at 08:11:37PM +0530, Viresh Kumar wrote:
> On 8 January 2013 20:05, Shawn Guo <shawn.guo@linaro.org> wrote:
> >> > +static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
> >> > +{
> >> > +       int ret;
> >> > +
> >> > +       if (policy->cpu != 0)
> >> > +               return -EINVAL;
> >>
> >> Why? The problem here is when you hot-unplug cpu0, init would be called for
> >> cpu1 and it would fail.
> >>
> >
> > On imx6q, we can never hot-unplug cpu0.  And all the cores of imx6q
> > share the clock and voltage, so have to scale together.  That's why
> > we only need to do this init for cpu0.
> 
> Ok, in that case too you don't need this code. init() wouldn't be
> called for any other
> cpu if policy->cpus is set correctly. So, that turns out to be a junk code.

I'm seeing that the .init() will be called on cpu1 when removing the
module.

Shawn

