From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Regression on Dell XPS13 (was: [char-misc for 4.10-rc4 V2] mei:
 bus: enable OS version only for SPT and newer)
Date: Sat, 21 Jan 2017 10:11:12 +0100
Message-ID: <20170121091112.GD27048@kroah.com>
References: <5B8DA87D05A7694D9FA63FD143655C1B5437C2D3@hasmsx108.ger.corp.intel.com>
 <20170115105830.GD26374@kroah.com>
 <20170116110539.GA1307@kroah.com>
 <1b1feb50-2b22-b7e7-0fb8-2011340f5c47@leemhuis.info>
 <55b349b2-2999-94d5-9f68-b1944df1d374@molgen.mpg.de>
 <954f9b4e8bd844c98f8d3c12f0fe366f@ausx13mpc120.AMER.DELL.COM>
 <20170117182337.GB12600@kroah.com>
 <4fc46eab4a174e44b6d28b7ecf979ec9@ausx13mpc120.AMER.DELL.COM>
 <20170117233346.GA2599@wisp>
 <52d8844460324d62b6e10dd540f64351@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:57684 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750874AbdAUJLC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 Jan 2017 04:11:02 -0500
Content-Disposition: inline
In-Reply-To: <52d8844460324d62b6e10dd540f64351@ausx13mpc120.AMER.DELL.COM>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: dvhart@infradead.org, rafael.j.wysocki@intel.com, pmenzel@molgen.mpg.de, linux@leemhuis.info, tomas.winkler@intel.com, jan@gondor.com, alexander.usyskin@intel.com, linux-kernel@vger.kernel.org, yu.c.chen@intel.com, tomi.p.sarvela@intel.com, daniel@quora.org, len.brown@intel.com, linux-pm@vger.kernel.org

On Fri, Jan 20, 2017 at 11:11:45PM +0000, Mario.Limonciello@dell.com wrote:
> Greg,
> 
> > -----Original Message-----
> > From: Darren Hart [mailto:dvhart@infradead.org]
> > Sent: Tuesday, January 17, 2017 5:34 PM
> > To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> > Cc: gregkh@linuxfoundation.org; rafael.j.wysocki@intel.com;
> > pmenzel@molgen.mpg.de; linux@leemhuis.info; tomas.winkler@intel.com;
> > jan@gondor.com; alexander.usyskin@intel.com; linux-kernel@vger.kernel.org;
> > yu.c.chen@intel.com; tomi.p.sarvela@intel.com; daniel@quora.org;
> > len.brown@intel.com; linux-pm@vger.kernel.org
> > Subject: Re: Regression on Dell XPS13 (was: [char-misc for 4.10-rc4 V2] mei:
> > bus: enable OS version only for SPT and newer)
> > 
> > On Tue, Jan 17, 2017 at 06:38:43PM +0000, Mario.Limonciello@dell.com
> > wrote:
> > > > -----Original Message-----
> > > > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > > > Sent: Tuesday, January 17, 2017 12:24 PM
> > > > To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> > > > Cc: pmenzel@molgen.mpg.de; rafael.j.wysocki@intel.com;
> > > > linux@leemhuis.info; tomas.winkler@intel.com; jan@gondor.com;
> > > > alexander.usyskin@intel.com; linux-kernel@vger.kernel.org;
> > > > yu.c.chen@intel.com; tomi.p.sarvela@intel.com; daniel@quora.org;
> > > > len.brown@intel.com; linux-pm@vger.kernel.org
> > > > Subject: Re: Regression on Dell XPS13 (was: [char-misc for 4.10-rc4 V2] mei:
> > > > bus: enable OS version only for SPT and newer)
> > > >
> > > > On Tue, Jan 17, 2017 at 04:57:49PM +0000, Mario.Limonciello@dell.com
> > > > wrote:
> > > > > So in the <6s scenario, the intel-hid driver is responsible to
> > > > > receive the ACPI event and process accordingly.  The maintainer
> > > > > has a patch ready for the intel-hid portion of this work, but it's
> > > > > currently being reviewed by Intel to ensure it can be legally submitted
> > into the kernel.
> > > >
> > > > Who at Intel do I need to go kick to make this mythical legal review
> > > > happen faster so we can see the code?
> > > >
> > > > Len and Rafael, what is going on here?
> > > >
> > >
> > > Len and Darren are both in the loop on the discussion around this patch.
> > > I don't know if they'll have any (public) comments they can add on the
> > > matter yet however.
> > 
> > Thanks Mario. Yes, there isn't much to say here in public other than to confirm
> > we are keenly aware of the problem and have been actively working on fixing
> > it, both for this instance, and the deeper systematic failure that resulted in this
> > situation. No amount of kicking will expedite the process at this point, but
> > should we feel the need, we'll reach out.
> > 
> 
> The approval has come through and the patch has been submitted.
> http://www.spinics.net/lists/platform-driver-x86/msg10286.html

Looks like it needs some work :)

And why isn't it tagged to go to the 4.10-stable kernel if it really
does fix some systems?

> Note: this is only half of the fix, the second half needs the ACPI subsystem to
> not be frozen to be able to receive this event.

Where is that change?

I'm still worried about 4.10-final, is that going to be broken for these
types of systems?

thanks,

greg k-h
