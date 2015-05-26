From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5 2/3] OPP: Allow multiple OPP tables to be passed via DT
Date: Tue, 26 May 2015 10:21:24 +0530
Message-ID: <20150526045124.GH23464@linux>
References: <cover.1432091956.git.viresh.kumar@linaro.org>
 <4690ad854263d6553debab67d65d230105c206ec.1432091956.git.viresh.kumar@linaro.org>
 <555D6E77.3060206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <555D6E77.3060206@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: thomas.petazzoni@free-electrons.com, rob.herring@linaro.org, kesavan.abhilash@gmail.com, linaro-kernel@lists.linaro.org, ta.omasab@gmail.com, khilman@linaro.org, linux-pm@vger.kernel.org, viswanath.puttagunta@linaro.org, sboyd@codeaurora.org, santosh.shilimkar@oracle.com, Rafael Wysocki <rjw@rjwysocki.net>, olof@lixom.net, devicetree@vger.kernel.org, broonie@kernel.org, mike.turquette@linaro.org, Sudeep.Holla@arm.com, grant.likely@linaro.org, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
List-Id: linux-pm@vger.kernel.org

On 21-05-15, 00:34, Nishanth Menon wrote:
> > +	cpu0_opp0: opp0 {
> 
> Maybe we should rename these as cpu0_opp_table_slow opp_table-fast
> 
> > +		compatible = "operating-points-v2";
> > +		opp-name = "opp-slow";
> 
> just name = "slow" ?
> 
> > +		opp-shared;
> > +
> > +		entry00 {
> 
> rename these as opp0, opp01 etc?
> these are the actual OPP description, while, what we call "cpu0_opp0" is
> actually an OPP table choice we have.

What about this now:
+Example 5: Multiple OPP tables
+
+/ {
+       cpus {
+               cpu@0 {
+                       compatible = "arm,cortex-a7";
+                       ...
+
+                       opp-supply = <&cpu_supply>
+                       operating-points-v2 = <&cpu0_opp_table_slow>, <&cpu0_opp_table_fast>;
+               };
+       };
+
+       cpu0_opp_table_slow: opp_table_slow {
+               compatible = "operating-points-v2";
+               opp-name = "slow";
+               opp-shared;
+
+               opp00 {
+                       opp-hz = <600000000>;
+                       ...
+               };
+
+               opp01 {
+                       opp-hz = <800000000>;
+                       ...
+               };
+       };
+
+       cpu0_opp_table_fast: opp_table_fast {
+               compatible = "operating-points-v2";
+               opp-name = "fast";
+               opp-shared;
+
+               opp10 {
+                       opp-hz = <1000000000>;
+                       ...
+               };
+
+               opp11 {
+                       opp-hz = <1100000000>;
+                       ...
+               };
+       };
+};

May I carry your Ack or you want to give it again?

-- 
viresh
