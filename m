From: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH] cpufreq: tegra124: add missing of_node_put()
Date: Mon, 4 Feb 2019 15:26:36 +0800
Message-ID: <CAEExFWtzRJX6-_A2mgKpRuvSws7SNZPMAbcuPu-maP3Jh=xnyg@mail.gmail.com>
References: <20190204063501.1348-1-tiny.windzz@gmail.com> <20190204063615.yr4fbz3b7ovbm7a2@vireshk-i7>
 <CAEExFWvcWAmzKtnCdnVNJz1kh1QQ-Y8-LRpH36YacQerFpOS9A@mail.gmail.com> <20190204071809.versc7prqit3vzgc@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190204071809.versc7prqit3vzgc@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, Thierry Reding <thierry.reding@gmail.com>, jonathanh@nvidia.com, Linux PM <linux-pm@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 4, 2019 at 3:18 PM Viresh Kumar <viresh.kumar@linaro.org> wrote=
:
>
> On 04-02-19, 15:00, Frank Lee wrote:
> > On Mon, Feb 4, 2019 at 2:36 PM Viresh Kumar <viresh.kumar@linaro.org> w=
rote:
> > >
> > > On 04-02-19, 01:35, Yangtao Li wrote:
> > > > of_cpu_device_node_get() will increase the refcount of device_node,
> > > > it is necessary to call of_node_put() at the end to release the
> > > > refcount.
> > > >
> > > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > > ---
> > > >  drivers/cpufreq/tegra124-cpufreq.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/t=
egra124-cpufreq.c
> > > > index 43530254201a..140a9266b64a 100644
> > > > --- a/drivers/cpufreq/tegra124-cpufreq.c
> > > > +++ b/drivers/cpufreq/tegra124-cpufreq.c
> > > > @@ -118,6 +118,8 @@ static int tegra124_cpufreq_probe(struct platfo=
rm_device *pdev)
> > > >               goto out_put_pllx_clk;
> > > >       }
> > > >
> > > > +     of_node_put(np);
> > > > +
> > > >       ret =3D tegra124_cpu_switch_to_dfll(priv);
> > > >       if (ret)
> > > >               goto out_put_pllp_clk;
> > >
> > > Fixes and stable tags ?
> > Hi viresh,
> >
> > Like this=EF=BC=9F
> >
> > Fixes: 9eb15dbbfa1a2 ("cpufreq: Add cpufreq driver for Tegra124")
> > Cc: stable@vger.kernel.org
>
> This needs to be something like:
>
> Cc: 4.5+ stable@vger.kernel.org #4.5+
>
> Also I don't think your patch is entirely correct as we will end up
> doing of_node_put() twice in error path.
Thanks for your reminder, I will modify it immediately.

MBR,
Yangtao
>
> --
> viresh
