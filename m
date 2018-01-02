From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Subject: Re: [PATCH v5 7/9] arm64: Topology, rename cluster_id
Date: Tue, 2 Jan 2018 10:29:35 +0800
Message-ID: <965127a6-816b-8e0c-d228-a3d73a8c643a@huawei.com>
References: <20171201222330.18863-1-jeremy.linton@arm.com>
 <20171201222330.18863-8-jeremy.linton@arm.com>
 <20171213180217.GB4060@red-moon>
 <7bb4e955-f3e5-d22f-4e78-eac97e66a9a6@arm.com>
 <20171218124229.GG507@e105550-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171218124229.GG507@e105550-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@foss.arm.com>, Jeremy Linton <jeremy.linton@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

Hi,

On 2017/12/18 20:42, Morten Rasmussen wrote:
> On Fri, Dec 15, 2017 at 10:36:35AM -0600, Jeremy Linton wrote:
>> Hi,
>>
>> On 12/13/2017 12:02 PM, Lorenzo Pieralisi wrote:
>>> [+Morten, Dietmar]
>>>
>>> $SUBJECT should be:
>>>
>>> arm64: topology: rename cluster_id
>>
[cut]
>>
>> I was hoping someone else would comment here, but my take at this point is
>> that it doesn't really matter in a functional sense at the moment.
>> Like the chiplet discussion it can be the subject of a future patch along
>> with the patches which tweak the scheduler to understand the split.
>>
>> BTW, given that i'm OoO next week, and the following that are the holidays,
>> I don't intend to repost this for a couple weeks. I don't think there are
>> any issues with this set.
>>
>>>
>>> There is also arch/arm to take into account, again, this patch is
>>> just renaming (as it should have named since the beginning) a
>>> topology level but we should consider everything from a legacy
>>> perspective.
> 
> arch/arm has gone for thread/core/socket for the three topology levels
> it supports.
> 
> I'm not sure what short term value keeping cluster_id has? Isn't it just
> about where we make the package = cluster assignment? Currently it is in
> the definition of topology_physical_package_id. If we keep cluster_id
> and add package_id, it gets moved into the MPIDR/DT parsing code. 
> 
> Keeping cluster_id and introducing a topology_cluster_id function could
> help cleaning up some of the users of topology_physical_package_id that
> currently assumes package_id == cluster_id though.

I think we still need the information describing which cores are in one cluster.
Many arm64 chips have the architecture core/cluster/socket. Cores in one cluster may
share a same L2 cache. That information can be used to build the sched_domain. If we put
cores in one cluster in one sched_domain, the performance will be better.(please see
kernel/sched/topology.c:1197, cpu_coregroup_mask() uses 'core_sibling' to build a multi-core
sched_domain)
So I think we still need variable to record which cores are in one sched_domain for future use.

Thanks,
Xiongfeng

> 
> Morten
> 
> .
> 

