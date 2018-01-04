From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Subject: Re: [PATCH v5 7/9] arm64: Topology, rename cluster_id
Date: Thu, 4 Jan 2018 12:14:17 +0800
Message-ID: <1f475770-0d0f-402a-ccf9-87c635b3cb64@huawei.com>
References: <20171201222330.18863-1-jeremy.linton@arm.com>
 <20171201222330.18863-8-jeremy.linton@arm.com>
 <20171213180217.GB4060@red-moon>
 <7bb4e955-f3e5-d22f-4e78-eac97e66a9a6@arm.com>
 <20171218124229.GG507@e105550-lin.cambridge.arm.com>
 <965127a6-816b-8e0c-d228-a3d73a8c643a@huawei.com>
 <20180103142934.GA5390@e107155-lin>
 <4ac912cf-927d-5482-9ceb-b497a547fc2e@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4ac912cf-927d-5482-9ceb-b497a547fc2e@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jeremy Linton <jeremy.linton@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Morten Rasmussen <morten.rasmussen@foss.arm.com>
Cc: mark.rutland@arm.com, Jonathan.Zhang@cavium.com, Jayachandran.Nair@cavium.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, austinwc@codeaurora.org, gregkh@linuxfoundation.org, jhugo@codeaurora.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, morten.rasmussen@arm.com, linux-acpi@vger.kernel.org, viresh.kumar@linaro.org, hanjun.guo@linaro.org, catalin.marinas@arm.com, dietmar.eggemann@arm.com, ahs3@redhat.com, linux-arm-kernel@lists.infradead.org, lenb@kernel.org
List-Id: linux-pm@vger.kernel.org



On 2018/1/4 1:32, Jeremy Linton wrote:
> Hi,
> 
> On 01/03/2018 08:29 AM, Sudeep Holla wrote:
>>
>> On 02/01/18 02:29, Xiongfeng Wang wrote:
>>> Hi,
>>>
>>> On 2017/12/18 20:42, Morten Rasmussen wrote:
>>>> On Fri, Dec 15, 2017 at 10:36:35AM -0600, Jeremy Linton wrote:
>>>>> Hi,
>>>>>
>>>>> On 12/13/2017 12:02 PM, Lorenzo Pieralisi wrote:
>>>>>> [+Morten, Dietmar]
>>>>>>
>>>>>> $SUBJECT should be:
>>>>>>
>>>>>> arm64: topology: rename cluster_id
>>>>>
>>> [cut]
>>>>>
>>> I think we still need the information describing which cores are in one
>>> cluster. Many arm64 chips have the architecture core/cluster/socket. Cores
>>> in one cluster may share a same L2 cache. That information can be used to
>>> build the sched_domain. If we put cores in one cluster in one sched_domain,
>>> the performance will be better.(please see kernel/sched/topology.c:1197,
>>> cpu_coregroup_mask() uses 'core_sibling' to build a multi-core
>>> sched_domain).
>>
>> We get all the cache information from DT/ACPI PPTT(mainly topology) and now
>> even the geometry. So ideally, the sharing information must come from that.
>> Any other solution might end up in conflict if DT/PPTT and that mismatch.

Sorry, I didn't express myself clearly. There may be some misunderstanding above.
I mean that PPTT report the cores topology, such as a level of the topology tree maybe  cores in one cluster,
another level maybe cores in one package.
We not only need variable in 'struct topology' to record which cores are in one package,
but also need variable to record which cores are in one cluster.
>>
>>> So I think we still need variable to record which cores are in one
>>> sched_domain for future use.
>>
>> I tend to say no, at-least not as is.
>>
> 
> Well, either way, with DynamiQ (and a55/a75) the cores have private L2's, which means that the cluster sharing is happening at what is then the L3 level. So, the code I had in earlier versions would have needed tweaks to deal with that anyway.
> 
> IMHO, if we want to detect this kind of sharing for future scheduling domains, it should probably be done independent of PPTT/DT/MIPDR by picking out shared cache levels from struct cacheinfo *. Which makes that change unrelated to the basic population of cacheinfo and cpu_topology in this patchset.
> 
> 
> .
> 
