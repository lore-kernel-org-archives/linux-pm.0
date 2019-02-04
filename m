From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: tegra124: add missing of_node_put()
Date: Mon, 4 Feb 2019 12:48:09 +0530
Message-ID: <20190204071809.versc7prqit3vzgc@vireshk-i7>
References: <20190204063501.1348-1-tiny.windzz@gmail.com>
 <20190204063615.yr4fbz3b7ovbm7a2@vireshk-i7>
 <CAEExFWvcWAmzKtnCdnVNJz1kh1QQ-Y8-LRpH36YacQerFpOS9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEExFWvcWAmzKtnCdnVNJz1kh1QQ-Y8-LRpH36YacQerFpOS9A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Frank Lee <tiny.windzz@gmail.com>
Cc: rjw@rjwysocki.net, Thierry Reding <thierry.reding@gmail.com>, jonathanh@nvidia.com, Linux PM <linux-pm@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 04-02-19, 15:00, Frank Lee wrote:
> On Mon, Feb 4, 2019 at 2:36 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 04-02-19, 01:35, Yangtao Li wrote:
> > > of_cpu_device_node_get() will increase the refcount of device_node,
> > > it is necessary to call of_node_put() at the end to release the
> > > refcount.
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > ---
> > >  drivers/cpufreq/tegra124-cpufreq.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
> > > index 43530254201a..140a9266b64a 100644
> > > --- a/drivers/cpufreq/tegra124-cpufreq.c
> > > +++ b/drivers/cpufreq/tegra124-cpufreq.c
> > > @@ -118,6 +118,8 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
> > >               goto out_put_pllx_clk;
> > >       }
> > >
> > > +     of_node_put(np);
> > > +
> > >       ret = tegra124_cpu_switch_to_dfll(priv);
> > >       if (ret)
> > >               goto out_put_pllp_clk;
> >
> > Fixes and stable tags ?
> Hi viresh,
> 
> Like this？
> 
> Fixes: 9eb15dbbfa1a2 ("cpufreq: Add cpufreq driver for Tegra124")
> Cc: stable@vger.kernel.org

This needs to be something like:

Cc: 4.5+ stable@vger.kernel.org #4.5+

Also I don't think your patch is entirely correct as we will end up
doing of_node_put() twice in error path.

-- 
viresh
