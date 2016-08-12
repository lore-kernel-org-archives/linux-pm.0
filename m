From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 02/15] dt/bindings: Update binding for PM domain idle
 states
Date: Fri, 12 Aug 2016 11:08:11 +0100
Message-ID: <697d8ac2-34ee-db3e-940b-5ce3365c5aa1@arm.com>
References: <1470351902-43103-1-git-send-email-lina.iyer@linaro.org>
 <1470351902-43103-3-git-send-email-lina.iyer@linaro.org>
 <99e35b6c-6698-6d27-f4d7-fa032796869e@arm.com>
 <20160810164034.GA1401@linaro.org>
 <5e59874c-bbb7-270a-199c-da1ff5932554@arm.com>
 <20160811211023.GC1401@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160811211023.GC1401@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, khilman@kernel.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, Axel Haslam <ahaslam+renesas@baylibre.com>, Marc Titinger <mtitinger+renesas@baylibre.com>, Brendan Jackman <Brendan.Jackman@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, andy.gross@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org



On 11/08/16 22:10, Lina Iyer wrote:
> On Wed, Aug 10 2016 at 12:09 -0600, Sudeep Holla wrote:
>>

[...]

>> cluster0
>>     CLUSTER_RET(Retention)
>>     CLUSTER_PG(Power Gate)
>>     core0
>>         CORE_RET
>>         CORE_PG
>>     core1
>>         CORE_RET
>>         CORE_PG
>>
>> cluster1
>>     CLUSTER_RET
>>     CLUSTER_PG
>>     core0
>>         CORE_RET
>>         CORE_PG
>>     core1
>>         CORE_RET
>>         CORE_PG
>>
>> Platform Co-ordinate supports the following states and we should be
>> able to determine that from the binding:
>>
>> CORE_RET
>> CORE_PG
>> CORE_RET + CLUSTER_RET
>
> The problem that we have to sove here is knowing that CORE_RET +
> CLUSTER_PG (hypothetically) an invalid combination. Kevin and
> I debated it in the earlier RFC and we dont have a good way to solve
> this generically for all devices.
>

Yes, I agree it's complex. But that needs to be solved IMO.

I can think of 2 possible solutions:

1. Index the states(which people have not liked, but as along as we
    don't use it in the code as it for any other purpose, it should be
    fine) and then have each state mentioning what parent state can be
    entered at this child state(i.e. starting index and all states below
    it)

2. Something similar to (1) but without index instead phandles.

Again these are just thoughts, others may think of some better
solution(s). Sorry I haven't followed all the previous threads in detail.

-- 
Regards,
Sudeep
