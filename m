From: <Mario.Limonciello@dell.com>
Subject: RE: Regression on Dell XPS13 (was: [char-misc for 4.10-rc4 V2] mei:
 bus: enable OS version only for SPT and newer)
Date: Fri, 20 Jan 2017 23:11:45 +0000
Message-ID: <52d8844460324d62b6e10dd540f64351@ausx13mpc120.AMER.DELL.COM>
References: <5549d8c0527412390d71236d80dff419@molgen.mpg.de>
 <20170114193959.GA30750@kroah.com>
 <5B8DA87D05A7694D9FA63FD143655C1B5437C2D3@hasmsx108.ger.corp.intel.com>
 <20170115105830.GD26374@kroah.com> <20170116110539.GA1307@kroah.com>
 <1b1feb50-2b22-b7e7-0fb8-2011340f5c47@leemhuis.info>
 <55b349b2-2999-94d5-9f68-b1944df1d374@molgen.mpg.de>
 <954f9b4e8bd844c98f8d3c12f0fe366f@ausx13mpc120.AMER.DELL.COM>
 <20170117182337.GB12600@kroah.com>
 <4fc46eab4a174e44b6d28b7ecf979ec9@ausx13mpc120.AMER.DELL.COM>
 <20170117233346.GA2599@wisp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170117233346.GA2599@wisp>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: dvhart@infradead.org, rafael.j.wysocki@intel.com, pmenzel@molgen.mpg.de, linux@leemhuis.info, tomas.winkler@intel.com, jan@gondor.com, alexander.usyskin@intel.com, linux-kernel@vger.kernel.org, yu.c.chen@intel.com, tomi.p.sarvela@intel.com, daniel@quora.org, len.brown@intel.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Greg,

> -----Original Message-----
> From: Darren Hart [mailto:dvhart@infradead.org]
> Sent: Tuesday, January 17, 2017 5:34 PM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Cc: gregkh@linuxfoundation.org; rafael.j.wysocki@intel.com;
> pmenzel@molgen.mpg.de; linux@leemhuis.info; tomas.winkler@intel.com;
> jan@gondor.com; alexander.usyskin@intel.com; linux-kernel@vger.kernel.org=
;
> yu.c.chen@intel.com; tomi.p.sarvela@intel.com; daniel@quora.org;
> len.brown@intel.com; linux-pm@vger.kernel.org
> Subject: Re: Regression on Dell XPS13 (was: [char-misc for 4.10-rc4 V2] m=
ei:
> bus: enable OS version only for SPT and newer)
>=20
> On Tue, Jan 17, 2017 at 06:38:43PM +0000, Mario.Limonciello@dell.com
> wrote:
> > > -----Original Message-----
> > > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > > Sent: Tuesday, January 17, 2017 12:24 PM
> > > To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> > > Cc: pmenzel@molgen.mpg.de; rafael.j.wysocki@intel.com;
> > > linux@leemhuis.info; tomas.winkler@intel.com; jan@gondor.com;
> > > alexander.usyskin@intel.com; linux-kernel@vger.kernel.org;
> > > yu.c.chen@intel.com; tomi.p.sarvela@intel.com; daniel@quora.org;
> > > len.brown@intel.com; linux-pm@vger.kernel.org
> > > Subject: Re: Regression on Dell XPS13 (was: [char-misc for 4.10-rc4 V=
2] mei:
> > > bus: enable OS version only for SPT and newer)
> > >
> > > On Tue, Jan 17, 2017 at 04:57:49PM +0000, Mario.Limonciello@dell.com
> > > wrote:
> > > > So in the <6s scenario, the intel-hid driver is responsible to
> > > > receive the ACPI event and process accordingly.  The maintainer
> > > > has a patch ready for the intel-hid portion of this work, but it's
> > > > currently being reviewed by Intel to ensure it can be legally submi=
tted
> into the kernel.
> > >
> > > Who at Intel do I need to go kick to make this mythical legal review
> > > happen faster so we can see the code?
> > >
> > > Len and Rafael, what is going on here?
> > >
> >
> > Len and Darren are both in the loop on the discussion around this patch=
.
> > I don't know if they'll have any (public) comments they can add on the
> > matter yet however.
>=20
> Thanks Mario. Yes, there isn't much to say here in public other than to c=
onfirm
> we are keenly aware of the problem and have been actively working on fixi=
ng
> it, both for this instance, and the deeper systematic failure that result=
ed in this
> situation. No amount of kicking will expedite the process at this point, =
but
> should we feel the need, we'll reach out.
>=20

The approval has come through and the patch has been submitted.
http://www.spinics.net/lists/platform-driver-x86/msg10286.html

Note: this is only half of the fix, the second half needs the ACPI subsyste=
m to
not be frozen to be able to receive this event.
