From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v3 02/15] dt/bindings: Update binding for PM domain idle
 states
Date: Mon, 15 Aug 2016 10:08:57 -0600
Message-ID: <20160815160857.GE1401@linaro.org>
References: <1470351902-43103-1-git-send-email-lina.iyer@linaro.org>
 <1470351902-43103-3-git-send-email-lina.iyer@linaro.org>
 <99e35b6c-6698-6d27-f4d7-fa032796869e@arm.com>
 <20160810164034.GA1401@linaro.org>
 <5e59874c-bbb7-270a-199c-da1ff5932554@arm.com>
 <20160811211023.GC1401@linaro.org>
 <697d8ac2-34ee-db3e-940b-5ce3365c5aa1@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <697d8ac2-34ee-db3e-940b-5ce3365c5aa1@arm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, Axel Haslam <ahaslam+renesas@baylibre.com>, devicetree@vger.kernel.org, Marc Titinger <mtitinger+renesas@baylibre.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Brendan Jackman <Brendan.Jackman@arm.com>, Juri Lelli <Juri.Lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 12 2016 at 04:08 -0600, Sudeep Holla wrote:
>
>
>On 11/08/16 22:10, Lina Iyer wrote:
>>On Wed, Aug 10 2016 at 12:09 -0600, Sudeep Holla wrote:
>>>
>
>[...]
>
>>>cluster0
>>>    CLUSTER_RET(Retention)
>>>    CLUSTER_PG(Power Gate)
>>>    core0
>>>        CORE_RET
>>>        CORE_PG
>>>    core1
>>>        CORE_RET
>>>        CORE_PG
>>>
>>>cluster1
>>>    CLUSTER_RET
>>>    CLUSTER_PG
>>>    core0
>>>        CORE_RET
>>>        CORE_PG
>>>    core1
>>>        CORE_RET
>>>        CORE_PG
>>>
>>>Platform Co-ordinate supports the following states and we should be
>>>able to determine that from the binding:
>>>
>>>CORE_RET
>>>CORE_PG
>>>CORE_RET + CLUSTER_RET
>>
>>The problem that we have to sove here is knowing that CORE_RET +
>>CLUSTER_PG (hypothetically) an invalid combination. Kevin and
>>I debated it in the earlier RFC and we dont have a good way to solve
>>this generically for all devices.
>>
>
>Yes, I agree it's complex. But that needs to be solved IMO.
>
>I can think of 2 possible solutions:
>
>1. Index the states(which people have not liked, but as along as we
>   don't use it in the code as it for any other purpose, it should be
>   fine) and then have each state mentioning what parent state can be
>   entered at this child state(i.e. starting index and all states below
>   it)
>
This is how QCOM solved it downstream.

>2. Something similar to (1) but without index instead phandles.
>

The problem is when you have non-CPU devices in the device tree and
since they do not have a way to represent states like CPU, we did not
have a clear path to that. Hence we punted that to later. Whatever we
do, we should solve it for a generic PM domain, not just CPU domains.

Thanks,
Lina

>Again these are just thoughts, others may think of some better
>solution(s). Sorry I haven't followed all the previous threads in detail.
>
>-- 
>Regards,
>Sudeep
