From: Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH v3 1/2] PM / OPP: introduce an OPP power estimation helper
Date: Mon, 22 Jan 2018 13:33:28 -0800
Message-ID: <CAJWu+ootSZHK-KPa=Ktb+6RzFCwOqMER4TxxzT8Ts+dnVxruGg@mail.gmail.com>
References: <20180119094549.5468-1-quentin.perret@arm.com> <20180119094549.5468-2-quentin.perret@arm.com>
 <CAJWu+orBCzCxre8adtjP6r8Hh=DQRfwzANU9_sA4SL3SWiiZpw@mail.gmail.com> <20180122095654.GB16453@e108498-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:43132 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750892AbeAVVda (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jan 2018 16:33:30 -0500
Received: by mail-it0-f48.google.com with SMTP id u62so11576481ita.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2018 13:33:30 -0800 (PST)
In-Reply-To: <20180122095654.GB16453@e108498-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, Amit Kachhap <amit.kachhap@gmail.com>, javi.merino@kernel.org, rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, Todd Kjos <tkjos@google.com>

On Mon, Jan 22, 2018 at 1:56 AM, Quentin Perret <quentin.perret@arm.com> wrote:
> Hi Joel,
>
> Thanks for the feedback !
>
> On Friday 19 Jan 2018 at 20:10:46 (-0800), Joel Fernandes wrote:
>> > +/**
>> > + * Estimate the power of an OPP as P = C * V^2 * f, with C the device's
>> > + * capacitance, V the OPP's voltage and f the OPP's frequency.
>> > + */
>> > +static void _opp_estimate_power(struct dev_pm_opp *opp, unsigned long cap)
>> > +{
>> > +       unsigned long mV = opp->supplies[0].u_volt / 1000;
>> > +       unsigned long KHz = opp->rate / 1000;
>> > +
>> > +       opp->power_estimate_uw = cap * mV * mV * KHz / 1000000000;
>>
>> Also, here you can do the multiples first and then the divides to get
>> better accuracy with lesser rounding.
>
> Yeah that's what I wanted to do in the first place but there is a risk
> that an intermediate result won't fit in 64 bits ... If you take the
> example of the highest OPP on the big cluster of the Hikey 960, the
> parameters are the following:
>  - uV = 1500000
>  - Hz = 2362000000
>  - C =  550
>
> In this case, P = C * uV^2 * Hz ~ 2.9230e+24 which doesn't fit in 64
> bits ...

True, if these numbers are typical it looks like there isn't any loss
of accuracy so it looks like it should be fine anyway. Thanks for
indulging.

- Joel
