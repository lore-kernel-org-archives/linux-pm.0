From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 1/9] PM / OPP: Reword binding supporting multiple
 regulators per device
Date: Thu, 10 Nov 2016 23:39:40 +0530
Message-ID: <20161110180940.GD11670@vireshk-i7>
References: <cover.1477463128.git.viresh.kumar@linaro.org>
 <28119b44689921f3c3cc00be49bff2bb99b32162.1477463128.git.viresh.kumar@linaro.org>
 <20161109145828.p6vvsd5bygkzjcmh@sirena.org.uk>
 <20161110040440.GA11670@vireshk-i7>
 <20161110163659.rk67qrmnrovq2ktf@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161110163659.rk67qrmnrovq2ktf@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, Viresh Kumar <vireshk@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10-11-16, 16:36, Mark Brown wrote:
> On Thu, Nov 10, 2016 at 09:34:40AM +0530, Viresh Kumar wrote:
> > On 09-11-16, 14:58, Mark Brown wrote:
> > > On Wed, Oct 26, 2016 at 12:02:56PM +0530, Viresh Kumar wrote:
> 
> > > > +  Entries for multiple regulators shall be provided in the same field separated
> > > > +  by angular brackets <>. The OPP binding doesn't provide any provisions to
> > > > +  relate the values to their power supplies or the order in which the supplies
> > > > +  need to be configured.
> 
> > > I don't understand how this works.  If we have an unordered list of
> > > values to set for regulators how will we make sense of them?
> 
> > The platform driver is responsible to identify the order and pass it on to the
> > OPP core. And the platform driver needs to have that hard coded.
> 
> That *really* should be in the binding.

Okay, how do you suggest doing that? Will a property like supply-names
in the OPP table be fine? Like this:

@@ -369,13 +378,16 @@ Example 4: Handling multiple regulators
                        compatible = "arm,cortex-a7";
                        ...
 
-                       cpu-supply = <&cpu_supply0>, <&cpu_supply1>, <&cpu_supply2>;
+                       vcc0-supply = <&cpu_supply0>;
+                       vcc1-supply = <&cpu_supply1>;
+                       vcc2-supply = <&cpu_supply2>;
                        operating-points-v2 = <&cpu0_opp_table>;
                };
        };
 
        cpu0_opp_table: opp_table0 {
                compatible = "operating-points-v2";
+               supply-names = "vcc0", "vcc1", "vcc2";
                opp-shared;

-- 
viresh
