From: Brendan Jackman <brendan.jackman@arm.com>
Subject: Re: [PATCH v3 02/15] dt/bindings: Update binding for PM domain idle
 states
Date: Tue, 16 Aug 2016 09:41:27 +0100
Message-ID: <20160816084127.GA24657@brendan-thinkstation>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160815224014.GF1401@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, Axel Haslam <ahaslam+renesas@baylibre.com>, devicetree@vger.kernel.org, Marc Titinger <mtitinger+renesas@baylibre.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Juri Lelli <Juri.Lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi Lina,

Agh, sorry, sent with the "IMPORTANT NOTICE" again, still getting used to
mailing lists.. here's the message again without it.

On Mon, Aug 15, 2016 at 04:40:14PM -0600, Lina Iyer wrote:
> On Mon, Aug 15 2016 at 10:14 -0600, Sudeep Holla wrote:
> >
> >
> >On 15/08/16 17:08, Lina Iyer wrote:
> >>On Fri, Aug 12 2016 at 04:08 -0600, Sudeep Holla wrote:
> >>>
> >>>
> >>>On 11/08/16 22:10, Lina Iyer wrote:
> >>>>On Wed, Aug 10 2016 at 12:09 -0600, Sudeep Holla wrote:
> >>>>>
> >>>
> >>>[...]
> >>>
> >>>>>cluster0
> >>>>>  CLUSTER_RET(Retention)
> >>>>>  CLUSTER_PG(Power Gate)
> >>>>>  core0
> >>>>>      CORE_RET
> >>>>>      CORE_PG
> >>>>>  core1
> >>>>>      CORE_RET
> >>>>>      CORE_PG
> >>>>>
> >>>>>cluster1
> >>>>>  CLUSTER_RET
> >>>>>  CLUSTER_PG
> >>>>>  core0
> >>>>>      CORE_RET
> >>>>>      CORE_PG
> >>>>>  core1
> >>>>>      CORE_RET
> >>>>>      CORE_PG
> >>>>>
> >>>>>Platform Co-ordinate supports the following states and we should be
> >>>>>able to determine that from the binding:
> >>>>>
> >>>>>CORE_RET
> >>>>>CORE_PG
> >>>>>CORE_RET + CLUSTER_RET
> >>>>
> >>>>The problem that we have to sove here is knowing that CORE_RET +
> >>>>CLUSTER_PG (hypothetically) an invalid combination. Kevin and
> >>>>I debated it in the earlier RFC and we dont have a good way to solve
> >>>>this generically for all devices.
> >>>>
> >>>
> >>>Yes, I agree it's complex. But that needs to be solved IMO.
> >>>
> >>>I can think of 2 possible solutions:
> >>>
> >>>1. Index the states(which people have not liked, but as along as we
> >>> don't use it in the code as it for any other purpose, it should be
> >>> fine) and then have each state mentioning what parent state can be
> >>> entered at this child state(i.e. starting index and all states below
> >>> it)
> >>>
> >>This is how QCOM solved it downstream.
> >>
> >
> >Yes even ACPI has indices to solve this.
> >
> >>>2. Something similar to (1) but without index instead phandles.
> >>>
> >>
> >>The problem is when you have non-CPU devices in the device tree and
> >>since they do not have a way to represent states like CPU, we did not
> >>have a clear path to that. Hence we punted that to later. Whatever we
> >>do, we should solve it for a generic PM domain, not just CPU domains.
> >>
> >
> >Yes bindings defined here should be applicable for devices to, but only
> >CPU's will have this hierarchy while the devices need not bother about
> >hierarchy. However the parent power domain can ever the state which is
> >least common denominator of all it's children power domain. That's my
> >understanding. No?
> >


Are you saying that the parent can enter the shallowest idle state that all its
children are in (I.e if all its children are in "retention" then it can enter
"retention")? I don't know what the reality is on existing platforms but it
doesn't sound like 100% safe assumption to make. Also I don't think you can
necessarily correlate idle states at different domain levels - i.e. here we've
matched up the idea of "retention" at core level with that of "retention" at
cluster level. I may have misunderstood you there..

> That is correct. But say if all the CPUs choose CORE_RET + CLUSTER_PG,
> which is invalid and the firmware has to ignore it and does CORE_RET +
> CLUSTER_RET instead, then Linux may have an inconsistent view of the
> state selection.
>

Perhaps a better starting point would be to go with the assumption that a parent
PD can only enter any idle state once its children are in their deepest idle
states.

So in the example above we'd end up with

CORE_RET
CORE_PG
CORE_PG + CLUSTER_RET
CORE_PG + CLUSTER_PG

(Missing out on CORE_RET + CLUSTER_RET, even though that's a valid combination
from the hardware's perspective)

Then a later addition to the bindings as discussed above could enable the
possibility of those combinations to be expressed.

> Thanks,
> Lina
>
> >--
> >Regards,
> >Sudeep
>
