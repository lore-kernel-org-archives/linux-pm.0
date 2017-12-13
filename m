From: Vikas Bansal <vikas.bansal@samsung.com>
Subject: Re: [PATCH V3] PM: In kernel power management domain_pm created for
 async schedules
Date: Wed, 13 Dec 2017 08:46:12 +0000
Message-ID: <20171213084612epcms5p7755822fff34c87907de2236923e82305@epcms5p7>
References: <3785462.Nrr6Y8ermz@aspire.rjw.lan>
        <20171206120714epcms5p70081d5bc518c3bb5f9cca4f56b203abf@epcms5p7>
        <20171206141238.GB11339@kroah.com>
        <CGME20171206120714epcms5p70081d5bc518c3bb5f9cca4f56b203abf@epcms5p7>
Reply-To: vikas.bansal@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:16136 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751837AbdLMJIT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Dec 2017 04:08:19 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20171213090817epoutp038ddb7924deefbb5576dd8088109ff445~-z3QYs1lw2197521975epoutp03G
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2017 09:08:17 +0000 (GMT)
In-Reply-To: <3785462.Nrr6Y8ermz@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

=C2=A0=0D=0ASender=20:=20Rafael=20J.=20Wysocki=C2=A0<rjw=40rjwysocki.net>=
=0D=0ADate=20=20=20:=202017-12-06=2019:48=20(GMT+5:30)=0D=0A=C2=A0=0D=0A>=
=20On=C2=A0Wednesday,=C2=A0December=C2=A06,=C2=A02017=C2=A03:12:38=C2=A0PM=
=C2=A0CET=C2=A0gregkh=40linuxfoundation.org=C2=A0wrote:=0D=0A>=20>=C2=A0On=
=C2=A0Wed,=C2=A0Dec=C2=A006,=C2=A02017=C2=A0at=C2=A012:07:14PM=C2=A0+0000,=
=C2=A0Vikas=C2=A0Bansal=C2=A0wrote:=0D=0A>=20>=C2=A0>=C2=A0Description:=0D=
=0A>=20>=C2=A0=0D=0A>=20>=C2=A0Why=C2=A0is=C2=A0this=C2=A0here?=0D=0A>=20>=
=C2=A0=0D=0A>=20>=C2=A0>=C2=A0=0D=0A>=20>=C2=A0>=C2=A0If=C2=A0there=C2=A0is=
=C2=A0a=C2=A0driver=C2=A0in=C2=A0system=C2=A0which=C2=A0starts=C2=A0creatin=
g=C2=A0async=C2=A0schedules=0D=0A>=20>=C2=A0>=C2=A0just=C2=A0after=C2=A0res=
ume=C2=A0(Same=C2=A0as=C2=A0our=C2=A0case,=C2=A0in=C2=A0which=C2=A0we=C2=A0=
faced=C2=A0issue).=0D=0A>=20>=C2=A0>=C2=A0Then=C2=A0async_synchronize_full=
=C2=A0API=C2=A0in=C2=A0PM=C2=A0cores=C2=A0starts=C2=A0waiting=C2=A0for=C2=
=A0completion=0D=0A>=20>=C2=A0>=C2=A0of=C2=A0async=C2=A0schedules=C2=A0crea=
ted=C2=A0by=C2=A0that=C2=A0driver=C2=A0(Even=C2=A0though=C2=A0those=C2=A0ar=
e=C2=A0in=C2=A0a=C2=A0domain).=0D=0A>=20>=C2=A0>=C2=A0Because=C2=A0of=C2=A0=
this=C2=A0kernel=C2=A0resume=C2=A0time=C2=A0is=C2=A0increased=C2=A0(We=C2=
=A0faces=C2=A0the=C2=A0same=C2=A0issue)=0D=0A>=20>=C2=A0>=C2=A0and=C2=A0who=
le=C2=A0system=C2=A0is=C2=A0delayed.=0D=0A>=20>=C2=A0>=C2=A0This=C2=A0probl=
em=C2=A0can=C2=A0be=C2=A0solved=C2=A0by=C2=A0creating=C2=A0a=C2=A0domain=C2=
=A0for=0D=0A>=20>=C2=A0>=C2=A0async=C2=A0schedules=C2=A0in=C2=A0PM=C2=A0cor=
e=C2=A0(As=C2=A0we=C2=A0solved=C2=A0in=C2=A0our=C2=A0case).=0D=0A>=20>=C2=
=A0>=C2=A0Below=C2=A0patch=C2=A0is=C2=A0for=C2=A0solving=C2=A0this=C2=A0pro=
blem.=0D=0A>=20>=C2=A0=0D=0A>=20>=C2=A0Very=C2=A0odd=C2=A0formatting.=0D=0A=
>=20>=C2=A0=0D=0A>=20>=C2=A0>=C2=A0=0D=0A>=20>=C2=A0>=C2=A0Changelog:=0D=0A=
>=20>=C2=A0>=C2=A01.=C2=A0Created=C2=A0Async=C2=A0domain=C2=A0domain_pm.=0D=
=0A>=20>=C2=A0>=C2=A02.=C2=A0Converted=C2=A0async_schedule=C2=A0to=C2=A0asy=
nc_schedule_domain.=0D=0A>=20>=C2=A0>=C2=A03.=C2=A0Converted=C2=A0async_syn=
chronize_full=C2=A0to=C2=A0async_synchronize_full_domain=0D=0A>=20>=C2=A0=
=0D=0A>=20>=C2=A0I'm=C2=A0confused.=C2=A0=C2=A0Have=C2=A0you=C2=A0read=C2=
=A0kernel=C2=A0patch=C2=A0submissions?=C2=A0=C2=A0Look=C2=A0at=C2=A0how=C2=
=A0they=0D=0A>=20>=C2=A0are=C2=A0formatted.=C2=A0=C2=A0The=C2=A0documentati=
on=C2=A0in=C2=A0the=C2=A0kernel=C2=A0tree=C2=A0should=C2=A0help=C2=A0you=C2=
=A0out=0D=0A>=20>=C2=A0a=C2=A0lot=C2=A0here.=0D=0A>=20>=C2=A0=0D=0A>=20>=C2=
=A0Also,=C2=A0this=C2=A0is=C2=A0not=C2=A0v1,=C2=A0it=C2=A0has=C2=A0changed=
=C2=A0from=C2=A0the=C2=A0previous=C2=A0version.=C2=A0=C2=A0Always=0D=0A>=20=
>=C2=A0describe,=C2=A0in=C2=A0the=C2=A0correct=C2=A0way,=C2=A0the=C2=A0chan=
ges=C2=A0from=C2=A0previous=C2=A0submissions.=0D=0A=0D=0ASetting=20the=20co=
rrect=20version=20and=20chaging=20the=20formatting.=0D=0A=0D=0A>=20>=C2=A0=
=0D=0A>=20>=C2=A0=0D=0A>=20>=C2=A0>=C2=A0=0D=0A>=20>=C2=A0>=C2=A0=0D=0A>=20=
>=C2=A0>=C2=A0=0D=0A>=20>=C2=A0>=C2=A0Signed-off-by:=C2=A0Vikas=C2=A0Bansal=
=C2=A0<vikas.bansal=40samsung.com>=0D=0A>=20>=C2=A0>=C2=A0Signed-off-by:=C2=
=A0Anuj=C2=A0Gupta=C2=A0<anuj01.gupta=40samsung.com>=0D=0A>=20>=C2=A0>=C2=
=A0---=0D=0A>=20>=C2=A0>=C2=A0=C2=A0drivers/base/power/main.c=C2=A0=7C=C2=
=A0=C2=A0=C2=A027=C2=A0+++++++++++++++------------=0D=0A>=20>=C2=A0>=C2=A0=
=C2=A01=C2=A0file=C2=A0changed,=C2=A015=C2=A0insertions(+),=C2=A012=C2=A0de=
letions(-)=0D=0A>=20>=C2=A0>=C2=A0=0D=0A>=20>=C2=A0>=C2=A0diff=C2=A0--git=
=C2=A0a/drivers/base/power/main.c=C2=A0b/drivers/base/power/main.c=0D=0A>=
=20>=C2=A0>=C2=A0index=C2=A0db2f044..042b034=C2=A0100644=0D=0A>=20>=C2=A0>=
=C2=A0---=C2=A0a/drivers/base/power/main.c=0D=0A>=20>=C2=A0>=C2=A0+++=C2=A0=
b/drivers/base/power/main.c=0D=0A>=20>=C2=A0>=C2=A0=40=40=C2=A0-39,6=C2=A0+=
39,7=C2=A0=40=40=0D=0A>=20>=C2=A0>=C2=A0=C2=A0=23include=C2=A0=22power.h=22=
=0D=0A>=20>=C2=A0>=C2=A0=C2=A0=0D=0A>=20>=C2=A0>=C2=A0=C2=A0typedef=C2=A0in=
t=C2=A0(*pm_callback_t)(struct=C2=A0device=C2=A0*);=0D=0A>=20>=C2=A0>=C2=A0=
+static=C2=A0ASYNC_DOMAIN(domain_pm);=0D=0A>=20>=C2=A0>=C2=A0=C2=A0=0D=0A>=
=20>=C2=A0>=C2=A0=C2=A0/*=0D=0A>=20>=C2=A0>=C2=A0=C2=A0=C2=A0*=C2=A0The=C2=
=A0entries=C2=A0in=C2=A0the=C2=A0dpm_list=C2=A0list=C2=A0are=C2=A0in=C2=A0a=
=C2=A0depth=C2=A0first=C2=A0order,=C2=A0simply=0D=0A>=20>=C2=A0>=C2=A0=40=
=40=C2=A0-615,7=C2=A0+616,8=C2=A0=40=40=C2=A0void=C2=A0dpm_noirq_resume_dev=
ices(pm_message_t=C2=A0state)=0D=0A>=20>=C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0reinit_completion(&dev->power.completion);=0D=0A>=20>=C2=A0>=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(is_async(dev))=C2=A0=7B=0D=0A>=20>=C2=A0>=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0get_device(dev);=0D=0A>=20>=C2=A0>=C2=A0-=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0async_schedule(async_resume_noirq=
,=C2=A0dev);=0D=0A>=20>=C2=A0>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0async_schedule_domain(async_resume_noirq,=
=C2=A0dev,=C2=A0=0D=0A>=20>=C2=A0=0D=0A>=20>=C2=A0Always=C2=A0run=C2=A0your=
=C2=A0patches=C2=A0through=C2=A0scripts/checkpatch.pl=C2=A0so=C2=A0you=C2=
=A0do=C2=A0you=C2=A0not=0D=0A>=20>=C2=A0get=C2=A0grumpy=C2=A0maintainers=C2=
=A0telling=C2=A0you=C2=A0to=C2=A0use=C2=A0scripts/checkpatch.pl=0D=0A>=20>=
=C2=A0=0D=0A>=20>=C2=A0Stop.=C2=A0=C2=A0Take=C2=A0some=C2=A0time.=C2=A0=C2=
=A0Redo=C2=A0the=C2=A0patch=C2=A0in=C2=A0another=C2=A0day=C2=A0or=C2=A0so,=
=C2=A0and=C2=A0then=0D=0A>=20>=C2=A0resend=C2=A0it=C2=A0later,=C2=A0_AFTER_=
=C2=A0you=C2=A0have=C2=A0addressed=C2=A0the=C2=A0issues.=C2=A0=C2=A0Don't=
=C2=A0rush,=0D=0A>=20>=C2=A0there=C2=A0is=C2=A0no=C2=A0race=C2=A0here.=0D=
=0A>=C2=A0=0D=0A>=20Also=C2=A0it=C2=A0is=C2=A0not=C2=A0clear=C2=A0to=C2=A0m=
e=C2=A0if=C2=A0this=C2=A0fixes=C2=A0a=C2=A0mainline=C2=A0kernel=C2=A0issue,=
=0D=0A>=20because=C2=A0the=C2=A0changelog=C2=A0mentions=C2=A0a=C2=A0driver=
=C2=A0doing=C2=A0something=C2=A0odd,=C2=A0but=C2=A0it=0D=0A>=20doesn't=C2=
=A0say=C2=A0which=C2=A0one=C2=A0it=C2=A0is=C2=A0and=C2=A0whether=C2=A0or=C2=
=A0not=C2=A0it=C2=A0is=C2=A0in=C2=A0the=C2=A0tree.=0D=0A=0D=0ANo,=20this=20=
driver=20is=20not=20part=20of=20mainline=20yet.=0D=0A=0D=0AChaging=20the=20=
patch=20and=20changelog=20as=20suggested.=20Changed=20the=20name=20of=20dom=
ain=20from=0D=0A=22domain_pm=22=20to=20=22async_pm=22.=20But=20kept=20the=
=20name=20in=20subject=20as=20domain_pm,=20just=20to=0D=0Aavoid=20confusion=
.=0D=0A=0D=0A>=20=C2=A0=0D=0A>=20Thanks,=0D=0A>=20Rafael=0D=0A=C2=A0=0D=0A=
=0D=0AIf=20there=20is=20a=20driver=20in=20system=20which=20starts=20creatin=
g=20async=20schedules=20just=20after=0D=0Aresume=20(Same=20as=20our=20case,=
=20in=20which=20we=20faced=20issue).=20Then=20async_synchronize_full=0D=0AA=
PI=20in=20PM=20cores=20starts=20waiting=20for=20completion=20of=20async=20s=
chedules=20created=20by=0D=0Athat=20driver=20(Even=20though=20those=20are=
=20in=20a=20domain).=20Because=20of=20this=20kernel=20resume=0D=0Atime=20is=
=20increased=20(We=20faces=20the=20same=20issue)=20and=20whole=20system=20i=
s=20delayed.=20=0D=0A=0D=0AFor=20solving=20this=20problem=20Async=20domain=
=20async_pm=20was=20created=20and=20=22async_schedule=22=0D=0AAPI=20call=20=
was=20replaced=20with=20=22async_schedule_domain=22.=22async_synchronize_fu=
ll=22=20was=0D=0Areplaced=20with=20=22async_synchronize_full_domain=22.=0D=
=0A=0D=0A=0D=0A=0D=0ASigned-off-by:=20Vikas=20Bansal=20<vikas.bansal=40sams=
ung.com>=0D=0ASigned-off-by:=20Anuj=20Gupta=20<anuj01.gupta=40samsung.com>=
=0D=0A---=0D=0A=20drivers/base/power/main.c=20=7C=20=20=2027=20++++++++++++=
+++------------=0D=0A=201=20file=20changed,=2015=20insertions(+),=2012=20de=
letions(-)=0D=0A=0D=0Adiff=20--git=20a/drivers/base/power/main.c=20b/driver=
s/base/power/main.c=0D=0Aindex=20db2f044..03b71e3=20100644=0D=0A---=20a/dri=
vers/base/power/main.c=0D=0A+++=20b/drivers/base/power/main.c=0D=0A=40=40=
=20-39,6=20+39,7=20=40=40=0D=0A=20=23include=20=22power.h=22=0D=0A=20=0D=0A=
=20typedef=20int=20(*pm_callback_t)(struct=20device=20*);=0D=0A+static=20AS=
YNC_DOMAIN(async_pm);=0D=0A=20=0D=0A=20/*=0D=0A=20=20*=20The=20entries=20in=
=20the=20dpm_list=20list=20are=20in=20a=20depth=20first=20order,=20simply=
=0D=0A=40=40=20-615,7=20+616,8=20=40=40=20void=20dpm_noirq_resume_devices(p=
m_message_t=20state)=0D=0A=20=09=09reinit_completion(&dev->power.completion=
);=0D=0A=20=09=09if=20(is_async(dev))=20=7B=0D=0A=20=09=09=09get_device(dev=
);=0D=0A-=09=09=09async_schedule(async_resume_noirq,=20dev);=0D=0A+=09=09=
=09async_schedule_domain(async_resume_noirq,=20dev,=20=0D=0A+=09=09=09=09=
=09=20=20=20=20=20=20&async_pm);=0D=0A=20=09=09=7D=0D=0A=20=09=7D=0D=0A=20=
=0D=0A=40=40=20-641,7=20+643,7=20=40=40=20void=20dpm_noirq_resume_devices(p=
m_message_t=20state)=0D=0A=20=09=09put_device(dev);=0D=0A=20=09=7D=0D=0A=20=
=09mutex_unlock(&dpm_list_mtx);=0D=0A-=09async_synchronize_full();=0D=0A+=
=09async_synchronize_full_domain(&async_pm);=0D=0A=20=09dpm_show_time(start=
time,=20state,=200,=20=22noirq=22);=0D=0A=20=09trace_suspend_resume(TPS(=22=
dpm_resume_noirq=22),=20state.event,=20false);=0D=0A=20=7D=0D=0A=40=40=20-7=
55,7=20+757,8=20=40=40=20void=20dpm_resume_early(pm_message_t=20state)=0D=
=0A=20=09=09reinit_completion(&dev->power.completion);=0D=0A=20=09=09if=20(=
is_async(dev))=20=7B=0D=0A=20=09=09=09get_device(dev);=0D=0A-=09=09=09async=
_schedule(async_resume_early,=20dev);=0D=0A+=09=09=09async_schedule_domain(=
async_resume_early,=20dev,=20=0D=0A+=09=09=09=09=09=20=20=20=20=20=20&async=
_pm);=0D=0A=20=09=09=7D=0D=0A=20=09=7D=0D=0A=20=0D=0A=40=40=20-780,7=20+783=
,7=20=40=40=20void=20dpm_resume_early(pm_message_t=20state)=0D=0A=20=09=09p=
ut_device(dev);=0D=0A=20=09=7D=0D=0A=20=09mutex_unlock(&dpm_list_mtx);=0D=
=0A-=09async_synchronize_full();=0D=0A+=09async_synchronize_full_domain(&as=
ync_pm);=0D=0A=20=09dpm_show_time(starttime,=20state,=200,=20=22early=22);=
=0D=0A=20=09trace_suspend_resume(TPS(=22dpm_resume_early=22),=20state.event=
,=20false);=0D=0A=20=7D=0D=0A=40=40=20-919,7=20+922,7=20=40=40=20void=20dpm=
_resume(pm_message_t=20state)=0D=0A=20=09=09reinit_completion(&dev->power.c=
ompletion);=0D=0A=20=09=09if=20(is_async(dev))=20=7B=0D=0A=20=09=09=09get_d=
evice(dev);=0D=0A-=09=09=09async_schedule(async_resume,=20dev);=0D=0A+=09=
=09=09async_schedule_domain(async_resume,=20dev,=20&async_pm);=0D=0A=20=09=
=09=7D=0D=0A=20=09=7D=0D=0A=20=0D=0A=40=40=20-946,7=20+949,7=20=40=40=20voi=
d=20dpm_resume(pm_message_t=20state)=0D=0A=20=09=09put_device(dev);=0D=0A=
=20=09=7D=0D=0A=20=09mutex_unlock(&dpm_list_mtx);=0D=0A-=09async_synchroniz=
e_full();=0D=0A+=09async_synchronize_full_domain(&async_pm);=0D=0A=20=09dpm=
_show_time(starttime,=20state,=200,=20NULL);=0D=0A=20=0D=0A=20=09cpufreq_re=
sume();=0D=0A=40=40=20-1156,7=20+1159,7=20=40=40=20static=20int=20device_su=
spend_noirq(struct=20device=20*dev)=0D=0A=20=0D=0A=20=09if=20(is_async(dev)=
)=20=7B=0D=0A=20=09=09get_device(dev);=0D=0A-=09=09async_schedule(async_sus=
pend_noirq,=20dev);=0D=0A+=09=09async_schedule_domain(async_suspend_noirq,=
=20dev,=20&async_pm);=0D=0A=20=09=09return=200;=0D=0A=20=09=7D=0D=0A=20=09r=
eturn=20__device_suspend_noirq(dev,=20pm_transition,=20false);=0D=0A=40=40=
=20-1202,7=20+1205,7=20=40=40=20int=20dpm_noirq_suspend_devices(pm_message_=
t=20state)=0D=0A=20=09=09=09break;=0D=0A=20=09=7D=0D=0A=20=09mutex_unlock(&=
dpm_list_mtx);=0D=0A-=09async_synchronize_full();=0D=0A+=09async_synchroniz=
e_full_domain(&async_pm);=0D=0A=20=09if=20(=21error)=0D=0A=20=09=09error=20=
=3D=20async_error;=0D=0A=20=0D=0A=40=40=20-1316,7=20+1319,7=20=40=40=20stat=
ic=20int=20device_suspend_late(struct=20device=20*dev)=0D=0A=20=0D=0A=20=09=
if=20(is_async(dev))=20=7B=0D=0A=20=09=09get_device(dev);=0D=0A-=09=09async=
_schedule(async_suspend_late,=20dev);=0D=0A+=09=09async_schedule_domain(asy=
nc_suspend_late,=20dev,=20&async_pm);=0D=0A=20=09=09return=200;=0D=0A=20=09=
=7D=0D=0A=20=0D=0A=40=40=20-1361,7=20+1364,7=20=40=40=20int=20dpm_suspend_l=
ate(pm_message_t=20state)=0D=0A=20=09=09=09break;=0D=0A=20=09=7D=0D=0A=20=
=09mutex_unlock(&dpm_list_mtx);=0D=0A-=09async_synchronize_full();=0D=0A+=
=09async_synchronize_full_domain(&async_pm);=0D=0A=20=09if=20(=21error)=0D=
=0A=20=09=09error=20=3D=20async_error;=0D=0A=20=09if=20(error)=20=7B=0D=0A=
=40=40=20-1576,7=20+1579,7=20=40=40=20static=20int=20device_suspend(struct=
=20device=20*dev)=0D=0A=20=0D=0A=20=09if=20(is_async(dev))=20=7B=0D=0A=20=
=09=09get_device(dev);=0D=0A-=09=09async_schedule(async_suspend,=20dev);=0D=
=0A+=09=09async_schedule_domain(async_suspend,=20dev,=20&async_pm);=0D=0A=
=20=09=09return=200;=0D=0A=20=09=7D=0D=0A=20=0D=0A=40=40=20-1622,7=20+1625,=
7=20=40=40=20int=20dpm_suspend(pm_message_t=20state)=0D=0A=20=09=09=09break=
;=0D=0A=20=09=7D=0D=0A=20=09mutex_unlock(&dpm_list_mtx);=0D=0A-=09async_syn=
chronize_full();=0D=0A+=09async_synchronize_full_domain(&async_pm);=0D=0A=
=20=09if=20(=21error)=0D=0A=20=09=09error=20=3D=20async_error;=0D=0A=20=09i=
f=20(error)=20=7B=0D=0A--=20=0D=0A1.7.9.5=0D=0A=C2=A0=0D=0A=C2=A0
