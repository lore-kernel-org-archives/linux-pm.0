From: <Mario.Limonciello@dell.com>
Subject: RE: Regression on Dell XPS13 (was: [char-misc for 4.10-rc4 V2] mei:
 bus: enable OS version only for SPT and newer)
Date: Tue, 24 Jan 2017 20:24:05 +0000
Message-ID: <f0d7adf0ff314704bf035badd8a6a897@ausx13mpc120.AMER.DELL.COM>
References: <5B8DA87D05A7694D9FA63FD143655C1B5437C2D3@hasmsx108.ger.corp.intel.com>
 <20170115105830.GD26374@kroah.com> <20170116110539.GA1307@kroah.com>
 <1b1feb50-2b22-b7e7-0fb8-2011340f5c47@leemhuis.info>
 <55b349b2-2999-94d5-9f68-b1944df1d374@molgen.mpg.de>
 <954f9b4e8bd844c98f8d3c12f0fe366f@ausx13mpc120.AMER.DELL.COM>
 <20170117182337.GB12600@kroah.com>
 <4fc46eab4a174e44b6d28b7ecf979ec9@ausx13mpc120.AMER.DELL.COM>
 <20170117233346.GA2599@wisp>
 <52d8844460324d62b6e10dd540f64351@ausx13mpc120.AMER.DELL.COM>
 <20170121091112.GD27048@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170121091112.GD27048@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, alex.hung@canonical.com
Cc: dvhart@infradead.org, rafael.j.wysocki@intel.com, pmenzel@molgen.mpg.de, linux@leemhuis.info, tomas.winkler@intel.com, jan@gondor.com, alexander.usyskin@intel.com, linux-kernel@vger.kernel.org, yu.c.chen@intel.com, tomi.p.sarvela@intel.com, daniel@quora.org, len.brown@intel.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Saturday, January 21, 2017 3:11 AM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Cc: dvhart@infradead.org; rafael.j.wysocki@intel.com;
> pmenzel@molgen.mpg.de; linux@leemhuis.info; tomas.winkler@intel.com;
> jan@gondor.com; alexander.usyskin@intel.com; linux-kernel@vger.kernel.org=
;
> yu.c.chen@intel.com; tomi.p.sarvela@intel.com; daniel@quora.org;
> len.brown@intel.com; linux-pm@vger.kernel.org
> Subject: Re: Regression on Dell XPS13 (was: [char-misc for 4.10-rc4 V2] m=
ei:
> bus: enable OS version only for SPT and newer)
>=20
> On Fri, Jan 20, 2017 at 11:11:45PM +0000, Mario.Limonciello@dell.com wrot=
e:
> > Greg,
> >
> > > -----Original Message-----
> > > From: Darren Hart [mailto:dvhart@infradead.org]
> > > Sent: Tuesday, January 17, 2017 5:34 PM
> > > To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> > > Cc: gregkh@linuxfoundation.org; rafael.j.wysocki@intel.com;
> > > pmenzel@molgen.mpg.de; linux@leemhuis.info;
> tomas.winkler@intel.com;
> > > jan@gondor.com; alexander.usyskin@intel.com; linux-
> kernel@vger.kernel.org;
> > > yu.c.chen@intel.com; tomi.p.sarvela@intel.com; daniel@quora.org;
> > > len.brown@intel.com; linux-pm@vger.kernel.org
> > > Subject: Re: Regression on Dell XPS13 (was: [char-misc for 4.10-rc4 V=
2] mei:
> > > bus: enable OS version only for SPT and newer)
> > >
> > > On Tue, Jan 17, 2017 at 06:38:43PM +0000, Mario.Limonciello@dell.com
> > > wrote:
> > > > > -----Original Message-----
> > > > > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > > > > Sent: Tuesday, January 17, 2017 12:24 PM
> > > > > To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> > > > > Cc: pmenzel@molgen.mpg.de; rafael.j.wysocki@intel.com;
> > > > > linux@leemhuis.info; tomas.winkler@intel.com; jan@gondor.com;
> > > > > alexander.usyskin@intel.com; linux-kernel@vger.kernel.org;
> > > > > yu.c.chen@intel.com; tomi.p.sarvela@intel.com; daniel@quora.org;
> > > > > len.brown@intel.com; linux-pm@vger.kernel.org
> > > > > Subject: Re: Regression on Dell XPS13 (was: [char-misc for 4.10-r=
c4 V2]
> mei:
> > > > > bus: enable OS version only for SPT and newer)
> > > > >
> > > > > On Tue, Jan 17, 2017 at 04:57:49PM +0000,
> Mario.Limonciello@dell.com
> > > > > wrote:
> > > > > > So in the <6s scenario, the intel-hid driver is responsible to
> > > > > > receive the ACPI event and process accordingly.  The maintainer
> > > > > > has a patch ready for the intel-hid portion of this work, but i=
t's
> > > > > > currently being reviewed by Intel to ensure it can be legally s=
ubmitted
> > > into the kernel.
> > > > >
> > > > > Who at Intel do I need to go kick to make this mythical legal rev=
iew
> > > > > happen faster so we can see the code?
> > > > >
> > > > > Len and Rafael, what is going on here?
> > > > >
> > > >
> > > > Len and Darren are both in the loop on the discussion around this p=
atch.
> > > > I don't know if they'll have any (public) comments they can add on =
the
> > > > matter yet however.
> > >
> > > Thanks Mario. Yes, there isn't much to say here in public other than =
to
> confirm
> > > we are keenly aware of the problem and have been actively working on
> fixing
> > > it, both for this instance, and the deeper systematic failure that re=
sulted in
> this
> > > situation. No amount of kicking will expedite the process at this poi=
nt, but
> > > should we feel the need, we'll reach out.
> > >
> >
> > The approval has come through and the patch has been submitted.
> > http://www.spinics.net/lists/platform-driver-x86/msg10286.html
>=20
> Looks like it needs some work :)
>=20

+Alex @ Canonical

Yeah, hopefully Alex knocks out those and turns it around quickly.

> And why isn't it tagged to go to the 4.10-stable kernel if it really
> does fix some systems?

A matter of timing, none of us had anticipated the legal hold
that had occurred around this particular patch.  When he resubmits
it with the fixes needed from the other review, he should submit it
to 4.10-stable too.

Thanks,
