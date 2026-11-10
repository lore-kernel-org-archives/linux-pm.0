Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794308097;
	b=m0Fk8sbE5WC0xCZkatS+UHx0oEiU+NL/Qt9zpRWvm6BqJHzTaxJKV/FYeGNH6kQhclWt
	 0W24F2+Cgxw9Yp0cQ7dBnN5piASvxxVHQ6t/Zr2Id5hEz+0AJ6JxHWqhU1my+WY6mHVrT
	 YLynWJTL7apyJFSFzd3VCeSNolROZJpupghbpuZoGoDJ6jh5eQtKCs8oJaGkSUIbfsXcq
	 zcQfv+MRQnCRiKjcSPKdvlY0o1XCZdbr6hIeMu2aqmWtYrl3OSP9UrLQyZ8sR900UTvdq
	 BdYFWi8DbCvHYKVwhzeG/fDc8WZ6w/0i8K5pbj3OGi0SF9b7luD5W6lDDw8oij6ZwxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308097;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/GvGp0ikRhYCrmCcfVEdjux6pBM8MsB+KXbne/7lAoM=;
	b=Zt7A1+t6+XWuPHc1tQwzsYngCXOSkqh6MkR5wnORv9mnGja96zm9wURKssYuTIlpz3Ii
	 Lzu9sxEeYandIkbRl/ELf0BMbs5n3o7VQfNAPLhvK2lmr/d5xNdIaDMarUfn4QzWvjVap
	 gz1+Q7u6T7ow4IaKb+ZDo3Q9iYcpF+AwPsvvwoa0PlJ2vZTcfeDJT2XEz9kcOSg+wc7LL
	 /L3BkYdbtQdx/NJvBeVKgrxnsJRbCKWuW40YnSpkPFIgVQ2t8zX91p6AVY/QoSoROrMnv
	 k7YbVYt2hfvs+ckPRpY5QVRRjjOJjy0aPV5pn1qs3bVBy+M/pYBTOuD+SH5sKIq4DmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mUkDTENG;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Nd6dJblK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40492606A321
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 10:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40492606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mUkDTENG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Nd6dJblK
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7l4ts1155019
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 10:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/GvGp0ikRhYCrmCcfVEdjux6pBM8MsB+KXbne/7lAoM=; b=mUkDTENGYogoUsvm
	c5dhKSLCd9QM91OJxfv7P/41BMyzplzxuqEIQ4Jwfu5jYTWHF7U1Al+4NPkDOMmz
	iga3w6m/DQz9x05Hu9jEWUPSVj0DQ+pww6XjtaK4BOzQJUUQzeMDbkvSWP1xCfQb
	0cmmsd+uwojsqcaxuywdQYFC3RKSaQSJySWIjUGOp0+hQz/+wGFAqiNu1IAv2scU
	DT56nbSTh7LM7nsybPDfJ7QOz1+gsMP0gKCTjtD8FAsMH8DKtMf/47ypSaKhclJ6
	Ld69AdFzgun8lHVDOU8Z/NTQ4NFao5unLvq/FfX3ryDlH1sx3lKBGP4vLqhuDSO1
	JmnEcA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hutv49rng-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 10:54:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b0e00d7cc2so1782157a91.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 02:54:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794308096; cv=none;
        d=google.com; s=arc-20260327;
        b=qIzKajoUG9XbOl4aEkdklzBfUp3znNE08ZHePb3PDLSY9WokLWm0GE/1eHLYwJRyp6
         jUf6Tl3enFimgD65IU1QyZ9klZmuVggvAa3WsqUmQQEeDIkj5v7CxMR/ZFyhAwRTL5Uc
         y9TGMh78JXL9dpYElfs2n1WiUEiHDDJFdE28oroDIoWEx3IztCHLbOPobPAuosOLyGes
         WCxVM2qZlkjTyaHkBexQFDDvTUQ30s4ZXzUH+D+d9wawamrdqIgum3h/78Y2FpMs7CNc
         aYwj05FWLpg2p/S05lPL1pbh/Cs6/irkCQP4yl2qEfl2l0j2d5LIh41I/0KeKw1ce2iw
         6IoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/GvGp0ikRhYCrmCcfVEdjux6pBM8MsB+KXbne/7lAoM=;
        fh=TYl0DuFkyigE7JgDeCtZ64J/yGKa8lr/30fXYnXMdtQ=;
        b=AWsX9BOF1gz5uqwGeCk6XFBszsFNjC9temOzewnSG2DIs/Jjhm0YCRGlxoOZIYIsBO
         BDpyiDom8yDvcNhsI6SzfoXpae4g9I/BM4nRLuSXVz/6j7677US+CNOLX41yu1OU9CTa
         ZFAAHGozUBcaBMbIfVUkfp4NzRiY7XLm68DVm5ibXG8AfEkcqBDVLq/YGwqPICeBRLAt
         KmQdwpEUoJo8v6DLiLUULvWjLzeExksyhQCH6P94C538HYVXBqr+S8QeJV0ObHW37Czm
         k8pglqTm6j/UH0djzCHXukz0/eN+RK0YnSQ/JFmtI0J5/wHLT1ZMt/CHz6Kea0rASNjl
         hVVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794308096; x=1794912896; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/GvGp0ikRhYCrmCcfVEdjux6pBM8MsB+KXbne/7lAoM=;
        b=Nd6dJblK2RB6hH66SV2Yn7HFbHm3pb1QuCWCxo3+ez9AfAkCw3XtElPemwNcgSeVOy
         KYQZSjC6OlFn4s7Mvd65C13oCaWDYIAPwOkonXxQAtPz+wX9SVpUjonUL31pynfXfc3o
         EvJs0zZ9Vy+9LCrrKzbCmR1sXrLTjLZ0KhjA++NoWjoZufFAkBf6ZzY4v002Ko3ro+kN
         +hvMl2m8D7ww8u6g2UAplUBJOqtbApX26DXuA9mw2OixKPkl85dUGALYUnAPobwpraDA
         J9Up9pLiyjoxEXe5yPn1f82FMpCd7CHdtIIIS+qx/MQHb+g4JS9P5BYoIC7WSvOHIW3s
         wcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794308096; x=1794912896;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/GvGp0ikRhYCrmCcfVEdjux6pBM8MsB+KXbne/7lAoM=;
        b=ep3/WLqtOI+LhXcISS56Ij/ht6wAx7md6Qs/7j+9bgTv7c1PDdlDiQJiNhkk5NpYkC
         AuBD0JZuo1rve5dDKuCYlEZ+xbBozziNTuwZuep8/sETxN0W9EfWg2gKoF+NdmPF/kB2
         OQW0QZevTbxllQgB0b8/DPV3Q7MVHhjwjwfOctNnuBRmmrHBkZLAuDQjSVt7PMONpEGW
         UPA5Y3fs8RBDGIaLyjwPR+3ROVerWhTlmRe4pqYXIkfJaxMWo52GGb2L25UkveQuacw5
         N4I/cKPD06S4QoL7ddxVoft5Gs2m5r3LKRq95WFsyyeinCVWtb+JsjqPeZGNCumc/e4Z
         0kJA==
X-Forwarded-Encrypted: i=1; AL+hErF8++M/ACd/lQXjcacGDSevx71+dt10rFQa2NOXJQ2h5xpUgPWFOt4ImWNZUmhgdpXmV2EBgPyITA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9LVnn3AythqfpiTBIkIbpIbR03z8gXZE5SDezYCvJbHA6W8hhf
	gGeQNtfMjXAxUh+UBJNn7TkEcKiUSB8nr3skVfKUZNUhppcLaLMiTu6b0bBAlCGw0vuJGrDFerf
	eJVScNi7hfatQ6u2YortRfPg4EdZHmumrdEOOTJF/xlXKm6PbNMpMeBm43rnJrM87olJ5d18rLI
	nAeLi/owOmpgVMWKOAR/M8jnRXqaXxlB33Cz4H
X-Gm-Gg: AYBFou3FEva6r5gQX9A/riZBJ+o6XkDbUhE+U+SFRIRUYkEy8dqN3oh/1pK+64PZwWQ
	4QFeYHnxzDweQZEIhS1p9trffhBnXZxexKCXo+YOGQVidRn6ratX2JIQkJLmEAKmM3sPE+vPSIE
	s/m5PwZYWNH+StJYdUsqhuemQQ9/d9CozlQYOSxy1hJJhWeH9NK53jKmRFxA==
X-Received: by 2002:a17:90a:e7d0:b0:3a8:5fd6:cb6 with SMTP id 98e67ed59e1d1-3b166a5fb0bmr2419106a91.0.1794308095850;
        Tue, 10 Nov 2026 02:54:55 -0800 (PST)
X-Received: by 2002:a17:90a:e7d0:b0:3a8:5fd6:cb6 with SMTP id
 98e67ed59e1d1-3b166a5fb0bmr2419092a91.0.1794308095395; Tue, 10 Nov 2026
 02:54:55 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101082307.151957-1-gahing@gahingwoo.com> <6777074.j6PcuT4dK6@diego>
In-Reply-To: <6777074.j6PcuT4dK6@diego>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 11:54:43 +0100
X-Gm-Features: AclHuK_tfQs_KED6YGEFdDQzYeq154VOUvxzh1aCGwTqlSdSoloobK9cAe7e-pc
Message-ID: <CAPx+jO_gRtipR7iuh0D7G2Wi25GZoqFD1JHVbJNmhd1UyC3Bmg@mail.gmail.com>
Subject: Re: [PATCH v15 00/15] accel/rocket: RK3576 NPU (RKNN) enablement
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
        ogabbay@kernel.org, zhangqing@rock-chips.com, royalnet026@gmail.com,
        abel.vesa@oss.qualcomm.com, sebastian.reichel@collabora.com,
        sidong.yang@furiosa.ai, u.kleine-koenig@baylibre.com,
        chaoyi.chen@rock-chips.com, diederik@cknow-tech.com,
        alchark@flipper.net, leonard@lausen.nl, jeff.hugo@oss.qualcomm.com,
        rfoss@kernel.org, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0MyBTYWx0ZWRfX3ZPaHVF+RRZd
 B8XIbi8JaIqRg6YGLcRPF4rwUw3ikl4FjFUVpDFcLRm27E7TfryoJWP5/+7U2rIPkxMhsF/M18T
 Gb8rUi9lfR3gaK9LEBf8QCTXBi09Pkc=
X-Proofpoint-ORIG-GUID: OJBjlokUMB7uxmH6hxkXwUPB-ThW8L_J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0MyBTYWx0ZWRfX/BpZAL0ppVD5
 MjacG/v4aOKZ0yVTbK9nnPetzsMMcothnZkO/Maw2VXkQ17FtcnuOOZtZVhV2qgE16+AmTuGwc1
 bqGo0DgJUmIz20bKyZltmvZg0uBZarn5EDbjpg/FU5MvN9/oZeeQbdZXiWZn7M+vaBNUgbHCH/m
 WQeMUdbJTAAakDFGDvVWgNhR8dI7bDM8fOzn0BW+5Zh7z3bHP7mIjEVoCnFK12DLwND6ZoQmGa9
 koHW4Nwdy23sY+PZDUpJPCzSZswgWl9dErhK9FsHcTA7/qWi/6GKxO0DGw4hxMeMZgbKRzc+HB/
 sKVSQlZeVay9gMH6znJbb6fShWvA7Jr5zRyYl+hAACdx6ft57J206PQyzk2reTurZVTqPxb1Ffi
 Lk591uS3k++JXkY/jwDJJPRJr7DgKl7NN6YNlhImfzywDdpAe0HC1GdJp/AgXDMMwruAD6a5lSl
 zSRnsd4T18DtATHYhyA==
X-Authority-Analysis: v=2.4 cv=B54sQ+tM c=1 sm=1 tr=0 ts=6af2f800 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=HKy5YsogUvdA2KhsgGYA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: OJBjlokUMB7uxmH6hxkXwUPB-ThW8L_J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100043

On Tue, Nov 3, 2026 at 11:39=E2=80=AFPM Heiko St=C3=BCbner <heiko@sntech.de=
> wrote:
>
> Hi Ulf,
>
> Am Sonntag, 1. November 2026, 09:22:52 Mitteleurop=C3=A4ische Normalzeit =
schrieb Jiaxing Hu:
> > Ulf offered to take 7, 9 and 10.
>
> I've now looked at the patches in question and they do look good to go.
> So it would be nice, if you could pick those up, when you have a minute :=
-)
>
> Thanks a lot
> Heiko
>
>

Patch 7, 9 and 10 applied for next, thanks!

Kind regards
Uffe
