From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 02/16] PM / OPP: Add 'opp-microvolt-triplets' binding
Date: Tue, 15 Sep 2015 09:00:27 +0530
Message-ID: <20150915033027.GJ32551@linux>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
 <254dd353453a495bb0921fa23e430428484f36fa.1441972771.git.viresh.kumar@linaro.org>
 <55F72E65.6000205@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33989 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766AbbIODad (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2015 23:30:33 -0400
Received: by padhy16 with SMTP id hy16so162414326pad.1
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2015 20:30:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55F72E65.6000205@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, lee.jones@linaro.org, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, open list <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[+Cc Mark, I thought I cc'd him earlier, but no, I cc'd him only for
the first patch]

On 14-09-15, 15:30, Rob Herring wrote:
> On 09/11/2015 07:01 AM, Viresh Kumar wrote:
> > If 'opp-microvolt' is used to specify values for multiple regulators,
> > then we need this additional information to know if the values passed
> > should be treated as <target> or <target min max>.
> 
> Can't you determine this implicitly from # of cells / # of regulators
> being either 1 or 3?

I thought the #<name>-cells property is used to pass arguments along with the
phandle, so something like this:

supply0: regulator@f8000000 {
        regulator-cells = 1;
        ...
}

cpu@1 {
        cpu-supply = <&supply0 XYZ>
}

But if we can define something like:

supply0: regulator@f8000000 {
        regulator-cells or microvolt-cells = 1 or 3;
        ...
}

And then do:

cpu@1 {
        cpu-supply = <&supply0>
        operating-points-v2 = "&opp-table";
}

opp-table: table {

        ...

        opp0 {
                opp-hz = ...;
                ...
                opp-microvolt = <one or three values here>
        }
}

then it will be very simple. Also, this would mean that with multiple
regulators, we can have one regulator supporting single microvolts
value and other supporting tar/min/max values..

> > 
> > This is because, DT doesn't differentiate between these two styles:
> > 
> > prop = <x>, <y>, <z>;
> > prop = <x y z>;
> > 
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/opp/opp.txt | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> > index 8759bc4783ed..719603b87353 100644
> > --- a/Documentation/devicetree/bindings/opp/opp.txt
> > +++ b/Documentation/devicetree/bindings/opp/opp.txt
> > @@ -76,6 +76,16 @@ This describes the OPPs belonging to a device. This node can have following
> >    present here is important, as that should match the order in which values are
> >    present in 'opp-microvolt' and 'opp-microamp' properties.
> >  
> > +- opp-microvolt-triplets: This is a required property, only if multiple supplies
> > +  are available for the device. Otherwise it is ignored.
> > +
> > +  'opp-microvolt' can be present in two forms: <target> or <target min max>, per
> > +  power-supply. 'opp-microvolt-triplets' property is used to find the form in
> > +  which 'opp-microvolt' is present.
> > +
> > +  If present, then 'opp-microvolt' must be present in <target min max> form,
> > +  else in <target> form.
> 
> This implies that bindings currently with triplets are wrong since they
> will be missing opp-microvolt-triplets.

Yeah, the bindings are incomplete, but there are no users yet, which
need the triplet thing. So, its all working just fine.

-- 
viresh
