Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F6A36DA0D;
	Thu,  2 Apr 2026 08:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775119027; cv=none; b=lbgFX+wFQUtTKp8l+gtTIZS3a3DuAJfIsTZcua3Udzsz3arIHLl9vTUKXDZTl5oOR6IrfIyvFJTYGvfeWR3USPED5AmXR0VjsA8w3BbmjYp2RvJb5WYQnVW6+2KZgZcSLkyaEo+DoPUiqZr7hldRsRcpArD5hcR4kx5mYwN0VuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775119027; c=relaxed/simple;
	bh=SQKns7EEnFXJ1o0WMdx/BfAZfEy54gejHZyvOXBYewI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A4IP17G9AoorRBGY4PnHZpECpffEkHXr0jcV0wr7nGNM0+YEJ143dSpA2ANXVJureyFsmzOWdYXJbNn/i0iqYYwIZ5S1mwr24R8LsjHxzvwFr9t0kH6ZDiw675fhs3Cz+/jlAQoDIRIVbdiDqJx357r656SlfdhOdnn3NqKdkfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=P6SbCk0S; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="P6SbCk0S"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=L9oWu7TNDJmh3cWequCojtagTOEx+jhlOz9G5BmteB4=;
	b=P6SbCk0SapI2pxC0k1TUBdDIUixaz4ct1x3i3a5uUZU64zZaMd37S4s7xv1bMTmBWf8GrV79S
	UoPkM1kW0o4KNQ366BrPyPeZnHCnKLaevrd2WLeSYfEwIY3SJaBSPKg3K83ZqjEtJv59jYlmVFe
	1PkNwOu1fUEiYUi/HqTNQRE=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fmZmz5dg4zKmTd;
	Thu,  2 Apr 2026 16:30:43 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 0ACBD40539;
	Thu,  2 Apr 2026 16:36:56 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 2 Apr
 2026 16:36:55 +0800
Message-ID: <abb63fc9-36dc-43e4-afe3-1a8c33e2da49@huawei.com>
Date: Thu, 2 Apr 2026 16:36:52 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: processor: Add acpi_processor_start() back to parse
 _CPC tables before CPU online
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, <catalin.marinas@arm.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <gshan@redhat.com>, <miguel.luis@oracle.com>,
	<guohanjun@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>, <salil.mehta@huawei.com>, Viresh Kumar
	<viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>
References: <20260120113242.3843463-1-zhenglifeng1@huawei.com>
 <CAJZ5v0hX839+J-MdKUwpRv0D9HSj-sbtMN0o-OOYatu9dU+bFQ@mail.gmail.com>
 <20260127165824.0000247f@huawei.com>
 <CAJZ5v0irPpqEZkCLPmdMU4CxR6ma_j11Z6Nxx8c5fd0aFq9dBw@mail.gmail.com>
 <762300a5-acd8-476d-bc6c-494b912995d3@huawei.com>
 <4257cdb1-c18b-4274-95b4-617f1da76518@huawei.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <4257cdb1-c18b-4274-95b4-617f1da76518@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2/6/2026 5:57 PM, zhenglifeng (A) wrote:
> On 2026/1/29 20:45, zhenglifeng (A) wrote:
>>
>>
>> On 2026/1/28 2:00, Rafael J. Wysocki wrote:
>>> +linux-pm and Viresh
>>>
>>> On Tue, Jan 27, 2026 at 5:58 PM Jonathan Cameron
>>> <jonathan.cameron@huawei.com> wrote:
>>>>
>>>> On Tue, 27 Jan 2026 15:42:16 +0100
>>>> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>>>>
>>>>> On Tue, Jan 20, 2026 at 12:33 PM Lifeng Zheng <zhenglifeng1@huawei.com> wrote:
>>>>>>
>>>>>> Currently, if boot with maxcpus less than NR_CPUS, the cppc_cpufreq driver
>>>>>> will fail to register. Because it requires the domain information of all
>>>>>> possible CPUs to construct shared_cpu_map, which shows the CPUs that share
>>>>>> the same domain.
>>>>>>
>>>>>> Commit c1385c1f0ba3 ("ACPI: processor: Simplify initial onlining to use
>>>>>> same path for cold and hotplug") removes probe() of acpi_processor_driver
>>>>>> and makes acpi_cppc_processor_probe() only being called the first time CPU
>>>>>> goes online. This means that CPUs that haven't yet gone online will not
>>>>>> have pre-parsed _CPC objects and causes cppc_cpufreq driver register fail.
>>>>>>
>>>>>> Add acpi_processor_start() back as the probe() callback of
>>>>>> acpi_processor_driver and call acpi_cppc_processor_probe() in it to make
>>>>>> sure all _CPC tables will be parsed when acpi_processor_driver registered.
>>>>>>
>>>>>> Fixes: c1385c1f0ba3 ("ACPI: processor: Simplify initial onlining to use same path for cold and hotplug")
>>>>>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>>>>>> ---
>>>>>>  drivers/acpi/processor_driver.c | 30 ++++++++++++++++++++++++++----
>>>>>>  1 file changed, 26 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
>>>>>> index 65e779be64ff..c8b4daf580b0 100644
>>>>>> --- a/drivers/acpi/processor_driver.c
>>>>>> +++ b/drivers/acpi/processor_driver.c
>>>>>> @@ -33,6 +33,7 @@ MODULE_AUTHOR("Paul Diefenbaugh");
>>>>>>  MODULE_DESCRIPTION("ACPI Processor Driver");
>>>>>>  MODULE_LICENSE("GPL");
>>>>>>
>>>>>> +static int acpi_processor_start(struct device *dev);
>>>>>>  static int acpi_processor_stop(struct device *dev);
>>>>>>
>>>>>>  static const struct acpi_device_id processor_device_ids[] = {
>>>>>> @@ -46,6 +47,7 @@ static struct device_driver acpi_processor_driver = {
>>>>>>         .name = "processor",
>>>>>>         .bus = &cpu_subsys,
>>>>>>         .acpi_match_table = processor_device_ids,
>>>>>> +       .probe = acpi_processor_start,
>>>>>>         .remove = acpi_processor_stop,
>>>>>>  };
>>>>>>
>>>>>> @@ -162,10 +164,6 @@ static int __acpi_processor_start(struct acpi_device *device)
>>>>>>         if (!pr)
>>>>>>                 return -ENODEV;
>>>>>>
>>>>>> -       result = acpi_cppc_processor_probe(pr);
>>>>>> -       if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
>>>>>> -               dev_dbg(&device->dev, "CPPC data invalid or not present\n");
>>>>>> -
>>>>>>         if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
>>>>>>                 acpi_processor_power_init(pr);
>>>>>>
>>>>>> @@ -192,6 +190,30 @@ static int __acpi_processor_start(struct acpi_device *device)
>>>>>>         return result;
>>>>>>  }
>>>>>>
>>>>>> +static int acpi_processor_start(struct device *dev)
>>>>>> +{
>>>>>> +       struct acpi_device *device = ACPI_COMPANION(dev);
>>>>>> +       struct acpi_processor *pr;
>>>>>> +       int result;
>>>>>> +
>>>>>> +       if (!device)
>>>>>> +               return -ENODEV;
>>>>>> +
>>>>>> +       pr = acpi_driver_data(device);
>>>>>> +       if (!pr)
>>>>>> +               return -ENODEV;
>>>>>> +
>>>>>> +       /* Protect against concurrent CPU hotplug operations */
>>>>>> +       cpu_hotplug_disable();
>>>>>> +       result = acpi_cppc_processor_probe(pr);
>>>>>> +       cpu_hotplug_enable();
>>>>>
>>>>> This means that CPPC will be initialized for vCPUs that are not
>>>>> enabled on ARM if I'm not mistaken.
>>>>
>>>> If we are just talking powered down at boot it used to do that
>>>> so I assume it was fine. The corner case is ones we are explicitly
>>>> saying are not onlineable yet but marked online capable and will
>>>> turn up later.
>>>>
>>>>>
>>>>> I'm not sure if it is valid to do so.
>>>>
>>>> The conclusion of the following is I think this is fine but I'm not
>>>> entirely confident about it.
>>>>
>>>> I'm struggling to figure out the right answer to this and
>>>> it's not easy to test. I vaguely recall having some nasty emulation
>>>> hacks to poke some x86 related _CPC stuff a while back.
>>>> I might be able to hack something up for this as well and try to
>>>> create pathological corner cases.
>>>>
>>>> The short answer is CPPC + hotplug isn't a thing today in KVM + QEMU,
>>>> but that's not to say it never will be if someone virtualizes CPC for
>>>> a guest.  Let's consider that hypothetical virtualization / emulation.
>>>>
>>>> So the questions:
>>>> 1) Does simply making this acpi_cppc_processor_probe() result in any
>>>>    register accesses to the registers that might be found in _CPC or
>>>>    used via other ACPI methods?
>>>> 2) Can we rely on a a VMM not do something nasty if those are accessed
>>>>    on CPUs that haven't been instantiated yet?  e.g. Bus error.
>>>>    A related useful question is: Can we assume these registers are
>>>>    accessible on offlined CPUs?  If they can be unsafe to access from
>>>>    CPUs that are temporary powered down / offline then I think we are fine because
>>>>    the CPPC code must guarantee not to access them. (I'm relying on this!)
>>>>
>>>> For the particular case Lifeng has run into, I think the code that matters
>>>> (beyond instantiation of the infrastructure) is the creation of the
>>>> domain info in acpi_get_psd(). I think _PSD can only be static data so
>>>> shouldn't cause any register accesses to the powered down CPUs.
>>>>
>>>> So 'probably' fine + we'll not really know unless we get CPU HP and
>>>> CPC.
>>>>
>>>> Alternative much more complex change would be to separate the grabbing of
>>>> static data (done here) from setting up anything dynamic which would remain
>>>> in the hotplug handler.  If those registers haven't been discovered we definitely
>>>> can't access them from the cpu freq driver.
>>>
>>> I'm thinking that maybe cppc_cpufreq should be updated instead.
>>>
>>> I'm not really sure why it needs to collect information on offline
>>> CPUs.  Surely, they don't matter until they are brought online.
>>
>> This information is collected in order to generate related_cpus. Without
>> doing so, a new policy will be created when the second CPU in the same
>> domain comes online, instead of reusing the existing policy. And this will
>> make a mess.
>>
>> I can't find a good way to solve this problem in cppc_cpufreq or cpufreq.
> 
> Hi Rafael,
> 
> If we have to make sure not to use the information on offline CPUs, there
> will be many things that need to be modified:
> 
> 1. acpi_get_psd_map() in cppc_acpi.c: only use the information on online
> CPUs, and update shared_cpu_map when a new CPU in the same domain goes
> online.
> 
> 2. cpufreq_online() in cpufreq.c: create a new policy and decide whether it
> should be kept because it may turns out that the CPU should share an
> already exist policy with other CPUs.
> 
> 3. The init() callbacks in cppc_cpufreq, acpi-cpufreq and maybe other
> drivers: verify whether the newly generated policy is necessary and return
> the result.
> 
> ...
> 
> Is it necessary to make such a big change for solving this problem? It
> seems to me that it is reasonable and fewer changes to parse the _CPC table
> for all CPUs in advance because it never change, isn't it?
> 

Hi Rafael,

Although some time has passed, I still look forward to your advice.

Thanks.

