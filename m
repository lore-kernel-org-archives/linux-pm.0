From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 5/9] ARM: common: Introduce PM domains for CPUs/clusters
Date: Fri, 07 Aug 2015 16:45:36 -0700
Message-ID: <7hd1yyvf1b.fsf@deeprootsystems.com>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438731339-58317-6-git-send-email-lina.iyer@linaro.org>
 <CAL_JsqK67=DTtjZwwnonObLDjLbahkREfm0RvyXVV95bhR-d4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_JsqK67=DTtjZwwnonObLDjLbahkREfm0RvyXVV95bhR-d4Q@mail.gmail.com>
 (Rob Herring's message of "Wed, 5 Aug 2015 22:14:51 -0500")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robherring2@gmail.com>, Lina Iyer <lina.iyer@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Krzysztof =?utf-8?Q?Koz=C5=82owski?= <k.kozlowski@samsung.com>, msivasub@codeaurora.org, Geert Uytterhoeven <geert@linux-m68k.org>, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Rob Herring <robherring2@gmail.com> writes:

> On Tue, Aug 4, 2015 at 6:35 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>> Define and add Generic PM domains (genpd) for ARM CPU clusters. Many
>> new

@Lina: I know you inherited this from some proof-of-concept code frome me, so
I'm partially to blame, but...

There's really nothing ARM specific about this driver.  

>> SoCs group CPUs as clusters. Clusters share common resources like GIC,
>> power rail, caches, VFP, Coresight etc. When all CPUs in the cluster are
>> idle, these shared resources may also be put in their idle state.
>>
>> The idle time between the last CPU entering idle and a CPU resuming
>> execution is an opportunity for these shared resources to be powered
>> down. Generic PM domain provides a framework for defining such power
>> domains and attach devices to the domain. When the devices in the domain
>> are idle at runtime, the domain would also be suspended and resumed
>> before the first of the devices resume execution.
>>
>> We define a generic PM domain for each cluster and attach CPU devices in
>> the cluster to that PM domain. The DT definitions for the SoC describe
>> this relationship. Genpd callbacks for power_on and power_off can then
>> be used to power up/down the shared resources for the domain.
>
> [...]
>
>> +ARM CPU Power domains
>> +
>> +The device tree allows describing of CPU power domains in a SoC. In ARM SoC,
>> +CPUs may be grouped as clusters. A cluster may have CPUs, GIC, Coresight,
>> +caches, VFP and power controller and other peripheral hardware. Generally,
>> +when the CPUs in the cluster are idle/suspended, the shared resources may also
>> +be suspended and resumed before any of the CPUs resume execution.
>> +
>> +CPUs are the defined as the PM domain consumers and there is a PM domain
>> +provider for the CPUs. Bindings for generic PM domains (genpd) is described in
>> +[1].
>> +
>> +The ARM CPU PM domain follows the same binding convention as any generic PM
>> +domain. Additional binding properties are -
>> +
>> +- compatible:
>> +       Usage: required
>> +       Value type: <string>
>> +       Definition: Must also have
>> +                       "arm,pd"
>> +               inorder to initialize the genpd provider as ARM CPU PM domain.
>
> A compatible string should represent a particular h/w block. If it is
> generic, it should represent some sort of standard programming
> interface (e.g, AHCI, EHCI, etc.). This doesn't seem to be either and
> is rather just a mapping of what "driver" you want to use.
>
> I would expect that identifying a cpu's or cluster's power domain
> would be done by a phandle between the cpu/cluster node and power
> domain node. 

That's correct, the CPU nodes (and other nodes in the cluster like GIC,
Coresight, etc.) would have phandles to the cluster power domain node.

But this series is meant to create the driver & binding for those cluster
power domain(s), so the question is how exactly describe it.

What we're trying to get to is binding to describe a powerdomain of a
generic CPU cluster, but of course the actual programming interface for
powering down the cluster will be platform specific.  In earlier RFC
versions, Lina had proposed ways for platforms to register some
low-level hooks with this generic driver for the platform-specific bits,
but if you have some other suggests, we'd be all ears.

Kevin
