From: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH] cpufreq: tegra124: add missing of_node_put()
Date: Mon, 4 Feb 2019 15:00:13 +0800
Message-ID: <CAEExFWvcWAmzKtnCdnVNJz1kh1QQ-Y8-LRpH36YacQerFpOS9A@mail.gmail.com>
References: <20190204063501.1348-1-tiny.windzz@gmail.com> <20190204063615.yr4fbz3b7ovbm7a2@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190204063615.yr4fbz3b7ovbm7a2@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, Thierry Reding <thierry.reding@gmail.com>, jonathanh@nvidia.com, Linux PM <linux-pm@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 4, 2019 at 2:36 PM Viresh Kumar <viresh.kumar@linaro.org> wrote=
:
>
> On 04-02-19, 01:35, Yangtao Li wrote:
> > of_cpu_device_node_get() will increase the refcount of device_node,
> > it is necessary to call of_node_put() at the end to release the
> > refcount.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/cpufreq/tegra124-cpufreq.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra=
124-cpufreq.c
> > index 43530254201a..140a9266b64a 100644
> > --- a/drivers/cpufreq/tegra124-cpufreq.c
> > +++ b/drivers/cpufreq/tegra124-cpufreq.c
> > @@ -118,6 +118,8 @@ static int tegra124_cpufreq_probe(struct platform_d=
evice *pdev)
> >               goto out_put_pllx_clk;
> >       }
> >
> > +     of_node_put(np);
> > +
> >       ret =3D tegra124_cpu_switch_to_dfll(priv);
> >       if (ret)
> >               goto out_put_pllp_clk;
>
> Fixes and stable tags ?
Hi viresh,

Like this=EF=BC=9F

Fixes: 9eb15dbbfa1a2 ("cpufreq: Add cpufreq driver for Tegra124")
Cc: stable@vger.kernel.org

MBR,
Yangtao
>
> --
> viresh
