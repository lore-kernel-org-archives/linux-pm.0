From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 02/15] dt/bindings: Update binding for PM domain idle
 states
Date: Tue, 16 Aug 2016 10:19:36 +0100
Message-ID: <edc76f32-7e8f-4301-1345-ef9944ae9a51@arm.com>
References: <1470351902-43103-1-git-send-email-lina.iyer@linaro.org>
 <1470351902-43103-3-git-send-email-lina.iyer@linaro.org>
 <99e35b6c-6698-6d27-f4d7-fa032796869e@arm.com>
 <20160810164034.GA1401@linaro.org>
 <5e59874c-bbb7-270a-199c-da1ff5932554@arm.com>
 <20160811211023.GC1401@linaro.org>
 <697d8ac2-34ee-db3e-940b-5ce3365c5aa1@arm.com>
 <20160815160857.GE1401@linaro.org>
 <2033f384-7ea3-6713-4def-80bf4251fd67@arm.com>
 <20160815224014.GF1401@linaro.org>
 <20160816084127.GA24657@brendan-thinkstation>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160816084127.GA24657@brendan-thinkstation>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Brendan Jackman <brendan.jackman@arm.com>, Lina Iyer <lina.iyer@linaro.org>
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, khilman@kernel.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, Axel Haslam <ahaslam+renesas@baylibre.com>, Marc Titinger <mtitinger+renesas@baylibre.com>, Sudeep Holla <sudeep.holla@arm.com>, andy.gross@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org



On 16/08/16 09:41, Brendan Jackman wrote:
> Hi Lina,
> On Mon, Aug 15, 2016 at 04:40:14PM -0600, Lina Iyer wrote:
>> On Mon, Aug 15 2016 at 10:14 -0600, Sudeep Holla wrote:
[,,,]


>>>
>>> Yes even ACPI has indices to solve this.
>>>
>>>>> 2. Something similar to (1) but without index instead phandles.
>>>>>
>>>>
>>>> The problem is when you have non-CPU devices in the device tree and
>>>> since they do not have a way to represent states like CPU, we did not
>>>> have a clear path to that. Hence we punted that to later. Whatever we
>>>> do, we should solve it for a generic PM domain, not just CPU domains.
>>>>
>>>
>>> Yes bindings defined here should be applicable for devices to, but only
>>> CPU's will have this hierarchy while the devices need not bother about
>>> hierarchy. However the parent power domain can ever the state which is
>>> least common denominator of all it's children power domain. That's my
>>> understanding. No?
>>>
>
>
> Are you saying that the parent can enter the shallowest idle state that all its
> children are in (I.e if all its children are in "retention" then it can enter
> "retention")? I don't know what the reality is on existing platforms but it
> doesn't sound like 100% safe assumption to make.

I was referring to non-CPU/device power states above. For CPU we do need
a mechanism in place to indicate the dependency.

> Also I don't think you can
> necessarily correlate idle states at different domain levels - i.e. here we've
> matched up the idea of "retention" at core level with that of "retention" at
> cluster level. I may have misunderstood you there..
>

Correct for CPUs. For normal devices and their power domains, it could
straight forward. E.g if many devices are at-least at state D1(few may
be at state D2 or above), the parent can enter D1.(D0-runnning and D1-D3
are low power states in the above example)

>> That is correct. But say if all the CPUs choose CORE_RET + CLUSTER_PG,
>> which is invalid and the firmware has to ignore it and does CORE_RET +
>> CLUSTER_RET instead, then Linux may have an inconsistent view of the
>> state selection.
>>

1. First, CORE_RET + CLUSTER_PG should not be registered as valid idle
    state.
2. We do have inconsistent view already for platform co-ordinated idle
    In-fact it could happen even with OSC mode I believe. Platform can
    always demote the state, so OS can never get the exact view unless it
    queries the firmware for that explicitly(e.g. PSCI_STATS)

>
> Perhaps a better starting point would be to go with the assumption that a parent
> PD can only enter any idle state once its children are in their deepest idle
> states.
>
> So in the example above we'd end up with
>
> CORE_RET
> CORE_PG
> CORE_PG + CLUSTER_RET
> CORE_PG + CLUSTER_PG
>

Yes this assumption seems good enough to me. At-least no invalid
combination is ensured.

> (Missing out on CORE_RET + CLUSTER_RET, even though that's a valid combination
> from the hardware's perspective)
>

Yes, if it's a real issue then we need proper bindings to deal with
that. Otherwise we can manage without the extra information.

> Then a later addition to the bindings as discussed above could enable the
> possibility of those combinations to be expressed.
>

Seems feasible solution to me, but better to make this explicit in the
binding and check with few others. It looks fair enough assumption IMO.

-- 
-- 
Regards,
Sudeep
