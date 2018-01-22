From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v3 1/2] PM / OPP: introduce an OPP power estimation helper
Date: Mon, 22 Jan 2018 09:56:54 +0000
Message-ID: <20180122095654.GB16453@e108498-lin.cambridge.arm.com>
References: <20180119094549.5468-1-quentin.perret@arm.com>
 <20180119094549.5468-2-quentin.perret@arm.com>
 <CAJWu+orBCzCxre8adtjP6r8Hh=DQRfwzANU9_sA4SL3SWiiZpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56044 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750928AbeAVJ47 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Jan 2018 04:56:59 -0500
Content-Disposition: inline
In-Reply-To: <CAJWu+orBCzCxre8adtjP6r8Hh=DQRfwzANU9_sA4SL3SWiiZpw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, matthias.bgg@gmail.com, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, Todd Kjos <tkjos@google.com>

Hi Joel,

Thanks for the feedback !

On Friday 19 Jan 2018 at 20:10:46 (-0800), Joel Fernandes wrote:
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
> 
> Also, here you can do the multiples first and then the divides to get
> better accuracy with lesser rounding.

Yeah that's what I wanted to do in the first place but there is a risk
that an intermediate result won't fit in 64 bits ... If you take the
example of the highest OPP on the big cluster of the Hikey 960, the
parameters are the following:
 - uV = 1500000
 - Hz = 2362000000
 - C =  550

In this case, P = C * uV^2 * Hz ~ 2.9230e+24 which doesn't fit in 64
bits ...
