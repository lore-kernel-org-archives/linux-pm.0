From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v5 7/9] arm64: Topology, rename cluster_id
Date: Thu, 4 Jan 2018 12:00:35 -0600
Message-ID: <fc613efc-7eb6-3688-2036-3d7252f80c41@arm.com>
References: <20171201222330.18863-1-jeremy.linton@arm.com>
 <20171201222330.18863-8-jeremy.linton@arm.com>
 <20171213180217.GB4060@red-moon>
 <7bb4e955-f3e5-d22f-4e78-eac97e66a9a6@arm.com>
 <20171218124229.GG507@e105550-lin.cambridge.arm.com>
 <965127a6-816b-8e0c-d228-a3d73a8c643a@huawei.com>
 <20180103142934.GA5390@e107155-lin>
 <4ac912cf-927d-5482-9ceb-b497a547fc2e@arm.com>
 <e59f197d-eff9-9429-6e3b-519aeac354fc@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <e59f197d-eff9-9429-6e3b-519aeac354fc@huawei.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Xiongfeng Wang <wangxiongfeng2@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Morten Rasmussen <morten.rasmussen@foss.arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hanjun.guo@linaro.org, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

Hi,

On 01/03/2018 09:59 PM, Xiongfeng Wang wrote:
> 
> 
> On 2018/1/4 1:32, Jeremy Linton wrote:
>> Hi,
>>
>> On 01/03/2018 08:29 AM, Sudeep Holla wrote:
>>>
>>> On 02/01/18 02:29, Xiongfeng Wang wrote:
>>>> Hi,
>>>>
>>>> On 2017/12/18 20:42, Morten Rasmussen wrote:
>>>>> On Fri, Dec 15, 2017 at 10:36:35AM -0600, Jeremy Linton wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 12/13/2017 12:02 PM, Lorenzo Pieralisi wrote:
>>>>>>> [+Morten, Dietmar]
>>>>>>>
>>>>>>> $SUBJECT should be:
>>>>>>>
>>>>>>> arm64: topology: rename cluster_id
>>>>>>
>>>> [cut]
>>>>>>
>>>> I think we still need the information describing which cores are in one
>>>> cluster. Many arm64 chips have the architecture core/cluster/socket. Cores
>>>> in one cluster may share a same L2 cache. That information can be used to
>>>> build the sched_domain. If we put cores in one cluster in one sched_domain,
>>>> the performance will be better.(please see kernel/sched/topology.c:1197,
>>>> cpu_coregroup_mask() uses 'core_sibling' to build a multi-core
>>>> sched_domain).
>>>
>>> We get all the cache information from DT/ACPI PPTT(mainly topology) and now
>>> even the geometry. So ideally, the sharing information must come from that.
>>> Any other solution might end up in conflict if DT/PPTT and that mismatch.
>>>
>>>> So I think we still need variable to record which cores are in one
>>>> sched_domain for future use.
>>>
>>> I tend to say no, at-least not as is.
>>>
>>
>> Well, either way, with DynamiQ (and a55/a75) the cores have private L2's, which means that the cluster sharing is happening at what is then the L3 level. So, the code I had in earlier versions would have needed tweaks to deal with that anyway.
>>
>> IMHO, if we want to detect this kind of sharing for future scheduling domains, it should probably be done independent of PPTT/DT/MIPDR by picking out shared cache levels from struct cacheinfo *. Which makes that change unrelated to the basic population of cacheinfo and cpu_topology in this patchset.
>>
> I think we need to build scheduling domains not only on the cache-sharing information,
> but also some other information, such as which cores use the same cache coherent interconnect
> (I don't know the detail, I just guess)
> 
> I think PPTT is used to report the cores topology, which cores are more related to each other.
> They may share the same cache, or use the same CCI, or are physically near to each other.
> I think we should use this information to build  MC(multi-cores) scheduling domains.
> 
> Or maybe  we can just discard the MC scheduling domain and handle this scheduling-domain-building
> task to the NUMA subsystem entirely, I don't know if it is proper.


For the immediate future what I would like is a way to identify where in 
the PPTT topology the NUMA domains begin (rather than assuming socket, 
which is the current plan). That allows the manufactures of systems 
(with say say MCM based topologies) to dictate at which level in the 
cpu/cache topology they want to start describing the topology with the 
SLIT/SRAT tables. I think that moves us in the direction you are 
indicating while still leaving the door open for something like a 
cluster level scheduling domain (based on cores sharing caches) or a 
split LLC domain (also based on cores sharing caches) that happens to be 
on die...





