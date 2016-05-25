From: Linda Knippers <linda.knippers@hpe.com>
Subject: Re: Enforce _PPC limits
Date: Wed, 25 May 2016 13:18:47 -0400
Message-ID: <b68cfb3a-adfa-2ac6-c920-6bb928e4b275@hpe.com>
References: <21572dff-ea5d-c0f3-6f48-66c9d38eda65@hpe.com>
 <1464127905.4603.11.camel@linux.intel.com>
 <cef22f9e-d60e-2065-e8a6-74c43e9b78f7@hpe.com>
 <1464195689.26461.63.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from g1t6225.austin.hp.com ([15.73.96.126]:53960 "EHLO
	g1t6225.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbcEYRSv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 May 2016 13:18:51 -0400
Received: from g1t6220.austin.hp.com (g1t6220.austin.hp.com [15.73.96.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g1t6225.austin.hp.com (Postfix) with ESMTPS id 023D3503E
	for <linux-pm@vger.kernel.org>; Wed, 25 May 2016 17:18:50 +0000 (UTC)
In-Reply-To: <1464195689.26461.63.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Srinivas,

On 5/25/2016 1:01 PM, Srinivas Pandruvada wrote:
> Hi Linda,
> 
> [...]
> 
>> I guess I've lost track of what intel_pstate is doing these
>> days.  When it
>> first came out, it totally disregarded ACPI information, which is why
>> code
>> was added to not load the driver on some platforms that are doing
>> their
>> own power management.  The rationale for not using ACPI was that ACPI
>> couldn't express all the information necessary to describe the
>> hardware
>> capabilities.
>>
>> Now it is using ACPI information for some things, but not all things?
>> Perhaps intel_pstate.txt could be updated to clarify that?
>>  Depending
>> on what the future is for intel_pstate and ACPI, I'm wondering if
>> that
>> vendor-specific code is no longer needed.
>>
>> This might be a nit but I'm also confused about whether it's really
>> enforcing _PPC limits or _PSS.  Are you actually limiting based on
>> the _PPC value?
> _PPC is an index into _PSS, the max frequency we will get from _PSS. We
> are not enforcing any limits in _PSS. So if some P-State is missing in
> _PSS, we will still select that P-State.
> I don't know what vendor specific code does. I guess it does more than
> just what acpi-cpufreq would have done.

The vendor specific code just prevents intel-pstate from running on systems
that don't expose the p-states through ACPI.  For HP ProLiant, we don't
populate _PSS if the firmware is configured to do the power management and
in that case, we didn't want intel_pstate also doing power management.
Oracle does something similar but different.

With apci-cpufreq, if there is no p-state information exposed through ACPI,
the driver doesn't run so there is no conflict.

>From what you said, we probably still need the vendor-specific code.

> I will check on the documentation part.

Thanks,

-- ljk
> 
> Thanks,
> Srinivas
> 
> 
