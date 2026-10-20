Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792492690;
	b=D+esZb+ySF7Ba6pGs3Ki0gzyKvcB0g+cvHPQZWMA7YsE5w8LemEp/TCPTH1+auMsVbQr
	 tZww6TgpEXmdWuq9lCZoW1t/FNUubRwoqHRtu/hldR0yDzrHV59zUusv1rm+8TtCgEF9M
	 MOCp12pnmYrSA+AuzsmEY2aZvOzPmZeh+RAAp4PVqHSJeH4ksjAZRfpJri//JWKHu/bNQ
	 LMrQEaLSGzrWvurqEPzHWjYTLgMItP3FpyEIjmhHP9H6O4QcATm+ClVrtwD/JTVBIhKU6
	 R0hrLRjdnmNFUpx3U622uDtPrafHnDiNCWXnMsKJaz97GugywHmwA94CdUoXr2i/Sfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792492690;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=kp5gpUWP9+ledzHkf+zwpt5NSmecoWohw/hKxyjrTRI=;
	b=mBpi5HTao4OeHDy7Jf9wAjx3Yg64xy25OSSeKIEzFAch+OrPXcHBqIsiOt1jX46y+myt
	 l+LT22wWsKhPdr7mWIdKkd4pB9fk8b2DB7/nZlnYr/v+GrJJ+6s9skKwQoJc2AFpciBNL
	 Gok/2OXtwrcXXNdilYNygYK5E2lbZoTE2/OLQnB4EsPHpQG0KgGG4G3cfgYwwpQe5jIGE
	 u6Ry+4YustjSPKiEeADYT4sFUWadnJlajrxRDUsPJoXy3HNSnL+m1/VIezfD9VXvz6auZ
	 gwG/agpwCKwJ1b+k5cNkG+EAOrw9S+gfNN+Zxzt5tld4a9AlyRilo6oqRGi5QJlVbVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NB71qG01;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WVffiuHx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523BF606A319
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 10:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 523BF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NB71qG01;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WVffiuHx
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K8XH9m4032354
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 10:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kp5gpUWP9+ledzHkf+zwpt5NSmecoWohw/hKxyjrTRI=; b=NB71qG01HUvJzbP+
	+XG8IvxeOGaxV9LMBIScz66/q3Lps+zBFTwdNvzjmLu+bezSSXb3BQALU/h7iwer
	oZGrqb91SyC1Ap6Yzdxa0nP1MlkNClV5auh65AS4ZrRqTGpl/nKcdyJSel9n3eBD
	JCUhugLVw2CIGCkRBLdqSFmJ2SZLHXUBqQJXenfC6ekFcTr3hsx7aSbsfP8LpWxI
	AA5t1THSu0aHLVUcsu+j+/cmyTwDtV3Kd+3huC9eRNxsduGqX411DaHiWdzdn3LM
	u9MHSA9yaKqqpvan7NdftVDZk0iva2OoOXbfpNazOfBFV3YdoeYcyzhAcCTS0a6j
	50lUyw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5qa234-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 10:38:08 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e8e16d22d8so45611165ad.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 03:38:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792492688; cv=none;
        d=google.com; s=arc-20260327;
        b=NrCIzQvszfvLc3C+epSHzoAj5QZEqGlXONRwp4ydqIk7mlq6aQ9wHB/a6o9YsxFZyL
         6CIN6ZEBBp24NV6ZNcvJ/E3iBQu1SKk7upYbJFezBcIOttDGctBSgZfTwzhxsRr5KlaL
         uGZEhhIsb2BCdkoDqJGhbkm1y/kQBGHGycL2YC+WZsB80IDKgdkvJ2WIKqxdjkNSNfhl
         6jfFg5esS0YJLCKKLHCQSVQP1J9x362rV3M9bY6KJeo4zksNMkt9TDDA6DBy23E5E21j
         DJ+sgZ84elFVceyrTAwrtijHrOaxFRKEF2awpA/WsQwq3WgmFS9HNJeADfuWIT9laMsv
         6GCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kp5gpUWP9+ledzHkf+zwpt5NSmecoWohw/hKxyjrTRI=;
        fh=BLSosJUHWi0r2e3Uyo3T3YrixWdPTmXjE8k2cYFJM8A=;
        b=Zb+u+J+p4ph56nUxxO/732MB9zc7zXOJnfYw/0MwdtpvG1cTRc5xEvGxfUV+TXQ97r
         l1J+74tDgvc4Q6ySwsGHwP4bKdpXRw0GwDjgYsoMlQwewIiuH3qFOnGrtNOUIApmtr/Q
         4FFdHt0faxxtAb/kiTG+bF6dwlzSm4vBThXafdKUufknFgzhjG9CJ7pXxtd6tQ2QJdt4
         S8RvfJGIH9uDLZMfWIEc+3dzAt5vso07uzwU0j5wyhNHZebceYc+7zPNcqGK2gLcLJPQ
         bbuy/IM/Ou/1zlj9lubH5JvisvYuv6tvzDL5ZqBsbiQrlSUaVtMrgpDG1Lyl0Vuo3KEU
         DpVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792492688; x=1793097488; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kp5gpUWP9+ledzHkf+zwpt5NSmecoWohw/hKxyjrTRI=;
        b=WVffiuHx9rz1W+gkzqPlmPzNVqfoovsINEMo5XWyRvcUYDYT+1pKzdQ+jhiRZvc4Uy
         F6CZwcrqACdfjhduPrIdjj5XjgGVx5k24HagMqbnF0PDp2kbyeUsBjW+igGbxGvVN76l
         oy4wTJu2CeixnJBnMeO8RAXtSd9TMXrzaoRKajiDqDF36/18aQ5WEwmaR2r3EeXf1OsX
         Seed7SJHsn94AL9EqwS7+IlLNkoXLj4NuUDjlmMyleit/XOgQLwQrK8MCbJstQJhzvd7
         6Sg4IyPvuIxtHDScfTL617oW9yv2jx90SDnN8XVYhUSjr9+FXufK6vksFXAFkDw7IEMB
         zEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792492688; x=1793097488;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kp5gpUWP9+ledzHkf+zwpt5NSmecoWohw/hKxyjrTRI=;
        b=if5Wyq5cOYjBS5o8HOARSG2SLwgnAfunAH+mPSLBI2Ln/N28xKppyqU1qVjrZ4PnQW
         0RfbMt+BHBxOasjtOz9vScXhkbGgye+hT1GpGQwWIeqCJqLv3EqYQ4gsBnA53X8Z16e2
         q52f5cacYjuDaBbVZwO/gMTgwc2wHO6/PfU/eoJMypLshzxWzm2dWKsMEXeIM8LueVJ9
         5lDBT7frq8gya+DglqtokySACpRNXMom/SxiqoJvJ2vjqwfl0pcjvlNKss1tMNrzKMl0
         LYyRSywXGe3la3JChWhrptyJnl6bAmbHlf2hmdEJz5RFNF9h7eFcXtFN8EhaDWmMYNfQ
         bGgA==
X-Gm-Message-State: AFq9FYLZFUuuyB0+atLupBNfTEzjvrRkqpo6g8LsCD4Swe0UNNinCl2f
	zCsFIRys2p9opvIwxY22Cv9TMx6Pt6FD3lzmnXYV7LctGa+B8HhUgmWYp++m6YEisZUzkzlMDji
	Fhsc3iPXVmohNqAJo9CgF1jEdD5Uw0rA2hYKn/DO9LqT39Vfs37utllFIkNGiOL2BbIvP77lQKL
	sspYzhrE4ws/mhn4zXQNKzLQooXumeceNTROf5
X-Gm-Gg: AYBFou1EW+6VgplXbRoZRGmQkGj9i5SiiYQh7agrEVCPLFQWsGyHLPrxjLcHnOfRn/U
	6XdUQh3HXmp0Vcl67jjsvEoTsR1Yy8Lyo2NGlAxowe01M/Q2AuXBxOUrorJ63SNN0ElDRbxhpK/
	MeaJsNFmE127lN5q816H+ua0M9i+ZwDcPh0S0KNKjAomQuRKVraiYJPFQHwQ==
X-Received: by 2002:a17:90b:4c05:b0:3ab:3384:1a44 with SMTP id 98e67ed59e1d1-3aceec79968mr9329457a91.12.1792492687877;
        Tue, 20 Oct 2026 03:38:07 -0700 (PDT)
X-Received: by 2002:a17:90b:4c05:b0:3ab:3384:1a44 with SMTP id
 98e67ed59e1d1-3aceec79968mr9329429a91.12.1792492687278; Tue, 20 Oct 2026
 03:38:07 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAJh9TS+k9P7bpa5gW+XV_da6JvA6TOGFJEdmsEmAULNAiZTBaQ@mail.gmail.com>
 <CAJh9TSJWr8eLG=9_UjwdOqwUqfsCxaAJb8NUUJ9NKjnmPcLSPA@mail.gmail.com>
 <CAPx+jO9x304geo422e6PGNGPNsgSPAKcqUUyX244jOwy7fNw3w@mail.gmail.com> <CAJh9TSK0CJPWGFQYFcWmA4TqcZuDTdrmOduBzZHVgSQVomCZeg@mail.gmail.com>
In-Reply-To: <CAJh9TSK0CJPWGFQYFcWmA4TqcZuDTdrmOduBzZHVgSQVomCZeg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:37:55 +0200
X-Gm-Features: AclHuK_46PCLXSTVIxbGuv8F4DK4GjNXI3Zf043qnmZPcdcesdWj-Ev8QNsw8-4
Message-ID: <CAPx+jO89BqvJuoYUddKvbgsuOeJEft5cFp8HnS=04-Y6uASi3g@mail.gmail.com>
Subject: Re: RISC-V genpd race in OSI mode (genpd domain power_off vs firmware
 suspend call)
To: Jimmy Ho <jimmy.ho@sifive.com>
Cc: linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
        Anup Patel <anup@brainfault.org>, rafael@kernel.org,
        daniel.lezcano@linaro.org, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Samuel Holland <samuel.holland@sifive.com>,
        Nick Hu <nick.hu@sifive.com>, ulfh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 9Sx2_X8k423AdRvg4NibPKDZY1bw1q7f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA0MiBTYWx0ZWRfX4gVtc41wx52z
 syukl6dGO9AD1rnEkR4ng6fJbArwYIavtAbqNDc2V0v8oHNukhbuHjQkS1ZOVHbeqKePUGyo3Qc
 eVGWEqK7+IU7jmeF9mN5RcNnBfhvJ+Rm7YGao3UhS/qr2klXroA1/MQsXH2dKAreOXDI19voF+z
 Zc3l7FWUr0HvJi7IhyQb2IRHgosVW/QAyAZib4KQv94/L7s30GG2aDfa+eQv/4wiABCz6My1uav
 hqsm48TU2lupRbi0OhryfTkSDXNuG03ZSlIB70Fuz1UpYNR5stzOif2hIqvgKtyqu/X130iSeZo
 RpKbSixSMUHLW1mUwkXAf8JoUAKPc8sw/24zfLPKM5dev1zNaZE5MQ9DOJhNGhzb3kl6iXC1h38
 N9G2dVM0r7/5/BkCDbuRzOQcyzvXesXooc+ZS4Sdc6pKefxeIhsXOnxP0KgvJlvJX1y7V6ucQvJ
 35bANiFZs7ecoFv1C7A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA0MiBTYWx0ZWRfX1kTg7NCF87rH
 vmDu/Doap9Xx/TdW0KtC0wGnBjf5ego5ngQRb6O0NzC/kpoJE6VQrJqhvqm4SZOR2GKN8+FeCoX
 pHB1SInLi0gMMg3SjLolwPfHRj3odYo=
X-Authority-Analysis: v=2.4 cv=LpcHWXdc c=1 sm=1 tr=0 ts=6ad74491 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=UXIAUNObAAAA:8 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8
 a=abO3mwVV_VmizPnVPssA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=a1s67YnXd6TbAZZNj1wK:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-GUID: 9Sx2_X8k423AdRvg4NibPKDZY1bw1q7f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200042

On Mon, Aug 31, 2026 at 3:53=E2=80=AFAM Jimmy Ho <jimmy.ho@sifive.com> wrot=
e:
>
> If I understand correctly, you are referring to a mechanism similar to
> psci_validate_state_coordination in PSCI.
> However, there is a time window between the genpd calling the
> power_off callback and the actual execution of
> psci_validate_state_coordination.
> During this window, another core could wake up, enter Linux, turn the
> cluster genpd back on,
> and complete its own suspend sequence before the initial core finishes
> suspending.
> Consequently, the initial core remains unaware that another core had
> woken up during that interval.

Right. Still, the FW knows about this and should prevent the initial
core from being suspended. Instead the FW should return an error code
for these situations.

Kind regards
Uffe

>
> Best regards
> Jimmy Ho
>
> On Fri, Aug 28, 2026 at 8:55=E2=80=AFPM Ulf Hansson
> <ulf.hansson@oss.qualcomm.com> wrote:
> >
> > On Fri, Aug 28, 2026 at 7:03=E2=80=AFAM Jimmy Ho <jimmy.ho@sifive.com> =
wrote:
> > >
> > > Resending this follow-up to Ulf=E2=80=99s current address
> > >
> > > On Fri, Aug 28, 2026 at 12:56=E2=80=AFPM Jimmy Ho <jimmy.ho@sifive.co=
m> wrote:
> > > >
> > > > Hi linux-pm,
> > > >
> > > > We hit a race condition involving genpd's CPU PM domain (OSI-mode
> > > > hierarchical cpuidle, similar to the ARM PSCI OSI model) on a RISC-=
V
> > > > platform, and would like to get your opinion on whether this is a
> > > > genpd-level issue and what the preferred generic fix would look lik=
e.
> > > >
> > > > Background
> > > > ----------
> > > > Observed this issue on qemu platform
> > > > On our SoC, drivers/irqchip/irq-riscv-aplic-main.c registers a genp=
d
> > > > notifier to save/restore the S-mode APLIC context:
> > > >
> > > >   aplic_notifier()
> > > >     GENPD_NOTIFY_PRE_OFF -> aplic_save()
> > > >     GENPD_NOTIFY_ON      -> aplic_restore()
> > > >
> > > > CPUs are attached to this genpd via dt_idle_attach_cpu() (as in
> > > > drivers/cpuidle/cpuidle-riscv-sbi.c, mirroring cpuidle-psci.c). Whe=
n
> > > > the last CPU in the domain goes idle, genpd_power_off() decides the
> > > > domain can be turned off (based on the "not_suspended" count comput=
ed
> > > > under genpd_lock). When the first CPU
> > > > resumes, genpd_power_on() decides to turn the domain back on and fi=
res
> > > > GENPD_NOTIFY_ON, which triggers aplic_restore().
> > > >
> > > > However, the actual SBI HSM suspend call (riscv_sbi_hart_suspend(),
> > > > similar to a PSCI CPU_SUSPEND call) is *not* issued inside
> > > > genpd_lock. genpd's power_off() callback only records which domain
> > > > idle state was selected; the real firmware suspend call happens lat=
er,
> > > > asynchronously, on each CPU's own cpuidle enter path
> > > > (__sbi_enter_domain_idle_state()).
> > > >
> > > > The race
> > > > --------
> > > > Because of this gap between "genpd's software decision that this CP=
U
> > > > is last-man / first-man" and "the CPU actually issuing the firmware
> > > > suspend/resume call", we observed the following sequence
> > > >
> > > > 1. CPU0 requests a system domain-level power-gate (deep sleep, tear=
s down the
> > > >    shared S-mode APLIC context) and hands off to firmware.
> > > > 2. Before CPU0's request is physically completed, CPU1 wakes up,
> > > >    genpd_power_on() runs, GENPD_NOTIFY_ON fires, aplic_restore() ru=
ns.
> > > > 3. CPU1 goes idle again, but this time system domain-level genpd re=
ject
> > > >    request, so it fallback to core level power-gate
> > > > 4. CPU0's original system deep power-gate request eventually comple=
tes at the
> > > >    firmware level -- physically collapsing the system domain, inclu=
ding the
> > > >    S-mode APLIC context, saved earlier by aplic_save()
> > > > 5. CPU0 wakes up (e.g. UART interrupt), enters Linux, but system ge=
npd's
> > > >    software state still says the domain is "on" (from step 2), so s=
ystem domain
> > > >    GENPD_NOTIFY_ON will not be fired again and aplic_restore() will=
 not be
> > > >    called
> > > >
> > > > This looks structurally identical to the race TF-A's PSCI OS-initia=
ted
> > > > mode documentation describes:
> > > > https://trustedfirmware-a.readthedocs.io/en/latest/design_documents=
/psci_osi_mode.html#races-in-os-initiated-mode
> > > >
> > > >
> > > >   "In OS-initiated mode, there are race windows where the OS's view
> > > >   and implementation's view of the system's state differ... the OS
> > > >   might request a powerdown state for a node from one core, while a=
t
> > > >   the same time, the implementation observes that another core in
> > > >   that node is powering up."
> > > >
> > > > TF-A's answer is to require the OS to encode a "last_at_pwrlvl" fie=
ld
> > > > into the StateID passed to CPU_SUSPEND, which firmware validates
> > > > against its own view of system state before honoring a powerdown
> > > > request. We could not find any code in current mainline Linux
> > > > (cpuidle-psci.c or generic cpuidle/genpd code) that actually comput=
es
> > > > and encodes this field dynamically per suspend call, so as far as w=
e
> > > > can tell this race is unhandled generically today, on both arm/psci
> > > > and riscv/sbi backends.
> > > >
> > > > Options we considered
> > > > ----------------------
> > > > 1. Implement something like PSCI's last_at_pwrlvl generically: expo=
se
> > > >    genpd's already-computed "am I the last CPU in this domain"
> > > >    information through the power_off() callback API, so
> > > >    backends can pass it down to firmware, and have firmware validat=
e/
> > > >    reject stale requests.
> > > >    - Pro: matches the documented PSCI OSI approach.
> > > >    - Con: We don't know how to set this flag properly in a generic =
way.
> > > >      last_at_pwrlvl is only meaningful on riscv/arm, so we can't ju=
st
> > > >      add it to genpd's generic code path. genpd also doesn't keep a
> > > >      counter of how many CPUs in a domain are still alive, so there=
's
> > > >      no existing state in genpd's power_off() callback we could rea=
d
> > > >      to derive the flag. One idea would be to walk the genpd hierar=
chy
> > > >      from within the power_off() callback and check the runtime_sta=
tus
> > > >      of each CPU device in the same domain (genpd domains already c=
arry
> > > >      a CPU mask, and get_cpu_device() can be used to look up the
> > > >      corresponding CPU device)
> > > >
> > > > 2. Do the power-domain control directly from the power_off()/power_=
on()
> > > >    genpd callbacks (e.g. have them poke the SoC's power controller
> > > >    registers via an SBI call, instead of relying on each CPU's own
> > > >    idle-entry path to trigger the deepest state).
> > > >    it creates two independent driver that will touch power controll=
er
> > > >    (opensbi vs linux)
> > > >
> > > > 3. Have each CPU pass a monotonically increasing sequence number
> > > >    alongside its suspend request to firmware, and have firmware
> > > >    itself detect and reject/downgrade a deep power-down request if =
a
> > > >    *newer* sequence number from a shallower (i.e. "some CPU became
> > > >    active again") request has been observed for the same domain sin=
ce.
> > > >    This is a firmware-side staleness check, entirely below the SBI
> > > >    call boundary
> > > >    this seq number can be maintained in gendpd generic code
> > > >    or riscv power_off() callback, where do you suggest this to be
> > > >    added?
> > > >
> > > > Do you have any suggestion to solving this issue?
> > > > Thanks,
> > > > Jimmy Ho
> >
> > The problem seems very similar to the race condition we have for the
> > PSCI OSI mode. This race condition needs to be managed in the FW.
> >
> > If the last CPU in a cluster is about to enter idle, the FW simply
> > needs to abort the request for it, if there is another CPU in the same
> > cluster that is about to wake up.
> >
> > Kind regards
> > Uffe
