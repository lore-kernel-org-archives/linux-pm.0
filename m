From: <Mario.Limonciello@dell.com>
Subject: RE: RFC: WMI Enhancements
Date: Sat, 6 May 2017 00:51:59 +0000
Message-ID: <beb9a835eaf243fab151627e919eccf3@ausx13mpc120.AMER.DELL.COM>
References: <20170412230854.GA11963@fury> <20170419075248.GD18887@pali>
 <f3684c95b91349d3b4e512370ac1faf4@ausx13mpc120.AMER.DELL.COM>
 <201704191854.51783@pali>
 <4e3e507b116443298427002c5aafed7f@ausx13mpc120.AMER.DELL.COM>
 <20170420131431.GM18887@pali> <20170420204436.GC3209@fury>
 <775ffd8f3327497cabd15ee7826cedaf@ausx13mpc120.AMER.DELL.COM>
 <20170505234436.GB25865@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from esa1.dell-outbound.iphmx.com ([68.232.153.90]:29602 "EHLO
        esa1.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751815AbdEFAwD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 May 2017 20:52:03 -0400
In-Reply-To: <20170505234436.GB25865@fury>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: dvhart@infradead.org
Cc: pali.rohar@gmail.com, rjw@rjwysocki.net, luto@amacapital.net, len.brown@intel.com, corentin.chary@gmail.com, luto@kernel.org, andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org

> -----Original Message-----
> From: Darren Hart [mailto:dvhart@infradead.org]
> Sent: Friday, May 5, 2017 6:45 PM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Cc: pali.rohar@gmail.com; rjw@rjwysocki.net; luto@amacapital.net;
> len.brown@intel.com; corentin.chary@gmail.com; luto@kernel.org;
> andriy.shevchenko@linux.intel.com; linux-kernel@vger.kernel.org; platform=
-
> driver-x86@vger.kernel.org; linux-pm@vger.kernel.org
> Subject: Re: RFC: WMI Enhancements
>=20
> On Fri, May 05, 2017 at 09:55:46PM +0000, Mario.Limonciello@dell.com wrot=
e:
> > > -----Original Message-----
> > > From: Darren Hart [mailto:dvhart@infradead.org]
> > > Sent: Thursday, April 20, 2017 3:45 PM
> > > To: Pali Roh=E1r <pali.rohar@gmail.com>
> > > Cc: Limonciello, Mario <Mario_Limonciello@Dell.com>; rjw@rjwysocki.ne=
t;
> > > luto@amacapital.net; len.brown@intel.com; corentin.chary@gmail.com;
> > > luto@kernel.org; andriy.shevchenko@linux.intel.com; linux-
> > > kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; linux-
> > > pm@vger.kernel.org
> > > Subject: Re: RFC: WMI Enhancements
> > >
> > > On Thu, Apr 20, 2017 at 03:14:31PM +0200, Pali Roh=E1r wrote:
> > > > On Wednesday 19 April 2017 17:24:00 Mario.Limonciello@dell.com wrot=
e:
> > > > > > -----Original Message-----
> > > > > > From: Pali Roh=E1r [mailto:pali.rohar@gmail.com]
> > > > > > Sent: Wednesday, April 19, 2017 11:55 AM
> > > > > > To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> > > > > > Cc: dvhart@infradead.org; rjw@rjwysocki.net; luto@amacapital.ne=
t;
> > > > > > len.brown@intel.com; corentin.chary@gmail.com; luto@kernel.org;
> > > > > > andriy.shevchenko@linux.intel.com; linux-kernel@vger.kernel.org=
;
> platform-
> > > > > > driver-x86@vger.kernel.org; linux-pm@vger.kernel.org
> > > > > > Subject: Re: RFC: WMI Enhancements
> > > > > >
> > > > > > On Wednesday 19 April 2017 18:29:53 Mario.Limonciello@dell.com
> wrote:
> > > > > > > > As wrote above, I'm fine with explicit whitelist of WMI GUI=
Ds which
> > > > > > > > will be exported to userspace after communication with vend=
or.
> > > > > > >
> > > > > > > What about GUID's not yet used by kernel drivers?  Would thos=
e
> > > > > > > default to whitelist default to blacklist?  My preference wou=
ld be
> > > > > > > to default to whitelist. This allows new GUID's to be added l=
ater
> > > > > > > without needing to modify kernel for something that kernel wo=
n't
> > > > > > > need to do anything immediately.
> > > > > >
> > > > > > I understood it as there would be explicit whitelist in kernel =
and new
> > > > > > GUIDs would be needed to add into whitelist, even those which d=
o not
> > > > > > have kernel wmi driver.
> > > > > >
> > > > > > Exporting all GUIDs (to userspace) which are not bind to kernel=
 driver
> > > > > > has one big problem. If kernel introduce new wmi driver for suc=
h GUID
> > > > > > then it block userspace to access it or at least would need to =
provide
> > > > > > audit filter and something would be probably filtered. It means=
 that
> > > > > > some userspace applications which would use that GUIDs stops wo=
rking
> > > > > > after upgrading to new kernel. And we can be in situation where=
 *user*
> > > > > > need to decide: either use 3rd party userspace application from=
 vendor
> > > > > > which provide some special settings for your laptop, or use ker=
nel
> > > > > > module which provides standard rfkill/led/input class driver.
> > > > > >
> > > > >
> > > > > If this proposal goes forward it would sound like to me an audit =
filter
> > > > > would become a prerequisite for any new WMI kernel driver.  This =
is not
> > > > > a problem to me.
> > > >
> > > > Not for any wmi driver, only for those which would like to export w=
mi
> > > > device to userspace.
> > >
> > > Correct.
> > >
> > > >
> > > > > This audience recommends the way for users to configure the syste=
m but
> > > > > of course cannot stop users from doing what they decide to do.
> > > >
> > > > Of course, but in above hypothetical example, user is in situation =
where
> > > > is unable to use both 3rd vendor application and together kernel
> > > > rfkill/led/input driver. User must decide (by e.g. modprobe blackli=
st or
> > > > manual module loading) what want to use.
> > > >
> > > > But ideal solution is that both 3rd vendor application for firmware
> > > > settings and also rfkill kernel driver would work together without =
need
> > > > to rmmod/modprobe modules and without restarting 3rd vendor applica=
tion.
> > > >
> > > > > We're all in agreement that the kernel should keep responsibility=
 for some
> > > > > of these functionalities.
> > > > > If a new kernel WMI driver duplicates functionality that happens =
to find its
> > > > > way in userspace and the kernel audits that out yes the userspace
> > > > > application may start to  have less functionality, but better sup=
port
> > > > > would live in the kernel and the user would be better supported b=
y
> > > > > the stack (for example could use standard rfkill userspace utilit=
ies).
> > > >
> > >
> > > Pali has raised a very good point which I want to get some feedback f=
rom Linus,
> > > and perhaps tglx, hpa, and gregkh on. While Mario is expressing a ver=
y
> pragmatic
> > > approach which I certainly appreciate, we have a very strong position=
 that we
> do
> > > not break userspace.
> > >
> > > There have been exceptions for specific pseudo filesystems and such, =
but they
> > > are rare. We would need to document the WMI commitment from the kerne=
l to
> > > userspace (e.g. any call may be filtered based on current Linux kerne=
l WMI
> > > usage, which may change over time). This sounds troublesome... will g=
ive this
> > > some more thought.
> > >
> >
> > There are other examples in the kernel of the same data accessible in m=
ultiple
> > different methods that can cause inconsistencies too.
>=20
> Something that occurred to me today is we could include in the API of the=
 WMI
> device the potential return of -EBUSY anytime the kernel decides it can't=
 safely
> service a call. This would avoid *changing* the API exposed to userspace,=
 but it
> could change the behavior and availability of certain methods.
>=20
> >
> > > > Ok. So it is acceptable solution/API/ABI for you & other Dell peopl=
e?
> > > > Or is something more or different needed?
> > > >
> > > > Darren, I hope that I understood your proposal with explicit whitel=
ist
> > > > correctly. And is there already another vendor which want to use wm=
i
> > > > userspace on linux?
> > >
> > > It might be moot with Christoph's dynamic ID comment which I need to =
go
> review
> > > in detail. Putting that aside for a moment, what I intended was for t=
he platform
> > > driver to whitelist GUIDs. But, that doesn't necessarily mean it has =
an explicit
> > > list. The platform driver could have a blacklist and then walk throug=
h all
> > > available GUIDs and export everything except those on the blacklist.
> >
> > To get this started can you re-review Andy's platform/wmi tree and merg=
e in
> some
> > of his bus work?  Regardless of the outcome of the access to userspace =
and
> dynamic
> > binding this is a good direction for WMI support in platform/drivers/x8=
6 to get
> started.
>=20
> Yes, this is already queued up for next week, and will be targeted at the=
 4.13
> merge window.
>=20

OK great.

> >
> > >
> > > Now with Christoph's idea, we may be able to maintain a blacklist of =
GUIDs and
> a
> > > whitelist of platforms which CAN export WMI, but not export any until
> userspace
> > > requests a specific GUID be exported at which point it is checked aga=
inst the
> > > blacklist and then exported accordingly, at which point the WMI metho=
d filters
> > > handle the rest.
> > >
> >
> > I've been studying more about how this access to WMI BIOS functions on
> Windows
> > works this week and uncovered what I see as another set of related ques=
tions
> around
> > commitment to manageability access from the OS with this potential user=
space
> layer.
> >
> > On Windows what happens is the MOF data (same stuff exposed by Andy's w=
mi-
> mof)
> > is imported into the WMI namespace.  This allows any tools to know exac=
tly how
> > to interact with the various GUID's associated to the ASL methods.  The=
 format of
> the
> > data and the arguments supported are encoded directly in that MOF data.
> >
> > This means that standard WBEM tools are able to interact directly with =
these
> methods
> > based upon exposed objects.  BIOS manufacturer can expose say all BIOS =
settings
> that
> > are integer to a GUID for interacting with integer settings and those w=
ould get
> loaded
> > into the WMI namespace.  When someone uses a WBEM tool to modify that
> object
> > the data is properly formatted into the correct arguments for an intege=
r and then
> run
> > through the ASL.  Another GUID might be made for strings and another fo=
r
> specially
> > crafted lists (like a boot order).  The important part is that all sett=
ings are
> discoverable
> > and no extra tools are needed to administer a box.  It can all be done =
from things
> like
> > PowerShell or wmic.
>=20
> Ah, that's good insight, thank you.
>=20
> >
> > In an ideal world I think this is the right solution for Linux too, as =
part of this pipe
> we've
> > discussed let some userspace Linux WBEM tools like OpenLMI have access =
to a
> BIOS
> > provider that can interact with various settings.
> >
> > Unfortunately the MOF data that comes out of wmi-mof is so called "Bina=
ry MOF"
> which
> > has been pre-compiled to an intermediate format with mofcomp.exe on
> Windows.
> > The format of binary MOF is not documented and the only known way to ge=
t text
> > mof back out is by using mofcomp.exe with some esoteric arguments.
> >
> > mofcomp.exe -MOF:recovered.mof -MFL:ms_409.mof -Amendment:MS_409
> binary_mof_file
> >
>=20
> Oh wow. That's... that's just horrible. :-(

That's only because a researcher discovered it too.  MS doesn't formally pr=
ovide
any documented support for extracting from binary MOF.

>=20
> Do you have an idea as to the relative complexity of this format? Does it=
 make
> sense for us to attempt to decompile it? Presumably this would be done in
> userspace ... although seeing as how we have drivers using this functiona=
lity,
> it would be useful to be able to parse this from the kernel as well. Hrm.
>=20

I haven't done any analysis of it so I'm not really sure how complex it wil=
l be.
For now I'd say userspace should be planned to handle it until someone dete=
rmines
A simple enough way to decompile it that can live in the kernel.

> Definitely *not* a perfect world :-)
>=20
> > So with that said, what role should the Linux kernel actually play here=
?
>=20
> Time to level this up. I'll draft something up and try to get Linus and G=
reg to
> weigh in.

OK thanks.

>=20
> > My thought is it still makes sense to make this pipe available to poten=
tially enable
> WBEM
> > tools at some point.  At least until a way to deconstruct binary MOF is=
 made
> available,
> > it's conceivable to build a provider from reverse engineered discovery =
of how the
> ASL works,
> > it just won't be as "pretty" as the type of data you get out of MOF wit=
h name and
> value mappings.
>=20
> I'm not following the "At least until a way to deconstruct binary MOF is =
made
> available" relates to making the pipe as you called it available?
>=20
> The pipe would provide a WMI chardev which usespace could open and write =
a
> method ID and arguments to, and read a response. That is necessary whethe=
r or
> not the MOF data is legible. Having the MOF data just means it's less wor=
k to
> figure out exactly which method IDs are available and what arguments they
> accept. Right?
>=20

I meant that to say that at least for now Andy's wmi-mof driver should stil=
l be merged.
If something is going to build on top of this to do WBEM tools, they'll nee=
d that MOF
data once someone figures out how to nicely deconstruct it.
