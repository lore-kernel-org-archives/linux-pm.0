From: Michael =?UTF-8?B?R3Jvw59ow6R1c2Vy?=
	<michael.grosshaeuser@t-online.de>
Subject: Re: Fans at full speed after resume
Date: Thu, 23 May 2013 22:22:04 +0200
Message-ID: <knltmt$76t$1@ger.gmane.org>
References: <CAPz6YkWr_D504UdeqXB0FXxgqOt3GYnF09ctoMaZ8P-znbVMGQ@mail.gmail.com> <1368591999.5890.9.camel@rzhang1-mobl4> <1368592193.5890.10.camel@rzhang1-mobl4> <knj3oe$h88$1@ger.gmane.org> <1369275908.2036.11.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Zhang Rui wrote:

> On Wed, 2013-05-22 at 20:46 +0200, Michael Gro=C3=9Fh=C3=A4user wrote=
:
>> Zhang Rui wrote:
>>=20
>> > On Wed, 2013-05-15 at 12:26 +0800, Zhang Rui wrote:
>> >> please
>> >>=20
>> >> On Tue, 2013-05-14 at 21:18 -0700, Sonny Rao wrote:
>> >> > Hi, I've seen a regression in kernels since 3.7 on x86 devices =
where
>> >> > the kernel turns the system fans on to max speed after resuming=
 from
>> >> > ram.  Other people have noticed it as well, for example see
>> >> > https://bugzilla.redhat.com/show_bug.cgi?id=3D895276
>> >> >=20
>> >> please check if this is a duplicate of bug
>> >> https://bugzilla.kernel.org/show_bug.cgi?id=3D56591
>> > or you can try 3.10-rc1 to see if the problem still exists or not.
>> >=20
>> > thanks,
>> > rui
>>=20
>>=20
>> Hi,
>>=20
>> I can confirm the same problem on a HP/Compaq 2510p with 3.10-rc2.
>>=20
> please check if this is a duplicate of bug
> https://bugzilla.kernel.org/show_bug.cgi?id=3D58301
>=20
> please try the patch at comment #7 and see if it helps or not.
>=20
> thanks,
> rui

Hi,

the patch fixes the problem for me.

Thanks,
Michael=20


>> Best Regards,
>> Michael
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
