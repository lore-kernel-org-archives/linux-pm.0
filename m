Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794592066;
	b=SXdRui8m1/ezyg3+P59sA1FHnb3GlKdR3ovp1MNseCDoYa4H+CRi+/RFug87IRlkDXvl
	 SCrJUdaxKzlVnrZbn+gfB5h3WJ5qDKqB+dZW7fNZG/pC2mWK8rJD505u7DL/iF6HePTR/
	 DZ9OzBLCFtKdfGXUKXbf+OWFe+eMscK8XCIC9AwXBwi7CJ+CFwskuGHEEBJ3EeV7J+9A9
	 Z0B81TuIGK3wqDbI14E0Rx+oWCajK0XdobulDlFDXoy+BE/rOo/SkwkPu+Hvc33oYID+J
	 9NTjyn8Gk926wdHneFxeUW00XhlKNleNxxd5t/Ed2Z0GVoUBI5VqeTqhha56y75FDdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592066;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Fe7oP9kUiaU4IMzTAKOazExG143SLUu/fzcBtQwA6ZE=;
	b=Yx1F2QCYgxbdfQu/hF7OvuYfzbnP2RUZFk+/73speVVuTP3rUVPdumpTkSLXL0/ylk5v
	 WKl7dOfk+WyFTxvAfUSvUbl4JIGPgfPcOVcHZhAGaZIsyoLPmc//v/ZagcGkzy5hD6EtU
	 /0KaDybVkHxGlv7lZvoz74mu1348zeUlFaeOO2t8hmgXSo3F/ImGdl97xxmHVQvbCmJtY
	 rfEIR9KBHDh+VqcWj6ktY77lmxGX86EbANEjjqjvXVasVTlqjJv+4KucalBVxeojFrMD1
	 Z/1LCqV9X109FZ50W7hGa6dRrUF5396IYEYV8Ci6Exf8cvlvOl0xa5zHee52zhL+BJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RcznuWyK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gkCkP7n5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BFE606C08A
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 17:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32BFE606C08A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RcznuWyK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gkCkP7n5
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFj6I3780569
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 17:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fe7oP9kUiaU4IMzTAKOazExG143SLUu/fzcBtQwA6ZE=; b=RcznuWyKp1IBp9Mf
	p6xVOeD3Y/BJqD1rDuzzbT3i/578VJmkuaXrNGeAW7aRQwD9RaoBB6eCuAoF84BZ
	9NhLPsT/8N78CBXiGQnn4bY5ohFkrk0VvKX05XSEGtKCNpEYi9Kc41pkBeTJ2yuB
	2y4Nbma6Y/pr40wypVnROv/iBBYhSdqdyZpGJvGrgyeAZF2gbZ2JJhhFeHiELT8d
	dpk3RfYzniz4y8bWkk7RWTNdnbKu/2yUJHZSMxleFXp4uYv0KvBoYoDk0tnaZplY
	GbXuf6uYLmXthYtNQFM1BlD9+jbtkNNp3XEnpc+mZp2ap3/Ki6FWCSbmR1vWdcPq
	ixjK1A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwv37jmp1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 17:47:45 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd5ca3840c5so1539059a12.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 09:47:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794592064; cv=none;
        d=google.com; s=arc-20260327;
        b=g7qwyZRcZQZdohxMR+0ftbeVP/PP9Z5oonaqaSaEGQgH7E2NzHD44hi1juKb1ewjmN
         DhPTJFJqPCtB3MAMO0QrzLa8EI0uNMdOn/ZTnPyA4ktSJUyDQa6dVIzshLzw9Ewu+kbi
         vMCPxUH0Tcuc7aa2yJY8eurUCxw8fpYpdeIjfMQlQv77LM/vHCvJ58s1xuEcqkm7wOw0
         wi3y5Kcocf7bv3orBvGw+RDy/1aY4/bBr8Vv3TMpEExwC1gGnR3oa2nqjwqFnBtdyAa0
         ucx0vbpPK6UsMbqAHNEyzeyA5pffayCtbgZ+buCxiWbDOn9rhw0NrMWJ94AiE66Fmf9h
         TVRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fe7oP9kUiaU4IMzTAKOazExG143SLUu/fzcBtQwA6ZE=;
        fh=IBhmjA0wdKLH8NOIk8jNDDXaGyzECV1afyHhjC9GTDs=;
        b=PzpVEWTaW7KDOetAeny7H6GU/yjlyE55LpJ1zWSCztyWEw3BTUQFj7gNEjPIjotUV3
         7IqSqQRPuVlukmp6WCar6QSt9uK5vxUxiVtpQiCsy82IkZUMdJF6cJcDNyg8bLTbp0PV
         IkmsQOJdNRoNPL+kx/+GoulceuRT2F7rsRZ4Tr3SQHcQA7FPt3DplgC/f1RJIAN45iKk
         UTYFh4b7HACOAOVa/sT7bFI6FiYp5NwPLaz3+NNY/bEoyra92Qecvgo32SdsijmWzWub
         gZpRHLuEbb8ffP6rnOedWhKKye+7MSM29cokm3FU9ws6AeRmhR0FGte79jtGPFwj843m
         boEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794592064; x=1795196864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fe7oP9kUiaU4IMzTAKOazExG143SLUu/fzcBtQwA6ZE=;
        b=gkCkP7n5GIh2mJEaxkN9fdhigjWm/V5OVuf1uUpxzLni4FUhI7Wuec3HFvtJbDczDx
         qk5i2T7KUSHJRUIpHMf3+VFigtc0ylrU3kn75dWB59OdfIC7CC7xovXYtrf2qg/RZw9b
         OyS8SMEC8TPlwnEu9udtKUjzZ/zwL/5yKsh2/zW4hy9WRwuP2jHWYLxDOk0NTlz5PISW
         z/cvcoBTUzLuarKTB+kkl2slb/m/wde5BrgnlaX41CFKV2TWB/tsJfy9dd3P0p08ApQ7
         W3ThgPpw+Xyq2uKodynu4bUoJ0zd0DhSz7CLLUvS+xeAFaLctwR8vYiLaEcOtFamVsr9
         06pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794592064; x=1795196864;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fe7oP9kUiaU4IMzTAKOazExG143SLUu/fzcBtQwA6ZE=;
        b=VJqbD7sn/jHnoFnUI2AqL2xvF5e/TFXJyNtifVdnFTiMyRo9VDgWD+wbkSljgMQ9uX
         mqeGH/n3j02gBTeiF3F0/BiJqkgyeoSJ4AHgki9ra8Cjk+d6HBpy0cPko1AUs+rv7uNQ
         aObecb9aVCTBxdkfZ6wAQ7rrT6OTHPgNn6D1txwE++NlETKWwoA3aA+fev1OAWzI68fU
         vYTqVbCbl7N/0VRBO2xSH6UbiVn+hWge1dEofqr7wa1jXHnXBCYbk88kcE2m88vSJg5E
         l2O9geTs3VpQCeLmb1k/vIP/Bcf94YzWUDd9o1pBxGLCzfbyddRvWRU1kHeLZuHFWvEy
         GvAA==
X-Forwarded-Encrypted: i=1; AL+hErH/Lk+90VBdxQkJyUM0fLd/5UzBP+ovDcVsTkGtKSA7WhomCm3TUhyues/v7kwUg25EkGipjG6Skw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/bWM3Jn6QbpgQS/oqkd7pM5ZoXUVszDIDpXytrBQCyS5nipSR3
	kUNVfuRqvlpm2Aqqdqly+UUjdyf1oGuAJXogoFofAodPQoWblg+n6kE+ZAzJXD+81SAtuuVsBqW
	/MJuSq30bKxJy4ZvN15uO3JSN1W49V2dguX0a+zJ1PnnxChpqj0XwTpAMN/ahGqPqekfiI47SOE
	XE4anHBOiZkvudbbhdsoraaBEtydPolC0ygRp+
X-Gm-Gg: AYBFou0A0z9ZMHcsoSqsXaG3xPXnORzMw30Cqp3OMzK8cWLWAR6YZ0e/SyY2DqdRX0D
	Mlb9tF+VJCXAjepSH7jwHSSIey+ewlDlgo0dT1NhdfMhX33ASYSiFZ0a1d+9EaAfFMj9u1P/qxX
	wNL5hiMfCiAoDHVa/ZGe9T1QUlIoUz4CgbmBtwolU9zYnLp5hf0HtFxq10rg==
X-Received: by 2002:a05:6a20:d48e:b0:3d3:aec2:4dcd with SMTP id adf61e73a8af0-3f7a68a5208mr3120362637.25.1794592064092;
        Fri, 13 Nov 2026 09:47:44 -0800 (PST)
X-Received: by 2002:a05:6a20:d48e:b0:3d3:aec2:4dcd with SMTP id
 adf61e73a8af0-3f7a68a5208mr3120329637.25.1794592063543; Fri, 13 Nov 2026
 09:47:43 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019092417.391522-1-leonard@lausen.nl> <20261019092417.391522-2-leonard@lausen.nl>
 <CAPx+jO-9BqNgA1Nx2TiHX=BS6cJMmETepYsiujBCeeb3wPt1bQ@mail.gmail.com> <avYBtK0fyG_0--nN@venus>
In-Reply-To: <avYBtK0fyG_0--nN@venus>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 18:47:32 +0100
X-Gm-Features: AclHuK_J5EuV9dnZIsWrbl-naj0R0vX4a-pEYbeUab3qTKG86s3ZcxdOv5w6zDQ
Message-ID: <CAPx+jO82TGVDRqoz+TN86LVfraVVeNhHBFktTDNvVzM7S8zbng@mail.gmail.com>
Subject: Re: [PATCH 1/2] pmdomain: rockchip: Manage the RK3576 GPU domain supply
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
        Leonard Lausen <leonard@lausen.nl>
Cc: ulfh@kernel.org, heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, detlev.casanova@collabora.com,
        finley.xiao@rock-chips.com, zhangqing@rock-chips.com,
        inindev@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gahing@gahingwoo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3MCBTYWx0ZWRfXyqm04X1xw1ho
 cAvSEytYf4ZYMScT2wPLLZWe6y6CoFAGCWdEeoEJu1tk/xZom5O1vrirUz8Ffgaj0EcMu5tzQM6
 LJgn8h4fRPDhgJ91I7gv+uvokwHBjyE=
X-Proofpoint-ORIG-GUID: NwpVdpwbUrSEqMcb0NVF9tqnG2qTD5fh
X-Proofpoint-GUID: NwpVdpwbUrSEqMcb0NVF9tqnG2qTD5fh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3MCBTYWx0ZWRfXynbkEXStnAk/
 FM2CWt4l9pytYA/NjFnk/c5YXZA4oI41YteUfgwzKloY3slGwtdTYZdkH5SXtcA/fKPWrxXv5j+
 hLH5/u5KB6cf6aNFJxgclfoOnbVgNQJ1WM474GAaoHmBDhyM6FkHB4crSwT4eO070tCUL/KmENG
 dhylzBLwjLKnSv2kd+ffQ8AwZLuv0Fxwif0FAlK65Q2MbTrSKDAqVLH0AuEQug/pDKCxo7czVqt
 88ciWvGs7WmRr4qSU3Jmy/vV5y3b3xkynKgkEp+pMXfRui26bsEjt+KPZx7YBZN53Y5HQOCeJ3v
 r3dYplmjFDe0xAjXfv5cBZjuj6beCoONeL4VmFHaNGX4osk6MqKjVs9L4+rMx17RSQd6xvQOpAb
 lWmOzrEoEXiz77CgsxS22pNLWcJIAoceMvNjjZUoLPmk0e6cVK9GU3MHONc8VoKApu2l+sYbD/A
 bejPaGggLeUlLoZwsxQ==
X-Authority-Analysis: v=2.4 cv=ZeeIpcVA c=1 sm=1 tr=0 ts=6af74d41 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=9GNsruGHAAAA:8 a=QX4gbG5DAAAA:8
 a=TNRU4YkNAAAA:8 a=mTdHOEkXxLqTN0UqMq0A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=gf-oSkQAjqHFJRp-GQfY:22 a=AbAUZ8qAyYyZVLSsDulk:22
 a=T6RL-YpNOstmnv1gjOTq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130070

On Thu, Nov 12, 2026 at 7:16=E2=80=AFPM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Thu, Nov 12, 2026 at 04:19:58PM +0100, Ulf Hansson wrote:
> > On Mon, Oct 19, 2026 at 11:24=E2=80=AFAM Leonard Lausen <leonard@lausen=
.nl> wrote:
> > >
> > > On the NanoPi M5, boot hangs during Panfrost initialization. Before t=
his
> > > fix, booting required blacklisting Panfrost on the kernel command lin=
e.
> > > Loading Panfrost after boot reports a GPU power-domain acknowledgment
> > > timeout:
> > >
> > >   failed to get ack on domain 'gpu', val=3D0x113ff
> > >
> > > Add regulator support to the RK3576 domain descriptors and mark the G=
PU
> > > domain as regulator-dependent. This lets the existing Rockchip
> > > power-domain regulator handling manage the GPU domain supply.
> > >
> > > A corresponding domain-supply property is needed in the board DT.
> > >
> > > The regulator-capable descriptors are based on the regulator support =
in
> > > Jiaxing Hu's pending RK3576 NPU enablement series, without its NPU se=
ttle
> > > delay changes.
> > >
> > > Link: https://lore.kernel.org/all/20260924102135.92217-10-gahing@gahi=
ngwoo.com/
> > > Fixes: cfee1b507758 ("pmdomain: rockchip: Add support for RK3576 SoC"=
)
> > > Signed-off-by: Leonard Lausen <leonard@lausen.nl>
> >
> > So this should be applied as a fix and tagged for stable kernels, right=
?
>
> Maybe like this, considering it requires regulator support, which
> landed in db6df2e3fc16 ("pmdomain: rockchip: add regulator
> support"):
>
> Cc: stable@vger.kernel.org # v6.15+

Alright!

Applied for fixes and by adding the above stable tag, thanks!

[...]

Kind regards
Uffe
