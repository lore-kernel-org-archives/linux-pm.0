Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794576044;
	b=W+nlVPo1XdHq5GGVXLY7VcZIIs5qsVNJfAGfE5OZ57w6ZQg4qx/7opzQC2XagVD1q8DM
	 uJV5o3EwKUn9MYvm4sQqmB12wYsCdsXPYSess6EtLXZOITxVioXk41pKcaQuC4wtSw5wS
	 jPiczp7XK5LIAWccMoc/MoRsXCSMMFFw/LG+FR87x8U3PtR0ovNty15o5VmK7KzaTiCF8
	 VCuATz9ix93TPf9a3LGBxmmWRdOMM1p/tFnOnCKwP7jY3cDlJBQYK85sWFQh5kzLPpbeP
	 RG9rrbK0lS55hjnVvxzvSUCvS7pzCRN4yyVbUXbTZR9NQUtkRVf0tal+4Qb82ko9sgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576044;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=1qWc4esvf8arA4ZupyLrig+Ez+fiYLvfvybCsV+67o4=;
	b=22J+dH+udfgF8JMY/LGG5iPb3+n7f2JccbxkPRALzpxcNkPU8TV8T7OBb5mUhgrsIf3H
	 8BIibHgd9WDZEFvXByHhNCzf8QXaMJ5K7udhZJHi89eRofWd77aLr32tL57zYmGYgMQPw
	 Ah54VSlQ5FTLXy8KNTgN/F6OkVwOoc7O12ZfdxHt3uUTkc8yxHCgrOR9D/NU9zYPSEaTg
	 sCSviphAWmMf2ZXHLDYkT9FoiGq0gpBYYT7Kb7cJEXqU2c6R4THDQdH5ELXG/TZi5jCdK
	 y7twxtehV2UXTNEpIxQQP36XsdkB5Ids4S3N8SkqAY489oFX91gBR8A1ySU3W2AsxSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Bsw5e1hi;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MZlUAlTd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3688760A2614
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 13:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3688760A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Bsw5e1hi;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MZlUAlTd
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCJVx63772058
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 13:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1qWc4esvf8arA4ZupyLrig+Ez+fiYLvfvybCsV+67o4=; b=Bsw5e1hirQIXko1V
	P/A3PCvUyTKZmfoS9gy5RgDa/dv85s3HuArahYIeIgFWuRgyN8aV2PmZZwTCkxDD
	y8N+PDV6Z+HV0a2usDHnZrVOn+14Y76HpxIKK2OVIFGQCqLPqLstGD1ImLW5fs60
	UfP9cNwJ0w2B/2Zzltv6H9Dv/MNJ/8UHouJQC0L/gCk3vWl3kZ+6BiGXVtGcsm2e
	KmrfMtMpG0fzfh1IIqAqYTBtBJRumGmVmAAIXfwiFGbYoJYziQ7OlEtJ0tD+HMvW
	jpsPW88hVEk8TBMhGU/OxTvcNdSvvX+/zNk6nF27/N5YNBkWIA8MjaWcvki3EppX
	0IFABA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwu2msveg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 13:20:42 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f33438950so206375585a.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 05:20:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794576041; cv=none;
        d=google.com; s=arc-20260327;
        b=R9LaJ2AQMMG1cj3kuD8M9lMsLVmLaEG8xjyJGWHnIDQgH+BOC5ig6EG6poUo9SFarM
         DFovGk1mHGPb5vMyROBjpgvxofXA1FvwvaFhdDEIVUaC6LiQIfLV/oReIdBW8MfhyDMd
         25CE0JsoCQL8vUnxq1BPldDD8Y2dNrpUZMWZPW5vtLihsxRUhjE7zBblfeOwl4lbLTES
         NIorjGY2/LDLsqTLZjf2r6codnPBVQQjjhUBxfeLS5VUA/dIajn7cx60RBvtD+E5E+Rg
         RcfLVzBMaHPmqjbGYeBxJV3t96plipJ9tS48eIXNCx7uQ3S+5CVfmf4GRn1gAu5UhJKm
         u+kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1qWc4esvf8arA4ZupyLrig+Ez+fiYLvfvybCsV+67o4=;
        fh=JaCHfbR+TdqMEzsvG3x38E9o2c3KEfcVlGJGurgKNG4=;
        b=FgiFpp0Bw4bQQCs2zdQy39pGS9Z20YrkaL/Hqca7IXY9BsvRUdF7dFLL/F249iRZAd
         JHjU32oJHSQK5FFdznIrZmGwP4oYsqOQJ6HzqpBG+geXS/4yf73vt+V3ZOU3ulE3IwRr
         ls7azYrZ0glcHl40xhBZgD/BRM6kSATTxqNBOf+GdNC0xBKksHmuDBzskg9HutIQVUYa
         dnFfDj5GZrH9aleIdpFGA+Xb71uOeHibQ/ualvOYWuyHqO86wdSIWqt1i1Wb4kwZq3Yd
         kMrZfYFr5iQ5IV0GW33f62/9B350lkdVT8MYxGPV6Hi8aaVkaHwBTwiexrk+ycldT3/I
         xWIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794576041; x=1795180841; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1qWc4esvf8arA4ZupyLrig+Ez+fiYLvfvybCsV+67o4=;
        b=MZlUAlTdN8gaUxf5+AjVtGxwjyZK+q8x2fUNFheL3zpxD/OwxFlpdpVZJlPObR8YE9
         PU8pA1FkQWhKQUxvZ/Wiwmg9MDjcKVaVBCB6coxkkp4I6JHYWuU28DNrGgr/fbqArSnT
         nd2onHV+AwubBNnQoRzUy9P9Xu8HSBNi40KRO8oc/3mOz4m1RDjiqradF2NbqtO+fzeO
         i6LzUgk3kqlhwZN1saPwpVj1F8WBB2BUkeRriLjpmfm2udjqfNH8Wdm1uhKQAC5OKzPM
         JV5k7CVt/J1Hq7XV8X9318c/aG7e8aPvsruaFloF+aU6qLL90YjN3u0Ffq+denGUqoro
         TtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794576041; x=1795180841;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1qWc4esvf8arA4ZupyLrig+Ez+fiYLvfvybCsV+67o4=;
        b=auvn6JZSHfQ5oZGrkPIMLxmyjOXf+cWuDlkCaSSNopqRzbfHE774OzHzuuqJ49JUjb
         qvwOV+RiK4beqG/wwG5Hsh12f5rdZzZVitMlGnJ6QT+8LZlRLKSyyM136sC7aCFMD5R3
         jys6QePZJpa1Vde9Zhy396BOhtqjkCLIuuwGmMC2ZpIm6pB/vfDAiuUS12nAcZBLm3O8
         AFfsYM6r2duOqmgHLebnsS0Eh36kcdY6CeC2K5YeM3oHBfViLCiuILUSfBubJ9mt0Udc
         Qzy5ygUkJNdUmS6f0LGCJmE3gyPCxOFNYvN9uOYDiswJARdeDT17vscD6aJ+vJI6Ft3U
         ArZQ==
X-Forwarded-Encrypted: i=1; AL+hErH2DcUwSan64vEbvjF3GriT8lRt2MjE1dps8RwFsoW4/T9yNOb2jH8waVKlvuhi8jfkhcZf6MihIA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZPENGsvQodkqpa6J/vb4GBeNE+Xa7XMQf7BaDjWF2d4GeE/IS
	1uB2Kbir1jlpOL/YRXX22vVXIh/hSW7G1Q55ON2caJ497XQFtzyA52vebsYlhLtwO7XeVgg5lXt
	vO7BX6CG4rh+O3W8KqRy/YNsjs060r0GfsUQqq8xx1fmRrN5qmt6zDw6sPiNl5PCKUZzF3Knob0
	EwB1HK+zR479PEYaU9PdNNJpH8SnNnl+aOnL6hL//1TIMZgCQ=
X-Gm-Gg: AYBFou2bewnPLOf9eHgjy6H0UEFsdJDDarna1ddObVsBBEWEOu5BONhVxp1EEY78/eO
	04JFj5Q/9GUbNOFScStXpcG8oMRgwNN/zMZgPfXAHWAfT9UuefVaYzIoE0PuWblwChenpKzhu0c
	AoRazJeFc1y9jrzxfkdobQdV1CdXtqxFctQAKfXpysCtd+A+sCAUcvqtPLPN+2MI1d/S0N1AmJO
	5xC0tbe/UHmBSAVp0qo4K1D1f9v275DqtQBWEuIT7hPqySaDuCdf9rtr0L1cfPNpwAsDGHWPY2N
X-Received: by 2002:a05:620a:1b94:b0:93f:6fd6:fbf9 with SMTP id af79cd13be357-9494bb73895mr395776485a.66.1794576041165;
        Fri, 13 Nov 2026 05:20:41 -0800 (PST)
X-Received: by 2002:a05:620a:1b94:b0:93f:6fd6:fbf9 with SMTP id
 af79cd13be357-9494bb73895mr395772685a.66.1794576040564; Fri, 13 Nov 2026
 05:20:40 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <b47282f1514a9012ac51d0915afb83782c3c0050.1794417398.git.len.brown@intel.com>
 <CAFEp6-0yj-+7uYnj5PCvaP39ruQ=xduBbQgJc7MyakuPLJhmvw@mail.gmail.com> <CAJvTdKnnqZJrZ6bgaxsyy6QttGwgh5RL=De9ggV3KhMPDau_BQ@mail.gmail.com>
In-Reply-To: <CAJvTdKnnqZJrZ6bgaxsyy6QttGwgh5RL=De9ggV3KhMPDau_BQ@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 14:20:28 +0100
X-Gm-Features: AclHuK9JvzPh-gUt_-PJY2SOU0LfVCGU1Ko4D84s0fgkAlJoejMKa24l7xCqmo8
Message-ID: <CAFEp6-2sLZkNQqDg7seE0ipZbuve_TZMjgNHV4ubW0Qs80Pyhg@mail.gmail.com>
Subject: Re: [PATCH] bus: mhi: pci_generic: Fix erroneous system suspend abort
To: Len Brown <lenb@kernel.org>
Cc: rafael@kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
        linux-pm@vger.kernel.org, mhi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: uqMYc0_qEcowqmJpAhG04s__8iWwtgfa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1MyBTYWx0ZWRfX7cw+SvkKL/0l
 EyXjz46KOmSAtmWIt18/2PTj9xSYDvg65fRF1UOY8zOf6p7w14drhyF9zU3LpAzaX+hfcRQYTBe
 JBiRPGBo51J9JtMaSeXh7YvdLxEvrdMT17wwNUWximJ/zeWAFRdgXRQJvS39C0M/Nn5zlfAkF3D
 KYkwXFw08uUnuKLJIyG4GcUWZXpaBvjz5qQ0pGvKAPPqis7wYTNyGRBlabxWnRRLhOFm+K24j21
 Ideza0wO7nSwtwNmLTV+Gl1YxlRpN8VgALUnj21Jldu/QbN0W1Tx8CQiPHLawp+Q8kF8PH3cy5b
 cwxdqC/3zt2cUdGSUHp9PrDvW1wJQbJdTrf/nvBwWDiX5K9BPJNuoqVq51cBZowHGa5ZJtSs5Gi
 t0YS3VxmrIE3AvlNjltjJdeb51T09bepYax80ISZIi/aJsj4JnVstzaAIVbfKUUEFmso6Tued55
 U3frnv+yOOa2UWu3BsQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1MyBTYWx0ZWRfX7+7DCrApW1LS
 x742iuUJutWS5eYK+ruVEUuT14v9J74cki2rz3pW/+2wSQQ7p9PODPcTNVKRTrXGKUn1zrvz2hP
 rTeGebU3ZWzElAbF9y7/UFFYx6YIeFA=
X-Authority-Analysis: v=2.4 cv=ddQVTnXe c=1 sm=1 tr=0 ts=6af70eaa cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8
 a=BYJHoP1oeDQRUb2UbM4A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: uqMYc0_qEcowqmJpAhG04s__8iWwtgfa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130053

On Fri, Nov 13, 2026 at 1:43=E2=80=AFPM Len Brown <lenb@kernel.org> wrote:
>
> Hello Loic,
>
> I agree that the device and the driver should be debugged, and perhaps
> re-implemented.
>
> Indeed, I'm happy to share the dmesg from 28,000 suspend/resume cycles
> on this machine
> over the last few months to support that effort, should somebody else
> undertake it.
>
> But today, this device is allowing its internal contagion to spread
> into Linux and interfere with
> system wide suspend due to an obvious 1-line programming error.
>
> This 1-line fix should be applied NOW, without waiting for internal
> mhi internal or development.

Fair enough, but would only ignoring error on -EBUSY would work for
you? as this is clearly something which is not relevant for system
wide suspend cases.

Also would it be possible to add a small inline comment saying we
purposely ignore this because of buggy mhi suspend handling.

With your patch what happens on the system resume path? is the MHI
device recovered?

Regards,
Loic

> thanks,
> -Len
>
> ps.  I filed this over a year ago:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D220020
>
> On Thu, Nov 12, 2026 at 5:23=E2=80=AFAM Loic Poulain
> <loic.poulain@oss.qualcomm.com> wrote:
> >
> > Hi Len,
> >
> > On Wed, Nov 11, 2026 at 6:23=E2=80=AFPM Len Brown <lenb@kernel.org> wro=
te:
> > >
> > > From: Len Brown <len.brown@intel.com>
> > >
> > > mhi sometimes aborts system suspend on the thinkpad T16 gen3:
> > >
> > > mhi-pci-generic 0000:08:00.0: failed to suspend device: -16
> > > mhi-pci-generic 0000:08:00.0: PM: pci_pm_suspend(): mhi_pci_suspend [=
mhi_pci_generic] returns -16
> > > mhi-pci-generic 0000:08:00.0: PM: dpm_run_callback(): pci_pm_suspend =
returns -16
> > > mhi-pci-generic 0000:08:00.0: PM: pci_pm_suspend returned -16 after 1=
5145 usecs
> > > mhi-pci-generic 0000:08:00.0: PM: failed to suspend async: error -16
> > >
> > > When a driver returns -EBUSY for its runtime suspend method,
> > > that means "try again later".
> > >
> > > But when a driver returns anything but 0 from its system-suspend
> > > method, that means "abort system suspend".
> > >
> > > Always return 0 from mhi_pci_suspend().
> >
> > Two things:
> > - I think we should simply use pm_runtime_force_suspend() /
> > pm_runtime_force_resume() for the system sleep callbacks instead of
> > implementing separate suspend/resume handling.
> > - Rather than silently ignoring the error, I think it would be worth
> > looking at the mhi_pm_suspend() implementation to understand what can
> > be returned here and under which conditions the MHI device fails to
> > suspend.
> >
> > Regards,
> > Loic
> >
> > >
> > > Fixes: d3800c1dce24 ("bus: mhi: pci_generic: Add support for runtime =
PM")
> > > Signed-off-by: Len Brown <len.brown@intel.com>
> > > ---
> > >  drivers/bus/mhi/host/pci_generic.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/hos=
t/pci_generic.c
> > > index 7193a384cca4..b036fa6e06c4 100644
> > > --- a/drivers/bus/mhi/host/pci_generic.c
> > > +++ b/drivers/bus/mhi/host/pci_generic.c
> > > @@ -1727,7 +1727,8 @@ static int __maybe_unused mhi_pci_runtime_resum=
e(struct device *dev)
> > >  static int  __maybe_unused mhi_pci_suspend(struct device *dev)
> > >  {
> > >         pm_runtime_disable(dev);
> > > -       return mhi_pci_runtime_suspend(dev);
> > > +       mhi_pci_runtime_suspend(dev);
> > > +       return 0;
> > >  }
> > >
> > >  static int __maybe_unused mhi_pci_resume(struct device *dev)
> > > --
> > > 2.45.2
> > >
>
>
>
> --
> Len Brown, Intel Open Source Technology Center
