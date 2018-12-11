From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: Re: [PATCH v3 3/5] devfreq: add devfreq_suspend/resume()
 functions
Date: Tue, 11 Dec 2018 11:45:14 +0900
Message-ID: <20181211024514epcms1p3ad01341631793f00a4161ff39139a1ce@epcms1p3>
References: <5C087BC3.1050405@samsung.com>
        <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
        <1544007956-28889-4-git-send-email-l.luba@partner.samsung.com>
        <CGME20181205110622eucas1p23d788afd54ad34c0a2663efac8734648@epcms1p3>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5C087BC3.1050405@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Luba <l.luba@partner.samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "tjakobi@math.uni-bielefeld.de" <tjakobi@math.uni-bielefeld.de>, Kyungmin Park <kyungmin.park@samsung.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "keescook@chromium.org" <keescook@chromium.org>, "anton@enomsg.org" <anton@enomsg.org>, "ccross@android.com" <ccross@android.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "kgene@kernel.org" <kgene@kernel.org>, "krzk@kernel.org" <krzk@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

> Hi Lukasz,
>=20
> On 2018=EB=85=84=2012=EC=9B=94=2005=EC=9D=BC=2020:05,=20Lukasz=20Luba=20w=
rote:=0D=0A>=20>=20This=20patch=20adds=20implementation=20for=20global=20su=
spend/resume=20for=0D=0A>=20>=20devfreq=20framework.=20System=20suspend=20w=
ill=20next=20use=20these=20functions.=0D=0A>=20>=20=0D=0A>=20>=20Suggested-=
by:=20Tobias=20Jakobi=20<tjakobi=40math.uni-bielefeld.de>=0D=0A>=20>=20Sugg=
ested-by:=20Chanwoo=20Choi=20<cw00.choi=40samsung.com>=0D=0A>=20>=20Signed-=
off-by:=20Lukasz=20Luba=20<l.luba=40partner.samsung.com>=0D=0A>=20>=20---=
=0D=0A>=20>=20=20drivers/devfreq/devfreq.c=20=7C=2044=20+++++++++++++++++++=
+++++++++++++++++++++++++=0D=0A>=20>=20=20include/linux/devfreq.h=20=20=20=
=7C=20=206=20++++++=0D=0A>=20>=20=202=20files=20changed,=2050=20insertions(=
+)=0D=0A>=20=0D=0A>=20Reviewed-by:=20Chanwoo=20Choi=20<cw00.choi=40samsung.=
com>=0D=0A=0D=0AAcked-by:=20MyungJoo=20Ham=20<myungjoo.ham=40samsung.com>=
=0D=0A=0D=0AThe=20patches=20from=201=20to=203=20are=20being=20applied=20and=
=20tested.=0D=0AI'll=20probably=20send=20pull-request=20to=20Rafael=20today=
=20after=20some=20testing=20targetting=204.21+=0D=0A=0D=0ACheers,=0D=0AMyun=
gJoo=0D=0A=0D=0A=0D=0A
