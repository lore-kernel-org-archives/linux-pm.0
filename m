From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v3 1/2] PM / OPP: introduce an OPP power estimation helper
Date: Mon, 22 Jan 2018 10:00:26 +0000
Message-ID: <20180122100026.GC16453@e108498-lin.cambridge.arm.com>
References: <20180119094549.5468-1-quentin.perret@arm.com>
 <20180119094549.5468-2-quentin.perret@arm.com>
 <CAJWu+opFktdGqGMxjAr6Fudt90Ecqe2KEZ76wS8wFZ07P071Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750925AbeAVKAa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Jan 2018 05:00:30 -0500
Content-Disposition: inline
In-Reply-To: <CAJWu+opFktdGqGMxjAr6Fudt90Ecqe2KEZ76wS8wFZ07P071Sg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, matthias.bgg@gmail.com, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, Todd Kjos <tkjos@google.com>

On Friday 19 Jan 2018 at 15:36:42 (-0800), Joel Fernandes wrote:
> > +/**
> > + * Estimate the power of an OPP as P = C * V^2 * f, with C the device's
> > + * capacitance, V the OPP's voltage and f the OPP's frequency.
> > + */
> > +static void _opp_estimate_power(struct dev_pm_opp *opp, unsigned long cap)
> > +{
> > +       unsigned long mV = opp->supplies[0].u_volt / 1000;
> > +       unsigned long KHz = opp->rate / 1000;
> > +
> > +       opp->power_estimate_uw = cap * mV * mV * KHz / 1000000000;
> > +}
> > +
> >  /*
> >   * Returns:
> >   * 0: On success. And appropriate error message for duplicate OPPs.
> > @@ -1039,6 +1069,8 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
> >         if (opp_table->get_pstate)
> >                 new_opp->pstate = opp_table->get_pstate(dev, new_opp->rate);
> >
> > +       _opp_estimate_power(new_opp, opp_table->capacitance);
> > +
> 
> Does this need to be a separate static function? There's only one user
> of the function in the C file and it adds more LOC.

True, but I guess that makes sense conceptually to factor out this
feature. Maybe it's just my personal taste :)

> 
> Otherwise, feel free to add FWIW:
> Reviewed-by: Joel Fernandes <joelaf@google.com>

Cool, thank you very much !

Quentin
