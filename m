From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [RESEND PATCH] PM / devfreq: Propagate error from
 devfreq_add_device()
Date: Mon, 06 Nov 2017 09:02:33 +0000
Message-ID: <20171106090233epcms1p225196088633f0720efbe5a2140ac713f@epcms1p2>
References: <20171106052741.445-1-bjorn.andersson@linaro.org>
        <CGME20171106052747epcas2p3522daee03bc1faef6643155d17e3e125@epcms1p2>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171106052741.445-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

=C2=A0=0D=0A=C2=A0=0D=0A>=20---------=20Original=20Message=20---------=0D=
=0A>=20Sender=20:=20Bjorn=20Andersson=C2=A0<bjorn.andersson=40linaro.org>=
=0D=0A>=C2=A0=0D=0A>=20Propagate=C2=A0the=C2=A0error=C2=A0of=C2=A0devfreq_a=
dd_device()=C2=A0in=C2=A0devm_devfreq_add_device()=0D=0A>=20rather=C2=A0tha=
n=C2=A0statically=C2=A0returning=C2=A0ENOMEM.=C2=A0This=C2=A0makes=C2=A0it=
=C2=A0slightly=C2=A0faster=0D=0A>=20to=C2=A0pinpoint=C2=A0the=C2=A0cause=C2=
=A0of=C2=A0a=C2=A0returned=C2=A0error.=0D=0A>=C2=A0=0D=0A>=20Fixes:=C2=A08c=
d84092d35e=C2=A0(=22PM=C2=A0/=C2=A0devfreq:=C2=A0Add=C2=A0resource-managed=
=C2=A0function=C2=A0for=C2=A0devfreq=C2=A0device=22)=0D=0A>=20Cc:=C2=A0stab=
le=40vger.kernel.org=0D=0A>=20Acked-by:=C2=A0Chanwoo=C2=A0Choi=C2=A0<cw00.c=
hoi=40samsung.com>=0D=0A>=20Signed-off-by:=C2=A0Bjorn=C2=A0Andersson=C2=A0<=
bjorn.andersson=40linaro.org>=0D=0A>=20---=0D=0A>=20=C2=A0=0D=0A>=20Resendi=
ng=C2=A0with=C2=A0Chanwoo's=C2=A0ack,=C2=A0Fixes=C2=A0and=C2=A0Cc=C2=A0stab=
le=0D=0A>=20=C2=A0=0D=0A>=20=C2=A0drivers/devfreq/devfreq.c=C2=A0=7C=C2=A02=
=C2=A0+-=0D=0A>=20=C2=A01=C2=A0file=C2=A0changed,=C2=A01=C2=A0insertion(+),=
=C2=A01=C2=A0deletion(-)=0D=0A=0D=0AAcked-by:=20MyungJoo=20Ham=20<myungjoo.=
ham=40samsung.com>=0D=0A=0D=0A=C2=A0=0D=0A=C2=A0=0D=0A
