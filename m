Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5413442D75B
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170913; cv=pass; b=geOp9EcDdna2WO4s7fG4BC0b5SXkqtEDW8hpOXLYuBfZBlexRMEQ3OYAHLgx37pd3e9uSIwGXKDDCuzp/nwNjwOq63g81cgSqdyHbEIVazE5N0nGC5sNxxTeYSfvXR/H5yr27ca3ClUpFE3LMbDQVR0EcYPpsPZ+cD3TgFIDvhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170913; c=relaxed/simple;
	bh=d45tURx3XWs+kAyjHrk/klKfMYkvuvpPKIkNMmnC9Pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MiGPHi14ZbSttLBWgMD6Q/RhXGbITBToB7iaanl55gYHXjXFiklZPLoTT0E5x9QYVcbchqAkZOvlj1znEdlS7RZ6Xd3gRcMa6c9CJndr/dGVSjR5BfwcfzDIxY84iyIeoMxTn5i/OOf2HCLdAjNdLUPIP8Tfnp8X+l5NLFHLHyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QwXc30K8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AhI86eYy; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QwXc30K8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AhI86eYy"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RFu9l1179708
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 16:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d45tURx3XWs+kAyjHrk/klKfMYkvuvpPKIkNMmnC9Pk=; b=QwXc30K8UvMnTrI+
	wYvzNBzzz6mmhTFlIJVxbpP1n+zDceDpbcl8AU/4CxteUn+Qj2krzqq6ts++mRT2
	JzAt22YA10tB+FQbNEU0OW00pc2GOFJmjNik52NhF0fmP5o5FxhtQkmhFhJYjbKm
	yAgqJeXmA0JFjRbEcHmzqkftWSlZoR7LFP0eaExFvA4PPkWXKCj67Yw7d21YnTGs
	G/YN7dYPUr4iIdzKIHifrdqrDn5X0Muy+A479uT1stnrMcvTyny//I+LfsLB659H
	cPWefnrowLmiISioa1brd9OtuH+FcEIUoSWdhGmM2Urg7u0wVUO95j6rYhkQKib4
	KwyuwQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpadkg9ea-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 16:48:28 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-520a00c7a03so52341751cf.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 09:48:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785170907; cv=none;
        d=google.com; s=arc-20260327;
        b=ftAfawgnQulLXG3GCRuUR/zmWule53QPN1r1PX9AuwO36OmK87LVtXBHPkcsHBt4MN
         N0TgmhLU/Xes+/L6pSc4h06YXgYXyd9LjFlaBLMEAxuuFQwZQ+U/+2Y8qJEsNGTU4gQD
         ++d2Mnz4A4pwZQjbCdYgJgx2s/MYcbYtasr33bE7z7+7wygjyg1rfDH6Dx9dJpIvJR3Y
         ql9mnMN+Z9jWhmDMckol8+tQ22Wo1+cQ/g2pJaJobsSy+BFrEGOo6vDDYMmndBttXLYg
         xewG0NpmdoKCZ1YE4h08z1y6mK2U5G55lAFF2i2KewFrcarhUlA4KIhOxb3glrYz8cL7
         OV5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d45tURx3XWs+kAyjHrk/klKfMYkvuvpPKIkNMmnC9Pk=;
        fh=v9q0uwDv5mkI5oEqKFYP1kHKVg5SmTnz6TrMX8BWQsI=;
        b=pZll2+pYQ+4Za0bbQOO1iMmaWj7cabzzoy+MrobbQIWDGUGnznACcuoXh9esqeZn2C
         oELBtZrV41cDsoXec9fShISoC+AQokI3tyMnMdT3MaWlePqTePsgoZa/Ca0WqMquR7ub
         gUU6by1i6x5H1mL6N+9tZuUMTqbOy3TbQvhYcAFGByPw7YEPA4/AqP0TE5Ii6LLE5zfd
         n3AFH/Rs1f+QGHX4HKItkPxT2gbdcO3J9jHsJyHNTW588A/KdDUdssfE2vP3B/uGQTcJ
         99D0FE6eEdPFoDPiH0ic7q7R+3DOMKsvEhtxzdvbbRBJAbF5wJlJNATd5phA5HIyppRj
         ss3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785170907; x=1785775707; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d45tURx3XWs+kAyjHrk/klKfMYkvuvpPKIkNMmnC9Pk=;
        b=AhI86eYyc8Cf3Hi25V9sGsSxpXO58zvuf/YpPx9uoFVP7LI8NtoTHVFXRBVebj3b2t
         U/qTBPmvXkSRmIvTboEuyrgV3whpQbcYWtBv1RsRJtp6bq8UvXKkH5kbmOqzODSHm9yd
         cX4OclIdd/oQcQkYetaI5w6Z5buFo8DBq0sJOavQNoUbOG0ooWePAEDbOHNnYctluO0w
         cQH5VzuRQYzwYHMgSVGrPF/bjwZ+yUoDGts76rRJ0uU143O3pYanlRfa/TuBGsuq/zx1
         2DEoy77xhJJorP0caDohz+5wJFSkkqfXI6SuyPtPfwsahkMqGXQl1ZO3bdg7WqfRHQH8
         kkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785170907; x=1785775707;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d45tURx3XWs+kAyjHrk/klKfMYkvuvpPKIkNMmnC9Pk=;
        b=EIieA2w7lVlUDzx252tuUKZT4fPWpYkJZCxOO7oaDKLTUWkldIQ8eHJ+kn8gXiZUG7
         geruQIYItTz8t5lwLASddhV2iHGyWB+d9WZd6ioMtakgyY0dqYeFLLlGClt/UF+lgfJt
         OLR9YPtFM8DYzAlgpvHVh9iiQIjP7QDBVKj1vZXeJqSK+wZ6rWkxl4Og0KEYHGktzIDH
         P0k4eCLT5HxxDwz7p5I4p244ho2Ddcr+q1yzmzLyOek2IBP8IhxOJOjtRvs+9vdq4I/s
         vgcT+labp7prPxzV6918GifgZk17eaaZU10gP8lcLx15+PyQ54WbptTa6il585Vl6cJl
         5v4g==
X-Forwarded-Encrypted: i=1; AHgh+RoOux9wgMJcdBv/fKx89ExRW94unvKr4ccLgLavRn0T+4OS+4JDdMrlDKex25Ly2waV+4HrDVfqgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9IOkSfzs5O4u/bvHcWLO9jYcKv+BkGzLWHS1eosFyTbZe9LRy
	8pUJo3VAmbANYvSaWoZTPlix79KeyfmB1sG962qMcgKQ1g1y5DRmc6ISKHU3giEnaIxzCPfP5A3
	zHF8T3m7Ipmtv3dvrCq0nqOGqOU64fwW2ZA07GqoG2Q69T6bux0S42CnOoPyVOsMhLlh1QYHgXI
	Z9PPxTqVBw46H5ZREgF09xIP73XYgjPTh16ZQ4
X-Gm-Gg: AR+sD10bkSJJZg24KQEUjuvGm4OXDLI0ehbLsHggeNviwLDhV3Rkz6mKBUFNoZr+U7B
	rBTF3nSLUCgIMTXXNlWnSIcOd8+XWGDDtC12ququcqnemG3knz3YWshWLBEIXcxZjn1/8kRkYQ3
	dzNYGG6vGc79nGP3pnPrpozBh1dclOCa2snRwGNMnGoACi70x2/WHUuPTEng==
X-Received: by 2002:a05:622a:8b:b0:51a:8835:58cb with SMTP id d75a77b69052e-529a86b1bf3mr107887161cf.54.1785170907058;
        Mon, 27 Jul 2026 09:48:27 -0700 (PDT)
X-Received: by 2002:a05:622a:8b:b0:51a:8835:58cb with SMTP id
 d75a77b69052e-529a86b1bf3mr107886821cf.54.1785170906641; Mon, 27 Jul 2026
 09:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722132729.302067-1-dmitry.osipenko@collabora.com>
 <CAPx+jO-1_ZpYcnPtoYxRn5vv34tiP7TXnjKZ3SaWkEzdeTfXpA@mail.gmail.com> <3130633c-fbff-4b1a-a127-bd4eb678c3f6@collabora.com>
In-Reply-To: <3130633c-fbff-4b1a-a127-bd4eb678c3f6@collabora.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 18:48:14 +0200
X-Gm-Features: AUfX_mwYyJK7opquw-Zgrx7ikepnD3P77x7E8vkOGtJWpCSQCzJtEQPkLeMKHN0
Message-ID: <CAPx+jO9-b_XyhS_CtX1ZFiH96WMYjjcvOEcO6u6CLEZq61rpaw@mail.gmail.com>
Subject: Re: [PATCH v1] pmdomain: mediatek: Fix MT8183 hang on boot
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Ulf Hansson <ulfh@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: hYRuwP7QVdKZ1C4G21H8t3pc1wCGAiXV
X-Proofpoint-GUID: hYRuwP7QVdKZ1C4G21H8t3pc1wCGAiXV
X-Authority-Analysis: v=2.4 cv=Ns7htcdJ c=1 sm=1 tr=0 ts=6a678bdc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=QX4gbG5DAAAA:8 a=gHq1O5mURKo0xi8WsWsA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE1NSBTYWx0ZWRfX9WcM2Y54wOFm
 Sto/8+yKbM+REidBKsSepDPUAA/mo0o4GBvAaYGAv3+SW/K/TGDQqXvLQV9+f3NSF4cZnEH/S1c
 4m40hsjy+zTNmGe5XEbblbbPQFgcbgKl9KZUB0fUCGAOaPXIDDkPvojbOV0vQWvoYylCBmEbWuz
 cv49s0FLgUBAgZad9EKEAVJVYwdLDjWpMFYYSgGHN/8Dpcg5T9xV5TR10Yej+L2md/F/XMkhe0b
 OvizU6JbuyP63hSRxG8bHHq53XD4NdNBKoJ5PsHxmQ7ooY+TcM1diXW/3jEhIzoh4PYFCLKsXQo
 uHNwVvf0jvMDteZSrhylTksdvDCDQg6P8SGiHKvLeKCFAOWytvNViM0L6j0sXUHkr5ImPPdtnAr
 Zde9qo17pU/k+PJowoYJTKILDq9ot6NE62PyDXMNNWfcyEleOuMh5qJZN40YdCg9mqasSpqS9fw
 VwT7PF+PA/hQSmRHpxA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE1NSBTYWx0ZWRfX+JO0GQOdBBda
 gvgZOFDK36zcNI+2LsDSC/3xJUOLaNSsakz/M8PAByCqFOtzihpejhnHYHZrsyGaiIY3sjcXbbx
 z3UFW1q/DWeb2VGNn7LbWqFHm8M2AM4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270155

On Mon, Jul 27, 2026 at 1:04=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> On 7/24/26 17:01, Ulf Hansson wrote:
> > On Wed, Jul 22, 2026 at 3:28=E2=80=AFPM Dmitry Osipenko
> > <dmitry.osipenko@collabora.com> wrote:
> >>
> >> Depending on firmware, part of the MFG domains may be left ON at boot
> >> leaving only some MFG cores powered, to let the ACP to prefetch the GP=
U
> >> region when the display controller is brought up. This doesn't play we=
ll
> >> with an eventual delay in probing Panfrost when the display controller=
 is
> >> fully set up, as that would make genpd's sync_state() to power off the
> >> domain while ACP tries to prefetch: this is causing an AXI stall,
> >> effectively freezing the AP indefinitely. In order to prevent this fro=
m
> >
> > I haven't made any detailed investigation, but to me, it sounds like
> > there is a missing consumer somewhere.
> >
> > Should the ACP/panfrost devices be a consumer of the MFG domains as
> > well? Or perhaps, if the ACP/panfrost should rely on the display
> > controller to be probed and powered-on, to be able to probe?
> >
>
> This is about how the bootloader is leaving the display controller, the A=
CP,
> and the MFG registers before booting the kernel.

Right.

>
> The kernel drivers themselves will reset this weird state when the HW get=
s
> to full probe so there won't be any more issue(s) from that point onwards=
.
>
> Actually, there would be A LOT to say about this, but I'll be very brief.=
..
>
> Basically, before booting the kernel, the bootloader is leaving a half-as=
sed
> setup to potentially support continuous splash functionality, but without=
 it
> being actually used on the device(s) that we're talking about here...

So does that mean that the print in scpsys_add_one_domain() ("A
default off power domain has been ON") gets printed for these PM
domains?

If so, perhaps it would be better to turn off the PM domains (if
possible) before registering them with genpd?

>
> Again, I should put a remark on every word of that last paragraph, but th=
is
> is the gist of it.
>
> If you're curious or need more information, of course I can expand a bit,
> there's no secret involved here, it's just that I'm avoiding to write a w=
all
> of text around that...
>
> P.S.: We've been discussing that internally and chasing this issue for mo=
nths
> before deciding to "solve" it like this.

Huh, I see, thanks for sharing.

I think it would be nice to clarify a little bit more in the commit
message, as it all kind of indicates to me that there is a missing
consumer or that a parent needs to be runtime resumed before a child
is probed.

Or another way of looking at it, that perhaps makes better sense.
Based on your latest information, it seems like the PM domain isn't
really fully powered-on by the bootloader, but still we are telling
genpd that it is, leading to an inconsistent state and errors.

[...]

Kind regards
Uffe
