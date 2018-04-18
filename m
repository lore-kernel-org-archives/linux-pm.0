From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: Re: [PATCH] PM / devfreq: use put_device() instead of kfree()
Date: Wed, 18 Apr 2018 16:57:35 +0900
Message-ID: <20180418075735epcms1p3c59f097441aabc6af5d7892298c6fdb2@epcms1p3>
References: <5AD01937.1070504@samsung.com>
        <d8d8708d2283349c2c4f3e9f3c9fd5f47126d2bc.1522410143.git.arvind.yadav.cs@gmail.com>
        <5AD001C5.2040406@samsung.com> <5AD0041D.2050506@samsung.com>
        <5AD012CB.7030003@gmail.com> <5AD0160E.7050601@samsung.com>
        <5AD017E8.7020901@gmail.com>
        <CGME20180330114418epcas5p1affd1c3d97e7422dd33e6d3ca73073be@epcms1p3>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5AD01937.1070504@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, arvindY <arvind.yadav.cs@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

>On 2018=EB=85=84=2004=EC=9B=94=2013=EC=9D=BC=2011:37,=20arvindY=20wrote:=
=0D=0A>>=20On=20Friday=2013=20April=202018=2007:59=20AM,=20Chanwoo=20Choi=
=20wrote:=0D=0A>>>=20On=202018=EB=85=84=2004=EC=9B=94=2013=EC=9D=BC=2011:15=
,=20arvindY=20wrote:=0D=0A>>>>=20On=20Friday=2013=20April=202018=2006:43=20=
AM,=20Chanwoo=20Choi=20wrote:=0D=0A>>>>>=20On=202018=EB=85=84=2004=EC=9B=94=
=2013=EC=9D=BC=2010:03,=20Chanwoo=20Choi=20wrote:=0D=0A=5B=5D=0D=0A>>>>>>>=
=20diff=20--git=20a/drivers/devfreq/devfreq.c=20b/drivers/devfreq/devfreq.c=
=0D=0A>>>>>>>=20index=20fe2af6a..a225b94=20100644=0D=0A>>>>>>>=20---=20a/dr=
ivers/devfreq/devfreq.c=0D=0A>>>>>>>=20+++=20b/drivers/devfreq/devfreq.c=0D=
=0A>>>>>>>=20=40=40=20-625,7=20+625,8=20=40=40=20struct=20devfreq=20*devfre=
q_add_device(struct=20device=20*dev,=0D=0A>>>>>>>=20=20=20=20=20=20=20=20er=
r=20=3D=20device_register(&devfreq->dev);=0D=0A>>>>>>>=20=20=20=20=20=20=20=
=20if=20(err)=20=7B=0D=0A>>>>>>>=20=20=20=20=20=20=20=20=20=20=20=20mutex_u=
nlock(&devfreq->lock);=0D=0A>>>>>>>=20-=20=20=20=20=20=20=20=20goto=20err_d=
ev;=0D=0A>>>>>>>=20+=20=20=20=20=20=20=20=20put_device(&devfreq->dev);=0D=
=0A>>>>>>>=20+=20=20=20=20=20=20=20=20goto=20err_out;=0D=0A>>>>>>>=20=20=20=
=20=20=20=20=20=7D=0D=0A>>>>>>>=20=20=20=20=20=20=20=20=20=20devfreq->trans=
_table=20=3D=20=20=20=20devm_kzalloc(&devfreq->dev,=0D=0A>>>>>>>=20=40=40=
=20-671,6=20+672,7=20=40=40=20struct=20devfreq=20*devfreq_add_device(struct=
=20device=20*dev,=0D=0A>>>>>>>=20=20=20=20=20=20=20=20mutex_unlock(&devfreq=
_list_lock);=0D=0A>>>>>>>=20=20=20=20=20=20=20=20=20=20device_unregister(&d=
evfreq->dev);=0D=0A>>>>>>>=20+=20=20=20=20devfreq=20=3D=20NULL;=0D=0A>>>>>>=
>=20=20=20=20err_dev:=0D=0A>>>>>>>=20=20=20=20=20=20=20=20if=20(devfreq)=0D=
=0A>>>>>>>=20=20=20=20=20=20=20=20=20=20=20=20kfree(devfreq);=0D=0A>>>>>>>=
=0D=0A=0D=0AAh..=20this=20was=20critcal.=20Thanks=21=0D=0A=0D=0AAcked-by:=
=20MyungJoo=20Ham=20<myungjoo.ham=40samsung.com>=0D=0A=0D=0A>Reviewed-by:=
=20Chanwoo=20Choi=20<cw00.choi=40samsung.com>=0D=0A=0D=0A=0D=0ACheers,=0D=
=0AMyungJoo=0D=0A
