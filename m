From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: 'UNKNOWN' status of opp-table->shared
Date: Thu, 16 Jun 2016 18:18:18 +0530
Message-ID: <20160616124818.GN5726@vireshk-i7>
References: <87bd097db7b673b1f75ca2086dfa76f4dfbf7f8c.1466058619.git.viresh.kumar@linaro.org>
 <CAJZ5v0gqbU8bc0k8ZHare6Tv4Nno5o4pYQwwzTP6Ha1xS3WDOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gqbU8bc0k8ZHare6Tv4Nno5o4pYQwwzTP6Ha1xS3WDOg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, acourbot@nvidia.com, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 16-06-16, 14:25, Rafael J. Wysocki wrote:
> On Thu, Jun 16, 2016 at 8:33 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > +                       if (opp_table->shared_opp == OPP_TABLE_IS_SHARED)
> > +                               return opp_table;
> > +
> > +                       return NULL;
> 
> That still can be
> 
> return opp_table->shared_opp == OPP_TABLE_IS_SHARED ? opp_table : NULL;
> 
> >                 }
> >         }
> >

> > +       if (of_property_read_bool(opp_np, "opp-shared"))
> > +               opp_table->shared_opp = OPP_TABLE_IS_SHARED;
> > +       else
> > +               opp_table->shared_opp = OPP_TABLE_IS_NOT_SHARED;
> 
> And here
> 
> opp_table->shared_opp = of_property_read_bool(opp_np, "opp-shared") ?
>                                             OPP_TABLE_IS_SHARED :
> OPP_TABLE_IS_NOT_SHARED;

Conditional statement for both these cases is getting very long and
if/else looks much more readable. And so I would like to stick with
that, if you allow.

> > +#define OPP_TABLE_IS_NOT_SHARED                0
> > +#define OPP_TABLE_IS_SHARED            1
> > +#define OPP_TABLE_SHARED_UNKNOWN       UINT_MAX
> 

> Please change this into an enum type.
 
> Besides, I'd call them OPP_TABLE_ACCESS_SHARED,
> OPP_TABLE_ACCESS_EXCLUSIVE, OPP_TABLE_ACCESS_UNKNOWN or similar, but I
> don't care that much either.

Sure. This can be done.

-- 
viresh
