From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [Patch v2] x86, ACPI, irq: Add a quirk to override SCI polarity
 for HyperV
Date: Wed, 19 Aug 2015 17:05:55 +0800
Message-ID: <55D446F3.7000500@linux.intel.com>
References: <alpine.DEB.2.11.1508182133010.3873@nanos>
 <1439963634-12006-1-git-send-email-jiang.liu@linux.intel.com>
 <CAJZ5v0g7F+BRMzc9-uuxHAK896B-hoOJ5AW7M4jGpowVG+hujw@mail.gmail.com>
 <55D42185.1000709@linux.intel.com>
 <CAJZ5v0gqAX+OEqKPK4b6nz4wpO=HScocTdBqzQsE=ikhA-rcwQ@mail.gmail.com>
 <55D427D3.7040103@linux.intel.com> <alpine.DEB.2.11.1508191025000.3873@nanos>
 <alpine.DEB.2.11.1508191039470.3873@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1508191039470.3873@nanos>
Sender: linux-acpi-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Nick Meier <nmeier@microsoft.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2015/8/19 16:40, Thomas Gleixner wrote:
> On Wed, 19 Aug 2015, Thomas Gleixner wrote:
>> On Wed, 19 Aug 2015, Jiang Liu wrote:
>>> On 2015/8/19 14:45, Rafael J. Wysocki wrote:
>>>> Well, the regression at hand has just shown that the assertion in the
>>>> changelog of that commit ("no need for for special treatment for GSI
>>>> used by ACPI SCI") does not really hold.  So, if the only motivation
>>>> for it was to get rid of one extra check in mp_unregister_gsi()
>>>> (mp_register_gsi() still needs to check if it is dealing with the SCI
>>>> anyway), I'd vote for reverting it.
>>> Hi Rafael,
>>> 	The motivation is to treat SCI as normal IOAPIC interrupt so
>>> we could enforce stricter pin attribute checking. Now it does reveal
>>> flaws in ACPI BIOS implementations, but we ran into trouble about how to
>>> handle those flaws:(
>>
>> The intent of this change is entirely correct, though it seems that
>> reality of ACPI is just different.
>>
>> To be on the safe side of things, I agree with Rafael that we should
>> revert that patch instead of introducing a single platform quirk.
> 
> Jiang,
> 
> can you please prepare a revert patch for this?
Sure, will send out revert patch after basic tests.
