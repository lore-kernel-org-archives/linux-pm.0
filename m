From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [Patch v3] ACPI, PCI: Penalize legacy IRQ used by ACPI SCI
Date: Wed, 26 Aug 2015 22:22:56 +0200
Message-ID: <CAJZ5v0ig2dbGtm6Td+kEw6H=ufwZTd4TWPdtUGFXgPbRJKTtPw@mail.gmail.com>
References: <alpine.DEB.2.11.1508201247370.3873@nanos>
	<1440142584-22404-1-git-send-email-jiang.liu@linux.intel.com>
	<alpine.DEB.2.11.1508241957590.15006@nanos>
	<55DD2791.3020905@intel.com>
	<alpine.DEB.2.11.1508261127060.15006@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1508261127060.15006@nanos>
Sender: linux-acpi-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Aaron Lu <aaron.lu@intel.com>, Jiang Liu <jiang.liu@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Nick Meier <nmeier@microsoft.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 26, 2015 at 11:27 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 26 Aug 2015, Aaron Lu wrote:
>> On 08/25/2015 04:01 PM, Thomas Gleixner wrote:
>> > On Fri, 21 Aug 2015, Jiang Liu wrote:
>> >> ---
>> >> Hi Nick,
>> >>    Rafael and Thomas have concerns about the way to solve the
>> >> regression by quirk, so could you please help to test this patch?
>> >
>> > Nick, can you please confirm that this works?
>>
>> I saw Nick said this in bugzilla:
>> "
>> Tested the v3 patch - it works in a Hyper-V environment.  The Tulip driver loads and the NIC was successfully assigned an IP address via DHCP.
>
> Rafael, can you take it via the ACPI tree?

I'll do that.

Thanks,
Rafael
