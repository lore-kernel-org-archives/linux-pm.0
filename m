From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Regression on Dell XPS13 (was: [char-misc for 4.10-rc4 V2] mei:
 bus: enable OS version only for SPT and newer)
Date: Wed, 18 Jan 2017 03:18:41 +0100
Message-ID: <CAJZ5v0h2+nZk=-2gjLWu=Mag9qXmpv8_+x3ckA=cLiOO0bmOPw@mail.gmail.com>
References: <20170110224956.GA2897@x61s.reliablesolutions.de>
 <5B8DA87D05A7694D9FA63FD143655C1B5437A09D@hasmsx108.ger.corp.intel.com>
 <aac5b255-e817-f92d-2f37-2ca7b52cd957@molgen.mpg.de> <5B8DA87D05A7694D9FA63FD143655C1B5437A315@hasmsx108.ger.corp.intel.com>
 <b1ecfd53-e856-ce10-d56e-4fea27095a8f@molgen.mpg.de> <20170113130018.GA896@kroah.com>
 <5549d8c0527412390d71236d80dff419@molgen.mpg.de> <20170114193959.GA30750@kroah.com>
 <5B8DA87D05A7694D9FA63FD143655C1B5437C2D3@hasmsx108.ger.corp.intel.com>
 <20170115105830.GD26374@kroah.com> <20170116110539.GA1307@kroah.com>
 <1b1feb50-2b22-b7e7-0fb8-2011340f5c47@leemhuis.info> <55b349b2-2999-94d5-9f68-b1944df1d374@molgen.mpg.de>
 <954f9b4e8bd844c98f8d3c12f0fe366f@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:33939 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbdARCSm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Jan 2017 21:18:42 -0500
In-Reply-To: <954f9b4e8bd844c98f8d3c12f0fe366f@ausx13mpc120.AMER.DELL.COM>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mario Limonciello <Mario.Limonciello@dell.com>, pmenzel@molgen.mpg.de
Cc: linux@leemhuis.info, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, jan@gondor.com, alexander.usyskin@intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Chen, Yu C" <yu.c.chen@intel.com>, Tomi Sarvela <tomi.p.sarvela@intel.com>, daniel@quora.org, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>

Mario, thanks for CCing this to linux-pm.

On Tue, Jan 17, 2017 at 5:57 PM,  <Mario.Limonciello@dell.com> wrote:
> Hi Paul,
>
> Thanks for raising this topic and including me.
> Suspend to Idle support in Linux as an alternative S3 on x86 is a new
> topic.  In all, I expected that some problems would arise as a result
> of this patch, and I hope they will spur interesting discussions and
> solutions.
>
> Something that might not be immediately obvious is that by supporting
> suspend to idle, new driver bugs are going to be identified for drivers
> that don't properly put hardware into low enough power modes for the CPU
> to go into the proper state.  Traditionally with S3 the BIOS would be responsible
> for powering devices down before S3 and back up when exiting S3.
> This onus is now on the OS.
>
>> -----Original Message-----
>> From: Paul Menzel [mailto:pmenzel@molgen.mpg.de]
>> Sent: Tuesday, January 17, 2017 8:34 AM
>> To: Rafael J. Wysocki <rafael.j.wysocki@intel.com>; Limonciello, Mario
>> <Mario_Limonciello@Dell.com>
>> Cc: Thorsten Leemhuis <linux@leemhuis.info>; Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org>; Tomas Winkler <tomas.winkler@intel.com>;
>> Jan Niehusmann <jan@gondor.com>; Usyskin, Alexander
>> <alexander.usyskin@intel.com>; linux-kernel@vger.kernel.org; Chen, Yu C
>> <yu.c.chen@intel.com>; Sarvela, Tomi P <tomi.p.sarvela@intel.com>; Daniel
>> Blueman <daniel@quora.org>; Len Brown <len.brown@intel.com>; linux-
>> pm@vger.kernel.org
>> Subject: Regression on Dell XPS13 (was: [char-misc for 4.10-rc4 V2] mei: bus:
>> enable OS version only for SPT and newer)
>>
>> Dear Rafael, dear Mario,
>>
>>
>> On 01/17/17 09:14, Thorsten Leemhuis wrote:
>> > Greg Kroah-Hartman wrote on 16.01.2017 12:05:
>> >> On Sun, Jan 15, 2017 at 11:58:30AM +0100, Greg Kroah-Hartman wrote:
>> >>> On Sun, Jan 15, 2017 at 07:19:03AM +0000, Winkler, Tomas wrote:
>> >>>>> Subject: Re: [char-misc for 4.10-rc4 V2] mei: bus: enable OS
>> >>>>> version only for SPT and newer On Sat, Jan 14, 2017 at 08:27:31PM
>> >>>>> +0100, Paul Menzel wrote:
>> >>>>>> On 2017-01-13 14:00, Greg Kroah-Hartman wrote:
>> >>>>>>> On Wed, Jan 11, 2017 at 03:26:06PM +0100, Paul Menzel wrote:
>> >>>>>>>> On 01/11/17 15:12, Winkler, Tomas wrote:
>> >>>>>>>>>>> On 01/11/17 10:24, Winkler, Tomas wrote:
>> >>>>>>>>>>>>> On Wed, Jan 11, 2017 at 01:27:21AM +0200, Tomas Winkler
>> wrote:
>> >>>>>>>>>>>>>> On older platforms the command should be just ignored
>> by
>> >>>>>>>>>>>>>> the firmware but some older platforms misbehave so it's
>> >>>>>>>>>>>>>> safer to send the command only if required.
>> >>>>>>>>>>>>> Thanks! This fixes suspend-to-ram for me (on a Thinkpad
>> x201s).
>> >>>>>>>>>>>> What about Dell XPS13?
>>
>> There is a regression with Linux 4.10-rc{1,2,3} on the Intel Kaby Lake device
>> Dell XPS13 (9360). Hitting the power button, the light of the power button
>> never goes off. Pressing it again, nothing happen. Only pressing it like ten
>> seconds the screen comes back for five seconds, and then it seems to try to
>> suspend again.

Paul,

Can you please check if reverting commit 08b98d329165 (PM / sleep /
ACPI: Use the ACPI_FADT_LOW_POWER_S0 flag) helps?

If not, please send me the output of "cat /sys/power/mem_sleep" from
the affected system.

Thanks,
Rafael
