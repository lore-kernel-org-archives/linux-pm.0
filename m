From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 1/9] PM / OPP: Reword binding supporting multiple
 regulators per device
Date: Thu, 10 Nov 2016 09:34:40 +0530
Message-ID: <20161110040440.GA11670@vireshk-i7>
References: <cover.1477463128.git.viresh.kumar@linaro.org>
 <28119b44689921f3c3cc00be49bff2bb99b32162.1477463128.git.viresh.kumar@linaro.org>
 <20161109145828.p6vvsd5bygkzjcmh@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35972 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752558AbcKJEEp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Nov 2016 23:04:45 -0500
Received: by mail-pf0-f174.google.com with SMTP id 189so138729877pfz.3
        for <linux-pm@vger.kernel.org>; Wed, 09 Nov 2016 20:04:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161109145828.p6vvsd5bygkzjcmh@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, Viresh Kumar <vireshk@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, devicetree@vger.kernel.org

On 09-11-16, 14:58, Mark Brown wrote:
> On Wed, Oct 26, 2016 at 12:02:56PM +0530, Viresh Kumar wrote:
> 
> > +  Entries for multiple regulators shall be provided in the same field separated
> > +  by angular brackets <>. The OPP binding doesn't provide any provisions to
> > +  relate the values to their power supplies or the order in which the supplies
> > +  need to be configured.
> 
> I don't understand how this works.  If we have an unordered list of
> values to set for regulators how will we make sense of them?

The platform driver is responsible to identify the order and pass it on to the
OPP core. And the platform driver needs to have that hard coded.

If we want to identify the entries for regulators just by parsing the DT then we
would need another field in the OPP table which I added earlier.

Something like this:

        cpu0_opp_table: opp_table0 {
                compatible = "operating-points-v2";
+               supply-names = "vcc0", "vcc1", "vcc2";
                opp-shared;
 
                opp00 {

Will that be acceptable ?

> > -			cpu-supply = <&cpu_supply0>, <&cpu_supply1>, <&cpu_supply2>;
> > +			vcc0-supply = <&cpu_supply0>;
> > +			vcc1-supply = <&cpu_supply1>;
> > +			vcc2-supply = <&cpu_supply2>;
> 
> This change doesn't seem to correspond to the documentation change.

This rectifies the incorrect binding previously added to the example, which I
realized to be incorrect only while attempting to code for it. And so it brings
the example on the same state as the documentation now.

-- 
viresh
