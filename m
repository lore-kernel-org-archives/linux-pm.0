From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: Re: [PATCH v3] PM / devfreq: Restart previous governor if new
 governor fails to start
Date: Tue, 11 Dec 2018 16:18:18 +0900
Message-ID: <20181211071818epcms1p30d107ed61043d39b38960ef1616282a0@epcms1p3>
References: <5C0F4C9A.8030607@samsung.com>
        <1477509425-16936-1-git-send-email-skannan@codeaurora.org>
        <de0f8010-31b2-8cec-f793-393c2199f44d@samsung.com>
        <5820CE7E.40802@codeaurora.org> <5821948B.2010907@samsung.com>
        <58223AF1.2030605@codeaurora.org> <58227CDB.6050907@samsung.com>
        <58228B9E.2090108@samsung.com> <58228C10.3070502@samsung.com>
        <58238840.90802@codeaurora.org> <5823BB01.3090502@samsung.com>
        <5164dea6-ad0c-d817-eb0d-36d9f4a718d4@codeaurora.org>
        <CGME20161026191715epcas1p311c2c626563a736e14c83fb0504c099e@epcms1p3>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5C0F4C9A.8030607@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Saravana Kannan <skannan@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kyungmin Park <kyungmin.park@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> Hi Saravana,
>=20
> The devfreq git repo is maintained by Myungjoo Ham.
> you can check it on MAINTAINERS file.
>=20
> I think that you better to resend mail to mainline
> with my reviewed tag because the devfreq core could be modified
> and then merge conflict might be happen when apply this patch.
>=20
> Regards,
> Chanwoo Choi
>=20
> On 2018=EB=85=84=2012=EC=9B=94=2008=EC=9D=BC=2005:29,=20Saravana=20Kannan=
=20wrote:=0D=0A>=20>=20=0D=0A>=20>=20On=2011/9/16=204:10=20PM,=20Chanwoo=20=
Choi=20wrote:=0D=0A>=20>>=20After=20fixing=20the=20bug=20of=20devfreq_add_d=
evice(),=0D=0A>=20>>=20I'll=20remove=20the=20unneeded=20'if=20statement'=20=
of=20prev_governor=20in=20governor_store.=0D=0A>=20>=20=0D=0A>=20>=20It's=
=20been=202=20years=20and=20this=20patch=20still=20hasn't=20been=20picked=
=20up.=20Can=20we=20please=20pick=20this=20up=20and=20get=20this=20into=20t=
he=20next=20kernel=20release?=0D=0A>=20>=20=0D=0A>=20>=20Thanks,=0D=0A>=20>=
=20=0D=0A>=20>=20Saravana=0D=0A>=20>=20=0D=0A=0D=0AIf=20that's=20already=20=
2=20years=20old,=20please=20rebase,=20test=20to=20see=20if=20that's=0D=0Ast=
ill=20valid=20with=20today's=20kernel,=20and=20resubmit.=0D=0A=0D=0ASorry=
=20for=20missing=20it,=20right=20now,=20after=202=20years,=0D=0AI=20just=20=
can't=20remember=20this=20one.=0D=0A=0D=0ACheers,=0D=0AMyungJoo=0D=0A=0D=0A
