From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v7 12/14] cpufreq: Add Kryo CPU scaling driver
Date: Wed, 16 May 2018 19:41:32 +0530
Message-ID: <20180516141132.aqjif7d5motmmnlo@vireshk-i7>
References: <1526375616-16904-1-git-send-email-ilialin@codeaurora.org>
 <1526375616-16904-13-git-send-email-ilialin@codeaurora.org>
 <CAHLCerOYq4q2GE+m3MQAbMfxM4azPr95XiLKVtoPVG1Kv2Db=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHLCerOYq4q2GE+m3MQAbMfxM4azPr95XiLKVtoPVG1Kv2Db=A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Ilia Lin <ilialin@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, nm@ti.com, lgirdwood@gmail.com, broonie@kernel.org, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, catalin.marinas@arm.com, will.deacon@arm.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, lakml <linux-arm-kernel@lists.infradead.org>, Rajendra Nayak <rnayak@codeaurora.org>, nicolas.dechesne@linaro.org, celster@codeaurora.org, tfinkel@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On 16-05-18, 16:12, Amit Kucheria wrote:
> > +       ret = PTR_ERR_OR_ZERO(opp_temp =
> > +                             dev_pm_opp_set_supported_hw(cpu_dev,&versions,1));
> > +       if (0 > ret)
> 
> Any particular reason to prefer this over (ret < 0) that is generally
> used? I've seen it used to avoid the == vs. = typos, but not for other
> comparisons.
> 
> Suggest sticking to what is commonly used i.e. ret < 0.
> 
> > +               goto free_opp;
> > +
> > +       cpu_dev = get_cpu_device(GOLD_LEAD);
> 
> Error check cpu_dev here?
> 
> > +       ret = PTR_ERR_OR_ZERO(opp_temp =
> > +                             dev_pm_opp_set_supported_hw(cpu_dev,&versions,1));
> > +       if (0 > ret)
> > +               goto free_opp;

The goto here is wrong

> > +
> > +
> > +       ret = PTR_ERR_OR_ZERO(platform_device_register_simple("cpufreq-dt",
> > +                                                             -1, NULL, 0));
> > +
> > +       if (0 == ret)
> > +               return 0;
> > +
> > +free_opp:
> > +       dev_pm_opp_put_supported_hw(opp_temp);
> 
> This is not needed because dev_pm_opp_set_supported_hw will free
> memory in case of failure. This call in only needed in case of a
> successful get.

But this is still required for the case where platform device
registration fails.

-- 
viresh
