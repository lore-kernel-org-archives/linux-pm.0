From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 5/9] drivers: base: cacheinfo: arm64: Add support for
 ACPI based firmware tables
Date: Mon, 20 Nov 2017 18:14:15 +0000
Message-ID: <c4f8dd3a-75ee-242e-e499-d85710e91b78@arm.com>
References: <20171109210311.25655-1-jeremy.linton@arm.com>
 <20171109210311.25655-6-jeremy.linton@arm.com>
 <20171120165642.GA31395@e107155-lin>
 <e1f2bdcc-e0fa-67d5-d4fe-7077b166988f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <e1f2bdcc-e0fa-67d5-d4fe-7077b166988f@arm.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, devel@acpica.org
List-Id: linux-pm@vger.kernel.org



On 20/11/17 18:02, Jeremy Linton wrote:
> On 11/20/2017 10:56 AM, Sudeep Holla wrote:
> 
> (trimming)
> 
>>> *    case there's no explicit cache node or the cache node
>>> itself in the *    device tree + * @firmware_node: Shared with
>>> of_node. When not using DT, this may contain + *    pointers to
>>> other firmware based values. Particularly ACPI/PPTT + *    unique
>>> values. * @disable_sysfs: indicates whether this node is visible
>>> to the user via *    sysfs or not * @priv: pointer to any private
>>> data structure specific to particular @@ -64,8 +67,10 @@ struct
>>> cacheinfo { #define CACHE_ALLOCATE_POLICY_MASK    \ 
>>> (CACHE_READ_ALLOCATE | CACHE_WRITE_ALLOCATE) #define CACHE_ID
>>> BIT(4) - -    struct device_node *of_node; +    union { +
>>> struct device_node *of_node; +        void *firmware_node; +
>>> };
>> 
>> I would prefer struct device_node *of_node; changed to struct
>> fwnode_handle *fwnode;
>> 
>> You can then have struct pptt_fwnode { <.....> /*below fwnode
>> allocated using acpi_alloc_fwnode_static */ struct fwnode_handle
>> *fwnode; };
>> 
>> This gives a good starting point to abstract DT and ACPI.
>> 
>> If not now, we can later implement fwnode.ops=pptt_cache_ops and
>> then use get property for both DT and ACPI.
> 
> 
> I'm obviously confused why this keeps coming up. On the surface it 
> sounds like a good idea. But then, given that I've actually
> implemented a portion of it, what becomes clear is that the PPTT
> isn't a good match.

Fair enough.

> Converting the OF routines to use the fwnode is fairly
> straightforward, but that doesn't help the ACPI situation other than
> to create a lot of misleading code (and the possibility of creating
> nonstandard DSDT entries). The fact that this hasn't been done for
> other tables MADT/SLIT/SRAT/etc makes me wonder why we should do it
> for the PPTT?
> 

IRQ/IORT does use it. If we don't want to use it fine. But the union
doesn't make sense and breaks the flow many other subsystems follow.
Hence I raised. Sorry, I hadn't followed the last revision/discussion on
this, my bad. But I had this thought since the beginning, hence I
brought this up.

> Particularly, when one considers fwnode is more a DSDT<->DT
> abstraction and thus has a lot of API surface that simply doesn't
> make any sense given the PPTT binary tree structure. Given that most
> of the fwnode routines are translating string properties (for
> example fwnode_property_read_string()) it might be possible to build
> a translator of some form which takes DT style properties and
> attempts to map them to the ACPI PPTT tree. What this adds I can't
> fathom, beyond the fact that suddenly the fwnode interface is a
> partial/brittle implementation where a large subset of the
> fwnode_operations will tend to be degenerate cases. The result likely
> will be a poorly implemented translator which breaks or is
> meaningless over a large part of the fwnode API surface.

Sure, I just mentioned ops thing, but that's optional. I just didn't
like the union which has of_node and void ptr instead of fwhandle. I am
fine if many agree that it's bad idea to use fwhandle here.

-- 
Regards,
Sudeep

-- 
Regards,
Sudeep
