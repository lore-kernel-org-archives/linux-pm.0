From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 6/6] PM / Domains: Propagate performance state updates
Date: Fri, 14 Dec 2018 12:03:21 +0530
Message-ID: <20181214063321.5i2hqoufw7jc3a2i@vireshk-i7>
References: <cover.1544611890.git.viresh.kumar@linaro.org>
 <d138bd45d0eacc11ff90e27f83d8b47d692877ef.1544611890.git.viresh.kumar@linaro.org>
 <CAPDyKFpFn60O7W71v7b3fsCtmS520=GG0AQhs3GpdarVE+W--A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpFn60O7W71v7b3fsCtmS520=GG0AQhs3GpdarVE+W--A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, Rajendra Nayak <rnayak@codeaurora.org>, Niklas Cassel <niklas.cassel@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 13-12-18, 16:53, Ulf Hansson wrote:
> On Wed, 12 Dec 2018 at 11:58, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >  update_state:
> > -       return _genpd_set_performance_state(genpd, state);
> > +       return _genpd_set_performance_state(genpd, state, depth);
> 
> Instead of calling _genpd_set_performance_state() from here, I suggest
> to let the caller do it. Simply return the aggregated new state, if it
> needs to be updated - and zero if no update is needed.
> 
> Why? I think it may clarify and simplify the code, in regards to the
> actual set/propagation of state changes. Another side-effect, is that
> you should be able to avoid the forward declaration of
> _genpd_reeval_performance_state(), which I think is nice as well.

_genpd_reeval_performance_state() is currently called from 3 different
places and with the suggested change those sites will have this diff.

-               ret = _genpd_reeval_performance_state(master, master_state,
-                                                     depth + 1);
+               master_state = _genpd_reeval_performance_state(master,
+                                               master_state);
+               ret = _genpd_set_performance_state(genpd, master_state, depth);

To be honest, I don't like it. Probably because I don't find the extra
declaration of _genpd_reeval_performance_state() that bad. If two
routines are always going to get called together it is worth calling
the second one from the first one for me.

But anyway, I am fine with it if you are. Please let me know.

> >  }
> >
> >  /**
> > @@ -332,7 +407,7 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
> >         prev = gpd_data->performance_state;
> >         gpd_data->performance_state = state;
> >
> > -       ret = _genpd_reeval_performance_state(genpd, state);
> > +       ret = _genpd_reeval_performance_state(genpd, state, 0);
> >         if (ret)
> >                 gpd_data->performance_state = prev;
> >
> > diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> > index 9ad101362aef..dd364abb649a 100644
> > --- a/include/linux/pm_domain.h
> > +++ b/include/linux/pm_domain.h
> > @@ -136,6 +136,10 @@ struct gpd_link {
> >         struct list_head master_node;
> >         struct generic_pm_domain *slave;
> >         struct list_head slave_node;
> > +
> > +       /* Sub-domain's per-master domain performance state */
> > +       unsigned int performance_state;
> > +       unsigned int prev_performance_state;
> 
> Probably a leftover from the earlier versions, please remove.

No, these are still getting used.

-- 
viresh
