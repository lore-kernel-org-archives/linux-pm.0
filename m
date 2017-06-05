From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: suspend-to-mem broken by eed4d47efe95 (ACPI / sleep: Ignore
 spurious SCI wakeups from suspend-to-idle)
Date: Mon, 5 Jun 2017 22:32:15 +0200
Message-ID: <CAJZ5v0h6U-JvnU03vhNz2zV1EGB8fV8zauBTGogOnxuvv0TonQ@mail.gmail.com>
References: <20170605090521.GA1912@light.dominikbrodowski.net>
 <21111815.riZgbS9lI9@aspire.rjw.lan> <20170605150915.GA1627@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170605150915.GA1627@light.dominikbrodowski.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 5, 2017 at 5:09 PM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> On Mon, Jun 05, 2017 at 03:08:57PM +0200, Rafael J. Wysocki wrote:
>> On Monday, June 05, 2017 11:05:21 AM Dominik Brodowski wrote:
>> > unfortunately, commit eed4d47efe95 (ACPI / sleep: Ignore spurious SCI
>> > wakeups from suspend-to-idle) breaks suspend-to-mem on my Dell XPS 13
>> > (9343) up to v4.12-rc4: Issuing
>> >
>> >     $ echo "mem" > /sys/power/state
>> >
>> > in the initramfs returns, after a while, with "write error: Resource
>> > busy", and the system *not* having entered the sleep state in between.
>>
>> Why initramfs?
>
> Easiest and quickest to test, with no userspace in between to interfere.
> During normal operations, I see suspend-to-mem fail, then a fall-back to
> s2idle...

I see, OK.

>> > In contrast thereto, 8a537ece3d94 (PM / wakeup: Integrate mechanism to abort
>> > transitions in progress) still works fine, and allows to enter
>> > suspend-to-mem. No real difference is to be seen in dmesg, with the notable
>> > exception of
>> >
>> >     ACPI: Low-level resume complete
>> >     ACPI : EC: EC started
>> >     PM: Restoring platform NVS memory
>> >     Suspended for N.NNNN seconds
>> >
>> > only showing up on working kernels. Reverting eed4d47efe95 on top of
>> > v4.12-rc4 restores suspend-to-mem to work as expected.
>>
>> I'm sure it is not necessary to revert all of it.
>
> Thought so, just wanted to confirm that eed4d47efe95 is indeed the culprit.
>
>> I guess what happens is that you get a wakeup event during suspend which is
>> aborted as a result.
>>
>> Please apply the partial revert below and see if it makes the issue go away.
>
> Yes it does -- with this patch applied on top of v4.12-rc4, everything works
> as expected. Both in initramfs and during normal runtime operations. Only an
> (probably unrelated) issue still appears during resume, namely "cache"
> complaining that the non-boot CPUs should not be sleeping:

That's unrelated.

OK, this still leaves us with three possibilities.

Can you please try to apply the device_pm.c part of the partial revert
alone and see if that helps (and if not, same for the button.c and
battery.c changes)?

Thanks,
Rafael
