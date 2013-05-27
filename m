From: Michael =?UTF-8?B?R3Jvw59ow6R1c2Vy?=
	<michael.grosshaeuser@t-online.de>
Subject: Re: Fans at full speed after resume
Date: Mon, 27 May 2013 22:36:19 +0200
Message-ID: <ko0g1j$fc1$1@ger.gmane.org>
References: <CAPz6YkWr_D504UdeqXB0FXxgqOt3GYnF09ctoMaZ8P-znbVMGQ@mail.gmail.com> <1368591999.5890.9.camel@rzhang1-mobl4> <1368592193.5890.10.camel@rzhang1-mobl4> <knj3oe$h88$1@ger.gmane.org> <1369275908.2036.11.camel@rzhang1-mobl4> <1Ufc0I-09RzDk0@fwd03.t-online.de> <1369631068.2159.2.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:37523 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757261Ab3E0UfR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 27 May 2013 16:35:17 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gll-linux-pm2@m.gmane.org>)
	id 1Uh48R-0002QJ-UJ
	for linux-pm@vger.kernel.org; Mon, 27 May 2013 22:35:15 +0200
Received: from p5ddcb160.dip0.t-ipconnect.de ([93.220.177.96])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2013 22:35:15 +0200
Received: from michael.grosshaeuser by p5ddcb160.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2013 22:35:15 +0200
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Zhang Rui wrote:

> On Thu, 2013-05-23 at 22:22 +0200, Michael Gro=C3=9Fh=C3=A4user wrote=
:
>> Zhang Rui wrote:
>>=20
>> > On Wed, 2013-05-22 at 20:46 +0200, Michael Gro=C3=9Fh=C3=A4user wr=
ote:
>> >> Zhang Rui wrote:
>> >>=20
>> >> > On Wed, 2013-05-15 at 12:26 +0800, Zhang Rui wrote:
>> >> >> please
>> >> >>=20
>> >> >> On Tue, 2013-05-14 at 21:18 -0700, Sonny Rao wrote:
>> >> >> > Hi, I've seen a regression in kernels since 3.7 on x86 devic=
es
>> >> >> > where the kernel turns the system fans on to max speed after
>> >> >> > resuming from
>> >> >> > ram.  Other people have noticed it as well, for example see
>> >> >> > https://bugzilla.redhat.com/show_bug.cgi?id=3D895276
>> >> >> >=20
>> >> >> please check if this is a duplicate of bug
>> >> >> https://bugzilla.kernel.org/show_bug.cgi?id=3D56591
>> >> > or you can try 3.10-rc1 to see if the problem still exists or n=
ot.
>> >> >=20
>> >> > thanks,
>> >> > rui
>> >>=20
>> >>=20
>> >> Hi,
>> >>=20
>> >> I can confirm the same problem on a HP/Compaq 2510p with 3.10-rc2=
=2E
>> >>=20
>> > please check if this is a duplicate of bug
>> > https://bugzilla.kernel.org/show_bug.cgi?id=3D58301
>> >=20
>> > please try the patch at comment #7 and see if it helps or not.
>> >=20
> Good to know.
> then could you please try the four patches in comment #10, #11, #12 a=
nd
> #13 in
> https://bugzilla.kernel.org/show_bug.cgi?id=3D58301
> without the previous patch and check if they help?
>=20
> These four patches are the fixes that I would push for upstream.

Hi,

I applied the patches to 3.10-rc2 and it works well after several suspe=
nd=20
resume cycles. Feel free to add me as Tested-by.

Best regards,
Michael=20

> thanks,
> rui
>> > thanks,
>> > rui
>>=20
>> Hi,
>>=20
>> the patch fixes the problem for me.
>>=20
>> Thanks,
>> Michael
>>=20
>>=20
>> >> Best Regards,
>> >> Michael
>> >>=20
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe linux-p=
m" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


