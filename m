From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: Re: [PATCH v3 2/5] devfreq: add support for suspend/resume of a
 devfreq device
Date: Tue, 11 Dec 2018 10:43:15 +0900
Message-ID: <20181211014315epcms1p153a54217e587fd76a8198db77762699a@epcms1p1>
References: <5C0878C0.4060500@samsung.com>
        <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
        <1544007956-28889-3-git-send-email-l.luba@partner.samsung.com>
        <CGME20181205110620eucas1p14de70dc092580b684a0304b5ce771605@epcms1p1>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5C0878C0.4060500@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Luba <l.luba@partner.samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "tjakobi@math.uni-bielefeld.de" <tjakobi@math.uni-bielefeld.de>, Kyungmin Park <kyungmin.park@samsung.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "keescook@chromium.org" <keescook@chromium.org>, "anton@enomsg.org" <anton@enomsg.org>, "ccross@android.com" <ccross@android.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "kgene@kernel.org" <kgene@kernel.org>, "krzk@kernel.org" <krzk@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

> Hi Lukasz,
>=20
> On 2018=EB=85=84=2012=EC=9B=94=2005=EC=9D=BC=2020:05,=20Lukasz=20Luba=20w=
rote:=0D=0A>=20>=20The=20patch=20prepares=20devfreq=20device=20for=20handli=
ng=20suspend/resume=0D=0A>=20>=20functionality.=20The=20new=20fields=20will=
=20store=20needed=20information=20during=20this=0D=0A>=20>=20process.=20Dev=
freq=20framework=20handles=20opp-suspend=20DT=20entry=20and=20there=20is=20=
no=0D=0A>=20>=20need=20of=20modyfications=20in=20the=20drivers=20code.=20It=
=20uses=20atomic=20variables=20to=0D=0A>=20>=20make=20sure=20no=20race=20co=
ndition=20affects=20the=20process.=0D=0A>=20>=20=0D=0A>=20>=20Suggested-by:=
=20Tobias=20Jakobi=20<tjakobi=40math.uni-bielefeld.de>=0D=0A>=20>=20Suggest=
ed-by:=20Chanwoo=20Choi=20<cw00.choi=40samsung.com>=0D=0A>=20>=20Signed-off=
-by:=20Lukasz=20Luba=20<l.luba=40partner.samsung.com>=0D=0A>=20>=20---=0D=
=0A>=20>=20=20drivers/devfreq/devfreq.c=20=7C=2047=20++++++++++++++++++++++=
+++++++++++++++++++------=0D=0A>=20>=20=20include/linux/devfreq.h=20=20=20=
=7C=20=207=20+++++++=0D=0A>=20>=20=202=20files=20changed,=2048=20insertions=
(+),=206=20deletions(-)=0D=0A>=20=0D=0A>=20Reviewed-by:=20Chanwoo=20Choi=20=
<cw00.choi=40samsung.com>=0D=0A>=20=0D=0A=0D=0ALooks=20goot=20do=20me=20as=
=20well.=0D=0A=0D=0AAcked-by:=20MyungJoo=20Ham=20<myungjoo.ham=40samsung.co=
m>=0D=0A=0D=0A=0D=0AAnyway,=20for=20the=20sake=20of=20curiosity...=0D=0A=0D=
=0AHaving=20suspend-frequency=20is=20usually=20required=20when=0D=0Athe=20f=
requency=20configuration=20is=20reset=20with=20suspend-resume=0D=0Aas=20old=
er=20Exynos's=20CPU=20did=20(I=20don't=20know=20whether=20it=20still=20does=
).=0D=0A=0D=0ADoes=20GPU=20do=20this=20as=20well?=0D=0A(memory-bus=20won't=
=20do=20this=20because=20they=20are=20kept=20turned=20on=20during=20suspend=
)=0D=0A=0D=0A=0D=0ACheers,=0D=0AMyungJoo=0D=0A
