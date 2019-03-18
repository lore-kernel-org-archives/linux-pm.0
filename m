From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] clk: mvebu: armada-37xx-periph: Fix initialization for
 cpu clocks
Date: Mon, 18 Mar 2019 13:28:44 +0200
Message-ID: <20190318112844.GA1708@apalos>
References: <20190313163558.6705-1-gregory.clement@bootlin.com>
 <20190314121541.GB19385@apalos>
 <CAC5LXJcCs4nr-qFOWzUJpUBAJ9ngG-cgeTCVCFBKFc1SPzHMuQ@mail.gmail.com>
 <20190314134428.GA24768@apalos>
 <874l85v8p6.fsf@FE-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <874l85v8p6.fsf@FE-laptop>
Sender: stable-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Christian Neubert <christian.neubert.86@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, Mike Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@bootlin.com>, =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Gregory, 
> Hi Ilias,
>  
>  On jeu., mars 14 2019, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> 
> > Hello Christian,
> >> Hi,
> >> 
> >> I assume you use the 1000 MHz firmware. This does also not work on my Rev 7
> >> board. But I'm pretty sure this is not a problem of the patches, because if
> >> I take a newer kernel (4.19.20/27) without the patches it also does not
> >> work. A kernel 4.19.17 does work for me. My opinion on that is that this is
> >> another problem which does just occure now because now the cpu frequency
> >> scaling is working with the right frequencies.
> > I am not sure which firmware i am running, i did all my tests on 5.0.0 and
> > changing between governors worked fine without the patches
> 
> Curently my espressobin is broken so I tested the patches on the Armada
> 3700 DB and I didn't observe the issue you had.
> 
> The 3700 DB I used is configured to run at 800MHz.
> 
> Could you apply the following patch and sent me the boot log?
> 
> diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
> index 26ed3c18a239..f814ade5cd80 100644
> --- a/drivers/clk/mvebu/armada-37xx-periph.c
> +++ b/drivers/clk/mvebu/armada-37xx-periph.c
> @@ -452,14 +452,17 @@ static int clk_pm_cpu_set_parent(struct clk_hw *hw, u8 index)
>  
>         /* Set the parent clock for all the load level */
>         for (load_level = 0; load_level < LOAD_LEVEL_NR; load_level++) {
> -               unsigned int reg, mask,  val,
> +               unsigned int reg, mask,  val, old,
>                         offset = ARMADA_37XX_NB_TBG_SEL_OFF;
>  
>                 armada_3700_pm_dvfs_update_regs(load_level, &reg, &offset);
>  
>                 val = index << offset;
>                 mask = ARMADA_37XX_NB_TBG_SEL_MASK << offset;
> +               regmap_read(base, reg, &old);
>                 regmap_update_bits(base, reg, mask, val);
> +               pr_err("%s old=%X -> val=0x%X load_level=%d\n",
> +                      __func__, old,  val, load_level);
>         }
>         return 0;
>  }
> 
> 
> 
[   14.909524] clk_pm_cpu_set_parent old=28004840 -> val=0x6000000 load_level=0
[   14.916424] clk_pm_cpu_set_parent old=2E004840 -> val=0x600 load_level=1
[   14.923315] clk_pm_cpu_set_parent old=8880A8C0 -> val=0x6000000 load_level=2
[   14.930572] clk_pm_cpu_set_parent old=8E80A8C0 -> val=0x600 load_level=3


Let me know if you need anything else

Regards
/Ilias
