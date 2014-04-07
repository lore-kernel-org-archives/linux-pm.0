From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH RFC v5 3/3] Documentation: arm: define DT idle states
 bindings
Date: Mon, 7 Apr 2014 17:34:49 +0200
Message-ID: <CAKfTPtAr=YFxF7oew3EShBryyAobFNqe0Rf-bBUTCyAsLNV3JQ@mail.gmail.com>
References: <1395142132-20788-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1395142132-20788-4-git-send-email-lorenzo.pieralisi@arm.com>
 <20140404155622.GA4061@e102568-lin.cambridge.arm.com>
 <CAKfTPtB=94pA__3pgO0G+=RZucwgGJ7rW0+HoAJLpWOtCo7g4Q@mail.gmail.com>
 <20140407143622.GB25563@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140407143622.GB25563@e102568-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Tomasz Figa <t.figa@samsung.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Russell King <linux@arm.linux.org.uk>, Sebastian Capella <sebastian.capella@linaro.org>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Dave P Martin <Dave.Martin@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Mike Turquette <mturquette@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>A
List-Id: linux-pm@vger.kernel.org

On 7 April 2014 16:36, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> On Mon, Apr 07, 2014 at 01:25:17PM +0100, Vincent Guittot wrote:
>> On 4 April 2014 17:56, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
>> > [replying to self, since I have a query]
>> >
>> > [...]
>> >
>> >> +===========================================
>> >> +4 - Examples
>> >> +===========================================
>> >> +
>> >> +Example 1 (ARM 64-bit, 16-cpu system):
>> >> +
>> >> +pd_clusters: power-domain-clusters@80002000 {
>> >> +       compatible = "arm,power-controller";
>> >> +       reg = <0x0 0x80002000 0x0 0x1000>;
>> >> +       #power-domain-cells = <1>;
>> >> +       #address-cells = <2>;
>> >> +       #size-cells = <2>;
>> >> +
>> >> +       pd_cores: power-domain-cores@80000000 {
>> >> +               compatible = "arm,power-controller";
>> >> +               reg = <0x0 0x80000000 0x0 0x1000>;
>> >> +               #power-domain-cells = <1>;
>> >> +       };
>> >> +};
>> >> +
>> >> +cpus {
>> >> +       #size-cells = <0>;
>> >> +       #address-cells = <2>;
>> >> +
>> >> +       idle-states {
>> >> +               entry-method = "arm,psci-cpu-suspend";
>> >> +
>> >> +               CLUSTER_RETENTION_0: cluster-retention-0 {
>> >> +                       compatible = "arm,idle-state";
>> >> +                       index = <2>;
>> >> +                       logic-state-retained;
>> >> +                       cache-state-retained;
>> >> +                       entry-method-param = <0x1010000>;
>> >> +                       entry-latency-us = <50>;
>> >> +                       exit-latency-us = <100>;
>> >> +                       min-residency-us = <250>;
>> >> +                       power-domains = <&pd_clusters 0>;
>> >> +                       CPU_RETENTION_0_0: cpu-retention-0 {
>> >> +                               compatible = "arm,idle-state";
>> >> +                               index = <0>;
>> >> +                               cache-state-retained;
>> >> +                               entry-method-param = <0x0010000>;
>> >> +                               entry-latency-us = <20>;
>> >> +                               exit-latency-us = <40>;
>> >> +                               min-residency-us = <30>;
>> >> +                               power-domains = <&pd_cores 0>,
>> >> +                                               <&pd_cores 1>,
>> >> +                                               <&pd_cores 2>,
>> >> +                                               <&pd_cores 3>,
>> >> +                                               <&pd_cores 4>,
>> >> +                                               <&pd_cores 5>,
>> >> +                                               <&pd_cores 6>,
>> >> +                                               <&pd_cores 7>;
>> >> +                       };
>> >> +               };
>> >> +
>> >> +               CLUSTER_SLEEP_0: cluster-sleep-0 {
>> >> +                       compatible = "arm,idle-state";
>> >> +                       index = <3>;
>> >> +                       entry-method-param = <0x1010000>;
>> >> +                       entry-latency-us = <600>;
>> >> +                       exit-latency-us = <1100>;
>> >> +                       min-residency-us = <2700>;
>> >> +                       power-domains = <&pd_clusters 0>;
>> >> +                       CPU_SLEEP_0_0: cpu-sleep-0 {
>> >> +                               /* cpu sleep */
>> >> +                               compatible = "arm,idle-state";
>> >> +                               index = <1>;
>> >> +                               entry-method-param = <0x0010000>;
>> >> +                               entry-latency-us = <250>;
>> >> +                               exit-latency-us = <500>;
>> >> +                               min-residency-us = <350>;
>> >> +                               power-domains = <&pd_cores 0>,
>> >> +                                               <&pd_cores 1>,
>> >> +                                               <&pd_cores 2>,
>> >> +                                               <&pd_cores 3>,
>> >> +                                               <&pd_cores 4>,
>> >> +                                               <&pd_cores 5>,
>> >> +                                               <&pd_cores 6>,
>> >> +                                               <&pd_cores 7>;
>> >> +                       };
>> >> +               };
>> >
>> > I noticed while developing the CPUidle generic driver, that by using this
>> > representation I might end up requiring duplicated states.
>> >
>> > For instance, a cluster-retention state and a cluster-sleep state might
>> > want to have cpu-sleep state as substate, and this would require an
>> > idle state node duplication.
>> >
>> > I think it is better to have a single flat (and ordered...that would
>> > kill two birds with one stone) list of nodes in the idle-states node and
>> > every state might have a list of phandles to subnodes (substates), something
>> > like the following example.
>> >
>> > This simplifies parsing  and I think it solves the last issue I
>> > came across (the need for duplicate states - in the bindings below,
>> > CPU_SLEEP_0 is a substate of both CLUSTER_RETENTION_0 and
>> > CLUSTER_SLEEP_0, through phandles).
>>
>> Hi Lorenzo,
>>
>> You explanation above has triggered a question. You writes:
>> CPU_SLEEP_0 is a substate of CLUSTER_RETENTION_0 but i would have say
>> that both CPU_SLEEP_0 and CPU_RETENTION_0 are substates of
>> CLUSTER_RETENTION_0. I mean that if cpus are either in retention mode
>> OR in  sleep mode, you can enter the CLUSTER_RETENTION_0 state (you
>> can have some in sleep mode and other in retention of course)
>> I'm wondering how this OR  will be described.
>
> We need another state (because that's what happens in HW right ?), so we
> describe it (obviously having different latencies):
>
>
>         CLUSTER_RETENTION_1: cluster-retention-1 {
>                 compatible = "arm,idle-state";
>                 logic-state-retained;
>                 cache-state-retained;
>                 entry-method-param = <0x1010000>;
>                 entry-latency-us = <50>;
>                 exit-latency-us = <700>;
>                 min-residency-us = <2000>;
>                 power-domains = <&pd_clusters 0>;
>                 substates = <&CPU_RETENTION_0>;
>          };
>
> Using phandles all state combinations are now possible, with no state
> duplication.
>
> State above is entered when all CPUs are in retention mode and thanks
> to the phandle the kernel knows what has to be done as far as each
> CPU is concerned. The beauty of this approach is that for every state,
> it is well defined what has to be done for the respective power domain
> (eg state above, cache is retained. All caches in <&pd_clusters 0> are
> retained. Then we follow the substates, and take action according to
> the substate propertes and respective power domain).
>
> Does this make sense ? I can't find fault with this semantics, but
> please let me know if you do.


So we will have some cpus of the cluster in CLUSTER_RETENTION_1 state
and other cpus of the same cluster in CLUSTER_RETENTION_0 depending of
the power state of the cpu part but for the same power state of common
part of the cluster.
How does the driver know that both power states are compatible ? I
mean how the last cpu will know that it can put the cluster in
retention state because all the other cpus of the cluster are in a
compatible state ?

Regards,
Vincent

>
> Thank you !!
> Lorenzo
>
>> Then, IMHO, the flat description below is clearer and remove the
>> duplicated description that you mention previously
>>
>> Regards,
>> Vincent
>>
>> >
>> > Thoughts very appreciated, thanks.
>> >
>> > Lorenzo
>> >
>> > idle-states {
>> >        entry-method = "arm,psci-cpu-suspend";
>> >
>> >         CPU_RETENTION_0: cpu-retention-0 {
>> >                        compatible = "arm,idle-state";
>> >                        cache-state-retained;
>> >                        entry-method-param = <0x0010000>;
>> >                        entry-latency-us = <20>;
>> >                        exit-latency-us = <40>;
>> >                        min-residency-us = <30>;
>> >                        power-domains = <&pd_cores 0>,
>> >                                        <&pd_cores 1>,
>> >                                        <&pd_cores 2>,
>> >                                        <&pd_cores 3>,
>> >         };
>> >
>> >         CPU_SLEEP_0: cpu-sleep-0 {
>> >                        /* cpu sleep */
>> >                        compatible = "arm,idle-state";
>> >                        entry-method-param = <0x0010000>;
>> >                        entry-latency-us = <250>;
>> >                        exit-latency-us = <500>;
>> >                        min-residency-us = <350>;
>> >                        power-domains = <&pd_cores 0>,
>> >                                        <&pd_cores 1>,
>> >                                        <&pd_cores 2>,
>> >                                        <&pd_cores 3>,
>> >         };
>> >
>> >         CPU_SLEEP_1: cpu-sleep-1 {
>> >                        /* cpu sleep */
>> >                        compatible = "arm,idle-state";
>> >                        entry-method-param = <0x0010000>;
>> >                        entry-latency-us = <250>;
>> >                        exit-latency-us = <500>;
>> >                        min-residency-us = <350>;
>> >                                        <&pd_cores 4>,
>> >                                        <&pd_cores 5>,
>> >                                        <&pd_cores 6>,
>> >                                        <&pd_cores 7>;
>> >         };
>> >
>> >         CLUSTER_RETENTION_0: cluster-retention-0 {
>> >                compatible = "arm,idle-state";
>> >                logic-state-retained;
>> >                cache-state-retained;
>> >                entry-method-param = <0x1010000>;
>> >                entry-latency-us = <50>;
>> >                exit-latency-us = <800>;
>> >                min-residency-us = <2400>;
>> >                power-domains = <&pd_clusters 0>;
>> >                substates = <&CPU_SLEEP_0>;
>> >         };
>> >
>> >         CLUSTER_SLEEP_0: cluster-sleep-0 {
>> >                compatible = "arm,idle-state";
>> >                entry-method-param = <0x1010000>;
>> >                entry-latency-us = <600>;
>> >                exit-latency-us = <1100>;
>> >                min-residency-us = <2700>;
>> >                power-domains = <&pd_clusters 0>;
>> >                substates = <&CPU_SLEEP_0>;
>> >         };
>> >
>> >         CLUSTER_SLEEP_1: cluster-sleep-1 {
>> >                compatible = "arm,idle-state";
>> >                entry-method-param = <0x1010000>;
>> >                entry-latency-us = <600>;
>> >                exit-latency-us = <1100>;
>> >                min-residency-us = <2700>;
>> >                power-domains = <&pd_clusters 1>;
>> >                substates = <&CPU_SLEEP_1>;
>> >         };
>> >
>> >         SYSTEM_SLEEP_0: system-sleep-0 {
>> >                compatible = "arm,idle-state";
>> >                entry-method-param = <0x2010000>;
>> >                entry-latency-us = <6000>;
>> >                exit-latency-us = <10000>;
>> >                min-residency-us = <30000>;
>> >                power-domains = <&pd_system 0>;
>> >                substates = <&CLUSTER_SLEEP_0>, <&CLUSTER_SLEEP_1>;
>> >         };
>> > };
>> >
>>
>
