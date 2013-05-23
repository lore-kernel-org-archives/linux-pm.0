From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Fans at full speed after resume
Date: Thu, 23 May 2013 10:25:08 +0800
Message-ID: <1369275908.2036.11.camel@rzhang1-mobl4>
References: <CAPz6YkWr_D504UdeqXB0FXxgqOt3GYnF09ctoMaZ8P-znbVMGQ@mail.gmail.com>
	 <1368591999.5890.9.camel@rzhang1-mobl4>
	 <1368592193.5890.10.camel@rzhang1-mobl4> <knj3oe$h88$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <knj3oe$h88$1@ger.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael =?ISO-8859-1?Q?Gro=DFh=E4user?= <michael.grosshaeuser@t-online.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2013-05-22 at 20:46 +0200, Michael Gro=C3=9Fh=C3=A4user wrote:
> Zhang Rui wrote:
>=20
> > On Wed, 2013-05-15 at 12:26 +0800, Zhang Rui wrote:
> >> please
> >>=20
> >> On Tue, 2013-05-14 at 21:18 -0700, Sonny Rao wrote:
> >> > Hi, I've seen a regression in kernels since 3.7 on x86 devices w=
here
> >> > the kernel turns the system fans on to max speed after resuming =
from
> >> > ram.  Other people have noticed it as well, for example see
> >> > https://bugzilla.redhat.com/show_bug.cgi?id=3D895276
> >> >=20
> >> please check if this is a duplicate of bug
> >> https://bugzilla.kernel.org/show_bug.cgi?id=3D56591
> > or you can try 3.10-rc1 to see if the problem still exists or not.
> >=20
> > thanks,
> > rui
>=20
>=20
> Hi,
>=20
> I can confirm the same problem on a HP/Compaq 2510p with 3.10-rc2.
>=20
please check if this is a duplicate of bug
https://bugzilla.kernel.org/show_bug.cgi?id=3D58301

please try the patch at comment #7 and see if it helps or not.

thanks,
rui
> Best Regards,
> Michael
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
