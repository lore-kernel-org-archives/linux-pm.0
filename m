From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: opp: Introduce bandwidth-MBps
 bindings
Date: Wed, 24 Apr 2019 14:35:06 +0530
Message-ID: <20190424090506.jdwhf4ndzr2m5ea7@vireshk-i7>
References: <20190423132823.7915-1-georgi.djakov@linaro.org>
 <20190423132823.7915-2-georgi.djakov@linaro.org>
 <e35223d0-80ac-5236-2b8d-7f46cd3a1581@codeaurora.org>
 <20190424064942.v5g6jr5l3xy5z3xv@vireshk-i7>
 <dd6f055c-e7df-13e8-72aa-2973d3c664d0@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <dd6f055c-e7df-13e8-72aa-2973d3c664d0@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sibi Sankar <sibis@codeaurora.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Georgi Djakov <georgi.djakov@linaro.org>, vireshk@kernel.org, sboyd@kernel.org, nm@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net, jcrouse@codeaurora.org, vincent.guittot@linaro.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 24-04-19, 14:30, Sibi Sankar wrote:
> Hey Viresh,
> 
> On 4/24/19 12:19 PM, Viresh Kumar wrote:
> > On 24-04-19, 12:16, Rajendra Nayak wrote:
> > > 
> > > 
> > > On 4/23/2019 6:58 PM, Georgi Djakov wrote:
> > > > In addition to frequency and voltage, some devices may have bandwidth
> > > > requirements for their interconnect throughput - for example a CPU
> > > > or GPU may also need to increase or decrease their bandwidth to DDR
> > > > memory based on the current operating performance point.
> > > > 
> > > > Extend the OPP tables with additional property to describe the bandwidth
> > > > needs of a device. The average and peak bandwidth values depend on the
> > > > hardware and its properties.
> > > > 
> > > > Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> > > > ---
> > > >    Documentation/devicetree/bindings/opp/opp.txt | 38 +++++++++++++++++++
> > > >    .../devicetree/bindings/property-units.txt    |  4 ++
> > > >    2 files changed, 42 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> > > > index 76b6c79604a5..830f0206aea7 100644
> > > > --- a/Documentation/devicetree/bindings/opp/opp.txt
> > > > +++ b/Documentation/devicetree/bindings/opp/opp.txt
> > > > @@ -132,6 +132,9 @@ Optional properties:
> > > >    - opp-level: A value representing the performance level of the device,
> > > >      expressed as a 32-bit integer.
> > > > +- bandwidth-MBps: The interconnect bandwidth is specified with an array containing
> > > > +  the two integer values for average and peak bandwidth in megabytes per second.
> > > > +
> > > >    - clock-latency-ns: Specifies the maximum possible transition latency (in
> > > >      nanoseconds) for switching to this OPP from any other OPP.
> > > > @@ -546,3 +549,38 @@ Example 6: opp-microvolt-<name>, opp-microamp-<name>:
> > > >    		};
> > > >    	};
> > > >    };
> > > > +
> > > > +Example 7: bandwidth-MBps:
> > > > +Average and peak bandwidth values for the interconnects between CPU and DDR
> > > > +memory and also between CPU and L3 are defined per each OPP. Bandwidth of both
> > > > +interconnects is scaled together with CPU frequency.
> > > > +
> > > > +/ {
> > > > +	cpus {
> > > > +		CPU0: cpu@0 {
> > > > +			compatible = "arm,cortex-a53", "arm,armv8";
> > > > +			...
> > > > +			operating-points-v2 = <&cpu_opp_table>;
> > > > +			/* path between CPU and DDR memory and CPU and L3 */
> > > > +			interconnects = <&noc MASTER_CPU &noc SLAVE_DDR>,
> > > > +					<&noc MASTER_CPU &noc SLAVE_L3>;
> > > > +		};
> > > > +	};
> > > > +
> > > > +	cpu_opp_table: cpu_opp_table {
> > > > +		compatible = "operating-points-v2";
> > > > +		opp-shared;
> > > > +
> > > > +		opp-200000000 {
> > > > +			opp-hz = /bits/ 64 <200000000>;
> > > > +			/* CPU<->DDR bandwidth: 457 MB/s average, 1525 MB/s peak */
> > > > +			 * CPU<->L3 bandwidth: 914 MB/s average, 3050 MB/s peak */
> > > > +			bandwidth-MBps = <457 1525>, <914 3050>;
> > > 
> > > Should this also have a bandwidth-MBps-name perhaps? Without that I guess we assume
> > > the order in which we specify the interconnects is the same as the order here?
> > 
> > Right, so I suggested not to add the -name property and to rely on the
> > order. Though I missed that he hasn't mentioned the order thing here.
> 
> by skipping names, aren't we forced to specify all the specified paths
> bandwidths for each opp even if it is redundant? i.e if the first/second
> icc path doesn't have to change across a few opps but if the other path
> does need to change this scheme would force it to be included and will
> try to set the first/second path again.
> 
> 
> e.g: Here the first path does not have to change across these two opps
> but have to specified nonetheless since we omit names.

The code should be efficient enough to return early in this case, but
these value must always be present. We can get some sort of
relationship between multiple paths that are part of same OPP, but not
between different OPPs.

> +		opp-1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			bandwidth-MBps = <457 1525>, <914 3050>;
> +		};
> +		opp-1400000000 {
> +			opp-hz = /bits/ 64 <1400000000>;
> +			bandwidth-MBps = <457 1525>, <1828 6102>;
> +		};
> 

-- 
viresh
