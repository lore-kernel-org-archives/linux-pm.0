From: <Mario.Limonciello@dell.com>
Subject: RE: RFC: WMI Enhancements
Date: Fri, 5 May 2017 21:55:46 +0000
Message-ID: <775ffd8f3327497cabd15ee7826cedaf@ausx13mpc120.AMER.DELL.COM>
References: <20170412230854.GA11963@fury> <20170419075248.GD18887@pali>
 <f3684c95b91349d3b4e512370ac1faf4@ausx13mpc120.AMER.DELL.COM>
 <201704191854.51783@pali>
 <4e3e507b116443298427002c5aafed7f@ausx13mpc120.AMER.DELL.COM>
 <20170420131431.GM18887@pali> <20170420204436.GC3209@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170420204436.GC3209@fury>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: dvhart@infradead.org, pali.rohar@gmail.com
Cc: rjw@rjwysocki.net, luto@amacapital.net, len.brown@intel.com, corentin.chary@gmail.com, luto@kernel.org, andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> -----Original Message-----
> From: Darren Hart [mailto:dvhart@infradead.org]
> Sent: Thursday, April 20, 2017 3:45 PM
> To: Pali Roh=E1r <pali.rohar@gmail.com>
> Cc: Limonciello, Mario <Mario_Limonciello@Dell.com>; rjw@rjwysocki.net;
> luto@amacapital.net; len.brown@intel.com; corentin.chary@gmail.com;
> luto@kernel.org; andriy.shevchenko@linux.intel.com; linux-
> kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; linux-
> pm@vger.kernel.org
> Subject: Re: RFC: WMI Enhancements
>=20
> On Thu, Apr 20, 2017 at 03:14:31PM +0200, Pali Roh=E1r wrote:
> > On Wednesday 19 April 2017 17:24:00 Mario.Limonciello@dell.com wrote:
> > > > -----Original Message-----
> > > > From: Pali Roh=E1r [mailto:pali.rohar@gmail.com]
> > > > Sent: Wednesday, April 19, 2017 11:55 AM
> > > > To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> > > > Cc: dvhart@infradead.org; rjw@rjwysocki.net; luto@amacapital.net;
> > > > len.brown@intel.com; corentin.chary@gmail.com; luto@kernel.org;
> > > > andriy.shevchenko@linux.intel.com; linux-kernel@vger.kernel.org; pl=
atform-
> > > > driver-x86@vger.kernel.org; linux-pm@vger.kernel.org
> > > > Subject: Re: RFC: WMI Enhancements
> > > >
> > > > On Wednesday 19 April 2017 18:29:53 Mario.Limonciello@dell.com wrot=
e:
> > > > > > As wrote above, I'm fine with explicit whitelist of WMI GUIDs w=
hich
> > > > > > will be exported to userspace after communication with vendor.
> > > > >
> > > > > What about GUID's not yet used by kernel drivers?  Would those
> > > > > default to whitelist default to blacklist?  My preference would b=
e
> > > > > to default to whitelist. This allows new GUID's to be added later
> > > > > without needing to modify kernel for something that kernel won't
> > > > > need to do anything immediately.
> > > >
> > > > I understood it as there would be explicit whitelist in kernel and =
new
> > > > GUIDs would be needed to add into whitelist, even those which do no=
t
> > > > have kernel wmi driver.
> > > >
> > > > Exporting all GUIDs (to userspace) which are not bind to kernel dri=
ver
> > > > has one big problem. If kernel introduce new wmi driver for such GU=
ID
> > > > then it block userspace to access it or at least would need to prov=
ide
> > > > audit filter and something would be probably filtered. It means tha=
t
> > > > some userspace applications which would use that GUIDs stops workin=
g
> > > > after upgrading to new kernel. And we can be in situation where *us=
er*
> > > > need to decide: either use 3rd party userspace application from ven=
dor
> > > > which provide some special settings for your laptop, or use kernel
> > > > module which provides standard rfkill/led/input class driver.
> > > >
> > >
> > > If this proposal goes forward it would sound like to me an audit filt=
er
> > > would become a prerequisite for any new WMI kernel driver.  This is n=
ot
> > > a problem to me.
> >
> > Not for any wmi driver, only for those which would like to export wmi
> > device to userspace.
>=20
> Correct.
>=20
> >
> > > This audience recommends the way for users to configure the system bu=
t
> > > of course cannot stop users from doing what they decide to do.
> >
> > Of course, but in above hypothetical example, user is in situation wher=
e
> > is unable to use both 3rd vendor application and together kernel
> > rfkill/led/input driver. User must decide (by e.g. modprobe blacklist o=
r
> > manual module loading) what want to use.
> >
> > But ideal solution is that both 3rd vendor application for firmware
> > settings and also rfkill kernel driver would work together without need
> > to rmmod/modprobe modules and without restarting 3rd vendor application=
.
> >
> > > We're all in agreement that the kernel should keep responsibility for=
 some
> > > of these functionalities.
> > > If a new kernel WMI driver duplicates functionality that happens to f=
ind its
> > > way in userspace and the kernel audits that out yes the userspace
> > > application may start to  have less functionality, but better support
> > > would live in the kernel and the user would be better supported by
> > > the stack (for example could use standard rfkill userspace utilities)=
.
> >
>=20
> Pali has raised a very good point which I want to get some feedback from =
Linus,
> and perhaps tglx, hpa, and gregkh on. While Mario is expressing a very pr=
agmatic
> approach which I certainly appreciate, we have a very strong position tha=
t we do
> not break userspace.
>=20
> There have been exceptions for specific pseudo filesystems and such, but =
they
> are rare. We would need to document the WMI commitment from the kernel to
> userspace (e.g. any call may be filtered based on current Linux kernel WM=
I
> usage, which may change over time). This sounds troublesome... will give =
this
> some more thought.
>=20

There are other examples in the kernel of the same data accessible in multi=
ple
different methods that can cause inconsistencies too.

> > Ok. So it is acceptable solution/API/ABI for you & other Dell people?
> > Or is something more or different needed?
> >
> > Darren, I hope that I understood your proposal with explicit whitelist
> > correctly. And is there already another vendor which want to use wmi
> > userspace on linux?
>=20
> It might be moot with Christoph's dynamic ID comment which I need to go r=
eview
> in detail. Putting that aside for a moment, what I intended was for the p=
latform
> driver to whitelist GUIDs. But, that doesn't necessarily mean it has an e=
xplicit
> list. The platform driver could have a blacklist and then walk through al=
l
> available GUIDs and export everything except those on the blacklist.

To get this started can you re-review Andy's platform/wmi tree and merge in=
 some
of his bus work?  Regardless of the outcome of the access to userspace and =
dynamic
binding this is a good direction for WMI support in platform/drivers/x86 to=
 get started.

>=20
> Now with Christoph's idea, we may be able to maintain a blacklist of GUID=
s and a
> whitelist of platforms which CAN export WMI, but not export any until use=
rspace
> requests a specific GUID be exported at which point it is checked against=
 the
> blacklist and then exported accordingly, at which point the WMI method fi=
lters
> handle the rest.
>=20

I've been studying more about how this access to WMI BIOS functions on Wind=
ows
works this week and uncovered what I see as another set of related question=
s around
commitment to manageability access from the OS with this potential userspac=
e layer.

On Windows what happens is the MOF data (same stuff exposed by Andy's wmi-m=
of)
is imported into the WMI namespace.  This allows any tools to know exactly =
how
to interact with the various GUID's associated to the ASL methods.  The for=
mat of the
data and the arguments supported are encoded directly in that MOF data.

This means that standard WBEM tools are able to interact directly with thes=
e methods
based upon exposed objects.  BIOS manufacturer can expose say all BIOS sett=
ings that=20
are integer to a GUID for interacting with integer settings and those would=
 get loaded=20
into the WMI namespace.  When someone uses a WBEM tool to modify that objec=
t
the data is properly formatted into the correct arguments for an integer an=
d then run=20
through the ASL.  Another GUID might be made for strings and another for sp=
ecially
crafted lists (like a boot order).  The important part is that all settings=
 are discoverable
and no extra tools are needed to administer a box.  It can all be done from=
 things like=20
PowerShell or wmic.

In an ideal world I think this is the right solution for Linux too, as part=
 of this pipe we've
discussed let some userspace Linux WBEM tools like OpenLMI have access to a=
 BIOS
provider that can interact with various settings.

Unfortunately the MOF data that comes out of wmi-mof is so called "Binary M=
OF" which
has been pre-compiled to an intermediate format with mofcomp.exe on Windows=
.
The format of binary MOF is not documented and the only known way to get te=
xt=20
mof back out is by using mofcomp.exe with some esoteric arguments.

mofcomp.exe -MOF:recovered.mof -MFL:ms_409.mof -Amendment:MS_409 binary_mof=
_file

So with that said, what role should the Linux kernel actually play here?

My thought is it still makes sense to make this pipe available to potential=
ly enable WBEM
tools at some point.  At least until a way to deconstruct binary MOF is mad=
e available,
it's conceivable to build a provider from reverse engineered discovery of h=
ow the ASL works,
it just won't be as "pretty" as the type of data you get out of MOF with na=
me and value mappings.
