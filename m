From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v5 7/9] arm64: Topology, rename cluster_id
Date: Wed, 3 Jan 2018 14:29:34 +0000
Message-ID: <20180103142934.GA5390@e107155-lin>
References: <20171201222330.18863-1-jeremy.linton@arm.com>
 <20171201222330.18863-8-jeremy.linton@arm.com>
 <20171213180217.GB4060@red-moon>
 <7bb4e955-f3e5-d22f-4e78-eac97e66a9a6@arm.com>
 <20171218124229.GG507@e105550-lin.cambridge.arm.com>
 <965127a6-816b-8e0c-d228-a3d73a8c643a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751364AbeACO3p (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Jan 2018 09:29:45 -0500
Content-Disposition: inline
In-Reply-To: <965127a6-816b-8e0c-d228-a3d73a8c643a@huawei.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Xiongfeng Wang <wangxiongfeng2@huawei.com>, Morten Rasmussen <morten.rasmussen@foss.arm.com>, Jeremy Linton <jeremy.linton@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hanjun.guo@linaro.org, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com


On 02/01/18 02:29, Xiongfeng Wang wrote:
> Hi,
> 
> On 2017/12/18 20:42, Morten Rasmussen wrote:
>> On Fri, Dec 15, 2017 at 10:36:35AM -0600, Jeremy Linton wrote:
>>> Hi,
>>>
>>> On 12/13/2017 12:02 PM, Lorenzo Pieralisi wrote:
>>>> [+Morten, Dietmar]
>>>>
>>>> $SUBJECT should be:
>>>>
>>>> arm64: topology: rename cluster_id
>>>
> [cut]
>>>
> I think we still need the information describing which cores are in one
> cluster. Many arm64 chips have the architecture core/cluster/socket. Cores
> in one cluster may share a same L2 cache. That information can be used to
> build the sched_domain. If we put cores in one cluster in one sched_domain,
> the performance will be better.(please see kernel/sched/topology.c:1197,
> cpu_coregroup_mask() uses 'core_sibling' to build a multi-core
> sched_domain).

We get all the cache information from DT/ACPI PPTT(mainly topology) and now
even the geometry. So ideally, the sharing information must come from that.
Any other solution might end up in conflict if DT/PPTT and that mismatch.

> So I think we still need variable to record which cores are in one
> sched_domain for future use.

I tend to say no, at-least not as is.
-- 
Regards,
Sudeep
