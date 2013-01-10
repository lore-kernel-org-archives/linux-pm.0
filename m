From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 1/2] cpufreq: add imx6q-cpufreq driver
Date: Thu, 10 Jan 2013 19:55:03 +0800
Message-ID: <20130110115500.GJ2265@S2101-09.ap.freescale.net>
References: <1357806863-6899-1-git-send-email-shawn.guo@linaro.org>
 <1357806863-6899-2-git-send-email-shawn.guo@linaro.org>
 <CAKohpom2Z0LmTNjq6mbZAa=JvQfBeRBzfXU3Jifn8y_C6XJkQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKohpom2Z0LmTNjq6mbZAa=JvQfBeRBzfXU3Jifn8y_C6XJkQw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 10, 2013 at 02:15:44PM +0530, Viresh Kumar wrote:
...
> > +       clk_prepare_enable(pll2_pfd2_396m_clk);
> > +       clk_set_parent(step_clk, pll2_pfd2_396m_clk);
> > +       clk_set_parent(pll1_sw_clk, step_clk);
> > +       clk_prepare_enable(pll1_sys_clk);
> 
> all these fns can fail too.. don't want to check return values?
> 
I initially had every single clk and regulator call return checked
and error handled properly.  But the code becomes very messy with
the error messages and recovering logic all over the places.  I think
it's a bit over engineering, and made a compromise to only check limited
ones to ensure the correctness at subsystem level.

> > +static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
> > +{
> > +       int ret;
> > +
> 
> So you finally removed the ugly check :)
> 
I just found though it's less optimal, removing the check does not
really cause any problem for me.

> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks.

Shawn

