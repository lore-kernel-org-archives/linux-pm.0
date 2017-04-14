From: <Mario.Limonciello@dell.com>
Subject: RE: RFC: WMI Enhancements
Date: Fri, 14 Apr 2017 17:42:03 +0000
Message-ID: <cdb41f03934e4dfd997f91c1bbb436c7@ausx13mpc120.AMER.DELL.COM>
References: <20170412230854.GA11963@fury> <20170413073339.GH3090@pali>
 <20170413165646.GD2064@fury>
 <e50750499ea246d78b336caae95d36b8@ausx13mpc120.AMER.DELL.COM>
 <20170413235103.GB11189@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170413235103.GB11189@fury>
Content-Language: en-US
Sender: platform-driver-x86-owner@vger.kernel.org
To: dvhart@infradead.org
Cc: pali.rohar@gmail.com, rjw@rjwysocki.net, len.brown@intel.com, corentin.chary@gmail.com, luto@kernel.org, andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Darren Hart [mailto:dvhart@infradead.org]
> Sent: Thursday, April 13, 2017 6:51 PM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Cc: pali.rohar@gmail.com; rjw@rjwysocki.net; len.brown@intel.com;
> corentin.chary@gmail.com; luto@kernel.org; andriy.shevchenko@linux.intel.=
com;
> linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; linux-
> pm@vger.kernel.org
> Subject: Re: RFC: WMI Enhancements
>=20
> On Thu, Apr 13, 2017 at 08:38:28PM +0000, Mario.Limonciello@dell.com wrot=
e:
> > Earlier question from Andy.  I had some discussion with the right peopl=
e about
> this.
> >
> > > Is it just the "call SMBIOS" GUID or are there other things?
> >
> > Today - it's just the SMBIOS calling GUID.  There are plans (not yet co=
ncrete) for
> > splitting up data access and organization of that data access classes a=
cross
> multiple
> >  other GUID/method pairs in the future.
> >
> > Ideally this could be done without needing kernel patches every time a =
new GUID
> > would (essentially) need to be whitelisted.
> >
> > > I am a strong supporter of the following philosophy with respect to s=
upporting
> > > innovation:
> > > "Enable them to enable themselves and get out of their way"
> > >
> > > I've followed this approach over the years to encourage upstream firs=
t software
> > > development, open-first policy toward specifications and documentatio=
n,
> proper
> > > license selection, and development of new mechanisms in existing stan=
dards,
> like
> > > ACPI _DSD. All of these serve to support innovation by removing bottl=
enecks
> and
> > > enabling developers to be independent.
> > >
> > > What I don't want to see is the Linux kernel becoming a bottleneck to=
 feature
> > > parity with Windows (or to becoming the lead vehicle for new features=
). When a
> > > vendor has a feature they want to expose which they determine to be a=
 value
> > > proposition for their product, I don't want the lack of a class drive=
r to get in
> > > the way. Exposing specific GUIDs is a minimal and easy to upstream ch=
ange
> which
> > > would enable rapid feature enabling.
> > >
> > > Perhaps I should have led with this :-)
> > >
> >
> > So considering future plans, I'd really like if it's possible to expose=
 all the GUID's
> the
> > GUID's the same as Windows does today.
>=20
> A bit of trouble parsing... to be clear, your preference would be that fo=
r the
> PNP0C14 on whitelisted platforms (either DMI matches, or possibly via the=
 ACPI
> Device UID?) we expose every GUID (Method, Event, and Data) for that devi=
ce to
> userspace?

My preference would be to expose everything found in _WDG across platforms =
so it=20
doesn't have to be a whitelist.  DMI matching could work if it was done spe=
cifically
on the manufacturer rather than individual system.

If you compare to how it's done with the other OS, everything mentioned in =
the MOF
is accessible from userspace.  The only reason the MOF exists is to match u=
p
what's in _WDG.  Linux can make this actually easier in that you just don't=
 use the
MOF at all.

>=20
> The concern raised here is that for systems using dell-wmi, the two GUIDs=
 used
> by the kernel would also be exposed to userspace. Is this correct?
>=20
> >
> > As example is we have some diagnostic testing tools.  Having to whiteli=
st
> interfaces
> > for them to operate would be sub-optimal.
> >
>=20
> Is this a problem because there are a lot of them, or because they routin=
ely
> change?

They're going to be changing in the future and that will use a new WMI inte=
rface
when that change happens.

The interfaces don't routinely change today, but there discussions to chang=
e
and introduce more later.

>=20
> Also, are these something that could be part of a debug feature, or do th=
ey need
> to be in production so you can work with customers to diagnose running sy=
stems
> for example?
>=20

The intent is for production, so that remediation tools can run on the box.
