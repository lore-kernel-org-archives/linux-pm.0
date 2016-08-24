From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 02/15] dt/bindings: Update binding for PM domain idle
 states
Date: Wed, 24 Aug 2016 15:07:38 +0100
Message-ID: <9b2ed5d3-c071-8828-5a22-1ab6f3753d74@arm.com>
References: <1470351902-43103-1-git-send-email-lina.iyer@linaro.org>
 <1470351902-43103-3-git-send-email-lina.iyer@linaro.org>
 <99e35b6c-6698-6d27-f4d7-fa032796869e@arm.com>
 <20160810164034.GA1401@linaro.org>
 <5e59874c-bbb7-270a-199c-da1ff5932554@arm.com> <m2fuq0k4tj.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <m2fuq0k4tj.fsf@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, linux-pm@vger.kernel.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, rjw@rjwysocki.net, Axel Haslam <ahaslam+renesas@baylibre.com>, Marc Titinger <mtitinger+renesas@baylibre.com>, Brendan Jackman <Brendan.Jackman@arm.com>, Lina Iyer <lina.iyer@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, andy.gross@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org



On 19/08/16 19:10, Kevin Hilman wrote:
> Sudeep Holla <sudeep.holla@arm.com> writes:
>
> [...]
>
>> In general whatever binding we come up must not just address OS
>> coordinated mode. Also I was thinking to have better coverage in the
>> description by having a bit more complex system like:
>>
>> cluster0
>> 	CLUSTER_RET(Retention)
>> 	CLUSTER_PG(Power Gate)
>> 	core0
>> 		CORE_RET
>> 		CORE_PG
>> 	core1
>> 		CORE_RET
>> 		CORE_PG
>
> Also, remember that a power domain may contain more than just CPUs, so
> this will also need to handle things like:
>
> 	device0..N
>         	DEV_CLK_GATE
>                 DEV_RET
>                 DEV_PG
>
> So, as (I think) Lina was trying to say, including CPU idle states
> inside domain idles states doesn't really scale well because it would
> also imply domain states would also include device idle states.
>
> IMO, the device-specific states belong in the device nodes, and that
> includes CPUs.
>

OK, IIUC we don't have device idle states binding today, so we are not
breaking anything there. Can you elaborate on the issue you see if we
just have domain idle-states ? Is it because we currently create genpd
domain for each entry ?

If a CPU/Device can be enter idle-state(s) it means that it is in a
power domain on its own, so I don't see any issue in such representation.

> It's up to the domain (genpd) governor to look at *all* devices in the
> domain, check their state and make a domain-wide decision.
>

Lets not mix the current genpd implementation in the kernel into this
discussion for simplicity. How is the implementation in the kernel today
and what can be done is a separate topic.

What this discussion should aim at is to present the idle states in the
system in the device tree so that it address the issues we have
currently and extensible in near future with any compatibility issues.

> The tricky part remains, IMO, the mapping between device/CPU states and
> allowable domain states.
>
> As was suggested earlier, a good potential starting point would be that
> all devices/CPUs would need to be in their deepest state before the
> domain would make any decisions.  While that leaves soem power savings
> on the table, it maps well to how genpd works today with only on/off
> states and could be extended with more complicated governors down the
> road.
>

Agreed.

Some example below for discussion, feel free to add more cases.

--
Regards,
Sudeep


--->8

1. Dual cluster with 2 CPUs in each cluster with powerdown at both CPU and
    cluster level

   idle-states {
     CPU_SLEEP_0: cpu-sleep-0 {
       ...
       entry-latency-us = <300>;
       ...
     };
     CLUSTER_SLEEP_0: cluster-sleep-0 {
       ...
       entry-latency-us = <300>;
       ...
     };
   };

   cpu@0 {
     ...
     /*
      * implentation may ignore cpu-idle-states if power-domains
      * has idle-states, DT's may have both for backward compatibility
      */
     cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
     power-domains = <&CPU_0_1_PD>;
     ...
   };

   cpu@1 {
     ...
     cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
     power-domains = <&CPU_0_1_PD>;
     ...
   };

   cpu@100 {
     ...
     cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
     power-domains = <&CPU_1_0_PD>;
     ...
   };

   cpu@101 {
     ...
     cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
     power-domains = <&CPU_1_1_PD>;
     ...
   };

   power-domains {
     CLUSTER_0_PD: cluster-0-pd {
       #power-domain-cells = <0>;
       domain-idle-states = <&CLUSTER_SLEEP_0>;
     };
     CPU_0_0_PD: cpu-0-0-pd@0 {
       #power-domain-cells = <0>;
       domain-idle-states = <&CPU_SLEEP_0>;
       power-domains = <&CLUSTER_0_PD>;
     };
     CPU_0_1_PD: cpu-0-1-pd@1 {
       #power-domain-cells = <0>;
       domain-idle-states = <&CPU_SLEEP_0>;
       power-domains = <&CLUSTER_0_PD>;
     };
     CLUSTER_1_PD: cluster-1-pd {
       #power-domain-cells = <0>;
       domain-idle-states = <&CLUSTER_SLEEP_0>;
     };
     CPU_1_0_PD: cpu-1-0-pd@0 {
       #power-domain-cells = <0>;
       domain-idle-states = <&CPU_SLEEP_0>;
       power-domains = <&CLUSTER_1_PD>;
     };
     CPU_1_1_PD: cpu-1-1-pd@1 {
       #power-domain-cells = <0>;
       domain-idle-states = <&CPU_SLEEP_0>;
       power-domains = <&CLUSTER_1_PD>;
     };
   };

2. Dual cluster with 2 CPUs in each cluster with retention and powerdown 
at both
    CPU and cluster level

   idle-states {
     CPU_SLEEP_0: cpu-sleep-0 { /* Retention */
       ...
       entry-latency-us = <100>;
       ...
     };
     CPU_SLEEP_1: cpu-sleep-1 { /* Power-down */
       ...
       entry-latency-us = <500>;
       ...
     };
     CLUSTER_SLEEP_0: cluster-sleep-0 { /* Retention */
       ...
       entry-latency-us = <300>;
       ...
     };
     CLUSTER_SLEEP_1: cluster-sleep-1 {/* Power-down */
       ...
       entry-latency-us = <1000>;
       ...
     };
   };

   cpu@0 {
     ...
     power-domains = <&CPU_0_1_PD>;
     ...
   };

   cpu@1 {
     ...
     power-domains = <&CPU_0_1_PD>;
     ...
   };

   cpu@100 {
     ...
     power-domains = <&CPU_1_0_PD>;
     ...
   };

   cpu@101 {
     ...
     power-domains = <&CPU_1_1_PD>;
     ...
   };

   power-domains {
     /*
      * Each cluster/core PD may point to different idle states,
      * it's all same here in the example to keep it short and
      * simple
      */
     CLUSTER_0_PD: cluster-0-pd {
       #power-domain-cells = <0>;
       domain-idle-states = <&CLUSTER_SLEEP_0 &CLUSTER_SLEEP_1>;
     };
     CPU_0_0_PD: cpu-0-0-pd@0 {
       #power-domain-cells = <0>;
       domain-idle-states = <&CPU_SLEEP_0 &CPU_SLEEP_1>;
       power-domains = <&CLUSTER_0_PD>;
     };
     CPU_0_1_PD: cpu-0-1-pd@1 {
       #power-domain-cells = <0>;
       domain-idle-states = <&CPU_SLEEP_0 &CPU_SLEEP_1>;
       power-domains = <&CLUSTER_0_PD>;
     };
     CLUSTER_1_PD: cluster-1-pd {
       #power-domain-cells = <0>;
       domain-idle-states = <&CLUSTER_SLEEP_0 &CLUSTER_SLEEP_1>;
     };
     CPU_1_0_PD: cpu-1-0-pd@0 {
       #power-domain-cells = <0>;
       domain-idle-states = <&CPU_SLEEP_0 &CPU_SLEEP_1>;
       power-domains = <&CLUSTER_1_PD>;
     };
     CPU_1_1_PD: cpu-1-1-pd@1 {
       #power-domain-cells = <0>;
       domain-idle-states = <&CPU_SLEEP_0 &CPU_SLEEP_1>;
       power-domains = <&CLUSTER_1_PD>;
     };
   };

3. Dual cluster with 2 CPUs in each cluster with retention and powerdown at
    just cluster level

   idle-states {
     CLUSTER_SLEEP_0: cluster-sleep-0 { /* Retention */
       ...
       entry-latency-us = <300>;
       ...
     };
     CLUSTER_SLEEP_1: cluster-sleep-1 {/* Power-down */
       ...
       entry-latency-us = <1000>;
       ...
     };
   };

   cpu@0 {
     ...
     power-domains = <&CLUSTER_0_PD>;
     ...
   };

   cpu@1 {
     ...
     power-domains = <&CLUSTER_0_PD>;
     ...
   };

   cpu@100 {
     ...
     power-domains = <&CLUSTER_1_PD>;
     ...
   };

   cpu@101 {
     ...
     power-domains = <&CLUSTER_1_PD>;
     ...
   };

   power-domains {
     CLUSTER_0_PD: cluster-0-pd {
       #power-domain-cells = <0>;
       domain-idle-states = <&CLUSTER_SLEEP_0 &CLUSTER_SLEEP_1>;
     };
     CLUSTER_1_PD: cluster-1-pd {
       #power-domain-cells = <0>;
       domain-idle-states = <&CLUSTER_SLEEP_0 &CLUSTER_SLEEP_1>;
     };
   };

4. 4 devices sharing the power domain.

   idle-states {
     /*
      * Device idle states may differ from CPU idle states in terms
      * of the list of properties
      */
     DEVPD_SLEEP_0: devpd-sleep-0 { /* Retention */
       ...
       entry-latency-us = <300>;
       ...
     };
     DEVPD_SLEEP_1: devpd-sleep-1 {/* Power-down */
       ...
       entry-latency-us = <1000>;
       ...
     };
   };

   dev@0 {
     ...
     power-domains = <&DEV_PD_0>;
     ...
   };

   dev@1 {
     ...
     power-domains = <&DEV_PD_0>;
     ...
   };

   dev@2 {
     ...
     power-domains = <&DEV_PD_0>;
     ...
   };

   dev@3 {
     ...
     power-domains = <&DEV_PD_0>;
     ...
   };

   power-domains {
     DEV_PD_0: device-pd-0 {
       #power-domain-cells = <0>;
       domain-idle-states = <&DEVPD_SLEEP_0 &DEVPD_SLEEP_1>;
     };
   };

5. 4 devices sharing the power domain + another device sharing the power
    domain but has it's own sub-domain

   idle-states {
     DEVPD_0_SLEEP_0: devpd-sleep-0 { /* Retention */
       ...
       entry-latency-us = <300>;
       ...
     };
     DEVPD_0_SLEEP_1: devpd-sleep-1 {/* Power-down */
       ...
       entry-latency-us = <1000>;
       ...
     };
     DEVPD_1_SLEEP_0: devpd-sleep-0 { /* Retention */
       ...
       entry-latency-us = <300>;
       ...
     };
     DEVPD_1_SLEEP_1: devpd-sleep-1 {/* Power-down */
       ...
       entry-latency-us = <1000>;
       ...
     };
   };

   dev@0 {
     ...
     power-domains = <&DEV_PD_0>;
     ...
   };

   dev@1 {
     ...
     power-domains = <&DEV_PD_0>;
     ...
   };

   dev@2 {
     ...
     power-domains = <&DEV_PD_0>;
     ...
   };

   dev@3 {
     ...
     power-domains = <&DEV_PD_0>;
     ...
   };

   dev@4 {
     ...
     power-domains = <&DEV_PD_1>;
     ...
   };

   power-domains {
     DEV_PD_0: device-pd-0 {
       #power-domain-cells = <0>;
       domain-idle-states = <&DEVPD_0_SLEEP_0 &DEVPD_0_SLEEP_1>;
     };
     DEV_PD_1: device-pd-1 {
       #power-domain-cells = <0>;
       power-domains = <&DEV_PD_0>;
       domain-idle-states = <&DEVPD_1_SLEEP_0 &DEVPD_1_SLEEP_1>;
     };
   };
