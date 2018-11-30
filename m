From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 3/5] PM / Domains: Save OPP table pointer in genpd
Date: Fri, 30 Nov 2018 14:35:21 +0530
Message-ID: <20181130090521.etwm56dcvfgk5qkl@vireshk-i7>
References: <cover.1543219386.git.viresh.kumar@linaro.org>
 <f95b514f7b3b3ab6ac00c9871e91513c9c3a09a3.1543219386.git.viresh.kumar@linaro.org>
 <CAPDyKFrUBwagtfwCezqw2ujPBVVtQNqz4rKgAG0Yyy18FZv+wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFrUBwagtfwCezqw2ujPBVVtQNqz4rKgAG0Yyy18FZv+wA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Niklas Cassel <niklas.cassel@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 30-11-18, 09:53, Ulf Hansson wrote:
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 8e554e6a82a2..0d928359b880 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -1907,12 +1907,21 @@ int of_genpd_add_provider_simple(struct device_node *np,
> >                                 ret);
> >                         goto unlock;
> >                 }
> > +
> > +               /*
> > +                * Save table for faster processing while setting performance
> > +                * state.
> > +                */
> > +               genpd->opp_table = dev_pm_opp_get_opp_table(&genpd->dev);
> > +               WARN_ON(!genpd->opp_table);
> 
> The WARN_ON seems lazy. Why not implement a proper error path?

We just added the table before this call and so we should get the table no
matter what. Initially I wanted to add a BUG_ON() but then I relaxed it a bit :)

There is no point of error path here as that will never run.

-- 
viresh
