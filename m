From: <Mario.Limonciello@dell.com>
Subject: RE: RFC: WMI Enhancements
Date: Mon, 8 May 2017 16:00:52 +0000
Message-ID: <eb9aba888e854c1b92911ba2e94975b2@ausx13mpc120.AMER.DELL.COM>
References: <201704191854.51783@pali>
 <4e3e507b116443298427002c5aafed7f@ausx13mpc120.AMER.DELL.COM>
 <20170420131431.GM18887@pali> <20170420204436.GC3209@fury>
 <775ffd8f3327497cabd15ee7826cedaf@ausx13mpc120.AMER.DELL.COM>
 <20170505234436.GB25865@fury>
 <beb9a835eaf243fab151627e919eccf3@ausx13mpc120.AMER.DELL.COM>
 <CALCETrUgPgk7uVdYx4zJzXQHpk5zALmzSp3Zcz9+FPAe6bA5LQ@mail.gmail.com>
 <20170508152907.GA17700@fury>
 <f8a3fa82d06142838ea39d8b1db7c25b@ausx13mpc120.AMER.DELL.COM>
 <20170508154725.GD17700@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:58796 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751308AbdEHQBX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2017 12:01:23 -0400
In-Reply-To: <20170508154725.GD17700@fury>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: dvhart@infradead.org
Cc: luto@kernel.org, pali.rohar@gmail.com, rjw@rjwysocki.net, len.brown@intel.com, corentin.chary@gmail.com, andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org

> -----Original Message-----
> From: Darren Hart [mailto:dvhart@infradead.org]
> Sent: Monday, May 8, 2017 10:47 AM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Cc: luto@kernel.org; pali.rohar@gmail.com; rjw@rjwysocki.net;
> len.brown@intel.com; corentin.chary@gmail.com;
> andriy.shevchenko@linux.intel.com; linux-kernel@vger.kernel.org; platform=
-
> driver-x86@vger.kernel.org; linux-pm@vger.kernel.org
> Subject: Re: RFC: WMI Enhancements
>=20
> On Mon, May 08, 2017 at 03:36:31PM +0000, Mario.Limonciello@dell.com wrot=
e:
> > > -----Original Message-----
> > > From: Darren Hart [mailto:dvhart@infradead.org]
> > > Sent: Monday, May 8, 2017 10:29 AM
> > > To: Andy Lutomirski <luto@kernel.org>
> > > Cc: Limonciello, Mario <Mario_Limonciello@Dell.com>; Pali Roh=E1r
> > > <pali.rohar@gmail.com>; Rafael J. Wysocki <rjw@rjwysocki.net>; Len Br=
own
> > > <len.brown@intel.com>; Corentin Chary <corentin.chary@gmail.com>; And=
y
> > > Shevchenko <andriy.shevchenko@linux.intel.com>; linux-
> kernel@vger.kernel.org;
> > > platform-driver-x86@vger.kernel.org; linux-pm@vger.kernel.org
> > > Subject: Re: RFC: WMI Enhancements
> > >
> > > On Fri, May 05, 2017 at 06:25:08PM -0700, Andy Lutomirski wrote:
> > > > On Fri, May 5, 2017 at 5:51 PM,  <Mario.Limonciello@dell.com> wrote=
:
> > > > >> -----Original Message-----
> > > > >> From: Darren Hart [mailto:dvhart@infradead.org]
> > > > >> Sent: Friday, May 5, 2017 6:45 PM
> > > > >> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> > > > >> Cc: pali.rohar@gmail.com; rjw@rjwysocki.net; luto@amacapital.net=
;
> > > > >> len.brown@intel.com; corentin.chary@gmail.com; luto@kernel.org;
> > > > >> andriy.shevchenko@linux.intel.com; linux-kernel@vger.kernel.org;
> platform-
> > > > >> driver-x86@vger.kernel.org; linux-pm@vger.kernel.org
> > > > >> Subject: Re: RFC: WMI Enhancements
> > > >
> > > >
> > > > > I meant that to say that at least for now Andy's wmi-mof driver s=
hould still
> be
> > > merged.
> > > > > If something is going to build on top of this to do WBEM tools, t=
hey'll need
> that
> > > MOF
> > > > > data once someone figures out how to nicely deconstruct it.
> > > > >
> > > >
> > > > The thing I don't like about my own driver is that, as a WMI device
> > > > driver, it can be loaded before the rest of the bus finishes probin=
g.
> > > > So user programs that are notified asynchronously that the wmi-mof
> > > > driver is loaded and try to use future functionality (ioctl to issu=
e a
> > > > MOF-based method call?) might end up doing so before the rest of th=
e
> > > > bus is probed.
> > > >
> > > > This could be addressed by always exposing the wmi-mof device last
> > > > (sort of -- it can be a module) or perhaps by moving MOF functional=
ity
> > > > to the core driver.  Or maybe it's not really a problem.
> > >
> > > Thanks Andy, I'll keep that in mind and see if I can come up with som=
ething to
> > > address it while working on WMI this week.
> > >
> > > The other problem with wmi-mof is that there will be no immediate ope=
n
> source
> > > consumers of the interface, and none on the horizon. We can't even te=
st it to
> > > any meaningful degree on Linux. I suspect this will be met with stiff
> > > resistance.
> >
> > Well FWIW I did a quick PoC check with the binary that I got out of it =
to make
> > sure it matched what was supposed to be.  I brought it over to a Win10 =
box and
> > decompiled using the mofcmp tool and those crazy arguments I mentioned =
and
> > it was correct.
> >
> > I'd argue that even if there is no open source tools available today, n=
ot making
> > the data available to userspace makes it difficult to even attempt to s=
tart
> > to reverse engineer.
> >
> > Kernel config with default of "N" perhaps for wmi-mof?
>=20
> All true. There is a precedent we're working against on this. I'll includ=
e it in
> my leveling-up thread today or tomorrow.
>=20
> > >
> > > >
> > > > Also, isn't there a way to ask Microsoft to document this?  Are you
> > > > supposed to "ask a question" on this forum, perhaps:
> > > >
> > > > https://msdn.microsoft.com/en-us/library/gg134029.aspx
> > > >
> > > > I'm guessing the Samba team knows how to do this, too.
> > > >
> >
> > Microsoft treats this as an "intermediary" format.  I'm not convinced
> > that anyone other than MS knows anything about it today.
> >
> > I agree asking them to document it is probably the right way to go.
> >
>=20
> Mario, you are most likely in a better position to do that than I am. Wou=
ld you
> take that on?
>=20

Sure, I've made a request in that forum here:
https://social.msdn.microsoft.com/Forums/en-US/cc3e50d6-c71d-4ce7-b765-6191=
f1788697/binary-mof-format?forum=3Dos_specifications

I'll keep you apprise if there is any further details provided by MS.

Thanks,
