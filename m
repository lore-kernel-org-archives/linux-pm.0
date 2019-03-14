From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] clk: mvebu: armada-37xx-periph: Fix initialization for
 cpu clocks
Date: Thu, 14 Mar 2019 16:15:29 +0200
Message-ID: <20190314141529.GA5576@apalos>
References: <20190313163558.6705-1-gregory.clement@bootlin.com>
 <20190314121541.GB19385@apalos>
 <CAC5LXJcCs4nr-qFOWzUJpUBAJ9ngG-cgeTCVCFBKFc1SPzHMuQ@mail.gmail.com>
 <20190314134428.GA24768@apalos>
 <CAC5LXJf=f2bZLroSXFkGiF2W=1XzAgb_wwtpvZY7O9xv28wbVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAC5LXJf=f2bZLroSXFkGiF2W=1XzAgb_wwtpvZY7O9xv28wbVA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Neubert <christian.neubert.86@gmail.com>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>, Stephen Boyd <sboyd@codeaurora.org>, Mike Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@bootlin.com>, =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,
> Hi,
> 
> the cpu frequency scaling never worked right (only on the 4.4 kernel from
> marvell). If you use the 1000 MHz firmware you are running with just 800
> MHz (this is the case on my board with a current firmware).
>
> Just have a look what the kernel thinks it is running at (frequency).
Ok, probably my bad here. By 'worked fine' i mean that this didn't lead to any 
freezes or panics. I know the actual frequency wasn't set properly

Regards
/Ilias
> 
> Regards,
> Christian
> 
> Ilias Apalodimas <ilias.apalodimas@linaro.org> schrieb am Do., 14. März
> 2019, 14:44:
> 
> > Hello Christian,
> > > Hi,
> > >
> > > I assume you use the 1000 MHz firmware. This does also not work on my
> > Rev 7
> > > board. But I'm pretty sure this is not a problem of the patches, because
> > if
> > > I take a newer kernel (4.19.20/27) without the patches it also does not
> > > work. A kernel 4.19.17 does work for me. My opinion on that is that this
> > is
> > > another problem which does just occure now because now the cpu frequency
> > > scaling is working with the right frequencies.
> > I am not sure which firmware i am running, i did all my tests on 5.0.0 and
> > changing between governors worked fine without the patches
> >
> > Regards
> > /Ilias
> > >
> > > Ilias Apalodimas <ilias.apalodimas@linaro.org> schrieb am Do., 14. März
> > > 2019, 13:15:
> > >
> > > > Hi Gregory,
> > > > > The clock parenting was not setup properly when DVFS was enabled. It
> > was
> > > > > expected that the same clock source was used with and without DVFS
> > which
> > > > > was not the case.
> > > > >
> > > > > This patch fixes this issue, allowing to make the cpufreq support
> > work
> > > > > when the CPU clocks source are not the default ones.
> > > > >
> > > > > Fixes: 92ce45fb875d ("cpufreq: Add DVFS support for Armada 37xx")
> > > > > Cc: <stable@vger.kernel.org>
> > > > > Reported-by: Christian Neubert <christian.neubert.86@gmail.com>
> > > > > Reported-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> > > > > ---
> > > > >  drivers/clk/mvebu/armada-37xx-periph.c | 11 +++++++++++
> > > > >  1 file changed, 11 insertions(+)
> > > > >
> > > > > diff --git a/drivers/clk/mvebu/armada-37xx-periph.c
> > > > b/drivers/clk/mvebu/armada-37xx-periph.c
> > > > > index 1f1cff428d78..26ed3c18a239 100644
> > > > > --- a/drivers/clk/mvebu/armada-37xx-periph.c
> > > > > +++ b/drivers/clk/mvebu/armada-37xx-periph.c
> > > > > @@ -671,6 +671,17 @@ static int armada_3700_add_composite_clk(const
> > > > struct clk_periph_data *data,
> > > > >               map = syscon_regmap_lookup_by_compatible(
> > > > >                               "marvell,armada-3700-nb-pm");
> > > > >               pmcpu_clk->nb_pm_base = map;
> > > > > +
> > > > > +             /*
> > > > > +              * Use the same parent when DVFS is enabled that the
> > > > > +              * default parent received at boot time. When this
> > > > > +              * function is called, DVFS is not enabled yet, so we
> > > > > +              * get the default parent and we can set the parent
> > > > > +              * for DVFS.
> > > > > +              */
> > > > > +             if (clk_pm_cpu_set_parent(muxrate_hw,
> > > > > +
> > > >  clk_pm_cpu_get_parent(muxrate_hw)))
> > > > > +                     dev_warn(dev, "Failed to setup default parent
> > > > clock for DVFS\n");
> > > > >       }
> > > > >
> > > > >       *hw = clk_hw_register_composite(dev, data->name,
> > > > data->parent_names,
> > > > > --
> > > > > 2.20.1
> > > > >
> > > > Applied this and selected only
> > > >
> > > > CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> > > > CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> > > > CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> > > >
> > > > After changing the governor from 'powersave' to 'performance' the board
> > > > completely froze (i even lost access to the serial port)
> > > >
> > > > Cheers
> > > > /Ilias
> > > >
> >
