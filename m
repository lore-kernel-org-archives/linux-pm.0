From: Darren Hart <dvhart@infradead.org>
Subject: Re: RFC: WMI Enhancements
Date: Fri, 14 Apr 2017 11:27:39 -0700
Message-ID: <20170414182739.GA25356@fury>
References: <20170412230854.GA11963@fury>
 <20170413073339.GH3090@pali>
 <20170413165646.GD2064@fury>
 <e50750499ea246d78b336caae95d36b8@ausx13mpc120.AMER.DELL.COM>
 <20170413235103.GB11189@fury>
 <cdb41f03934e4dfd997f91c1bbb436c7@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cdb41f03934e4dfd997f91c1bbb436c7@ausx13mpc120.AMER.DELL.COM>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: pali.rohar@gmail.com, rjw@rjwysocki.net, len.brown@intel.com, corentin.chary@gmail.com, luto@kernel.org, andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 14, 2017 at 05:42:03PM +0000, Mario.Limonciello@dell.com wrote:
> 
> 
> > -----Original Message-----
> > From: Darren Hart [mailto:dvhart@infradead.org]
> > Sent: Thursday, April 13, 2017 6:51 PM
> > To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> > Cc: pali.rohar@gmail.com; rjw@rjwysocki.net; len.brown@intel.com;
> > corentin.chary@gmail.com; luto@kernel.org; andriy.shevchenko@linux.intel.com;
> > linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; linux-
> > pm@vger.kernel.org
> > Subject: Re: RFC: WMI Enhancements
> > 
> > On Thu, Apr 13, 2017 at 08:38:28PM +0000, Mario.Limonciello@dell.com wrote:
> > > Earlier question from Andy.  I had some discussion with the right people about
> > this.
> > >
> > > > Is it just the "call SMBIOS" GUID or are there other things?
> > >
> > > Today - it's just the SMBIOS calling GUID.  There are plans (not yet concrete) for
> > > splitting up data access and organization of that data access classes across
> > multiple
> > >  other GUID/method pairs in the future.
> > >
> > > Ideally this could be done without needing kernel patches every time a new GUID
> > > would (essentially) need to be whitelisted.
> > >
> > > > I am a strong supporter of the following philosophy with respect to supporting
> > > > innovation:
> > > > "Enable them to enable themselves and get out of their way"
> > > >
> > > > I've followed this approach over the years to encourage upstream first software
> > > > development, open-first policy toward specifications and documentation,
> > proper
> > > > license selection, and development of new mechanisms in existing standards,
> > like
> > > > ACPI _DSD. All of these serve to support innovation by removing bottlenecks
> > and
> > > > enabling developers to be independent.
> > > >
> > > > What I don't want to see is the Linux kernel becoming a bottleneck to feature
> > > > parity with Windows (or to becoming the lead vehicle for new features). When a
> > > > vendor has a feature they want to expose which they determine to be a value
> > > > proposition for their product, I don't want the lack of a class driver to get in
> > > > the way. Exposing specific GUIDs is a minimal and easy to upstream change
> > which
> > > > would enable rapid feature enabling.
> > > >
> > > > Perhaps I should have led with this :-)
> > > >
> > >
> > > So considering future plans, I'd really like if it's possible to expose all the GUID's
> > the
> > > GUID's the same as Windows does today.
> > 
> > A bit of trouble parsing... to be clear, your preference would be that for the
> > PNP0C14 on whitelisted platforms (either DMI matches, or possibly via the ACPI
> > Device UID?) we expose every GUID (Method, Event, and Data) for that device to
> > userspace?
> 
> My preference would be to expose everything found in _WDG across platforms so it 
> doesn't have to be a whitelist.  DMI matching could work if it was done specifically
> on the manufacturer rather than individual system.
> 
> If you compare to how it's done with the other OS, everything mentioned in the MOF
> is accessible from userspace.  The only reason the MOF exists is to match up
> what's in _WDG.  Linux can make this actually easier in that you just don't use the
> MOF at all.
> 
> > 
> > The concern raised here is that for systems using dell-wmi, the two GUIDs used
> > by the kernel would also be exposed to userspace. Is this correct?

OK, rather than whitelisting specific GUIDs to be exported, what if we matched
on a vendor and exported all of them except for the ones that any kernel drivers
have already bound to? For example, dell-wmi currently binds to:

#define DELL_EVENT_GUID "9DBB5994-A997-11DA-B012-B622A1EF5492"
#define DELL_DESCRIPTOR_GUID "8D9DDCBC-A997-11DA-B012-B622A1EF5492"

Perhaps a set of mof and $vendor-mof drivers could be created which would do what
Andy L's patch does, but match on DMI Vendor or WMI PNP UID and export all
interfaces. When another kernel driver binds to a WMI GUID, that GUID will
either not be exported, or it will be "locked" from a userspace perspective.

This of course is dependent on whether or not the WMI GUIDs are granular enough
or if the same GUID is needed by the userpsace application AND by the kernel
driver to perform different functions - this would be really unfortunate.

That said, from what I've learned about WMI, it was designed to provide access
to firmware from userspace. The approach we take in Linux currently was
expedient, but not consistent with the intent of the mechanism.

> > 
> > >
> > > As example is we have some diagnostic testing tools.  Having to whitelist
> > interfaces
> > > for them to operate would be sub-optimal.
> > >
> > 
> > Is this a problem because there are a lot of them, or because they routinely
> > change?
> 
> They're going to be changing in the future and that will use a new WMI interface
> when that change happens.
> 
> The interfaces don't routinely change today, but there discussions to change
> and introduce more later.
> 
> > 
> > Also, are these something that could be part of a debug feature, or do they need
> > to be in production so you can work with customers to diagnose running systems
> > for example?
> > 
> 
> The intent is for production, so that remediation tools can run on the box.
> 
> 

-- 
Darren Hart
VMware Open Source Technology Center
