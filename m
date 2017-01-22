From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Regression on Dell XPS13 (was: [char-misc for 4.10-rc4 V2] mei:
 bus: enable OS version only for SPT and newer)
Date: Sun, 22 Jan 2017 10:45:16 +0100
Message-ID: <CAJZ5v0gKLiezvGE71v-A=Jz5E_E0PL4twHmA7y_CDdS4aFxJ9A@mail.gmail.com>
References: <5549d8c0527412390d71236d80dff419@molgen.mpg.de>
 <20170114193959.GA30750@kroah.com> <5B8DA87D05A7694D9FA63FD143655C1B5437C2D3@hasmsx108.ger.corp.intel.com>
 <20170115105830.GD26374@kroah.com> <20170116110539.GA1307@kroah.com>
 <1b1feb50-2b22-b7e7-0fb8-2011340f5c47@leemhuis.info> <55b349b2-2999-94d5-9f68-b1944df1d374@molgen.mpg.de>
 <954f9b4e8bd844c98f8d3c12f0fe366f@ausx13mpc120.AMER.DELL.COM>
 <20170117182337.GB12600@kroah.com> <4fc46eab4a174e44b6d28b7ecf979ec9@ausx13mpc120.AMER.DELL.COM>
 <20170117233346.GA2599@wisp> <52d8844460324d62b6e10dd540f64351@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35236 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdAVJpR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Jan 2017 04:45:17 -0500
In-Reply-To: <52d8844460324d62b6e10dd540f64351@ausx13mpc120.AMER.DELL.COM>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mario Limonciello <Mario.Limonciello@dell.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Darren Hart <dvhart@infradead.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>, Thorsten Leemhuis <linux@leemhuis.info>, Tomas Winkler <tomas.winkler@intel.com>, jan@gondor.com, Alexander Usyskin <alexander.usyskin@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Chen, Yu C" <yu.c.chen@intel.com>, Tomi Sarvela <tomi.p.sarvela@intel.com>, Daniel Blueman <daniel@quora.org>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>

On Sat, Jan 21, 2017 at 12:11 AM,  <Mario.Limonciello@dell.com> wrote:
> Greg,
>
>> -----Original Message-----
>> From: Darren Hart [mailto:dvhart@infradead.org]
>> Sent: Tuesday, January 17, 2017 5:34 PM
>> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
>> Cc: gregkh@linuxfoundation.org; rafael.j.wysocki@intel.com;
>> pmenzel@molgen.mpg.de; linux@leemhuis.info; tomas.winkler@intel.com;
>> jan@gondor.com; alexander.usyskin@intel.com; linux-kernel@vger.kernel.org;
>> yu.c.chen@intel.com; tomi.p.sarvela@intel.com; daniel@quora.org;
>> len.brown@intel.com; linux-pm@vger.kernel.org
>> Subject: Re: Regression on Dell XPS13 (was: [char-misc for 4.10-rc4 V2] mei:
>> bus: enable OS version only for SPT and newer)
>>
>> On Tue, Jan 17, 2017 at 06:38:43PM +0000, Mario.Limonciello@dell.com
>> wrote:
>> > > -----Original Message-----
>> > > From: Greg KH [mailto:gregkh@linuxfoundation.org]
>> > > Sent: Tuesday, January 17, 2017 12:24 PM
>> > > To: Limonciello, Mario <Mario_Limonciello@Dell.com>
>> > > Cc: pmenzel@molgen.mpg.de; rafael.j.wysocki@intel.com;
>> > > linux@leemhuis.info; tomas.winkler@intel.com; jan@gondor.com;
>> > > alexander.usyskin@intel.com; linux-kernel@vger.kernel.org;
>> > > yu.c.chen@intel.com; tomi.p.sarvela@intel.com; daniel@quora.org;
>> > > len.brown@intel.com; linux-pm@vger.kernel.org
>> > > Subject: Re: Regression on Dell XPS13 (was: [char-misc for 4.10-rc4 V2] mei:
>> > > bus: enable OS version only for SPT and newer)
>> > >
>> > > On Tue, Jan 17, 2017 at 04:57:49PM +0000, Mario.Limonciello@dell.com
>> > > wrote:
>> > > > So in the <6s scenario, the intel-hid driver is responsible to
>> > > > receive the ACPI event and process accordingly.  The maintainer
>> > > > has a patch ready for the intel-hid portion of this work, but it's
>> > > > currently being reviewed by Intel to ensure it can be legally submitted
>> into the kernel.
>> > >
>> > > Who at Intel do I need to go kick to make this mythical legal review
>> > > happen faster so we can see the code?
>> > >
>> > > Len and Rafael, what is going on here?
>> > >
>> >
>> > Len and Darren are both in the loop on the discussion around this patch.
>> > I don't know if they'll have any (public) comments they can add on the
>> > matter yet however.
>>
>> Thanks Mario. Yes, there isn't much to say here in public other than to confirm
>> we are keenly aware of the problem and have been actively working on fixing
>> it, both for this instance, and the deeper systematic failure that resulted in this
>> situation. No amount of kicking will expedite the process at this point, but
>> should we feel the need, we'll reach out.
>>
>
> The approval has come through and the patch has been submitted.
> http://www.spinics.net/lists/platform-driver-x86/msg10286.html
>
> Note: this is only half of the fix, the second half needs the ACPI subsystem to
> not be frozen to be able to receive this event.

Can you please elaborate on what exactly you mean here?

ACPI events wake up the system from suspend-to-idle, because the SCI
is marked as a wakeup interrupt.  Is this not sufficient?  If it
isn't, then why?

Thanks,
Rafael
