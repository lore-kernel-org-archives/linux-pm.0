From: <Mario.Limonciello@dell.com>
Subject: RE: RFC: WMI Enhancements
Date: Fri, 14 Apr 2017 19:04:12 +0000
Message-ID: <6be8765f968a47b79f6408cc8ddef7f1@ausx13mpc120.AMER.DELL.COM>
References: <20170412230854.GA11963@fury> <20170413073339.GH3090@pali>
 <20170413165646.GD2064@fury>
 <e50750499ea246d78b336caae95d36b8@ausx13mpc120.AMER.DELL.COM>
 <20170413235103.GB11189@fury>
 <cdb41f03934e4dfd997f91c1bbb436c7@ausx13mpc120.AMER.DELL.COM>
 <20170414182739.GA25356@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:24525 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751687AbdDNTEU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2017 15:04:20 -0400
In-Reply-To: <20170414182739.GA25356@fury>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: dvhart@infradead.org
Cc: pali.rohar@gmail.com, rjw@rjwysocki.net, len.brown@intel.com, corentin.chary@gmail.com, luto@kernel.org, andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org

> -----Original Message-----
> From: Darren Hart [mailto:dvhart@infradead.org]
> Sent: Friday, April 14, 2017 1:28 PM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Cc: pali.rohar@gmail.com; rjw@rjwysocki.net; len.brown@intel.com;
> corentin.chary@gmail.com; luto@kernel.org; andriy.shevchenko@linux.intel.=
com;
> linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; linux-
> pm@vger.kernel.org
> Subject: Re: RFC: WMI Enhancements
>=20
> On Fri, Apr 14, 2017 at 05:42:03PM +0000, Mario.Limonciello@dell.com wrot=
e:
> >
> >
> > > -----Original Message-----
> > > From: Darren Hart [mailto:dvhart@infradead.org]
> > > Sent: Thursday, April 13, 2017 6:51 PM
> > > To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> > > Cc: pali.rohar@gmail.com; rjw@rjwysocki.net; len.brown@intel.com;
> > > corentin.chary@gmail.com; luto@kernel.org;
> andriy.shevchenko@linux.intel.com;
> > > linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; li=
nux-
> > > pm@vger.kernel.org
> > > Subject: Re: RFC: WMI Enhancements
> > >
> > > On Thu, Apr 13, 2017 at 08:38:28PM +0000, Mario.Limonciello@dell.com
> wrote:
> > > > Earlier question from Andy.  I had some discussion with the right p=
eople about
> > > this.
> > > >
> > > > > Is it just the "call SMBIOS" GUID or are there other things?
> > > >
> > > > Today - it's just the SMBIOS calling GUID.  There are plans (not ye=
t concrete)
> for
> > > > splitting up data access and organization of that data access class=
es across
> > > multiple
> > > >  other GUID/method pairs in the future.
> > > >
> > > > Ideally this could be done without needing kernel patches every tim=
e a new
> GUID
> > > > would (essentially) need to be whitelisted.
> > > >
> > > > > I am a strong supporter of the following philosophy with respect =
to
> supporting
> > > > > innovation:
> > > > > "Enable them to enable themselves and get out of their way"
> > > > >
> > > > > I've followed this approach over the years to encourage upstream =
first
> software
> > > > > development, open-first policy toward specifications and document=
ation,
> > > proper
> > > > > license selection, and development of new mechanisms in existing
> standards,
> > > like
> > > > > ACPI _DSD. All of these serve to support innovation by removing b=
ottlenecks
> > > and
> > > > > enabling developers to be independent.
> > > > >
> > > > > What I don't want to see is the Linux kernel becoming a bottlenec=
k to feature
> > > > > parity with Windows (or to becoming the lead vehicle for new feat=
ures).
> When a
> > > > > vendor has a feature they want to expose which they determine to =
be a
> value
> > > > > proposition for their product, I don't want the lack of a class d=
river to get in
> > > > > the way. Exposing specific GUIDs is a minimal and easy to upstrea=
m change
> > > which
> > > > > would enable rapid feature enabling.
> > > > >
> > > > > Perhaps I should have led with this :-)
> > > > >
> > > >
> > > > So considering future plans, I'd really like if it's possible to ex=
pose all the
> GUID's
> > > the
> > > > GUID's the same as Windows does today.
> > >
> > > A bit of trouble parsing... to be clear, your preference would be tha=
t for the
> > > PNP0C14 on whitelisted platforms (either DMI matches, or possibly via=
 the ACPI
> > > Device UID?) we expose every GUID (Method, Event, and Data) for that =
device to
> > > userspace?
> >
> > My preference would be to expose everything found in _WDG across platfo=
rms so
> it
> > doesn't have to be a whitelist.  DMI matching could work if it was done
> specifically
> > on the manufacturer rather than individual system.
> >
> > If you compare to how it's done with the other OS, everything mentioned=
 in the
> MOF
> > is accessible from userspace.  The only reason the MOF exists is to mat=
ch up
> > what's in _WDG.  Linux can make this actually easier in that you just d=
on't use the
> > MOF at all.
> >
> > >
> > > The concern raised here is that for systems using dell-wmi, the two G=
UIDs used
> > > by the kernel would also be exposed to userspace. Is this correct?
>=20
> OK, rather than whitelisting specific GUIDs to be exported, what if we ma=
tched
> on a vendor and exported all of them except for the ones that any kernel =
drivers
> have already bound to? For example, dell-wmi currently binds to:
>=20
> #define DELL_EVENT_GUID "9DBB5994-A997-11DA-B012-B622A1EF5492"
> #define DELL_DESCRIPTOR_GUID "8D9DDCBC-A997-11DA-B012-B622A1EF5492"
>=20
> Perhaps a set of mof and $vendor-mof drivers could be created which would=
 do
> what
> Andy L's patch does, but match on DMI Vendor or WMI PNP UID and export al=
l
> interfaces. When another kernel driver binds to a WMI GUID, that GUID wil=
l
> either not be exported, or it will be "locked" from a userspace perspecti=
ve.
>=20
> This of course is dependent on whether or not the WMI GUIDs are granular =
enough
> or if the same GUID is needed by the userpsace application AND by the ker=
nel
> driver to perform different functions - this would be really unfortunate.
>=20
> That said, from what I've learned about WMI, it was designed to provide a=
ccess
> to firmware from userspace. The approach we take in Linux currently was
> expedient, but not consistent with the intent of the mechanism.
>=20

For $FUTURE GUIDs that approach could potentially work depending upon how
the different GUID's are segmented.  There's a few different approaches bei=
ng
discussed.

It unfortunately wouldn't work with the "current" stuff though if we go for=
ward
with the proposal to adjust dell-smbios to use the WMI calls too.
The SMBIOS GUID(A80593CE-A997-11DA-B012-B622A1EF5492) would get=20
taken by dell-smbios and hence not available to userspace.

It would be fine to restrict the event one (9DBB5994-A997-11DA-B012-B622A1E=
F5492).
The one the kernel sees as DESCRIPTOR_GUID can be used to provide static
Info, I don't think that's needed by userspace either.
