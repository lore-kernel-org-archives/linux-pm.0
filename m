From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC V7 2/2] OPP: Allow "opp-hz" and "opp-microvolt" to contain
 magic values
Date: Thu, 30 Nov 2017 12:29:07 +0530
Message-ID: <20171130065907.GI11413@vireshk-i7>
References: <23ba51eaa6b52117458165dccc00a95cf8e86e1d.1509453284.git.viresh.kumar@linaro.org>
 <CAL_JsqKr7MsM6iZ_QYO=iCzXNwANEGQGDLFUEwe0Z-p2Z_aMYw@mail.gmail.com>
 <CAKohpokvQD4Z6YY6MRG8c+hnsS=Z52X4XhyTgC5FTgf7VuaNmw@mail.gmail.com>
 <CAL_JsqK-qtAaM_Ou5NtxcWR3F_q=8rMPJUm-VqGtKhbtWe5SAQ@mail.gmail.com>
 <20171101214333.GG30645@codeaurora.org>
 <20171102045155.GX4240@vireshk-i7>
 <20171102071533.GM30645@codeaurora.org>
 <20171102090033.GZ4240@vireshk-i7>
 <CAPDyKFryn5=GMs+hiRcxGOC1U=-LL9RQdnY3cWniyE+4pwQDog@mail.gmail.com>
 <20171130005029.GC19419@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171130005029.GC19419-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 29-11-17, 16:50, Stephen Boyd wrote:
> Sorry it still makes zero sense to me. It seems that we're trying
> to make the OPP table parsing generic just for the sake of code
> brevity.

Not just the code but bindings as well to make sure we don't add a new
property (similar to earlier ones) for every platform that wants to
use performance states.

> Is this the goal? From a DT writer perspective it seems
> confusing to say that opp-microvolt is sometimes a microvolt and
> sometimes not a microvolt.

Well it would still represent the voltage but not in microvolt units
as the platform guys decided to hide those values from kernel and
handle them directly in firmware.

> Why can't the SoC specific genpd
> driver parse something like "qcom,corner" instead out of the
> node?

Sure we can, but that means that a new property will be required for
the next platform.

I did it this way as Kevin (and Rob) suggested NOT to add another
property but use the earlier ones as we aren't passing anything new
here, just that the units of the property are different. For another
SoC, we may want to hide both freq and voltage values from kernel and
pass firmware dependent values. Should we add two new properties for
that SoC then ?

> BTW, I don't believe I have a use-case where I want to express
> power domain OPP tables.

I do remember that you once said [1] that you may want to pass the
real voltage values as well via DT. And so I thought that you can pass
performance-state (corner) in opp-hz and real voltage values in
opp-microvolt.

> I have many devices that all have
> different frequencies that are all tied into the same power
> domain. This binding makes it look like we can only have one
> frequency per domain which won't work.

No, that isn't the case. Looks like we have some confusion here. Let
me try with a simple example:

        foo: foo-power-domain@09000000 {
                compatible = "foo,genpd";
                #power-domain-cells = <0>;
                operating-points-v2 = <&domain_opp_table>;
        };

        cpu0: cpu@0 {
                compatible = "arm,cortex-a53", "arm,armv8";
                ...
                operating-points-v2 = <&cpu_opp_table>;
                power-domains = <&foo>;
        };


        domain_opp_table: domain_opp_table {
                compatible = "operating-points-v2";

                domain_opp_1: opp00 {
                        opp-hz = /bits/ 64 <1>; /* These are corners AKA perf states */
                };
                domain_opp_2: opp01 {
                        opp-hz = /bits/ 64 <2>;
                };
                domain_opp_3: opp02 {
                        opp-hz = /bits/ 64 <3>;
                };
        };

        cpu_opp_table: cpu_opp_table {
                compatible = "operating-points-v2";
                opp-shared;

                opp00 {
                        opp-hz = /bits/ 64 <208000000>;
                        clock-latency-ns = <500000>;
                        power-domain-opp = <&domain_opp_1>;
                };
                opp01 {
                        opp-hz = /bits/ 64 <432000000>;
                        clock-latency-ns = <500000>;
                        power-domain-opp = <&domain_opp_2>;
                };
                opp02 {
                        opp-hz = /bits/ 64 <729000000>;
                        clock-latency-ns = <500000>;
                        power-domain-opp = <&domain_opp_2>;
                };
                opp03 {
                        opp-hz = /bits/ 64 <960000000>;
                        clock-latency-ns = <500000>;
                        power-domain-opp = <&domain_opp_3>;
                };
        };

The device frequencies are still managed by device's OPP table,
just that device's OPP has OPP requirement from another device which
is power domain in this case.

> I want to express that a device with a range of frequencies (or
> really multiple ranges of frequencies) is inside certain physical
> power domains and the frequency of the clks dictates the minimum
> voltage requirement of those power domains.
> 
> For the most complicated case, imagine something like our eMMC
> controller that has two clks (clk1,clk2) that it changes the rate
> of independently and those two clks rely on two different
> regulators (vreg1, vreg2) that supply voltage domains in the SoC
> which the eMMC controller happens to be part of (pd1, pd2). And
> the device is also part of another power domain that we use to
> turn everything off (pd3).
> 
>  +-------+                                 +-------+
>  | vreg1 |                                 | vreg2 |
>  +---+---+                                 +----+--+
>      |                                          |
>      |     +------------+-------------+         |
>      |     | +-------+  |  +--------+ |         |
>      +-----> | clk1  |  |  |  clk2  | <---------+
>            | +---+---+  |  +----+---+ |
>            |     |      |       |     |
>       +----------v--------------v-----------+
>       |    |            |             |     |
>       |    |            |             |     |
>       |    |   pd1      |     pd2     |     |
>       |    |            |             |     |
>       |    +------------+-------------+     |
>       |                                     |
>       |  pd3                          eMMC  |
>       +-------------------------------------+
> 
> 
> >From a DT perspective, I see this as one emmc node:
> 
>     pd: power-domain-controller {
>         #power-domain-cells = <1>;
>     };
> 
>     cc: clock-controller {
>         #clock-cells = <1>;
>     };
> 
>     emmc {
>         power-domains = <&pd 1> <&pd 2>, <&pd 3>;
>         clocks = <&cc 1> <&cc 2>;
>     }
> 
> And then we really don't want to have to express every single
> possible frequency that clk1 and clk2 can be just to express the
> voltage/corner constraints. It could be that we have some table
> like so:
> 
>        clk1 Hz  |  pd1 Corner
>     ------------+-----------
>          40000  |   0
>         960000  |   0
>       19200000  |   1
>       25000000  |   1
>       50000000  |   2
>       74000000  |   3
> 
>        clk2 Hz  |  pd2 Corner
>     ------------+-----------
>        19200000 |   0
>       150000000 |   1
>       340000000 |   2
> 
> 
> BUT we also have another device that uses pd1 and has it's own
> clk3 with different frequency constraints:
> 
>        clk3 Hz   |  pd1 Corner
>     -------------+-----------
>       250000000  |   0
>       360000000  |   1
>       730000000  |   2
> 
> So when clk3 is at 730000000, we don't care what frequency clk1
> is running at, pd1 needs to be at least at corner 2. If it's at
> corner 3 because clk1 is at 74000000 then that's fine.
> 
> I imagine DT would look like our "fmax tables" that are currently
> out of tree. Something like:
> 
> 	clk1_fmax_table {
> 		fmax0 {
> 			reg = /bits/ 64 <960000>;
> 			qcom,corner = <0>;
> 		};
> 		fmax1 {
> 			reg = /bits/ 64 <25000000>;
> 			qcom,corner = <1>;
> 		};
> 		fmax2 {
> 			reg = /bits/ 64 <50000000>;
> 			qcom,corner = <2>;
> 		};
> 		fmax3 {
> 			reg = /bits/ 64 <740000000>;
> 			qcom,corner = <3>;
> 		};
> 	};
> 
> Which is similar to OPP table, but we only list the maximum
> frequency that requires a particular corner. We're back to the
> same problem we have with OPPs of figuring out how to relate a
> table to a certain clk and power domain though. At least for
> qcom, we could do that with some sort of complicated list
> property:
> 
>     emmc {
>         performance-states = <&fmax_table &cc 1 &pd 1>
>     };
> 
> or something like that which would parse a table, a clock, and a
> number of power domains.

Here is how this can be represented with the current proposal.

        pd: power-domain-controller {
            #power-domain-cells = <1>;
            operating-points-v2 = <&pd1_opp_table>, <&pd2_opp_table>, <&pd3_opp_table>;
        };
   
        /*
         * The below OPP nodes can contain other properties like
         * microvolt and microamps, etc.
         *
         * Also if the below 3 tables are exactly same, then the same
         * table can be used for all the three power domains provided
         * by the above controller.
         */
        pd1_opp_table: pd1_opp_table {
                compatible = "operating-points-v2";

                pd1_opp_1: opp00 {
                        opp-hz = /bits/ 64 <1>; /* These are corners AKA perf states */
                };
                pd1_opp_2: opp01 {
                        opp-hz = /bits/ 64 <2>;
                };
                pd1_opp_3: opp02 {
                        opp-hz = /bits/ 64 <3>;
                };
        };

        pd2_opp_table: pd2_opp_table {
                compatible = "operating-points-v2";

                pd2_opp_1: opp00 {
                        opp-hz = /bits/ 64 <1>; /* These are corners AKA perf states */
                };
                pd2_opp_2: opp01 {
                        opp-hz = /bits/ 64 <2>;
                };
                pd2_opp_3: opp02 {
                        opp-hz = /bits/ 64 <3>;
                };
        };

        pd3_opp_table: pd3_opp_table {
                compatible = "operating-points-v2";

                pd3_opp_1: opp00 {
                        opp-hz = /bits/ 64 <1>; /* These are corners AKA perf states */
                };
                pd3_opp_2: opp01 {
                        opp-hz = /bits/ 64 <2>;
                };
                pd3_opp_3: opp02 {
                        opp-hz = /bits/ 64 <3>;
                };
        };

        cc: clock-controller {
            #clock-cells = <1>;
        };
    
        emmc {
            power-domains = <&pd 1> <&pd 2>, <&pd 3>;
            clocks = <&cc 1> <&cc 2>;
            /*
             * We don't allow multiple OPP tables for devices
             * currently, but I think we need to use it for multiple
             * clk case, like emmc in your example.
             */
            operating-points-v2 = <&cc1_opp_table>, <&cc2_opp_table>;
        }

        cc1_opp_table: cc1_opp_table {
                compatible = "operating-points-v2";
                opp-shared;

                opp00 {
                        opp-hz = /bits/ 64 <40000>;
                        power-domain-opp = <&pd1_opp_1>;
                };
                opp01 {
                        opp-hz = /bits/ 64 <960000>;
                        power-domain-opp = <&pd1_opp_1>;
                };
                opp02 {
                        opp-hz = /bits/ 64 <19200000>;
                        power-domain-opp = <&pd1_opp_2>;
                };
                opp03 {
                        opp-hz = /bits/ 64 <25000000>;
                        power-domain-opp = <&pd1_opp_2>;
                };
                opp04 {
                        opp-hz = /bits/ 64 <50000000>;
                        power-domain-opp = <&pd1_opp_3>;
                };
                opp05 {
                        opp-hz = /bits/ 64 <74000000>;
                        power-domain-opp = <&pd1_opp_3>;
                };
        };

        cc2_opp_table: cc2_opp_table {
                compatible = "operating-points-v2";
                opp-shared;

                opp00 {
                        opp-hz = /bits/ 64 <19200000>;
                        power-domain-opp = <&pd2_opp_1>;
                };
                opp01 {
                        opp-hz = /bits/ 64 <150000000>;
                        power-domain-opp = <&pd2_opp_2>;
                };
                opp02 {
                        opp-hz = /bits/ 64 <340000000>;
                        power-domain-opp = <&pd2_opp_3>;
                };
        };

Other devices can too have their OPP tables containing phandles to the
pd1/2/3 OPPs.

Wouldn't this work well ?

> Reminds me, we can have one clk frequency map to multiple power
> domains too. We have this case for our CPUs and PLLs where we
> have individual power control on two domains for one frequency.
> So when the PLL frequency changes, we need to turn on and set the
> voltage or corner of two regulators.

Sure, in that case the above "power-domain-opp" can contain a list.
This is the multiple-power-domain case we have discussed multiple
times earlier.

> So I don't really know how this is all going to work.

I am still hopeful :)

> I'd really
> appreciate to see the full picture though. Reviewing this a bit
> at a time makes me lose sight of the bigger picture.

I was about to publish code based on these bindings today, but then I
received last minute comments from you and Rob and that work is going
to wait a bit more :)

-- 
viresh

[1] https://marc.info/?l=linux-kernel&m=147995301320486&w=2
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
