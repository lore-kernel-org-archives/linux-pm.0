From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: Re: Re: devfreq relation with pm qos
Date: Thu, 12 Jul 2018 11:34:44 +0900
Message-ID: <20180712023444epcms1p8cb202bb977fcb2b365bc334f87244d04@epcms1p8>
References: <CAES_P+-=iictJKgHFGN2Mypp_+GMyTOVmZVQw=bSfHbyZMY4QA@mail.gmail.com>
        <CAES_P+_k=fz3yMnVZni2hEnfSujctnT33zoN9-KsBLBeQaG_sA@mail.gmail.com>
        <CAES_P+_GTRcFya=N20+b+U=HOpv9gcpYkfJW_gU_i_2pH2hmMA@mail.gmail.com>
        <20180710055847epcms1p2eed3f89ae0220a06051faa83cc8b21ed@epcms1p2>
        <CGME20180709213456epcas4p17e5753d1b59856a0df3790d7faef8d73@epcms1p8>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAES_P+-=iictJKgHFGN2Mypp_+GMyTOVmZVQw=bSfHbyZMY4QA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: noman pouigt <variksla@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

>MyungJo, I am trying to understand the relationship of PM QOS with
>devfreq drivers. I don't see any relation of PM QOS api's with devfreq dri=
vers
>directly as there are no QOS apis used in the devfreq framework.
>
>The only explanation I have is that PM QOS has direct relationship
>with CPUFREQ driver and as CPUFREQ driver works with CPU
>frequency and that CPU frequency directly affects DEVFREQ drivers
>as devfreq driver maps CPU frequency to device frequency and
>that is why PM QOS doesn=E2=80=99t=20have=20direct=20relation=20with=20PM=
=20QOS.=0D=0A>=0D=0A>Is=20my=20understanding=20right?=0D=0A=0D=0AYour=20und=
erstanding=20on=20the=20fact=20that=20there=20is=20no=20relation=20between=
=0D=0APM=20QOS=20and=20Devfreq=20framework=20of=20today's=20code=20is=20cor=
rect.=0D=0A=0D=0AThe=20reason=20on=20why=20so=20is=20not.=0D=0AIn=20general=
,=20you=20don't=20make=20a=20peripheral=20device=20be=20directly=20throttle=
d=0D=0Aby=20CPUFreq=20values.=20There=20exist=20such=20cases,=20but=20they=
=20are=20not=0D=0A=22general=22=20or=20inherit=20characteristics=20of=20per=
ipheral=20devices.=0D=0A=0D=0ACheers,=0D=0AMyungJoo.=0D=0A
