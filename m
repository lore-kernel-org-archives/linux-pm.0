From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 10/11] cpuidle/powernv: Add support for POWER ISA v3
 idle states
Date: Wed, 15 Jun 2016 10:27:25 +0530
Message-ID: <5760E035.4070103@linux.vnet.ibm.com>
References: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com> <1465404871-5406-11-git-send-email-shreyas@linux.vnet.ibm.com> <20160613153446.GF10634@linaro.org>	 <575FE0B0.4030309@linux.vnet.ibm.com> <1465903788.30200.8.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465903788.30200.8.camel@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: ego@linux.vnet.ibm.com, mikey@neuling.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, maddy@linux.vnet.ibm.com, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org



On 06/14/2016 04:59 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2016-06-14 at 16:17 +0530, Shreyas B Prabhu wrote:
> 
>>
>> I ignored adding this check because this is part of initcall and we are
>> unlikely to run out of memory at this state. But I'll add the check in
>> next version.
> 
> Why do you malloc the u64 array and not the string pointer array ?
> Shouldn't you either have both on stack or both allocated ?
> 

Yes. I'll make this consistent.

Thanks,
Shreyas
