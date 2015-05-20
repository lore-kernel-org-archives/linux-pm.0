From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Wed, 20 May 2015 07:37:15 +0530
Message-ID: <20150520020715.GA6465@linux>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <555BDA7C.7020506@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33686 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbbETCHU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2015 22:07:20 -0400
Received: by pdbqa5 with SMTP id qa5so49290630pdb.0
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2015 19:07:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <555BDA7C.7020506@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mike.turquette@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 19-05-15, 17:51, Stephen Boyd wrote:
> This looks like it covers my usecases. I'm not sure if I'm going to put
> all of this data in DT because of the philosophical question regarding
> what should be in DT and the technical decisions that some platforms I'm
> working on have made to encode parts of the OPPs in fuses, but at least
> the binding looks to support all the scenarios I have today.

Thanks.

> > +Required properties:
> > +- opp-khz: Frequency in kHz
> 
> Can this be in Hz? I thought there were some problems with kHz and Hz
> before where we wanted to make this into Hz so that rounding problems
> don't arise?

Yeah, good point.

> Also I wonder if all properties should be optional? I don't have this
> scenario today, but perhaps the frequencies could be encoded in fuses,
> but the voltages wouldn't be and so we might want to read out the
> frequencies for a fixed set of voltages. Of course, if there's nothing
> in the OPP node at all, it's not very useful, so perhaps some statement
> that at least one of the frequency/voltage/amperage properties should be
> present.

I am not sure. What we are trying to do (fill partially in DT and
partially in platform), is a trick and not the right use of bindings.

Ideally whatever is passed in DT should be complete by itself and
doesn't require platform to tweak it (which it can't). For example,
the cpufreq-dt driver will try to initialize OPPs from the DT directly
and wouldn't know about the platform tweaks. That can work eventually
as platform will add OPPs for the same bindings before cpufreq driver
will try to do, but that's a trick.

And then its all about frequency in the first place, and so marking
that optional looks wrong. Probably not the right use of these
bindings.

> > +  Entries for multiple regulators must be present in the same order as
> > +  regulators are specified in device's DT node. If few regulators don't provide
> > +  capability to configure current, then values for then should be marked as
> 
> s/then/them/

Thanks. But this part is already re-written and doesn't have this
issue anymore.

> Please put some space between properties so they can be found quickly:

Sure, thanks.

-- 
viresh
