From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Fans at full speed after resume
Date: Mon, 27 May 2013 13:04:28 +0800
Message-ID: <1369631068.2159.2.camel@rzhang1-mobl4>
References: <CAPz6YkWr_D504UdeqXB0FXxgqOt3GYnF09ctoMaZ8P-znbVMGQ@mail.gmail.com>
	 <1368591999.5890.9.camel@rzhang1-mobl4>
	 <1368592193.5890.10.camel@rzhang1-mobl4> <knj3oe$h88$1@ger.gmane.org>
	 <1369275908.2036.11.camel@rzhang1-mobl4> <1Ufc0I-09RzDk0@fwd03.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:24271 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261Ab3E0FEz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 27 May 2013 01:04:55 -0400
In-Reply-To: <1Ufc0I-09RzDk0@fwd03.t-online.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael =?ISO-8859-1?Q?Gro=DFh=E4user?= <michael.grosshaeuser@t-online.de>
Cc: Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, 2013-05-23 at 22:22 +0200, Michael Gro=C3=9Fh=C3=A4user wrote:
> Zhang Rui wrote:
>=20
> > On Wed, 2013-05-22 at 20:46 +0200, Michael Gro=C3=9Fh=C3=A4user wro=
te:
> >> Zhang Rui wrote:
> >>=20
> >> > On Wed, 2013-05-15 at 12:26 +0800, Zhang Rui wrote:
> >> >> please
> >> >>=20
> >> >> On Tue, 2013-05-14 at 21:18 -0700, Sonny Rao wrote:
> >> >> > Hi, I've seen a regression in kernels since 3.7 on x86 device=
s where
> >> >> > the kernel turns the system fans on to max speed after resumi=
ng from
> >> >> > ram.  Other people have noticed it as well, for example see
> >> >> > https://bugzilla.redhat.com/show_bug.cgi?id=3D895276
> >> >> >=20
> >> >> please check if this is a duplicate of bug
> >> >> https://bugzilla.kernel.org/show_bug.cgi?id=3D56591
> >> > or you can try 3.10-rc1 to see if the problem still exists or no=
t.
> >> >=20
> >> > thanks,
> >> > rui
> >>=20
> >>=20
> >> Hi,
> >>=20
> >> I can confirm the same problem on a HP/Compaq 2510p with 3.10-rc2.
> >>=20
> > please check if this is a duplicate of bug
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D58301
> >=20
> > please try the patch at comment #7 and see if it helps or not.
> >=20
Good to know.
then could you please try the four patches in comment #10, #11, #12 and
#13 in
https://bugzilla.kernel.org/show_bug.cgi?id=3D58301
without the previous patch and check if they help?

These four patches are the fixes that I would push for upstream.

thanks,
rui
> > thanks,
> > rui
>=20
> Hi,
>=20
> the patch fixes the problem for me.
>=20
> Thanks,
> Michael=20
>=20
>=20
> >> Best Regards,
> >> Michael
> >>=20
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-pm=
" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html


