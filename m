From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] x86/ACPI/cstate: Output AMD on APCI C1 FFH MWAIT AMD
 systems
Date: Thu, 9 Aug 2018 07:43:47 -0400
Message-ID: <932b8a78-a7b4-ea8c-a640-b7f657f45b63@redhat.com>
References: <20180808174735.3114-1-prarit@redhat.com>
 <20180808195856.GA20912@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180808195856.GA20912@amd>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 08/08/2018 03:58 PM, Pavel Machek wrote:
> On Wed 2018-08-08 13:47:35, Prarit Bhargava wrote:
>> commit 5209654a46ee ("x86/ACPI/cstate: Allow ACPI C1 FFH MWAIT use on AMD
>> systems") allows use of FFH for ACPI C1 but tools like cpupower and turbostat
>> display INTEL for the cstate description.
>>
>> Output "AMD" for AMD systems with FFH for ACPI C1.
> 
> Um, is it good idea?
>> First, you are changing kernel API.

I thought about that and the AMD support was only added a year ago so I think it
is okay to change.  Secondly, I did a grep for the use of the desc file in the
Fedora sources and only found a few places where the file is referenced.  They
all *report* the data but do not use it to make a decision.

For example, turbostat and cpupower only return the data to the console.

> 
>> @@ -107,9 +108,14 @@ static long acpi_processor_ffh_cstate_probe_cpu(void *_cx)
>>  			"Monitor-Mwait will be used to enter C-%d state\n",
>>  			cx->type);
>>  	}
>> -	snprintf(cx->desc,
>> -			ACPI_CX_DESC_LEN, "ACPI FFH INTEL MWAIT 0x%x",
>> -			cx->address);
>> +	if (c->x86_vendor == X86_VENDOR_INTEL)
>> +		snprintf(cx->desc,
>> +			 ACPI_CX_DESC_LEN, "ACPI FFH INTEL MWAIT 0x%x",
>> +			 cx->address);
>> +	else
>> +		snprintf(cx->desc,
>> +			 ACPI_CX_DESC_LEN, "ACPI FFH AMD MWAIT 0x%x",
>> +			 cx->address);
> 
> Second, I read it as "Intel MWAIT" instruction is used. Yes, AMD cpu can
> use Intel MWAIT, too...

That's true but the weirdness of seeing INTEL on an AMD box there made me push
this patch.

> 
> Third, there are more CPU vendors out there.

Not in this code.  It is AMD & Intel only.  I thought about dropping INTEL, and
also switching to X86.

Should we drop INTEL from the above or not (as suggested later in this thread)?
It feels like everyone is on the fence about it.

P.

> 
> 									Pavel
> 
