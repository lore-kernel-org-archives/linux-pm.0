From: <Mario.Limonciello@dell.com>
Subject: RE: RFC: WMI Enhancements
Date: Mon, 8 May 2017 19:11:57 +0000
Message-ID: <2aa696fd37b24c2ca18fc9f30b664ab1@ausx13mpc120.AMER.DELL.COM>
References: <775ffd8f3327497cabd15ee7826cedaf@ausx13mpc120.AMER.DELL.COM>
 <20170505234436.GB25865@fury>
 <beb9a835eaf243fab151627e919eccf3@ausx13mpc120.AMER.DELL.COM>
 <CALCETrUgPgk7uVdYx4zJzXQHpk5zALmzSp3Zcz9+FPAe6bA5LQ@mail.gmail.com>
 <20170508152907.GA17700@fury>
 <f8a3fa82d06142838ea39d8b1db7c25b@ausx13mpc120.AMER.DELL.COM>
 <20170508154725.GD17700@fury>
 <CAHp75VdZrdBMGLcXoZhsjd14jbDaYMikThon6hC-s3fWsGb0ug@mail.gmail.com>
 <CAOg5c--wkQgvsmhTynAKyG9iWaHjRWC5Z+MXzVJVw66vxSz4Zw@mail.gmail.com>
 <27661c9222e2452aa78ab1d1c1cd9015@ausx13mpc120.AMER.DELL.COM>
 <20170508190900.GF17700@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:21024 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754570AbdEHTMA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2017 15:12:00 -0400
In-Reply-To: <20170508190900.GF17700@fury>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: dvhart@infradead.org
Cc: a.bokovoy@gmail.com, andy.shevchenko@gmail.com, luto@kernel.org, pali.rohar@gmail.com, rjw@rjwysocki.net, len.brown@intel.com, corentin.chary@gmail.com, andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org

> -----Original Message-----
> From: Darren Hart [mailto:dvhart@infradead.org]
> Sent: Monday, May 8, 2017 2:09 PM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Cc: a.bokovoy@gmail.com; andy.shevchenko@gmail.com; luto@kernel.org;
> pali.rohar@gmail.com; rjw@rjwysocki.net; len.brown@intel.com;
> corentin.chary@gmail.com; andriy.shevchenko@linux.intel.com; linux-
> kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; linux-
> pm@vger.kernel.org
> Subject: Re: RFC: WMI Enhancements
>=20
> On Mon, May 08, 2017 at 06:26:53PM +0000, Mario.Limonciello@dell.com wrot=
e:
> > (Responding as plain text, your email probably got punted from the ML f=
rom
> being HTML)
> >
> > >
> > > ...
> > >
> > > I'm not sure what you are asking about. Samba does not deal with WMI =
at all.
> The state of affairs is
> > > explained at https://powershell.org/2015/04/24/management-information=
-
> the-omicimwmimidmtf-dictionary/
> > > -- old WMI (DCOM/RPC-based) is deprecated, new WMI based on WS-MAN is
> supported and OMI is the
> > > implementation. We used to have a very limited attemt at writing DCOM=
 stack
> and nobody worked on
> > > it for years so it got removed.
> >
> > Thanks!  That was a very interesting read.
> >
> > > Microsoft has already published a MOF parser as part of OMI work:
> https://github.com/Microsoft/omi/
> > > under MIT license.
> >
> > Unfortunately that's expecting text MOF, not this intermediary compiled=
 format.
> >
>=20
> I presume which of these to use is the decision of the vendor?=20

No, MS documentation indicates to store binary MOF in the ACPI buffer.

>Is there a
> transition going on from BMOF to Text MOF? Or will both be part of produc=
ts for
> the near term?
>=20

Binary MOF will be part of products unless MS or a standards group decides =
to=20
announce something new for OEM's to use in this space.

> I'm trying to understand if BMOF is a legacy thing now, or if it will con=
tinue
> to be used in new designs.

Should be continued to use in new designs.
