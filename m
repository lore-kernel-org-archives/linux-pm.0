From: Shuah Khan <shuahkhan@gmail.com>
Subject: Re: [PATCH] ACPI / PNP: Do not crash due to stale pointer use during
 system resume
Date: Thu, 29 Nov 2012 16:50:20 -0700
Message-ID: <CAKocOONs0M9R7tpF8k3J6AOptXwmrmWn9KwN9sgdxMKoB2pY8A@mail.gmail.com>
References: <1829835.4TBEQGhjkq@vostro.rjw.lan>
	<CAKocOOOsOZ=g45cdFSZZoCVMBxf9aWNSa4RdGNCuAEKrxXkr1Q@mail.gmail.com>
	<28227702.6DTxM78Dej@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <28227702.6DTxM78Dej@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 29, 2012 at 4:51 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday, November 29, 2012 04:25:20 PM Shuah Khan wrote:
>> On Thu, Nov 29, 2012 at 4:10 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >
>> > During resume from system suspend the 'data' field of
>> > struct pnp_dev in pnpacpi_set_resources() may be a stale pointer,
>> > due to removal of the associated ACPI device node object in the
>> > previous suspend-resume cycle.  This happens, for example, if a
>> > dockable machine is booted in the docking station and then suspended
>> > and resumed and suspended again.  If that happens,
>> > pnpacpi_build_resource_template() called from pnpacpi_set_resources()
>> > attempts to use that pointer and crashes.
>> >
>> > However, pnpacpi_set_resources() actually checks the device's ACPI
>> > handle, attempts to find the ACPI device node object attached to it
>> > and returns an error code if that fails, so in fact it knows what the
>> > correct value of dev->data should be.  Use this observation to update
>> > dev->data with the correct value if necessary and dump a call trace
>> > if that's the case (once).
>> >
>> > We still need to fix the root cause of this issue, but preventing
>> > systems from crashing because of it is an improvement too.
>> >
>> > Reported-and-tested-by: Zdenek Kabelac <zdenek.kabelac@gmail.com>
>> > References: https://bugzilla.kernel.org/show_bug.cgi?id=51071
>> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Any reason why this shouldn't go into stable releases?
>
> Yes, it can go to -stable.  This is just a patch, not a git commit.  I can
> still add the "stable" tag to it when it goes to git. :-)
>

Good. This patch applies just fine to 3.0.x, 3.4.x and 3.6.x for what
its worth. That's how far I have gotten so far and getting ready to do
compile tests on these.

-- Shuah
