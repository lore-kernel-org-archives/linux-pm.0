From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/2] PM / sleep: Support for using suspend-to-idle by default
Date: Thu, 17 Nov 2016 22:05:08 +0100
Message-ID: <CAJZ5v0g-eOciw_3PZBvaHPzh8sMpe0Fbx6RmCTiS1Nax=Bxh3w@mail.gmail.com>
References: <9316960.49SRRJV8RJ@vostro.rjw.lan> <71203ae1bfe54eb39d79c54b51ba7ae8@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36338 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbcKQVFK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Nov 2016 16:05:10 -0500
In-Reply-To: <71203ae1bfe54eb39d79c54b51ba7ae8@ausx13mpc120.AMER.DELL.COM>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mario Limonciello <Mario.Limonciello@dell.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>

On Thu, Nov 17, 2016 at 9:40 PM,  <Mario.Limonciello@dell.com> wrote:
> Hi Rafael,
>
>> -----Original Message-----
>> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
>> Sent: Wednesday, November 16, 2016 8:19 PM
>> To: Linux PM list <linux-pm@vger.kernel.org>
>> Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>; Len Brown
>> <len.brown@intel.com>; Linux Kernel Mailing List <linux-
>> kernel@vger.kernel.org>; Limonciello, Mario
>> <Mario_Limonciello@Dell.com>; Andy Lutomirski <luto@kernel.org>
>> Subject: [PATCH 0/2] PM / sleep: Support for using suspend-to-idle by
>> default
>>
>> Hi,
>>
>> This series is a follow-up for a BoF discussion during the LPC.
>>
>> The discussion was about supporting Linux on modern laptops and one of
>> the issues mentioned was the lack of support for suspend-to-idle in user
>> space and if there's anything that can be done about that in the kernel.
>>
>> The following patches are my input. :-)
>>
>> The first one reworks the suspend interface to allow the "mem" string
>> in /sys/power/state to represent multiple things that can be selected via
>> an additional sysfs attribute.
>>
>> The second one makes ACPI select suspend-to-idle as the default suspend
>> mode
>> if so indicated in the FADT.
>>
>> Please let me know what you think.
>>
>> Thanks,
>> Rafael
>
> Thanks for submitting.  I like the approach, especially that it leaves room
> to easily modify the behavior for debugging purposes and adding quirks.

Well, that's the point. :-)

> I tested your series on a machine that had this bit set in the FADT and
> confirmed that it set up and used policy properly.
>
> Tested-By: Mario Limonciello <mario.limonciello@dell.com>

Thanks!
