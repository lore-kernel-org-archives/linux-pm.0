From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/2] PM / sleep: Support for using suspend-to-idle by default
Date: Wed, 7 Dec 2016 23:56:41 +0100
Message-ID: <CAJZ5v0irVpD5NqzG6LePkC-FHEekO5RAmkQZurMbd8Fm+QGLhg@mail.gmail.com>
References: <9316960.49SRRJV8RJ@vostro.rjw.lan> <71203ae1bfe54eb39d79c54b51ba7ae8@ausx13mpc120.AMER.DELL.COM>
 <CAJZ5v0g-eOciw_3PZBvaHPzh8sMpe0Fbx6RmCTiS1Nax=Bxh3w@mail.gmail.com> <c7f7306f2ae9452a838f94d87b3bc737@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c7f7306f2ae9452a838f94d87b3bc737@ausx13mpc120.AMER.DELL.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: Mario Limonciello <Mario.Limonciello@dell.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 7, 2016 at 10:38 PM,  <Mario.Limonciello@dell.com> wrote:
>> -----Original Message-----
>> From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of
>> Rafael J. Wysocki
>> Sent: Thursday, November 17, 2016 3:05 PM
>> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>; Linux PM <linux-
>> pm@vger.kernel.org>; ACPI Devel Maling List <linux-acpi@vger.kernel.org>;
>> Len Brown <len.brown@intel.com>; Linux Kernel Mailing List <linux-
>> kernel@vger.kernel.org>; Andy Lutomirski <luto@kernel.org>
>> Subject: Re: [PATCH 0/2] PM / sleep: Support for using suspend-to-idle by
>> default
>>
>> On Thu, Nov 17, 2016 at 9:40 PM,  <Mario.Limonciello@dell.com> wrote:
>> > Hi Rafael,
>> >
>> >> -----Original Message-----
>> >> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
>> >> Sent: Wednesday, November 16, 2016 8:19 PM
>> >> To: Linux PM list <linux-pm@vger.kernel.org>
>> >> Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>; Len Brown
>> >> <len.brown@intel.com>; Linux Kernel Mailing List <linux-
>> >> kernel@vger.kernel.org>; Limonciello, Mario
>> >> <Mario_Limonciello@Dell.com>; Andy Lutomirski <luto@kernel.org>
>> >> Subject: [PATCH 0/2] PM / sleep: Support for using suspend-to-idle by
>> >> default
>> >>
>> >> Hi,
>> >>
>> >> This series is a follow-up for a BoF discussion during the LPC.
>> >>
>> >> The discussion was about supporting Linux on modern laptops and one of
>> >> the issues mentioned was the lack of support for suspend-to-idle in user
>> >> space and if there's anything that can be done about that in the kernel.
>> >>
>> >> The following patches are my input. :-)
>> >>
>> >> The first one reworks the suspend interface to allow the "mem" string
>> >> in /sys/power/state to represent multiple things that can be selected via
>> >> an additional sysfs attribute.
>> >>
>> >> The second one makes ACPI select suspend-to-idle as the default
>> suspend
>> >> mode
>> >> if so indicated in the FADT.
>> >>
>> >> Please let me know what you think.
>> >>
>> >> Thanks,
>> >> Rafael
>> >
>> > Thanks for submitting.  I like the approach, especially that it leaves room
>> > to easily modify the behavior for debugging purposes and adding quirks.
>>
>> Well, that's the point. :-)
>>
>> > I tested your series on a machine that had this bit set in the FADT and
>> > confirmed that it set up and used policy properly.
>> >
>> > Tested-By: Mario Limonciello <mario.limonciello@dell.com>
>>
>> Thanks!
>
> Rafael,
>
> I hadn't noticed these merged into any of your linux-pm.git branches.
>
> Do you have a plan for merging them?  Or waiting for other feedback?

They are in the linux-next branch (and therefore in linux-next), so on
their way to 4.10-rc1.

I usually only update topic branches at kernel.org when they are ready
to go into the mainline and the ones I have locally are merged into
the linux-next one beforehand.

Thanks,
Rafael
