From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v2 5/8] dt/bindings: Update binding for PM domain idle
 states
Date: Mon, 10 Oct 2016 10:43:42 -0600
Message-ID: <20161010164342.GC44885@linaro.org>
References: <1475879821-8035-1-git-send-email-lina.iyer@linaro.org>
 <1475879821-8035-6-git-send-email-lina.iyer@linaro.org>
 <4e55d6ad-8de7-72d7-7512-5e4ff2aabc79@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4e55d6ad-8de7-72d7-7512-5e4ff2aabc79@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, lorenzo.pieralisi@arm.com, Juri.Lelli@arm.com, khilman@kernel.org, sboyd@codeaurora.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, Marc Titinger <mtitinger+renesas@baylibre.com>, brendan.jackman@arm.com, linux-arm-msm@vger.kernel.org, andy.gross@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 10 2016 at 09:45 -0600, Sudeep Holla wrote:
>
>
>On 07/10/16 23:36, Lina Iyer wrote:
>>Update DT bindings to describe idle states of PM domains.
>>
>>This patch is based on the original patch by Marc Titinger.
>>
>>Cc: <devicetree@vger.kernel.org>
>>Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
>>Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>Acked-by: Rob Herring <robh@kernel.org>
>>---
>> .../devicetree/bindings/power/power_domain.txt     | 38 ++++++++++++++++++++++
>> 1 file changed, 38 insertions(+)
>>
>>diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
>>index 025b5e7..7f8f27e 100644
>>--- a/Documentation/devicetree/bindings/power/power_domain.txt
>>+++ b/Documentation/devicetree/bindings/power/power_domain.txt
>>@@ -29,6 +29,10 @@ Optional properties:
>>    specified by this binding. More details about power domain specifier are
>>    available in the next section.
>>
>>+- domain-idle-states : A phandle of an idle-state that shall be soaked into a
>>+                generic domain power state. The idle state definitions are
>>+                compatible with arm,idle-state specified in [1].
>>+
>
>Please do add the following details to the binding. IMO, this binding is
>not complete in terms of specification as there are few open questions:
>
>1. What not define a standard compatible instead of "arm,idle-state" ?
>   I agree it can be used, but as part of this *generic* binding, IMO
>   it's better to have something generic and can be used by devices.
>   Otherwise, this binding becomes CPU specific, that too ARM CPU
>   specific.
>
We had gone down this path of having a separate DT bindings for domains
that is not arm,idle-state. See RFC patches. But the binding did closely
match this and it so was suggested that we use arm,idle-state which is
already defined.

>2. Now taking CPU as a special device, how does this co-exist with the
>   cpu-idle-states ? Better to have some description may be in the ARM
>   CPU idle binding document(not here of-course)
>
The is a binding for a generic PM domain. This has no bearing on the CPU
or its idle states. Its just that the data is compatible with
arm,idle-state.

>3. I still haven't seen any explanation for not considering complete
>   hierarchical power domain representation which was raised in earlier
>   versions. I had provided example for the proposal. I just saw them
>   already in use in the upstream kernel by Renasas. e.g.:
>   arch/arm/boot/dts/r8a73a4.dtsi
>
Hierarchical power domains have been available for few years in DT. The
OF features of domains have always supported it. Platforms are free to
define domains in hierarchy they seem fit for their SoCs. This is a
feature that is available today and is not being modified in these
patches. It will be creating confusion if I talk about hierarchical
domains which are obvious and irrelevant to this series.

>   How does that fit with your proposal, though you have not made one
>   yet for CPUs in this binding ? In the above file, CPUs have either
>   own power domain inside the L2 one which is cluster level power
>   domain.
>
Again, this series is not about the CPUs. This is about adding features
to genpd that may be used in other contexts including cpuidle in the
future.

>One must be able to get answers to these above questions with this
>binding. Until then it's *incomplete* though it may be correct.
>
I have always tried to answer all your questions. If anything remains
unclarified pls. bring it up.

Thanks,
Lina
