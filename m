Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794592094;
	b=rNSt+Zva9N61BX/fDGF2dfx0VxL5gB9Mu4b4lJiX9Vxdn8HJ2spJHn+Lh6WBgkTkH8z6
	 6Z+LuAABy3NvbGR+v8GvNpaxZj3QmXfKyy1xFKCvHOA4BlA14saHABnI5K7C4LcyPemmH
	 oqso10xpRL5hHNJQ/BBpEM06EPfUZYnEIjBkYe91bb4FLUdLjt0qZVz2TxvZRHaaauZdc
	 ksUOvrQ0pI0TLl8cpvdj+oFp2jfr++sQSxSsnFMdvf4d4Y1WYx9V9EuP4i5lVnIpT36wE
	 c5iBdc/04gjVkl1juG4cQjGnS2bd4HYvi0JtwHuxlNqqsqsyGPDi3QAMOj1vlo9CN8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592094;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=tYWjPq7IqlSKgbNTpcHLqc47/rglK9xx20CYVlKikS8=;
	b=2NQSDGpudetMG62hf36mb7EW4yDyqwQxcdT+cOdvbrzw1LU1GrZiXiXar70zJkf8jtdU
	 W0Rgpx9SVP2JQaGcU77OEbl3ACxvW+qExL2ul/hyWfgW47w0zb6ql3ZQUpiOGd4ZBQ74Q
	 yoVgvfDhdL/M/8x/yAAWwIcX5bpba7OGREeEGceD4ZBgMkoArgLX+tWBtGbz18f6lx4Un
	 gOFy+P5eqIR3i4VWZFEHDpl/JkRnzO1ndPRWm/iAGJswnVrxmHIIwa6NsyluGKXGqa2w4
	 1gThVDrYc7Pr+9GzqQ+MVHVRMKuXJANpZrCFwdk0U+CNB45faKdPTmNJQ92Rl6CZe+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pZQAGIDG;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T3jJCMa2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50F660776DD
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 17:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B50F660776DD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pZQAGIDG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T3jJCMa2
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFR7KL1011736
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 17:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tYWjPq7IqlSKgbNTpcHLqc47/rglK9xx20CYVlKikS8=; b=pZQAGIDGVwHJfm1U
	MPRN2QTFFZq/UoCWG9MIk42a8lV72+KURht33BDF/LLzZ8RbDEeCnHpX4mImRXw5
	7hiSMXWxX/ZkPLBH8jsisruy99Ohe8KaSz2EPlMvq0kS/clp0za10LhijLWRMbT7
	m2c+utU3ETt3e9v1otJKOBd5k+4PugjibRXwOW6HHHGBx+QszUay/gdkK7FukSgl
	anZLrFIlWejdBF3A3LG1wuoJVOR+8eGwYnumX69NNWASjv48oUqBX7HQnQohgniu
	hR2Eo1AVbhxYPLaK3x2vb7gRxffvUsNn7KdszpR+hlyzoOrN4zzeISkrhOhrD6E5
	z/FtkA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkfdm9t2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 17:48:12 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b07b06027eso1697357a91.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 09:48:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794592092; cv=none;
        d=google.com; s=arc-20260327;
        b=dHXDsaxN566lW4hStlOJeIEFFZOKR3BoxbzxckH7kB0WrZB4y+M/+FAvsTJ1BWJoFG
         GaTTamNOCb2jjHGlsZFBx1skSPU8+0hPkLOFfxBhnndOIXQG2jbpwjhZF/I8cN3EsXRu
         Nz28iX3SmAmqnm8kCu+H5U/c0tr0/Y+Cypk7GmT66K1H/bruSjhbbEcvgBmrCaYDeEqR
         IdsN8jtlak0azmGpXk6Fm9qAGOoJB1L+lPQE3QTRXSL0DeYlyyXK9PC3WhjC4YGuI4O5
         fqUNUBMouC9vypTfLA2QgRP7AwmJjAIIG7yyBx/ltozNsSbelNrJfDnR40G0s5G6IgHe
         LXGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tYWjPq7IqlSKgbNTpcHLqc47/rglK9xx20CYVlKikS8=;
        fh=LvQM+pMyBgJltn1r+lnarbOsflrWwUsrDDCPCMmuzrw=;
        b=gPC8xLX2Igva1I1g2YeXOA8TfBsoTf6E1UyF/2VYz3p3RTeGqDz5Qz81wzbfuHVDvV
         X5BWVazHMeDprzxm96UuacaAfEYujkNsmK0VZiJlOXEFos0tEQZ5fd3HpTLixwXqzdTc
         vucdCKL2Vp96nV3ujVEOBwp0rDKJDkB//89N/itl1p72hL1UK4fNEE98uJQZBub/Z6Sc
         b+08FjfiTQnE5CDdCazlGjW6XPrz+RkeUMgWNvohz0y3lEY+yvImEMMWNmQtarXcaNps
         cSaW2zmBBo151NSC2XRdWRyk8UgMPM1yFxfd9tPSxjq605yQ53kkJUSwYK38qhkxgKY/
         Xlqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794592092; x=1795196892; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tYWjPq7IqlSKgbNTpcHLqc47/rglK9xx20CYVlKikS8=;
        b=T3jJCMa24yL7aMNIwVFsMGJuKbULHk8gKwibx3bcn0aVJJdadDfGE2uTK9mJGz1Gd9
         4F3IrfOGU+xy11/t689E734Y57GM7Bm/VNF3yEiM2mhvckAKeiAlezIW1+CMo4Zel5V+
         LsY1tZxiXcKlkNT5dw4EHJiYDysx0R49fJuhGk1rW06x0f91SqSZ6klZsqXlo2n3OBhK
         lp+akPmQlXehlLdNeGZ5roVI2CALrVu+GpqvQ0P4bVig3ZQRmU9r5IzPkbXgmAnn/YSM
         Qe4mIEnSUZvxi5Bem39wdiOW9e1TXSrnCxqKhovVgwY4EoHhzLmbd+32rCfZ5gI12PL5
         5mAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794592092; x=1795196892;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tYWjPq7IqlSKgbNTpcHLqc47/rglK9xx20CYVlKikS8=;
        b=setc7IKPKzEaIs2MPilLbn5Z7YLBVXNeuZNQbi1L7UTFMBp4BXE6IZ6ndXlHs8iraS
         d0ardhxJaXxY4z90kCwcuOgaNCF0BK5zRNqiyQj3Ns6a3fWhU7TxBXGhpdrCvPvh0+FQ
         l7oBiJi69AtHiarMCioS8qIhj0/eiIcVUNpI4OoAyviDeiHShQFXhvAMB9EvJAQCNjLO
         +8IDCD2s55m55vquNXF67LzmxaHhIjwlchXlindAmXNBa1O7OjucEiR+26g6KeNAlHq/
         21SLtWHXOHRYWdDpRu1tyCXMDgDAw5gZTTMoJ6l3oGSbvPM06z4mVEtBqyuWMe1ylv7d
         O3oA==
X-Forwarded-Encrypted: i=1; AL+hErGFolwGN9YCivLO1kx4QfSNWC5Rxk6lXGKcth9rcYK3176z13s97R7kI6BSVeIekbrR1ra4N8bHvw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+gvrtYo1dcwiOCswh3+33WvNYofPxGgwh0bIn6q+WPfLxDC0cN
	2tTFdVckKDWl7ZWhpCIOCVMkxR58stBn6mLzkm2lZB2B79E+DHYX/TjWnvcnf6AVNVfrmArC6ZH
	pL9UNn9uMXM+ny2bnfWF/Lqnrfs9oNA3Ka+7vGc7qqxn/6uXrr4HZT+RLu357J+ArTAZBQRvGFu
	/MOorHFBNx1gx40FGu1lipjoG8nW+1SgTudPXE
X-Gm-Gg: AYBFou0oFrHSHOzXATSZV8kYWW8fRxOsQ9xv216UXovtnfry/r6Y2bIChOFxfGPsXTd
	gUuVmEsSyKXr7NOOBBtzqyoauTc+P3QCQUQ2hBX/yE+DDxiTpHzWFeZ+A1wk0KOo+eX+aS8XST0
	epiQGlnxB/ZF5K2NJFkG2N1FoppkjK6kvCWw/YSPPdWfGQJi1m9PpiZWcD5A==
X-Received: by 2002:a17:90b:48ce:b0:3ab:188b:c5b1 with SMTP id 98e67ed59e1d1-3b1b0a4e7f7mr3137270a91.56.1794592092373;
        Fri, 13 Nov 2026 09:48:12 -0800 (PST)
X-Received: by 2002:a17:90b:48ce:b0:3ab:188b:c5b1 with SMTP id
 98e67ed59e1d1-3b1b0a4e7f7mr3137245a91.56.1794592091922; Fri, 13 Nov 2026
 09:48:11 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260925041751.495818-1-coiaprant@gmail.com> <382B43FA-B225-41C5-80B6-944D9D2802CF@gmail.com>
 <CALj3r0jMLFbz+oa_z6kySDg-3aLaFWtFoKv9VB_qHhQZDpemfw@mail.gmail.com>
In-Reply-To: <CALj3r0jMLFbz+oa_z6kySDg-3aLaFWtFoKv9VB_qHhQZDpemfw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 18:48:00 +0100
X-Gm-Features: AclHuK8g7tQW9S4ZM83ovlzdx6LVKg4onvs4sx_JqFXCpOEKhsosFCl6JEvlGa4
Message-ID: <CAPx+jO-+uwxMN3-LZn4nH4HSXu6GCnvdrUb9ff79W5EeCU4SZA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: rockchip: mark PD_PIPE as active wakeup on RK3568
To: Coia Prant <coiaprant@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3MCBTYWx0ZWRfX/YbKPUmUt7Fn
 ShrfuQE6Dk7QJJbtA3VAiN2tQiBS/qWgct3NnjuWFBZmCSzqSc8e/TarFsRo1QLM3XOWryXMTvI
 faKguOiN0JMxHvFpqVsotvK2yUBiC+4=
X-Proofpoint-ORIG-GUID: AF64-u2LU2zPhOLck0Rz7vW8DU6tuJMC
X-Authority-Analysis: v=2.4 cv=DoTDa2/+ c=1 sm=1 tr=0 ts=6af74d5c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=qR-pa9LE6TqeafLzNesA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3MCBTYWx0ZWRfXxit4tEscOFN5
 oLd9LOYiL6Km5Q+prdx7SQyzKZDJH3tf6sEBiC1Prato8F/UiKrco9KDfFpiJ9DgB38hrZcQCIj
 PjOIIiFe0zuuZkxBD6elB4EPnOLv4+4MzmoNSUVpYXjFfStPsAlmw1ijPn7V4WyCjBpF/amMogj
 vcGmqv0vq0z2cm0IbmUFsY7JTapHKiiRnnjjXiPBwJB9/oSfLjMnmXPKK/YrYL9bjHd35dnkzDO
 srxmLug/Pws8+YempCadv0gp3X1USMv5gKEHosRzzyY8sUByh/1iQ0ZY3eAOInqgeGB/O4YLJyt
 PEYOcgAaW4cCz4yGMSr8++hYHTxenx4o54hQVEK+Gm7UWBJ4cSM1VWFEDy1fpOjSc1sSRj+Z4Bv
 oRs1Oq15yEzDPTpr5Z53GaZLzrf0ve0YLd6yQyOxK3sg+yNI4vOFFTCwiqHGBAzWb9/eA+X0dTX
 WCjdle50hA58kF+yfIA==
X-Proofpoint-GUID: AF64-u2LU2zPhOLck0Rz7vW8DU6tuJMC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130070

On Thu, Oct 22, 2026 at 5:04=E2=80=AFAM Coia Prant <coiaprant@gmail.com> wr=
ote:
>
> Coia Prant <coiaprant@gmail.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=886=E6=97=
=A5=E5=91=A8=E4=BA=8C 07:27=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On September 25, 2026 12:17:51 PM GMT+08:00, Coia Prant <coiaprant@gmai=
l.com> wrote:
> > >The PD_PIPE power domain on RK3568 hosts the XPCS, the PCIe
> > >controllers and the SATA controllers.  All of them can act as
> > >wakeup sources for the system:
> > >
> > >  - the XPCS for MAC WoL, through the SGMII link
> > >  - the PCIe controllers for PME#
> > >  - the SATA controllers for hotplug wake
> > >
> > >The domain is registered with active_wakeup =3D false, so genpd powers
> > >it down during system suspend even when a consumer is on the wakeup
> > >path.  That kills the XPCS and the SerDes, which breaks MAC WoL on
> > >RK3568 SGMII boards, and it also powers down the PCIe and SATA
> > >controllers while their drivers still expect the link to be alive.
> > >
> > >Mark PD_PIPE as active_wakeup so that genpd honours the wakeup path
> > >of its consumers.  Consumers that call device_set_wakeup_path() keep
> > >the domain powered; consumers that do not mark themselves as wakeup
> > >sources are unaffected and the domain is still powered down when
> > >nothing needs it.
> > >
> > >Several other Rockchip SoCs already mark their PCIe and USB power
> > >domains as active wakeup, for example RK3588's pcie and usb domains
> > >and RK3576's usb domain.  PD_PIPE hosts the same kind of
> > >wakeup-capable controllers on RK3568, so this follows the same
> > >pattern.
> > >
> > >Signed-off-by: Coia Prant <coiaprant@gmail.com>
>
> Hi Ulf,
>
> Gentle ping on this patch. It was sent on Sep 25 and Patchwork shows it
> as "Handled Elsewhere", but I can't find it merged in linux-pm,
> linux-rockchip, linux-next or mainline, and I haven't received any
> review feedback.
>
> Since then, the XPCS driver and DTS that depend on PD_PIPE staying
> powered across suspend have been merged and sent upstream:
>
> - XPCS driver in net-next: https://git.kernel.org/netdev/net-next/c/5e91e=
dfb0e45
>
> Could you let me know which tree this should go through, or whether it
> was already picked somewhere? If it needs to be routed differently, I'm
> happy to resend it.
>
> Thanks,
> Coia

Apologize for the huge delay. I was waiting for an ack from some of
the rockchip maintainers.

Anyway, this looks fine to me so, applied for next, thanks!

Kind regards
Uffe
